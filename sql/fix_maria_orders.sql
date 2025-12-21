-- Fix orders for duplicate "Мария Экскурсовод" clients
-- Телефоны хранятся БЕЗ знака "+"

-- Step 1: Find both clients (checking different phone formats)
SELECT id, name, phone 
FROM rental_clients 
WHERE phone LIKE '%79274299177%' OR phone LIKE '%79274900014%';

-- Step 2: Get the UUID for client +79274299177
-- Copy the ID from step 1 and use it below

-- Step 3: Reassign 9 orders to the correct client
-- REPLACE <UUID> with the actual id from step 1
UPDATE rental_orders 
SET client_id = (
  SELECT id FROM rental_clients 
  WHERE phone LIKE '%79274299177%' 
  LIMIT 1
)
WHERE order_number IN (220, 206, 193, 182, 169, 164, 148, 136, 106);

-- Step 4: Verify the fix
SELECT 
  c.name,
  c.phone,
  COUNT(ro.id) as order_count
FROM rental_clients c
LEFT JOIN rental_orders ro ON ro.client_id = c.id
WHERE c.phone LIKE '%79274299177%' OR c.phone LIKE '%79274900014%'
GROUP BY c.id, c.name, c.phone;
