-- Reimport orders with direct phone matching
-- Step 1: Delete all existing orders
DELETE FROM rental_orders;

-- Step 2: Insert orders with direct phone lookup
-- SKIP order 1273: no phone
-- SKIP order 1272: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1271, c.id, 'new', '2026-01-03'::date, '2026-01-05'::date, 3, 45, 0, 0, 0, false, 96, 12900, 0, 'Заберет сама', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274111993%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1270, c.id, 'new', '2026-01-09'::date, '2026-01-09'::date, 1, 36, 0, 0, 0, false, 97, 3500, 0, 'Из АйТи парка в АйТи парк', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1269, c.id, 'new', '2026-01-09'::date, '2026-01-09'::date, 1, 31, 0, 0, 0, false, 97, 3000, 0, 'Из Сафара в Релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1268, c.id, 'new', '2026-01-06'::date, '2026-01-06'::date, 1, 42, 0, 0, 0, false, 98, 4100, 0, 'Из Сафара в Релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1267, c.id, 'new', '2026-01-05'::date, '2026-01-05'::date, 1, 40, 0, 0, 0, false, 98, 3900, 0, 'Из АйТи парка в АйТи парк', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1266, c.id, 'new', '2026-01-05'::date, '2026-01-05'::date, 1, 45, 0, 0, 0, false, 98, 4400, 0, 'Из Сафара в Релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1265, c.id, 'new', '2026-01-04'::date, '2026-01-04'::date, 1, 24, 0, 0, 0, false, 96, 2300, 0, 'Уточнить', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1264, c.id, 'new', '2026-01-04'::date, '2026-01-04'::date, 1, 39, 0, 0, 0, false, 97, 3800, 0, 'Из АйТи парка в АйТи парк', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1263, c.id, 'new', '2026-01-04'::date, '2026-01-04'::date, 1, 45, 0, 0, 0, false, 98, 4400, 0, 'Из Сафара в Релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1262, c.id, 'new', '2026-01-03'::date, '2026-01-03'::date, 1, 45, 0, 0, 0, false, 98, 4400, 0, 'Из Сафара в Релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1261, c.id, 'new', '2026-01-02'::date, '2026-01-02'::date, 1, 46, 0, 0, 0, false, 98, 4500, 0, 'Уточнить откуда, вернут в Стерлядку', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1260, c.id, 'new', '2025-12-31'::date, '2025-12-31'::date, 1, 29, 0, 0, 0, false, 77, 2240, 0, 'Из Сафара в Релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1259, c.id, 'new', '2025-12-31'::date, '2025-12-31'::date, 1, 32, 0, 0, 0, false, 78, 2480, 0, 'Из АйТи парка в АйТи парк', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1258, c.id, 'new', '2026-01-07'::date, '2026-01-09'::date, 3, 42, 0, 0, 0, false, 95, 12000, 0, 'Уточнить', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1257, c.id, 'new', '2026-01-06'::date, '2026-01-06'::date, 1, 46, 0, 0, 0, false, 98, 4500, 0, 'Уточнить', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1256, c.id, 'new', '2026-01-03'::date, '2026-01-05'::date, 3, 47, 0, 0, 0, false, 96, 13500, 0, 'Уточнить', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1255, c.id, 'new', '2026-01-08'::date, '2026-01-08'::date, 1, 37, 0, 0, 0, false, 95, 3500, 0, 'Уточнить', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1254, c.id, 'new', '2026-01-06'::date, '2026-01-08'::date, 3, 37, 0, 0, 0, false, 95, 10500, 0, 'Уточнить', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1253, c.id, 'new', '2026-01-04'::date, '2026-01-06'::date, 3, 50, 0, 0, 0, false, 96, 14400, 0, 'Уточнить', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1252, c.id, 'new', '2026-01-03'::date, '2026-01-05'::date, 3, 44, 0, 0, 0, false, 95, 12600, 0, 'Уточнить', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1251, c.id, 'new', '2026-01-02'::date, '2026-01-04'::date, 3, 50, 0, 0, 0, false, 96, 14400, 0, 'Уточнить', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1250, c.id, 'new', '2025-12-18'::date, '2025-12-18'::date, 1, 46, 0, 0, 0, false, 98, 4500, 0, 'Завезти в Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1249, c.id, 'new', '2026-01-06'::date, '2026-01-06'::date, 1, 46, 0, 0, 0, false, 98, 4500, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1248, c.id, 'new', '2025-12-18'::date, '2025-12-20'::date, 3, 32, 0, 0, 0, false, 75, 7200, 0, 'В офис Вернут в Азимут после 20:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1247, c.id, 'new', '2025-12-17'::date, '2025-12-19'::date, 3, 36, 0, 0, 0, false, 73, 7920, 0, 'В офис с 14 до 17', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1246, c.id, 'new', '2025-12-12'::date, '2025-12-12'::date, 1, 41, 0, 0, 0, false, 98, 4000, 0, 'Заберут в 10 с Баумана', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1245, c.id, 'new', '2025-12-12'::date, '2025-12-12'::date, 1, 31, 0, 0, 0, false, 77, 2400, 0, 'Вернут в офис вечером, гид Эльвира, м Полина', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1244, c.id, 'new', '2025-12-06'::date, '2025-12-07'::date, 2, 40, 0, 0, 0, false, 100, 8000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1243, c.id, 'new', '2026-01-03'::date, '2026-01-04'::date, 2, 40, 0, 0, 0, false, 100, 8000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1242, c.id, 'new', '2025-12-31'::date, '2026-01-01'::date, 2, 40, 0, 0, 0, false, 100, 8000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1241, c.id, 'new', '2025-12-13'::date, '2025-12-13'::date, 1, 21, 0, 0, 0, false, 76, 1600, 0, 'Из Сафара в релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1240, c.id, 'new', '2025-12-10'::date, '2025-12-10'::date, 1, 16, 0, 0, 0, false, 75, 1200, 0, 'В Марриот до 9:30 Оставят в Каспийске после 16;00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172914815%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1239, c.id, 'new', '2025-12-08'::date, '2025-12-08'::date, 1, 55, 0, 0, 0, false, 79, 4320, 0, '07.12 с 8:30 до 11:00 заберут от Свита Холла •Рузиля 54шт / оставит после 15:00 в фургончике (+7 965 603-40-01)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1238, c.id, 'new', '2025-12-08'::date, '2025-12-09'::date, 2, 27, 0, 0, 0, false, 68, 3680, 0, '07.12 с 8:30 до 11:00 заберут от Свита Холла •Снежанна 26шт + 20 доп наушников / оставит 08.12 у свита Холла (+7 927 414-91-01)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1237, c.id, 'new', '2025-12-07'::date, '2025-12-07'::date, 1, 25, 0, 0, 0, false, 96, 2400, 0, 'Карина К 18:00 заберут из фургончика, закончат в 22:00 сообщат куда оставят', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179221193%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1236, c.id, 'new', '2025-12-08'::date, '2025-12-09'::date, 2, 48, 0, 0, 0, false, 61, 5840, 0, '07.12 с 8:30 до 11:00 заберут от Свита Холла •Елена 47шт + 26 доп наушников / оставит 08.12 у свита Холла (+7 927 401-58-22)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1235, c.id, 'new', '2025-12-08'::date, '2025-12-09'::date, 2, 50, 0, 0, 0, false, 102, 10160, 0, '07.12 с 8:30 до 11:00 заберут от Свита Холла •Эльмира 49шт + 78 доп наушников / оставит 08.12 в Кристалле (+7 917 878-83-60)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1234, c.id, 'new', '2025-12-08'::date, '2025-12-09'::date, 2, 31, 0, 0, 0, false, 65, 4000, 0, '06.12 вечером в Кристалл •Ирина 30шт + 20 доп наушников / оставит 08.12 у Свита Холла (+7 917 293-48-70)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1233, c.id, 'new', '2025-12-08'::date, '2025-12-08'::date, 2, 44, 0, 0, 0, false, 75, 6560, 0, '06.12 вечером в Амакс Сафар •Ольга 43 + 39 доп наушников / оставит 08.12 в Кристалл (+7 950 314-03-61)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

-- SKIP order 1232: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1231, c.id, 'new', '2025-12-05'::date, '2025-12-05'::date, 1, 28, 0, 0, 0, false, 77, 2160, 0, '04.12 вечером или 05.12 до 11:00 в Кристалл! Гульназ 27шт / оставит в Амакс после 14:30 (+7 939 390-26-10)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1230, c.id, 'new', '2025-12-05'::date, '2025-12-05'::date, 1, 31, 0, 0, 0, false, 77, 2400, 0, '04.12 вечером или 05.12 до 11:00 в Кристалл! Светлана 30шт / оставит в Амакс после 14:30 (+7 967 780-00-66)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1229, c.id, 'new', '2025-12-05'::date, '2025-12-05'::date, 1, 47, 0, 0, 0, false, 78, 3680, 0, '04.12 вечером или 05.12 до 11:00 в Кристалл! •Татьяна 46шт / оставит в Амакс после 14:00 (+7 987 282-71-66)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1228, c.id, 'new', '2025-12-05'::date, '2025-12-05'::date, 1, 37, 0, 0, 0, false, 147, 5440, 0, '04.12 в офис Казань 360, в районе 12:00 Эльмира 36+32 доп наушника / оставит в Амакс после 20:30 (+7 917 878-83-60)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1227, c.id, 'new', '2025-12-05'::date, '2025-12-05'::date, 1, 55, 0, 0, 0, false, 119, 6560, 0, '04.12 В офис Казань 360, в районе 12:00 Снежанна 54 +28 доп наушников / оставит в Амакс после 20:30 ( +7 927 414-91-01)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1226, c.id, 'new', '2025-12-05'::date, '2025-12-05'::date, 1, 47, 0, 0, 0, false, 78, 3680, 0, '04.12 в офис Казань 360 в районе 12:00 Ольга 46шт / оставит в фургончике после 15:00 (+7 950 314-03-61)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1225, c.id, 'new', '2025-12-05'::date, '2025-12-05'::date, 1, 48, 0, 0, 0, false, 78, 3760, 0, '04.12 в офис Казань 360 в районе 12:00 Алик 47шт / оставит в Амакс после 15:00 (+7 987 221-02-84)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1224, c.id, 'new', '2025-12-21'::date, '2025-12-21'::date, 1, 31, 0, 0, 0, false, 97, 3000, 0, 'Дауна 8:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1223, c.id, 'new', '2025-12-07'::date, '2025-12-07'::date, 1, 52, 0, 0, 0, false, 98, 5100, 0, 'Баумана в 8:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1222, c.id, 'new', '2025-11-28'::date, '2025-11-28'::date, 1, 25, 0, 0, 0, false, 96, 2400, 0, 'Оставить в фургончике до 15:00, вечером оставит в Шаляпине', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046623179%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1221, c.id, 'new', '2025-11-25'::date, '2025-11-25'::date, 1, 11, 0, 0, 0, false, 73, 800, 0, 'Ольга ткач', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033449007%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1220, c.id, 'new', '2026-01-04'::date, '2026-01-05'::date, 2, 52, 0, 0, 0, false, 96, 10000, 0, 'Уточнить', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9006000057%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1219, c.id, 'new', '2025-12-14'::date, '2025-12-14'::date, 1, 51, 0, 0, 0, false, 98, 5000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1218, c.id, 'new', '2025-11-23'::date, '2025-11-23'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, 'Баумана в 8:15 Алена Лазуко', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1217, c.id, 'new', '2025-11-19'::date, '2025-11-20'::date, 2, 29, 0, 0, 0, false, 93, 5400, 0, 'заберет из фургончика', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872961933%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1216, c.id, 'new', '2025-11-18'::date, '2025-11-19'::date, 2, 33, 0, 0, 0, false, 75, 4960, 0, 'Авиатор. Игорь', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1215, c.id, 'new', '2025-11-20'::date, '2025-11-20'::date, 1, 104, 0, 0, 0, false, 77, 8000, 0, '19.10 в районе 10 заберет ! 4 сумки по 26шт', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9376252850%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1214, c.id, 'new', '2025-11-19'::date, '2025-11-19'::date, 1, 20, 0, 0, 0, false, 95, 1900, 0, 'Заберет в 11:00 из фургончика', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1212, c.id, 'new', '2026-01-08'::date, '2026-01-09'::date, 2, 27, 0, 0, 0, false, 93, 5000, 0, 'Ростов', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1211, c.id, 'new', '2026-01-06'::date, '2026-01-08'::date, 3, 37, 0, 0, 0, false, 95, 10500, 0, 'Подольск Передать 5 вечером', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1210, c.id, 'new', '2026-01-07'::date, '2026-01-09'::date, 3, 37, 0, 0, 0, false, 95, 10500, 0, 'Карабулак', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1209, c.id, 'new', '2026-01-05'::date, '2026-01-07'::date, 3, 37, 0, 0, 0, false, 95, 10500, 0, 'ЕКБ 3', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1208, c.id, 'new', '2026-01-03'::date, '2026-01-05'::date, 3, 37, 0, 0, 0, false, 95, 10500, 0, 'ЕКБ 2', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1207, c.id, 'new', '2025-12-31'::date, '2026-01-02'::date, 3, 37, 0, 0, 0, false, 95, 10500, 0, 'ЕКБ 1', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1206, c.id, 'new', '2025-12-19'::date, '2025-12-21'::date, 3, 32, 0, 0, 0, false, 94, 9000, 0, 'Гатчина К 11:30 в дом чая , Катя Кореева', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

-- SKIP order 1205: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1204, c.id, 'new', '2025-11-29'::date, '2025-11-30'::date, 2, 17, 0, 0, 0, false, 88, 3000, 0, 'Карат до 11:00. Оставят в спринтере у Оксаны', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9112872606%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1203, c.id, 'new', '2025-11-16'::date, '2025-11-19'::date, 4, 10, 0, 0, 0, false, 56, 2240, 0, '14.11 в офис , оригинал счёта и акта', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1202, c.id, 'new', '2025-11-15'::date, '2025-11-15'::date, 1, 19, 0, 0, 0, false, 76, 1440, 0, 'От Сафара в Релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

-- SKIP order 1201: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1200, c.id, 'new', '2025-11-20'::date, '2025-11-23'::date, 4, 22, 0, 0, 0, false, 68, 6000, 0, '22.11. Не работают. в отеле Рамада Казань на Чернышевского. Для булата валиуллина и Антона зенкова если что', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

-- SKIP order 1199: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1198, c.id, 'new', '2025-11-14'::date, '2025-11-16'::date, 3, 37, 0, 0, 0, false, 95, 10500, 0, 'В Азу до 12:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1197, c.id, 'new', '2025-11-18'::date, '2025-11-20'::date, 3, 37, 0, 0, 0, false, 95, 10500, 0, 'Щелково, 8:15 дом чая, оставят в кристалле после 21:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1196, c.id, 'new', '2025-11-08'::date, '2025-11-09'::date, 2, 43, 0, 0, 0, false, 95, 8200, 0, '8 ноября к 11:30-12:00 в кафе «Азу» на Петербургской 52', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1195, c.id, 'new', '2025-11-08'::date, '2025-11-09'::date, 2, 48, 0, 0, 0, false, 96, 9200, 0, 'Заберет Владимир Нежданов. Из фургончика в 13:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9068185524%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1194, c.id, 'new', '2025-11-07'::date, '2025-11-07'::date, 1, 20, 0, 0, 0, false, 76, 1520, 0, ', 7.11 к 9.20 а Дон Кихот радио гиды на19 человек гид Аида. Вернут после 20 в Донецке Кихот. +7 903 344-08-99 Аида', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1193, c.id, 'new', '2025-11-14'::date, '2025-11-16'::date, 3, 40, 0, 0, 0, false, 76, 9120, 0, 'Уточнить ОТМЕНА', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1192, c.id, 'new', '2025-11-08'::date, '2025-11-09'::date, 2, 28, 0, 0, 0, false, 74, 4160, 0, 'Гид Эльвира, Полина, в офис', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1191, c.id, 'new', '2025-11-05'::date, '2025-11-05'::date, 1, 18, 0, 0, 0, false, 76, 1360, 0, 'В офис до 13', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1190, c.id, 'new', '2025-11-03'::date, '2025-11-03'::date, 1, 40, 0, 0, 0, false, 98, 3900, 0, '3 ноября на 1 день нужны радиогиды, 39 человек +гид Ирина т.+7 927 421-36-82 Группа приедет на ЦЖД в 12:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

-- SKIP order 1189: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1188, c.id, 'new', '2025-11-03'::date, '2025-11-04'::date, 2, 39, 0, 0, 0, false, 76, 5920, 0, 'В офис 03 днем , вернут 4 после обеда Гид Диана, мен Полина', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1187, c.id, 'new', '2025-11-03'::date, '2025-11-03'::date, 1, 26, 0, 0, 0, false, 77, 2000, 0, 'Из Сафара в релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1186, c.id, 'new', '2025-11-03'::date, '2025-11-03'::date, 1, 24, 0, 0, 0, false, 77, 1840, 0, 'Из биляра в Биляр', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1185, c.id, 'new', '2025-11-01'::date, '2025-11-01'::date, 1, 37, 0, 0, 0, false, 78, 2880, 0, 'В 10:30 заберут', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9050249197%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1184, c.id, 'new', '2025-11-01'::date, '2025-11-01'::date, 1, 16, 0, 0, 0, false, 94, 1500, 0, 'Заберет сама в 8:45', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1183, c.id, 'new', '2025-10-30'::date, '2025-10-30'::date, 1, 16, 0, 0, 0, false, 75, 1200, 0, 'В кафе Медину на спартаковской до 13', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1182, c.id, 'new', '2025-11-06'::date, '2025-11-06'::date, 1, 44, 0, 0, 0, false, 98, 4300, 0, 'На 6 ноября оставьте для нас радиомикрофоны в кол- ве 43 шт) Отель Волга. С 15:00 - До 20 ч там же и оставим', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9277213758%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1181, c.id, 'new', '2025-10-29'::date, '2025-10-29'::date, 1, 23, 0, 0, 0, false, 73, 1680, 0, 'в офис до 15:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033449007%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1180, c.id, 'new', '2025-10-30'::date, '2025-10-30'::date, 1, 63, 0, 0, 0, false, 77, 4880, 0, 'Две сумки на 37 и 26шт Гид Резида и Людмила , Полина', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1179, c.id, 'new', '2025-10-28'::date, '2025-10-28'::date, 1, 31, 0, 0, 0, false, 165, 5100, 0, 'заберет из бусика ВЕРНЕТ В КРИССТАЛ ПОСЛЕ 22:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1178, c.id, 'new', '2025-10-28'::date, '2025-10-29'::date, 2, 38, 0, 0, 0, false, 66, 5040, 0, 'Заявка на 28 и 29 октября 36 человек +гид Лиля т.+7 965 602-05-28 28.10 приезжают в 12:30 на ЦЖД. ВЕРНУТ В РИВЬЕРУ', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1177, c.id, 'new', '2025-10-29'::date, '2025-10-29'::date, 1, 21, 0, 0, 0, false, 95, 2000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9170779471%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1176, c.id, 'new', '2025-10-27'::date, '2025-10-28'::date, 2, 35, 0, 0, 0, false, 66, 4620, 0, 'Гостиница Булгар 2* , улица Вишневского 21 33+ гид Владимир т 89178858409 На 27 и 28 октября', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1175, c.id, 'new', '2025-10-29'::date, '2025-10-29'::date, 1, 23, 0, 0, 0, false, 77, 1760, 0, '29.10 22 чел. Карат к 8.20 вернут по созвону в 16.00 гид Диляра Рафкатовна 89179275489. СУМОЧКА В КАРАТЕ', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1174, c.id, 'new', '2025-10-28'::date, '2025-10-28'::date, 1, 50, 0, 0, 0, false, 78, 3920, 0, '28.10 49 чел. к 9.30 в хостел Крылья вернут по созвону после 16. гид Николай 89172349414. ВЕРНУТ В ОФИС', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1173, c.id, 'new', '2025-10-28'::date, '2025-10-30'::date, 3, 42, 0, 0, 0, false, 76, 9600, 0, '28-30.10 40 чел. 28 в Кристалл к 10.30 вернут в Кристалл 30.10 после 23.00 гид Гульсина Закиевна 89178975685', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1172, c.id, 'new', '2025-10-27'::date, '2025-10-28'::date, 2, 1, 0, 0, 0, false, 3600, 7200, 0, '27-28.10 40 чел. 27 в Кристалл в 12 вернут 28 в Кристалл в 17.гид Лилия 89872975449', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1171, c.id, 'new', '2025-10-27'::date, '2025-10-28'::date, 2, 42, 0, 0, 0, false, 76, 6400, 0, '27-28.10 40чел. 27 в Кристалл в 12 вернут в Кристалл 28 в 17 гид Диана 8927445452527', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1170, c.id, 'new', '2025-10-26'::date, '2025-10-28'::date, 3, 53, 0, 0, 0, false, 77, 12240, 0, 'Гид Яна, доставкой, добавить в счёт 238₽ , Любовь', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1169, c.id, 'new', '2025-10-26'::date, '2025-10-26'::date, 1, 25, 0, 0, 0, false, 77, 1920, 0, '26.10 24чел. Кристалл 9.30 вернут после 20.00 в Кристалл гид Ирина 89046620732 Вернут в 09:00 в кристалл 27.10', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1168, c.id, 'new', '2025-11-01'::date, '2025-11-03'::date, 3, 24, 0, 0, 0, false, 92, 6600, 0, 'В дом чая до 13. Оставят в кристалл после 22:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1167, c.id, 'new', '2025-10-25'::date, '2025-10-25'::date, 1, 26, 0, 0, 0, false, 96, 2500, 0, 'кафе азу до 14;30. Вернут в 19:00 к свито холлу', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1166, c.id, 'new', '2025-10-25'::date, '2025-10-26'::date, 2, 24, 0, 0, 0, false, 73, 3520, 0, '25.10 22 чел. хостел Крылья в 6.00 сдадут 26.10 после 16. по созвону. гид Татьяна 89600344289 Вернули в крылья', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1165, c.id, 'new', '2025-10-25'::date, '2025-10-25'::date, 1, 21, 0, 0, 0, false, 76, 1600, 0, '25.10 20 чел. Кристалл в 10 вернут по созвону. гида Марина 89172526993', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1164, c.id, 'new', '2025-10-24'::date, '2025-10-24'::date, 1, 55, 0, 0, 0, false, 79, 4320, 0, 'В офис до 12, Римма', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1163, c.id, 'new', '2025-11-02'::date, '2025-11-02'::date, 1, 46, 0, 0, 0, false, 98, 4500, 0, 'Эверест в 17:00 в мано', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1162, c.id, 'new', '2025-11-18'::date, '2025-11-19'::date, 2, 36, 0, 0, 0, false, 76, 5440, 0, 'Кристал вернули туда же. 1 потеряли', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1161, c.id, 'new', '2025-10-25'::date, '2025-10-25'::date, 1, 157, 0, 0, 0, false, 74, 11641, 0, 'Группа #1 Начало в Свияжске в 9 утра 42 человека + гид Аида т. +79033440899 Группа #2 Начало в 10:00 на ЦЖД 45 человек + гид Татьяна т.89063271840 Группа #3 Начало в 10:00 на ЦЖД 29 человек + гид Ирина т.89274213682 Группа #4 Начало в 10:00 на ЦЖД 37 человек + гид Владимир т.89178858409 Все группы заканчивают в 20:10-20:30 на ЦЖД 43,46,30,38', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1160, c.id, 'new', '2025-12-31'::date, '2026-01-01'::date, 2, 80, 0, 0, 0, false, 95, 15200, 0, 'две сумки по 40', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1159, c.id, 'new', '2025-10-26'::date, '2025-10-26'::date, 1, 62, 0, 0, 0, false, 97, 6000, 0, '2 сумки по 31. Кристал. Ирина софронова и Ирина совельева ВЕЧЕРОМ', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9038307370%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1158, c.id, 'new', '2025-10-28'::date, '2025-10-28'::date, 1, 21, 0, 0, 0, false, 95, 2000, 0, 'К 15:00 заберут из фургончика Двойной комплект наушников', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179221193%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1157, c.id, 'new', '2025-10-23'::date, '2025-10-24'::date, 2, 44, 0, 0, 0, false, 95, 8400, 0, 'Волга начало в 12:30. Елена.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9225115900%' LIMIT 1;

-- SKIP order 1156: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1155, c.id, 'new', '2025-10-22'::date, '2025-10-22'::date, 1, 53, 0, 0, 0, false, 78, 4160, 0, 'Накануне, гид Надежда, римма', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1154, c.id, 'new', '2025-10-20'::date, '2025-10-20'::date, 1, 89, 0, 0, 0, false, 78, 6960, 0, '2 сумки на 43 и 44шт утром, Римма', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

-- SKIP order 1153: no phone
-- SKIP order 1152: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1151, c.id, 'new', '2025-10-19'::date, '2025-10-19'::date, 1, 41, 0, 0, 0, false, 98, 4000, 0, '19 октября 40 радиогидов. Утром в 9.30 забираю группу в Гранд отеле.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872969542%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1150, c.id, 'new', '2025-10-17'::date, '2025-10-17'::date, 1, 510, 0, 0, 0, false, 78, 40000, 0, 'В 9:30 Маяковского 24А', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1149, c.id, 'new', '2025-10-18'::date, '2025-10-18'::date, 1, 54, 0, 0, 0, false, 79, 4240, 0, 'В офис утром Римма', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1148, c.id, 'new', '2025-10-17'::date, '2025-10-19'::date, 3, 42, 0, 0, 0, false, 76, 9600, 0, 'Кристал. Гулистан Закиевна. +79178975685', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1147, c.id, 'new', '2025-10-18'::date, '2025-10-18'::date, 1, 42, 0, 0, 0, false, 98, 4100, 0, 'Фатима. Сумка в Кристалле', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1146, c.id, 'new', '2025-10-16'::date, '2025-10-16'::date, 1, 8, 0, 0, 0, false, 188, 1500, 0, 'заберет в 11:40', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9510610028%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1145, c.id, 'new', '2025-10-25'::date, '2025-10-25'::date, 1, 185, 0, 0, 0, false, 109, 20200, 0, 'Поезд в 9:05 Казань пасс 1) 52+1 гид Наталья Жукова +7 (927) 243-43-67 2) 54+1 гид Валерий Матросов +7 (905) 319-54-86 3) 52+1 гид Зельфира +7 (987) 275-03-95 4) 22+1 гид на 2 дня Снежана +7 (927) 414-91-01 (5:02) поезд Заканчивают в 21:30 на жд', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9372883686%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1144, c.id, 'new', '2025-10-21'::date, '2025-10-22'::date, 2, 51, 0, 0, 0, false, 77, 7840, 0, 'В офис, гид Лилия, Полина', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1143, c.id, 'new', '2025-10-14'::date, '2025-10-14'::date, 1, 20, 0, 0, 0, false, 76, 1520, 0, 'Кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9108272699%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1142, c.id, 'new', '2025-10-30'::date, '2025-10-31'::date, 2, 16, 0, 0, 0, false, 70, 2240, 0, 'Марина Трэвел Юлия (2гр) В кристалл В офис Инициативы принесут 01.11', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1141, c.id, 'new', '2025-10-30'::date, '2025-11-01'::date, 3, 44, 0, 0, 0, false, 93, 12300, 0, 'Экскурсовод Марина 8917 288-90-13 Дома чая до 15:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1140, c.id, 'new', '2025-10-28'::date, '2025-10-30'::date, 3, 36, 0, 0, 0, false, 141, 15200, 0, 'Дом чая до 15:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1139, c.id, 'new', '2025-10-25'::date, '2025-10-27'::date, 3, 36, 0, 0, 0, false, 94, 10200, 0, 'К 14:30 дома Чая, Катя Кореева ВЕРНЕТ В КРИСТАЛЛ ПОСЛЕ 20:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1138, c.id, 'new', '2025-10-27'::date, '2025-10-29'::date, 3, 46, 0, 0, 0, false, 96, 13200, 0, 'Гид Диляра Ахмерова +7 950 327-62-72 Поезд прибывает 27 октября 377 в 12:29 . Кристал. ВЕРНУЛИ В ШАЛЯПИН', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9222673014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1137, c.id, 'new', '2025-10-22'::date, '2025-10-22'::date, 1, 41, 0, 0, 0, false, 98, 4000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9063310993%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1136, c.id, 'new', '2025-10-11'::date, '2025-10-11'::date, 1, 100, 0, 0, 0, false, 78, 7840, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1135, c.id, 'new', '2025-10-10'::date, '2025-10-10'::date, 1, 135, 0, 0, 0, false, 78, 10560, 0, 'Отмена!', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1134, c.id, 'new', '2025-10-11'::date, '2025-10-11'::date, 1, 56, 0, 0, 0, false, 98, 5500, 0, 'Сопровождающая группы Ирина +7 951 908-31-31. Будем ждать вас в Туган Авылым 11.10 в 12:30. окончание экскурсии в 18:00.', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9159441878%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1133, c.id, 'new', '2025-10-15'::date, '2025-10-16'::date, 2, 52, 0, 0, 0, false, 96, 10000, 0, 'Сами заберут и вернут После обеда', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178516882%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1132, c.id, 'new', '2025-10-11'::date, '2025-10-11'::date, 1, 19, 0, 0, 0, false, 76, 1440, 0, 'От Сафара в Сулейман', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1131, c.id, 'new', '2025-10-11'::date, '2025-10-12'::date, 2, 33, 0, 0, 0, false, 94, 6200, 0, 'Заберет в +/- 12:00. 12 числа', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872969542%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1130, c.id, 'new', '2025-10-24'::date, '2025-10-25'::date, 2, 55, 0, 0, 0, false, 96, 10600, 0, 'Ф Крис стал', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9264062333%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1129, c.id, 'new', '2025-10-12'::date, '2025-10-12'::date, 1, 47, 0, 0, 0, false, 98, 4600, 0, 'Сумка в Волге', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1128, c.id, 'new', '2025-10-08'::date, '2025-10-10'::date, 3, 56, 0, 0, 0, false, 77, 12960, 0, 'В гфис любовь', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1127, c.id, 'new', '2025-10-07'::date, '2025-10-07'::date, 1, 21, 0, 0, 0, false, 76, 1600, 0, 'Заберут до 14:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179221193%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1126, c.id, 'new', '2025-10-10'::date, '2025-10-10'::date, 1, 49, 0, 0, 0, false, 77, 3760, 0, '2 сумки на 27шт и 20шт, во второй половине дня', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179221193%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1125, c.id, 'new', '2025-10-17'::date, '2025-10-20'::date, 4, 14, 0, 0, 0, false, 69, 3840, 0, 'В офис 16.10 Забрать 21 в обед оригинал акт и счёт', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1124, c.id, 'new', '2025-10-09'::date, '2025-10-09'::date, 1, 41, 0, 0, 0, false, 78, 3200, 0, 'Гид Аида, Римма', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1123, c.id, 'new', '2025-10-07'::date, '2025-10-07'::date, 1, 46, 0, 0, 0, false, 78, 3600, 0, 'В офис, Римма', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1122, c.id, 'new', '2025-10-07'::date, '2025-10-08'::date, 2, 40, 0, 0, 0, false, 76, 6080, 0, 'Гид Николай, мне Римма, в офис Тиц 7.10', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

