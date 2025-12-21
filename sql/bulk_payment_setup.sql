-- Групповые платежи для клиентов (Bulk Payments)
-- Выполните эти команды в Supabase SQL Editor

-- 1. Создать таблицу групповых платежей
CREATE TABLE IF NOT EXISTS rental_payment_batches (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  client_id UUID NOT NULL REFERENCES rental_clients(id) ON DELETE CASCADE,
  total_amount INTEGER NOT NULL,
  payment_method TEXT NOT NULL DEFAULT 'transfer' CHECK (payment_method IN ('cash', 'card', 'transfer')),
  payment_date DATE NOT NULL DEFAULT CURRENT_DATE,
  reference TEXT,
  notes TEXT,
  created_by UUID REFERENCES profiles(id),
  created_by_name TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Связующая таблица: какие заказы оплачены в рамках групповой оплаты
CREATE TABLE IF NOT EXISTS rental_batch_orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  batch_id UUID NOT NULL REFERENCES rental_payment_batches(id) ON DELETE CASCADE,
  order_id UUID NOT NULL REFERENCES rental_orders(id) ON DELETE CASCADE,
  allocated_amount INTEGER NOT NULL,
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(batch_id, order_id)
);

-- 3. Добавить ссылку на групповой платёж в rental_payments
ALTER TABLE rental_payments 
ADD COLUMN IF NOT EXISTS batch_id UUID REFERENCES rental_payment_batches(id) ON DELETE SET NULL;

-- 4. Создать индексы
CREATE INDEX IF NOT EXISTS idx_rental_payment_batches_client_id ON rental_payment_batches(client_id);
CREATE INDEX IF NOT EXISTS idx_rental_payment_batches_created_at ON rental_payment_batches(created_at);
CREATE INDEX IF NOT EXISTS idx_rental_batch_orders_batch_id ON rental_batch_orders(batch_id);
CREATE INDEX IF NOT EXISTS idx_rental_batch_orders_order_id ON rental_batch_orders(order_id);
CREATE INDEX IF NOT EXISTS idx_rental_payments_batch_id ON rental_payments(batch_id);

-- 5. Включить RLS
ALTER TABLE rental_payment_batches ENABLE ROW LEVEL SECURITY;
ALTER TABLE rental_batch_orders ENABLE ROW LEVEL SECURITY;

-- 6. Создать политики RLS для rental_payment_batches
CREATE POLICY "Allow read rental_payment_batches for authenticated users"
ON rental_payment_batches FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Allow insert rental_payment_batches for authenticated users"
ON rental_payment_batches FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY "Allow update rental_payment_batches for authenticated users"
ON rental_payment_batches FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

CREATE POLICY "Allow delete rental_payment_batches for authenticated users"
ON rental_payment_batches FOR DELETE
TO authenticated
USING (true);

-- 7. Создать политики RLS для rental_batch_orders
CREATE POLICY "Allow read rental_batch_orders for authenticated users"
ON rental_batch_orders FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Allow insert rental_batch_orders for authenticated users"
ON rental_batch_orders FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY "Allow delete rental_batch_orders for authenticated users"
ON rental_batch_orders FOR DELETE
TO authenticated
USING (true);

-- 8. Включить Realtime
ALTER PUBLICATION supabase_realtime ADD TABLE rental_payment_batches;
ALTER PUBLICATION supabase_realtime ADD TABLE rental_batch_orders;
