-- Выполните эти команды в Supabase SQL Editor

-- 1. Добавить поля комиссий в таблицу profiles
ALTER TABLE profiles 
ADD COLUMN IF NOT EXISTS owner_commission_percent INTEGER DEFAULT 20,
ADD COLUMN IF NOT EXISTS executor_commission_percent INTEGER DEFAULT 10;

-- 2. Создать таблицу rental_commissions
CREATE TABLE IF NOT EXISTS rental_commissions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id UUID NOT NULL REFERENCES rental_orders(id) ON DELETE CASCADE,
  order_number INTEGER NOT NULL,
  recipient_id UUID NOT NULL REFERENCES profiles(id),
  recipient_name TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('owner', 'executor')),
  amount INTEGER NOT NULL,
  basis_amount INTEGER NOT NULL,
  percentage INTEGER NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'paid')),
  paid_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- 3. Создать индексы
CREATE INDEX IF NOT EXISTS idx_rental_commissions_order_id ON rental_commissions(order_id);
CREATE INDEX IF NOT EXISTS idx_rental_commissions_recipient_id ON rental_commissions(recipient_id);
CREATE INDEX IF NOT EXISTS idx_rental_commissions_status ON rental_commissions(status);

-- 4. Включить RLS
ALTER TABLE rental_commissions ENABLE ROW LEVEL SECURITY;

-- 5. Создать политики RLS
CREATE POLICY "Allow read all rental_commissions for authenticated users"
ON rental_commissions FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Allow insert rental_commissions for authenticated users"
ON rental_commissions FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY "Allow update rental_commissions for authenticated users"
ON rental_commissions FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

-- 6. Включить Realtime для таблицы
ALTER PUBLICATION supabase_realtime ADD TABLE rental_commissions;
