import { useState, useEffect, useRef } from 'react';
import { createClient, SupabaseClient } from '@supabase/supabase-js';

declare global {
  interface Window {
    Telegram?: {
      WebApp: {
        ready: () => void;
        close: () => void;
        expand: () => void;
        MainButton: {
          text: string;
          show: () => void;
          hide: () => void;
          onClick: (callback: () => void) => void;
          offClick: (callback: () => void) => void;
          showProgress: (leaveActive?: boolean) => void;
          hideProgress: () => void;
          enable: () => void;
          disable: () => void;
          isVisible: boolean;
          isActive: boolean;
        };
        BackButton: {
          show: () => void;
          hide: () => void;
          onClick: (callback: () => void) => void;
          offClick: (callback: () => void) => void;
        };
        initDataUnsafe: {
          user?: {
            id: number;
            first_name: string;
            last_name?: string;
            username?: string;
          };
          start_param?: string;
        };
        themeParams: {
          bg_color?: string;
          text_color?: string;
          hint_color?: string;
          button_color?: string;
          button_text_color?: string;
          secondary_bg_color?: string;
        };
        colorScheme: 'light' | 'dark';
        showAlert: (message: string) => void;
        showConfirm: (message: string, callback: (confirmed: boolean) => void) => void;
        HapticFeedback: {
          impactOccurred: (style: 'light' | 'medium' | 'heavy' | 'rigid' | 'soft') => void;
          notificationOccurred: (type: 'error' | 'success' | 'warning') => void;
          selectionChanged: () => void;
        };
      };
    };
  }
}

interface OrderFormData {
  startDate: string;
  endDate: string;
  daysCount: number;
  kitCount: number;
  spareReceiverCount: number;
  transmitterCount: number;
  microphoneCount: number;
  comment: string;
}

interface ClientData {
  id: string;
  name: string;
  phone: string;
}

type Screen = 'loading' | 'not_connected' | 'form' | 'submitting' | 'success' | 'error';

const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL || '';
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY || '';
const PRICE_PER_KIT = 500;

