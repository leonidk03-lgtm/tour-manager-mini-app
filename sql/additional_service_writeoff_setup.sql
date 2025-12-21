-- Настройка автоматического списания товаров при продаже дополнительных услуг
-- Выполните в Supabase SQL Editor

-- 1. Добавляем колонку для связи доп. услуги с товаром на складе
ALTER TABLE additional_services 
ADD COLUMN IF NOT EXISTS writeoff_item_id UUID REFERENCES equipment_items(id) ON DELETE SET NULL;

-- 2. Добавляем комментарий для понимания
COMMENT ON COLUMN additional_services.writeoff_item_id IS 'ID товара со склада, который автоматически списывается при продаже этой услуги';
