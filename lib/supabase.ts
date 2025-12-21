import { createClient, SupabaseClient } from '@supabase/supabase-js';
import AsyncStorage from '@react-native-async-storage/async-storage';
import Constants from 'expo-constants';

const SUPABASE_URL_KEY = 'supabase_custom_url';
const SUPABASE_ANON_KEY_KEY = 'supabase_custom_anon_key';

const extraConfig = Constants.expoConfig?.extra || {};
const defaultUrl = process.env.SUPABASE_URL || process.env.EXPO_PUBLIC_SUPABASE_URL || extraConfig.supabaseUrl || '';
const defaultAnonKey = process.env.SUPABASE_ANON_KEY || process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY || extraConfig.supabaseAnonKey || '';

let currentUrl = defaultUrl;
let currentAnonKey = defaultAnonKey;

function createSupabaseClient(url: string, anonKey: string): SupabaseClient | null {
  if (!url || !anonKey) {
    console.warn('Supabase URL or Anon Key not configured');
    return null as unknown as SupabaseClient;
  }
  return createClient(url, anonKey, {
    auth: {
      storage: AsyncStorage,
      autoRefreshToken: true,
      persistSession: true,
      detectSessionInUrl: false,
    },
    db: {
      schema: 'public',
    },
    global: {
      headers: {
        'x-my-custom-header': 'tour-manager',
      },
    },
  });
}

export let supabase = createSupabaseClient(currentUrl, currentAnonKey);

export async function initSupabaseFromStorage(): Promise<void> {
  try {
    const storedUrl = await AsyncStorage.getItem(SUPABASE_URL_KEY);
    const storedAnonKey = await AsyncStorage.getItem(SUPABASE_ANON_KEY_KEY);
    
    if (storedUrl && storedAnonKey) {
      currentUrl = storedUrl;
      currentAnonKey = storedAnonKey;
      supabase = createSupabaseClient(currentUrl, currentAnonKey);
    }
  } catch (error) {
    console.error('Error loading Supabase config from storage:', error);
  }
}

export async function getSupabaseConfig(): Promise<{ url: string; anonKey: string }> {
  const storedUrl = await AsyncStorage.getItem(SUPABASE_URL_KEY);
  const storedAnonKey = await AsyncStorage.getItem(SUPABASE_ANON_KEY_KEY);
  
  return {
    url: storedUrl || defaultUrl,
    anonKey: storedAnonKey || defaultAnonKey,
  };
}

export async function updateSupabaseConfig(url: string, anonKey: string): Promise<void> {
  await AsyncStorage.setItem(SUPABASE_URL_KEY, url);
  await AsyncStorage.setItem(SUPABASE_ANON_KEY_KEY, anonKey);
  
  currentUrl = url;
  currentAnonKey = anonKey;
  supabase = createSupabaseClient(url, anonKey);
}

export async function resetSupabaseConfig(): Promise<void> {
  await AsyncStorage.removeItem(SUPABASE_URL_KEY);
  await AsyncStorage.removeItem(SUPABASE_ANON_KEY_KEY);
  
  currentUrl = defaultUrl;
  currentAnonKey = defaultAnonKey;
  supabase = createSupabaseClient(defaultUrl, defaultAnonKey);
}

export function getCurrentSupabaseUrl(): string {
  return currentUrl;
}

export type UserRole = 'admin' | 'manager' | 'radio_dispatcher';

export type PermissionKey = 
  | 'radio_guides'
  | 'radio_guides_add'
  | 'radio_guides_edit'
  | 'allocation'
  | 'chat'
  | 'chat_view_all'
  | 'dispatching_notes'
  | 'excursion_notes'
  | 'excursions'
  | 'finances'
  | 'view_other_managers'
  | 'warehouse'
  | 'rental'
  | 'rental_clients'
  | 'rental_orders'
  | 'rental_payments'
  | 'rental_commissions'
  | 'rental_calendar';

export const PERMISSION_DEFINITIONS: Record<PermissionKey, string> = {
  radio_guides: 'Радиогиды',
  radio_guides_add: 'Добавление сумок',
  radio_guides_edit: 'Редактирование сумок',
  allocation: 'Распределение',
  chat: 'Чат',
  chat_view_all: 'Полный доступ',
  dispatching_notes: 'Отправление',
  excursion_notes: 'Заметки к экскурсиям',
  excursions: 'Экскурсии',
  finances: 'Финансы',
  view_other_managers: 'Просмотр данных коллег',
  warehouse: 'Склад',
  rental: 'Аренда',
  rental_clients: 'Клиенты',
  rental_orders: 'Заказы',
  rental_payments: 'Платежи',
  rental_commissions: 'Комиссии',
  rental_calendar: 'Календарь',
};

export interface PermissionGroup {
  key: PermissionKey;
  label: string;
  description?: string;
  children?: { key: PermissionKey; label: string; description?: string }[];
}