function App() {
  const [screen, setScreen] = useState<Screen>('loading');
  const [client, setClient] = useState<ClientData | null>(null);
  const [supabase, setSupabase] = useState<SupabaseClient | null>(null);
  const [errorMessage, setErrorMessage] = useState('');
  const [orderNumber, setOrderNumber] = useState<number | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const submitHandlerRef = useRef<() => void>(() => {});
  
  const [formData, setFormData] = useState<OrderFormData>({
    startDate: getTomorrowDate(),
    endDate: getDayAfterTomorrow(),
    daysCount: 1,
    kitCount: 1,
    spareReceiverCount: 0,
    transmitterCount: 0,
    microphoneCount: 0,
    comment: '',
  });

  // Update ref whenever handleSubmit changes
  useEffect(() => {
    submitHandlerRef.current = handleSubmit;
  });

  // Setup MainButton click handler with proper cleanup
  useEffect(() => {
    const tg = window.Telegram?.WebApp;
    if (!tg) return;

    const clickHandler = () => {
      submitHandlerRef.current();
    };

    tg.MainButton.onClick(clickHandler);

    return () => {
      tg.MainButton.offClick(clickHandler);
    };
  }, []);

  useEffect(() => {
    initApp();
  }, []);

  useEffect(() => {
    const start = new Date(formData.startDate);
    const end = new Date(formData.endDate);
    const diffTime = end.getTime() - start.getTime();
    const diffDays = Math.max(1, Math.ceil(diffTime / (1000 * 60 * 60 * 24)));
    
    if (diffDays !== formData.daysCount) {
      setFormData(prev => ({ ...prev, daysCount: diffDays }));
    }
  }, [formData.startDate, formData.endDate]);

  async function initApp() {
    const tg = window.Telegram?.WebApp;
    if (tg) {
      tg.ready();
      tg.expand();
    }

    if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
      setErrorMessage('Supabase not configured');
      setScreen('error');
      return;
    }

    const sb = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
    setSupabase(sb);

    const userId = tg?.initDataUnsafe?.user?.id;
    if (!userId) {
      setScreen('not_connected');
      return;
    }

    try {
      const { data: clientData, error } = await sb
        .from('rental_clients')
        .select('id, name, phone')
        .eq('telegram_chat_id', userId.toString())
        .maybeSingle();

      if (error) throw error;

      if (!clientData) {
        setScreen('not_connected');
        return;
      }

      setClient(clientData);
      setScreen('form');
    } catch (err: any) {
      console.error('Init error:', err);
      setErrorMessage(err.message || 'Failed to load data');
      setScreen('error');
    }
  }

  function validateForm(): string | null {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    const startDate = new Date(formData.startDate);
    const endDate = new Date(formData.endDate);
    
    if (startDate < today) {
      return 'Дата начала не может быть в прошлом';
    }
    
    if (endDate < startDate) {
      return 'Дата окончания не может быть раньше даты начала';
    }
    
    if (formData.kitCount < 1) {
      return 'Укажите хотя бы один комплект';
    }
    
    if (formData.daysCount < 1) {
      return 'Минимальный срок аренды - 1 день';
    }
    
    return null;
  }

  async function handleSubmit() {
    if (!supabase || !client) return;
    if (isSubmitting) return; // Prevent double-submit

    const validationError = validateForm();
    if (validationError) {
      window.Telegram?.WebApp.showAlert(validationError);
      return;
    }

    const tg = window.Telegram?.WebApp;
    
    setIsSubmitting(true);
    setScreen('submitting');
    tg?.MainButton.showProgress();
    tg?.MainButton.disable();

    try {
      const totalPrice = calculateTotalPrice();

      const { data: lastOrder } = await supabase
        .from('rental_orders')
        .select('order_number')
        .order('order_number', { ascending: false })
        .limit(1)
        .single();

      const newOrderNumber = (lastOrder?.order_number || 0) + 1;

      const { data: insertedOrder, error } = await supabase
        .from('rental_orders')
        .insert({
          order_number: newOrderNumber,
          client_id: client.id,
          status: 'new',
          start_date: formData.startDate,
          end_date: formData.endDate,
          days_count: formData.daysCount,
          kit_count: formData.kitCount,
          spare_receiver_count: formData.spareReceiverCount,
          transmitter_count: formData.transmitterCount,
          microphone_count: formData.microphoneCount,
          price_per_unit: PRICE_PER_KIT,
          total_price: totalPrice,
          prepayment: 0,
          receiver_notes: formData.comment || null,
          is_charged: false,
        })
        .select('id')
        .single();

      if (error) throw error;

      // Note: Manager notifications are handled server-side via database trigger
      // The rental_orders insert triggers notification to admin managers with telegram_chat_id
      // See: Supabase Database Webhooks or pg_notify for real-time alerts

      setOrderNumber(newOrderNumber);
      tg?.HapticFeedback.notificationOccurred('success');
      setScreen('success');
    } catch (err: any) {
      console.error('Submit error:', err);
      tg?.HapticFeedback.notificationOccurred('error');
      setErrorMessage(err.message || 'Failed to create order');
      setScreen('error');
    } finally {
      tg?.MainButton.hideProgress();
      tg?.MainButton.enable();
      setIsSubmitting(false);
    }
  }


  function calculateTotalPrice(): number {
    return formData.kitCount * PRICE_PER_KIT * formData.daysCount;
  }

  function updateFormField<K extends keyof OrderFormData>(field: K, value: OrderFormData[K]) {
    setFormData(prev => ({ ...prev, [field]: value }));
  }

  function incrementCount(field: 'kitCount' | 'spareReceiverCount' | 'transmitterCount' | 'microphoneCount') {
    window.Telegram?.WebApp.HapticFeedback.selectionChanged();
    setFormData(prev => ({ ...prev, [field]: prev[field] + 1 }));
  }

  function decrementCount(field: 'kitCount' | 'spareReceiverCount' | 'transmitterCount' | 'microphoneCount') {
    const min = field === 'kitCount' ? 1 : 0;
    setFormData(prev => ({ ...prev, [field]: Math.max(min, prev[field] - 1) }));
    window.Telegram?.WebApp.HapticFeedback.selectionChanged();
  }

  function handleClose() {
    window.Telegram?.WebApp.close();
  }

  if (screen === 'loading') {
    return (
      <div className="container">
        <div className="loading">
          <div className="spinner" />
          <p>Загрузка...</p>
        </div>
      </div>
    );
  }

  if (screen === 'not_connected') {
    return (
      <div className="container">
        <div className="success-screen">
          <div className="success-icon" style={{ backgroundColor: 'var(--warning)' }}>
            !
          </div>
          <h2>Не подключено</h2>
          <p style={{ color: 'var(--text-secondary)' }}>
            Для создания заказов подключитесь через ссылку-приглашение от менеджера
          </p>
        </div>
      </div>
    );
  }

  if (screen === 'success') {
    return (
      <div className="container">
        <div className="success-screen">
          <div className="success-icon">✓</div>
          <h2>Заказ создан!</h2>
          <p style={{ color: 'var(--text-secondary)' }}>
            Номер заказа: #{orderNumber}
          </p>
          <p style={{ color: 'var(--text-secondary)', marginTop: 8 }}>
            Менеджер свяжется с вами для подтверждения
          </p>
          <button className="btn btn-primary" onClick={handleClose} style={{ marginTop: 24 }}>
            Закрыть
          </button>
        </div>
      </div>
    );
  }

  if (screen === 'error') {
    return (
      <div className="container">
        <div className="success-screen">
          <div className="success-icon" style={{ backgroundColor: 'var(--error)' }}>
            ✕
          </div>
          <h2>Ошибка</h2>
          <p style={{ color: 'var(--text-secondary)' }}>{errorMessage}</p>
          <button className="btn btn-secondary" onClick={() => setScreen('form')} style={{ marginTop: 24 }}>
            Попробовать снова
          </button>
        </div>
      </div>
    );
  }

  if (screen === 'submitting') {
    return (
      <div className="container">
        <div className="loading">
          <div className="spinner" />
          <p>Создание заказа...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="container">
      <div className="header">
        <h1>Новый заказ</h1>
        {client && <p>{client.name}</p>}
      </div>

      <div className="form-group">
        <label>Даты аренды</label>
        <div className="form-row">
          <input
            type="date"
            value={formData.startDate}
            onChange={(e) => updateFormField('startDate', e.target.value)}
            min={getTodayDate()}
          />
          <input
            type="date"
            value={formData.endDate}
            onChange={(e) => updateFormField('endDate', e.target.value)}
            min={formData.startDate}
          />
        </div>
      </div>

      <div className="info-card">
        <h3>Количество дней</h3>
        <p>{formData.daysCount} {getDaysLabel(formData.daysCount)}</p>
      </div>

      <div className="form-group">
        <label>Комплектов радиогидов</label>
        <div className="counter">
          <button onClick={() => decrementCount('kitCount')} disabled={formData.kitCount <= 1}>
            −
          </button>
          <span>{formData.kitCount}</span>
          <button onClick={() => incrementCount('kitCount')}>+</button>
        </div>
      </div>

      <div className="form-group">
        <label>Запасных приёмников</label>
        <div className="counter">
          <button onClick={() => decrementCount('spareReceiverCount')} disabled={formData.spareReceiverCount <= 0}>
            −
          </button>
          <span>{formData.spareReceiverCount}</span>
          <button onClick={() => incrementCount('spareReceiverCount')}>+</button>
        </div>
      </div>

      <div className="form-group">
        <label>Передатчиков</label>
        <div className="counter">
          <button onClick={() => decrementCount('transmitterCount')} disabled={formData.transmitterCount <= 0}>
            −
          </button>
          <span>{formData.transmitterCount}</span>
          <button onClick={() => incrementCount('transmitterCount')}>+</button>
        </div>
      </div>

      <div className="form-group">
        <label>Микрофонов</label>
        <div className="counter">
          <button onClick={() => decrementCount('microphoneCount')} disabled={formData.microphoneCount <= 0}>
            −
          </button>
          <span>{formData.microphoneCount}</span>
          <button onClick={() => incrementCount('microphoneCount')}>+</button>
        </div>
      </div>

      <div className="form-group">
        <label>Комментарий к заказу</label>
        <textarea
          value={formData.comment}
          onChange={(e) => updateFormField('comment', e.target.value)}
          placeholder="Особые пожелания, адрес доставки и т.д."
        />
      </div>

      <div className="price-summary">
        <div className="price-row">
          <span className="price-label">Комплектов</span>
          <span className="price-value">{formData.kitCount} x {PRICE_PER_KIT} руб.</span>
        </div>
        <div className="price-row">
          <span className="price-label">Дней</span>
          <span className="price-value">{formData.daysCount}</span>
        </div>
        <div className="price-row total">
          <span>Итого</span>
          <span>{calculateTotalPrice()} руб.</span>
        </div>
      </div>

      <button className="btn btn-primary" onClick={handleSubmit}>
        Создать заказ
      </button>
    </div>
  );
}

function getTodayDate(): string {
  return new Date().toISOString().split('T')[0];
}

function getTomorrowDate(): string {
  const tomorrow = new Date();
  tomorrow.setDate(tomorrow.getDate() + 1);
  return tomorrow.toISOString().split('T')[0];
}

function getDayAfterTomorrow(): string {
  const dat = new Date();
  dat.setDate(dat.getDate() + 2);
  return dat.toISOString().split('T')[0];
}

function getDaysLabel(count: number): string {
  if (count === 1) return 'день';
  if (count >= 2 && count <= 4) return 'дня';
  return 'дней';
}

export default App;
