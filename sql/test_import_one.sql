-- Test import of single order
-- First check if client exists:
SELECT id, name, director_name, phone 
FROM rental_clients 
WHERE name = 'Арсен (Юнион)' 
   OR director_name = 'Арсен (Юнион)'
   OR REPLACE(REPLACE(phone, ' ', ''), '-', '') LIKE '%79152964580%'
LIMIT 5;

-- If client found, try insert:
INSERT INTO rental_orders (
  order_number, client_id, status, start_date, end_date, days_count,
  kit_count, spare_receiver_count, transmitter_count, microphone_count,
  is_charged, price_per_unit, total_price, prepayment, receiver_notes,
  manager_id, manager_name, created_at, updated_at
)
SELECT 
  99999,
  c.id,
  'new',
  '2025-01-15'::date,
  '2025-01-16'::date,
  1,
  10,
  0, 0, 0,
  false,
  100,
  1000,
  0,
  NULL,
  NULL,
  'Test Manager',
  NOW(),
  NOW()
FROM rental_clients c
WHERE c.name = 'Арсен (Юнион)'
LIMIT 1;

-- Check result:
SELECT * FROM rental_orders WHERE order_number = 99999;
