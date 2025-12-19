-- Модуль аренды радиогидов
-- Выполните этот скрипт в Supabase SQL Editor

-- 1. Таблица клиентов аренды
CREATE TABLE IF NOT EXISTS rental_clients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL CHECK (type IN ('individual', 'company')),
  name TEXT NOT NULL,
  phone TEXT,
  email TEXT,
  director_name TEXT,
  legal_address TEXT,
  inn TEXT,
  kpp TEXT,
  default_price NUMERIC DEFAULT 100,
  assigned_manager_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  notes TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Таблица заказов аренды
CREATE TABLE IF NOT EXISTS rental_orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_number SERIAL,
  client_id UUID NOT NULL REFERENCES rental_clients(id) ON DELETE RESTRICT,
  status TEXT NOT NULL DEFAULT 'new' CHECK (status IN ('new', 'issued', 'returned', 'completed', 'cancelled')),
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ NOT NULL,
  days_count INTEGER NOT NULL DEFAULT 1,
  kit_count INTEGER NOT NULL DEFAULT 0,
  transmitter_count INTEGER NOT NULL DEFAULT 0,
  microphone_count INTEGER NOT NULL DEFAULT 0,
  bag_number TEXT,
  is_charged BOOLEAN DEFAULT false,
  price_per_unit NUMERIC NOT NULL DEFAULT 100,
  total_price NUMERIC NOT NULL DEFAULT 0,
  prepayment NUMERIC DEFAULT 0,
  receiver_notes TEXT,
  manager_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  manager_name TEXT,
  executor_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  executor_name TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Таблица платежей по аренде
CREATE TABLE IF NOT EXISTS rental_payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id UUID NOT NULL REFERENCES rental_orders(id) ON DELETE CASCADE,
  type TEXT NOT NULL CHECK (type IN ('prepayment', 'refund', 'service_expense', 'final')),
  amount NUMERIC NOT NULL,
  manager_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  manager_name TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. Таблица истории изменений заказа
CREATE TABLE IF NOT EXISTS rental_order_history (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id UUID NOT NULL REFERENCES rental_orders(id) ON DELETE CASCADE,
  action TEXT NOT NULL,
  manager_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  manager_name TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Индексы для производительности
CREATE INDEX IF NOT EXISTS idx_rental_clients_type ON rental_clients(type);
CREATE INDEX IF NOT EXISTS idx_rental_clients_manager ON rental_clients(assigned_manager_id);
CREATE INDEX IF NOT EXISTS idx_rental_orders_client ON rental_orders(client_id);
CREATE INDEX IF NOT EXISTS idx_rental_orders_status ON rental_orders(status);
CREATE INDEX IF NOT EXISTS idx_rental_orders_dates ON rental_orders(start_date, end_date);
CREATE INDEX IF NOT EXISTS idx_rental_orders_manager ON rental_orders(manager_id);
CREATE INDEX IF NOT EXISTS idx_rental_payments_order ON rental_payments(order_id);
CREATE INDEX IF NOT EXISTS idx_rental_order_history_order ON rental_order_history(order_id);

-- RLS политики
ALTER TABLE rental_clients ENABLE ROW LEVEL SECURITY;
ALTER TABLE rental_orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE rental_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE rental_order_history ENABLE ROW LEVEL SECURITY;

-- Политики для rental_clients
CREATE POLICY "Enable read for authenticated users" ON rental_clients
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable insert for authenticated users" ON rental_clients
  FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "Enable update for authenticated users" ON rental_clients
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable delete for authenticated users" ON rental_clients
  FOR DELETE TO authenticated USING (true);

-- Политики для rental_orders
CREATE POLICY "Enable read for authenticated users" ON rental_orders
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable insert for authenticated users" ON rental_orders
  FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "Enable update for authenticated users" ON rental_orders
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable delete for authenticated users" ON rental_orders
  FOR DELETE TO authenticated USING (true);

-- Политики для rental_payments
CREATE POLICY "Enable read for authenticated users" ON rental_payments
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable insert for authenticated users" ON rental_payments
  FOR INSERT TO authenticated WITH CHECK (true);

CREATE POLICY "Enable update for authenticated users" ON rental_payments
  FOR UPDATE TO authenticated USING (true) WITH CHECK (true);

CREATE POLICY "Enable delete for authenticated users" ON rental_payments
  FOR DELETE TO authenticated USING (true);

-- Политики для rental_order_history
CREATE POLICY "Enable read for authenticated users" ON rental_order_history
  FOR SELECT TO authenticated USING (true);

CREATE POLICY "Enable insert for authenticated users" ON rental_order_history
  FOR INSERT TO authenticated WITH CHECK (true);

-- Триггер для обновления updated_at (если еще не существует)
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

DROP TRIGGER IF EXISTS update_rental_clients_updated_at ON rental_clients;
CREATE TRIGGER update_rental_clients_updated_at
  BEFORE UPDATE ON rental_clients
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_rental_orders_updated_at ON rental_orders;
CREATE TRIGGER update_rental_orders_updated_at
  BEFORE UPDATE ON rental_orders
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Включить Realtime для таблиц
ALTER PUBLICATION supabase_realtime ADD TABLE rental_clients;
ALTER PUBLICATION supabase_realtime ADD TABLE rental_orders;
ALTER PUBLICATION supabase_realtime ADD TABLE rental_payments;
ALTER PUBLICATION supabase_realtime ADD TABLE rental_order_history;