-- SKIP order 1121: no phone
-- SKIP order 1120: no phone
-- SKIP order 1119: no phone
-- SKIP order 1118: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1117, c.id, 'new', '2025-10-07'::date, '2025-10-07'::date, 1, 46, 0, 0, 0, false, 78, 3600, 0, 'Амакс Сафар. Вернула в офис', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869297050%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1116, c.id, 'new', '2025-10-06'::date, '2025-10-08'::date, 3, 51, 0, 0, 0, false, 77, 11760, 0, 'Доставкой сами вызовут Любовь', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1115, c.id, 'new', '2025-10-06'::date, '2025-10-09'::date, 3, 20, 0, 0, 0, false, 72, 4320, 0, 'Оставить в парк отеле', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869160808%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1114, c.id, 'new', '2025-10-04'::date, '2025-10-04'::date, 1, 25, 0, 0, 0, false, 77, 1920, 0, 'Вернут в офис Тиц к 19:00 Мен Анна', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1113, c.id, 'new', '2025-10-12'::date, '2025-10-12'::date, 1, 31, 0, 0, 0, false, 97, 3000, 0, 'Эллинлайн Инн --7807028247--12.10 , туристов --30 , едут из Иошкар Олы, тел гида из Казани, 89033428060--Светлана Сумка в кристале', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9219733344%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1112, c.id, 'new', '2025-10-04'::date, '2025-10-05'::date, 2, 14, 0, 0, 0, false, 74, 2080, 0, 'заберет Игорь в 9:10. +79274055070. Вернул в фургончик', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1111, c.id, 'new', '2025-10-28'::date, '2025-10-28'::date, 1, 52, 0, 0, 0, false, 78, 4080, 0, '28 октября с 9:00 до 13:30 экскурсовод елена +79053162973 В релиту Оставят в Азу у АйТи парка в 12:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1110, c.id, 'new', '2025-10-26'::date, '2025-10-26'::date, 1, 52, 0, 0, 0, false, 78, 4080, 0, '26 октября с 11 :00 до 18:00 Экскурсовод снежана+79274149101 В Азу на Петербургской до 12 Оставят в Релите в 18', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1109, c.id, 'new', '2025-10-05'::date, '2025-10-05'::date, 1, 30, 0, 0, 0, false, 77, 2320, 0, 'Сулейман . Аида. Вернут вечером в Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1108, c.id, 'new', '2025-10-25'::date, '2025-10-26'::date, 2, 41, 0, 0, 0, false, 95, 7800, 0, 'Бирку не делал. Сумка без номера. Пломба 2482', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

-- SKIP order 1107: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1106, c.id, 'new', '2025-10-04'::date, '2025-10-05'::date, 2, 37, 0, 0, 0, false, 76, 5600, 0, 'Вернут в офис Инициативы, в пн забрать с деньгами', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1105, c.id, 'new', '2025-10-04'::date, '2025-10-05'::date, 2, 30, 0, 0, 0, false, 77, 4640, 0, 'Оставят 6 утром в парк отеле', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869160808%' LIMIT 1;

-- SKIP order 1104: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1103, c.id, 'new', '2025-11-06'::date, '2025-11-06'::date, 1, 25, 0, 0, 0, false, 100, 2500, 0, 'Волга', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9277213758%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1102, c.id, 'new', '2025-10-23'::date, '2025-10-23'::date, 1, 48, 0, 0, 0, false, 98, 4700, 0, 'Волга. Начало в 14:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9277213758%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1101, c.id, 'new', '2025-10-03'::date, '2025-10-03'::date, 1, 49, 0, 0, 0, false, 98, 4800, 0, 'Заберет в 8:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1100, c.id, 'new', '2025-10-06'::date, '2025-10-06'::date, 1, 26, 0, 0, 0, false, 96, 2500, 0, '6 октября 15:00-18:00 25 радиогдиов на имя гида Татьяна Сулеймманова, отель Мариотт Казань', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1099, c.id, 'new', '2025-10-04'::date, '2025-10-05'::date, 2, 32, 0, 0, 0, false, 94, 6000, 0, 'Вернет в пн утром', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172788430%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1098, c.id, 'new', '2025-10-10'::date, '2025-10-10'::date, 1, 20, 0, 0, 0, false, 76, 1520, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1097, c.id, 'new', '2025-10-04'::date, '2025-10-04'::date, 1, 108, 0, 0, 0, false, 78, 8400, 0, 'В Марриот 3 сумки по 36шт Гиды: Наталия +7 987 238-41-05 София +7 905 038-37-23 Элина +7 917 236-98-27 В 14 вернут туда же, уточнить', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172914815%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1096, c.id, 'new', '2025-10-08'::date, '2025-10-08'::date, 1, 204, 0, 0, 0, false, 78, 16000, 0, 'Отказ', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178533525%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1095, c.id, 'new', '2025-10-04'::date, '2025-10-05'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, 'В кристалл оставит к 22', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1094, c.id, 'new', '2025-10-03'::date, '2025-10-03'::date, 1, 102, 0, 0, 0, false, 98, 10000, 0, 'В Ривьеру до 16:00, вернут в 19:30 туда же', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9969526558%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1093, c.id, 'new', '2025-10-03'::date, '2025-10-03'::date, 1, 14, 0, 0, 0, false, 74, 1040, 0, 'Нужен набор на 13+1 3.10 16:00-20:30 забрать и отнести можем сами на Баумана вам.', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9376252850%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1092, c.id, 'new', '2025-10-01'::date, '2025-10-01'::date, 1, 30, 0, 0, 0, false, 75, 2240, 0, 'в офис', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033449007%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1091, c.id, 'new', '2025-10-01'::date, '2025-10-01'::date, 1, 50, 0, 0, 0, false, 78, 3920, 0, 'В офис тиц до 11, гид Юрий', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1090, c.id, 'new', '2025-09-30'::date, '2025-09-30'::date, 1, 16, 0, 0, 0, false, 75, 1200, 0, 'Заберет из бусика', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046623179%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1089, c.id, 'new', '2025-10-04'::date, '2025-10-04'::date, 1, 28, 0, 0, 0, false, 77, 2160, 0, 'От Корстон в Корстон', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1088, c.id, 'new', '2025-10-04'::date, '2025-10-04'::date, 1, 25, 0, 0, 0, false, 77, 1920, 0, 'От Сафара, до Корстона', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1087, c.id, 'new', '2025-10-28'::date, '2025-10-30'::date, 2, 24, 0, 0, 0, false, 118, 5680, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1086, c.id, 'new', '2025-10-02'::date, '2025-10-02'::date, 1, 31, 0, 0, 0, false, 77, 2400, 0, 'Заберет сама в районе в 8:15', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9372883686%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1085, c.id, 'new', '2025-10-01'::date, '2025-10-03'::date, 3, 42, 0, 0, 0, false, 94, 11840, 0, 'В пн вернут', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274163395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1084, c.id, 'new', '2025-11-01'::date, '2025-11-02'::date, 2, 37, 0, 0, 0, false, 76, 5600, 0, '1-2.11 35 чел. 1.11 в Кристалл к 12 вернут 2.11 по созвону гид Владимир Николаевич 89178858409. ВЕРНУЛ В КРИСТАЛ', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1083, c.id, 'new', '2025-10-03'::date, '2025-10-05'::date, 3, 49, 0, 0, 0, false, 77, 11280, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1082, c.id, 'new', '2025-10-06'::date, '2025-10-06'::date, 1, 48, 0, 0, 0, false, 78, 3760, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1081, c.id, 'new', '2025-09-28'::date, '2025-09-28'::date, 1, 50, 0, 0, 0, false, 70, 3500, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1080, c.id, 'new', '2025-09-27'::date, '2025-09-27'::date, 1, 56, 0, 0, 0, false, 79, 4400, 0, 'Оставил в Шаляпин', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9196451838%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1079, c.id, 'new', '2025-09-27'::date, '2025-09-27'::date, 1, 27, 0, 0, 0, false, 77, 2080, 0, 'Кристал, вернут туда же', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

-- SKIP order 1078: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1077, c.id, 'new', '2025-10-27'::date, '2025-10-30'::date, 4, 45, 0, 0, 0, false, 76, 13760, 0, '27-30.10 43 чел. 27 в Кристалле в 11 вернут 30 в Кристалл после 23.00гид Игорь 89274055070 ВЕЧЕРОМ ВЕРНЕТ К 12 в фургончик', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1076, c.id, 'new', '2025-10-27'::date, '2025-10-28'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, '27.10-29.10 45 чел. 27 в Кристалле в 7.30 вернут 29 в Кристалл в 17.30 гид Аида 89033440899 ВЕЧЕРОМ. ОСТАВИЛИ ХОСТЕЛ СЛИП СПЕЙС. ЧИСТОПОЛЬСКАЯ 19А, 3 этаж, офис 36', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1075, c.id, 'new', '2025-10-26'::date, '2025-10-29'::date, 4, 39, 0, 0, 0, false, 57, 8880, 0, '26-29.10 *без28 октября* 37 чел. в Кристалл к 11 сдадут 29.10 в кристалл после 19.30 гид Дания 89172904415 живут в Кварте.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1074, c.id, 'new', '2025-10-26'::date, '2025-10-28'::date, 3, 32, 0, 0, 0, false, 75, 7200, 0, '26-28.10 30 чел. Кристалл в 7.30 сдадут 28.10 после 17 в Кристалл ВЕЧЕРОМ гид Ольга 89503140361', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1073, c.id, 'new', '2025-10-17'::date, '2025-10-19'::date, 3, 50, 0, 0, 0, false, 77, 11520, 0, 'Кристал. Игорь. +79274055070', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1072, c.id, 'new', '2025-09-28'::date, '2025-09-28'::date, 1, 43, 0, 0, 0, false, 78, 3360, 0, 'Оставить в фургончике до 13:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046623179%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1071, c.id, 'new', '2025-09-30'::date, '2025-09-30'::date, 1, 21, 0, 0, 0, false, 76, 1600, 0, 'Кристалл для Веры Валерьевны', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9108272699%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1070, c.id, 'new', '2025-09-27'::date, '2025-09-27'::date, 1, 28, 0, 0, 0, false, 77, 2160, 0, 'Оставить в бусике до 16:00, вернут в 18:40', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179221193%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1069, c.id, 'new', '2025-09-26'::date, '2025-09-28'::date, 3, 41, 0, 0, 0, false, 76, 9360, 0, 'Сумка в офисе', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

-- SKIP order 1068: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1067, c.id, 'new', '2025-09-24'::date, '2025-09-24'::date, 1, 11, 0, 0, 0, false, 73, 800, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1066, c.id, 'new', '2025-09-26'::date, '2025-09-28'::date, 3, 32, 0, 0, 0, false, 75, 7200, 0, 'В офис 25, гид Николай и Татьяна, мен Римма', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1065, c.id, 'new', '2025-09-26'::date, '2025-09-26'::date, 1, 18, 0, 0, 0, false, 76, 1360, 0, 'От Сафара до Сулеймана', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1064, c.id, 'new', '2025-09-25'::date, '2025-09-28'::date, 4, 36, 0, 0, 0, false, 76, 10880, 0, '25-28 нужно 34 радиогида гид Владимир Николаевич 89178858409 привезти надо в отель Давыдов на К! Маркса к 9.30 , а сдаст сам к Вам в офис после обеда 28.09 или по созвону.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1063, c.id, 'new', '2025-09-27'::date, '2025-09-28'::date, 2, 29, 0, 0, 0, false, 74, 4320, 0, 'Заберет сама и вернет сама. 28.09 оставят в кафе азу после 13:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1062, c.id, 'new', '2025-10-02'::date, '2025-10-02'::date, 1, 16, 0, 0, 0, false, 75, 1200, 0, 'заберет сам', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1061, c.id, 'new', '2025-09-28'::date, '2025-09-28'::date, 1, 35, 0, 0, 0, false, 78, 2720, 0, 'Вернут либо в воскресенье вечером либо в понедельник', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9509693961%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1060, c.id, 'new', '2025-09-28'::date, '2025-09-28'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'Заберет утром +7 927 240-82-50 Лариса', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9006000057%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1059, c.id, 'new', '2025-10-29'::date, '2025-10-30'::date, 2, 40, 0, 0, 0, false, 76, 6080, 0, 'Кристалл', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274463215%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1058, c.id, 'new', '2025-10-26'::date, '2025-10-28'::date, 3, 70, 0, 0, 0, false, 100, 0, 0, '2 сумки по 35', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274463215%' LIMIT 1;

-- SKIP order 1057: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1056, c.id, 'new', '2025-09-24'::date, '2025-09-24'::date, 1, 31, 0, 0, 0, false, 77, 2400, 0, 'Утром заберет, вернут 24.09 к 18:00 Гид Алексей, мен Камилла', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1055, c.id, 'new', '2025-09-24'::date, '2025-09-27'::date, 4, 22, 0, 0, 0, false, 69, 6080, 0, 'Оставят в кристалле', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9159441878%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1054, c.id, 'new', '2025-09-25'::date, '2025-09-26'::date, 2, 42, 0, 0, 0, false, 76, 6400, 0, 'Ривьера. Валерий', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1053, c.id, 'new', '2025-09-24'::date, '2025-09-24'::date, 1, 26, 0, 0, 0, false, 77, 2000, 0, 'грант отель. Валерий', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1052, c.id, 'new', '2025-09-27'::date, '2025-10-01'::date, 5, 25, 0, 0, 0, false, 67, 8400, 0, 'Азимут', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9246802568%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1051, c.id, 'new', '2025-09-21'::date, '2025-09-21'::date, 1, 29, 0, 0, 0, false, 77, 2240, 0, '22.09 утром привезут', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9061135111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1050, c.id, 'new', '2025-09-20'::date, '2025-09-20'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, 'В 7:45 от свита Холла', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1049, c.id, 'new', '2025-09-30'::date, '2025-09-30'::date, 1, 36, 0, 0, 0, false, 78, 2800, 0, 'Волга', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9277213758%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1048, c.id, 'new', '2025-09-24'::date, '2025-09-25'::date, 2, 37, 0, 0, 0, false, 76, 5600, 0, 'Гид Катя Кореева, из бусика', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172914815%' LIMIT 1;

-- SKIP order 1046: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1044, c.id, 'new', '2025-09-20'::date, '2025-09-20'::date, 1, 36, 0, 0, 0, false, 78, 2800, 0, 'в Давыдов на Карла Маркса', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9163108629%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1043, c.id, 'new', '2025-09-23'::date, '2025-09-23'::date, 1, 41, 0, 0, 0, false, 78, 3200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1042, c.id, 'new', '2025-09-20'::date, '2025-09-20'::date, 1, 44, 0, 0, 0, false, 78, 3440, 0, 'Вернула в офис', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869297050%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1041, c.id, 'new', '2025-10-08'::date, '2025-10-08'::date, 1, 48, 0, 0, 0, false, 78, 3760, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1040, c.id, 'new', '2025-09-20'::date, '2025-09-20'::date, 1, 306, 0, 0, 0, false, 82, 25000, 0, '6 групп по 50, привезти в деревню универсиады к 14:00 Забрать от Кремля в 16:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179221193%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1039, c.id, 'new', '2025-09-20'::date, '2025-09-20'::date, 1, 22, 0, 0, 0, false, 76, 1680, 0, 'Заберет утром от свита холла Гид оставит сумку 20 сентября к 16:00 в офисе ТИЦ на Баумана, 49. Гид Серов Алексей +7 917 255-38-26', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1038, c.id, 'new', '2025-09-20'::date, '2025-09-21'::date, 2, 35, 0, 0, 0, false, 94, 6600, 0, 'Оставили в кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1037, c.id, 'new', '2025-10-10'::date, '2025-10-11'::date, 2, 36, 0, 0, 0, false, 78, 5600, 0, 'Отказ,', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9168133609%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1036, c.id, 'new', '2026-01-05'::date, '2026-01-05'::date, 1, 50, 0, 0, 0, false, 100, 0, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9127740429%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1035, c.id, 'new', '2026-01-03'::date, '2026-01-03'::date, 1, 50, 0, 0, 0, false, 100, 0, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9127740429%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1034, c.id, 'new', '2025-10-04'::date, '2025-10-05'::date, 2, 46, 0, 0, 0, false, 68, 6240, 0, '46 приемников и 88 наушников', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9276703000%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1033, c.id, 'new', '2025-09-20'::date, '2025-09-20'::date, 1, 26, 0, 0, 0, false, 77, 2000, 0, 'От Сафара в Корстон', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1032, c.id, 'new', '2025-09-20'::date, '2025-09-20'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'От корстона в Корстон', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1031, c.id, 'new', '2025-09-17'::date, '2025-09-18'::date, 2, 44, 0, 0, 0, false, 76, 6720, 0, 'В офис к 10, забрать 18 до 19:00 Ответственным лицом будет представитель Госкомитета РТ - Анастасия Софьина +7 904 765-52-93 Мен Камилла', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1030, c.id, 'new', '2025-09-16'::date, '2025-09-16'::date, 1, 16, 0, 0, 0, false, 104, 1670, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1029, c.id, 'new', '2025-09-17'::date, '2025-09-18'::date, 2, 32, 0, 0, 0, false, 75, 4800, 0, 'Заберет в 9.30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1027, c.id, 'new', '2025-09-17'::date, '2025-09-17'::date, 1, 35, 0, 0, 0, false, 78, 2720, 0, 'В офис Гид любовь, мен полина', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1026, c.id, 'new', '2025-09-20'::date, '2025-09-20'::date, 1, 42, 0, 0, 0, false, 78, 3280, 0, 'Заберут 19 числа вечером.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872797484%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1025, c.id, 'new', '2025-09-18'::date, '2025-09-19'::date, 2, 27, 0, 0, 0, false, 74, 4000, 0, 'Биляр. Игорь. 89274055070 Вернут в Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1024, c.id, 'new', '2025-09-15'::date, '2025-09-16'::date, 2, 29, 0, 0, 0, false, 74, 4320, 0, 'Игорь. 89274055070', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1023, c.id, 'new', '2026-01-01'::date, '2026-01-02'::date, 2, 50, 0, 0, 0, false, 96, 9600, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9272534202%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1022, c.id, 'new', '2025-09-14'::date, '2025-09-14'::date, 1, 46, 0, 0, 0, false, 78, 3600, 0, 'В Раймонд Аида +7 903 344-08-99', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9043349504%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1021, c.id, 'new', '2025-09-13'::date, '2025-09-14'::date, 1, 42, 0, 0, 0, false, 156, 6560, 0, 'Сами заберут', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9050249197%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1020, c.id, 'new', '2025-09-18'::date, '2025-09-20'::date, 3, 38, 0, 0, 0, false, 76, 8640, 0, 'Светлана +79677800066 В кафе Азу на Чернышевского до 15:30 Вернет в Азимут (ибис) 21 утром', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1019, c.id, 'new', '2025-09-19'::date, '2025-09-21'::date, 3, 49, 0, 0, 0, false, 77, 11280, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1018, c.id, 'new', '2025-09-12'::date, '2025-09-12'::date, 1, 22, 0, 0, 0, false, 153, 3360, 0, 'Азу. Петербургская 52', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1017, c.id, 'new', '2025-09-16'::date, '2025-09-19'::date, 4, 59, 0, 0, 0, false, 75, 17600, 0, '55шт двойной комплект наушников', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9042786414%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1016, c.id, 'new', '2025-09-13'::date, '2025-09-13'::date, 1, 31, 0, 0, 0, false, 77, 2400, 0, 'В АйТи парк на спартаковской 12.09 в', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9061135111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1015, c.id, 'new', '2025-09-12'::date, '2025-09-13'::date, 2, 22, 0, 0, 0, false, 73, 3200, 0, 'Кристал, Диана', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1014, c.id, 'new', '2025-09-12'::date, '2025-09-14'::date, 3, 38, 0, 0, 0, false, 76, 8640, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

-- SKIP order 1012: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1011, c.id, 'new', '2025-09-12'::date, '2025-09-14'::date, 3, 36, 0, 0, 0, false, 76, 8160, 0, 'Кристал. Разина', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9272534202%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1010, c.id, 'new', '2025-09-12'::date, '2025-09-12'::date, 1, 43, 0, 0, 0, false, 98, 4200, 0, 'В отель Давыдов на назарбаева, вечером 11.09, забрать можно 12 вечером', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9264062333%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1009, c.id, 'new', '2025-09-12'::date, '2025-09-14'::date, 3, 34, 0, 0, 0, false, 71, 7200, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046623179%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1008, c.id, 'new', '2025-09-12'::date, '2025-09-12'::date, 1, 183, 0, 0, 0, false, 79, 14400, 0, '180шт + доп наушники, 3 сумки по 60шт 11.09 заберут от часов в 13:30 13.09 вернут', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9171208622%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1007, c.id, 'new', '2025-09-11'::date, '2025-09-11'::date, 1, 102, 0, 0, 0, false, 78, 8000, 0, 'В офис тиц к вечеру 10.09 Вернут 11.09 к вечеру , две сумки по 50', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1006, c.id, 'new', '2025-09-12'::date, '2025-09-14'::date, 3, 39, 0, 0, 0, false, 76, 8880, 0, 'Начало от Релиты, 12 сентября радиогиды должны там быть к 12.30. А вернут их в Стерлядку 14 сентября к 16.00.', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1005, c.id, 'new', '2025-09-09'::date, '2025-09-09'::date, 1, 24, 0, 0, 0, false, 77, 1840, 0, 'К 10 в офис, гид Алексей, вернут к 19', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1004, c.id, 'new', '2025-09-06'::date, '2025-09-06'::date, 1, 45, 0, 0, 0, false, 78, 3520, 0, 'В офис тиц к 10:00, забрать до 19:00 Гид Алиса Мен Камилла', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1003, c.id, 'new', '2025-09-05'::date, '2025-09-06'::date, 2, 14, 0, 0, 0, false, 86, 2400, 0, 'Из фургончика заберет 18:00. Наушников положить 33 шт', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9510610028%' LIMIT 1;

-- SKIP order 1002: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1001, c.id, 'new', '2025-09-10'::date, '2025-09-12'::date, 3, 32, 0, 0, 0, false, 75, 7200, 0, 'Кристал до 12:00, Владлена', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9222673014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 1000, c.id, 'new', '2025-09-06'::date, '2025-09-06'::date, 1, 51, 0, 0, 0, false, 69, 3500, 0, 'Зебурт 5 вечером', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 999, c.id, 'new', '2025-09-06'::date, '2025-09-06'::date, 1, 54, 0, 0, 0, false, 79, 4240, 0, 'Заберет утром', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9272408250%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 998, c.id, 'new', '2025-09-02'::date, '2025-09-02'::date, 1, 12, 0, 0, 0, false, 73, 880, 0, 'Заберет', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9510610028%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 997, c.id, 'new', '2025-09-02'::date, '2025-09-02'::date, 1, 23, 0, 0, 0, false, 77, 1760, 0, 'В кристалл для Фирузы', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9108272699%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 996, c.id, 'new', '2025-09-06'::date, '2025-09-06'::date, 1, 58, 0, 0, 0, false, 77, 4480, 0, 'Две сумки на 28шт В рамаду, забрать там же', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9196862442%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 995, c.id, 'new', '2025-09-01'::date, '2025-09-01'::date, 1, 39, 0, 0, 0, false, 148, 5760, 0, 'Сами заберу.т Двойной комплект наушников, днем группа 38 человек, вечером 35', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 994, c.id, 'new', '2025-08-29'::date, '2025-08-30'::date, 2, 26, 0, 0, 0, false, 74, 3840, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 993, c.id, 'new', '2025-09-01'::date, '2025-09-01'::date, 1, 97, 0, 0, 0, false, 78, 7520, 0, 'Сумки на 33, 28, 33шт Заберут сами около 10', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9042786414%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 992, c.id, 'new', '2025-09-12'::date, '2025-09-12'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, 'Корстон. Номер 1807', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9262332196%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 990, c.id, 'new', '2025-08-29'::date, '2025-08-30'::date, 2, 48, 0, 0, 0, false, 77, 7360, 0, '29-30 августа надо 46 радиогидов в кристалл к 7.30 гид Аида 89520385698', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 989, c.id, 'new', '2025-08-30'::date, '2025-08-30'::date, 1, 40, 0, 0, 0, false, 88, 3500, 0, 'Отправить утром в Новинку', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 988, c.id, 'new', '2025-10-25'::date, '2025-10-25'::date, 1, 306, 0, 0, 0, false, 78, 24000, 0, '6 сумок по 51. Старт от Лучано с Островского в 13:30 передать', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274463215%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 987, c.id, 'new', '2025-09-07'::date, '2025-09-07'::date, 1, 35, 0, 0, 0, false, 68, 2380, 0, 'Уточнить', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 986, c.id, 'new', '2025-08-28'::date, '2025-08-28'::date, 1, 13, 0, 0, 0, false, 92, 1200, 0, 'Оставить в офисе Вернет в Шаляпин', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9534837004%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 985, c.id, 'new', '2025-10-31'::date, '2025-11-03'::date, 4, 29, 0, 0, 0, false, 67, 7800, 0, 'Краснодар 4 До 14, кафе мед Оставили в кристалле!', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 984, c.id, 'new', '2025-10-26'::date, '2025-10-27'::date, 2, 41, 0, 0, 0, false, 76, 6240, 0, 'Марина Трэвел Юлия НАЛ ВЕРНУТ В ОФИС ИНИЦ 28.10 в 10:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 983, c.id, 'new', '2025-10-26'::date, '2025-10-28'::date, 3, 46, 0, 0, 0, false, 73, 10120, 0, 'Арапова В кристалл до 11:00 нал ВЕРНУТ В КРИСТАЛЛ ПОСЛЕ 22:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 982, c.id, 'new', '2025-10-25'::date, '2025-10-26'::date, 2, 55, 0, 0, 0, false, 77, 8480, 0, 'Марина Трэвел Олеся В кристалл, нал', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 981, c.id, 'new', '2025-10-27'::date, '2025-10-29'::date, 3, 52, 0, 0, 0, false, 74, 11500, 0, 'ЮВА 3 В кристалл до 11:00, нал ВЕРНУТ в КРИСТАЛЛ ПОСЛЕ 22:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 980, c.id, 'new', '2025-10-25'::date, '2025-10-27'::date, 3, 52, 0, 0, 0, false, 74, 11500, 0, 'ЮВА 2 ВЕРНУТ В кристалл ПОСЛЕ 22:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 979, c.id, 'new', '2025-10-25'::date, '2025-10-27'::date, 3, 51, 0, 0, 0, false, 106, 16270, 0, 'ЮВА 1 ВЕРНУТ В крисстал ПОСЛЕ 22:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 978, c.id, 'new', '2025-10-27'::date, '2025-10-31'::date, 5, 26, 0, 0, 0, false, 65, 8510, 0, 'Краснодар 3 До 14, кафе мед', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 977, c.id, 'new', '2025-10-27'::date, '2025-10-31'::date, 5, 44, 0, 0, 0, false, 69, 15170, 0, 'Краснодар 2 До 14, кафе мед', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 976, c.id, 'new', '2025-10-27'::date, '2025-10-31'::date, 5, 50, 0, 0, 0, false, 70, 17390, 0, 'Краснодар 1 До 14, кафе мед', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 975, c.id, 'new', '2025-10-23'::date, '2025-10-27'::date, 5, 46, 0, 0, 0, false, 69, 15910, 0, 'Краснодар 0 НАЛ ВНРНУТ В КРИСТАЛЛ ПОСЛЕ 13:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 974, c.id, 'new', '2025-08-30'::date, '2025-08-30'::date, 1, 25, 0, 0, 0, false, 64, 1600, 0, 'От Сафара в Корстон', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 973, c.id, 'new', '2025-08-30'::date, '2025-08-30'::date, 1, 32, 0, 0, 0, false, 78, 2480, 0, 'От релиты до релиты', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 972, c.id, 'new', '2025-09-28'::date, '2025-10-01'::date, 4, 38, 0, 0, 0, false, 57, 8700, 0, 'В офисе Инициативы', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 971, c.id, 'new', '2025-09-20'::date, '2025-09-20'::date, 1, 47, 0, 0, 0, false, 78, 3680, 0, 'В офисе', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 970, c.id, 'new', '2025-08-29'::date, '2025-09-01'::date, 4, 36, 0, 0, 0, false, 73, 10560, 0, 'Заберет 28.08 в 19:30 4 комплекта наушников', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9376252850%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 969, c.id, 'new', '2025-08-27'::date, '2025-08-27'::date, 1, 27, 0, 0, 0, false, 77, 2080, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 968, c.id, 'new', '2025-08-27'::date, '2025-08-28'::date, 2, 33, 0, 0, 0, false, 75, 4960, 0, 'Заберет утром в 10:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 967, c.id, 'new', '2025-08-26'::date, '2025-08-26'::date, 1, 11, 0, 0, 0, false, 73, 800, 0, 'Заберут в 17:30 примерно', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600565131%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 966, c.id, 'new', '2025-08-28'::date, '2025-08-28'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, 'В офис тиц 27.08, вернут 29.08', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 965, c.id, 'new', '2025-08-27'::date, '2025-08-27'::date, 1, 153, 0, 0, 0, false, 78, 12000, 0, 'В офис 26.08, вернут 28.08 Три сумки по 50', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 964, c.id, 'new', '2025-08-25'::date, '2025-08-25'::date, 1, 40, 0, 0, 0, false, 78, 3120, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 963, c.id, 'new', '2025-08-23'::date, '2025-08-23'::date, 1, 48, 0, 0, 0, false, 78, 3760, 0, 'В АйТи парке', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9163108629%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 962, c.id, 'new', '2025-08-23'::date, '2025-08-24'::date, 2, 38, 0, 0, 0, false, 76, 5760, 0, 'В Кристалле', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 961, c.id, 'new', '2025-08-22'::date, '2025-08-22'::date, 1, 150, 0, 0, 0, false, 80, 12000, 0, 'Утром заберут', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274163395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 960, c.id, 'new', '2025-08-30'::date, '2025-08-30'::date, 1, 35, 0, 0, 0, false, 78, 2720, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9068185524%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 959, c.id, 'new', '2025-08-22'::date, '2025-08-23'::date, 2, 41, 0, 0, 0, false, 76, 6240, 0, 'Заберет утром Владимир 89178858409', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 958, c.id, 'new', '2025-08-21'::date, '2025-08-21'::date, 1, 10, 0, 0, 0, false, 80, 800, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9510610028%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 957, c.id, 'new', '2025-09-16'::date, '2025-09-19'::date, 3, 29, 0, 0, 0, false, 74, 6480, 0, 'Сулейман до 15:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 956, c.id, 'new', '2025-08-22'::date, '2025-08-22'::date, 1, 140, 0, 0, 0, false, 80, 11200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178844225%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 955, c.id, 'new', '2025-08-21'::date, '2025-08-23'::date, 3, 30, 0, 0, 0, false, 93, 8400, 0, 'В кристалe', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 954, c.id, 'new', '2025-08-21'::date, '2025-08-23'::date, 3, 20, 0, 0, 0, false, 72, 4320, 0, '18+ человек в Кристалл к 10 ч. На 3 или 4 дня. Гид Ирина 89046620732 Вернули в парк отель', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 953, c.id, 'new', '2025-08-24'::date, '2025-08-24'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'В стерлядке', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 952, c.id, 'new', '2025-08-22'::date, '2025-08-24'::date, 3, 51, 0, 0, 0, false, 77, 11760, 0, 'В Кристалле', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 951, c.id, 'new', '2025-08-20'::date, '2025-08-20'::date, 1, 14, 0, 0, 0, false, 74, 1040, 0, 'Заберут', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600565131%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 950, c.id, 'new', '2025-08-22'::date, '2025-08-23'::date, 2, 32, 0, 0, 0, false, 75, 4800, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869297050%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 949, c.id, 'new', '2025-08-19'::date, '2025-08-21'::date, 3, 45, 0, 0, 0, false, 45, 6020, 0, 'Утром отправить в добрую столовую', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

