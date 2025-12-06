import { createClient } from '@supabase/supabase-js';
import AsyncStorage from '@react-native-async-storage/async-storage';

const supabaseUrl = process.env.SUPABASE_URL || process.env.EXPO_PUBLIC_SUPABASE_URL || '';
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY || process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY || '';

export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    storage: AsyncStorage,
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: false,
  },
});

export type UserRole = 'admin' | 'manager';

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
