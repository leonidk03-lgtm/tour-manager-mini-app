import { createClient, SupabaseClient } from '@supabase/supabase-js';
import AsyncStorage from '@react-native-async-storage/async-storage';

const SUPABASE_URL_KEY = 'supabase_custom_url';
const SUPABASE_ANON_KEY_KEY = 'supabase_custom_anon_key';

const defaultUrl = process.env.SUPABASE_URL || process.env.EXPO_PUBLIC_SUPABASE_URL || '';
const defaultAnonKey = process.env.SUPABASE_ANON_KEY || process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY || '';

let currentUrl = defaultUrl;
let currentAnonKey = defaultAnonKey;

function createSupabaseClient(url: string, anonKey: string): SupabaseClient {
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

export interface Profile {
  id: string;
  email: string;
  display_name: string;
  role: UserRole;
  is_active: boolean;
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