-- SKIP order 948: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 947, c.id, 'new', '2025-08-18'::date, '2025-08-18'::date, 1, 100, 0, 0, 0, false, 320, 32000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274163395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 946, c.id, 'new', '2025-08-22'::date, '2025-08-22'::date, 1, 56, 0, 0, 0, false, 79, 4400, 0, 'Заберут вечером 21.08', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600501515%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 945, c.id, 'new', '2025-08-18'::date, '2025-08-18'::date, 1, 26, 0, 0, 0, false, 74, 1920, 0, '2 сумки по 12шт, в офис 18.08 к 10:00, Вернут вечером до 19:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 944, c.id, 'new', '2025-08-15'::date, '2025-08-16'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, 'В офис к 10:00, 15.08, двойной комплект наушников, Вернут 17.08 до 12:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

-- SKIP order 943: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 942, c.id, 'new', '2025-08-23'::date, '2025-08-24'::date, 2, 33, 0, 0, 0, false, 75, 4960, 0, 'Заберут утром', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9036945019%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 941, c.id, 'new', '2025-08-14'::date, '2025-08-14'::date, 1, 11, 0, 0, 0, false, 73, 800, 0, 'Вернут в Кристал после 20:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9510610028%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 940, c.id, 'new', '2025-08-16'::date, '2025-08-17'::date, 2, 48, 0, 0, 0, false, 77, 7360, 0, 'В Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 939, c.id, 'new', '2025-08-23'::date, '2025-08-24'::date, 2, 53, 0, 0, 0, false, 77, 8160, 0, 'В Волгe', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9225115900%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 938, c.id, 'new', '2025-08-15'::date, '2025-08-17'::date, 3, 51, 0, 0, 0, false, 77, 11760, 0, 'В кристалл Оставила в кристалле', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 937, c.id, 'new', '2025-08-16'::date, '2025-08-16'::date, 1, 16, 0, 0, 0, false, 75, 1200, 0, 'В Сулейман, вернут туда же', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 936, c.id, 'new', '2025-08-15'::date, '2025-08-16'::date, 2, 38, 0, 0, 0, false, 63, 4800, 0, 'От амакса в Корстон около 20:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 935, c.id, 'new', '2025-08-30'::date, '2025-08-30'::date, 1, 47, 0, 0, 0, false, 78, 3680, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 934, c.id, 'new', '2025-08-16'::date, '2025-08-16'::date, 1, 40, 0, 0, 0, false, 78, 3120, 0, ', будет забирать +7 927 240-82-50 Лариса', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9006000057%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 933, c.id, 'new', '2025-08-16'::date, '2025-08-16'::date, 1, 56, 0, 0, 0, false, 157, 8800, 0, 'Пушкина 8. В 8:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393902610%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 932, c.id, 'new', '2025-08-13'::date, '2025-08-13'::date, 1, 43, 0, 0, 0, false, 156, 6720, 0, 'Акварель хостел', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9377745735%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 931, c.id, 'new', '2025-08-13'::date, '2025-08-13'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'Утром в 8 у Часов Вернут в реч порт, Эдику', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9226624712%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 930, c.id, 'new', '2025-08-13'::date, '2025-08-14'::date, 2, 48, 0, 0, 0, false, 77, 7360, 0, 'В офис 13.08 к 10, вернут 15.08 до 12:00 Гид Диана', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 929, c.id, 'new', '2025-08-12'::date, '2025-08-14'::date, 3, 18, 0, 0, 0, false, 71, 3840, 0, 'В офис тиц 12.08 в 10:15', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 928, c.id, 'new', '2025-08-15'::date, '2025-08-17'::date, 3, 49, 0, 0, 0, false, 77, 11280, 0, 'Заберет утром Оставила в бусике', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 927, c.id, 'new', '2025-08-13'::date, '2025-08-14'::date, 2, 46, 0, 0, 0, false, 77, 7040, 0, 'Заберет утром', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 926, c.id, 'new', '2025-08-10'::date, '2025-08-10'::date, 1, 9, 0, 0, 0, false, 71, 640, 0, 'В офис тиц в 10:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 925, c.id, 'new', '2025-08-08'::date, '2025-08-09'::date, 2, 40, 0, 0, 0, false, 78, 6240, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9068185524%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 924, c.id, 'new', '2025-08-11'::date, '2025-08-11'::date, 1, 65, 0, 0, 0, false, 78, 5040, 0, '1 на 36 Ильмира; 2 на 27 Алсу, занеси накануне', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 923, c.id, 'new', '2025-08-09'::date, '2025-08-09'::date, 1, 20, 0, 0, 0, false, 76, 1520, 0, 'Сама заберет и вернет Экскурсия с 10:30 до 15:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274662530%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 922, c.id, 'new', '2025-08-09'::date, '2025-08-10'::date, 2, 44, 0, 0, 0, false, 76, 6720, 0, 'В кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 921, c.id, 'new', '2025-08-08'::date, '2025-08-08'::date, 1, 45, 0, 0, 0, false, 78, 3520, 0, 'В кристалл, Мария Вернула в кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 920, c.id, 'new', '2025-08-08'::date, '2025-08-10'::date, 3, 49, 0, 0, 0, false, 77, 11280, 0, 'В кристалл, сопровождающий Ирина', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 919, c.id, 'new', '2025-08-19'::date, '2025-08-19'::date, 1, 49, 0, 0, 0, false, 78, 3840, 0, 'В кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9108272699%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 918, c.id, 'new', '2025-08-08'::date, '2025-08-10'::date, 3, 35, 0, 0, 0, false, 75, 7920, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9625552796%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 917, c.id, 'new', '2025-08-07'::date, '2025-08-07'::date, 1, 15, 0, 0, 0, false, 65, 980, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 916, c.id, 'new', '2025-08-17'::date, '2025-08-17'::date, 1, 38, 0, 0, 0, false, 68, 2590, 0, 'В волгу Оставила в бусике', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 915, c.id, 'new', '2025-08-09'::date, '2025-08-09'::date, 1, 33, 0, 0, 0, false, 78, 2560, 0, 'От Сафара до корстона', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 914, c.id, 'new', '2025-08-09'::date, '2025-08-09'::date, 1, 40, 0, 0, 0, false, 78, 3120, 0, 'От релиты до релиты', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 913, c.id, 'new', '2025-08-06'::date, '2025-08-06'::date, 1, 35, 0, 0, 0, false, 78, 2720, 0, 'В 12:00 в трапезную', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872969542%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 912, c.id, 'new', '2025-09-13'::date, '2025-09-13'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, 'Созвониться', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9530225627%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 911, c.id, 'new', '2025-08-08'::date, '2025-08-08'::date, 1, 45, 0, 0, 0, false, 78, 3520, 0, 'Волга', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 909, c.id, 'new', '2025-08-11'::date, '2025-08-11'::date, 1, 138, 0, 0, 0, false, 78, 10800, 0, '2 сумки по 50, Нурия и Светлана 1 сумка на 35, Диляра В офис тиц 10. 08 до вечера', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 908, c.id, 'new', '2025-08-11'::date, '2025-08-13'::date, 3, 47, 0, 0, 0, false, 77, 10800, 0, 'Сами заберут 11.08 Гид Катя Кореева Вернут в отель Европа', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 907, c.id, 'new', '2025-08-07'::date, '2025-08-07'::date, 1, 46, 0, 0, 0, false, 78, 3600, 0, 'В офис 6 Гид Светлана +79677800066', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 906, c.id, 'new', '2025-09-20'::date, '2025-09-20'::date, 1, 20, 0, 0, 0, false, 76, 1520, 0, 'Заберут после 11:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 905, c.id, 'new', '2025-08-03'::date, '2025-08-03'::date, 1, 39, 0, 0, 0, false, 78, 3040, 0, 'Заберут утром у часов, вернут в порт кому-нибудь', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9226624712%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 904, c.id, 'new', '2025-08-01'::date, '2025-08-03'::date, 3, 45, 0, 0, 0, false, 76, 10320, 0, 'В кристал', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 903, c.id, 'new', '2025-08-23'::date, '2025-08-23'::date, 1, 41, 0, 0, 0, false, 78, 3200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9063310993%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 902, c.id, 'new', '2025-08-08'::date, '2025-08-09'::date, 2, 41, 0, 0, 0, false, 76, 6240, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869297050%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 901, c.id, 'new', '2025-08-02'::date, '2025-08-02'::date, 1, 48, 0, 0, 0, false, 78, 3760, 0, 'Вечером перед вечер кой заберет Ирина Савельева', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9530225627%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 900, c.id, 'new', '2025-08-01'::date, '2025-08-03'::date, 3, 45, 0, 0, 0, false, 75, 10080, 0, 'В мвияжск передать', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 899, c.id, 'new', '2025-08-01'::date, '2025-08-03'::date, 3, 54, 0, 0, 0, false, 74, 12000, 0, 'Сама заберет утром', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 898, c.id, 'new', '2025-07-30'::date, '2025-07-31'::date, 2, 48, 0, 0, 0, false, 77, 7360, 0, 'Сама заберет в 10:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 897, c.id, 'new', '2025-08-12'::date, '2025-08-14'::date, 3, 32, 0, 0, 0, false, 68, 6480, 0, 'Группа 21 на 3 дня и группа 9 на 2 дня В кристалл 11.08 вечером', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 896, c.id, 'new', '2025-08-03'::date, '2025-08-03'::date, 1, 41, 0, 0, 0, false, 78, 3200, 0, 'От Релита до Ногая', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 895, c.id, 'new', '2025-07-28'::date, '2025-07-28'::date, 1, 211, 0, 0, 0, false, 78, 16480, 0, '4 сумки по 49+1 1 сумка по 10+1 (Наталья) В офис тиц до 10:30, вернут 29.07 до 12:00 Ильмира, Яна, Инна, (Надия кристалл ) до 13:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 894, c.id, 'new', '2025-08-01'::date, '2025-08-02'::date, 2, 29, 0, 0, 0, false, 74, 4320, 0, 'Заберет гид Ольга вечером или утром', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9196862442%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 893, c.id, 'new', '2025-07-27'::date, '2025-07-27'::date, 1, 62, 0, 0, 0, false, 77, 4800, 0, 'Гид Лариса на Баумана 49, 26.07 до 17:00 на 50шт Гид Гульнара на Баумана 49, 26.07 до 17:00 на 10шт Вернут 27.07 до 19:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 892, c.id, 'new', '2025-07-27'::date, '2025-07-28'::date, 2, 104, 0, 0, 0, false, 77, 16000, 0, 'Гид Ванда в кристалл 26.07 до 20:00 на 50шт +2!!! Запасных(так как 2 дня) +двойной комплект наушников Гид Вероника в кристалл 26.07 до 20:00 на 50шт +2!!! Запасных(так как 2 дня) +двойной комплект наушников Вернут 29.07 до 12:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 891, c.id, 'new', '2025-07-27'::date, '2025-07-27'::date, 1, 153, 0, 0, 0, false, 78, 12000, 0, 'Гид Алексей на Баумана 49, 26.07 до 17:00, 50 радиогидов Гид Елена в Кристалл, 26.07 вечером, 50 радиогидов Гид Ирина на Баумана 49, 26.07 до 17:00, 50 радиогидов Вернут 27.07 до 19:00 в офис ТИЦ', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 890, c.id, 'new', '2025-07-28'::date, '2025-07-28'::date, 1, 37, 0, 0, 0, false, 78, 2880, 0, 'Регину на университетской к 8', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9050249197%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 889, c.id, 'new', '2025-08-02'::date, '2025-08-02'::date, 1, 46, 0, 0, 0, false, 78, 3600, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 888, c.id, 'new', '2025-07-31'::date, '2025-07-31'::date, 1, 38, 0, 0, 0, false, 76, 2880, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

-- SKIP order 887: no phone
-- SKIP order 886: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 885, c.id, 'new', '2025-07-25'::date, '2025-07-25'::date, 1, 33, 0, 0, 0, false, 153, 5040, 0, 'Заберет утром', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172788430%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 884, c.id, 'new', '2025-07-26'::date, '2025-07-26'::date, 1, 36, 0, 0, 0, false, 78, 2800, 0, 'Владимир', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9068185524%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 883, c.id, 'new', '2025-08-04'::date, '2025-08-04'::date, 1, 15, 0, 0, 0, false, 75, 1120, 0, 'Корстон', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 882, c.id, 'new', '2025-07-26'::date, '2025-07-26'::date, 1, 41, 0, 0, 0, false, 68, 2800, 0, 'Заберут вечером 25 числа', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 881, c.id, 'new', '2025-07-26'::date, '2025-07-27'::date, 2, 28, 0, 0, 0, false, 74, 4160, 0, 'В азалию', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9220064070%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 880, c.id, 'new', '2025-07-26'::date, '2025-07-27'::date, 2, 43, 0, 0, 0, false, 76, 6560, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 879, c.id, 'new', '2025-07-25'::date, '2025-07-25'::date, 1, 266, 0, 0, 0, false, 78, 20800, 0, '5 сумок по 50, гид Елена, Алексей, Инна, Яна, Ванда 1 сумка на 10 Диляра В офис тиц к 10:30 Вернут до 19:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 878, c.id, 'new', '2025-08-05'::date, '2025-08-05'::date, 1, 48, 0, 0, 0, false, 77, 3680, 0, 'Кристал Два микрофона и передатчика', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9108272699%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 877, c.id, 'new', '2025-07-26'::date, '2025-07-26'::date, 1, 24, 0, 0, 0, false, 77, 1840, 0, 'От Сафара в Сулейман', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 876, c.id, 'new', '2025-07-25'::date, '2025-07-26'::date, 2, 35, 0, 0, 0, false, 71, 4960, 0, 'От Сафара в релиту в районе 20:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 875, c.id, 'new', '2025-07-24'::date, '2025-07-24'::date, 1, 136, 0, 0, 0, false, 76, 10400, 0, '4 сумки по 22 и 2 по 21', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9376252850%' LIMIT 1;

-- SKIP order 874: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 873, c.id, 'new', '2025-07-25'::date, '2025-07-27'::date, 3, 49, 0, 0, 0, false, 77, 11280, 0, 'В Кристал', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 872, c.id, 'new', '2025-07-22'::date, '2025-07-22'::date, 1, 13, 0, 0, 0, false, 74, 960, 0, 'Хилтон. На имя Татьяна', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 871, c.id, 'new', '2025-07-28'::date, '2025-07-28'::date, 1, 50, 0, 0, 0, false, 100, 5000, 0, '27 заберут вечером Две сумки по 25шт', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9506781207%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 870, c.id, 'new', '2025-07-21'::date, '2025-07-21'::date, 1, 43, 0, 0, 0, false, 78, 3360, 0, 'В Татарстан к 8 Вернут туда же в 15:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9050249197%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 869, c.id, 'new', '2025-07-20'::date, '2025-07-22'::date, 3, 17, 0, 0, 0, false, 71, 3600, 0, 'В Фатиму', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 868, c.id, 'new', '2025-07-19'::date, '2025-07-20'::date, 2, 70, 0, 0, 0, false, 78, 10880, 0, 'Сумки на 32 и 36 В Релиту на имя Эльзы +7 904 717-59-99', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178533525%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 867, c.id, 'new', '2025-07-22'::date, '2025-07-24'::date, 3, 52, 0, 0, 0, false, 77, 12000, 0, 'В марриот 21.07', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9032182869%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 866, c.id, 'new', '2025-07-18'::date, '2025-07-18'::date, 1, 15, 0, 0, 0, false, 93, 1400, 0, 'В офис', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9534837004%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 865, c.id, 'new', '2025-07-18'::date, '2025-07-18'::date, 1, 45, 0, 0, 0, false, 78, 3520, 0, 'Группа Марии', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 864, c.id, 'new', '2025-07-18'::date, '2025-07-20'::date, 3, 34, 0, 0, 0, false, 75, 7680, 0, 'Группа Ирины Вернули в кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 863, c.id, 'new', '2025-07-18'::date, '2025-07-20'::date, 3, 44, 0, 0, 0, false, 76, 10080, 0, 'Группа Кати Вернули в кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 862, c.id, 'new', '2025-09-06'::date, '2025-09-06'::date, 1, 44, 0, 0, 0, false, 78, 3440, 0, 'Кристал, Лейла', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9027805858%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 861, c.id, 'new', '2025-07-18'::date, '2025-07-18'::date, 1, 90, 0, 0, 0, false, 78, 7040, 0, 'Две сумки по 44шт В Тиц 17.07 до 17:00 Вернут 18.07 до 19:00 1) Гид Серов Алексей +7 917 255-38-26 2) Гид Елена Яхъяева +7 927 401-58-22', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 860, c.id, 'new', '2025-07-19'::date, '2025-07-19'::date, 1, 44, 0, 0, 0, false, 78, 3440, 0, 'В Сафар, вернут в корстон', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 859, c.id, 'new', '2025-07-18'::date, '2025-07-18'::date, 1, 71, 0, 0, 0, false, 69, 4900, 0, 'Заберут 17', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 858, c.id, 'new', '2025-07-19'::date, '2025-07-19'::date, 1, 44, 0, 0, 0, false, 78, 3440, 0, 'От релита вернут в релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 857, c.id, 'new', '2025-07-17'::date, '2025-07-17'::date, 1, 28, 0, 0, 0, false, 77, 2160, 0, 'В здание присутсвеныхх мест 16.07 до 20:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172914815%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 856, c.id, 'new', '2025-07-17'::date, '2025-07-19'::date, 3, 24, 0, 0, 0, false, 92, 6600, 0, 'В татарскую усадьбу не ресепшен', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 855, c.id, 'new', '2025-07-15'::date, '2025-07-17'::date, 3, 47, 0, 0, 0, false, 67, 9450, 0, 'Доставка', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 854, c.id, 'new', '2025-07-16'::date, '2025-07-17'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, 'Сама заберет утром в 10:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 853, c.id, 'new', '2025-07-25'::date, '2025-07-26'::date, 2, 39, 0, 0, 0, false, 76, 5920, 0, 'Заберет утром', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869297050%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 852, c.id, 'new', '2025-07-12'::date, '2025-07-12'::date, 1, 11, 0, 0, 0, false, 73, 800, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600565131%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 851, c.id, 'new', '2025-07-12'::date, '2025-07-12'::date, 1, 33, 0, 0, 0, false, 78, 2560, 0, 'В тасиго нео. На имя Валерия Матросова', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 850, c.id, 'new', '2025-07-11'::date, '2025-07-11'::date, 1, 29, 0, 0, 0, false, 77, 2240, 0, 'Добрый вечер, Леонид. На 11 июля надо на 28 чел. Радио гиды к 9.45 До вечера. Гид Ирина Палей +7 904 662-07-32. в А матти М. Джалиля1 Оставила в кристалле!', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 849, c.id, 'new', '2025-07-12'::date, '2025-07-13'::date, 2, 52, 0, 0, 0, false, 77, 8000, 0, 'Уточнить', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9625552796%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 848, c.id, 'new', '2025-07-10'::date, '2025-07-10'::date, 1, 16, 0, 0, 0, false, 75, 1200, 0, 'Заберет', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9397368972%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 847, c.id, 'new', '2025-07-11'::date, '2025-07-11'::date, 1, 35, 0, 0, 0, false, 78, 2720, 0, 'В амакс Сафар, вернут в корстон', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 846, c.id, 'new', '2025-07-22'::date, '2025-07-22'::date, 1, 46, 0, 0, 0, false, 77, 3520, 0, 'Крсталл С группой наш сотрудник Елена 89277678701', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9108272699%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 845, c.id, 'new', '2025-07-12'::date, '2025-07-12'::date, 1, 41, 0, 0, 0, false, 78, 3200, 0, 'Уточнить', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9063310993%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 844, c.id, 'new', '2025-07-12'::date, '2025-07-12'::date, 1, 46, 0, 0, 0, false, 78, 3600, 0, 'Сумка в Мано', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 843, c.id, 'new', '2025-07-12'::date, '2025-07-12'::date, 1, 53, 0, 0, 0, false, 78, 4160, 0, 'Заберут', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9006000057%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 842, c.id, 'new', '2025-07-11'::date, '2025-07-13'::date, 3, 40, 0, 0, 0, false, 76, 9120, 0, 'Заберут 10 в течение дня', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 841, c.id, 'new', '2025-07-11'::date, '2025-07-13'::date, 3, 49, 0, 0, 0, false, 77, 11280, 0, 'Кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 840, c.id, 'new', '2025-07-09'::date, '2025-07-09'::date, 1, 24, 0, 0, 0, false, 77, 1840, 0, 'В релиту, вернут в кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 839, c.id, 'new', '2025-07-19'::date, '2025-07-19'::date, 1, 53, 0, 0, 0, false, 78, 4160, 0, '18.07 в офис, забрать 20.07 Гид: Алексей Серов +7 917 255-38-26', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 838, c.id, 'new', '2025-07-05'::date, '2025-07-05'::date, 1, 31, 0, 0, 0, false, 80, 2480, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172891133%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 837, c.id, 'new', '2025-07-05'::date, '2025-07-05'::date, 1, 22, 0, 0, 0, false, 76, 1680, 0, 'В Тиц до 10:30 Вернут до 19:00 в Тиц Мен Камилла Гид Эльвира +7 917 228-93-99', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 835, c.id, 'new', '2025-07-05'::date, '2025-07-06'::date, 2, 36, 0, 0, 0, false, 76, 5440, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9068185524%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 834, c.id, 'new', '2025-07-04'::date, '2025-07-05'::date, 2, 33, 0, 0, 0, false, 73, 4800, 0, 'Петербуржская 52', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 833, c.id, 'new', '2025-07-04'::date, '2025-07-05'::date, 2, 41, 0, 0, 0, false, 76, 6240, 0, '4-5 июня 39 человек. Нужны радиогидв. Гид Ирина 89046620732', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 832, c.id, 'new', '2025-07-04'::date, '2025-07-06'::date, 3, 46, 0, 0, 0, false, 77, 10560, 0, 'В кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 831, c.id, 'new', '2025-07-07'::date, '2025-07-09'::date, 3, 19, 0, 0, 0, false, 72, 4080, 0, 'в офис 07.07 с 9:00 до 12:30?', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869160808%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 830, c.id, 'new', '2025-07-16'::date, '2025-07-17'::date, 2, 55, 0, 0, 0, false, 96, 10600, 0, 'В 8 утра в алтын куль Гид Марина 8917 288-90-13', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 829, c.id, 'new', '2025-07-01'::date, '2025-07-03'::date, 3, 52, 0, 0, 0, false, 77, 12000, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872961933%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 828, c.id, 'new', '2025-07-06'::date, '2025-07-06'::date, 1, 41, 0, 0, 0, false, 68, 2800, 0, 'В Татарстан', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 827, c.id, 'new', '2025-07-01'::date, '2025-07-02'::date, 2, 25, 0, 0, 0, false, 67, 3360, 0, 'Сумка на 20 и 5', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046623179%' LIMIT 1;

-- SKIP order 826: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 825, c.id, 'new', '2025-07-02'::date, '2025-07-03'::date, 2, 40, 0, 0, 0, false, 76, 6080, 0, 'Заберет примерно в 10:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 824, c.id, 'new', '2025-06-29'::date, '2025-06-30'::date, 2, 30, 0, 0, 0, false, 75, 4480, 0, '29 июня к 7.30 в Кристалл надо радиогиды на 28 человек.сдадут в Кристалл 30 июня после 17.00 гид Ирина 89046620732', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 823, c.id, 'new', '2025-06-27'::date, '2025-06-28'::date, 1, 49, 0, 0, 0, false, 153, 7520, 0, '27 июня надо на 47 чел. Радиогиды в Кристалл к 7.00. Сдадут в Кристал вечером 28. Гид Ванда 89655868806', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

