-- TourManager Database Schema
-- Run this in Supabase SQL Editor

-- Profiles table (extends auth.users)
CREATE TABLE IF NOT EXISTS profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  display_name TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('admin', 'manager')) DEFAULT 'manager',
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Tour types table
CREATE TABLE IF NOT EXISTS tour_types (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  article_number TEXT NOT NULL DEFAULT '',
  full_price NUMERIC(12, 2) NOT NULL DEFAULT 0,
  discounted_price NUMERIC(12, 2) NOT NULL DEFAULT 0,
  is_enabled BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Additional services table
CREATE TABLE IF NOT EXISTS additional_services (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  price NUMERIC(12, 2) NOT NULL DEFAULT 0,
  is_enabled BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Excursions table
CREATE TABLE IF NOT EXISTS excursions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  tour_type_id UUID REFERENCES tour_types(id) ON DELETE SET NULL,
  event_date DATE NOT NULL,
  event_time TEXT NOT NULL DEFAULT '',
  full_price_count INTEGER NOT NULL DEFAULT 0,
  discounted_count INTEGER NOT NULL DEFAULT 0,
  free_count INTEGER NOT NULL DEFAULT 0,
  by_tour_count INTEGER NOT NULL DEFAULT 0,
  paid_count INTEGER NOT NULL DEFAULT 0,
  expenses JSONB NOT NULL DEFAULT '[]'::jsonb,
  additional_services JSONB NOT NULL DEFAULT '[]'::jsonb,
  manager_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Transactions table
CREATE TABLE IF NOT EXISTS transactions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL CHECK (type IN ('income', 'expense')),
  amount NUMERIC(12, 2) NOT NULL DEFAULT 0,
  description TEXT NOT NULL DEFAULT '',
  event_date DATE NOT NULL,
  manager_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Activities table (audit log)
CREATE TABLE IF NOT EXISTS activities (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  manager_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  manager_name TEXT NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('excursion_added', 'excursion_deleted', 'transaction_added', 'transaction_deleted')),
  description TEXT NOT NULL,
  target_id UUID,
  timestamp TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Deleted items table (soft delete)
CREATE TABLE IF NOT EXISTS deleted_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  item_type TEXT NOT NULL CHECK (item_type IN ('excursion', 'transaction')),
  item_data JSONB NOT NULL,
  deleted_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  deleted_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Push tokens table
CREATE TABLE IF NOT EXISTS push_tokens (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  manager_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  expo_token TEXT NOT NULL UNIQUE,
  platform TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE tour_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE additional_services ENABLE ROW LEVEL SECURITY;
ALTER TABLE excursions ENABLE ROW LEVEL SECURITY;
ALTER TABLE transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE deleted_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE push_tokens ENABLE ROW LEVEL SECURITY;

-- Helper function to check if user is admin
CREATE OR REPLACE FUNCTION is_admin()
RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM profiles
    WHERE id = auth.uid() AND role = 'admin' AND is_active = true
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Profiles policies
CREATE POLICY "Users can view own profile" ON profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Admins can view all profiles" ON profiles
  FOR SELECT USING (is_admin());

CREATE POLICY "Admins can insert profiles" ON profiles
  FOR INSERT WITH CHECK (is_admin());

CREATE POLICY "Admins can update profiles" ON profiles
  FOR UPDATE USING (is_admin());

-- Tour types policies (everyone can read, admins can modify)
CREATE POLICY "Anyone can view tour types" ON tour_types
  FOR SELECT USING (true);

CREATE POLICY "Admins can insert tour types" ON tour_types
  FOR INSERT WITH CHECK (is_admin());

CREATE POLICY "Admins can update tour types" ON tour_types
  FOR UPDATE USING (is_admin());

CREATE POLICY "Admins can delete tour types" ON tour_types
  FOR DELETE USING (is_admin());

-- Additional services policies (everyone can read, admins can modify)
CREATE POLICY "Anyone can view additional services" ON additional_services
  FOR SELECT USING (true);

CREATE POLICY "Admins can insert additional services" ON additional_services
  FOR INSERT WITH CHECK (is_admin());

CREATE POLICY "Admins can update additional services" ON additional_services
  FOR UPDATE USING (is_admin());

CREATE POLICY "Admins can delete additional services" ON additional_services
  FOR DELETE USING (is_admin());

-- Excursions policies (managers see own, admins see all)
CREATE POLICY "Managers can view own excursions" ON excursions
  FOR SELECT USING (manager_id = auth.uid());

CREATE POLICY "Admins can view all excursions" ON excursions
  FOR SELECT USING (is_admin());

CREATE POLICY "Authenticated users can insert excursions" ON excursions
  FOR INSERT WITH CHECK (manager_id = auth.uid());

CREATE POLICY "Managers can update own excursions" ON excursions
  FOR UPDATE USING (manager_id = auth.uid());

CREATE POLICY "Admins can update all excursions" ON excursions
  FOR UPDATE USING (is_admin());

CREATE POLICY "Managers can delete own excursions" ON excursions
  FOR DELETE USING (manager_id = auth.uid());

CREATE POLICY "Admins can delete all excursions" ON excursions
  FOR DELETE USING (is_admin());

-- Transactions policies (managers see own, admins see all)
CREATE POLICY "Managers can view own transactions" ON transactions
  FOR SELECT USING (manager_id = auth.uid());

CREATE POLICY "Admins can view all transactions" ON transactions
  FOR SELECT USING (is_admin());

CREATE POLICY "Authenticated users can insert transactions" ON transactions
  FOR INSERT WITH CHECK (manager_id = auth.uid());

CREATE POLICY "Managers can update own transactions" ON transactions
  FOR UPDATE USING (manager_id = auth.uid());

CREATE POLICY "Admins can update all transactions" ON transactions
  FOR UPDATE USING (is_admin());

CREATE POLICY "Managers can delete own transactions" ON transactions
  FOR DELETE USING (manager_id = auth.uid());

CREATE POLICY "Admins can delete all transactions" ON transactions
  FOR DELETE USING (is_admin());

-- Activities policies (managers see own, admins see all)
CREATE POLICY "Managers can view own activities" ON activities
  FOR SELECT USING (manager_id = auth.uid());

CREATE POLICY "Admins can view all activities" ON activities
  FOR SELECT USING (is_admin());

CREATE POLICY "Authenticated users can insert activities" ON activities
  FOR INSERT WITH CHECK (manager_id = auth.uid());

-- Deleted items policies (admins only)
CREATE POLICY "Admins can view deleted items" ON deleted_items
  FOR SELECT USING (is_admin());

CREATE POLICY "Authenticated users can insert deleted items" ON deleted_items
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Admins can delete from deleted items" ON deleted_items
  FOR DELETE USING (is_admin());

-- Push tokens policies
CREATE POLICY "Users can view own push tokens" ON push_tokens
  FOR SELECT USING (manager_id = auth.uid());

CREATE POLICY "Admins can view all push tokens" ON push_tokens
  FOR SELECT USING (is_admin());

CREATE POLICY "Authenticated users can insert push tokens" ON push_tokens
  FOR INSERT WITH CHECK (manager_id = auth.uid());

CREATE POLICY "Users can delete own push tokens" ON push_tokens
  FOR DELETE USING (manager_id = auth.uid());

-- Create profile on signup trigger
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO profiles (id, email, display_name, role, is_active)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'display_name', NEW.email),
    COALESCE(NEW.raw_user_meta_data->>'role', 'manager'),
    true
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE OR REPLACE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- Updated at trigger
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_tour_types_updated_at
  BEFORE UPDATE ON tour_types
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_additional_services_updated_at
  BEFORE UPDATE ON additional_services
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_excursions_updated_at
  BEFORE UPDATE ON excursions
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_transactions_updated_at
  BEFORE UPDATE ON transactions
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Seed data for tour_types (run only once)
INSERT INTO tour_types (name, article_number, full_price, discounted_price, is_enabled)
VALUES 
  ('Обзорная экскурсия по городу', 'ART-001', 1500, 1200, true),
  ('Экскурсия в Эрмитаж', 'ART-002', 2500, 2000, true),
  ('Речная прогулка по Неве', 'ART-003', 1000, 800, true),
  ('Ночная экскурсия', 'ART-004', 2000, 1600, true),
  ('Загородная экскурсия в Петергоф', 'ART-005', 3500, 2800, true),
  ('Пешеходная экскурсия по центру', 'ART-006', 800, 600, true)
ON CONFLICT DO NOTHING;

-- Seed data for additional_services (run only once)
INSERT INTO additional_services (name, price, is_enabled)
VALUES 
  ('Аудиогид', 300, true),
  ('Радиогид', 200, true),
  ('Обед в ресторане', 1500, true),
  ('Фотосессия', 500, true),
  ('Сувенирный набор', 400, true)
ON CONFLICT DO NOTHING;