export const PERMISSION_GROUPS: PermissionGroup[] = [
  {
    key: 'radio_guides',
    label: 'Радиогиды',
    description: 'Доступ к разделу',
    children: [
      { key: 'radio_guides_add', label: 'Добавление сумок' },
      { key: 'radio_guides_edit', label: 'Редактирование сумок' },
    ],
  },
  {
    key: 'chat',
    label: 'Чат',
    description: 'Доступ к разделу',
    children: [
      { key: 'chat_view_all', label: 'Полный доступ', description: 'Видит все сообщения (иначе только свои и ответы)' },
    ],
  },
  { key: 'allocation', label: 'Распределение' },
  { key: 'dispatching_notes', label: 'Отправление' },
  { key: 'excursion_notes', label: 'Заметки к экскурсиям' },
  { key: 'excursions', label: 'Экскурсии' },
  { key: 'finances', label: 'Финансы' },
  { key: 'view_other_managers', label: 'Просмотр данных коллег' },
  { key: 'warehouse', label: 'Склад' },
  { 
    key: 'rental', 
    label: 'Аренда', 
    description: 'Доступ к модулю аренды радиогидов',
    children: [
      { key: 'rental_clients', label: 'Клиенты' },
      { key: 'rental_orders', label: 'Заказы' },
      { key: 'rental_payments', label: 'Платежи' },
      { key: 'rental_commissions', label: 'Комиссии' },
      { key: 'rental_calendar', label: 'Календарь' },
    ],
  },
];

export type ManagerPermissions = Partial<Record<PermissionKey, boolean>>;

export type DashboardWidgetKey = 
  | 'kpi_cards'
  | 'period_summary'
  | 'alerts'
  | 'today_excursions'
  | 'rental_section';

export const DASHBOARD_WIDGET_DEFINITIONS: { key: DashboardWidgetKey; label: string; description: string }[] = [
  { key: 'kpi_cards', label: 'KPI карточки', description: 'Прибыль, доход, расходы, участники' },
  { key: 'period_summary', label: 'Сводка по периодам', description: 'Неделя и месяц' },
  { key: 'alerts', label: 'Оповещения', description: 'Низкий заряд, запас, просроченные' },
  { key: 'today_excursions', label: 'Экскурсии на сегодня', description: 'Список экскурсий' },
  { key: 'rental_section', label: 'Аренда', description: 'Активные заказы аренды' },
];

export interface DashboardConfig {
  widgets: {
    key: DashboardWidgetKey;
    visible: boolean;
    order: number;
  }[];
}

export const DEFAULT_DASHBOARD_CONFIG: DashboardConfig = {
  widgets: [
    { key: 'kpi_cards', visible: true, order: 0 },
    { key: 'period_summary', visible: true, order: 1 },
    { key: 'alerts', visible: true, order: 2 },
    { key: 'today_excursions', visible: true, order: 3 },
    { key: 'rental_section', visible: true, order: 4 },
  ],
};

export interface Profile {
  id: string;
  email: string;
  display_name: string;
  role: UserRole;
  is_active: boolean;
  permissions?: ManagerPermissions;
  owner_commission_percent?: number;
  executor_commission_percent?: number;
  service_commission_percent?: number;
  dashboard_config?: DashboardConfig;
  created_at: string;
  updated_at: string;
}

export interface DbExcursion {
  id: string;
  tour_type_id: string;
  event_date: string;
  event_time: string;
  full_price_count: number;
  discounted_count: number;
  free_count: number;
  by_tour_count: number;
  paid_count: number;
  expenses: { type: string; amount: number }[];
  additional_services: { serviceId: string; count: number }[];
  manager_id: string;
  manager_name?: string;
  created_at: string;
  updated_at: string;
}

export interface DbTransaction {
  id: string;
  type: 'income' | 'expense';
  amount: number;
  description: string;
  event_date: string;
  manager_id: string;
  manager_name?: string;
  created_at: string;
  updated_at: string;
}

export interface DbTourType {
  id: string;
  name: string;
  article_number: string;
  full_price: number;
  discounted_price: number;
  is_enabled: boolean;
  created_at: string;
  updated_at: string;
}

export interface DbAdditionalService {
  id: string;
  name: string;
  price: number;
  is_enabled: boolean;
  created_at: string;
  updated_at: string;
}

export interface DbActivity {
  id: string;
  manager_id: string;
  manager_name: string;
  type: 'excursion_added' | 'excursion_deleted' | 'transaction_added' | 'transaction_deleted';
  description: string;
  target_id: string;
  timestamp: string;
}

export interface DbRadioGuideKit {
  id: string;
  bag_number: number;
  receiver_count: number;
  status: 'available' | 'issued' | 'maintenance';
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface DbRadioGuideAssignment {
  id: string;
  kit_id: string;
  excursion_id: string | null;
  guide_name: string;
  bus_number: string | null;
  receivers_issued: number;
  receivers_returned: number | null;
  issued_at: string;
  returned_at: string | null;
  return_notes: string | null;
  manager_id: string;
  manager_name: string;
  created_at: string;
  updated_at: string;
}

export interface DbExcursionNote {
  id: string;
  excursion_id: string;
  manager_id: string;
  manager_name: string;
  text: string;
  created_at: string;
  updated_at: string;
}
