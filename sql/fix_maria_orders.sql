-- Fix orders for duplicate "Мария Экскурсовод" clients
-- Client 1: +79274900014 (31 заказов - оставить как есть)
-- Client 2: +79274299177 (9 заказов - переназначить)

-- Step 1: Check both clients exist
SELECT id, name, phone, company_name 
FROM rental_clients 
WHERE phone IN ('+79274900014', '+79274299177');

-- Step 2: Reassign 9 orders to the correct client (+79274299177)
UPDATE rental_orders 
SET client_id = (SELECT id FROM rental_clients WHERE phone = '+79274299177' LIMIT 1)
WHERE order_number IN (220, 206, 193, 182, 169, 164, 148, 136, 106);

-- Step 3: Verify the fix
SELECT 
  c.name,
  c.phone,
  COUNT(ro.id) as order_count
FROM rental_clients c
LEFT JOIN rental_orders ro ON ro.client_id = c.id
WHERE c.phone IN ('+79274900014', '+79274299177')
GROUP BY c.id, c.name, c.phone;