-- SKIP order 822: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 821, c.id, 'new', '2025-06-27'::date, '2025-06-27'::date, 1, 17, 0, 0, 0, false, 94, 1600, 0, 'Заберет сама', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9534837004%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 820, c.id, 'new', '2025-06-27'::date, '2025-06-27'::date, 1, 18, 0, 0, 0, false, 66, 1190, 0, 'Заберут', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 819, c.id, 'new', '2025-07-04'::date, '2025-07-05'::date, 2, 35, 0, 0, 0, false, 57, 4000, 0, 'Уточнить', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869297050%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 818, c.id, 'new', '2025-06-28'::date, '2025-06-28'::date, 1, 43, 0, 0, 0, false, 74, 3200, 0, 'Заберут. 28 утром', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9068185524%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 817, c.id, 'new', '2025-06-28'::date, '2025-06-28'::date, 1, 21, 0, 0, 0, false, 67, 1400, 0, 'Карат', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 816, c.id, 'new', '2025-06-28'::date, '2025-06-28'::date, 1, 44, 0, 0, 0, false, 68, 3010, 0, 'Завтрак в Марджани 8. В 8:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 815, c.id, 'new', '2025-06-27'::date, '2025-06-28'::date, 2, 28, 0, 0, 0, false, 65, 3640, 0, 'Кристал. Ирина. 1 лежит отдельно, не работает', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 814, c.id, 'new', '2025-06-27'::date, '2025-06-28'::date, 2, 28, 0, 0, 0, false, 65, 3640, 0, 'Кристал. Владимир', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 813, c.id, 'new', '2025-06-26'::date, '2025-06-26'::date, 1, 123, 0, 0, 0, false, 78, 9600, 0, '3 сумки по 40 в Ривьеру к 14:30, забрать в 18:20 из туган авылым 89377044790 Анастасия ответственная', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9376252850%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 812, c.id, 'new', '2025-06-28'::date, '2025-06-28'::date, 1, 26, 0, 0, 0, false, 77, 2000, 0, 'В офис к 10:30, забрать с отеля мираж после 20:00 +7 903 388-89-29 Гид Ильмира', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 811, c.id, 'new', '2025-06-28'::date, '2025-06-28'::date, 1, 44, 0, 0, 0, false, 78, 3440, 0, 'В релиту, вернут в релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 810, c.id, 'new', '2025-06-28'::date, '2025-06-28'::date, 1, 23, 0, 0, 0, false, 77, 1760, 0, 'В Сафар, вернут в Корстон', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 809, c.id, 'new', '2025-07-08'::date, '2025-07-08'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'В Кристал', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9108272699%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 808, c.id, 'new', '2025-07-08'::date, '2025-07-08'::date, 1, 25, 0, 0, 0, false, 77, 1920, 0, 'Заберет', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600565131%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 807, c.id, 'new', '2025-06-25'::date, '2025-06-26'::date, 2, 20, 0, 0, 0, false, 72, 2880, 0, 'НЕО тасига', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 806, c.id, 'new', '2025-06-25'::date, '2025-06-26'::date, 2, 156, 0, 0, 0, false, 64, 20000, 0, '3 сумки по 52шт в офис Тиц Забрать 27', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 805, c.id, 'new', '2025-06-25'::date, '2025-06-25'::date, 1, 1, 0, 0, 0, false, 7200, 7200, 0, 'В офис две сумки по 45', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 804, c.id, 'new', '2025-06-24'::date, '2025-06-25'::date, 2, 12, 0, 0, 0, false, 67, 1600, 0, 'В Нео Гид Эльзара для компании Пфайзер', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172914815%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 803, c.id, 'new', '2025-06-23'::date, '2025-06-24'::date, 1, 34, 0, 0, 0, false, 132, 4480, 0, '23.06 и 24.06* Группа 32 чел+ гид Владимир т. +7 917 885-84-09, гид Владимир', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

-- SKIP order 802: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 801, c.id, 'new', '2025-06-21'::date, '2025-06-21'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'Заберет утром Елена Козлова', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9006000057%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 800, c.id, 'new', '2025-06-20'::date, '2025-06-23'::date, 4, 25, 0, 0, 0, false, 74, 7360, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 799, c.id, 'new', '2025-06-20'::date, '2025-06-23'::date, 4, 43, 0, 0, 0, false, 76, 13120, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 798, c.id, 'new', '2025-06-20'::date, '2025-06-20'::date, 1, 31, 0, 0, 0, false, 68, 2100, 0, 'Забрать из Сулеймана Ирина', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 797, c.id, 'new', '2025-06-21'::date, '2025-06-22'::date, 2, 50, 0, 0, 0, false, 77, 7680, 0, 'Кристал Ольга', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9272534202%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 796, c.id, 'new', '2025-06-20'::date, '2025-06-20'::date, 2, 17, 0, 0, 0, false, 75, 2560, 0, 'Раймонд. Для Татьяны', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 795, c.id, 'new', '2025-06-21'::date, '2025-06-21'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'В релиту, вернут туда же', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 794, c.id, 'new', '2025-06-20'::date, '2025-06-21'::date, 1, 30, 0, 0, 0, false, 75, 2240, 0, 'В Сафар, вернут в Сулейман', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 792, c.id, 'new', '2025-06-24'::date, '2025-06-24'::date, 1, 31, 0, 0, 0, false, 77, 2400, 0, 'В кристал', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9108272699%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 791, c.id, 'new', '2025-06-19'::date, '2025-06-20'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, 'В Европу , оставят в АйТи парке', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9163108629%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 790, c.id, 'new', '2025-06-21'::date, '2025-06-21'::date, 1, 25, 0, 0, 0, false, 150, 3760, 0, 'В нео Тасиго с 9 до 18', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9118348339%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 789, c.id, 'new', '2025-06-18'::date, '2025-06-18'::date, 1, 31, 0, 0, 0, false, 77, 2400, 0, 'Да, пусть оставят на ресепшене на мой номер (1617 Стрелкова Анастасия) корстон', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

-- SKIP order 788: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 786, c.id, 'new', '2025-06-18'::date, '2025-06-19'::date, 2, 44, 0, 0, 0, false, 76, 6720, 0, 'Заберет утром в 10:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 785, c.id, 'new', '2025-06-18'::date, '2025-06-20'::date, 3, 24, 0, 0, 0, false, 73, 5280, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9190117253%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 784, c.id, 'new', '2025-06-15'::date, '2025-06-15'::date, 1, 31, 0, 0, 0, false, 80, 2480, 0, 'Амстердам', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 783, c.id, 'new', '2025-06-12'::date, '2025-06-12'::date, 1, 26, 0, 0, 0, false, 192, 5000, 0, 'Оставила в бусинке', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 782, c.id, 'new', '2025-06-12'::date, '2025-06-14'::date, 3, 40, 0, 0, 0, false, 101, 12160, 0, 'В офис Тиц', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 781, c.id, 'new', '2025-06-12'::date, '2025-06-14'::date, 3, 39, 0, 0, 0, false, 101, 11840, 0, 'В офис тиц', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 780, c.id, 'new', '2025-06-21'::date, '2025-06-21'::date, 1, 44, 0, 0, 0, false, 78, 3440, 0, 'Позвонит экскурсовод. Утром созвониться Сдали в татарскую усадьбу', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9677022929%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 779, c.id, 'new', '2025-06-28'::date, '2025-06-28'::date, 1, 41, 0, 0, 0, false, 78, 3200, 0, 'Заберет 27 вечером часов в 18:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9063310993%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 777, c.id, 'new', '2025-06-21'::date, '2025-06-21'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, 'В мано до 12, вернут после 19 в Татарстан', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 776, c.id, 'new', '2025-06-24'::date, '2025-06-24'::date, 1, 21, 0, 0, 0, false, 72, 1520, 0, 'Сулейман к 10, вернут туда же +7 937 575-03-93 гид резеда', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9111708200%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 775, c.id, 'new', '2025-06-12'::date, '2025-06-14'::date, 3, 45, 0, 0, 0, false, 76, 10320, 0, 'Оставила в Кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 774, c.id, 'new', '2025-06-13'::date, '2025-06-13'::date, 1, 43, 0, 0, 0, false, 78, 3360, 0, 'В кристалл, оставят там же в 17;00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 773, c.id, 'new', '2025-06-14'::date, '2025-06-15'::date, 2, 42, 0, 0, 0, false, 76, 6400, 0, 'В космос, вернут туда же после 20:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9050249197%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 772, c.id, 'new', '2025-06-11'::date, '2025-06-12'::date, 2, 20, 0, 0, 0, false, 72, 2880, 0, '18 штук на 11 и 12 июня. с 9.00 с апарт Отеля Пушкина 26', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 771, c.id, 'new', '2025-06-10'::date, '2025-06-12'::date, 3, 34, 0, 0, 0, false, 75, 7680, 0, '10 июня надо 32 радиогида (гид Аида 89033440899) Можно,если успеете в 7.30 в Кристалл, или в 08:30 – 09:30 Завтрак Кафе «Овсянки» ул.Бутлерова 34а 89046660417', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 769, c.id, 'new', '2025-06-13'::date, '2025-06-13'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'В Сафар, вернут в Сулейман', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 768, c.id, 'new', '2025-06-12'::date, '2025-06-12'::date, 1, 41, 0, 0, 0, false, 78, 3200, 0, 'В Сафар Вернут в релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 767, c.id, 'new', '2025-06-12'::date, '2025-06-12'::date, 1, 54, 0, 0, 0, false, 76, 4080, 0, 'Утром заберет в 08:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 765, c.id, 'new', '2025-06-12'::date, '2025-06-15'::date, 3, 42, 0, 0, 0, false, 67, 8400, 0, 'Радиогиды на все дни 40 человек 12-15 июня Отель Мираж Гид Ирина Баталова т +7 927 421-36-82 Приедут на жд в 10:50', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 764, c.id, 'new', '2025-06-09'::date, '2025-06-10'::date, 2, 22, 0, 0, 0, false, 64, 2800, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 763, c.id, 'new', '2025-06-09'::date, '2025-06-09'::date, 1, 26, 0, 0, 0, false, 77, 2000, 0, 'В Татарстан Вернут туда же после 19', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9050249197%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 762, c.id, 'new', '2025-06-14'::date, '2025-06-16'::date, 3, 40, 0, 0, 0, false, 76, 9120, 0, 'Ирина Пронина. Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9190117253%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 761, c.id, 'new', '2025-06-13'::date, '2025-06-13'::date, 1, 45, 0, 0, 0, false, 71, 3200, 0, 'Фатима', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9276703000%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 760, c.id, 'new', '2025-06-07'::date, '2025-06-08'::date, 2, 46, 0, 0, 0, false, 77, 7040, 0, '. 7.июня в 10 в Кристалл , радиогиды. 44 человека Гид Владимир Николаевич 89178858409 сдадут вечером 8 июня в Кристалл', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 759, c.id, 'new', '2025-06-10'::date, '2025-06-11'::date, 2, 53, 0, 0, 0, false, 77, 8160, 0, 'В 12 в Татарстан', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9225115900%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 758, c.id, 'new', '2025-06-18'::date, '2025-06-18'::date, 1, 42, 0, 0, 0, false, 68, 2870, 0, 'ВЕрнула в кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 757, c.id, 'new', '2025-06-06'::date, '2025-06-07'::date, 1, 49, 0, 0, 0, false, 153, 7520, 0, 'Будем в пятницу в кафе «Азу» в 15:00, возле айти', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 756, c.id, 'new', '2025-06-12'::date, '2025-06-14'::date, 3, 53, 0, 0, 0, false, 77, 12240, 0, 'В кристалл Гид Эльмира +7 917 878-83-60 Оставила в кристалле', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 755, c.id, 'new', '2025-06-05'::date, '2025-06-05'::date, 1, 16, 0, 0, 0, false, 75, 1200, 0, '08:30 утра отель Венера московская г. Казань, ул. Московская, д. 35. валерий матросов гид +7 905 319-54-86', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 754, c.id, 'new', '2025-06-14'::date, '2025-06-17'::date, 4, 26, 0, 0, 0, false, 62, 6440, 0, 'Максим горький', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 753, c.id, 'new', '2025-06-13'::date, '2025-06-14'::date, 2, 47, 0, 0, 0, false, 67, 6300, 0, 'Оставила в волге', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

-- SKIP order 752: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 751, c.id, 'new', '2025-06-06'::date, '2025-06-06'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'Заберут. Ольга', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9515639790%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 750, c.id, 'new', '2025-06-28'::date, '2025-06-28'::date, 1, 46, 0, 0, 0, false, 157, 7200, 0, 'Кристал. Лариса', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9530225627%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 749, c.id, 'new', '2025-06-12'::date, '2025-06-12'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, 'Отель Дион Гид Юстасия, вернут утром к 10 на Баумана', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9534880189%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 748, c.id, 'new', '2025-06-21'::date, '2025-06-21'::date, 1, 31, 0, 0, 0, false, 77, 2400, 0, 'В кристалл Вернет в фургончик', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172922000%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 747, c.id, 'new', '2025-06-04'::date, '2025-06-05'::date, 2, 17, 0, 0, 0, false, 71, 2400, 0, 'Заберет после обеда, на связи', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046623179%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 746, c.id, 'new', '2025-06-03'::date, '2025-06-05'::date, 3, 36, 0, 0, 0, false, 76, 8160, 0, '3-5 июня надо будет 34 радиогида в Кристалл к 10 . 30 сдадут вечером в Кристалл 5 июня гид Диана. +7 927 445-45-25', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 745, c.id, 'new', '2025-06-07'::date, '2025-06-07'::date, 1, 44, 0, 0, 0, false, 78, 3440, 0, 'В Сафар Вернут в Релиту в 23:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 744, c.id, 'new', '2025-06-04'::date, '2025-06-06'::date, 3, 44, 0, 0, 0, false, 76, 10080, 0, 'В кристалл Вернут в кристал 06 после 21:00 Гид Ванда 1 утерян', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 743, c.id, 'new', '2025-06-20'::date, '2025-06-21'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, 'Ирина пронина', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 742, c.id, 'new', '2025-06-02'::date, '2025-06-02'::date, 1, 82, 0, 0, 0, false, 78, 6400, 0, 'Рамада ~Антон Зенков +7 919 695‑73‑73', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 741, c.id, 'new', '2025-06-04'::date, '2025-06-04'::date, 1, 36, 0, 0, 0, false, 78, 2800, 0, '3 до 19 Забрать 5', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 740, c.id, 'new', '2025-08-08'::date, '2025-08-10'::date, 3, 48, 0, 0, 0, false, 77, 11040, 0, 'Кристал, Яна', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9639629332%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 739, c.id, 'new', '2025-07-18'::date, '2025-07-20'::date, 3, 40, 0, 0, 0, false, 80, 9600, 0, 'Кристал. Яна', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9639629332%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 738, c.id, 'new', '2025-07-04'::date, '2025-07-06'::date, 3, 40, 0, 0, 0, false, 80, 9600, 0, 'Кристал. Яна', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9639629332%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 737, c.id, 'new', '2025-06-27'::date, '2025-06-29'::date, 3, 43, 0, 0, 0, false, 76, 9840, 0, 'Кристал. Яна', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9639629332%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 736, c.id, 'new', '2025-06-06'::date, '2025-06-08'::date, 2, 53, 0, 0, 0, false, 78, 8320, 0, 'Сумка в отели Раймонд', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872961933%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 735, c.id, 'new', '2025-06-06'::date, '2025-06-08'::date, 3, 43, 0, 0, 0, false, 76, 9840, 0, 'Кристал. Яна', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9639629332%' LIMIT 1;

-- SKIP order 734: no phone
-- SKIP order 733: no phone
-- SKIP order 732: no phone
-- SKIP order 731: no phone
-- SKIP order 730: no phone
-- SKIP order 729: no phone
-- SKIP order 728: no phone
-- SKIP order 727: no phone
-- SKIP order 726: no phone
-- SKIP order 725: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 724, c.id, 'new', '2025-05-30'::date, '2025-05-30'::date, 1, 16, 0, 0, 0, false, 75, 1200, 0, 'Заберет из бусика', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274662530%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 723, c.id, 'new', '2025-05-30'::date, '2025-06-01'::date, 3, 35, 0, 0, 0, false, 75, 7920, 0, 'В Волгу Оставили в бусике', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9105850558%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 722, c.id, 'new', '2025-05-30'::date, '2025-05-30'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, 'Вернет 31 в обед', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 721, c.id, 'new', '2025-05-31'::date, '2025-05-31'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'В офис тиц Вернут вечером', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 720, c.id, 'new', '2025-05-30'::date, '2025-05-31'::date, 2, 34, 0, 0, 0, false, 73, 4960, 0, 'Заберет в обед Завезет в кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 719, c.id, 'new', '2025-05-31'::date, '2025-05-31'::date, 1, 60, 0, 0, 0, false, 80, 4800, 0, 'Две сумки по 30шт Привезти к новому театру Камала в 14:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179221193%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 718, c.id, 'new', '2025-05-30'::date, '2025-05-30'::date, 1, 42, 0, 0, 0, false, 78, 3280, 0, 'В Регину на Петербургской Вернут в районе 20:30 в Регину', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9050249197%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 716, c.id, 'new', '2025-06-03'::date, '2025-06-03'::date, 1, 20, 0, 0, 0, false, 76, 1520, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9677791807%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 715, c.id, 'new', '2025-05-31'::date, '2025-06-01'::date, 2, 26, 0, 0, 0, false, 74, 3840, 0, 'В Булак. Оставили в кристале', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 714, c.id, 'new', '2025-05-31'::date, '2025-05-31'::date, 1, 30, 0, 0, 0, false, 77, 2320, 0, 'Заберет 30.05. В 17:15', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9276703000%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 713, c.id, 'new', '2025-05-28'::date, '2025-05-28'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, 'Лейла. Оставят в кристале', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9273735552%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 712, c.id, 'new', '2025-05-29'::date, '2025-05-29'::date, 1, 29, 0, 0, 0, false, 77, 2240, 0, '29.05 до 16:00 в отель 13 на московской 13А', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9196862442%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 711, c.id, 'new', '2025-05-30'::date, '2025-05-30'::date, 1, 18, 0, 0, 0, false, 76, 1360, 0, '23.30 Корстон оставят', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 710, c.id, 'new', '2025-06-13'::date, '2025-06-14'::date, 2, 32, 0, 0, 0, false, 75, 4800, 0, 'Раймонд', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869297050%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 709, c.id, 'new', '2025-06-12'::date, '2025-06-13'::date, 2, 42, 0, 0, 0, false, 76, 6400, 0, 'Утром в 8:30 заберет', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 708, c.id, 'new', '2025-05-30'::date, '2025-05-31'::date, 2, 57, 0, 0, 0, false, 77, 8800, 0, '+7 950 314-03-61 Ольга Оставит в кристалле', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 707, c.id, 'new', '2025-05-27'::date, '2025-05-27'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'Гранд отель Вернули туда же', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9050249197%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 706, c.id, 'new', '2025-05-27'::date, '2025-05-27'::date, 1, 34, 0, 0, 0, false, 78, 2640, 0, 'В Регину на университетской Вернули туда же', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9050249197%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 705, c.id, 'new', '2025-05-30'::date, '2025-06-02'::date, 3, 36, 0, 0, 0, false, 76, 8160, 0, '30.05 В гостиницу Татарстан до 20:30, Оставит в бусике', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9677791807%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 704, c.id, 'new', '2025-05-28'::date, '2025-05-28'::date, 1, 46, 0, 0, 0, false, 78, 3600, 0, '27 принести 29 забрать', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 703, c.id, 'new', '2025-05-31'::date, '2025-06-01'::date, 2, 30, 0, 0, 0, false, 75, 4480, 0, '30 до 19:00 в мобильный трак Забрать можно 02.06 до 19:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 702, c.id, 'new', '2025-05-26'::date, '2025-05-27'::date, 2, 40, 0, 0, 0, false, 66, 5320, 0, 'Группа 38 чел+ гид Ирина т.+7 927 421-36-82 Нужны радиогиды *на завтра, на 26,27,мая* Завтра в 12:30 приезжают на ЖД центр, можно оставить в Кристалле. Забрать в Булаке', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 701, c.id, 'new', '2025-05-25'::date, '2025-05-25'::date, 1, 37, 0, 0, 0, false, 78, 2880, 0, '25.05 надо 36 радиогидов завести в 9-10 на Каюма Насыри 1/5б 2 этаж музей Бик тэмле, бик матур. с ними будет работать гид Марина 89172526993', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

-- SKIP order 700: no phone
-- SKIP order 699: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 698, c.id, 'new', '2025-05-25'::date, '2025-05-25'::date, 1, 31, 0, 0, 0, false, 77, 2400, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172989675%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 697, c.id, 'new', '2025-05-24'::date, '2025-05-25'::date, 2, 47, 0, 0, 0, false, 78, 7360, 0, 'Заберет в 10:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178605272%' LIMIT 1;

-- SKIP order 696: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 694, c.id, 'new', '2025-05-24'::date, '2025-05-26'::date, 3, 38, 0, 0, 0, false, 76, 8640, 0, '24-26 мая гид Ольга 89503140361 36 человек 24- в Кристалл до 10.30 сдаст 26- в Кристалл после 17.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 693, c.id, 'new', '2025-05-29'::date, '2025-05-30'::date, 2, 38, 0, 0, 0, false, 76, 5760, 0, 'гид Ирина Палей 89046620732 сдаст 30- в отеле Давыдов на Назарбаева после 19.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 692, c.id, 'new', '2025-05-25'::date, '2025-05-25'::date, 1, 36, 0, 0, 0, false, 78, 2800, 0, '24 в Кристалл к 15.00 привести радиогиды на 35 человек для Ирины Палей 89046620732 для работы на 25 мая,т.к. она уедет 25.05 в Йошкар-Олу с ними в 5.30 утра. сдаст 25 мая после 18.00 по созвону.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 691, c.id, 'new', '2025-05-24'::date, '2025-05-25'::date, 2, 35, 0, 0, 0, false, 75, 5280, 0, '24-25 мая гид Владимир Николаевич 89178858409 заберет 24- в Кристалле в 7.30 на 33 человека.сдаст 25- на Баумана после 16.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 690, c.id, 'new', '2025-05-24'::date, '2025-05-24'::date, 1, 16, 0, 0, 0, false, 75, 1200, 0, 'Офис тиц', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 688, c.id, 'new', '2025-06-21'::date, '2025-06-21'::date, 1, 25, 0, 0, 0, false, 77, 1920, 0, 'От отеля Мираж в 16:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9196862442%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 687, c.id, 'new', '2025-06-19'::date, '2025-06-19'::date, 1, 143, 0, 0, 0, false, 78, 11200, 0, 'Около 10 заберет утром Сумки на 48,48, 47 Вернет на следующий день к обеду', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178533525%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 686, c.id, 'new', '2025-05-23'::date, '2025-05-23'::date, 1, 41, 0, 0, 0, false, 78, 3200, 0, 'Офис тиц Забрать утром 24', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 685, c.id, 'new', '2025-05-23'::date, '2025-05-23'::date, 1, 70, 0, 0, 0, false, 78, 5440, 0, 'Две сумки по 34шт забрать утром 24', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 684, c.id, 'new', '2025-06-04'::date, '2025-06-04'::date, 1, 9, 0, 0, 0, false, 4000, 36000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 683, c.id, 'new', '2025-05-25'::date, '2025-05-27'::date, 3, 53, 0, 0, 0, false, 77, 12240, 0, '24.05 в тиц офис до 17 Забрать можно 27.05 после 21:00 в кристалле +7 965 586-88-06 Гид Ванда', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 682, c.id, 'new', '2025-05-24'::date, '2025-05-24'::date, 1, 56, 0, 0, 0, false, 79, 4400, 0, '23 оставить вечером в Азимут Сдадут 24 в азимут в районе 18 Оставила в Космосе', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9778302928%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 681, c.id, 'new', '2025-05-22'::date, '2025-05-22'::date, 1, 62, 0, 0, 0, false, 77, 4800, 0, 'оставить в Серфе на Подлужной и Сдала в бусик', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179221193%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 680, c.id, 'new', '2025-05-28'::date, '2025-05-28'::date, 1, 28, 0, 0, 0, false, 77, 2160, 0, 'Уточнить', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9278000133%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 678, c.id, 'new', '2025-05-22'::date, '2025-05-22'::date, 1, 112, 0, 0, 0, false, 79, 8800, 0, 'Две сумки по 55, в Корстон к 12', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179221193%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 677, c.id, 'new', '2025-05-24'::date, '2025-05-24'::date, 1, 14, 0, 0, 0, false, 74, 1040, 0, 'Заберет сама 23 вечером Вернула в бусик', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274662530%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 676, c.id, 'new', '2025-05-20'::date, '2025-05-21'::date, 2, 32, 0, 0, 0, false, 75, 4800, 0, 'Заказ Аудигид: 30шт на 20.05,21.05 гостиница Фатима Карла Маркса 2', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172403085%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 675, c.id, 'new', '2025-05-17'::date, '2025-05-18'::date, 2, 35, 0, 0, 0, false, 75, 5280, 0, 'Елена. +7 987 296‑95‑42. Сумка в кристале', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9853891999%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 674, c.id, 'new', '2025-05-23'::date, '2025-05-23'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'Заберет в кристалле, Оставила в офисе', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172922000%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 672, c.id, 'new', '2025-05-17'::date, '2025-05-17'::date, 1, 52, 0, 0, 0, false, 78, 4080, 0, 'Закончат к 12', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 671, c.id, 'new', '2025-05-17'::date, '2025-05-17'::date, 1, 41, 0, 0, 0, false, 68, 2800, 0, 'Завезти в Булгар отель', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 670, c.id, 'new', '2025-05-17'::date, '2025-05-17'::date, 1, 1, 0, 0, 0, false, 7200, 7200, 0, 'Две сумки на 45 на один день', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 669, c.id, 'new', '2025-05-17'::date, '2025-05-18'::date, 2, 1, 0, 0, 0, false, 7200, 14400, 0, 'Две сумки по 45 на два дня', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 668, c.id, 'new', '2025-06-15'::date, '2025-06-16'::date, 2, 33, 0, 0, 0, false, 75, 4960, 0, '15 и 16 июня. На 31 человека. Забрать придется 14 июня, тк программа обслуживания начинается 15 июня в 05:00 утра.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 667, c.id, 'new', '2025-06-28'::date, '2025-06-29'::date, 2, 37, 0, 0, 0, false, 76, 5600, 0, 'Уточнить', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9220064070%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 666, c.id, 'new', '2025-05-16'::date, '2025-05-16'::date, 1, 25, 0, 0, 0, false, 64, 1600, 0, '5 переводчиков и 5 микрофонов', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 664, c.id, 'new', '2025-05-27'::date, '2025-05-28'::date, 2, 30, 0, 0, 0, false, 93, 5600, 0, '(Чайка Ю) Катя Кореева В дом чая к 15:30 Вернет в кристал', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 663, c.id, 'new', '2025-05-17'::date, '2025-05-17'::date, 1, 41, 0, 0, 0, false, 78, 3200, 0, 'Заберут 16 мая', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9063310993%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 662, c.id, 'new', '2025-05-26'::date, '2025-05-28'::date, 3, 31, 0, 0, 0, false, 94, 8700, 0, 'Воронеж Гид Екатерина Геннадьевна 89275662530 Оставила в Шаляпине', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 661, c.id, 'new', '2025-05-21'::date, '2025-05-23'::date, 3, 38, 0, 0, 0, false, 76, 8640, 0, 'Кристал. Гид Элина', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9222673014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 660, c.id, 'new', '2025-05-16'::date, '2025-05-16'::date, 1, 31, 0, 0, 0, false, 68, 2100, 0, '16 мая, будет 30 человек + гид Владимир т. +7 917 885-84-09 Начало 16 мая в 8:00 от ЦЖД,(можно оставить в Кристалле) на 1 день, заканчивают в 17 ч в отеле 55 ( ул. Островского 55)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 659, c.id, 'new', '2025-05-23'::date, '2025-05-24'::date, 2, 33, 0, 0, 0, false, 94, 6200, 0, 'М- Поет-2 Экскурсовод Марина Николаевна +7 927 429-91-77 Вернет в 22 в Кристал', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 658, c.id, 'new', '2025-05-16'::date, '2025-05-16'::date, 1, 25, 0, 0, 0, false, 77, 1920, 0, 'Заберут. Начало в 12:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9827935377%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 657, c.id, 'new', '2025-05-17'::date, '2025-05-17'::date, 1, 44, 0, 0, 0, false, 78, 3440, 0, 'В Сафар Заканчивают в 23:30 в Корстон', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 656, c.id, 'new', '2025-05-28'::date, '2025-05-28'::date, 1, 48, 0, 0, 0, false, 78, 3760, 0, 'Сама заберет 29 утром занесет', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 655, c.id, 'new', '2025-05-24'::date, '2025-05-25'::date, 2, 27, 0, 0, 0, false, 93, 5000, 0, 'На ресепшен отеля Максим Горький Вернула в Кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9161638158%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 654, c.id, 'new', '2025-05-17'::date, '2025-05-17'::date, 1, 46, 0, 0, 0, false, 78, 3600, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869297050%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 653, c.id, 'new', '2025-05-12'::date, '2025-05-12'::date, 1, 40, 0, 0, 0, false, 78, 3120, 0, 'Заберет в 8:20-8:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872797484%' LIMIT 1;

