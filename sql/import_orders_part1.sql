-- Часть 1 из 7
DO $$
DECLARE
  leonid_id UUID;
  leonid_name TEXT;
  stas_id UUID;
  stas_name TEXT;
  client_id UUID;
BEGIN
  SELECT id, display_name INTO leonid_id, leonid_name FROM profiles WHERE display_name ILIKE '%Леонид%' LIMIT 1;
  SELECT id, display_name INTO stas_id, stas_name FROM profiles WHERE display_name ILIKE '%Стас%' LIMIT 1;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1273, client_id, 'issued', '2025-12-20', '2025-12-21', 2, 26, 0, 0, 0, NULL, false, 0, 4000.0, 0, 'В кристалл Катя Ильина Ваучер Кремль и свияжск', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1272, client_id, 'returned', '2025-12-19', '2025-12-19', 1, 44, 0, 0, 0, NULL, true, 0, 3440.0, 3440.0, '43 радиогида в 9:30 от отеля Рамада. И один ваучер на Кремль . Гид Катя Ильина', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%София%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1271, client_id, 'new', '2026-01-03', '2026-01-05', 3, 45, 0, 0, 0, NULL, false, 0, 12900.0, 0, 'Заберет сама', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1270, client_id, 'new', '2026-01-09', '2026-01-09', 1, 36, 0, 0, 0, NULL, false, 0, 3500.0, 0, 'Из АйТи парка в АйТи парк', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1269, client_id, 'new', '2026-01-09', '2026-01-09', 1, 31, 0, 0, 0, NULL, false, 0, 3000.0, 0, 'Из Сафара в Релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1268, client_id, 'new', '2026-01-06', '2026-01-06', 1, 42, 0, 0, 0, NULL, false, 0, 4100.0, 0, 'Из Сафара в Релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1267, client_id, 'new', '2026-01-05', '2026-01-05', 1, 40, 0, 0, 0, NULL, false, 0, 3900.0, 0, 'Из АйТи парка в АйТи парк', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1266, client_id, 'new', '2026-01-05', '2026-01-05', 1, 45, 0, 0, 0, NULL, false, 0, 4400.0, 0, 'Из Сафара в Релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1265, client_id, 'new', '2026-01-04', '2026-01-04', 1, 24, 0, 0, 0, NULL, false, 0, 2300.0, 0, 'Уточнить', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1264, client_id, 'new', '2026-01-04', '2026-01-04', 1, 39, 0, 0, 0, NULL, false, 0, 3800.0, 0, 'Из АйТи парка в АйТи парк', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1263, client_id, 'new', '2026-01-04', '2026-01-04', 1, 45, 0, 0, 0, NULL, false, 0, 4400.0, 0, 'Из Сафара в Релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1262, client_id, 'new', '2026-01-03', '2026-01-03', 1, 45, 0, 0, 0, NULL, false, 0, 4400.0, 0, 'Из Сафара в Релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1261, client_id, 'new', '2026-01-02', '2026-01-02', 1, 46, 0, 0, 0, NULL, false, 0, 4500.0, 0, 'Уточнить откуда, вернут в Стерлядку', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1260, client_id, 'new', '2025-12-31', '2025-12-31', 1, 29, 0, 0, 0, NULL, false, 0, 2240.0, 0, 'Из Сафара в Релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1259, client_id, 'new', '2025-12-31', '2025-12-31', 1, 32, 0, 0, 0, NULL, false, 0, 2480.0, 0, 'Из АйТи парка в АйТи парк', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1258, client_id, 'new', '2026-01-07', '2026-01-09', 3, 42, 0, 0, 0, NULL, false, 0, 12000.0, 0, 'Уточнить', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1257, client_id, 'new', '2026-01-06', '2026-01-06', 1, 46, 0, 0, 0, NULL, false, 0, 4500.0, 0, 'Уточнить', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1256, client_id, 'new', '2026-01-03', '2026-01-05', 3, 47, 0, 0, 0, NULL, false, 0, 13500.0, 0, 'Уточнить', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1255, client_id, 'new', '2026-01-08', '2026-01-08', 1, 37, 0, 0, 0, NULL, false, 0, 3500.0, 0, 'Уточнить', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1254, client_id, 'new', '2026-01-06', '2026-01-08', 3, 37, 0, 0, 0, NULL, false, 0, 10500.0, 0, 'Уточнить', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1253, client_id, 'new', '2026-01-04', '2026-01-06', 3, 50, 0, 0, 0, NULL, false, 0, 14400.0, 0, 'Уточнить', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1252, client_id, 'new', '2026-01-03', '2026-01-05', 3, 44, 0, 0, 0, NULL, false, 0, 12600.0, 0, 'Уточнить', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1251, client_id, 'new', '2026-01-02', '2026-01-04', 3, 50, 0, 0, 0, NULL, false, 0, 14400.0, 0, 'Уточнить', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1250, client_id, 'completed', '2025-12-18', '2025-12-18', 1, 46, 0, 0, 0, NULL, true, 0, 4500.0, 4500.0, 'Завезти в Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1249, client_id, 'new', '2026-01-06', '2026-01-06', 1, 46, 0, 0, 0, NULL, false, 0, 4500.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1248, client_id, 'returned', '2025-12-18', '2025-12-20', 3, 32, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'В офис Вернут в Азимут после 20:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1247, client_id, 'returned', '2025-12-17', '2025-12-19', 3, 36, 0, 0, 0, NULL, true, 0, 7920.0, 7920.0, 'В офис с 14 до 17', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1246, client_id, 'completed', '2025-12-12', '2025-12-12', 1, 41, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Заберут в 10 с Баумана', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1245, client_id, 'returned', '2025-12-12', '2025-12-12', 1, 31, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'Вернут в офис вечером, гид Эльвира, м Полина', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1244, client_id, 'new', '2025-12-06', '2025-12-07', 2, 40, 0, 0, 0, NULL, false, 0, 8000.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1243, client_id, 'new', '2026-01-03', '2026-01-04', 2, 40, 0, 0, 0, NULL, false, 0, 8000.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1242, client_id, 'new', '2025-12-31', '2026-01-01', 2, 40, 0, 0, 0, NULL, false, 0, 8000.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1241, client_id, 'returned', '2025-12-13', '2025-12-13', 1, 21, 0, 0, 0, NULL, true, 0, 1600.0, 1600.0, 'Из Сафара в релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена (Конгресс Авиа)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1240, client_id, 'completed', '2025-12-10', '2025-12-10', 1, 16, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, 'В Марриот до 9:30 Оставят в Каспийске после 16;00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1239, client_id, 'returned', '2025-12-08', '2025-12-08', 1, 55, 0, 0, 0, NULL, true, 0, 4320.0, 4320.0, '07.12 с 8:30 до 11:00 заберут от Свита Холла •Рузиля 54шт / оставит после 15:00 в фургончике (+7 965 603-40-01)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1238, client_id, 'returned', '2025-12-08', '2025-12-09', 2, 27, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, '07.12 с 8:30 до 11:00 заберут от Свита Холла •Снежанна 26шт + 20 доп наушников / оставит 08.12 у свита Холла (+7 927 414-91-01)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1237, client_id, 'cancelled', '2025-12-07', '2025-12-07', 1, 25, 0, 0, 0, NULL, false, 0, 2400.0, 0, 'Карина К 18:00 заберут из фургончика, закончат в 22:00 сообщат куда оставят', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1236, client_id, 'returned', '2025-12-08', '2025-12-09', 2, 48, 0, 0, 0, NULL, true, 0, 5840.0, 5840.0, '07.12 с 8:30 до 11:00 заберут от Свита Холла •Елена 47шт + 26 доп наушников / оставит 08.12 у свита Холла (+7 927 401-58-22)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1235, client_id, 'returned', '2025-12-08', '2025-12-09', 2, 50, 0, 0, 0, NULL, true, 0, 10160.0, 10160.0, '07.12 с 8:30 до 11:00 заберут от Свита Холла •Эльмира 49шт + 78 доп наушников / оставит 08.12 в Кристалле (+7 917 878-83-60)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1234, client_id, 'returned', '2025-12-08', '2025-12-09', 2, 31, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, '06.12 вечером в Кристалл •Ирина 30шт + 20 доп наушников / оставит 08.12 у Свита Холла (+7 917 293-48-70)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1233, client_id, 'returned', '2025-12-08', '2025-12-08', 2, 44, 0, 0, 0, NULL, true, 0, 6560.0, 6560.0, '06.12 вечером в Амакс Сафар •Ольга 43 + 39 доп наушников / оставит 08.12 в Кристалл (+7 950 314-03-61)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1232, client_id, 'returned', '2025-12-05', '2025-12-05', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, '35 радиогидов . И один ваучер на свияжск и один на Кремль . Завтра 9:00 отель Азимут ул.Право-Булачная д.43/1. Гид Нина Максимова', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1231, client_id, 'returned', '2025-12-05', '2025-12-05', 1, 28, 0, 0, 0, NULL, true, 0, 2160.0, 2160.0, '04.12 вечером или 05.12 до 11:00 в Кристалл! Гульназ 27шт / оставит в Амакс после 14:30 (+7 939 390-26-10)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1230, client_id, 'returned', '2025-12-05', '2025-12-05', 1, 31, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, '04.12 вечером или 05.12 до 11:00 в Кристалл! Светлана 30шт / оставит в Амакс после 14:30 (+7 967 780-00-66)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1229, client_id, 'returned', '2025-12-05', '2025-12-05', 1, 47, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, '04.12 вечером или 05.12 до 11:00 в Кристалл! •Татьяна 46шт / оставит в Амакс после 14:00 (+7 987 282-71-66)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1228, client_id, 'returned', '2025-12-05', '2025-12-05', 1, 37, 0, 0, 0, NULL, true, 0, 5440.0, 5440.0, '04.12 в офис Казань 360, в районе 12:00 Эльмира 36+32 доп наушника / оставит в Амакс после 20:30 (+7 917 878-83-60)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1227, client_id, 'returned', '2025-12-05', '2025-12-05', 1, 55, 0, 0, 0, NULL, true, 0, 6560.0, 6560.0, '04.12 В офис Казань 360, в районе 12:00 Снежанна 54 +28 доп наушников / оставит в Амакс после 20:30 ( +7 927 414-91-01)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1226, client_id, 'returned', '2025-12-05', '2025-12-05', 1, 47, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, '04.12 в офис Казань 360 в районе 12:00 Ольга 46шт / оставит в фургончике после 15:00 (+7 950 314-03-61)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1225, client_id, 'returned', '2025-12-05', '2025-12-05', 1, 48, 0, 0, 0, NULL, true, 0, 3760.0, 3760.0, '04.12 в офис Казань 360 в районе 12:00 Алик 47шт / оставит в Амакс после 15:00 (+7 987 221-02-84)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1224, client_id, 'issued', '2025-12-21', '2025-12-21', 1, 31, 0, 0, 0, NULL, false, 0, 3000.0, 0, 'Дауна 8:30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1223, client_id, 'completed', '2025-12-07', '2025-12-07', 1, 52, 0, 0, 0, NULL, true, 0, 5100.0, 5100.0, 'Баумана в 8:30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1222, client_id, 'completed', '2025-11-28', '2025-11-28', 1, 25, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'Оставить в фургончике до 15:00, вечером оставит в Шаляпине', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Искандер%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1221, client_id, 'completed', '2025-11-25', '2025-11-25', 1, 11, 0, 0, 0, NULL, true, 0, 800.0, 800.0, 'Ольга ткач', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1220, client_id, 'new', '2026-01-04', '2026-01-05', 2, 52, 0, 0, 0, NULL, false, 0, 10000.0, 0, 'Уточнить', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1219, client_id, 'completed', '2025-12-14', '2025-12-14', 1, 51, 0, 0, 0, NULL, true, 0, 5000.0, 5000.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1218, client_id, 'completed', '2025-11-23', '2025-11-23', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Баумана в 8:15 Алена Лазуко', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айгуль Файзуллина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1217, client_id, 'completed', '2025-11-19', '2025-11-20', 2, 29, 0, 0, 0, NULL, true, 0, 5400.0, 5400.0, 'заберет из фургончика', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1216, client_id, 'returned', '2025-11-18', '2025-11-19', 2, 33, 0, 0, 0, NULL, false, 0, 4960.0, 0, 'Авиатор. Игорь', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ленар (ИП Ножкин)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1215, client_id, 'completed', '2025-11-20', '2025-11-20', 1, 104, 0, 0, 0, NULL, true, 0, 8000.0, 8000.0, '19.10 в районе 10 заберет ! 4 сумки по 26шт', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1214, client_id, 'completed', '2025-11-19', '2025-11-19', 1, 20, 0, 0, 0, NULL, true, 0, 1900.0, 1900.0, 'Заберет в 11:00 из фургончика', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1212, client_id, 'new', '2026-01-08', '2026-01-09', 2, 27, 0, 0, 0, NULL, false, 0, 5000.0, 0, 'Ростов', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1211, client_id, 'new', '2026-01-06', '2026-01-08', 3, 37, 0, 0, 0, NULL, false, 0, 10500.0, 0, 'Подольск Передать 5 вечером', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1210, client_id, 'new', '2026-01-07', '2026-01-09', 3, 37, 0, 0, 0, NULL, false, 0, 10500.0, 0, 'Карабулак', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1209, client_id, 'new', '2026-01-05', '2026-01-07', 3, 37, 0, 0, 0, NULL, false, 0, 10500.0, 0, 'ЕКБ 3', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1208, client_id, 'new', '2026-01-03', '2026-01-05', 3, 37, 0, 0, 0, NULL, false, 0, 10500.0, 0, 'ЕКБ 2', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1207, client_id, 'new', '2025-12-31', '2026-01-02', 3, 37, 0, 0, 0, NULL, false, 0, 10500.0, 0, 'ЕКБ 1', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1206, client_id, 'issued', '2025-12-19', '2025-12-21', 3, 32, 0, 0, 0, NULL, false, 0, 9000.0, 0, 'Гатчина К 11:30 в дом чая , Катя Кореева', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1205, client_id, 'returned', '2025-11-15', '2025-11-15', 1, 30, 0, 0, 0, NULL, true, 0, 2320.0, 2320.0, 'в 9:00 старт от деревни универсиады. Подъедет к часам. Нужно ей отдать сумку, ваучер на свияжск, и зп. 9600₽', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александр Романов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1204, client_id, 'completed', '2025-11-29', '2025-11-30', 2, 17, 0, 0, 0, NULL, true, 0, 3000.0, 3000.0, 'Карат до 11:00. Оставят в спринтере у Оксаны', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1203, client_id, 'completed', '2025-11-16', '2025-11-19', 4, 10, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, '14.11 в офис , оригинал счёта и акта', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1202, client_id, 'completed', '2025-11-15', '2025-11-15', 1, 19, 0, 0, 0, NULL, true, 0, 1440.0, 1440.0, 'От Сафара в Релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1201, client_id, 'returned', '2025-11-12', '2025-11-12', 1, 33, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, 'На завтра 32 Радиогида. В 16:00 от отеля Волга. Гид Ольга Ткач. Ваучер Кремль', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1200, client_id, 'returned', '2025-11-20', '2025-11-23', 4, 22, 0, 0, 0, NULL, false, 0, 6000.0, 0, '22.11. Не работают. в отеле Рамада Казань на Чернышевского. Для булата валиуллина и Антона зенкова если что', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1199, client_id, 'returned', '2025-11-11', '2025-11-15', 5, 35, 0, 0, 0, NULL, true, 0, 12400.0, 12400.0, '11-15 ноября , 31 радиогид. И ваучер на кремль, свияжск, булгар. гид Катя Ильина. Кристал 12:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1198, client_id, 'completed', '2025-11-14', '2025-11-16', 3, 37, 0, 0, 0, NULL, true, 0, 10500.0, 10500.0, 'В Азу до 12:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1197, client_id, 'completed', '2025-11-18', '2025-11-20', 3, 37, 0, 0, 0, NULL, true, 0, 10500.0, 10500.0, 'Щелково, 8:15 дом чая, оставят в кристалле после 21:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1196, client_id, 'completed', '2025-11-08', '2025-11-09', 2, 43, 0, 0, 0, NULL, true, 0, 8200.0, 8200.0, '8 ноября к 11:30-12:00 в кафе «Азу» на Петербургской 52', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1195, client_id, 'completed', '2025-11-08', '2025-11-09', 2, 48, 0, 0, 0, NULL, true, 0, 9200.0, 9200.0, 'Заберет Владимир Нежданов. Из фургончика в 13:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1194, client_id, 'returned', '2025-11-07', '2025-11-07', 1, 20, 0, 0, 0, NULL, false, 0, 1520.0, 0, ', 7.11 к 9.20 а Дон Кихот радио гиды на19 человек гид Аида. Вернут после 20 в Донецке Кихот. +7 903 344-08-99 Аида', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1193, client_id, 'cancelled', '2025-11-14', '2025-11-16', 3, 40, 0, 0, 0, NULL, false, 0, 9120.0, 0, 'Уточнить ОТМЕНА', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1192, client_id, 'completed', '2025-11-08', '2025-11-09', 2, 28, 0, 0, 0, NULL, true, 0, 4160.0, 4160.0, 'Гид Эльвира, Полина, в офис', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1191, client_id, 'completed', '2025-11-05', '2025-11-05', 1, 18, 0, 0, 0, NULL, true, 0, 1360.0, 1360.0, 'В офис до 13', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1190, client_id, 'completed', '2025-11-03', '2025-11-03', 1, 40, 0, 0, 0, NULL, true, 0, 3900.0, 3900.0, '3 ноября на 1 день нужны радиогиды, 39 человек +гид Ирина т.+7 927 421-36-82 Группа приедет на ЦЖД в 12:30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1189, client_id, 'completed', '2025-11-02', '2025-11-02', 1, 33, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, 'на завтра 32 радтогида в 11:00 от спасской башни кремля. И один ваучер на кремль. гид Гузель Габдрахманова . +7 917 283-86-75', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1188, client_id, 'completed', '2025-11-03', '2025-11-04', 2, 39, 0, 0, 0, NULL, true, 0, 5920.0, 5920.0, 'В офис 03 днем , вернут 4 после обеда Гид Диана, мен Полина', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1187, client_id, 'completed', '2025-11-03', '2025-11-03', 1, 26, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, 'Из Сафара в релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1186, client_id, 'completed', '2025-11-03', '2025-11-03', 1, 24, 0, 0, 0, NULL, true, 0, 1840.0, 1840.0, 'Из биляра в Биляр', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1185, client_id, 'completed', '2025-11-01', '2025-11-01', 1, 37, 0, 0, 0, NULL, true, 0, 2880.0, 2880.0, 'В 10:30 заберут', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1184, client_id, 'completed', '2025-11-01', '2025-11-01', 1, 16, 0, 0, 0, NULL, true, 0, 1500.0, 1500.0, 'Заберет сама в 8:45', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1183, client_id, 'completed', '2025-10-30', '2025-10-30', 1, 16, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, 'В кафе Медину на спартаковской до 13', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь Ким%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1182, client_id, 'completed', '2025-11-06', '2025-11-06', 1, 44, 0, 0, 0, NULL, true, 0, 4300.0, 4300.0, 'На 6 ноября оставьте для нас радиомикрофоны в кол- ве 43 шт) Отель Волга. С 15:00 - До 20 ч там же и оставим', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Искандер%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1181, client_id, 'completed', '2025-10-29', '2025-10-29', 1, 23, 0, 0, 0, NULL, true, 0, 1680.0, 1680.0, 'в офис до 15:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1180, client_id, 'completed', '2025-10-30', '2025-10-30', 1, 63, 0, 0, 0, NULL, true, 0, 4880.0, 4880.0, 'Две сумки на 37 и 26шт Гид Резида и Людмила , Полина', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1179, client_id, 'completed', '2025-10-28', '2025-10-28', 1, 53, 0, 0, 0, NULL, true, 0, 5100.0, 5100.0, 'заберет из бусика ВЕРНЕТ В КРИССТАЛ ПОСЛЕ 22:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1178, client_id, 'completed', '2025-10-28', '2025-10-29', 2, 38, 0, 0, 0, NULL, true, 0, 5040.0, 5040.0, 'Заявка на 28 и 29 октября 36 человек +гид Лиля т.+7 965 602-05-28 28.10 приезжают в 12:30 на ЦЖД. ВЕРНУТ В РИВЬЕРУ', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга Лотова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1177, client_id, 'completed', '2025-10-29', '2025-10-29', 1, 21, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1176, client_id, 'completed', '2025-10-27', '2025-10-28', 2, 35, 0, 0, 0, NULL, true, 0, 4620.0, 4620.0, 'Гостиница Булгар 2* , улица Вишневского 21 33+ гид Владимир т 89178858409 На 27 и 28 октября', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1175, client_id, 'completed', '2025-10-29', '2025-10-29', 1, 23, 0, 0, 0, NULL, true, 0, 1760.0, 1760.0, '29.10 22 чел. Карат к 8.20 вернут по созвону в 16.00 гид Диляра Рафкатовна 89179275489. СУМОЧКА В КАРАТЕ', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1174, client_id, 'completed', '2025-10-28', '2025-10-28', 1, 50, 0, 0, 0, NULL, true, 0, 3920.0, 3920.0, '28.10 49 чел. к 9.30 в хостел Крылья вернут по созвону после 16. гид Николай 89172349414. ВЕРНУТ В ОФИС', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1173, client_id, 'completed', '2025-10-28', '2025-10-30', 3, 42, 0, 0, 0, NULL, true, 0, 9600.0, 9600.0, '28-30.10 40 чел. 28 в Кристалл к 10.30 вернут в Кристалл 30.10 после 23.00 гид Гульсина Закиевна 89178975685', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1172, client_id, 'completed', '2025-10-27', '2025-10-28', 2, 47, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, '27-28.10 40 чел. 27 в Кристалл в 12 вернут 28 в Кристалл в 17.гид Лилия 89872975449', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1171, client_id, 'completed', '2025-10-27', '2025-10-28', 2, 42, 0, 0, 0, NULL, true, 0, 6400.0, 6400.0, '27-28.10 40чел. 27 в Кристалл в 12 вернут в Кристалл 28 в 17 гид Диана 8927445452527', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1170, client_id, 'completed', '2025-10-26', '2025-10-28', 3, 53, 0, 0, 0, NULL, true, 0, 12240.0, 12240.0, 'Гид Яна, доставкой, добавить в счёт 238₽ , Любовь', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1169, client_id, 'completed', '2025-10-26', '2025-10-26', 1, 25, 0, 0, 0, NULL, true, 0, 1920.0, 1920.0, '26.10 24чел. Кристалл 9.30 вернут после 20.00 в Кристалл гид Ирина 89046620732 Вернут в 09:00 в кристалл 27.10', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1168, client_id, 'completed', '2025-11-01', '2025-11-03', 3, 24, 0, 0, 0, NULL, true, 0, 6600.0, 6600.0, 'В дом чая до 13. Оставят в кристалл после 22:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1167, client_id, 'completed', '2025-10-25', '2025-10-25', 1, 26, 0, 0, 0, NULL, true, 0, 2500.0, 2500.0, 'кафе азу до 14;30. Вернут в 19:00 к свито холлу', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1166, client_id, 'completed', '2025-10-25', '2025-10-26', 2, 24, 0, 0, 0, NULL, true, 0, 3520.0, 3520.0, '25.10 22 чел. хостел Крылья в 6.00 сдадут 26.10 после 16. по созвону. гид Татьяна 89600344289 Вернули в крылья', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1165, client_id, 'completed', '2025-10-25', '2025-10-25', 1, 21, 0, 0, 0, NULL, true, 0, 1600.0, 1600.0, '25.10 20 чел. Кристалл в 10 вернут по созвону. гида Марина 89172526993', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1164, client_id, 'completed', '2025-10-24', '2025-10-24', 1, 55, 0, 0, 0, NULL, true, 0, 4320.0, 4320.0, 'В офис до 12, Римма', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1163, client_id, 'completed', '2025-11-02', '2025-11-02', 1, 46, 0, 0, 0, NULL, true, 0, 4500.0, 4500.0, 'Эверест в 17:00 в мано', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1162, client_id, 'completed', '2025-11-18', '2025-11-19', 2, 36, 0, 0, 0, NULL, true, 0, 5440.0, 5440.0, 'Кристал вернули туда же. 1 потеряли', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1161, client_id, 'completed', '2025-10-25', '2025-10-25', 1, 157, 0, 0, 0, NULL, true, 0, 11641.0, 11641.0, 'Группа #1 Начало в Свияжске в 9 утра 42 человека + гид Аида т. +79033440899 Группа #2 Начало в 10:00 на ЦЖД 45 человек + гид Татьяна т.89063271840 Группа #3 Начало в 10:00 на ЦЖД 29 человек + гид Ирина т.89274213682 Группа #4 Начало в 10:00 на ЦЖД 37 человек + гид Владимир т.89178858409 Все группы заканчивают в 20:10-20:30 на ЦЖД 43,46,30,38', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1160, client_id, 'new', '2025-12-31', '2026-01-01', 2, 80, 0, 0, 0, NULL, false, 0, 15200.0, 0, 'две сумки по 40', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Флот%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1159, client_id, 'completed', '2025-10-26', '2025-10-26', 1, 62, 0, 0, 0, NULL, true, 0, 6000.0, 6000.0, '2 сумки по 31. Кристал. Ирина софронова и Ирина совельева ВЕЧЕРОМ', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1158, client_id, 'completed', '2025-10-28', '2025-10-28', 1, 21, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, 'К 15:00 заберут из фургончика Двойной комплект наушников', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1157, client_id, 'completed', '2025-10-23', '2025-10-24', 2, 44, 0, 0, 0, NULL, true, 0, 8400.0, 8400.0, 'Волга начало в 12:30. Елена.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1156, client_id, 'completed', '2025-10-19', '2025-10-19', 1, 100, 0, 0, 0, NULL, true, 0, 5680.0, 5680.0, 'Сумки указаны в программе', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1155, client_id, 'completed', '2025-10-22', '2025-10-22', 1, 53, 0, 0, 0, NULL, true, 0, 4160.0, 4160.0, 'Накануне, гид Надежда, римма', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1154, client_id, 'completed', '2025-10-20', '2025-10-20', 1, 89, 0, 0, 0, NULL, true, 0, 6960.0, 6960.0, '2 сумки на 43 и 44шт утром, Римма', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1153, client_id, 'completed', '2025-11-01', '2025-11-01', 1, 21, 0, 0, 0, NULL, true, 0, 1600.0, 1600.0, '1 ноября . 20 радиогидов . в 10:00 от отеля Арон + ваучер на свияжск. Лариса', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1152, client_id, 'completed', '2025-10-26', '2025-10-26', 1, 34, 0, 0, 0, NULL, true, 0, 2640.0, 2640.0, '26 октября 33 радиогида + ваучер на кремль 9:30 от у ТЦ "Аида" Остановка Лаврентьева . Гид Ольга Ткач', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1151, client_id, 'completed', '2025-10-19', '2025-10-19', 1, 41, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, '19 октября 40 радиогидов. Утром в 9.30 забираю группу в Гранд отеле.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1150, client_id, 'completed', '2025-10-17', '2025-10-17', 1, 510, 0, 0, 0, NULL, true, 0, 40000.0, 40000.0, 'В 9:30 Маяковского 24А', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1149, client_id, 'completed', '2025-10-18', '2025-10-18', 1, 54, 0, 0, 0, NULL, true, 0, 4240.0, 4240.0, 'В офис утром Римма', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1148, client_id, 'completed', '2025-10-17', '2025-10-19', 3, 42, 0, 0, 0, NULL, true, 0, 9600.0, 9600.0, 'Кристал. Гулистан Закиевна. +79178975685', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1147, client_id, 'completed', '2025-10-18', '2025-10-18', 1, 42, 0, 0, 0, NULL, true, 0, 4100.0, 4100.0, 'Фатима. Сумка в Кристалле', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузелия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1146, client_id, 'completed', '2025-10-16', '2025-10-16', 1, 8, 0, 0, 0, NULL, true, 0, 1500.0, 1500.0, 'заберет в 11:40', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Супрунова (от Миры)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1145, client_id, 'completed', '2025-10-25', '2025-10-25', 1, 185, 0, 0, 0, NULL, true, 0, 20200.0, 20200.0, 'Поезд в 9:05 Казань пасс 1) 52+1 гид Наталья Жукова +7 (927) 243-43-67 2) 54+1 гид Валерий Матросов +7 (905) 319-54-86 3) 52+1 гид Зельфира +7 (987) 275-03-95 4) 22+1 гид на 2 дня Снежана +7 (927) 414-91-01 (5:02) поезд Заканчивают в 21:30 на жд', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1144, client_id, 'completed', '2025-10-21', '2025-10-22', 2, 51, 0, 0, 0, NULL, true, 0, 7840.0, 7840.0, 'В офис, гид Лилия, Полина', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1143, client_id, 'completed', '2025-10-14', '2025-10-14', 1, 20, 0, 0, 0, NULL, true, 0, 1520.0, 1520.0, 'Кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1142, client_id, 'completed', '2025-10-30', '2025-10-31', 2, 16, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, 'Марина Трэвел Юлия (2гр) В кристалл В офис Инициативы принесут 01.11', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1141, client_id, 'completed', '2025-10-30', '2025-11-01', 3, 44, 0, 0, 0, NULL, true, 0, 12300.0, 12300.0, 'Экскурсовод Марина 8917 288-90-13 Дома чая до 15:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1140, client_id, 'completed', '2025-10-28', '2025-10-30', 3, 36, 0, 0, 0, NULL, true, 0, 15200.0, 15200.0, 'Дом чая до 15:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1139, client_id, 'completed', '2025-10-25', '2025-10-27', 3, 36, 0, 0, 0, NULL, true, 0, 10200.0, 10200.0, 'К 14:30 дома Чая, Катя Кореева ВЕРНЕТ В КРИСТАЛЛ ПОСЛЕ 20:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия (Рыжий Слон)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1138, client_id, 'returned', '2025-10-27', '2025-10-29', 3, 46, 0, 0, 0, NULL, false, 0, 13200.0, 0, 'Гид Диляра Ахмерова +7 950 327-62-72 Поезд прибывает 27 октября 377 в 12:29 . Кристал. ВЕРНУЛИ В ШАЛЯПИН', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузель (Юралс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1137, client_id, 'completed', '2025-10-22', '2025-10-22', 1, 41, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1136, client_id, 'completed', '2025-10-11', '2025-10-11', 1, 100, 0, 0, 0, NULL, true, 0, 7840.0, 7840.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1135, client_id, 'cancelled', '2025-10-10', '2025-10-10', 1, 135, 0, 0, 0, NULL, false, 0, 10560.0, 0, 'Отмена!', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина «Романова Трэвел»%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1134, client_id, 'completed', '2025-10-11', '2025-10-11', 1, 56, 0, 0, 0, NULL, true, 0, 5500.0, 5500.0, 'Сопровождающая группы Ирина +7 951 908-31-31. Будем ждать вас в Туган Авылым 11.10 в 12:30. окончание экскурсии в 18:00.', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Дмитрий (Алабуга-Волокно)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1133, client_id, 'completed', '2025-10-15', '2025-10-16', 2, 52, 0, 0, 0, NULL, true, 0, 10000.0, 10000.0, 'Сами заберут и вернут После обеда', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1132, client_id, 'completed', '2025-10-11', '2025-10-11', 1, 19, 0, 0, 0, NULL, true, 0, 1440.0, 1440.0, 'От Сафара в Сулейман', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1131, client_id, 'cancelled', '2025-10-11', '2025-10-12', 2, 33, 0, 0, 0, NULL, false, 0, 6200.0, 0, 'Заберет в +/- 12:00. 12 числа', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Марина Экс%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1130, client_id, 'completed', '2025-10-24', '2025-10-25', 2, 55, 0, 0, 0, NULL, true, 0, 10600.0, 10600.0, 'Ф Крис стал', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1129, client_id, 'completed', '2025-10-12', '2025-10-12', 1, 47, 0, 0, 0, NULL, true, 0, 4600.0, 4600.0, 'Сумка в Волге', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1128, client_id, 'completed', '2025-10-08', '2025-10-10', 3, 56, 0, 0, 0, NULL, true, 0, 12960.0, 12960.0, 'В гфис любовь', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1127, client_id, 'completed', '2025-10-07', '2025-10-07', 1, 21, 0, 0, 0, NULL, true, 0, 1600.0, 1600.0, 'Заберут до 14:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1126, client_id, 'completed', '2025-10-10', '2025-10-10', 1, 49, 0, 0, 0, NULL, true, 0, 3760.0, 3760.0, '2 сумки на 27шт и 20шт, во второй половине дня', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1125, client_id, 'completed', '2025-10-17', '2025-10-20', 4, 14, 0, 0, 0, NULL, true, 0, 3840.0, 3840.0, 'В офис 16.10 Забрать 21 в обед оригинал акт и счёт', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1124, client_id, 'completed', '2025-10-09', '2025-10-09', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, 'Гид Аида, Римма', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1123, client_id, 'completed', '2025-10-07', '2025-10-07', 1, 46, 0, 0, 0, NULL, true, 0, 3600.0, 3600.0, 'В офис, Римма', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1122, client_id, 'completed', '2025-10-07', '2025-10-08', 2, 40, 0, 0, 0, NULL, true, 0, 6080.0, 6080.0, 'Гид Николай, мне Римма, в офис Тиц 7.10', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1121, client_id, 'completed', '2025-10-30', '2025-10-30', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, '30 октября .35 штук . 11:00 от жд вокзала центрального. Нина Максимова, ваучер Кремль', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1120, client_id, 'completed', '2025-10-24', '2025-10-24', 1, 42, 0, 0, 0, NULL, true, 0, 3280.0, 3280.0, '24 октября , 41 штука. в 8:30 Хотел 13 ул.Московская д.13а. Светлана Чиж, ваучер на кремль', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1119, client_id, 'completed', '2025-10-28', '2025-10-29', 2, 37, 0, 0, 0, NULL, true, 0, 5600.0, 5600.0, '28-29 октября . 35 штук . гид Нина Максимова 28 октября в 11:00 от центрального жд', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1118, client_id, 'completed', '2025-10-07', '2025-10-07', 1, 27, 0, 0, 0, NULL, true, 0, 2080.0, 2080.0, 'на завтра 26 радиогидов иваучер на свияжск . в 9:00 от площади тукая . Гид Лариса Семенова ( ей на вечерке сегодня все можно передать)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1117, client_id, 'completed', '2025-10-07', '2025-10-07', 1, 46, 0, 0, 0, NULL, true, 0, 3600.0, 3600.0, 'Амакс Сафар. Вернула в офис', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1116, client_id, 'completed', '2025-10-06', '2025-10-08', 3, 51, 0, 0, 0, NULL, true, 0, 11760.0, 11760.0, 'Доставкой сами вызовут Любовь', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария (ОСР)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1115, client_id, 'returned', '2025-10-06', '2025-10-09', 3, 20, 0, 0, 0, NULL, false, 0, 4320.0, 0, 'Оставить в парк отеле', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1114, client_id, 'completed', '2025-10-04', '2025-10-04', 1, 25, 0, 0, 0, NULL, true, 0, 1920.0, 1920.0, 'Вернут в офис Тиц к 19:00 Мен Анна', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Титова Галина (Эллинлайн)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1113, client_id, 'completed', '2025-10-12', '2025-10-12', 1, 31, 0, 0, 0, NULL, true, 0, 3000.0, 3000.0, 'Эллинлайн Инн --7807028247--12.10 , туристов --30 , едут из Иошкар Олы, тел гида из Казани, 89033428060--Светлана Сумка в кристале', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1112, client_id, 'completed', '2025-10-04', '2025-10-05', 2, 14, 0, 0, 0, NULL, true, 0, 2080.0, 2080.0, 'заберет Игорь в 9:10. +79274055070. Вернул в фургончик', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1111, client_id, 'completed', '2025-10-28', '2025-10-28', 1, 52, 0, 0, 0, NULL, true, 0, 4080.0, 4080.0, '28 октября с 9:00 до 13:30 экскурсовод елена +79053162973 В релиту Оставят в Азу у АйТи парка в 12:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1110, client_id, 'completed', '2025-10-26', '2025-10-26', 1, 52, 0, 0, 0, NULL, true, 0, 4080.0, 4080.0, '26 октября с 11 :00 до 18:00 Экскурсовод снежана+79274149101 В Азу на Петербургской до 12 Оставят в Релите в 18', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1109, client_id, 'completed', '2025-10-05', '2025-10-05', 1, 30, 0, 0, 0, NULL, true, 0, 2320.0, 2320.0, 'Сулейман . Аида. Вернут вечером в Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1108, client_id, 'completed', '2025-10-25', '2025-10-26', 2, 41, 0, 0, 0, NULL, true, 0, 7800.0, 7800.0, 'Бирку не делал. Сумка без номера. Пломба 2482', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1107, client_id, 'completed', '2025-10-04', '2025-10-04', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'завтра 50 штук оборудование. В 9:00 от Бутлерова 44. гид Настя Семенова , ей надо передать ваучер на булгар и документы для клиента. документы я смогу передать тебе после 14:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1106, client_id, 'completed', '2025-10-04', '2025-10-05', 2, 37, 0, 0, 0, NULL, true, 0, 5600.0, 5600.0, 'Вернут в офис Инициативы, в пн забрать с деньгами', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария (ОСР)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1105, client_id, 'completed', '2025-10-04', '2025-10-05', 2, 30, 0, 0, 0, NULL, true, 0, 4640.0, 4640.0, 'Оставят 6 утром в парк отеле', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1104, client_id, 'completed', '2025-10-03', '2025-10-05', 3, 25, 0, 0, 0, NULL, true, 0, 5520.0, 5520.0, '3-5 октября , группа 23 человека . Нужны радиогиды +ваучер на кремль и свияжск . Гид Нина Максимова . завтра в 7:50 от центрального жд. Сумка в фургончике', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь Ким%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1103, client_id, 'cancelled', '2025-11-06', '2025-11-06', 1, 25, 0, 0, 0, NULL, false, 0, 2500.0, 0, 'Волга', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь Ким%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1102, client_id, 'completed', '2025-10-23', '2025-10-23', 1, 48, 0, 0, 0, NULL, true, 0, 4700.0, 4700.0, 'Волга. Начало в 14:30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1101, client_id, 'completed', '2025-10-03', '2025-10-03', 1, 49, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, 'Заберет в 8:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1100, client_id, 'returned', '2025-10-06', '2025-10-06', 1, 26, 0, 0, 0, NULL, false, 0, 2500.0, 0, '6 октября 15:00-18:00 25 радиогдиов на имя гида Татьяна Сулеймманова, отель Мариотт Казань', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Владимир Нежданов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1099, client_id, 'completed', '2025-10-04', '2025-10-05', 2, 32, 0, 0, 0, NULL, true, 0, 6000.0, 6000.0, 'Вернет в пн утром', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1098, client_id, 'completed', '2025-10-10', '2025-10-10', 1, 20, 0, 0, 0, NULL, true, 0, 1520.0, 1520.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена (Конгресс Авиа)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1097, client_id, 'completed', '2025-10-04', '2025-10-04', 1, 108, 0, 0, 0, NULL, true, 0, 8400.0, 8400.0, 'В Марриот 3 сумки по 36шт Гиды: Наталия +7 987 238-41-05 София +7 905 038-37-23 Элина +7 917 236-98-27 В 14 вернут туда же, уточнить', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Агентство Удачи)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1096, client_id, 'cancelled', '2025-10-08', '2025-10-08', 1, 204, 0, 0, 0, NULL, false, 0, 16000.0, 0, 'Отказ', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1095, client_id, 'completed', '2025-10-04', '2025-10-05', 2, 47, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'В кристалл оставит к 22', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Дамир (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1094, client_id, 'completed', '2025-10-03', '2025-10-03', 1, 102, 0, 0, 0, NULL, true, 0, 10000.0, 10000.0, 'В Ривьеру до 16:00, вернут в 19:30 туда же', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ленар (ИП Ножкин)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1093, client_id, 'completed', '2025-10-03', '2025-10-03', 1, 14, 0, 0, 0, NULL, true, 0, 1040.0, 1040.0, 'Нужен набор на 13+1 3.10 16:00-20:30 забрать и отнести можем сами на Баумана вам.', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Искандер%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1092, client_id, 'completed', '2025-10-01', '2025-10-01', 1, 30, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, 'в офис', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1091, client_id, 'completed', '2025-10-01', '2025-10-01', 1, 50, 0, 0, 0, NULL, true, 0, 3920.0, 3920.0, 'В офис тиц до 11, гид Юрий', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1090, client_id, 'completed', '2025-09-30', '2025-09-30', 1, 16, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, 'Заберет из бусика', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1089, client_id, 'completed', '2025-10-04', '2025-10-04', 1, 28, 0, 0, 0, NULL, true, 0, 2160.0, 2160.0, 'От Корстон в Корстон', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1088, client_id, 'completed', '2025-10-04', '2025-10-04', 1, 25, 0, 0, 0, NULL, true, 0, 1920.0, 1920.0, 'От Сафара, до Корстона', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1087, client_id, 'completed', '2025-10-28', '2025-10-30', 2, 24, 0, 0, 0, NULL, true, 0, 5680.0, 5680.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Супрунова (от Миры)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1086, client_id, 'completed', '2025-10-02', '2025-10-02', 1, 31, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'Заберет сама в районе в 8:15', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сафина Алина (ФРГРТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1085, client_id, 'returned', '2025-10-01', '2025-10-03', 3, 42, 0, 0, 0, NULL, false, 0, 11840.0, 0, 'В пн вернут', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1084, client_id, 'completed', '2025-11-01', '2025-11-02', 2, 37, 0, 0, 0, NULL, true, 0, 5600.0, 5600.0, '1-2.11 35 чел. 1.11 в Кристалл к 12 вернут 2.11 по созвону гид Владимир Николаевич 89178858409. ВЕРНУЛ В КРИСТАЛ', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1083, client_id, 'cancelled', '2025-10-03', '2025-10-05', 3, 49, 0, 0, 0, NULL, false, 0, 11280.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1082, client_id, 'completed', '2025-10-06', '2025-10-06', 1, 48, 0, 0, 0, NULL, true, 0, 3760.0, 3760.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1081, client_id, 'completed', '2025-09-28', '2025-09-28', 1, 50, 0, 0, 0, NULL, true, 0, 3500.0, 3500.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Вадим%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1080, client_id, 'completed', '2025-09-27', '2025-09-27', 1, 56, 0, 0, 0, NULL, true, 0, 4400.0, 4400.0, 'Оставил в Шаляпин', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1079, client_id, 'completed', '2025-09-27', '2025-09-27', 1, 27, 0, 0, 0, NULL, true, 0, 2080.0, 2080.0, 'Кристал, вернут туда же', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1078, client_id, 'completed', '2025-09-27', '2025-09-27', 1, 102, 0, 0, 0, NULL, true, 0, 8000.0, 8000.0, 'Сергей и Резеда Оставят в 317', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1077, client_id, 'completed', '2025-10-27', '2025-10-30', 4, 45, 0, 0, 0, NULL, true, 0, 13760.0, 13760.0, '27-30.10 43 чел. 27 в Кристалле в 11 вернут 30 в Кристалл после 23.00гид Игорь 89274055070 ВЕЧЕРОМ ВЕРНЕТ К 12 в фургончик', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1076, client_id, 'completed', '2025-10-27', '2025-10-28', 2, 47, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, '27.10-29.10 45 чел. 27 в Кристалле в 7.30 вернут 29 в Кристалл в 17.30 гид Аида 89033440899 ВЕЧЕРОМ. ОСТАВИЛИ ХОСТЕЛ СЛИП СПЕЙС. ЧИСТОПОЛЬСКАЯ 19А, 3 этаж, офис 36', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1075, client_id, 'completed', '2025-10-26', '2025-10-29', 4, 39, 0, 0, 0, NULL, true, 0, 8880.0, 8880.0, '26-29.10 *без28 октября* 37 чел. в Кристалл к 11 сдадут 29.10 в кристалл после 19.30 гид Дания 89172904415 живут в Кварте.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1074, client_id, 'completed', '2025-10-26', '2025-10-28', 3, 32, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, '26-28.10 30 чел. Кристалл в 7.30 сдадут 28.10 после 17 в Кристалл ВЕЧЕРОМ гид Ольга 89503140361', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1073, client_id, 'completed', '2025-10-17', '2025-10-19', 3, 50, 0, 0, 0, NULL, true, 0, 11520.0, 11520.0, 'Кристал. Игорь. +79274055070', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
END $$;