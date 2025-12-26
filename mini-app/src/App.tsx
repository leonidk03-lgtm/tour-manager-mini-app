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
          setText: (text: string) => void;
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

interface Order {
  id: string;
  order_number: number;
  status: string;
  start_date: string;
  end_date: string;
  days_count: number;
  kit_count: number;
  spare_receiver_count: number;
  transmitter_count: number;
  microphone_count: number;
  total_price: number;
  prepayment: number;
  is_charged: boolean;
  receiver_notes: string | null;
  created_at: string;
}

type Screen = 'loading' | 'not_connected' | 'menu' | 'orders' | 'history' | 'balance' | 'new_order' | 'order_details' | 'submitting' | 'success' | 'error';

const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL || '';
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY || '';
const PRICE_PER_KIT = 500;

const STATUS_LABELS: Record<string, string> = {
  new: 'Новый',
  confirmed: 'Подтверждён',
  issued: 'Выдан',
  returned: 'Возвращён',
  completed: 'Завершён',
  cancelled: 'Отменён',
};

const STATUS_COLORS: Record<string, string> = {
  new: '#3b82f6',
  confirmed: '#8b5cf6',
  issued: '#f59e0b',
  returned: '#10b981',
  completed: '#6b7280',
  cancelled: '#ef4444',
};