-- SKIP order 652: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 651, c.id, 'new', '2025-05-11'::date, '2025-05-13'::date, 3, 50, 0, 0, 0, false, 67, 10080, 0, 'радиогиды на 11,12,13 мая, будет 48 человек + гид Ирина т. +7 927 421-36-82 Отель Булгар ( Ул Вишневского 21) Можно оставить накануне в отеле Кристалл, группа приезжает 11 мая в 7:50 утра на ЦЖД', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 650, c.id, 'new', '2025-06-12'::date, '2025-06-12'::date, 1, 39, 0, 0, 0, false, 78, 3040, 0, 'Заберет в 10:45', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 649, c.id, 'new', '2025-05-13'::date, '2025-05-15'::date, 3, 33, 0, 0, 0, false, 69, 6880, 0, 'Хилтон в обед', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9870051978%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 648, c.id, 'new', '2025-05-09'::date, '2025-05-09'::date, 1, 13, 0, 0, 0, false, 74, 960, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9297259743%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 647, c.id, 'new', '2025-05-01'::date, '2025-05-04'::date, 4, 17, 0, 0, 0, false, 71, 4800, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9112636331%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 646, c.id, 'new', '2025-05-15'::date, '2025-05-15'::date, 1, 36, 0, 0, 0, false, 78, 2800, 0, 'на 15 мая, 35 штук, прошу принести сумку 14 мая в первой половине дня, чтобы гид успел у нас её забрать. Сумку принесите в наш мобильный трак на петербургской. Забрать сумку можно будет 16 мая в течение дня до 19.00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 645, c.id, 'new', '2025-05-09'::date, '2025-05-11'::date, 3, 30, 0, 0, 0, false, 52, 4640, 0, 'Группа №3(Екатеринбург) 29 человек, на 3 дня(09-11 мая) можно оставить в Кристалле до 11:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 644, c.id, 'new', '2025-05-08'::date, '2025-05-10'::date, 3, 45, 0, 0, 0, false, 78, 10560, 0, 'Группа №2 (Ногинск) 44 человека,на 3 дня (08-10 мая) привезти накануне, т.к. встречают в 7 утра', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 643, c.id, 'new', '2025-05-08'::date, '2025-05-09'::date, 2, 46, 0, 0, 0, false, 78, 7200, 0, 'Группа №1(Обнинск) 46 человек, на 2 дня (08-09 мая) привезти накануне в офис, т.к. встречают в 7 утра Вернули в кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 642, c.id, 'new', '2025-05-08'::date, '2025-05-08'::date, 1, 54, 0, 0, 0, false, 79, 4240, 0, 'Баскет холл, к 8', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

-- SKIP order 641: no phone
-- SKIP order 640: no phone
-- SKIP order 639: no phone
-- SKIP order 638: no phone
-- SKIP order 637: no phone
-- SKIP order 634: no phone
-- SKIP order 633: no phone
-- SKIP order 632: no phone
-- SKIP order 630: no phone
-- SKIP order 629: no phone
-- SKIP order 628: no phone
-- SKIP order 627: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 626, c.id, 'new', '2025-05-09'::date, '2025-05-09'::date, 1, 38, 0, 0, 0, false, 78, 2960, 0, 'Кафе Хоррият до 11:00( петерьургая 57) Вернут после 20:00 в Татарстан', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9050249197%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 625, c.id, 'new', '2025-05-08'::date, '2025-05-09'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, 'Амансафар. Вернут в корстон', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9099242488%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 624, c.id, 'new', '2025-05-05'::date, '2025-05-06'::date, 2, 46, 0, 0, 0, false, 77, 7040, 0, 'Гид Диана +7 927 445-45-25 05 в тиц до 15 Вернут в тиц 06 с 18:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 623, c.id, 'new', '2025-05-09'::date, '2025-05-10'::date, 2, 27, 0, 0, 0, false, 74, 4000, 0, '9.05 гид Виктория 89196236810 25шт. 9.30 отель Давыдов на Павлюхина , сдаст 10.05 после 21.30 по созвону. ВЕРНУЛА В КРИСТАЛ', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 622, c.id, 'new', '2025-05-09'::date, '2025-05-10'::date, 2, 46, 0, 0, 0, false, 77, 7040, 0, '9.05 гид Марина 89172526993 44 шт. в 9.30 отель Аматти сдаст 10.05 после 21.30 по созвону', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 621, c.id, 'new', '2025-05-08'::date, '2025-05-09'::date, 2, 46, 0, 0, 0, false, 77, 7040, 0, '8.05 гид Владимир 89178858409 44 шт. в 9.00 Алан аш на Бутлерова 43 сдаст 9.05 после 16 по созвону', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 620, c.id, 'new', '2025-05-05'::date, '2025-05-06'::date, 2, 29, 0, 0, 0, false, 74, 4320, 0, '5.05 гид Владимир 89178858409 27шт. в 8.00 кафе Овсянки сдаст 6.05 после 19.00 по созвону.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 619, c.id, 'new', '2025-05-03'::date, '2025-05-03'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 618, c.id, 'new', '2025-05-10'::date, '2025-05-10'::date, 1, 36, 0, 0, 0, false, 78, 2800, 0, '10 мая с 08.00 до 23.30 от Сафара в Релиту', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 617, c.id, 'new', '2025-05-09'::date, '2025-05-09'::date, 1, 26, 0, 0, 0, false, 77, 2000, 0, 'с 08.00 до 23.30 от Сафара в Сулейман', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 615, c.id, 'new', '2025-05-03'::date, '2025-05-03'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, 'Утром Принесет на вечерку', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179275489%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 614, c.id, 'new', '2025-05-03'::date, '2025-05-04'::date, 2, 34, 0, 0, 0, false, 78, 5280, 0, '3.05 гид Владимир 89178858409 33 шт. в Кристалл к 7.30 сдаст 4.05 после 13. по созвону на Баумана', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 613, c.id, 'new', '2025-05-02'::date, '2025-05-04'::date, 3, 36, 0, 0, 0, false, 78, 8400, 0, '2.05 гид Диана 89274454525 35 штук отель Кристалл к 7.30 сдадут 4.05 после 13.30 в кристалл', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 612, c.id, 'new', '2025-05-01'::date, '2025-05-02'::date, 2, 38, 0, 0, 0, false, 102, 7770, 0, '1 группа* На *1 и 2 мая* 37 человек + гид Владимир т.+7 917 885-84-09 отель Булгар ( ул Вишневского 21) 2 группа * На *2 мая* 37 человек + гид Ирина т. +7 927 421-36-82 Отель Биляр Палас ( ул Островского 61) Нужно положить два комплекта наушников. Оставили в биляр!!', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 611, c.id, 'new', '2025-05-02'::date, '2025-05-04'::date, 3, 40, 0, 0, 0, false, 76, 9120, 0, '01.05 занести в офис Тиц', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 610, c.id, 'new', '2025-05-08'::date, '2025-05-10'::date, 3, 42, 0, 0, 0, false, 98, 12300, 0, 'Тула завезти ВЕРНУЛИ В КРИСТАЛЛ', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 609, c.id, 'new', '2025-05-08'::date, '2025-05-10'::date, 3, 44, 0, 0, 0, false, 98, 12900, 0, 'ЕКБ-2 завезти ВЕРНУЛИ В КРИСТАЛ', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 608, c.id, 'new', '2025-05-01'::date, '2025-05-03'::date, 3, 32, 0, 0, 0, false, 75, 7200, 0, '30.04 занести в офис Тиц на Баумана Вернут 03.05 в офис Тиц вечером', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503118747%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 607, c.id, 'new', '2025-05-03'::date, '2025-05-03'::date, 1, 44, 0, 0, 0, false, 78, 3440, 0, 'Оставить в Сафаре Забрать в Сулейман утром 04.05', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 606, c.id, 'new', '2025-05-03'::date, '2025-05-03'::date, 1, 37, 0, 0, 0, false, 78, 2880, 0, 'Оставить в Сулейман до 08:30 и забрать в Сулейман Утром', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 605, c.id, 'new', '2025-05-02'::date, '2025-05-02'::date, 1, 27, 0, 0, 0, false, 77, 2080, 0, 'Оставить в Амакс Оставят в Релите в 23:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9152964580%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 604, c.id, 'new', '2025-04-30'::date, '2025-05-01'::date, 2, 29, 0, 0, 0, false, 74, 4320, 0, 'Крисстал вернет гид Анна +7 987 290-73-09 Они в 18:00 заканчивают в Рамаде', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179062560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 602, c.id, 'new', '2025-05-03'::date, '2025-05-03'::date, 1, 44, 0, 0, 0, false, 78, 3440, 0, 'Татарстан Алевтина Александровна 89033881755 Вернут туда же после 18:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9050249197%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 601, c.id, 'new', '2025-05-03'::date, '2025-05-04'::date, 2, 65, 0, 0, 0, false, 94, 12200, 0, 'Уточнить 63 гида Оставили в крисстал', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 600, c.id, 'new', '2025-05-02'::date, '2025-05-03'::date, 2, 37, 0, 0, 0, false, 95, 7000, 0, 'Завезу по пути в кристал Оставили в кристал', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 599, c.id, 'new', '2025-05-01'::date, '2025-05-03'::date, 3, 47, 0, 0, 0, false, 77, 10800, 0, 'Завезти в офис инициативы Вернут в кристал в 22:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 598, c.id, 'new', '2025-05-01'::date, '2025-05-01'::date, 1, 34, 0, 0, 0, false, 78, 2640, 0, 'Завезти в офис инициативы Вернут в Амстердам в 23:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600523400%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 597, c.id, 'new', '2025-05-01'::date, '2025-05-03'::date, 3, 20, 0, 0, 0, false, 90, 5400, 0, 'Сами заберут Оставят в кристалле в 22:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 596, c.id, 'new', '2025-05-01'::date, '2025-05-02'::date, 2, 33, 0, 0, 0, false, 94, 6200, 0, 'Сами заберут', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 595, c.id, 'new', '2025-05-01'::date, '2025-05-03'::date, 3, 35, 0, 0, 0, false, 94, 9900, 0, 'Сами заберут', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872904401%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 594, c.id, 'new', '2025-05-13'::date, '2025-05-14'::date, 2, 54, 0, 0, 0, false, 76, 8160, 0, 'Заберут и оставят в Кристалле', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9225115900%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 593, c.id, 'new', '2025-04-29'::date, '2025-04-29'::date, 1, 33, 0, 0, 0, false, 136, 4480, 0, '29.04 1 группа 32 человека + гид Лариса тел. +7 927 240-82-50 2 группа 32 человека + гид Ольга тел. +7 927 401-81-84 Экскурсия будет от Амакс Сафар с 15 до 18 ч и заканчивается в Амакс', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 592, c.id, 'new', '2025-05-02'::date, '2025-05-02'::date, 1, 47, 0, 0, 0, false, 78, 3680, 0, 'На 02.05 в Крисстал, группа 46+1 запас+1 гид Сопровождающая Мария +7 901 282-25-77 Гид Алексей Вернут в фургончик в 15:30', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 591, c.id, 'new', '2025-05-01'::date, '2025-05-03'::date, 3, 48, 0, 0, 0, false, 77, 11040, 0, 'Кристалл Вернут в кристалл в районе 19', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9206736156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 589, c.id, 'new', '2025-05-05'::date, '2025-05-06'::date, 2, 40, 0, 0, 0, false, 76, 6080, 0, 'Утром заберет', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9276797970%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 588, c.id, 'new', '2025-05-03'::date, '2025-05-03'::date, 1, 42, 0, 0, 0, false, 78, 3280, 0, 'Заберут Вечером вернет', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 587, c.id, 'new', '2025-04-30'::date, '2025-04-30'::date, 1, 29, 0, 0, 0, false, 77, 2240, 0, '. на 30.04. в Карат к 9.30 гид Диана 89274454525 сдаст 30.04 после 17.30 по созвону.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 586, c.id, 'new', '2025-04-29'::date, '2025-04-30'::date, 2, 30, 0, 0, 0, false, 75, 4480, 0, 'на 29 апреля 28 чел. гид Ирина Палей 89046620732 Биляр к 9.30 сдадут 30.04 после 19 в Кристалл', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 585, c.id, 'new', '2025-04-28'::date, '2025-04-29'::date, 2, 36, 0, 0, 0, false, 78, 5600, 0, '35 шт гид Гульнара 89600389286в Сулейман к 8.30 сдаст гид Ванда 89655868806 29 апреля по созвону после 17.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 584, c.id, 'new', '2025-04-28'::date, '2025-04-28'::date, 1, 33, 0, 0, 0, false, 78, 2560, 0, '32 шт. гид Зифа 89053162643 в Давыдов на Павлюхина , сдадут в этот же день после 19.00 в Давыдов', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 583, c.id, 'new', '2025-04-28'::date, '2025-04-30'::date, 3, 38, 0, 0, 0, false, 76, 8640, 0, '36 шт. гид Марина 89172526993 в Кристалл в 10.30 отдадут 30.04 по созвону после 20.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

-- SKIP order 582: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 581, c.id, 'new', '2025-05-08'::date, '2025-05-08'::date, 1, 25, 0, 0, 0, false, 77, 1920, 0, 'Заберут сами рано утром', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9190783257%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 580, c.id, 'new', '2025-04-27'::date, '2025-04-27'::date, 1, 38, 0, 0, 0, false, 68, 2590, 0, 'Заберет в 12:45', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274463215%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 579, c.id, 'new', '2025-04-26'::date, '2025-04-26'::date, 1, 25, 0, 0, 0, false, 77, 1920, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178605272%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 578, c.id, 'new', '2025-04-26'::date, '2025-04-27'::date, 2, 42, 0, 0, 0, false, 67, 5600, 0, 'Заявка на завтра 26 и 27 апреля Группа 40 человек + гид Ирина тел. +7 927 421-36-82 Завтра приезжают на ЖД в 12 часов дня, можно оставить в отеле Кристалл. Сумка в отели Гвардейский', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 577, c.id, 'new', '2025-05-01'::date, '2025-05-01'::date, 1, 50, 0, 0, 0, false, 78, 3920, 0, 'Заберет в 8:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172989675%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 576, c.id, 'new', '2025-04-29'::date, '2025-04-29'::date, 1, 43, 0, 0, 0, false, 78, 3360, 0, '29 апреля Регина на Петербургской 42 шт для Татьяны', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 575, c.id, 'new', '2025-04-28'::date, '2025-04-28'::date, 1, 75, 0, 0, 0, false, 78, 5840, 0, '28 го Региеа на Петербургской 73/2 для Айгуль и Александра. На 36 и 37.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 574, c.id, 'new', '2025-04-28'::date, '2025-04-28'::date, 1, 36, 0, 0, 0, false, 78, 2800, 0, '28 го в Регину на Петербург для Ольги 35 штук', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 573, c.id, 'new', '2025-04-26'::date, '2025-04-26'::date, 1, 45, 0, 0, 0, false, 267, 12000, 0, '26 го в кристалле на имя Айгуль 44 шт На имя Эльвира 35 человек На имя Лиза 37 человек На имя Влада 36 Вернут в Регину после 16:00 на петербуржскую', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 572, c.id, 'new', '2025-04-24'::date, '2025-04-24'::date, 1, 50, 0, 0, 0, false, 74, 3680, 0, 'Оставят в Волге,', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 571, c.id, 'new', '2025-05-03'::date, '2025-05-03'::date, 1, 37, 0, 0, 0, false, 279, 10320, 0, 'Заберут с Баумана в 16:30 Вернут в 20:30 в Регину на Баумана', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179332160%' LIMIT 1;

-- SKIP order 570: no phone
-- SKIP order 569: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 568, c.id, 'new', '2025-04-24'::date, '2025-04-24'::date, 1, 36, 0, 0, 0, false, 78, 2800, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9063248898%' LIMIT 1;

-- SKIP order 567: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 566, c.id, 'new', '2025-05-04'::date, '2025-05-06'::date, 3, 87, 0, 0, 0, false, 76, 19920, 0, 'Кристал. Информация будет в 19:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9222673014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 565, c.id, 'new', '2025-05-02'::date, '2025-05-03'::date, 2, 75, 0, 0, 0, false, 78, 11680, 0, '2 мая 73/2 в кристалле Для Людмилы и Татьяны Вернули в Релиту', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 563, c.id, 'new', '2025-04-25'::date, '2025-04-28'::date, 4, 43, 0, 0, 0, false, 57, 9840, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 562, c.id, 'new', '2025-04-26'::date, '2025-04-27'::date, 2, 64, 0, 0, 0, false, 39, 4960, 0, 'Она в Кристалле оборудование на 62 чел возьмёт,а отдаст в Татарской слободе на Марджани в 12.00 группа там будет. Самгина Ольг +7 953 717‑05‑28. Привезет Ильдар 051', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9158685892%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 561, c.id, 'new', '2025-04-24'::date, '2025-04-24'::date, 1, 77, 0, 0, 0, false, 78, 6000, 0, 'Одна сумка один передатчик. Марафон. Доставка', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274143743%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 560, c.id, 'new', '2025-05-09'::date, '2025-05-09'::date, 1, 56, 0, 0, 0, false, 94, 5250, 0, 'Уточнить в переписке', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 559, c.id, 'new', '2025-05-07'::date, '2025-05-07'::date, 1, 56, 0, 0, 0, false, 69, 3850, 0, 'Уточнить в переписке Наталья Релита', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 557, c.id, 'new', '2025-04-26'::date, '2025-04-27'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, 'Заберут утром', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178605272%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 556, c.id, 'new', '2025-04-24'::date, '2025-04-24'::date, 1, 17, 0, 0, 0, false, 75, 1280, 0, 'Добрый день! На 24.04 ГРАНД ОТЕЛЬ КАЗАНЬ Нужны аудиогиды) 16 для группы+ запосной+ для гида', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 555, c.id, 'new', '2025-04-23'::date, '2025-04-23'::date, 1, 21, 0, 0, 0, false, 72, 1520, 0, 'Забрать 23. У Кремля в 12:15', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9377797273%' LIMIT 1;

-- SKIP order 554: no phone
-- SKIP order 553: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 551, c.id, 'new', '2025-04-18'::date, '2025-04-20'::date, 3, 47, 0, 0, 0, false, 77, 10800, 0, 'На 18-20 апреля нужно 45 шт. радиогидов в Кристалл к 7.00 .Вернут туда же после 20 часов Гид Владимир Николаевич 89178858409', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 550, c.id, 'new', '2025-04-17'::date, '2025-04-18'::date, 2, 41, 0, 0, 0, false, 76, 6240, 0, '17 апреля надо 39 штук на 2 дня радио гидов в Хостел (Петербургская, 40Б) к 14.30 для гида Шуравиной Ольги89503140361 вернут 18.04 по созвону после 17 часов.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

-- SKIP order 548: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 547, c.id, 'new', '2025-05-10'::date, '2025-05-11'::date, 2, 45, 0, 0, 0, false, 33, 3010, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 546, c.id, 'new', '2025-04-14'::date, '2025-04-14'::date, 1, 21, 0, 0, 0, false, 76, 1600, 0, 'В отель Карат Гид+7 950 949-04-94 Беркут хан ( Радик) сдаст по созвону вечером', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 544, c.id, 'new', '2025-06-03'::date, '2025-06-05'::date, 2, 34, 0, 0, 0, false, 144, 9760, 0, '3. В 12:00 у Кремля Даты: 3 июНя с 11 до 18 5 июНя с 9 до 20', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9103961028%' LIMIT 1;

-- SKIP order 543: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 542, c.id, 'new', '2025-04-13'::date, '2025-04-13'::date, 1, 56, 0, 0, 0, false, 69, 3850, 0, 'Релита. Сумка в Шаляпин', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

-- SKIP order 541: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 540, c.id, 'new', '2025-05-01'::date, '2025-05-02'::date, 2, 45, 0, 0, 0, false, 67, 6020, 0, 'Оставила в Волге', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

-- SKIP order 539: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 537, c.id, 'new', '2025-04-13'::date, '2025-04-13'::date, 1, 25, 0, 0, 0, false, 77, 1920, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 536, c.id, 'new', '2025-05-02'::date, '2025-05-03'::date, 2, 20, 0, 0, 0, false, 76, 3040, 0, '+79297259743 Утром сама заберет В кристалле', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872965880%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 533, c.id, 'new', '2025-04-12'::date, '2025-04-12'::date, 1, 51, 0, 0, 0, false, 157, 8000, 0, 'На субботу 12 апреля нужно 100 примерно радиогидов и 2 передатчика. Поможете?', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 532, c.id, 'new', '2025-04-13'::date, '2025-04-13'::date, 1, 21, 0, 0, 0, false, 76, 1600, 0, '13.04 гид Палей Ирина 89046620732 20 чел. Сулейман к 11.30 сдаст в 20.30 в Кристалл ГИДА НЕ ПРЕДУПРЕДИЛИ! СУМКА ОСТАЛАСЬ В СУЛЕЙМАН!', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 531, c.id, 'new', '2025-04-11'::date, '2025-04-11'::date, 1, 30, 0, 0, 0, false, 75, 2240, 0, '10.04 гид Дания 89172904415 28чел. в обед позвонит на Баумана. чтобы использовать 11.04. сдаст 11.04 поздно или по звонку потом', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 530, c.id, 'new', '2025-04-09'::date, '2025-04-10'::date, 2, 28, 0, 0, 0, false, 74, 4160, 0, 'Полносью мой, сдадут в кристалл 10.04 в 20:00. Гольфстрим', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9053171049%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 529, c.id, 'new', '2025-04-09'::date, '2025-04-10'::date, 2, 42, 0, 0, 0, false, 67, 5600, 0, '9 и 10 апреля на группу 40 человек + гид Ирина Софронова тел.+7 917 293-48-70 Отель Ногай', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 528, c.id, 'new', '2025-04-08'::date, '2025-04-09'::date, 2, 44, 0, 0, 0, false, 67, 5880, 0, '8 и 9 апреля на группу 42 человека + гид Владимир тел.+7 917 885-84-09 Отель Татарская усадьба ( Марджани 8). Сдал в офис', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 527, c.id, 'new', '2025-04-08'::date, '2025-04-09'::date, 2, 29, 0, 0, 0, false, 65, 3780, 0, '8 и 9 апреля на группу 27 человек + гид Ирина Баталова тел.+7 927 421-36-82 Отель кристал 09.04 в 20:00 сумки в кристалле не было Сумку оставили в IT park', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 526, c.id, 'new', '2025-04-08'::date, '2025-04-10'::date, 3, 47, 0, 0, 0, false, 77, 10800, 0, '8 апреля 45 чел.гид Аида 89033440899 в 7 утра уезжает в Йошкар-Олу для встречи группы там на вокзале. ( наверное опять доставка)…. Сдадут 10 апреля в Кристалл в 19.15', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 525, c.id, 'new', '2025-04-07'::date, '2025-04-09'::date, 3, 39, 0, 0, 0, false, 76, 8880, 0, '7 апреля 37чел.гид Светлана. +79172969340 прибывают в 5 утра на Восстание сдадут 9 апреля в Кристалл после 17', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 524, c.id, 'new', '2025-04-06'::date, '2025-04-06'::date, 1, 14, 0, 0, 0, false, 205, 2870, 0, 'Лилия 13 Наталья 14 Роман 14 В Кремль в 10:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 523, c.id, 'new', '2025-04-06'::date, '2025-04-06'::date, 1, 33, 0, 0, 0, false, 78, 2560, 0, 'Заберут в 8:45. Забрать в кристале', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178605272%' LIMIT 1;

-- SKIP order 522: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 521, c.id, 'new', '2025-04-06'::date, '2025-04-07'::date, 2, 27, 0, 0, 0, false, 74, 4000, 0, '6 апреля гид Гульназ 89393902610 25шт.Прибытие, Казань-2 (Восстание-Пасс.) в 05:25 возвращение так же 7 апреля на Восстание в 19. Попробует оставить в гостинице Карат', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 520, c.id, 'new', '2025-04-08'::date, '2025-04-08'::date, 1, 41, 0, 0, 0, false, 78, 3200, 0, '7 оставить в Татарстан 8 оставит в кристалле', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 519, c.id, 'new', '2025-04-04'::date, '2025-04-04'::date, 1, 33, 0, 0, 0, false, 78, 2560, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178605272%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 518, c.id, 'new', '2025-04-05'::date, '2025-04-07'::date, 3, 45, 0, 0, 0, false, 76, 10320, 0, '5 апреля 43 чел. гид Нелли Рифовна 89063237048 отель кристалл в 7.30 сдадут 7 апреля Кристалл после 17.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 517, c.id, 'new', '2025-04-05'::date, '2025-04-06'::date, 2, 40, 0, 0, 0, false, 76, 6080, 0, '5 апреля Гид Ольга 89503140361 Кристалл в 7.00! 38 чел. сдадут в Кисталл 6 апреля после 17.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 516, c.id, 'new', '2025-04-05'::date, '2025-04-06'::date, 2, 30, 0, 0, 0, false, 75, 4480, 0, '5 апреля 28 чел. Отель Берисон Камала 3* в 9.30 Гид Диляра Рафаровна 89179275489 сдадут 6 апреля отель Кристалл после 15.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 515, c.id, 'new', '2025-04-04'::date, '2025-04-05'::date, 2, 41, 0, 0, 0, false, 76, 6240, 0, '4 апреля гид Ирина Палей 89046620732 39 чел. (созвон, прибытие Восстание в 5 утра) сдадут (созвон 5 апреля возвращение в Казань в 19 на Восстание) Завтрак в Овсянке Оставит в отеле Крисстал, 07.04 в 12:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 514, c.id, 'new', '2025-04-06'::date, '2025-04-08'::date, 3, 44, 0, 0, 0, false, 76, 10080, 0, 'Елена Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9853891999%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 513, c.id, 'new', '2025-04-03'::date, '2025-04-04'::date, 2, 27, 0, 0, 0, false, 74, 4000, 0, 'Заберет в 8:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 512, c.id, 'new', '2025-04-02'::date, '2025-04-02'::date, 1, 24, 0, 0, 0, false, 77, 1840, 0, 'У замка сладостей в 8:45. В кристалле', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 509, c.id, 'new', '2025-04-02'::date, '2025-04-02'::date, 1, 36, 0, 0, 0, false, 78, 2800, 0, 'Заберет 1 апреля в 14:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 508, c.id, 'new', '2025-05-09'::date, '2025-05-10'::date, 2, 41, 0, 0, 0, false, 78, 6400, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9270303303%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 507, c.id, 'new', '2025-04-08'::date, '2025-04-09'::date, 2, 29, 0, 0, 0, false, 65, 3780, 0, 'Кристал В 20:00, 09.04 сумки в кристалле не было. Вернули в Шаляпин', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 506, c.id, 'new', '2025-04-02'::date, '2025-04-04'::date, 3, 21, 0, 0, 0, false, 67, 4200, 0, 'Оставить в Кристале. Забрать в Доме Муллина в СТС', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 505, c.id, 'new', '2025-04-29'::date, '2025-04-30'::date, 2, 31, 0, 0, 0, false, 77, 4800, 0, 'Рамада', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 504, c.id, 'new', '2025-04-01'::date, '2025-04-01'::date, 1, 34, 0, 0, 0, false, 75, 2560, 0, '8:30 у часов Вернут в Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 503, c.id, 'new', '2025-04-01'::date, '2025-04-03'::date, 3, 38, 0, 0, 0, false, 74, 8400, 0, 'Карат', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9042786414%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 502, c.id, 'new', '2025-03-27'::date, '2025-03-27'::date, 1, 33, 0, 0, 0, false, 78, 2560, 0, 'В обед заберут. 14:00 у Свито Холла', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 501, c.id, 'new', '2025-04-26'::date, '2025-04-28'::date, 3, 50, 0, 0, 0, false, 75, 11280, 0, 'Берисон худикова', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 500, c.id, 'new', '2025-03-26'::date, '2025-03-27'::date, 2, 34, 0, 0, 0, false, 66, 4480, 0, 'Кристал Лариса', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

-- SKIP order 499: no phone
-- SKIP order 498: no phone
-- SKIP order 497: no phone
-- SKIP order 496: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 495, c.id, 'new', '2025-05-01'::date, '2025-05-01'::date, 1, 48, 0, 0, 0, false, 78, 3760, 0, 'Крисстал Заканчивает в 19:00 в Давыдов назарбаева', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172922000%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 494, c.id, 'new', '2025-03-23'::date, '2025-03-24'::date, 2, 28, 0, 0, 0, false, 74, 4160, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172922000%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 493, c.id, 'new', '2025-03-23'::date, '2025-03-23'::date, 1, 31, 0, 0, 0, false, 68, 2100, 0, 'Кристал Лариса', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

