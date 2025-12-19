-- Выполните эти команды в Supabase SQL Editor
-- Добавляет поля для хранения менеджера клиента и запасных приемников в заказе

-- 1. Добавить поля owner_manager_id и owner_manager_name в таблицу rental_orders
ALTER TABLE rental_orders 
ADD COLUMN IF NOT EXISTS owner_manager_id UUID REFERENCES profiles(id),
ADD COLUMN IF NOT EXISTS owner_manager_name TEXT;

-- 2. Добавить поле spare_receiver_count для запасных приемников
ALTER TABLE rental_orders 
ADD COLUMN IF NOT EXISTS spare_receiver_count INTEGER DEFAULT 0;

-- 3. (Опционально) Заполнить существующие заказы данными из клиентов
-- UPDATE rental_orders ro
-- SET 
--   owner_manager_id = rc.assigned_manager_id,
--   owner_manager_name = p.display_name
-- FROM rental_clients rc
-- LEFT JOIN profiles p ON p.id = rc.assigned_manager_id
-- WHERE ro.client_id = rc.id AND ro.owner_manager_id IS NULL;