function App() {
  const [screen, setScreen] = useState<Screen>('loading');
  const [client, setClient] = useState<ClientData | null>(null);
  const [supabase, setSupabase] = useState<SupabaseClient | null>(null);
  const [errorMessage, setErrorMessage] = useState('');
  const [orderNumber, setOrderNumber] = useState<number | null>(null);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [orders, setOrders] = useState<Order[]>([]);
  const [selectedOrder, setSelectedOrder] = useState<Order | null>(null);
  const [stats, setStats] = useState({ activeOrders: 0, totalDebt: 0 });
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

  useEffect(() => {
    submitHandlerRef.current = handleSubmit;
  });

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

  useEffect(() => {
    const tg = window.Telegram?.WebApp;
    if (!tg) return;

    if (screen === 'menu') {
      tg.BackButton.hide();
      tg.MainButton.hide();
    } else if (screen === 'new_order') {
      tg.BackButton.show();
      tg.MainButton.setText('Создать заказ');
      tg.MainButton.show();
    } else if (['orders', 'history', 'balance', 'order_details'].includes(screen)) {
      tg.BackButton.show();
      tg.MainButton.hide();
    } else {
      tg.BackButton.hide();
      tg.MainButton.hide();
    }
  }, [screen]);

  useEffect(() => {
    const tg = window.Telegram?.WebApp;
    if (!tg) return;

    const backHandler = () => {
      if (screen === 'order_details') {
        setScreen('orders');
      } else {
        setScreen('menu');
      }
    };

    tg.BackButton.onClick(backHandler);
    return () => {
      tg.BackButton.offClick(backHandler);
    };
  }, [screen]);

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

    let userId: string | undefined = tg?.initDataUnsafe?.user?.id?.toString();
    
    if (!userId) {
      const urlParams = new URLSearchParams(window.location.search);
      userId = urlParams.get('chatId') || undefined;
    }
    
    if (!userId) {
      setErrorMessage('No user ID found');
      setScreen('not_connected');
      return;
    }

    try {
      const { data: clientData, error } = await sb
        .from('rental_clients')
        .select('id, name, phone')
        .eq('telegram_chat_id', userId)
        .maybeSingle();

      if (error) {
        setErrorMessage(`DB Error: ${error.message}`);
        setScreen('error');
        return;
      }

      if (!clientData) {
        setErrorMessage(`No client found for chatId: ${userId}`);
        setScreen('not_connected');
        return;
      }

      setClient(clientData);
      await loadStats(sb, clientData.id);
      setScreen('menu');
    } catch (err: any) {
      setErrorMessage(err.message || 'Failed to load data');
      setScreen('error');
    }
  }

  async function loadStats(sb: SupabaseClient, clientId: string) {
    const { data: ordersData } = await sb
      .from('rental_orders')
      .select('status, total_price, prepayment, is_charged')
      .eq('client_id', clientId);

    if (ordersData) {
      const activeOrders = ordersData.filter(o => ['new', 'confirmed', 'issued'].includes(o.status)).length;
      const totalDebt = ordersData
        .filter(o => !o.is_charged && o.status !== 'cancelled')
        .reduce((sum, o) => sum + (Number(o.total_price) - Number(o.prepayment || 0)), 0);
      setStats({ activeOrders, totalDebt });
    }
  }

  async function loadOrders(statusFilter: 'active' | 'history') {
    if (!supabase || !client) return;

    const statuses = statusFilter === 'active' 
      ? ['new', 'confirmed', 'issued'] 
      : ['returned', 'completed', 'cancelled'];

    const { data, error } = await supabase
      .from('rental_orders')
      .select('*')
      .eq('client_id', client.id)
      .in('status', statuses)
      .order('created_at', { ascending: false });

    if (!error && data) {
      setOrders(data);
    }
  }

  function validateForm(): string | null {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    
    const startDate = new Date(formData.startDate);
    const endDate = new Date(formData.endDate);
    
    if (startDate < today) return 'Дата начала не может быть в прошлом';
    if (endDate < startDate) return 'Дата окончания не может быть раньше даты начала';
    if (formData.kitCount < 1) return 'Укажите хотя бы один комплект';
    if (formData.daysCount < 1) return 'Минимальный срок аренды - 1 день';
    
    return null;
  }

  async function handleSubmit() {
    if (!supabase || !client) return;
    if (isSubmitting) return;

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

      const { error } = await supabase
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

      setOrderNumber(newOrderNumber);
      tg?.HapticFeedback.notificationOccurred('success');
      setScreen('success');
      
      setFormData({
        startDate: getTomorrowDate(),
        endDate: getDayAfterTomorrow(),
        daysCount: 1,
        kitCount: 1,
        spareReceiverCount: 0,
        transmitterCount: 0,
        microphoneCount: 0,
        comment: '',
      });
      
      await loadStats(supabase, client.id);
    } catch (err: any) {
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

  function navigateTo(newScreen: Screen) {
    window.Telegram?.WebApp.HapticFeedback.selectionChanged();
    if (newScreen === 'orders') {
      loadOrders('active');
    } else if (newScreen === 'history') {
      loadOrders('history');
    }
    setScreen(newScreen);
  }

  function openOrderDetails(order: Order) {
    setSelectedOrder(order);
    setScreen('order_details');
  }

  function formatDate(dateString: string): string {
    const date = new Date(dateString);
    return date.toLocaleDateString('ru-RU', { day: 'numeric', month: 'short' });
  }

  function formatPrice(price: number): string {
    return new Intl.NumberFormat('ru-RU').format(price) + ' руб.';
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
        <div className="center-screen">
          <div className="icon-circle warning">!</div>
          <h2>Не подключено</h2>
          <p className="text-secondary">
            Для создания заказов подключитесь через ссылку-приглашение от менеджера
          </p>
        </div>
      </div>
    );
  }

  if (screen === 'menu') {
    return (
      <div className="container">
        <div className="header">
          <h1>TourManager</h1>
          {client && <p className="text-secondary">{client.name}</p>}
        </div>

        <div className="menu-grid">
          <div className="menu-card" onClick={() => navigateTo('new_order')}>
            <div className="menu-icon primary">+</div>
            <div className="menu-text">
              <h3>Новый заказ</h3>
              <p>Создать заявку на аренду</p>
            </div>
          </div>

          <div className="menu-card" onClick={() => navigateTo('orders')}>
            <div className="menu-icon blue">
              <span className="menu-badge">{stats.activeOrders}</span>
            </div>
            <div className="menu-text">
              <h3>Мои заказы</h3>
              <p>Активные заявки</p>
            </div>
          </div>

          <div className="menu-card" onClick={() => navigateTo('history')}>
            <div className="menu-icon gray">H</div>
            <div className="menu-text">
              <h3>История</h3>
              <p>Завершённые заказы</p>
            </div>
          </div>

          <div className="menu-card" onClick={() => navigateTo('balance')}>
            <div className="menu-icon" style={{ backgroundColor: stats.totalDebt > 0 ? '#ef4444' : '#10b981' }}>
              $
            </div>
            <div className="menu-text">
              <h3>Баланс</h3>
              <p>{stats.totalDebt > 0 ? `Задолженность: ${formatPrice(stats.totalDebt)}` : 'Нет задолженности'}</p>
            </div>
          </div>
        </div>
      </div>
    );
  }

  if (screen === 'orders' || screen === 'history') {
    const title = screen === 'orders' ? 'Мои заказы' : 'История';
    const emptyText = screen === 'orders' ? 'Нет активных заказов' : 'История пуста';

    return (
      <div className="container">
        <div className="header">
          <h1>{title}</h1>
        </div>

        {orders.length === 0 ? (
          <div className="empty-state">
            <p className="text-secondary">{emptyText}</p>
            {screen === 'orders' && (
              <button className="btn btn-primary" onClick={() => navigateTo('new_order')}>
                Создать заказ
              </button>
            )}
          </div>
        ) : (
          <div className="orders-list">
            {orders.map(order => (
              <div key={order.id} className="order-card" onClick={() => openOrderDetails(order)}>
                <div className="order-header">
                  <span className="order-number">#{order.order_number}</span>
                  <span className="order-status" style={{ backgroundColor: STATUS_COLORS[order.status] || '#6b7280' }}>
                    {STATUS_LABELS[order.status] || order.status}
                  </span>
                </div>
                <div className="order-dates">
                  {formatDate(order.start_date)} - {formatDate(order.end_date)}
                </div>
                <div className="order-info">
                  <span>{order.kit_count} комплект(ов)</span>
                  <span className="order-price">{formatPrice(order.total_price)}</span>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    );
  }

  if (screen === 'balance') {
    return (
      <div className="container">
        <div className="header">
          <h1>Баланс</h1>
        </div>

        <div className="balance-card">
          <div className="balance-amount" style={{ color: stats.totalDebt > 0 ? '#ef4444' : '#10b981' }}>
            {stats.totalDebt > 0 ? formatPrice(stats.totalDebt) : 'Нет задолженности'}
          </div>
          <p className="text-secondary">
            {stats.totalDebt > 0 ? 'К оплате' : 'Все заказы оплачены'}
          </p>
        </div>

        <div className="info-text">
          <p>Для оплаты свяжитесь с менеджером или переведите на карту.</p>
        </div>
      </div>
    );
  }

  if (screen === 'order_details' && selectedOrder) {
    const debt = Number(selectedOrder.total_price) - Number(selectedOrder.prepayment || 0);
    
    return (
      <div className="container">
        <div className="header">
          <h1>Заказ #{selectedOrder.order_number}</h1>
          <span className="order-status large" style={{ backgroundColor: STATUS_COLORS[selectedOrder.status] }}>
            {STATUS_LABELS[selectedOrder.status]}
          </span>
        </div>

        <div className="details-section">
          <h3>Даты аренды</h3>
          <p>{formatDate(selectedOrder.start_date)} - {formatDate(selectedOrder.end_date)}</p>
          <p className="text-secondary">{selectedOrder.days_count} {getDaysLabel(selectedOrder.days_count)}</p>
        </div>

        <div className="details-section">
          <h3>Оборудование</h3>
          <div className="details-row">
            <span>Комплектов</span>
            <span>{selectedOrder.kit_count}</span>
          </div>
          {selectedOrder.spare_receiver_count > 0 && (
            <div className="details-row">
              <span>Запасных приёмников</span>
              <span>{selectedOrder.spare_receiver_count}</span>
            </div>
          )}
          {selectedOrder.transmitter_count > 0 && (
            <div className="details-row">
              <span>Передатчиков</span>
              <span>{selectedOrder.transmitter_count}</span>
            </div>
          )}
          {selectedOrder.microphone_count > 0 && (
            <div className="details-row">
              <span>Микрофонов</span>
              <span>{selectedOrder.microphone_count}</span>
            </div>
          )}
        </div>

        <div className="details-section">
          <h3>Оплата</h3>
          <div className="details-row">
            <span>Сумма заказа</span>
            <span>{formatPrice(selectedOrder.total_price)}</span>
          </div>
          <div className="details-row">
            <span>Предоплата</span>
            <span>{formatPrice(selectedOrder.prepayment || 0)}</span>
          </div>
          <div className="details-row total">
            <span>К оплате</span>
            <span style={{ color: debt > 0 ? '#ef4444' : '#10b981' }}>
              {debt > 0 ? formatPrice(debt) : 'Оплачено'}
            </span>
          </div>
        </div>

        {selectedOrder.receiver_notes && (
          <div className="details-section">
            <h3>Комментарий</h3>
            <p className="text-secondary">{selectedOrder.receiver_notes}</p>
          </div>
        )}
      </div>
    );
  }

  if (screen === 'success') {
    return (
      <div className="container">
        <div className="center-screen">
          <div className="icon-circle success">OK</div>
          <h2>Заказ создан!</h2>
          <p className="text-secondary">Номер заказа: #{orderNumber}</p>
          <p className="text-secondary">Менеджер свяжется с вами для подтверждения</p>
          <button className="btn btn-primary" onClick={() => navigateTo('menu')}>
            В меню
          </button>
        </div>
      </div>
    );
  }

  if (screen === 'error') {
    return (
      <div className="container">
        <div className="center-screen">
          <div className="icon-circle error">X</div>
          <h2>Ошибка</h2>
          <p className="text-secondary">{errorMessage}</p>
          <button className="btn btn-secondary" onClick={() => navigateTo('menu')}>
            В меню
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
      </div>

      <div className="form-section">
        <h3 className="section-title">Даты аренды</h3>
        <div className="date-row">
          <div className="date-field">
            <label>Начало</label>
            <input
              type="date"
              value={formData.startDate}
              onChange={(e) => updateFormField('startDate', e.target.value)}
              min={getTodayDate()}
            />
          </div>
          <div className="date-field">
            <label>Окончание</label>
            <input
              type="date"
              value={formData.endDate}
              onChange={(e) => updateFormField('endDate', e.target.value)}
              min={formData.startDate}
            />
          </div>
        </div>
        <div className="days-info">
          {formData.daysCount} {getDaysLabel(formData.daysCount)}
        </div>
      </div>

      <div className="form-section">
        <h3 className="section-title">Оборудование</h3>
        <div className="equipment-grid">
          <div className="equipment-field">
            <label>Компл. *</label>
            <input
              type="number"
              inputMode="numeric"
              value={formData.kitCount || ''}
              onChange={(e) => updateFormField('kitCount', Math.max(1, parseInt(e.target.value) || 1))}
              placeholder="0"
              min="1"
            />
          </div>
          <div className="equipment-field">
            <label>Запасные</label>
            <input
              type="number"
              inputMode="numeric"
              value={formData.spareReceiverCount || ''}
              onChange={(e) => updateFormField('spareReceiverCount', Math.max(0, parseInt(e.target.value) || 0))}
              placeholder="0"
              min="0"
            />
          </div>
          <div className="equipment-field">
            <label>Передат.</label>
            <input
              type="number"
              inputMode="numeric"
              value={formData.transmitterCount || ''}
              onChange={(e) => updateFormField('transmitterCount', Math.max(0, parseInt(e.target.value) || 0))}
              placeholder="0"
              min="0"
            />
          </div>
          <div className="equipment-field">
            <label>Микроф.</label>
            <input
              type="number"
              inputMode="numeric"
              value={formData.microphoneCount || ''}
              onChange={(e) => updateFormField('microphoneCount', Math.max(0, parseInt(e.target.value) || 0))}
              placeholder="0"
              min="0"
            />
          </div>
        </div>
      </div>

      <div className="form-group">
        <label>Комментарий</label>
        <textarea
          value={formData.comment}
          onChange={(e) => updateFormField('comment', e.target.value)}
          placeholder="Адрес доставки, пожелания..."
        />
      </div>

      <div className="price-summary">
        <div className="price-row">
          <span>Комплектов</span>
          <span>{formData.kitCount} x {PRICE_PER_KIT} руб.</span>
        </div>
        <div className="price-row">
          <span>Дней</span>
          <span>{formData.daysCount}</span>
        </div>
        <div className="price-row total">
          <span>Итого</span>
          <span>{formatPrice(calculateTotalPrice())}</span>
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