-- SKIP order 492: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 491, c.id, 'new', '2025-03-23'::date, '2025-03-23'::date, 1, 25, 0, 0, 0, false, 77, 1920, 0, '23 марта 24шт.гид Лилия 89872975449 отель Кристалл в 12.00 отдадут после 19 в отель Волга', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 490, c.id, 'new', '2025-03-23'::date, '2025-03-25'::date, 3, 49, 0, 0, 0, false, 77, 11280, 0, 'Кристал Диляра', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9222673014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 489, c.id, 'new', '2025-03-27'::date, '2025-03-29'::date, 3, 40, 0, 0, 0, false, 76, 9120, 0, 'Доставить экскурсоводу вечером Яндекс доставкой на Фучика. Аида. +7 903 344-08-99 Напомню адрес. Фучика 58 б кв 49 чтоб не было ошибк Оставит в Мано в районе 17 часов', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 488, c.id, 'new', '2025-03-26'::date, '2025-03-28'::date, 3, 47, 0, 0, 0, false, 77, 10800, 0, '26 марта 45 шт отель Кристалл к 11.30 гид Аида89033440899. сдадут 28 в Мано', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 487, c.id, 'new', '2025-03-26'::date, '2025-03-28'::date, 3, 53, 0, 0, 0, false, 77, 12240, 0, '26-28 марта- 51 шт.гид Светлана 89172969340 отель Регата 8.30 вернут 28 марта из Иннополиса возвращаются на ж.д.Восстание в 19.00 Решите, пожалуйста с гидом как лучше. Сдали в Татарстан!', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 486, c.id, 'new', '2025-03-26'::date, '2025-03-27'::date, 2, 43, 0, 0, 0, false, 76, 6560, 0, '26-27 гид Виктория 89196236810 41шт. отель Берисон на Худякова 9.30 Вернула в офис!', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 485, c.id, 'new', '2025-03-25'::date, '2025-03-27'::date, 3, 40, 0, 0, 0, false, 76, 9120, 0, '25-27 марта 38шт. гид Гульназ 89393902610 Кристалл к 11.30 сдадут 27 в кристалл в 22.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 484, c.id, 'new', '2025-03-25'::date, '2025-03-27'::date, 3, 44, 0, 0, 0, false, 76, 10080, 0, '25-27 марта 42шт. отель Ямле в 9.30 гид Эльвира 89172639101 сдадут в Кисталл 27.03 в 13.30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 483, c.id, 'new', '2025-03-24'::date, '2025-03-26'::date, 3, 36, 0, 0, 0, false, 76, 8160, 0, '24 марта 34шт. гид Гульнара 89600389286 15:45-16:30 Обед в Ресторане «ТАТАР»ул. Шигабутдина Марджани 4 . сдадут 26 марта 14:00-15:00 Обед в кафе города. Татарская усадьба Алан Аш ул.Шигабутдина Марджани,8', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 482, c.id, 'new', '2025-03-24'::date, '2025-03-26'::date, 3, 32, 0, 0, 0, false, 75, 7200, 0, '24 марта 30 шт. гид Альбина 89503160154 в Сулейман в 8.40 отдадут 26 марта в Сулейман в 20.30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 481, c.id, 'new', '2025-03-24'::date, '2025-03-24'::date, 1, 50, 0, 0, 0, false, 78, 3920, 0, '24 марта 49шт. в Сулейман к 9.30 сдадут в этот же день 13:00 – 14:00 Обед в кафе города Ресторанный двор ул.Астрономическая 7. гид Ирина 89046620732. Вернули в Офис', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 480, c.id, 'new', '2025-03-23'::date, '2025-03-26'::date, 4, 36, 0, 0, 0, false, 76, 10880, 0, '23 марта 34шт.Гид Ольга 89503140361 15:00 – 16:00 Обед Кафе «Овсянки» ул.Бутлерова 34а отдадут 26 марта 12:00 – 13:30 Обед Ресторанный двор ул.Астрономическая,7', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 479, c.id, 'new', '2025-03-22'::date, '2025-03-24'::date, 3, 25, 0, 0, 0, false, 77, 5760, 0, 'на 22.03 24шт. 8905323704822-гид Нелли Рифовна 09:00 - 10:00 Завтрак Кафе «Овсянки» ул.Бутлерова 34а сдаст 24 марта 19:00 Ужин Кафе Медина ул.Татарстан,7', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 478, c.id, 'new', '2025-03-22'::date, '2025-03-24'::date, 3, 39, 0, 0, 0, false, 76, 8880, 0, 'на 22.03 37 шт гид Аида 89033440899в 13.30 ресторан ТАТАР в кремле,отдаст 24.03 в отель Кристалл после 21', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 477, c.id, 'new', '2025-05-02'::date, '2025-05-03'::date, 2, 50, 0, 0, 0, false, 77, 7680, 0, 'Сулейман начало в 09:00. Забрать в Джузеппе', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9089197168%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 476, c.id, 'new', '2025-05-01'::date, '2025-05-02'::date, 2, 52, 0, 0, 0, false, 77, 8000, 0, 'В 9:00 завтрак', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9006000057%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 475, c.id, 'new', '2025-04-04'::date, '2025-04-04'::date, 1, 14, 0, 0, 0, false, 69, 960, 0, 'С 13:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600565131%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 474, c.id, 'new', '2025-04-06'::date, '2025-04-06'::date, 1, 46, 0, 0, 0, false, 77, 3520, 0, 'В 09:00 заберет сама Две сумки по 22 Оставила в офисе', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9196855619%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 473, c.id, 'new', '2025-04-03'::date, '2025-04-03'::date, 1, 21, 0, 0, 0, false, 76, 1600, 0, 'Заберет из офиса', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033061734%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 472, c.id, 'new', '2025-03-22'::date, '2025-03-23'::date, 2, 24, 0, 0, 0, false, 73, 3520, 0, 'Валерий Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9261608591%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 470, c.id, 'new', '2025-04-18'::date, '2025-04-20'::date, 3, 35, 0, 0, 0, false, 75, 7920, 0, 'Кристал.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 469, c.id, 'new', '2025-05-08'::date, '2025-05-09'::date, 2, 51, 0, 0, 0, false, 78, 8000, 0, '8 мая с 20 до 22 9 мая с 14 до 18 Порядка 50 человек. Отель Европа.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9261409872%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 468, c.id, 'new', '2025-06-13'::date, '2025-06-14'::date, 2, 15, 0, 0, 0, false, 75, 2240, 0, 'В Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 467, c.id, 'new', '2025-04-06'::date, '2025-04-07'::date, 2, 26, 0, 0, 0, false, 77, 4000, 0, '5 апреля в 14:00 заберет. Забрать в новинки', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 466, c.id, 'new', '2025-03-25'::date, '2025-03-29'::date, 5, 18, 0, 0, 0, false, 71, 6400, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 465, c.id, 'new', '2025-03-14'::date, '2025-03-15'::date, 2, 50, 0, 0, 0, false, 77, 7680, 0, 'Гид Елена +79376267304', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9031562454%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 463, c.id, 'new', '2025-03-08'::date, '2025-03-08'::date, 1, 37, 0, 0, 0, false, 78, 2880, 0, 'Гостиница пилигрим. Оставить 8 числа. Забрать 9 числа.', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9161550131%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 462, c.id, 'new', '2025-03-05'::date, '2025-03-05'::date, 1, 18, 0, 0, 0, false, 76, 1360, 0, 'Отель Рамада На имя Валерий', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9950953373%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 461, c.id, 'new', '2025-02-26'::date, '2025-02-26'::date, 1, 52, 0, 0, 0, false, 67, 3500, 0, 'Старт в 15:00 от старого ИТ парка', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 460, c.id, 'new', '2025-02-14'::date, '2025-02-16'::date, 3, 40, 0, 0, 0, false, 65, 7770, 0, 'Кристалл, Казанские Традиции', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172934870%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 459, c.id, 'new', '2025-02-18'::date, '2025-02-19'::date, 2, 26, 0, 0, 0, false, 74, 3840, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 458, c.id, 'new', '2025-02-09'::date, '2025-02-09'::date, 1, 45, 0, 0, 0, false, 78, 3520, 0, 'В 11:00-11:30 они приедут в Татарстан и встретятся там с экскурсоводом, Живут в Волге , +7 960 039-47-90 гид на 10 февраля Инна, они встречаются с группой в 11:00 возле гостиницы Татарстан', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9171014003%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 457, c.id, 'new', '2025-04-29'::date, '2025-04-29'::date, 1, 14, 0, 0, 0, false, 74, 1040, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 455, c.id, 'new', '2025-02-17'::date, '2025-02-19'::date, 3, 52, 0, 0, 0, false, 63, 9840, 0, 'Делать группу так же как 12 февраля', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 454, c.id, 'new', '2025-02-11'::date, '2025-02-11'::date, 1, 52, 0, 0, 0, false, 77, 4000, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 453, c.id, 'new', '2025-07-26'::date, '2025-07-27'::date, 2, 33, 0, 0, 0, false, 75, 4960, 0, 'В школу в 12', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9127740429%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 452, c.id, 'new', '2025-06-12'::date, '2025-06-12'::date, 1, 43, 0, 0, 0, false, 78, 3360, 0, 'Можно так же до 13.00 на Оренбургский тракт 4а. Светлана - +79954723715, для связи. +7 917 878-34-06. Сергей Слободенюк', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9127740429%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 451, c.id, 'new', '2025-05-01'::date, '2025-06-02'::date, 2, 48, 0, 0, 0, false, 77, 7360, 0, 'В 12:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9127740429%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 450, c.id, 'new', '2025-04-30'::date, '2025-04-30'::date, 1, 4, 0, 0, 0, false, 2960, 11840, 0, 'Ривьера', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9270303303%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 449, c.id, 'new', '2025-02-06'::date, '2025-02-08'::date, 3, 32, 0, 0, 0, false, 75, 7200, 0, 'Татарстан Мастерская впечатлений', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9270303303%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 445, c.id, 'new', '2025-04-24'::date, '2025-04-26'::date, 3, 31, 0, 0, 0, false, 75, 6960, 0, 'Кристал. Вернули в кристал. Привезет Ильдар 051', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 444, c.id, 'new', '2025-01-26'::date, '2025-01-26'::date, 1, 12, 0, 0, 0, false, 73, 880, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872821123%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 443, c.id, 'new', '2025-01-25'::date, '2025-01-25'::date, 1, 55, 0, 0, 0, false, 74, 4080, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9022870302%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 442, c.id, 'new', '2025-01-21'::date, '2025-01-22'::date, 2, 54, 0, 0, 0, false, 77, 8320, 0, 'Сулейман Владимир Николаевич', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 441, c.id, 'new', '2025-01-12'::date, '2025-01-12'::date, 1, 33, 0, 0, 0, false, 78, 2560, 0, 'Созвониться 11.01 до обеда', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9276703000%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 440, c.id, 'new', '2025-01-18'::date, '2025-01-18'::date, 1, 20, 0, 0, 0, false, 72, 1440, 0, 'Свита холл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869297050%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 439, c.id, 'new', '2025-01-08'::date, '2025-01-09'::date, 2, 25, 0, 0, 0, false, 64, 3220, 0, 'Волга', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 438, c.id, 'new', '2025-01-04'::date, '2025-01-06'::date, 3, 28, 0, 0, 0, false, 63, 5265, 0, 'Тиц , Баумана', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179064739%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 437, c.id, 'new', '2025-01-04'::date, '2025-01-04'::date, 1, 40, 0, 0, 0, false, 63, 2535, 0, 'Юнион амакс Сафар', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179064739%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 436, c.id, 'new', '2025-01-04'::date, '2025-01-04'::date, 1, 40, 0, 0, 0, false, 63, 2535, 0, 'Юнион релита', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179064739%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 435, c.id, 'new', '2025-01-04'::date, '2025-01-04'::date, 1, 44, 0, 0, 0, false, 64, 2795, 0, 'Юнион, амакс сафар', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179064739%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 434, c.id, 'new', '2025-01-06'::date, '2025-01-07'::date, 2, 48, 0, 0, 0, false, 77, 7360, 0, '6-7.01 гид Марина Рукавишникова +79172526993 6.01 в Сулейман к 9.00 вернут 7.01 после 22.00 в Кристалл', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 433, c.id, 'new', '2025-01-05'::date, '2025-01-07'::date, 3, 28, 0, 0, 0, false, 74, 6240, 0, '5-7 января Гид Владимир Николаевич +7917885840 5,01 в отель Сулейман к 8,30 вернут 7,01 после 18 по созвону, вернул в Сулейман', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 432, c.id, 'new', '2025-01-03'::date, '2025-01-04'::date, 2, 25, 0, 0, 0, false, 74, 3680, 0, '3,4 января.гид Аида +79033440899 3.01 в 14:00 - 14:45 Обед в кафе города Кафе Медина ул.Татарстан,7 вернут 4.01 вернут после 15 в Кристалл', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 431, c.id, 'new', '2025-01-04'::date, '2025-01-05'::date, 2, 42, 0, 0, 0, false, 76, 6400, 0, '4,5 января. Гид Виолетта +79053171049 4.01 в Отель Кристалл 3*к 8.30 вернут 5.01 после 22.00 в Кристалл', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 430, c.id, 'new', '2025-01-03'::date, '2025-01-04'::date, 2, 48, 0, 0, 0, false, 77, 7360, 0, '3.4 января гид Шуравина Ольга +79503140361 3-привезти в ресторан Ферма.ул.Бурхана Шахиди,11 вернут 4.января в отель Сулейман. Обед 12-13', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 429, c.id, 'new', '2024-12-31'::date, '2024-12-31'::date, 1, 46, 0, 0, 0, false, 78, 3600, 0, 'Колобок на Гафури', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9503244678%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 428, c.id, 'new', '2025-01-08'::date, '2025-01-09'::date, 2, 1, 0, 0, 0, false, 4690, 9380, 0, 'Кристал 1 группа 30 человека + гид Ирина 2 группа 37 человек + гид Владимир', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 427, c.id, 'new', '2025-01-06'::date, '2025-01-08'::date, 3, 52, 0, 0, 0, false, 77, 12000, 0, 'Волга Гид Наталья', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9129231660%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 426, c.id, 'new', '2024-12-31'::date, '2025-01-02'::date, 3, 42, 0, 0, 0, false, 76, 9600, 0, 'Заберет сама вечером', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9625552796%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 425, c.id, 'new', '2024-12-31'::date, '2025-01-02'::date, 3, 47, 0, 0, 0, false, 77, 10800, 0, 'Заберет сама вечером', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9625552796%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 424, c.id, 'new', '2024-12-31'::date, '2025-01-02'::date, 2, 50, 0, 0, 0, false, 115, 11520, 0, 'Хаял кушают в 9:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 423, c.id, 'new', '2025-01-06'::date, '2025-01-06'::date, 1, 47, 0, 0, 0, false, 78, 3680, 0, 'вернут в мано', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 422, c.id, 'new', '2024-12-27'::date, '2024-12-29'::date, 2, 30, 0, 0, 0, false, 75, 4480, 0, 'Кристал Владимир Николаевич', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 421, c.id, 'new', '2024-12-21'::date, '2024-12-21'::date, 1, 26, 0, 0, 0, false, 67, 1750, 0, 'На завтра 21.12 на 1 день Нужны гиды для группы 25 человек + гид Владимир т. 89178858409 Оставить для Владимира Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 419, c.id, 'new', '2025-01-05'::date, '2025-01-05'::date, 1, 35, 0, 0, 0, false, 89, 3120, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9127740429%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 418, c.id, 'new', '2025-01-03'::date, '2025-01-03'::date, 1, 47, 0, 0, 0, false, 78, 3680, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9127740429%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 417, c.id, 'new', '2024-12-21'::date, '2024-12-21'::date, 1, 24, 0, 0, 0, false, 77, 1840, 0, 'Экскурсовод Инна', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 416, c.id, 'new', '2025-01-05'::date, '2025-01-07'::date, 3, 31, 0, 0, 0, false, 75, 6960, 0, '5 января начало в 16.00 от хостела Пушкин, (Пушкина 1/55)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

-- SKIP order 414: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 413, c.id, 'new', '2024-12-14'::date, '2024-12-15'::date, 2, 21, 0, 0, 0, false, 72, 3040, 0, 'Карат', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9112872606%' LIMIT 1;

-- SKIP order 412: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 411, c.id, 'new', '2024-12-14'::date, '2024-12-14'::date, 1, 31, 0, 0, 0, false, 77, 2400, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872965880%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 410, c.id, 'new', '2024-12-13'::date, '2024-12-14'::date, 2, 39, 0, 0, 0, false, 76, 5920, 0, 'Гвардейская', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

-- SKIP order 409: no phone
-- SKIP order 408: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 407, c.id, 'new', '2024-12-06'::date, '2024-12-06'::date, 1, 46, 0, 0, 0, false, 68, 3150, 0, 'Шаляпин', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 406, c.id, 'new', '2024-12-05'::date, '2024-12-05'::date, 1, 20, 0, 0, 0, false, 66, 1330, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 405, c.id, 'new', '2024-12-05'::date, '2024-12-05'::date, 1, 16, 0, 0, 0, false, 75, 1200, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274662530%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 404, c.id, 'new', '2024-11-29'::date, '2024-11-29'::date, 1, 16, 0, 0, 0, false, 75, 1200, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274662530%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 403, c.id, 'new', '2024-11-28'::date, '2024-11-28'::date, 1, 59, 0, 0, 0, false, 146, 8640, 0, 'Приедет 13:30 к Шаляпину', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 402, c.id, 'new', '2024-11-26'::date, '2024-11-26'::date, 1, 16, 0, 0, 0, false, 75, 1200, 0, '9:50. У иконы. забрать в кристале', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

-- SKIP order 401: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 400, c.id, 'new', '2024-11-22'::date, '2024-11-22'::date, 1, 50, 0, 0, 0, false, 77, 3840, 0, '+7 917 252-69-93. Марина Рукавишникова 48 шт. В 9.30-19.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 399, c.id, 'new', '2025-01-05'::date, '2025-01-07'::date, 3, 54, 0, 0, 0, false, 77, 12480, 0, 'Оставила в офисе', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 398, c.id, 'new', '2025-01-03'::date, '2025-01-03'::date, 1, 53, 0, 0, 0, false, 78, 4160, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

-- SKIP order 397: no phone
-- SKIP order 396: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 395, c.id, 'new', '2024-11-30'::date, '2024-12-01'::date, 2, 34, 0, 0, 0, false, 75, 5120, 0, 'Прошу Вас выставить счёт на группу 32+1 гид. 30.11-1.12,, завтрак Биляр Палас, гид 89030624411 Елена Анатольевна.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9219733344%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 394, c.id, 'new', '2024-11-18'::date, '2024-11-20'::date, 3, 41, 0, 0, 0, false, 67, 8190, 0, 'Группа Хостел Пушкин, ул.Пушкина 1/55 а на 18-20 ноября 39 человек + гид Лариса т. 89272408250', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 393, c.id, 'new', '2024-11-18'::date, '2024-11-19'::date, 2, 38, 0, 0, 0, false, 66, 5040, 0, 'Группа Хостел Nice, ул. Петербургская 40 б на 18 и 19 ноября 36 человек + гид Татьяна т.89063271840', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 392, c.id, 'new', '2024-11-19'::date, '2024-11-19'::date, 1, 41, 0, 0, 0, false, 78, 3200, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172488804%' LIMIT 1;

-- SKIP order 391: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 390, c.id, 'new', '2024-11-16'::date, '2024-11-18'::date, 3, 24, 0, 0, 0, false, 46, 3300, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033449007%' LIMIT 1;

-- SKIP order 389: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 388, c.id, 'new', '2024-11-15'::date, '2024-11-15'::date, 1, 33, 0, 0, 0, false, 78, 2560, 0, 'Добрый вечер. Заказ на 15.11 в 9 утра , ГОСТ. Кристалл, 32 чел. На имя Элли', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9169501665%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 387, c.id, 'new', '2024-11-10'::date, '2024-11-10'::date, 1, 31, 0, 0, 0, false, 68, 2100, 0, 'Ривьера', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

-- SKIP order 386: no phone
-- SKIP order 385: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 384, c.id, 'new', '2024-11-07'::date, '2024-11-07'::date, 1, 28, 0, 0, 0, false, 77, 2160, 0, '26 шт. радиогидов на 1 день (беру 07.11.(чт) в 14.00)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033888929%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 383, c.id, 'new', '2024-11-04'::date, '2024-11-04'::date, 1, 30, 0, 0, 0, false, 77, 2320, 0, 'Фиолетовые', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033888929%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 382, c.id, 'new', '2024-11-03'::date, '2024-11-03'::date, 1, 25, 0, 0, 0, false, 67, 1680, 0, 'Кристал. Лилия. Мариотт', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 381, c.id, 'new', '2024-11-06'::date, '2024-11-07'::date, 2, 45, 0, 0, 0, false, 78, 7040, 0, 'на 6,7 ноября. Гид Игорь. +7 927 405-50-70 44 шт. В Давыдов на Назарбаева к 10.30. Сдадут7 ноября в Кристалл после 17.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 380, c.id, 'new', '2024-12-31'::date, '2025-01-02'::date, 3, 46, 0, 0, 0, false, 77, 10560, 0, 'Инна +79869297050 Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9272534202%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 379, c.id, 'new', '2024-11-01'::date, '2024-11-01'::date, 1, 45, 0, 0, 0, false, 75, 3360, 0, 'Баумана в 9:50. забрать в Мариотте', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

-- SKIP order 378: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 377, c.id, 'new', '2024-11-05'::date, '2024-11-06'::date, 2, 26, 0, 0, 0, false, 67, 3500, 0, '5.11 в 10.30 Казань 1 прибытие - 6.11 в 17.00 привозим на Казань 1 - Гид: +79872969542 Елена - 140 руб. * 25 наушников = 3 500 руб. - гид оплатит на месте', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9853891999%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 376, c.id, 'new', '2024-11-01'::date, '2024-11-01'::date, 1, 11, 0, 0, 0, false, 73, 800, 0, 'Сулейман начало в 15:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 375, c.id, 'new', '2024-11-03'::date, '2024-11-04'::date, 2, 44, 0, 0, 0, false, 78, 6880, 0, 'Карат на Сары садыковой', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 374, c.id, 'new', '2024-10-31'::date, '2024-11-01'::date, 2, 20, 0, 0, 0, false, 58, 2310, 0, 'Сафар', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 373, c.id, 'new', '2024-11-30'::date, '2024-12-01'::date, 2, 53, 0, 0, 0, false, 77, 8160, 0, 'Гид Елена', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9225115900%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 372, c.id, 'new', '2024-11-16'::date, '2024-11-17'::date, 2, 51, 0, 0, 0, false, 78, 8000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9225115900%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 371, c.id, 'new', '2024-11-09'::date, '2024-11-10'::date, 2, 51, 0, 0, 0, false, 78, 8000, 0, 'Гид Елена Волга 12:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9225115900%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 370, c.id, 'new', '2024-11-03'::date, '2024-11-04'::date, 2, 43, 0, 0, 0, false, 78, 6720, 0, 'И нужно будет 3- 4.11 От меня Данил наберёт и заберёт.Он будет вести нашу группу', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178605272%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 369, c.id, 'new', '2024-10-30'::date, '2024-10-30'::date, 1, 34, 0, 0, 0, false, 49, 1650, 0, 'В офис 14:00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033449007%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 368, c.id, 'new', '2024-10-31'::date, '2024-11-01'::date, 2, 43, 0, 0, 0, false, 78, 6720, 0, 'Добрый вечер. На 31 надо в АМАКС сафар отель 42 шт на 31-1. Гид Игорь +7 927 405-50-70. По поводу возврата созвонитесь, пожалуйста', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 367, c.id, 'new', '2024-10-30'::date, '2024-10-31'::date, 2, 22, 0, 0, 0, false, 67, 2940, 0, 'Добрый вечер, Леонид! Группа 21 человек +гид Лиля т. +7 965 602-05-28 На 2 дня 30 октября и 31 октября Проживают в отеле Булгар, Вишневского 21 Будет возможность?', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 366, c.id, 'new', '2024-10-30'::date, '2024-10-31'::date, 2, 46, 0, 0, 0, false, 78, 7200, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9109939725%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 365, c.id, 'new', '2024-10-28'::date, '2024-10-30'::date, 2, 22, 0, 0, 0, false, 76, 3360, 0, 'На 28 и 30 нужны 21 радиогиды в 13,30 у них сегодня обед в Ресторанном дворе( стерлядке) гид Диляра +7 917 927-54-89', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 364, c.id, 'new', '2024-10-28'::date, '2024-10-28'::date, 1, 22, 0, 0, 0, false, 76, 1680, 0, 'Ольга +79872965880', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9827935377%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 363, c.id, 'new', '2024-10-29'::date, '2024-11-01'::date, 3, 37, 0, 0, 0, false, 78, 8640, 0, '29-31 36шт. 29-в Кристалл к 9.30 сдадут 1 ноября после 16.00 в Кристалл гид Марина +79053130120', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 362, c.id, 'new', '2024-10-28'::date, '2024-10-30'::date, 3, 35, 0, 0, 0, false, 78, 8160, 0, '28-30 34шт. 28-Кристалл в 11.00 гид Игорь +79274055070, сдадут 30-после 16. 12:00 донкихот', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 361, c.id, 'new', '2024-10-28'::date, '2024-10-30'::date, 3, 38, 0, 0, 0, false, 78, 8880, 0, '28-30 37 шт. 28-Кристалл к 12, сдадут 30 по созвону после 15 гид Диана +79274454525', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 360, c.id, 'new', '2024-10-27'::date, '2024-10-29'::date, 3, 35, 0, 0, 0, false, 78, 8160, 0, '27-29 34 шт.27-Сулейман к 8.00 29-сдаст в офис после 15.00 гид Марина +79172526993', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 359, c.id, 'new', '2024-10-27'::date, '2024-10-30'::date, 4, 35, 0, 0, 0, false, 78, 10880, 0, '27-30 34 шт. 27- отель Волга 8.40 завтрак сдадут 30-Кристалл после 21 гид Ольга +79503140361', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 358, c.id, 'new', '2024-10-30'::date, '2024-10-30'::date, 1, 32, 0, 0, 0, false, 78, 2480, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 357, c.id, 'new', '2024-10-28'::date, '2024-10-28'::date, 1, 42, 0, 0, 0, false, 78, 3280, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 356, c.id, 'new', '2024-10-31'::date, '2024-11-01'::date, 2, 24, 0, 0, 0, false, 67, 3220, 0, 'Группа 23 чел+гид Татьяна т.89063271840- 2 дня Оставить 30 октября в отеле Кристал. 1.11. отель болгар', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 355, c.id, 'new', '2024-10-29'::date, '2024-10-29'::date, 1, 18, 0, 0, 0, false, 66, 1190, 0, 'Группа 17 чел+гид Булат т.89376173315 - 1 день Оставить 28 октября в отеле Булгар 2,ул.Вишневского 21*', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 354, c.id, 'new', '2024-10-28'::date, '2024-10-29'::date, 2, 44, 0, 0, 0, false, 68, 6020, 0, '4) Группа 43 чел+гид Ирина т.89274213682 - 2 дня с 28-29 окт, Оставить 27 октября в хостоле "Дом 64", ул Большая Красная 64', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 353, c.id, 'new', '2024-10-26'::date, '2024-10-28'::date, 3, 42, 0, 0, 0, false, 68, 8610, 0, '3) Группа 41 чел+гид Маргарита т.89063263820 -на *3 ДНЯ* с 26-28 окт, на 3й день возращает гид Татьяна т.89063271840 Оставить сегодня в отеле Булгар 2,ул.Вишневского 21*сумка в Шаляпин', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

-- SKIP order 352: no phone
-- SKIP order 351: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 350, c.id, 'new', '2024-11-02'::date, '2024-11-03'::date, 2, 25, 0, 0, 0, false, 77, 3840, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 349, c.id, 'new', '2024-10-26'::date, '2024-10-26'::date, 1, 54, 0, 0, 0, false, 140, 7560, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 348, c.id, 'new', '2024-10-28'::date, '2024-10-28'::date, 1, 54, 0, 0, 0, false, 79, 4240, 0, 'Волга', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172989675%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 347, c.id, 'new', '2024-10-30'::date, '2024-10-31'::date, 2, 50, 0, 0, 0, false, 78, 7840, 0, 'Гранд отель к 12', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9122438485%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 346, c.id, 'new', '2024-10-29'::date, '2024-10-29'::date, 1, 48, 0, 0, 0, false, 140, 6720, 0, '2 группы', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872141100%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 345, c.id, 'new', '2024-10-31'::date, '2024-11-02'::date, 3, 47, 0, 0, 0, false, 69, 9660, 0, 'Лейла +79172488804', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9994502017%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 344, c.id, 'new', '2024-10-31'::date, '2024-11-02'::date, 3, 42, 0, 0, 0, false, 68, 8610, 0, 'Диляра +79179275489', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9994502017%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 343, c.id, 'new', '2024-10-29'::date, '2024-10-31'::date, 3, 50, 0, 0, 0, false, 69, 10290, 0, 'Ангелина +79872050601. Татарская усадьба', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9994502017%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 342, c.id, 'new', '2024-10-26'::date, '2024-10-26'::date, 1, 8, 0, 0, 0, false, 100, 800, 0, 'в 12 заберет', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872902704%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 341, c.id, 'new', '2024-10-28'::date, '2024-10-29'::date, 2, 34, 0, 0, 0, false, 68, 4620, 0, '28.10 в 10.30 Казань 1 прибытие - 29.10 в 17.00 привозим на Казань 1 - Гид: +7 905 316-29-73 Елена - 140 руб. * 33 наушников = 4 620 руб. - гид оплатит на месте', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9853891999%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 340, c.id, 'new', '2024-10-25'::date, '2024-10-26'::date, 2, 45, 0, 0, 0, false, 68, 6160, 0, '25.10 в 7.30 Казань 1 прибытие - 26.10 в 18.30 привозим на Казань 1 - Гид: +7 905 316-29-73 Елена - 140 руб. * 44 наушников = 6 160 руб. - гид оплатит на месте', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9853891999%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 339, c.id, 'new', '2024-10-25'::date, '2024-10-27'::date, 3, 34, 0, 0, 0, false, 75, 7680, 0, 'Жд 11:00 вернут 27.10 в 15:00 Дурсун. +7 919 699-29-68', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9633126228%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 338, c.id, 'new', '2024-10-18'::date, '2024-10-20'::date, 3, 19, 0, 0, 0, false, 72, 4080, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9273838350%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 337, c.id, 'new', '2024-10-26'::date, '2024-10-26'::date, 1, 46, 0, 0, 0, false, 78, 3600, 0, '26.10 в 9 утра поезд, оставить в кристалл', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872231391%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 335, c.id, 'new', '2024-10-16'::date, '2024-10-18'::date, 3, 29, 0, 0, 0, false, 74, 6480, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

-- SKIP order 334: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 333, c.id, 'new', '2024-10-11'::date, '2024-10-13'::date, 2, 40, 0, 0, 0, false, 80, 6400, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9874092737%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 332, c.id, 'new', '2024-10-11'::date, '2024-10-13'::date, 2, 33, 0, 0, 0, false, 99, 6510, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 331, c.id, 'new', '2024-10-27'::date, '2024-10-27'::date, 1, 48, 0, 0, 0, false, 78, 3760, 0, 'Группа приезжает 26 октября в 13:00 и будет ночевать в Фатиме. 27 октября отправится на экскурсию в 08:00 И закончит в 14:00-14:30 у театра кукол', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9068185524%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 330, c.id, 'new', '2024-10-12'::date, '2024-10-12'::date, 1, 53, 0, 0, 0, false, 78, 4160, 0, '14:00 туган авылым', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 329, c.id, 'new', '2024-10-11'::date, '2024-10-11'::date, 1, 107, 0, 0, 0, false, 79, 8400, 0, '13:30 дом чая Забрать в крыльях', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 328, c.id, 'new', '2024-10-11'::date, '2024-10-12'::date, 2, 26, 0, 0, 0, false, 74, 3840, 0, 'Волга', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274900014%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 327, c.id, 'new', '2024-10-12'::date, '2024-10-13'::date, 2, 50, 0, 0, 0, false, 77, 7680, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178605272%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 326, c.id, 'new', '2024-10-30'::date, '2024-10-30'::date, 1, 47, 0, 0, 0, false, 78, 3680, 0, '30-46 шт. в Давыдов на Назарбаева к 10, сдадут в Кристалл в 21 гид Марина +79053130120', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 324, c.id, 'new', '2024-10-30'::date, '2024-11-01'::date, 3, 48, 0, 0, 0, false, 80, 11520, 0, '30-1.11 48 шт. 30-в 11.30 завтрак в Алан аш на Ш.Марджани,8 сдадут 1 ноября в 21.00 в Кристалл гид Нелли Рифовна +79063237048', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 323, c.id, 'new', '2024-10-29'::date, '2024-10-31'::date, 3, 37, 0, 0, 0, false, 78, 8640, 0, '29-31 36шт. 29-Кристалл к 8.30 , сдадут 31-в Кристалл в 18.00 гид Аида +79033440899', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 322, c.id, 'new', '2024-10-29'::date, '2024-10-31'::date, 3, 33, 0, 0, 0, false, 80, 7920, 0, '29-31 (без30) 33 шт. 29- завтрак в Волге в 7.30 гид Игорь +79274055070 сдадут 31 после 17 в Кристалл гид Виолетта +79053171049', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 321, c.id, 'new', '2024-10-28'::date, '2024-10-30'::date, 3, 29, 0, 0, 0, false, 77, 6720, 0, '28-30 28 шт. 28-Кристаллв 13.00 гид Гузель +79033142074 сдадут 30- в 20.00 Кристалл гид Гульназ +79393902610', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 320, c.id, 'new', '2024-10-27'::date, '2024-10-30'::date, 4, 36, 0, 0, 0, false, 58, 8400, 0, '27-30 без 28 октября 35шт.27-кафе Медина на Спартаковской к 8.30 возврат по созвону30 -после 16.00 гид Виолетта +79053171049. Забрать в офисе', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 319, c.id, 'new', '2024-10-27'::date, '2024-10-28'::date, 3, 47, 0, 0, 0, false, 52, 7360, 0, '46 шт. 27-в Кристалл к 11.30 гид Юля +79178863309. сдадут 28- по созвону после 14.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 318, c.id, 'new', '2024-10-26'::date, '2024-10-28'::date, 3, 35, 0, 0, 0, false, 78, 8160, 0, 'оставят в Кристалле 28.10. Гид Дания +79172904415 после 22.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 317, c.id, 'new', '2024-10-27'::date, '2024-10-27'::date, 1, 30, 0, 0, 0, false, 77, 2320, 0, '29 шт. отель Ямле к 9.00 сдадут по договоренности после 14.30 гид Гульназ +79393902610', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 316, c.id, 'new', '2024-10-26'::date, '2024-10-27'::date, 2, 28, 0, 0, 0, false, 77, 4320, 0, '26-27- 27 шт. В Кристалл к 7.30 , сдадут в Кристалл 27.10 после20. 30 26-27 последняя моя запись гид Лилия. +79872975449', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 315, c.id, 'new', '2024-10-26'::date, '2024-10-26'::date, 1, 32, 0, 0, 0, false, 78, 2480, 0, '26 октября к 9.40 в Давыдов на Назарбаева 31 шт на один день сдадут туда же после 17,30 гид Ирина 89274213682', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 314, c.id, 'new', '2024-10-25'::date, '2024-10-27'::date, 3, 31, 0, 0, 0, false, 77, 7200, 0, '25-27 октября в Кристалл к 7,30 сдадут в 17,30 - в Кристалл 30 шт. Гид Диляра Рафаровна +79179275489', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 313, c.id, 'new', '2024-10-25'::date, '2024-10-25'::date, 1, 26, 0, 0, 0, false, 77, 2000, 0, '25 шт. В Кристалл к 11.30 сдадут на Баумана в офис16. 30 гид Виолетта +79053171049', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 310, c.id, 'new', '2024-10-28'::date, '2024-10-30'::date, 3, 34, 0, 0, 0, false, 75, 7680, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 308, c.id, 'new', '2024-10-07'::date, '2024-10-09'::date, 3, 38, 0, 0, 0, false, 74, 8400, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 307, c.id, 'new', '2024-10-05'::date, '2024-10-05'::date, 1, 56, 0, 0, 0, false, 138, 7700, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 306, c.id, 'new', '2024-10-06'::date, '2024-10-08'::date, 3, 28, 0, 0, 0, false, 65, 5460, 0, '6.10 в 10.30 Казань 1 прибытие - 8.10 в 17.00 привозим на Казань 1 - Гид: +79872969542 Елена - 210 руб. * 26 наушников = 5 460 руб. - гид оплатит на месте', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9853891999%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 305, c.id, 'new', '2024-10-04'::date, '2024-10-04'::date, 1, 50, 0, 0, 0, false, 78, 3920, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 304, c.id, 'new', '2024-10-03'::date, '2024-10-05'::date, 3, 27, 0, 0, 0, false, 49, 4000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 303, c.id, 'new', '2024-10-13'::date, '2024-10-13'::date, 1, 55, 0, 0, 0, false, 79, 4320, 0, 'Света', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9631166119%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 302, c.id, 'new', '2024-10-02'::date, '2024-10-03'::date, 2, 28, 0, 0, 0, false, 74, 4160, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

-- SKIP order 301: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 300, c.id, 'new', '2024-10-08'::date, '2024-10-09'::date, 2, 31, 0, 0, 0, false, 63, 3920, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274463215%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 299, c.id, 'new', '2024-10-05'::date, '2024-10-06'::date, 2, 51, 0, 0, 0, false, 77, 7840, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178605272%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 298, c.id, 'new', '2024-09-30'::date, '2024-10-03'::date, 4, 54, 0, 0, 0, false, 77, 16640, 0, '30 . 09 надо 52 радиогида в Кристалле в 7.30 отдадут 3.10 в Кристалл после 15.00 гид Диляра Рафаровна 89179275489', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 297, c.id, 'new', '2024-09-28'::date, '2024-09-28'::date, 1, 49, 0, 0, 0, false, 69, 3360, 0, '46 человек +1 гид Встреча возле ЦУМа ожидается прибытие в 14:00,в 20:30 ужинают в отеле Хаял, и едут на заселение в Биляр Инн, краснокошайская 187 Гид Екатерина +7 927 430-72-44', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 296, c.id, 'new', '2024-09-27'::date, '2024-09-29'::date, 3, 46, 0, 0, 0, false, 77, 10560, 0, '27-29 44 шт. Кристалл 11.30-вернут в Авиатор в 19.00 гид Баталова Ирина 89274213682', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 295, c.id, 'new', '2024-09-27'::date, '2024-09-29'::date, 3, 28, 0, 0, 0, false, 74, 6240, 0, '27-29 26 шт. Кристалл в 10.30, вернут Кристалл в 20.00 гид Шуравина Ольга 89503140361', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 294, c.id, 'new', '2024-09-27'::date, '2024-09-28'::date, 2, 30, 0, 0, 0, false, 75, 4480, 0, '27-28 - 28 шт. Кристалл в 9.00 вернут Кристалл в 14. гид Диляра Рафаровна 89179275489', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 293, c.id, 'new', '2024-09-28'::date, '2024-09-29'::date, 2, 35, 0, 0, 0, false, 66, 4620, 0, 'Кристал Гид: Елена +79872969542', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9853891999%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 292, c.id, 'new', '2024-10-31'::date, '2024-10-31'::date, 1, 46, 0, 0, 0, false, 78, 3600, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9027805858%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 291, c.id, 'new', '2024-09-28'::date, '2024-09-28'::date, 1, 33, 0, 0, 0, false, 78, 2560, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9027805858%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 290, c.id, 'new', '2024-09-27'::date, '2024-09-28'::date, 2, 24, 0, 0, 0, false, 64, 3080, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 289, c.id, 'new', '2024-09-25'::date, '2024-09-28'::date, 4, 53, 0, 0, 0, false, 75, 16000, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600311560%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 288, c.id, 'new', '2024-11-02'::date, '2024-11-02'::date, 1, 50, 0, 0, 0, false, 78, 3920, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033405711%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 287, c.id, 'new', '2024-09-26'::date, '2024-09-26'::date, 1, 34, 0, 0, 0, false, 78, 2640, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033405711%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 286, c.id, 'new', '2024-09-23'::date, '2024-09-23'::date, 1, 51, 0, 0, 0, false, 69, 3500, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 283, c.id, 'new', '2024-10-05'::date, '2024-10-06'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 282, c.id, 'new', '2024-09-28'::date, '2024-09-29'::date, 2, 39, 0, 0, 0, false, 76, 5920, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 281, c.id, 'new', '2024-09-25'::date, '2024-09-27'::date, 3, 51, 0, 0, 0, false, 77, 11760, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 280, c.id, 'new', '2024-09-20'::date, '2024-09-20'::date, 1, 40, 0, 0, 0, false, 76, 3040, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178605272%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 279, c.id, 'new', '2024-09-20'::date, '2024-09-22'::date, 3, 50, 0, 0, 0, false, 77, 11520, 0, 'Забрать в свияжске', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 278, c.id, 'new', '2024-09-20'::date, '2024-09-21'::date, 2, 17, 0, 0, 0, false, 62, 2100, 0, 'Кристал. Сумка 1', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 277, c.id, 'new', '2024-09-20'::date, '2024-09-22'::date, 3, 35, 0, 0, 0, false, 75, 7920, 0, 'В хаял. Вернут в офис. Сумка 2', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 276, c.id, 'new', '2024-09-20'::date, '2024-09-21'::date, 2, 32, 0, 0, 0, false, 75, 4800, 0, 'В хаял. Вернут в кристал. Сумка 10', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 275, c.id, 'new', '2024-09-18'::date, '2024-09-18'::date, 1, 35, 0, 0, 0, false, 78, 2720, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 274, c.id, 'new', '2024-10-31'::date, '2024-11-02'::date, 3, 27, 0, 0, 0, false, 74, 6000, 0, 'Отель Парисон', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9257337010%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 272, c.id, 'new', '2024-12-31'::date, '2024-12-31'::date, 1, 50, 0, 0, 0, false, 100, 0, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9127740429%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 271, c.id, 'new', '2024-09-21'::date, '2024-09-21'::date, 1, 47, 0, 0, 0, false, 78, 3680, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9376267304%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 270, c.id, 'new', '2024-09-17'::date, '2024-09-18'::date, 2, 50, 0, 0, 0, false, 77, 7680, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 269, c.id, 'new', '2024-09-21'::date, '2024-09-21'::date, 1, 31, 0, 0, 0, false, 72, 2240, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 268, c.id, 'new', '2024-10-05'::date, '2024-10-05'::date, 1, 46, 0, 0, 0, false, 137, 6320, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9530225627%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 267, c.id, 'new', '2024-09-14'::date, '2024-09-14'::date, 1, 28, 0, 0, 0, false, 77, 2160, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9277213758%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 266, c.id, 'new', '2024-09-14'::date, '2024-09-14'::date, 1, 34, 0, 0, 0, false, 71, 2400, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9272434367%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 265, c.id, 'new', '2024-09-14'::date, '2024-09-15'::date, 2, 38, 0, 0, 0, false, 76, 5760, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9659400307%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 264, c.id, 'new', '2024-09-13'::date, '2024-09-15'::date, 3, 37, 0, 0, 0, false, 66, 7350, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 263, c.id, 'new', '2024-09-12'::date, '2024-09-16'::date, 5, 20, 0, 0, 0, false, 64, 6400, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

-- SKIP order 262: no phone
-- SKIP order 261: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 260, c.id, 'new', '2024-09-14'::date, '2024-09-14'::date, 1, 48, 0, 0, 0, false, 78, 3760, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9087256018%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 259, c.id, 'new', '2024-09-11'::date, '2024-09-11'::date, 1, 36, 0, 0, 0, false, 78, 2800, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9003225015%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 258, c.id, 'new', '2024-09-07'::date, '2024-09-07'::date, 1, 31, 0, 0, 0, false, 114, 3520, 0, 'Двойной комплект наушников', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9272434367%' LIMIT 1;

-- SKIP order 257: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 256, c.id, 'new', '2024-09-06'::date, '2024-09-06'::date, 1, 39, 0, 0, 0, false, 78, 3040, 0, 'Кристалл к 10.30 38 шт. Гид Диана 89274454525. Вернуть этот день день. Отель Сулейман в 18.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 255, c.id, 'new', '2024-09-28'::date, '2024-09-29'::date, 2, 50, 0, 0, 0, false, 77, 7680, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178605272%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 254, c.id, 'new', '2024-09-06'::date, '2024-09-06'::date, 1, 12, 0, 0, 0, false, 73, 880, 0, '6.09 нужно 11 аудиогидов🙏🏻с 13 до 19', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600565131%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 253, c.id, 'new', '2024-09-07'::date, '2024-09-09'::date, 3, 15, 0, 0, 0, false, 69, 3120, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9053770542%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 252, c.id, 'new', '2024-09-08'::date, '2024-09-11'::date, 3, 52, 0, 0, 0, false, 103, 16000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%0714403848%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 251, c.id, 'new', '2024-09-11'::date, '2024-09-13'::date, 3, 24, 0, 0, 0, false, 73, 5280, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033403252%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 250, c.id, 'new', '2024-09-05'::date, '2024-09-05'::date, 1, 11, 0, 0, 0, false, 73, 800, 0, 'Заберут 10:00 вернут 13:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600565131%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 249, c.id, 'new', '2024-09-05'::date, '2024-09-07'::date, 3, 15, 0, 0, 0, false, 69, 3120, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9053770542%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 248, c.id, 'new', '2024-09-06'::date, '2024-09-07'::date, 2, 49, 0, 0, 0, false, 67, 6580, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 247, c.id, 'new', '2024-09-14'::date, '2024-09-14'::date, 1, 250, 0, 0, 0, false, 90, 22400, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9013633803%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 246, c.id, 'new', '2024-09-06'::date, '2024-09-06'::date, 1, 41, 0, 0, 0, false, 68, 2800, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 245, c.id, 'new', '2024-09-04'::date, '2024-09-06'::date, 3, 31, 0, 0, 0, false, 65, 6090, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 244, c.id, 'new', '2024-09-05'::date, '2024-09-05'::date, 1, 31, 0, 0, 0, false, 68, 2100, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

-- SKIP order 243: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 242, c.id, 'new', '2024-09-28'::date, '2024-09-29'::date, 2, 31, 0, 0, 0, false, 75, 4640, 0, 'Лейла', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9107527951%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 241, c.id, 'new', '2024-08-31'::date, '2024-08-31'::date, 1, 46, 0, 0, 0, false, 80, 3680, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 240, c.id, 'new', '2024-08-31'::date, '2024-08-31'::date, 1, 36, 0, 0, 0, false, 82, 2960, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9068185524%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 239, c.id, 'new', '2024-08-25'::date, '2024-08-25'::date, 1, 34, 0, 0, 0, false, 78, 2640, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178605272%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 238, c.id, 'new', '2024-09-08'::date, '2024-09-08'::date, 1, 45, 0, 0, 0, false, 68, 3080, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 237, c.id, 'new', '2024-09-10'::date, '2024-09-14'::date, 5, 48, 0, 0, 0, false, 66, 15750, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 236, c.id, 'new', '2024-08-24'::date, '2024-08-24'::date, 1, 35, 0, 0, 0, false, 78, 2720, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9028352353%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 235, c.id, 'new', '2024-08-23'::date, '2024-08-23'::date, 1, 44, 0, 0, 0, false, 153, 6720, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9127740429%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 234, c.id, 'new', '2024-08-23'::date, '2024-08-23'::date, 1, 12, 0, 0, 0, false, 73, 880, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872816240%' LIMIT 1;

-- SKIP order 232: no phone
-- SKIP order 231: no phone
-- SKIP order 230: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 229, c.id, 'new', '2024-08-18'::date, '2024-08-18'::date, 1, 45, 0, 0, 0, false, 78, 3520, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 228, c.id, 'new', '2024-09-26'::date, '2024-09-29'::date, 3, 43, 0, 0, 0, false, 76, 9840, 0, 'У Натальи', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9141859919%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 227, c.id, 'new', '2024-10-05'::date, '2024-10-06'::date, 2, 50, 0, 0, 0, false, 100, 0, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 226, c.id, 'new', '2024-08-23'::date, '2024-08-24'::date, 2, 44, 0, 0, 0, false, 76, 6720, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9211263650%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 225, c.id, 'new', '2024-08-22'::date, '2024-08-22'::date, 1, 22, 0, 0, 0, false, 145, 3200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9220064070%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 224, c.id, 'new', '2024-08-21'::date, '2024-08-21'::date, 1, 25, 0, 0, 0, false, 59, 1470, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 223, c.id, 'new', '2024-08-21'::date, '2024-08-22'::date, 2, 39, 0, 0, 0, false, 76, 5920, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 222, c.id, 'new', '2024-08-20'::date, '2024-08-21'::date, 2, 51, 0, 0, 0, false, 67, 6860, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 221, c.id, 'new', '2024-08-16'::date, '2024-08-16'::date, 1, 40, 0, 0, 0, false, 76, 3040, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9874092737%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 220, c.id, 'new', '2024-08-16'::date, '2024-08-17'::date, 2, 45, 0, 0, 0, false, 76, 6880, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274299177%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 219, c.id, 'new', '2024-08-17'::date, '2024-08-17'::date, 1, 39, 0, 0, 0, false, 76, 2960, 0, 'В 11:30 в туган авылым', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9036945019%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 218, c.id, 'new', '2024-08-17'::date, '2024-08-17'::date, 1, 22, 0, 0, 0, false, 76, 1680, 0, 'Болгар отель', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393902610%' LIMIT 1;

-- SKIP order 217: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 216, c.id, 'new', '2024-10-05'::date, '2024-10-05'::date, 1, 50, 0, 0, 0, false, 77, 3840, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9530225627%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 215, c.id, 'new', '2024-09-28'::date, '2024-09-28'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, 'Альбина Николаевна +79503160154', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9530225627%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 214, c.id, 'new', '2024-08-17'::date, '2024-08-17'::date, 1, 57, 0, 0, 0, false, 79, 4480, 0, 'Ирина Совельва', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9530225627%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 213, c.id, 'new', '2024-08-17'::date, '2024-08-17'::date, 1, 1, 0, 0, 0, false, 8160, 8160, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 212, c.id, 'new', '2024-08-15'::date, '2024-08-17'::date, 3, 35, 0, 0, 0, false, 73, 7680, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 211, c.id, 'new', '2024-08-17'::date, '2024-08-21'::date, 5, 52, 0, 0, 0, false, 74, 19200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046623179%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 210, c.id, 'new', '2024-08-19'::date, '2024-08-19'::date, 1, 11, 0, 0, 0, false, 73, 800, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600565131%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 208, c.id, 'new', '2024-08-14'::date, '2024-08-15'::date, 2, 32, 0, 0, 0, false, 75, 4800, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 207, c.id, 'new', '2024-08-13'::date, '2024-08-14'::date, 2, 49, 0, 0, 0, false, 67, 6580, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 206, c.id, 'new', '2024-08-09'::date, '2024-08-10'::date, 2, 36, 0, 0, 0, false, 76, 5440, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274299177%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 205, c.id, 'new', '2024-08-10'::date, '2024-08-12'::date, 3, 50, 0, 0, 0, false, 51, 7680, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9625552796%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 204, c.id, 'new', '2024-08-09'::date, '2024-08-11'::date, 3, 47, 0, 0, 0, false, 77, 10800, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9625552796%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 203, c.id, 'new', '2024-08-09'::date, '2024-08-09'::date, 1, 17, 0, 0, 0, false, 75, 1280, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172733148%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 202, c.id, 'new', '2024-08-10'::date, '2024-08-10'::date, 1, 1, 0, 0, 0, false, 880, 880, 0, 'С 9 до 13 Количество скажут впритык', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9028352353%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 201, c.id, 'new', '2024-08-09'::date, '2024-08-09'::date, 1, 14, 0, 0, 0, false, 74, 1040, 0, 'Заберет сама в районе 15:00', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 200, c.id, 'new', '2024-08-17'::date, '2024-08-17'::date, 1, 44, 0, 0, 0, false, 78, 3440, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9107527951%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 199, c.id, 'new', '2024-08-03'::date, '2024-08-04'::date, 2, 11, 0, 0, 0, false, 80, 1760, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872902704%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 198, c.id, 'new', '2024-08-30'::date, '2024-08-31'::date, 2, 48, 0, 0, 0, false, 77, 7360, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 197, c.id, 'new', '2024-08-28'::date, '2024-08-29'::date, 2, 30, 0, 0, 0, false, 75, 4480, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 196, c.id, 'new', '2024-08-06'::date, '2024-08-07'::date, 2, 43, 0, 0, 0, false, 76, 6560, 0, 'Карат', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 195, c.id, 'new', '2024-08-11'::date, '2024-08-12'::date, 2, 33, 0, 0, 0, false, 75, 4960, 0, 'Азалия', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9220064070%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 194, c.id, 'new', '2024-08-13'::date, '2024-08-13'::date, 1, 1, 0, 0, 0, false, 2400, 2400, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9277213758%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 193, c.id, 'new', '2024-08-02'::date, '2024-08-03'::date, 2, 20, 0, 0, 0, false, 72, 2880, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274299177%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 192, c.id, 'new', '2024-08-02'::date, '2024-08-02'::date, 1, 40, 0, 0, 0, false, 76, 3040, 0, 'Гранд отель', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 191, c.id, 'new', '2024-08-03'::date, '2024-08-03'::date, 1, 47, 0, 0, 0, false, 78, 3680, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9028352353%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 190, c.id, 'new', '2024-08-02'::date, '2024-08-03'::date, 2, 48, 0, 0, 0, false, 67, 6440, 0, 'Живут в Волге', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 189, c.id, 'new', '2024-08-03'::date, '2024-08-06'::date, 4, 34, 0, 0, 0, false, 64, 8680, 0, 'Давыдов ИНН', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 188, c.id, 'new', '2024-08-09'::date, '2024-08-11'::date, 2, 42, 0, 0, 0, false, 76, 6400, 0, 'Используют 9 и 11 оплата по счёту,', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9163108629%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 187, c.id, 'new', '2024-08-02'::date, '2024-08-04'::date, 3, 42, 0, 0, 0, false, 70, 8880, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 186, c.id, 'new', '2024-07-31'::date, '2024-08-01'::date, 2, 33, 0, 0, 0, false, 75, 4960, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 185, c.id, 'new', '2024-07-27'::date, '2024-07-27'::date, 1, 41, 0, 0, 0, false, 78, 3200, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9625795347%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 184, c.id, 'new', '2024-07-27'::date, '2024-07-28'::date, 2, 29, 0, 0, 0, false, 74, 4320, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9028352353%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 183, c.id, 'new', '2024-07-25'::date, '2024-07-25'::date, 1, 10, 0, 0, 0, false, 80, 800, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872902704%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 182, c.id, 'new', '2024-07-26'::date, '2024-07-27'::date, 2, 20, 0, 0, 0, false, 72, 2880, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274299177%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 181, c.id, 'new', '2024-08-29'::date, '2024-08-29'::date, 1, 29, 0, 0, 0, false, 77, 2240, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 180, c.id, 'new', '2024-08-02'::date, '2024-08-03'::date, 2, 44, 0, 0, 0, false, 76, 6720, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9211263650%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 179, c.id, 'new', '2024-07-26'::date, '2024-07-28'::date, 3, 47, 0, 0, 0, false, 94, 13300, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9625552796%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 178, c.id, 'new', '2024-07-27'::date, '2024-07-27'::date, 1, 47, 0, 0, 0, false, 77, 3600, 0, 'Туган авылым', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9036945019%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 177, c.id, 'new', '2024-08-07'::date, '2024-08-08'::date, 2, 22, 0, 0, 0, false, 73, 3200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 176, c.id, 'new', '2024-07-27'::date, '2024-07-27'::date, 1, 50, 0, 0, 0, false, 134, 6720, 0, 'Отель Гагарин', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 175, c.id, 'new', '2024-08-09'::date, '2024-08-11'::date, 2, 51, 0, 0, 0, false, 115, 11760, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 174, c.id, 'new', '2024-07-26'::date, '2024-07-27'::date, 2, 46, 0, 0, 0, false, 120, 11040, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872821123%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 173, c.id, 'new', '2024-07-23'::date, '2024-07-24'::date, 2, 40, 0, 0, 0, false, 66, 5320, 0, 'Волга', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 172, c.id, 'new', '2024-07-21'::date, '2024-07-21'::date, 1, 10, 0, 0, 0, false, 80, 800, 0, 'Без сумки', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872902704%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 171, c.id, 'new', '2024-07-24'::date, '2024-07-27'::date, 4, 46, 0, 0, 0, false, 77, 14080, 0, 'Леонид нам надо будет на 24-27 июня 44 радиогида гид. Владимир Николаевич 89178858409 в отель Давыдов на Назарбаева к 9.30 Записка "для В.Н."', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 170, c.id, 'new', '2024-07-19'::date, '2024-07-21'::date, 3, 42, 0, 0, 0, false, 76, 9600, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 169, c.id, 'new', '2024-07-19'::date, '2024-07-20'::date, 2, 41, 0, 0, 0, false, 76, 6240, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274299177%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 168, c.id, 'new', '2024-07-19'::date, '2024-07-21'::date, 3, 46, 0, 0, 0, false, 77, 10560, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9625552796%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 167, c.id, 'new', '2024-07-17'::date, '2024-07-18'::date, 2, 49, 0, 0, 0, false, 77, 7520, 0, 'Регина на Баумана', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 166, c.id, 'new', '2024-07-20'::date, '2024-07-20'::date, 1, 300, 0, 0, 0, false, 80, 24000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033428060%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 165, c.id, 'new', '2024-07-12'::date, '2024-07-12'::date, 1, 20, 0, 0, 0, false, 100, 0, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9397368972%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 164, c.id, 'new', '2024-07-13'::date, '2024-07-14'::date, 2, 19, 0, 0, 0, false, 72, 2720, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274299177%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 163, c.id, 'new', '2024-07-12'::date, '2024-07-13'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872821123%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 162, c.id, 'new', '2024-07-14'::date, '2024-07-14'::date, 1, 300, 0, 0, 0, false, 80, 24000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033428060%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 161, c.id, 'new', '2024-07-09'::date, '2024-07-10'::date, 2, 27, 0, 0, 0, false, 77, 4160, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274662530%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 160, c.id, 'new', '2024-07-08'::date, '2024-07-08'::date, 1, 2, 0, 0, 0, false, 80, 160, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033414430%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 159, c.id, 'new', '2024-07-07'::date, '2024-07-07'::date, 1, 15, 0, 0, 0, false, 114, 1712, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9397368972%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 158, c.id, 'new', '2024-09-10'::date, '2024-09-11'::date, 2, 39, 0, 0, 0, false, 76, 5920, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9262118230%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 157, c.id, 'new', '2024-07-10'::date, '2024-07-10'::date, 1, 11, 0, 0, 0, false, 73, 800, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9003208221%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 156, c.id, 'new', '2024-07-07'::date, '2024-07-09'::date, 2, 8, 0, 0, 0, false, 75, 1200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 155, c.id, 'new', '2024-07-19'::date, '2024-07-21'::date, 3, 49, 0, 0, 0, false, 67, 9870, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

-- SKIP order 154: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 153, c.id, 'new', '2024-07-06'::date, '2024-07-06'::date, 1, 42, 0, 0, 0, false, 76, 3200, 0, 'Улица Баумана, 15. Хостел на Баумана', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872797484%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 152, c.id, 'new', '2024-07-06'::date, '2024-07-07'::date, 2, 44, 0, 0, 0, false, 73, 6400, 0, 'Кристал', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9867215041%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 151, c.id, 'new', '2024-07-08'::date, '2024-07-08'::date, 1, 300, 0, 0, 0, false, 80, 24000, 0, 'Ит парк Рамеева. 14:30..14:40 примерно', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033428060%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 150, c.id, 'new', '2024-07-06'::date, '2024-07-08'::date, 3, 57, 0, 0, 0, false, 77, 13200, 0, 'Давыдов на Назарбаева к 8.30. На 3 дня. Сдадут 8.07 с 14-15 в Ресторанном дворе. Гид Диана. 89274454525', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 149, c.id, 'new', '2024-07-05'::date, '2024-07-06'::date, 2, 41, 0, 0, 0, false, 76, 6240, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9211263650%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 148, c.id, 'new', '2024-07-05'::date, '2024-07-06'::date, 2, 37, 0, 0, 0, false, 76, 5600, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274299177%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 147, c.id, 'new', '2024-07-21'::date, '2024-07-21'::date, 1, 110, 0, 0, 0, false, 70, 7700, 0, 'Позвонить 19.07', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9991640682%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 146, c.id, 'new', '2024-07-04'::date, '2024-07-04'::date, 1, 55, 0, 0, 0, false, 77, 4240, 0, 'Релита', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872141100%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 145, c.id, 'new', '2024-07-05'::date, '2024-07-06'::date, 2, 46, 0, 0, 0, false, 67, 6160, 0, 'В Волгу 04, вечером', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 144, c.id, 'new', '2024-07-03'::date, '2024-07-03'::date, 1, 39, 0, 0, 0, false, 78, 3040, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274111993%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 143, c.id, 'new', '2024-07-07'::date, '2024-07-07'::date, 1, 31, 0, 0, 0, false, 77, 2400, 0, 'Азалия', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9220064070%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 142, c.id, 'new', '2024-06-30'::date, '2024-06-30'::date, 1, 15, 0, 0, 0, false, 1376, 20640, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9397368972%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 140, c.id, 'new', '2024-06-30'::date, '2024-07-02'::date, 3, 26, 0, 0, 0, false, 74, 5760, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 139, c.id, 'new', '2024-06-28'::date, '2024-06-29'::date, 1, 20, 0, 0, 0, false, 120, 2400, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9397368972%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 138, c.id, 'new', '2024-06-28'::date, '2024-06-30'::date, 3, 42, 0, 0, 0, false, 76, 9600, 0, 'Завтра к 8.30 в Лимончелло 40 шт. На 3 дня. Оставят в Кристалле. Гид Яна +7 952 034-45-43', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 137, c.id, 'new', '2024-09-24'::date, '2024-09-24'::date, 1, 50, 0, 0, 0, false, 77, 3840, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033405711%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 136, c.id, 'new', '2024-06-28'::date, '2024-06-29'::date, 2, 46, 0, 0, 0, false, 77, 7040, 0, 'Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274299177%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 135, c.id, 'new', '2024-06-29'::date, '2024-06-29'::date, 1, 22, 0, 0, 0, false, 76, 1680, 0, 'Новинка', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9101776156%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 134, c.id, 'new', '2024-06-27'::date, '2024-06-29'::date, 3, 6, 0, 0, 0, false, 67, 1200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 133, c.id, 'new', '2024-07-10'::date, '2024-07-10'::date, 1, 100, 0, 0, 0, false, 80, 8000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872961344%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 132, c.id, 'new', '2024-06-29'::date, '2024-06-30'::date, 2, 26, 0, 0, 0, false, 74, 3840, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600362522%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 131, c.id, 'new', '2024-06-27'::date, '2024-06-27'::date, 1, 32, 0, 0, 0, false, 85, 2720, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872797484%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 130, c.id, 'new', '2024-06-25'::date, '2024-06-25'::date, 1, 1, 0, 0, 0, false, 1209, 1209, 0, '15', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9397368972%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 129, c.id, 'new', '2024-06-29'::date, '2024-06-30'::date, 2, 26, 0, 0, 0, false, 65, 3360, 0, '29.06 в 10.00 Аэропорт и вернут 30.06 в 19.30 Аэропорт - 24 наушника - +7 960 036-25-22 алсу', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9853891999%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 128, c.id, 'new', '2024-06-28'::date, '2024-06-28'::date, 1, 46, 0, 0, 0, false, 78, 3600, 0, 'Отель Европа завезти 27 вечером. Забрать там же', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9261409872%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 127, c.id, 'new', '2024-06-23'::date, '2024-06-23'::date, 1, 14, 0, 0, 0, false, 86, 1200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9397368972%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 126, c.id, 'new', '2024-06-22'::date, '2024-06-22'::date, 1, 43, 0, 0, 0, false, 78, 3360, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 125, c.id, 'new', '2024-06-22'::date, '2024-06-22'::date, 1, 51, 0, 0, 0, false, 78, 4000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872797484%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 124, c.id, 'new', '2024-06-25'::date, '2024-06-26'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, 'Двойной комплект наушников', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9534129930%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 123, c.id, 'new', '2024-06-22'::date, '2024-06-22'::date, 1, 58, 0, 0, 0, false, 77, 4480, 0, 'Заберет 21.06, вернет 23.06', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033063787%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 122, c.id, 'new', '2024-06-21'::date, '2024-06-22'::date, 2, 38, 0, 0, 0, false, 76, 5760, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872821123%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 121, c.id, 'new', '2024-06-22'::date, '2024-06-22'::date, 1, 4, 0, 0, 0, false, 3600, 14400, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033414430%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 120, c.id, 'new', '2024-06-21'::date, '2024-06-22'::date, 2, 62, 0, 0, 0, false, 88, 10880, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033414430%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 119, c.id, 'new', '2024-06-29'::date, '2024-06-29'::date, 1, 50, 0, 0, 0, false, 67, 3360, 0, 'Шаляпина', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 118, c.id, 'new', '2024-06-21'::date, '2024-06-23'::date, 3, 36, 0, 0, 0, false, 76, 8160, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9625552796%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 117, c.id, 'new', '2024-07-06'::date, '2024-07-06'::date, 1, 42, 0, 0, 0, false, 76, 3200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 116, c.id, 'new', '2024-06-19'::date, '2024-06-20'::date, 2, 34, 0, 0, 0, false, 75, 5120, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872750395%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 115, c.id, 'new', '2024-06-29'::date, '2024-06-29'::date, 1, 36, 0, 0, 0, false, 78, 2800, 0, '29 июня с 12:00 (привезти к театру Кукол) до 23:00 (оставим в гостинице Татарстан на ваше имя и телефон)', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9068185524%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 114, c.id, 'new', '2024-06-29'::date, '2024-06-30'::date, 2, 31, 0, 0, 0, false, 124, 7700, 0, '29.06 в 10.30 Казань - 1 и вернут 30.06 в 17.00 казань 1 - Гид: +7 987 296-95-42. 29 шт. Елена + +7 927 243-37-92 Ангелина - 26 шт.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9853891999%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 113, c.id, 'new', '2024-06-17'::date, '2024-06-17'::date, 1, 34, 0, 0, 0, false, 78, 2640, 0, 'В фургончике забрать', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 112, c.id, 'new', '2024-05-14'::date, '2024-05-17'::date, 4, 1, 0, 0, 0, false, 3120, 12480, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 111, c.id, 'new', '2024-05-09'::date, '2024-05-11'::date, 3, 1, 0, 0, 0, false, 3760, 11280, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 110, c.id, 'new', '2024-05-09'::date, '2024-05-10'::date, 2, 1, 0, 0, 0, false, 3760, 7520, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 109, c.id, 'new', '2024-05-07'::date, '2024-05-09'::date, 3, 1, 0, 0, 0, false, 5120, 15360, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 108, c.id, 'new', '2024-05-07'::date, '2024-05-07'::date, 1, 1, 0, 0, 0, false, 5360, 5360, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 107, c.id, 'new', '2024-05-05'::date, '2024-05-07'::date, 3, 1, 0, 0, 0, false, 4080, 12240, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 106, c.id, 'new', '2024-06-15'::date, '2024-06-16'::date, 2, 46, 0, 0, 0, false, 77, 7040, 0, 'Забрать в кристалле', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274299177%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 105, c.id, 'new', '2024-06-25'::date, '2024-06-25'::date, 1, 51, 0, 0, 0, false, 63, 3200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9063279749%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 104, c.id, 'new', '2024-06-14'::date, '2024-06-15'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872821123%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 103, c.id, 'new', '2024-06-14'::date, '2024-06-15'::date, 2, 26, 0, 0, 0, false, 74, 3840, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872821123%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 102, c.id, 'new', '2024-06-14'::date, '2024-06-16'::date, 3, 24, 0, 0, 0, false, 73, 5280, 0, 'На 14-16.06 (3 дня) нужны радиогиды на 22 чел. Подвезти нужно 14.06 к 8.30 Давыдов ИНН (К.Маркса, 42).', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9211263650%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 101, c.id, 'new', '2024-06-08'::date, '2024-06-08'::date, 1, 13, 0, 0, 0, false, 74, 960, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033888929%' LIMIT 1;

-- SKIP order 100: no phone
INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 99, c.id, 'new', '2024-06-11'::date, '2024-06-14'::date, 4, 38, 0, 0, 0, false, 76, 11520, 0, 'Уточнить', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872231391%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 98, c.id, 'new', '2024-06-10'::date, '2024-06-10'::date, 1, 47, 0, 0, 0, false, 69, 3220, 0, 'Самовывоз', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033408152%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 97, c.id, 'new', '2024-06-08'::date, '2024-06-09'::date, 2, 33, 0, 0, 0, false, 66, 4340, 0, '8.06 в 5.27 прибывают Казань 2 и 9.06 в 17.00 привозим группу Казань 1 - Гид: +7 905 316-29-73 Елена - 31 радиогид - деньги передаст на месте', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9853891999%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 96, c.id, 'new', '2024-06-25'::date, '2024-06-26'::date, 2, 31, 0, 0, 0, false, 147, 9100, 0, 'Ривьера', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9270303303%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 95, c.id, 'new', '2024-06-07'::date, '2024-06-09'::date, 3, 50, 0, 0, 0, false, 77, 11520, 0, 'Оставить 6 в отеле Давыдов, там же забрать', NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9219471867%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 94, c.id, 'new', '2024-06-22'::date, '2024-06-23'::date, 2, 44, 0, 0, 0, false, 76, 6720, 0, '22.06 гид Владимир+7 917 885-84-09 оставить ему в Медине, Татарстан, 7 в 14.00 42 радиогила. Вернёт он же в 16.00 на рецепшн в Кристалл', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 93, c.id, 'new', '2024-06-18'::date, '2024-06-19'::date, 2, 28, 0, 0, 0, false, 74, 4160, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 92, c.id, 'new', '2024-06-15'::date, '2024-06-16'::date, 2, 28, 0, 0, 0, false, 74, 4160, 0, 'На 15-16 надо 26 радио гидов. Заберёт Марсель +7 904 762-46-40 лимончелло к 9.00. Сдаст 16 июня Никита в 19.00 в рфис. Оставили в кристале', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 91, c.id, 'new', '2024-06-11'::date, '2024-06-13'::date, 3, 26, 0, 0, 0, false, 74, 5760, 0, '11-13 июня 24 шт. возьмет Диана 89274454525 в 15.30 в нац музее..сдаст Ирина 89046620732 в Туган Авлым с 18-19часов.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 90, c.id, 'new', '2024-06-11'::date, '2024-06-12'::date, 2, 37, 0, 0, 0, false, 76, 5600, 0, '11-12 июня 35 радиогидов.Наш гид Ольга 89503140361 оставить в кафе Лимончелло в 9.00 сдаст на Баумана Вам в офис примерно в 17.30-18.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 89, c.id, 'new', '2024-06-04'::date, '2024-06-06'::date, 2, 33, 0, 0, 0, false, 75, 4960, 0, 'Завезти в отель Венера. Вернут в Кристал. Марина. +7 917 252-69-93', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 88, c.id, 'new', '2024-06-04'::date, '2024-06-04'::date, 1, 19, 0, 0, 0, false, 76, 1440, 0, 'Калинина 60', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872965880%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 87, c.id, 'new', '2024-06-04'::date, '2024-06-04'::date, 1, 56, 0, 0, 0, false, 69, 3850, 0, 'Регина на Питербуржской', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 86, c.id, 'new', '2024-06-03'::date, '2024-06-04'::date, 2, 22, 0, 0, 0, false, 73, 3200, 0, 'Азалия. На имя Наталья', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9624554760%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 85, c.id, 'new', '2024-06-07'::date, '2024-06-07'::date, 1, 44, 0, 0, 0, false, 78, 3440, 0, 'На 7.06 43 шт Либо я вечером 6-го заберу, либо нужно привезти 7 июня на Северный вокзал к 7.48', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9869297050%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 84, c.id, 'new', '2024-06-02'::date, '2024-06-03'::date, 2, 29, 0, 0, 0, false, 74, 4320, 0, '+7 917 270-83-69. гид Татьяна Александровна Давыдов Инн на Карла Маркса. На 2 дня 27 человек. Вернут в хаял в 15.00', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 83, c.id, 'new', '2024-06-01'::date, '2024-06-01'::date, 1, 26, 0, 0, 0, false, 77, 2000, 0, 'Заберет в 8:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872821123%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 82, c.id, 'new', '2024-06-05'::date, '2024-06-05'::date, 1, 46, 0, 0, 0, false, 68, 3150, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 81, c.id, 'new', '2024-06-01'::date, '2024-06-02'::date, 2, 47, 0, 0, 0, false, 78, 7360, 0, 'Оставить в Арон', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178605272%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 80, c.id, 'new', '2024-07-06'::date, '2024-07-06'::date, 1, 47, 0, 0, 0, false, 78, 3680, 0, 'Утром в 8:00 у Кремля', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9270303303%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 79, c.id, 'new', '2024-06-01'::date, '2024-06-02'::date, 2, 53, 0, 0, 0, false, 77, 8160, 0, 'После 14:00 позвонить Алене, в нагай', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172733148%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 78, c.id, 'new', '2024-05-30'::date, '2024-05-31'::date, 1, 1, 0, 0, 0, false, 7600, 7600, 0, 'Забрать из Шаляпина', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274662530%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 77, c.id, 'new', '2024-05-29'::date, '2024-05-29'::date, 1, 12, 0, 0, 0, false, 73, 880, 0, 'Заберет сама', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9274662530%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 76, c.id, 'new', '2024-05-31'::date, '2024-05-31'::date, 1, 12, 0, 0, 0, false, 73, 880, 0, 'В обед 13:00 у аптеки', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046623179%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 75, c.id, 'new', '2024-06-01'::date, '2024-06-02'::date, 2, 42, 0, 0, 0, false, 65, 5460, 0, '1.06 в 5.27 прибывают Казань 2 и 2.06 в 17.00 привозим группу Казань 1 - Гид: +7 927 243-37-92 Ангелина - деньги передаст на месте', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9853891999%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 74, c.id, 'new', '2024-05-28'::date, '2024-05-30'::date, 2, 24, 0, 0, 0, false, 73, 3520, 0, '22 чел к 14 в Ресторанный двор гид Марина +7 917 252-69-93. На 28 и 30. Сдаст в Кристалл.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 73, c.id, 'new', '2024-05-29'::date, '2024-05-29'::date, 1, 48, 0, 0, 0, false, 39, 1880, 0, 'Лазука', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 72, c.id, 'new', '2024-05-27'::date, '2024-05-27'::date, 1, 52, 0, 0, 0, false, 77, 4000, 0, 'Сама заберет', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9276797970%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 71, c.id, 'new', '2024-07-01'::date, '2024-07-02'::date, 2, 34, 0, 0, 0, false, 75, 5120, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9107527951%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 70, c.id, 'new', '2024-05-26'::date, '2024-05-28'::date, 3, 50, 0, 0, 0, false, 75, 11280, 0, 'Живут в Волге. Группа из донецка', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9493022939%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 69, c.id, 'new', '2024-07-14'::date, '2024-07-15'::date, 2, 1, 0, 0, 0, false, 100, 0, 0, 'Уточнить по количеству', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9211263650%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 68, c.id, 'new', '2024-07-29'::date, '2024-07-31'::date, 3, 44, 0, 0, 0, false, 76, 10080, 0, 'Татарстан вечером 28 числа', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9627930811%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 67, c.id, 'new', '2024-07-05'::date, '2024-07-06'::date, 2, 51, 0, 0, 0, false, 55, 5600, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9127740429%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 66, c.id, 'new', '2024-08-24'::date, '2024-08-25'::date, 2, 51, 0, 0, 0, false, 78, 8000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9127740429%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 65, c.id, 'new', '2024-07-16'::date, '2024-07-17'::date, 2, 52, 0, 0, 0, false, 77, 8000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9127740429%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 64, c.id, 'new', '2024-06-25'::date, '2024-06-26'::date, 2, 47, 0, 0, 0, false, 77, 7200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178761282%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 63, c.id, 'new', '2024-06-15'::date, '2024-06-15'::date, 1, 36, 0, 0, 0, false, 68, 2450, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 62, c.id, 'new', '2024-05-13'::date, '2024-05-13'::date, 1, 31, 0, 0, 0, false, 68, 2100, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 61, c.id, 'new', '2024-05-11'::date, '2024-05-13'::date, 3, 51, 0, 0, 0, false, 67, 10290, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 60, c.id, 'new', '2024-05-10'::date, '2024-05-11'::date, 2, 46, 0, 0, 0, false, 77, 7040, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178761282%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 59, c.id, 'new', '2024-05-10'::date, '2024-05-11'::date, 2, 19, 0, 0, 0, false, 55, 2100, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 58, c.id, 'new', '2024-05-07'::date, '2024-05-09'::date, 3, 38, 0, 0, 0, false, 66, 7560, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9994502017%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 57, c.id, 'new', '2024-05-01'::date, '2024-05-03'::date, 3, 38, 0, 0, 0, false, 66, 7560, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9994502017%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 56, c.id, 'new', '2024-05-01'::date, '2024-05-03'::date, 3, 39, 0, 0, 0, false, 66, 7770, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9994502017%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 55, c.id, 'new', '2024-04-10'::date, '2024-04-12'::date, 3, 40, 0, 0, 0, false, 66, 7980, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9853891999%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 54, c.id, 'new', '2024-04-26'::date, '2024-04-26'::date, 1, 21, 0, 0, 0, false, 76, 1600, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178761282%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 53, c.id, 'new', '2024-04-26'::date, '2024-04-26'::date, 1, 62, 0, 0, 0, false, 90, 5600, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178761282%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 52, c.id, 'new', '2024-04-25'::date, '2024-04-25'::date, 1, 102, 0, 0, 0, false, 78, 8000, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178761282%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 51, c.id, 'new', '2024-04-16'::date, '2024-04-17'::date, 2, 18, 0, 0, 0, false, 71, 2560, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 50, c.id, 'new', '2024-04-12'::date, '2024-04-12'::date, 1, 21, 0, 0, 0, false, 76, 1600, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178761282%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 49, c.id, 'new', '2024-05-26'::date, '2024-05-28'::date, 3, 1, 0, 0, 0, false, 1667, 5000, 0, 'Легче мы приезжаем 26 мая в11 часов нас 29 + Гид ты сказал за5000 сделаешь буду благодарна выезд 28 мая. Экскурсовод Дина +7 919 699-29-68', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9633126228%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 48, c.id, 'new', '2024-05-26'::date, '2024-05-26'::date, 1, 27, 0, 0, 0, false, 77, 2080, 0, '26 мая отель Давыдов Инн на К. Маркса 9.45 до 17 ч. Гид Дания. +7 917 290-44-15 надо26 шт. Забирать там же в этот же день', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 47, c.id, 'new', '2024-05-24'::date, '2024-05-24'::date, 1, 41, 0, 0, 0, false, 68, 2800, 0, 'Начало в 16:00. Улица Карла Маркса, 11а. Кarl House', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9662409276%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 46, c.id, 'new', '2024-05-25'::date, '2024-05-25'::date, 1, 53, 0, 0, 0, false, 69, 3640, 0, 'Завтракают в Волге . Для Екатерины +7 927 430‑72‑44. Забрать Гостиница Болгар', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 45, c.id, 'new', '2024-10-05'::date, '2024-10-06'::date, 2, 49, 0, 0, 0, false, 77, 7520, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 44, c.id, 'new', '2024-06-05'::date, '2024-06-06'::date, 2, 31, 0, 0, 0, false, 75, 4640, 0, 'В Сулейман', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 43, c.id, 'new', '2024-06-14'::date, '2024-06-16'::date, 3, 42, 0, 0, 0, false, 76, 9600, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9994502017%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 42, c.id, 'new', '2024-07-27'::date, '2024-07-27'::date, 1, 47, 0, 0, 0, false, 78, 3680, 0, 'Добрый день, Леонид, заказ на 27 июля на 46 человек,группа из Пензы. Экскурсовод Татьяна т.89063271840 и 89503287480.', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9022038859%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 41, c.id, 'new', '2024-05-29'::date, '2024-05-30'::date, 2, 31, 0, 0, 0, false, 77, 4800, 0, 'Забрать в Татаринн на Марджани', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872965880%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 40, c.id, 'new', '2024-05-23'::date, '2024-05-23'::date, 1, 26, 0, 0, 0, false, 77, 2000, 0, 'До 11:00 КНИИТУ (К.Маркса, 68) Просим передать Ирине Дубровской: +7 927 403 99 95. Забрать из офиса Экскурс в обед', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9393309448%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 39, c.id, 'new', '2024-05-22'::date, '2024-05-23'::date, 2, 40, 0, 0, 0, false, 74, 5920, 0, 'Забрать в Мано', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178761282%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 38, c.id, 'new', '2024-05-26'::date, '2024-05-26'::date, 1, 23, 0, 0, 0, false, 77, 1760, 0, '26 мая 22 чел в 11.30 Оставить в кристалле. Для Екатерины. Забрать в татарской усадьбе', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9178761282%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 37, c.id, 'new', '2024-04-30'::date, '2024-05-01'::date, 2, 1, 0, 0, 0, false, 3280, 6560, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 36, c.id, 'new', '2024-04-30'::date, '2024-04-30'::date, 1, 1, 0, 0, 0, false, 3280, 3280, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 35, c.id, 'new', '2024-04-28'::date, '2024-04-29'::date, 2, 1, 0, 0, 0, false, 2240, 4480, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 34, c.id, 'new', '2024-04-28'::date, '2024-04-29'::date, 2, 1, 0, 0, 0, false, 2640, 5280, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 33, c.id, 'new', '2024-04-28'::date, '2024-04-28'::date, 1, 1, 0, 0, 0, false, 2160, 2160, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 32, c.id, 'new', '2024-04-27'::date, '2024-04-27'::date, 1, 1, 0, 0, 0, false, 1840, 1840, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 31, c.id, 'new', '2024-04-22'::date, '2024-04-23'::date, 2, 1, 0, 0, 0, false, 1760, 3520, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 30, c.id, 'new', '2024-04-21'::date, '2024-04-22'::date, 2, 1, 0, 0, 0, false, 1840, 3680, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 29, c.id, 'new', '2024-04-20'::date, '2024-04-20'::date, 1, 1, 0, 0, 0, false, 1200, 1200, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 28, c.id, 'new', '2024-04-18'::date, '2024-04-18'::date, 1, 1, 0, 0, 0, false, 3760, 3760, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 27, c.id, 'new', '2024-04-17'::date, '2024-04-18'::date, 2, 1, 0, 0, 0, false, 3680, 7360, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 26, c.id, 'new', '2024-04-09'::date, '2024-04-09'::date, 1, 1, 0, 0, 0, false, 2480, 2480, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 25, c.id, 'new', '2024-04-09'::date, '2024-05-11'::date, 3, 1, 0, 0, 0, false, 3760, 11280, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 24, c.id, 'new', '2024-04-07'::date, '2024-04-09'::date, 3, 1, 0, 0, 0, false, 2960, 8880, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 23, c.id, 'new', '2024-04-05'::date, '2024-04-06'::date, 2, 1, 0, 0, 0, false, 2960, 5920, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 22, c.id, 'new', '2024-05-24'::date, '2024-05-24'::date, 1, 62, 0, 0, 0, false, 77, 4800, 0, 'Группа 60 чел в свияжск делиться на 2 группы. Положить 2 передатчика. Отправить видео по настройке', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9033443111%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 19, c.id, 'new', '2024-05-17'::date, '2024-05-19'::date, 3, 45, 0, 0, 0, false, 76, 10320, 0, NULL, NULL, 'Стас', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 18, c.id, 'new', '2024-05-24'::date, '2024-05-26'::date, 3, 44, 0, 0, 0, false, 107, 14080, 0, 'Сами', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172278327%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 17, c.id, 'new', '2024-06-28'::date, '2024-06-30'::date, 3, 28, 0, 0, 0, false, 74, 6240, 0, 'Кристал. Забрать дом чая 30 числа в 15:30', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9262118230%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 16, c.id, 'new', '2024-05-27'::date, '2024-05-29'::date, 3, 46, 0, 0, 0, false, 50, 6880, 0, 'Оставили в кристале', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872827166%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 15, c.id, 'new', '2024-05-24'::date, '2024-05-26'::date, 3, 48, 0, 0, 0, false, 77, 11040, 0, '8:30 гостиница Татарстан. +7 960 036‑74‑49', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9159613586%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 14, c.id, 'new', '2024-05-20'::date, '2024-05-20'::date, 1, 42, 0, 0, 0, false, 78, 3280, 0, 'в 11:40 отель Наган', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9872797484%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 13, c.id, 'new', '2024-05-31'::date, '2024-05-31'::date, 1, 33, 0, 0, 0, false, 78, 2560, 0, '31 мая отель Легенда к 8.00 до 17.00 оставят там же . 32 шт гид Ирина +7 904 662-07-32', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 12, c.id, 'new', '2024-05-27'::date, '2024-05-29'::date, 3, 54, 0, 0, 0, false, 77, 12480, 0, 'Передать вечером Татьяне. Положить запасные наушники', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9994502017%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 11, c.id, 'new', '2024-05-26'::date, '2024-05-28'::date, 3, 49, 0, 0, 0, false, 77, 11280, 0, 'Передать Лейле. В Кристал', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9107527951%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 9, c.id, 'new', '2024-05-25'::date, '2024-05-27'::date, 2, 28, 0, 0, 0, false, 74, 4160, 0, '25 мая к 8.15 отель Давыдов Инн на К. Маркса 26 шт. Вернут 27 мая в 17 отель Кристалл! Им надо на 25 и 27. Гид Палей Ирина +7 904 662-07-32', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 8, c.id, 'new', '2024-05-24'::date, '2024-05-25'::date, 2, 28, 0, 0, 0, false, 74, 4160, 0, '26 шт. В Биляр к 8.00 гид Диана +7 927 242-10-38. Отдаст их гид Марина 25 мая в20. 00 в Кристалле', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 7, c.id, 'new', '2024-05-24'::date, '2024-05-25'::date, 2, 32, 0, 0, 0, false, 75, 4800, 0, 'На завтра 24 мая 30 шт в Сулейман до 9.45 гид Баталова Ирина. +7 927 421-36-82, вернет25 мая в 20.00 в Сулейман', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 6, c.id, 'new', '2024-05-23'::date, '2024-05-24'::date, 2, 24, 0, 0, 0, false, 73, 3520, 0, 'Оставить и забрать из кристалла , Гид Гульназ +7 939 390-26-10', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9179142756%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 5, c.id, 'new', '2024-05-20'::date, '2024-05-20'::date, 1, 41, 0, 0, 0, false, 68, 2800, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9172751068%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 4, c.id, 'new', '2024-05-20'::date, '2024-05-20'::date, 1, 20, 0, 0, 0, false, 72, 1440, 0, NULL, NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9600336033%' LIMIT 1;

INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, created_at, updated_at)
SELECT 3, c.id, 'new', '2024-05-19'::date, '2024-05-20'::date, 2, 32, 0, 0, 0, false, 66, 4200, 0, 'ЖД1 в 13:30 гид Татьяна +79063271840', NULL, 'Леонид', NOW(), NOW()
FROM rental_clients c WHERE c.phone LIKE '%9046699399%' LIMIT 1;

