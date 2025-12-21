-- SQL для импорта 1215 заказов
-- Выполните ПОСЛЕ import_clients.sql

DO $$
DECLARE
  leonid_id UUID;
  stas_id UUID;
  client_id UUID;
BEGIN
  SELECT id INTO leonid_id FROM profiles WHERE display_name ILIKE '%Леонид%' LIMIT 1;
  SELECT id INTO stas_id FROM profiles WHERE display_name ILIKE '%Стас%' LIMIT 1;

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1273, client_id, 'Эдик Заказы для групп', 'issued', '20.12.2025', '21.12.2025', 2, 26, 0, 0, 0, 4000.0, 0, false, 'В кристалл Катя Ильина Ваучер Кремль и свияжск', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1272, client_id, 'Эдик Заказы для групп', 'returned', '19.12.2025', '19.12.2025', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, '43 радиогида в 9:30 от отеля Рамада. И один ваучер на Кремль . Гид Катя Ильина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%София%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1271, client_id, 'София', 'new', '03.01.2026', '05.01.2026', 3, 45, 0, 0, 0, 12900.0, 0, false, 'Заберет сама', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1270, client_id, 'Арсен (Юнион)', 'new', '09.01.2026', '09.01.2026', 1, 36, 0, 0, 0, 3500.0, 0, false, 'Из АйТи парка в АйТи парк', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1269, client_id, 'Арсен (Юнион)', 'new', '09.01.2026', '09.01.2026', 1, 31, 0, 0, 0, 3000.0, 0, false, 'Из Сафара в Релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1268, client_id, 'Арсен (Юнион)', 'new', '06.01.2026', '06.01.2026', 1, 42, 0, 0, 0, 4100.0, 0, false, 'Из Сафара в Релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1267, client_id, 'Арсен (Юнион)', 'new', '05.01.2026', '05.01.2026', 1, 40, 0, 0, 0, 3900.0, 0, false, 'Из АйТи парка в АйТи парк', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1266, client_id, 'Арсен (Юнион)', 'new', '05.01.2026', '05.01.2026', 1, 45, 0, 0, 0, 4400.0, 0, false, 'Из Сафара в Релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1265, client_id, 'Арсен (Юнион)', 'new', '04.01.2026', '04.01.2026', 1, 24, 0, 0, 0, 2300.0, 0, false, 'Уточнить', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1264, client_id, 'Арсен (Юнион)', 'new', '04.01.2026', '04.01.2026', 1, 39, 0, 0, 0, 3800.0, 0, false, 'Из АйТи парка в АйТи парк', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1263, client_id, 'Арсен (Юнион)', 'new', '04.01.2026', '04.01.2026', 1, 45, 0, 0, 0, 4400.0, 0, false, 'Из Сафара в Релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1262, client_id, 'Арсен (Юнион)', 'new', '03.01.2026', '03.01.2026', 1, 45, 0, 0, 0, 4400.0, 0, false, 'Из Сафара в Релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1261, client_id, 'Арсен (Юнион)', 'new', '02.01.2026', '02.01.2026', 1, 46, 0, 0, 0, 4500.0, 0, false, 'Уточнить откуда, вернут в Стерлядку', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1260, client_id, 'Арсен (Юнион)', 'new', '31.12.2025', '31.12.2025', 1, 29, 0, 0, 0, 2240.0, 0, false, 'Из Сафара в Релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1259, client_id, 'Арсен (Юнион)', 'new', '31.12.2025', '31.12.2025', 1, 32, 0, 0, 0, 2480.0, 0, false, 'Из АйТи парка в АйТи парк', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1258, client_id, 'Зельфира', 'new', '07.01.2026', '09.01.2026', 3, 42, 0, 0, 0, 12000.0, 0, false, 'Уточнить', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1257, client_id, 'Зельфира', 'new', '06.01.2026', '06.01.2026', 1, 46, 0, 0, 0, 4500.0, 0, false, 'Уточнить', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1256, client_id, 'Зельфира', 'new', '03.01.2026', '05.01.2026', 3, 47, 0, 0, 0, 13500.0, 0, false, 'Уточнить', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1255, client_id, 'Эвелина (Инициатива)', 'new', '08.01.2026', '08.01.2026', 1, 37, 0, 0, 0, 3500.0, 0, false, 'Уточнить', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1254, client_id, 'Эвелина (Инициатива)', 'new', '06.01.2026', '08.01.2026', 3, 37, 0, 0, 0, 10500.0, 0, false, 'Уточнить', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1253, client_id, 'Эвелина (Инициатива)', 'new', '04.01.2026', '06.01.2026', 3, 50, 0, 0, 0, 14400.0, 0, false, 'Уточнить', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1252, client_id, 'Эвелина (Инициатива)', 'new', '03.01.2026', '05.01.2026', 3, 44, 0, 0, 0, 12600.0, 0, false, 'Уточнить', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1251, client_id, 'Эвелина (Инициатива)', 'new', '02.01.2026', '04.01.2026', 3, 50, 0, 0, 0, 14400.0, 0, false, 'Уточнить', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1250, client_id, 'Мария Экскурсовод', 'new', '18.12.2025', '18.12.2025', 1, 46, 0, 0, 0, 4500.0, 4500.0, true, 'Завезти в Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1249, client_id, 'Элина (Сититур)', 'new', '06.01.2026', '06.01.2026', 1, 46, 0, 0, 0, 4500.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1248, client_id, 'Ляйсан (Казань 360)', 'returned', '18.12.2025', '20.12.2025', 3, 32, 0, 0, 0, 7200.0, 7200.0, true, 'В офис Вернут в Азимут после 20:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1247, client_id, 'Ляйсан (Казань 360)', 'returned', '17.12.2025', '19.12.2025', 3, 36, 0, 0, 0, 7920.0, 7920.0, true, 'В офис с 14 до 17', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1246, client_id, 'Мира (ИП)', 'new', '12.12.2025', '12.12.2025', 1, 41, 0, 0, 0, 4000.0, 4000.0, true, 'Заберут в 10 с Баумана', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1245, client_id, 'Любовь (ТИЦ)', 'returned', '12.12.2025', '12.12.2025', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, 'Вернут в офис вечером, гид Эльвира, м Полина', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1244, client_id, 'Мария Экскурсовод', 'new', '06.12.2025', '07.12.2025', 2, 40, 0, 0, 0, 8000.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1243, client_id, 'Мария Экскурсовод', 'new', '03.01.2026', '04.01.2026', 2, 40, 0, 0, 0, 8000.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1242, client_id, 'Мария Экскурсовод', 'new', '31.12.2025', '01.01.2026', 2, 40, 0, 0, 0, 8000.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1241, client_id, 'Арсен (Юнион)', 'returned', '13.12.2025', '13.12.2025', 1, 21, 0, 0, 0, 1600.0, 1600.0, true, 'Из Сафара в релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена (Конгресс Авиа)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1240, client_id, 'Елена (Конгресс Авиа)', 'new', '10.12.2025', '10.12.2025', 1, 16, 0, 0, 0, 1200.0, 1200.0, true, 'В Марриот до 9:30 Оставят в Каспийске после 16;00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1239, client_id, 'Ляйсан (Казань 360)', 'returned', '08.12.2025', '08.12.2025', 1, 55, 0, 0, 0, 4320.0, 4320.0, true, '07.12 с 8:30 до 11:00 заберут от Свита Холла •Рузиля 54шт / оставит после 15:00 в фургончике (+7 965 603-40-01)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1238, client_id, 'Ляйсан (Казань 360)', 'returned', '08.12.2025', '09.12.2025', 2, 27, 0, 0, 0, 3680.0, 3680.0, true, '07.12 с 8:30 до 11:00 заберут от Свита Холла •Снежанна 26шт + 20 доп наушников / оставит 08.12 у свита Холла (+7 927 414-91-01)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1237, client_id, 'Карина (технологии путешествий)', 'cancelled', '07.12.2025', '07.12.2025', 1, 25, 0, 0, 0, 2400.0, 0, false, 'Карина К 18:00 заберут из фургончика, закончат в 22:00 сообщат куда оставят', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1236, client_id, 'Ляйсан (Казань 360)', 'returned', '08.12.2025', '09.12.2025', 2, 48, 0, 0, 0, 5840.0, 5840.0, true, '07.12 с 8:30 до 11:00 заберут от Свита Холла •Елена 47шт + 26 доп наушников / оставит 08.12 у свита Холла (+7 927 401-58-22)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1235, client_id, 'Ляйсан (Казань 360)', 'returned', '08.12.2025', '09.12.2025', 2, 50, 0, 0, 0, 10160.0, 10160.0, true, '07.12 с 8:30 до 11:00 заберут от Свита Холла •Эльмира 49шт + 78 доп наушников / оставит 08.12 в Кристалле (+7 917 878-83-60)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1234, client_id, 'Ляйсан (Казань 360)', 'returned', '08.12.2025', '09.12.2025', 2, 31, 0, 0, 0, 4000.0, 4000.0, true, '06.12 вечером в Кристалл •Ирина 30шт + 20 доп наушников / оставит 08.12 у Свита Холла (+7 917 293-48-70)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1233, client_id, 'Ляйсан (Казань 360)', 'returned', '08.12.2025', '08.12.2025', 2, 44, 0, 0, 0, 6560.0, 6560.0, true, '06.12 вечером в Амакс Сафар •Ольга 43 + 39 доп наушников / оставит 08.12 в Кристалл (+7 950 314-03-61)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1232, client_id, 'Эдик Заказы для групп', 'returned', '05.12.2025', '05.12.2025', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, '35 радиогидов . И один ваучер на свияжск и один на Кремль . Завтра 9:00 отель Азимут ул.Право-Булачная д.43/1. Гид Нина Максимова', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1231, client_id, 'Ляйсан (Казань 360)', 'returned', '05.12.2025', '05.12.2025', 1, 28, 0, 0, 0, 2160.0, 2160.0, true, '04.12 вечером или 05.12 до 11:00 в Кристалл! Гульназ 27шт / оставит в Амакс после 14:30 (+7 939 390-26-10)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1230, client_id, 'Ляйсан (Казань 360)', 'returned', '05.12.2025', '05.12.2025', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, '04.12 вечером или 05.12 до 11:00 в Кристалл! Светлана 30шт / оставит в Амакс после 14:30 (+7 967 780-00-66)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1229, client_id, 'Ляйсан (Казань 360)', 'returned', '05.12.2025', '05.12.2025', 1, 47, 0, 0, 0, 3680.0, 3680.0, true, '04.12 вечером или 05.12 до 11:00 в Кристалл! •Татьяна 46шт / оставит в Амакс после 14:00 (+7 987 282-71-66)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1228, client_id, 'Ляйсан (Казань 360)', 'returned', '05.12.2025', '05.12.2025', 1, 37, 0, 0, 0, 5440.0, 5440.0, true, '04.12 в офис Казань 360, в районе 12:00 Эльмира 36+32 доп наушника / оставит в Амакс после 20:30 (+7 917 878-83-60)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1227, client_id, 'Ляйсан (Казань 360)', 'returned', '05.12.2025', '05.12.2025', 1, 55, 0, 0, 0, 6560.0, 6560.0, true, '04.12 В офис Казань 360, в районе 12:00 Снежанна 54 +28 доп наушников / оставит в Амакс после 20:30 ( +7 927 414-91-01)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1226, client_id, 'Ляйсан (Казань 360)', 'returned', '05.12.2025', '05.12.2025', 1, 47, 0, 0, 0, 3680.0, 3680.0, true, '04.12 в офис Казань 360 в районе 12:00 Ольга 46шт / оставит в фургончике после 15:00 (+7 950 314-03-61)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1225, client_id, 'Ляйсан (Казань 360)', 'returned', '05.12.2025', '05.12.2025', 1, 48, 0, 0, 0, 3760.0, 3760.0, true, '04.12 в офис Казань 360 в районе 12:00 Алик 47шт / оставит в Амакс после 15:00 (+7 987 221-02-84)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1224, client_id, 'Андрей (Экскурс)', 'issued', '21.12.2025', '21.12.2025', 1, 31, 0, 0, 0, 3000.0, 0, false, 'Дауна 8:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1223, client_id, 'Андрей (Экскурс)', 'new', '07.12.2025', '07.12.2025', 1, 52, 0, 0, 0, 5100.0, 5100.0, true, 'Баумана в 8:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1222, client_id, 'Екатерина Кореева', 'new', '28.11.2025', '28.11.2025', 1, 25, 0, 0, 0, 2400.0, 2400.0, true, 'Оставить в фургончике до 15:00, вечером оставит в Шаляпине', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Искандер%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1221, client_id, 'Искандер', 'new', '25.11.2025', '25.11.2025', 1, 11, 0, 0, 0, 800.0, 800.0, true, 'Ольга ткач', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1220, client_id, 'Ольга', 'new', '04.01.2026', '05.01.2026', 2, 52, 0, 0, 0, 10000.0, 0, false, 'Уточнить', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1219, client_id, 'Галия', 'new', '14.12.2025', '14.12.2025', 1, 51, 0, 0, 0, 5000.0, 5000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1218, client_id, 'Андрей (Экскурс)', 'new', '23.11.2025', '23.11.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'Баумана в 8:15 Алена Лазуко', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айгуль Файзуллина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1217, client_id, 'Айгуль Файзуллина', 'new', '19.11.2025', '20.11.2025', 2, 29, 0, 0, 0, 5400.0, 5400.0, true, 'заберет из фургончика', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1216, client_id, 'Татьяна (Гольфстрим)', 'completed', '18.11.2025', '19.11.2025', 2, 33, 0, 0, 0, 4960.0, 4960.0, true, 'Авиатор. Игорь', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ленар (ИП Ножкин)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1215, client_id, 'Ленар (ИП Ножкин)', 'new', '20.11.2025', '20.11.2025', 1, 104, 0, 0, 0, 8000.0, 8000.0, true, '19.10 в районе 10 заберет ! 4 сумки по 26шт', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1214, client_id, 'Галия', 'new', '19.11.2025', '19.11.2025', 1, 20, 0, 0, 0, 1900.0, 1900.0, true, 'Заберет в 11:00 из фургончика', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1212, client_id, 'Галина (Тур Урал)', 'new', '08.01.2026', '09.01.2026', 2, 27, 0, 0, 0, 5000.0, 0, false, 'Ростов', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1211, client_id, 'Галина (Тур Урал)', 'new', '06.01.2026', '08.01.2026', 3, 37, 0, 0, 0, 10500.0, 0, false, 'Подольск Передать 5 вечером', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1210, client_id, 'Галина (Тур Урал)', 'new', '07.01.2026', '09.01.2026', 3, 37, 0, 0, 0, 10500.0, 0, false, 'Карабулак', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1209, client_id, 'Галина (Тур Урал)', 'new', '05.01.2026', '07.01.2026', 3, 37, 0, 0, 0, 10500.0, 0, false, 'ЕКБ 3', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1208, client_id, 'Галина (Тур Урал)', 'new', '03.01.2026', '05.01.2026', 3, 37, 0, 0, 0, 10500.0, 0, false, 'ЕКБ 2', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1207, client_id, 'Галина (Тур Урал)', 'new', '31.12.2025', '02.01.2026', 3, 37, 0, 0, 0, 10500.0, 0, false, 'ЕКБ 1', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1206, client_id, 'Галина (Тур Урал)', 'issued', '19.12.2025', '21.12.2025', 3, 32, 0, 0, 0, 9000.0, 0, false, 'Гатчина К 11:30 в дом чая , Катя Кореева', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1205, client_id, 'Эдик Заказы для групп', 'returned', '15.11.2025', '15.11.2025', 1, 30, 0, 0, 0, 2320.0, 2320.0, true, 'в 9:00 старт от деревни универсиады. Подъедет к часам. Нужно ей отдать сумку, ваучер на свияжск, и зп. 9600₽', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александр Романов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1204, client_id, 'Александр Романов', 'new', '29.11.2025', '30.11.2025', 2, 17, 0, 0, 0, 3000.0, 3000.0, true, 'Карат до 11:00. Оставят в спринтере у Оксаны', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1203, client_id, 'Ляйсан (Казань 360)', 'new', '16.11.2025', '19.11.2025', 4, 10, 0, 0, 0, 2240.0, 2240.0, true, '14.11 в офис , оригинал счёта и акта', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1202, client_id, 'Арсен (Юнион)', 'new', '15.11.2025', '15.11.2025', 1, 19, 0, 0, 0, 1440.0, 1440.0, true, 'От Сафара в Релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1201, client_id, 'Эдик Заказы для групп', 'returned', '12.11.2025', '12.11.2025', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, 'На завтра 32 Радиогида. В 16:00 от отеля Волга. Гид Ольга Ткач. Ваучер Кремль', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1200, client_id, 'Екатерина', 'completed', '20.11.2025', '23.11.2025', 4, 22, 0, 0, 0, 6000.0, 6000.0, true, '22.11. Не работают. в отеле Рамада Казань на Чернышевского. Для булата валиуллина и Антона зенкова если что', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1199, client_id, 'Эдик Заказы для групп', 'returned', '11.11.2025', '15.11.2025', 5, 35, 0, 0, 0, 12400.0, 12400.0, true, '11-15 ноября , 31 радиогид. И ваучер на кремль, свияжск, булгар. гид Катя Ильина. Кристал 12:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1198, client_id, 'Зульхиза Кутлучурина', 'new', '14.11.2025', '16.11.2025', 3, 37, 0, 0, 0, 10500.0, 10500.0, true, 'В Азу до 12:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1197, client_id, 'Галина (Тур Урал)', 'new', '18.11.2025', '20.11.2025', 3, 37, 0, 0, 0, 10500.0, 10500.0, true, 'Щелково, 8:15 дом чая, оставят в кристалле после 21:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1196, client_id, 'Зульхиза Кутлучурина', 'new', '08.11.2025', '09.11.2025', 2, 43, 0, 0, 0, 8200.0, 8200.0, true, '8 ноября к 11:30-12:00 в кафе «Азу» на Петербургской 52', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1195, client_id, 'Артем Агафонов', 'new', '08.11.2025', '09.11.2025', 2, 48, 0, 0, 0, 9200.0, 9200.0, true, 'Заберет Владимир Нежданов. Из фургончика в 13:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1194, client_id, 'Татьяна (Гольфстрим)', 'completed', '07.11.2025', '07.11.2025', 1, 20, 0, 0, 0, 1520.0, 1520.0, true, ', 7.11 к 9.20 а Дон Кихот радио гиды на19 человек гид Аида. Вернут после 20 в Донецке Кихот. +7 903 344-08-99 Аида', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1193, client_id, 'Ляйсан (Казань 360)', 'cancelled', '14.11.2025', '16.11.2025', 3, 40, 0, 0, 0, 9120.0, 0, false, 'Уточнить ОТМЕНА', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1192, client_id, 'Любовь (ТИЦ)', 'new', '08.11.2025', '09.11.2025', 2, 28, 0, 0, 0, 4160.0, 4160.0, true, 'Гид Эльвира, Полина, в офис', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1191, client_id, 'Любовь (ТИЦ)', 'new', '05.11.2025', '05.11.2025', 1, 18, 0, 0, 0, 1360.0, 1360.0, true, 'В офис до 13', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1190, client_id, 'Альберт (КТ)', 'new', '03.11.2025', '03.11.2025', 1, 40, 0, 0, 0, 3900.0, 3900.0, true, '3 ноября на 1 день нужны радиогиды, 39 человек +гид Ирина т.+7 927 421-36-82 Группа приедет на ЦЖД в 12:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1189, client_id, 'Эдик Заказы для групп', 'new', '02.11.2025', '02.11.2025', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, 'на завтра 32 радтогида в 11:00 от спасской башни кремля. И один ваучер на кремль. гид Гузель Габдрахманова . +7 917 283-86-75', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1188, client_id, 'Любовь (ТИЦ)', 'new', '03.11.2025', '04.11.2025', 2, 39, 0, 0, 0, 5920.0, 5920.0, true, 'В офис 03 днем , вернут 4 после обеда Гид Диана, мен Полина', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1187, client_id, 'Арсен (Юнион)', 'new', '03.11.2025', '03.11.2025', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, 'Из Сафара в релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1186, client_id, 'Арсен (Юнион)', 'new', '03.11.2025', '03.11.2025', 1, 24, 0, 0, 0, 1840.0, 1840.0, true, 'Из биляра в Биляр', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1185, client_id, 'Ирина (Иль Мио Тур)', 'new', '01.11.2025', '01.11.2025', 1, 37, 0, 0, 0, 2880.0, 2880.0, true, 'В 10:30 заберут', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1184, client_id, 'Зельфира', 'new', '01.11.2025', '01.11.2025', 1, 16, 0, 0, 0, 1500.0, 1500.0, true, 'Заберет сама в 8:45', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1183, client_id, 'Зельфира', 'new', '30.10.2025', '30.10.2025', 1, 16, 0, 0, 0, 1200.0, 1200.0, true, 'В кафе Медину на спартаковской до 13', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь Ким%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1182, client_id, 'Любовь Ким', 'new', '06.11.2025', '06.11.2025', 1, 44, 0, 0, 0, 4300.0, 4300.0, true, 'На 6 ноября оставьте для нас радиомикрофоны в кол- ве 43 шт) Отель Волга. С 15:00 - До 20 ч там же и оставим', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Искандер%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1181, client_id, 'Искандер', 'new', '29.10.2025', '29.10.2025', 1, 23, 0, 0, 0, 1680.0, 1680.0, true, 'в офис до 15:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1180, client_id, 'Любовь (ТИЦ)', 'new', '30.10.2025', '30.10.2025', 1, 63, 0, 0, 0, 4880.0, 4880.0, true, 'Две сумки на 37 и 26шт Гид Резида и Людмила , Полина', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1179, client_id, 'Мария Экскурсовод', 'new', '28.10.2025', '28.10.2025', 1, 53, 0, 0, 0, 5100.0, 5100.0, true, 'заберет из бусика ВЕРНЕТ В КРИССТАЛ ПОСЛЕ 22:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1178, client_id, 'Альберт (КТ)', 'new', '28.10.2025', '29.10.2025', 2, 38, 0, 0, 0, 5040.0, 5040.0, true, 'Заявка на 28 и 29 октября 36 человек +гид Лиля т.+7 965 602-05-28 28.10 приезжают в 12:30 на ЦЖД. ВЕРНУТ В РИВЬЕРУ', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга Лотова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1177, client_id, 'Ольга Лотова', 'new', '29.10.2025', '29.10.2025', 1, 21, 0, 0, 0, 2000.0, 2000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1176, client_id, 'Альберт (КТ)', 'new', '27.10.2025', '28.10.2025', 2, 35, 0, 0, 0, 4620.0, 4620.0, true, 'Гостиница Булгар 2* , улица Вишневского 21 33+ гид Владимир т 89178858409 На 27 и 28 октября', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1175, client_id, 'Татьяна (Гольфстрим)', 'new', '29.10.2025', '29.10.2025', 1, 23, 0, 0, 0, 1760.0, 1760.0, true, '29.10 22 чел. Карат к 8.20 вернут по созвону в 16.00 гид Диляра Рафкатовна 89179275489. СУМОЧКА В КАРАТЕ', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1174, client_id, 'Татьяна (Гольфстрим)', 'new', '28.10.2025', '28.10.2025', 1, 50, 0, 0, 0, 3920.0, 3920.0, true, '28.10 49 чел. к 9.30 в хостел Крылья вернут по созвону после 16. гид Николай 89172349414. ВЕРНУТ В ОФИС', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1173, client_id, 'Татьяна (Гольфстрим)', 'new', '28.10.2025', '30.10.2025', 3, 42, 0, 0, 0, 9600.0, 9600.0, true, '28-30.10 40 чел. 28 в Кристалл к 10.30 вернут в Кристалл 30.10 после 23.00 гид Гульсина Закиевна 89178975685', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1172, client_id, 'Татьяна (Гольфстрим)', 'new', '27.10.2025', '28.10.2025', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, '27-28.10 40 чел. 27 в Кристалл в 12 вернут 28 в Кристалл в 17.гид Лилия 89872975449', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1171, client_id, 'Татьяна (Гольфстрим)', 'new', '27.10.2025', '28.10.2025', 2, 42, 0, 0, 0, 6400.0, 6400.0, true, '27-28.10 40чел. 27 в Кристалл в 12 вернут в Кристалл 28 в 17 гид Диана 8927445452527', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1170, client_id, 'Любовь (ТИЦ)', 'new', '26.10.2025', '28.10.2025', 3, 53, 0, 0, 0, 12240.0, 12240.0, true, 'Гид Яна, доставкой, добавить в счёт 238₽ , Любовь', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1169, client_id, 'Татьяна (Гольфстрим)', 'new', '26.10.2025', '26.10.2025', 1, 25, 0, 0, 0, 1920.0, 1920.0, true, '26.10 24чел. Кристалл 9.30 вернут после 20.00 в Кристалл гид Ирина 89046620732 Вернут в 09:00 в кристалл 27.10', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1168, client_id, 'Галина (Тур Урал)', 'new', '01.11.2025', '03.11.2025', 3, 24, 0, 0, 0, 6600.0, 6600.0, true, 'В дом чая до 13. Оставят в кристалл после 22:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1167, client_id, 'Зульхиза Кутлучурина', 'new', '25.10.2025', '25.10.2025', 1, 26, 0, 0, 0, 2500.0, 2500.0, true, 'кафе азу до 14;30. Вернут в 19:00 к свито холлу', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1166, client_id, 'Татьяна (Гольфстрим)', 'new', '25.10.2025', '26.10.2025', 2, 24, 0, 0, 0, 3520.0, 3520.0, true, '25.10 22 чел. хостел Крылья в 6.00 сдадут 26.10 после 16. по созвону. гид Татьяна 89600344289 Вернули в крылья', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1165, client_id, 'Татьяна (Гольфстрим)', 'new', '25.10.2025', '25.10.2025', 1, 21, 0, 0, 0, 1600.0, 1600.0, true, '25.10 20 чел. Кристалл в 10 вернут по созвону. гида Марина 89172526993', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1164, client_id, 'Любовь (ТИЦ)', 'new', '24.10.2025', '24.10.2025', 1, 55, 0, 0, 0, 4320.0, 4320.0, true, 'В офис до 12, Римма', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1163, client_id, 'Элина (Сититур)', 'new', '02.11.2025', '02.11.2025', 1, 46, 0, 0, 0, 4500.0, 4500.0, true, 'Эверест в 17:00 в мано', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1162, client_id, 'Андрей (Экскурс)', 'new', '18.11.2025', '19.11.2025', 2, 36, 0, 0, 0, 5440.0, 5440.0, true, 'Кристал вернули туда же. 1 потеряли', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1161, client_id, 'Альберт (КТ)', 'new', '25.10.2025', '25.10.2025', 1, 157, 0, 0, 0, 11641.0, 11641.0, true, 'Группа #1 Начало в Свияжске в 9 утра 42 человека + гид Аида т. +79033440899 Группа #2 Начало в 10:00 на ЦЖД 45 человек + гид Татьяна т.89063271840 Группа #3 Начало в 10:00 на ЦЖД 29 человек + гид Ирина т.89274213682 Группа #4 Начало в 10:00 на ЦЖД 37 человек + гид Владимир т.89178858409 Все группы заканчивают в 20:10-20:30 на ЦЖД 43,46,30,38', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1160, client_id, 'Мария Экскурсовод', 'new', '31.12.2025', '01.01.2026', 2, 80, 0, 0, 0, 15200.0, 0, false, 'две сумки по 40', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Флот%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1159, client_id, 'Наталья Флот', 'new', '26.10.2025', '26.10.2025', 1, 62, 0, 0, 0, 6000.0, 6000.0, true, '2 сумки по 31. Кристал. Ирина софронова и Ирина совельева ВЕЧЕРОМ', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1158, client_id, 'Карина (технологии путешествий)', 'new', '28.10.2025', '28.10.2025', 1, 21, 0, 0, 0, 2000.0, 2000.0, true, 'К 15:00 заберут из фургончика Двойной комплект наушников', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1157, client_id, 'Алексей', 'new', '23.10.2025', '24.10.2025', 2, 44, 0, 0, 0, 8400.0, 8400.0, true, 'Волга начало в 12:30. Елена.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1156, client_id, 'Эдик Заказы для групп', 'new', '19.10.2025', '19.10.2025', 1, 100, 0, 0, 0, 5680.0, 5680.0, true, 'Сумки указаны в программе', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1155, client_id, 'Любовь (ТИЦ)', 'new', '22.10.2025', '22.10.2025', 1, 53, 0, 0, 0, 4160.0, 4160.0, true, 'Накануне, гид Надежда, римма', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1154, client_id, 'Любовь (ТИЦ)', 'new', '20.10.2025', '20.10.2025', 1, 89, 0, 0, 0, 6960.0, 6960.0, true, '2 сумки на 43 и 44шт утром, Римма', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1153, client_id, 'Эдик Заказы для групп', 'new', '01.11.2025', '01.11.2025', 1, 21, 0, 0, 0, 1600.0, 1600.0, true, '1 ноября . 20 радиогидов . в 10:00 от отеля Арон + ваучер на свияжск. Лариса', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1152, client_id, 'Эдик Заказы для групп', 'new', '26.10.2025', '26.10.2025', 1, 34, 0, 0, 0, 2640.0, 2640.0, true, '26 октября 33 радиогида + ваучер на кремль 9:30 от у ТЦ "Аида" Остановка Лаврентьева . Гид Ольга Ткач', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1151, client_id, 'Елена', 'new', '19.10.2025', '19.10.2025', 1, 41, 0, 0, 0, 4000.0, 4000.0, true, '19 октября 40 радиогидов. Утром в 9.30 забираю группу в Гранд отеле.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1150, client_id, 'Любовь (ТИЦ)', 'new', '17.10.2025', '17.10.2025', 1, 510, 0, 0, 0, 40000.0, 40000.0, true, 'В 9:30 Маяковского 24А', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1149, client_id, 'Любовь (ТИЦ)', 'new', '18.10.2025', '18.10.2025', 1, 54, 0, 0, 0, 4240.0, 4240.0, true, 'В офис утром Римма', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1148, client_id, 'Татьяна (Гольфстрим)', 'new', '17.10.2025', '19.10.2025', 3, 42, 0, 0, 0, 9600.0, 9600.0, true, 'Кристал. Гулистан Закиевна. +79178975685', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1147, client_id, 'Мария Экскурсовод', 'new', '18.10.2025', '18.10.2025', 1, 42, 0, 0, 0, 4100.0, 4100.0, true, 'Фатима. Сумка в Кристалле', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузелия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1146, client_id, 'Гузелия', 'new', '16.10.2025', '16.10.2025', 1, 8, 0, 0, 0, 1500.0, 1500.0, true, 'заберет в 11:40', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Супрунова (от Миры)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1145, client_id, 'Юлия Супрунова (от Миры)', 'new', '25.10.2025', '25.10.2025', 1, 185, 0, 0, 0, 20200.0, 20200.0, true, 'Поезд в 9:05 Казань пасс 1) 52+1 гид Наталья Жукова +7 (927) 243-43-67 2) 54+1 гид Валерий Матросов +7 (905) 319-54-86 3) 52+1 гид Зельфира +7 (987) 275-03-95 4) 22+1 гид на 2 дня Снежана +7 (927) 414-91-01 (5:02) поезд Заканчивают в 21:30 на жд', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1144, client_id, 'Любовь (ТИЦ)', 'new', '21.10.2025', '22.10.2025', 2, 51, 0, 0, 0, 7840.0, 7840.0, true, 'В офис, гид Лилия, Полина', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1143, client_id, 'Ольга (Сиалия)', 'new', '14.10.2025', '14.10.2025', 1, 20, 0, 0, 0, 1520.0, 1520.0, true, 'Кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1142, client_id, 'Эвелина (Инициатива)', 'new', '30.10.2025', '31.10.2025', 2, 16, 0, 0, 0, 2240.0, 2240.0, true, 'Марина Трэвел Юлия (2гр) В кристалл В офис Инициативы принесут 01.11', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1141, client_id, 'Галина (Тур Урал)', 'new', '30.10.2025', '01.11.2025', 3, 44, 0, 0, 0, 12300.0, 12300.0, true, 'Экскурсовод Марина 8917 288-90-13 Дома чая до 15:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1140, client_id, 'Галина (Тур Урал)', 'new', '28.10.2025', '30.10.2025', 3, 36, 0, 0, 0, 15200.0, 15200.0, true, 'Дом чая до 15:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1139, client_id, 'Галина (Тур Урал)', 'new', '25.10.2025', '27.10.2025', 3, 36, 0, 0, 0, 10200.0, 10200.0, true, 'К 14:30 дома Чая, Катя Кореева ВЕРНЕТ В КРИСТАЛЛ ПОСЛЕ 20:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия (Рыжий Слон)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1138, client_id, 'Юлия (Рыжий Слон)', 'completed', '27.10.2025', '29.10.2025', 3, 46, 0, 0, 0, 13200.0, 13200.0, true, 'Гид Диляра Ахмерова +7 950 327-62-72 Поезд прибывает 27 октября 377 в 12:29 . Кристал. ВЕРНУЛИ В ШАЛЯПИН', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузель (Юралс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1137, client_id, 'Гузель (Юралс)', 'new', '22.10.2025', '22.10.2025', 1, 41, 0, 0, 0, 4000.0, 4000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1136, client_id, 'Любовь (ТИЦ)', 'new', '11.10.2025', '11.10.2025', 1, 100, 0, 0, 0, 7840.0, 7840.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1135, client_id, 'Любовь (ТИЦ)', 'cancelled', '10.10.2025', '10.10.2025', 1, 135, 0, 0, 0, 10560.0, 0, false, 'Отмена!', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина «Романова Трэвел»%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1134, client_id, 'Екатерина «Романова Трэвел»', 'new', '11.10.2025', '11.10.2025', 1, 56, 0, 0, 0, 5500.0, 5500.0, true, 'Сопровождающая группы Ирина +7 951 908-31-31. Будем ждать вас в Туган Авылым 11.10 в 12:30. окончание экскурсии в 18:00.', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Дмитрий (Алабуга-Волокно)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1133, client_id, 'Дмитрий (Алабуга-Волокно)', 'new', '15.10.2025', '16.10.2025', 2, 52, 0, 0, 0, 10000.0, 10000.0, true, 'Сами заберут и вернут После обеда', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1132, client_id, 'Арсен (Юнион)', 'new', '11.10.2025', '11.10.2025', 1, 19, 0, 0, 0, 1440.0, 1440.0, true, 'От Сафара в Сулейман', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1131, client_id, 'Елена', 'cancelled', '11.10.2025', '12.10.2025', 2, 33, 0, 0, 0, 6200.0, 0, false, 'Заберет в +/- 12:00. 12 числа', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Марина Экс%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1130, client_id, 'Марина Экс', 'new', '24.10.2025', '25.10.2025', 2, 55, 0, 0, 0, 10600.0, 10600.0, true, 'Ф Крис стал', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1129, client_id, 'Мария Экскурсовод', 'new', '12.10.2025', '12.10.2025', 1, 47, 0, 0, 0, 4600.0, 4600.0, true, 'Сумка в Волге', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1128, client_id, 'Любовь (ТИЦ)', 'new', '08.10.2025', '10.10.2025', 3, 56, 0, 0, 0, 12960.0, 12960.0, true, 'В гфис любовь', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1127, client_id, 'Карина (технологии путешествий)', 'new', '07.10.2025', '07.10.2025', 1, 21, 0, 0, 0, 1600.0, 1600.0, true, 'Заберут до 14:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1126, client_id, 'Карина (технологии путешествий)', 'new', '10.10.2025', '10.10.2025', 1, 49, 0, 0, 0, 3760.0, 3760.0, true, '2 сумки на 27шт и 20шт, во второй половине дня', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1125, client_id, 'Ляйсан (Казань 360)', 'new', '17.10.2025', '20.10.2025', 4, 14, 0, 0, 0, 3840.0, 3840.0, true, 'В офис 16.10 Забрать 21 в обед оригинал акт и счёт', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1124, client_id, 'Любовь (ТИЦ)', 'new', '09.10.2025', '09.10.2025', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, 'Гид Аида, Римма', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1123, client_id, 'Любовь (ТИЦ)', 'new', '07.10.2025', '07.10.2025', 1, 46, 0, 0, 0, 3600.0, 3600.0, true, 'В офис, Римма', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1122, client_id, 'Любовь (ТИЦ)', 'new', '07.10.2025', '08.10.2025', 2, 40, 0, 0, 0, 6080.0, 6080.0, true, 'Гид Николай, мне Римма, в офис Тиц 7.10', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1121, client_id, 'Эдик Заказы для групп', 'new', '30.10.2025', '30.10.2025', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, '30 октября .35 штук . 11:00 от жд вокзала центрального. Нина Максимова, ваучер Кремль', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1120, client_id, 'Эдик Заказы для групп', 'new', '24.10.2025', '24.10.2025', 1, 42, 0, 0, 0, 3280.0, 3280.0, true, '24 октября , 41 штука. в 8:30 Хотел 13 ул.Московская д.13а. Светлана Чиж, ваучер на кремль', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1119, client_id, 'Эдик Заказы для групп', 'new', '28.10.2025', '29.10.2025', 2, 37, 0, 0, 0, 5600.0, 5600.0, true, '28-29 октября . 35 штук . гид Нина Максимова 28 октября в 11:00 от центрального жд', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1118, client_id, 'Эдик Заказы для групп', 'new', '07.10.2025', '07.10.2025', 1, 27, 0, 0, 0, 2080.0, 2080.0, true, 'на завтра 26 радиогидов иваучер на свияжск . в 9:00 от площади тукая . Гид Лариса Семенова ( ей на вечерке сегодня все можно передать)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1117, client_id, 'Инна Экскурсовод', 'new', '07.10.2025', '07.10.2025', 1, 46, 0, 0, 0, 3600.0, 3600.0, true, 'Амакс Сафар. Вернула в офис', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1116, client_id, 'Любовь (ТИЦ)', 'new', '06.10.2025', '08.10.2025', 3, 51, 0, 0, 0, 11760.0, 11760.0, true, 'Доставкой сами вызовут Любовь', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария (ОСР)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1115, client_id, 'Мария (ОСР)', 'completed', '06.10.2025', '09.10.2025', 3, 20, 0, 0, 0, 4320.0, 4320.0, true, 'Оставить в парк отеле', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1114, client_id, 'Любовь (ТИЦ)', 'new', '04.10.2025', '04.10.2025', 1, 25, 0, 0, 0, 1920.0, 1920.0, true, 'Вернут в офис Тиц к 19:00 Мен Анна', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Титова Галина (Эллинлайн)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1113, client_id, 'Титова Галина (Эллинлайн)', 'new', '12.10.2025', '12.10.2025', 1, 31, 0, 0, 0, 3000.0, 3000.0, true, 'Эллинлайн Инн --7807028247--12.10 , туристов --30 , едут из Иошкар Олы, тел гида из Казани, 89033428060--Светлана Сумка в кристале', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1112, client_id, 'Татьяна (Гольфстрим)', 'new', '04.10.2025', '05.10.2025', 2, 14, 0, 0, 0, 2080.0, 2080.0, true, 'заберет Игорь в 9:10. +79274055070. Вернул в фургончик', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1111, client_id, 'Ляйсан (Казань 360)', 'new', '28.10.2025', '28.10.2025', 1, 52, 0, 0, 0, 4080.0, 4080.0, true, '28 октября с 9:00 до 13:30 экскурсовод елена +79053162973 В релиту Оставят в Азу у АйТи парка в 12:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1110, client_id, 'Ляйсан (Казань 360)', 'new', '26.10.2025', '26.10.2025', 1, 52, 0, 0, 0, 4080.0, 4080.0, true, '26 октября с 11 :00 до 18:00 Экскурсовод снежана+79274149101 В Азу на Петербургской до 12 Оставят в Релите в 18', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1109, client_id, 'Татьяна (Гольфстрим)', 'new', '05.10.2025', '05.10.2025', 1, 30, 0, 0, 0, 2320.0, 2320.0, true, 'Сулейман . Аида. Вернут вечером в Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1108, client_id, 'Татьяна Чуб', 'new', '25.10.2025', '26.10.2025', 2, 41, 0, 0, 0, 7800.0, 7800.0, true, 'Бирку не делал. Сумка без номера. Пломба 2482', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1107, client_id, 'Эдик Заказы для групп', 'new', '04.10.2025', '04.10.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'завтра 50 штук оборудование. В 9:00 от Бутлерова 44. гид Настя Семенова , ей надо передать ваучер на булгар и документы для клиента. документы я смогу передать тебе после 14:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1106, client_id, 'Эвелина (Инициатива)', 'new', '04.10.2025', '05.10.2025', 2, 37, 0, 0, 0, 5600.0, 5600.0, true, 'Вернут в офис Инициативы, в пн забрать с деньгами', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария (ОСР)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1105, client_id, 'Мария (ОСР)', 'new', '04.10.2025', '05.10.2025', 2, 30, 0, 0, 0, 4640.0, 4640.0, true, 'Оставят 6 утром в парк отеле', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1104, client_id, 'Эдик Заказы для групп', 'new', '03.10.2025', '05.10.2025', 3, 25, 0, 0, 0, 5520.0, 5520.0, true, '3-5 октября , группа 23 человека . Нужны радиогиды +ваучер на кремль и свияжск . Гид Нина Максимова . завтра в 7:50 от центрального жд. Сумка в фургончике', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь Ким%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1103, client_id, 'Любовь Ким', 'cancelled', '06.11.2025', '06.11.2025', 1, 25, 0, 0, 0, 2500.0, 0, false, 'Волга', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь Ким%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1102, client_id, 'Любовь Ким', 'new', '23.10.2025', '23.10.2025', 1, 48, 0, 0, 0, 4700.0, 4700.0, true, 'Волга. Начало в 14:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1101, client_id, 'Зельфира', 'new', '03.10.2025', '03.10.2025', 1, 49, 0, 0, 0, 4800.0, 4800.0, true, 'Заберет в 8:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1100, client_id, 'Екатерина', 'completed', '06.10.2025', '06.10.2025', 1, 26, 0, 0, 0, 2500.0, 2500.0, true, '6 октября 15:00-18:00 25 радиогдиов на имя гида Татьяна Сулеймманова, отель Мариотт Казань', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Владимир Нежданов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1099, client_id, 'Владимир Нежданов', 'new', '04.10.2025', '05.10.2025', 2, 32, 0, 0, 0, 6000.0, 6000.0, true, 'Вернет в пн утром', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1098, client_id, 'Галия', 'new', '10.10.2025', '10.10.2025', 1, 20, 0, 0, 0, 1520.0, 1520.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена (Конгресс Авиа)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1097, client_id, 'Елена (Конгресс Авиа)', 'new', '04.10.2025', '04.10.2025', 1, 108, 0, 0, 0, 8400.0, 8400.0, true, 'В Марриот 3 сумки по 36шт Гиды: Наталия +7 987 238-41-05 София +7 905 038-37-23 Элина +7 917 236-98-27 В 14 вернут туда же, уточнить', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Агентство Удачи)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1096, client_id, 'Татьяна (Агентство Удачи)', 'cancelled', '08.10.2025', '08.10.2025', 1, 204, 0, 0, 0, 16000.0, 0, false, 'Отказ', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1095, client_id, 'Ляйсан (Казань 360)', 'new', '04.10.2025', '05.10.2025', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, 'В кристалл оставит к 22', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Дамир (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1094, client_id, 'Дамир (Экскурс)', 'new', '03.10.2025', '03.10.2025', 1, 102, 0, 0, 0, 10000.0, 10000.0, true, 'В Ривьеру до 16:00, вернут в 19:30 туда же', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ленар (ИП Ножкин)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1093, client_id, 'Ленар (ИП Ножкин)', 'new', '03.10.2025', '03.10.2025', 1, 14, 0, 0, 0, 1040.0, 1040.0, true, 'Нужен набор на 13+1 3.10 16:00-20:30 забрать и отнести можем сами на Баумана вам.', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Искандер%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1092, client_id, 'Искандер', 'new', '01.10.2025', '01.10.2025', 1, 30, 0, 0, 0, 2240.0, 2240.0, true, 'в офис', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1091, client_id, 'Любовь (ТИЦ)', 'new', '01.10.2025', '01.10.2025', 1, 50, 0, 0, 0, 3920.0, 3920.0, true, 'В офис тиц до 11, гид Юрий', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1090, client_id, 'Екатерина Кореева', 'new', '30.09.2025', '30.09.2025', 1, 16, 0, 0, 0, 1200.0, 1200.0, true, 'Заберет из бусика', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1089, client_id, 'Арсен (Юнион)', 'new', '04.10.2025', '04.10.2025', 1, 28, 0, 0, 0, 2160.0, 2160.0, true, 'От Корстон в Корстон', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1088, client_id, 'Арсен (Юнион)', 'new', '04.10.2025', '04.10.2025', 1, 25, 0, 0, 0, 1920.0, 1920.0, true, 'От Сафара, до Корстона', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1087, client_id, 'Галия', 'new', '28.10.2025', '30.10.2025', 2, 24, 0, 0, 0, 5680.0, 5680.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Супрунова (от Миры)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1086, client_id, 'Юлия Супрунова (от Миры)', 'new', '02.10.2025', '02.10.2025', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, 'Заберет сама в районе в 8:15', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сафина Алина (ФРГРТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1085, client_id, 'Сафина Алина (ФРГРТ)', 'completed', '01.10.2025', '03.10.2025', 3, 42, 0, 0, 0, 11840.0, 11840.0, true, 'В пн вернут', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1084, client_id, 'Татьяна (Гольфстрим)', 'new', '01.11.2025', '02.11.2025', 2, 37, 0, 0, 0, 5600.0, 5600.0, true, '1-2.11 35 чел. 1.11 в Кристалл к 12 вернут 2.11 по созвону гид Владимир Николаевич 89178858409. ВЕРНУЛ В КРИСТАЛ', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1083, client_id, 'Татьяна (Гольфстрим)', 'cancelled', '03.10.2025', '05.10.2025', 3, 49, 0, 0, 0, 11280.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1082, client_id, 'Мария Экскурсовод', 'new', '06.10.2025', '06.10.2025', 1, 48, 0, 0, 0, 3760.0, 3760.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1081, client_id, 'Мира (ИП)', 'new', '28.09.2025', '28.09.2025', 1, 50, 0, 0, 0, 3500.0, 3500.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Вадим%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1080, client_id, 'Вадим', 'new', '27.09.2025', '27.09.2025', 1, 56, 0, 0, 0, 4400.0, 4400.0, true, 'Оставил в Шаляпин', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1079, client_id, 'Мария Экскурсовод', 'new', '27.09.2025', '27.09.2025', 1, 27, 0, 0, 0, 2080.0, 2080.0, true, 'Кристал, вернут туда же', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1078, client_id, 'Эдик Заказы для групп', 'new', '27.09.2025', '27.09.2025', 1, 102, 0, 0, 0, 8000.0, 8000.0, true, 'Сергей и Резеда Оставят в 317', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1077, client_id, 'Татьяна (Гольфстрим)', 'new', '27.10.2025', '30.10.2025', 4, 45, 0, 0, 0, 13760.0, 13760.0, true, '27-30.10 43 чел. 27 в Кристалле в 11 вернут 30 в Кристалл после 23.00гид Игорь 89274055070 ВЕЧЕРОМ ВЕРНЕТ К 12 в фургончик', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1076, client_id, 'Татьяна (Гольфстрим)', 'new', '27.10.2025', '28.10.2025', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, '27.10-29.10 45 чел. 27 в Кристалле в 7.30 вернут 29 в Кристалл в 17.30 гид Аида 89033440899 ВЕЧЕРОМ. ОСТАВИЛИ ХОСТЕЛ СЛИП СПЕЙС. ЧИСТОПОЛЬСКАЯ 19А, 3 этаж, офис 36', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1075, client_id, 'Татьяна (Гольфстрим)', 'new', '26.10.2025', '29.10.2025', 4, 39, 0, 0, 0, 8880.0, 8880.0, true, '26-29.10 *без28 октября* 37 чел. в Кристалл к 11 сдадут 29.10 в кристалл после 19.30 гид Дания 89172904415 живут в Кварте.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1074, client_id, 'Татьяна (Гольфстрим)', 'new', '26.10.2025', '28.10.2025', 3, 32, 0, 0, 0, 7200.0, 7200.0, true, '26-28.10 30 чел. Кристалл в 7.30 сдадут 28.10 после 17 в Кристалл ВЕЧЕРОМ гид Ольга 89503140361', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1073, client_id, 'Татьяна (Гольфстрим)', 'new', '17.10.2025', '19.10.2025', 3, 50, 0, 0, 0, 11520.0, 11520.0, true, 'Кристал. Игорь. +79274055070', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1072, client_id, 'Екатерина Кореева', 'new', '28.09.2025', '28.09.2025', 1, 43, 0, 0, 0, 3360.0, 3360.0, true, 'Оставить в фургончике до 13:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1071, client_id, 'Ольга (Сиалия)', 'new', '30.09.2025', '30.09.2025', 1, 21, 0, 0, 0, 1600.0, 1600.0, true, 'Кристалл для Веры Валерьевны', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1070, client_id, 'Карина (технологии путешествий)', 'new', '27.09.2025', '27.09.2025', 1, 28, 0, 0, 0, 2160.0, 2160.0, true, 'Оставить в бусике до 16:00, вернут в 18:40', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1069, client_id, 'Зельфира', 'new', '26.09.2025', '28.09.2025', 3, 41, 0, 0, 0, 9360.0, 9360.0, true, 'Сумка в офисе', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1068, client_id, 'Эдик Заказы для групп', 'new', '26.09.2025', '26.09.2025', 1, 39, 0, 0, 0, 3040.0, 3040.0, true, 'Светлана Чиж, ваучер на Кремль , Московская 48', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1067, client_id, 'Любовь (ТИЦ)', 'new', '24.09.2025', '24.09.2025', 1, 11, 0, 0, 0, 800.0, 800.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1066, client_id, 'Любовь (ТИЦ)', 'new', '26.09.2025', '28.09.2025', 3, 32, 0, 0, 0, 7200.0, 7200.0, true, 'В офис 25, гид Николай и Татьяна, мен Римма', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1065, client_id, 'Арсен (Юнион)', 'new', '26.09.2025', '26.09.2025', 1, 18, 0, 0, 0, 1360.0, 1360.0, true, 'От Сафара до Сулеймана', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1064, client_id, 'Татьяна (Гольфстрим)', 'new', '25.09.2025', '28.09.2025', 4, 36, 0, 0, 0, 10880.0, 10880.0, true, '25-28 нужно 34 радиогида гид Владимир Николаевич 89178858409 привезти надо в отель Давыдов на К! Маркса к 9.30 , а сдаст сам к Вам в офис после обеда 28.09 или по созвону.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1063, client_id, 'Зульхиза Кутлучурина', 'new', '27.09.2025', '28.09.2025', 2, 29, 0, 0, 0, 4320.0, 4320.0, true, 'Заберет сама и вернет сама. 28.09 оставят в кафе азу после 13:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1062, client_id, 'Андрей (Экскурс)', 'cancelled', '02.10.2025', '02.10.2025', 1, 16, 0, 0, 0, 1200.0, 0, false, 'заберет сам', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1061, client_id, 'Татьяна', 'new', '28.09.2025', '28.09.2025', 1, 35, 0, 0, 0, 2720.0, 2720.0, true, 'Вернут либо в воскресенье вечером либо в понедельник', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1060, client_id, 'Ольга', 'new', '28.09.2025', '28.09.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'Заберет утром +7 927 240-82-50 Лариса', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айрат Нурмухаммадов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1059, client_id, 'Айрат Нурмухаммадов', 'new', '29.10.2025', '30.10.2025', 2, 40, 0, 0, 0, 6080.0, 6080.0, true, 'Кристалл', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айрат Нурмухаммадов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1058, client_id, 'Айрат Нурмухаммадов', 'cancelled', '26.10.2025', '28.10.2025', 3, 70, 0, 0, 0, 0.0, 0, false, '2 сумки по 35', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1057, client_id, 'Эдик Заказы для групп', 'new', '24.09.2025', '24.09.2025', 1, 30, 0, 0, 0, 2320.0, 2320.0, true, 'Ольга ткач. Ваучер Кремль, заберет утром', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1056, client_id, 'Любовь (ТИЦ)', 'new', '24.09.2025', '24.09.2025', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, 'Утром заберет, вернут 24.09 к 18:00 Гид Алексей, мен Камилла', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина «Романова Трэвел»%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1055, client_id, 'Екатерина «Романова Трэвел»', 'new', '24.09.2025', '27.09.2025', 4, 22, 0, 0, 0, 6080.0, 6080.0, true, 'Оставят в кристалле', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1054, client_id, 'Екатерина', 'new', '25.09.2025', '26.09.2025', 2, 42, 0, 0, 0, 6400.0, 6400.0, true, 'Ривьера. Валерий', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1053, client_id, 'Екатерина', 'new', '24.09.2025', '24.09.2025', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, 'грант отель. Валерий', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Мои Каникулы) (Круиз)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1052, client_id, 'Татьяна (Мои Каникулы) (Круиз)', 'new', '27.09.2025', '01.10.2025', 5, 25, 0, 0, 0, 8400.0, 8400.0, true, 'Азимут', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Управление Природными Территориями (УПТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1051, client_id, 'Управление Природными Территориями (УПТ)', 'new', '21.09.2025', '21.09.2025', 1, 29, 0, 0, 0, 2240.0, 2240.0, true, '22.09 утром привезут', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1050, client_id, 'Зельфира', 'new', '20.09.2025', '20.09.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'В 7:45 от свита Холла', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь Ким%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1049, client_id, 'Любовь Ким', 'new', '30.09.2025', '30.09.2025', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, 'Волга', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена (Конгресс Авиа)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1048, client_id, 'Елена (Конгресс Авиа)', 'new', '24.09.2025', '25.09.2025', 2, 37, 0, 0, 0, 5600.0, 5600.0, true, 'Гид Катя Кореева, из бусика', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1046, client_id, 'Эдик Заказы для групп', 'new', '19.09.2025', '19.09.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'в 12:00 от цирка, Элина, ваучер на кремль', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина Тур Москва%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1044, client_id, 'Галина Тур Москва', 'new', '20.09.2025', '20.09.2025', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, 'в Давыдов на Карла Маркса', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1043, client_id, 'Галия', 'new', '23.09.2025', '23.09.2025', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1042, client_id, 'Инна Экскурсовод', 'new', '20.09.2025', '20.09.2025', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, 'Вернула в офис', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1041, client_id, 'Мария Экскурсовод', 'new', '08.10.2025', '08.10.2025', 1, 48, 0, 0, 0, 3760.0, 3760.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1040, client_id, 'Карина (технологии путешествий)', 'new', '20.09.2025', '20.09.2025', 1, 306, 0, 0, 0, 25000.0, 25000.0, true, '6 групп по 50, привезти в деревню универсиады к 14:00 Забрать от Кремля в 16:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1039, client_id, 'Любовь (ТИЦ)', 'new', '20.09.2025', '20.09.2025', 1, 22, 0, 0, 0, 1680.0, 1680.0, true, 'Заберет утром от свита холла Гид оставит сумку 20 сентября к 16:00 в офисе ТИЦ на Баумана, 49. Гид Серов Алексей +7 917 255-38-26', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1038, client_id, 'Галина (Тур Урал)', 'new', '20.09.2025', '21.09.2025', 2, 35, 0, 0, 0, 6600.0, 6600.0, true, 'Оставили в кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Давид (КФУ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1037, client_id, 'Давид (КФУ)', 'cancelled', '10.10.2025', '11.10.2025', 2, 36, 0, 0, 0, 5600.0, 0, false, 'Отказ,', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1036, client_id, 'Мария', 'new', '05.01.2026', '05.01.2026', 1, 50, 0, 0, 0, 0.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1035, client_id, 'Мария', 'new', '03.01.2026', '03.01.2026', 1, 50, 0, 0, 0, 0.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Пронина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1034, client_id, 'Ирина Пронина', 'new', '04.10.2025', '05.10.2025', 2, 46, 0, 0, 0, 6240.0, 6240.0, true, '46 приемников и 88 наушников', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1033, client_id, 'Арсен (Юнион)', 'new', '20.09.2025', '20.09.2025', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, 'От Сафара в Корстон', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1032, client_id, 'Арсен (Юнион)', 'new', '20.09.2025', '20.09.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'От корстона в Корстон', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1031, client_id, 'Любовь (ТИЦ)', 'new', '17.09.2025', '18.09.2025', 2, 44, 0, 0, 0, 6720.0, 6720.0, true, 'В офис к 10, забрать 18 до 19:00 Ответственным лицом будет представитель Госкомитета РТ - Анастасия Софьина +7 904 765-52-93 Мен Камилла', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1030, client_id, 'Екатерина', 'new', '16.09.2025', '16.09.2025', 1, 16, 0, 0, 0, 1670.0, 1670.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1029, client_id, 'Зельфира', 'new', '17.09.2025', '18.09.2025', 2, 32, 0, 0, 0, 4800.0, 4800.0, true, 'Заберет в 9.30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1027, client_id, 'Любовь (ТИЦ)', 'new', '17.09.2025', '17.09.2025', 1, 35, 0, 0, 0, 2720.0, 2720.0, true, 'В офис Гид любовь, мен полина', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Сафина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1026, client_id, 'Алина Сафина', 'new', '20.09.2025', '20.09.2025', 1, 42, 0, 0, 0, 3280.0, 3280.0, true, 'Заберут 19 числа вечером.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1025, client_id, 'Татьяна (Гольфстрим)', 'new', '18.09.2025', '19.09.2025', 2, 27, 0, 0, 0, 4000.0, 4000.0, true, 'Биляр. Игорь. 89274055070 Вернут в Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1024, client_id, 'Татьяна (Гольфстрим)', 'new', '15.09.2025', '16.09.2025', 2, 29, 0, 0, 0, 4320.0, 4320.0, true, 'Игорь. 89274055070', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александр%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1023, client_id, 'Александр', 'new', '01.01.2026', '02.01.2026', 2, 50, 0, 0, 0, 9600.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей СПБ%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1022, client_id, 'Андрей СПБ', 'new', '14.09.2025', '14.09.2025', 1, 46, 0, 0, 0, 3600.0, 3600.0, true, 'В Раймонд Аида +7 903 344-08-99', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1021, client_id, 'Ирина (Иль Мио Тур)', 'new', '13.09.2025', '14.09.2025', 1, 42, 0, 0, 0, 6560.0, 6560.0, true, 'Сами заберут', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1020, client_id, 'Ляйсан (Казань 360)', 'new', '18.09.2025', '20.09.2025', 3, 38, 0, 0, 0, 8640.0, 8640.0, true, 'Светлана +79677800066 В кафе Азу на Чернышевского до 15:30 Вернет в Азимут (ибис) 21 утром', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1019, client_id, 'Татьяна Чуб', 'new', '19.09.2025', '21.09.2025', 3, 49, 0, 0, 0, 11280.0, 11280.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1018, client_id, 'Зульхиза Кутлучурина', 'new', '12.09.2025', '12.09.2025', 1, 22, 0, 0, 0, 3360.0, 3360.0, true, 'Азу. Петербургская 52', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1017, client_id, 'Анастасия', 'new', '16.09.2025', '19.09.2025', 4, 59, 0, 0, 0, 17600.0, 17600.0, true, '55шт двойной комплект наушников', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Управление Природными Территориями (УПТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1016, client_id, 'Управление Природными Территориями (УПТ)', 'new', '13.09.2025', '13.09.2025', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, 'В АйТи парк на спартаковской 12.09 в', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1015, client_id, 'Татьяна (Гольфстрим)', 'new', '12.09.2025', '13.09.2025', 2, 22, 0, 0, 0, 3200.0, 3200.0, true, 'Кристал, Диана', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1014, client_id, 'Анюта Родионова (Родина-тур)', 'new', '12.09.2025', '14.09.2025', 3, 38, 0, 0, 0, 8640.0, 8640.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1012, client_id, 'Эдик Заказы для групп', 'new', '11.09.2025', '11.09.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'Ольга Ткач', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александр%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1011, client_id, 'Александр', 'new', '12.09.2025', '14.09.2025', 3, 36, 0, 0, 0, 8160.0, 8160.0, true, 'Кристал. Разина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Марина Экс%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1010, client_id, 'Марина Экс', 'new', '12.09.2025', '12.09.2025', 1, 43, 0, 0, 0, 4200.0, 4200.0, true, 'В отель Давыдов на назарбаева, вечером 11.09, забрать можно 12 вечером', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1009, client_id, 'Екатерина Кореева', 'new', '12.09.2025', '14.09.2025', 3, 34, 0, 0, 0, 7200.0, 7200.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Тольятти)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1008, client_id, 'Ольга (Тольятти)', 'new', '12.09.2025', '12.09.2025', 1, 183, 0, 0, 0, 14400.0, 14400.0, true, '180шт + доп наушники, 3 сумки по 60шт 11.09 заберут от часов в 13:30 13.09 вернут', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1007, client_id, 'Любовь (ТИЦ)', 'new', '11.09.2025', '11.09.2025', 1, 102, 0, 0, 0, 8000.0, 8000.0, true, 'В офис тиц к вечеру 10.09 Вернут 11.09 к вечеру , две сумки по 50', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1006, client_id, 'Арсен (Юнион)', 'new', '12.09.2025', '14.09.2025', 3, 39, 0, 0, 0, 8880.0, 8880.0, true, 'Начало от Релиты, 12 сентября радиогиды должны там быть к 12.30. А вернут их в Стерлядку 14 сентября к 16.00.', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1005, client_id, 'Любовь (ТИЦ)', 'new', '09.09.2025', '09.09.2025', 1, 24, 0, 0, 0, 1840.0, 1840.0, true, 'К 10 в офис, гид Алексей, вернут к 19', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1004, client_id, 'Любовь (ТИЦ)', 'new', '06.09.2025', '06.09.2025', 1, 45, 0, 0, 0, 3520.0, 3520.0, true, 'В офис тиц к 10:00, забрать до 19:00 Гид Алиса Мен Камилла', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузелия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1003, client_id, 'Гузелия', 'new', '05.09.2025', '06.09.2025', 2, 14, 0, 0, 0, 2400.0, 2400.0, true, 'Из фургончика заберет 18:00. Наушников положить 33 шт', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1002, client_id, 'Эдик Заказы для групп', 'new', '05.09.2025', '05.09.2025', 1, 200, 0, 0, 0, 14400.0, 14400.0, true, 'Реч.порт. 14:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия (Рыжий Слон)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1001, client_id, 'Юлия (Рыжий Слон)', 'new', '10.09.2025', '12.09.2025', 3, 32, 0, 0, 0, 7200.0, 7200.0, true, 'Кристал до 12:00, Владлена', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (1000, client_id, 'Мира (ИП)', 'new', '06.09.2025', '06.09.2025', 1, 51, 0, 0, 0, 3500.0, 3500.0, true, 'Зебурт 5 вечером', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лариса Перминова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (999, client_id, 'Лариса Перминова', 'new', '06.09.2025', '06.09.2025', 1, 54, 0, 0, 0, 4240.0, 4240.0, true, 'Заберет утром', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузелия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (998, client_id, 'Гузелия', 'new', '02.09.2025', '02.09.2025', 1, 12, 0, 0, 0, 880.0, 880.0, true, 'Заберет', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (997, client_id, 'Ольга (Сиалия)', 'new', '02.09.2025', '02.09.2025', 1, 23, 0, 0, 0, 1760.0, 1760.0, true, 'В кристалл для Фирузы', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Рената (Твоя Казань)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (996, client_id, 'Рената (Твоя Казань)', 'new', '06.09.2025', '06.09.2025', 1, 58, 0, 0, 0, 4480.0, 4480.0, true, 'Две сумки на 28шт В рамаду, забрать там же', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (995, client_id, 'Эвелина (Инициатива)', 'new', '01.09.2025', '01.09.2025', 1, 39, 0, 0, 0, 5760.0, 5760.0, true, 'Сами заберу.т Двойной комплект наушников, днем группа 38 человек, вечером 35', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (994, client_id, 'Зульхиза Кутлучурина', 'new', '29.08.2025', '30.08.2025', 2, 26, 0, 0, 0, 3840.0, 3840.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (993, client_id, 'Анастасия', 'new', '01.09.2025', '01.09.2025', 1, 97, 0, 0, 0, 7520.0, 7520.0, true, 'Сумки на 33, 28, 33шт Заберут сами около 10', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Жанна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (992, client_id, 'Жанна', 'new', '12.09.2025', '12.09.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'Корстон. Номер 1807', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (990, client_id, 'Татьяна (Гольфстрим)', 'new', '29.08.2025', '30.08.2025', 2, 48, 0, 0, 0, 7360.0, 7360.0, true, '29-30 августа надо 46 радиогидов в кристалл к 7.30 гид Аида 89520385698', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (989, client_id, 'Анюта Родионова (Родина-тур)', 'new', '30.08.2025', '30.08.2025', 1, 40, 0, 0, 0, 3500.0, 3500.0, true, 'Отправить утром в Новинку', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айрат Нурмухаммадов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (988, client_id, 'Айрат Нурмухаммадов', 'new', '25.10.2025', '25.10.2025', 1, 306, 0, 0, 0, 24000.0, 24000.0, true, '6 сумок по 51. Старт от Лучано с Островского в 13:30 передать', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (987, client_id, 'Юлианна', 'new', '07.09.2025', '07.09.2025', 1, 35, 0, 0, 0, 2380.0, 2380.0, true, 'Уточнить', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Фируза%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (986, client_id, 'Фируза', 'new', '28.08.2025', '28.08.2025', 1, 13, 0, 0, 0, 1200.0, 1200.0, true, 'Оставить в офисе Вернет в Шаляпин', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (985, client_id, 'Эвелина (Инициатива)', 'new', '31.10.2025', '03.11.2025', 4, 29, 0, 0, 0, 7800.0, 7800.0, true, 'Краснодар 4 До 14, кафе мед Оставили в кристалле!', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (984, client_id, 'Эвелина (Инициатива)', 'new', '26.10.2025', '27.10.2025', 2, 41, 0, 0, 0, 6240.0, 6240.0, true, 'Марина Трэвел Юлия НАЛ ВЕРНУТ В ОФИС ИНИЦ 28.10 в 10:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (983, client_id, 'Эвелина (Инициатива)', 'new', '26.10.2025', '28.10.2025', 3, 46, 0, 0, 0, 10120.0, 10120.0, true, 'Арапова В кристалл до 11:00 нал ВЕРНУТ В КРИСТАЛЛ ПОСЛЕ 22:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (982, client_id, 'Эвелина (Инициатива)', 'new', '25.10.2025', '26.10.2025', 2, 55, 0, 0, 0, 8480.0, 8480.0, true, 'Марина Трэвел Олеся В кристалл, нал', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (981, client_id, 'Эвелина (Инициатива)', 'new', '27.10.2025', '29.10.2025', 3, 52, 0, 0, 0, 11500.0, 11500.0, true, 'ЮВА 3 В кристалл до 11:00, нал ВЕРНУТ в КРИСТАЛЛ ПОСЛЕ 22:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (980, client_id, 'Эвелина (Инициатива)', 'new', '25.10.2025', '27.10.2025', 3, 52, 0, 0, 0, 11500.0, 11500.0, true, 'ЮВА 2 ВЕРНУТ В кристалл ПОСЛЕ 22:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (979, client_id, 'Эвелина (Инициатива)', 'new', '25.10.2025', '27.10.2025', 3, 51, 0, 0, 0, 16270.0, 16270.0, true, 'ЮВА 1 ВЕРНУТ В крисстал ПОСЛЕ 22:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (978, client_id, 'Эвелина (Инициатива)', 'new', '27.10.2025', '31.10.2025', 5, 26, 0, 0, 0, 8510.0, 8510.0, true, 'Краснодар 3 До 14, кафе мед', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (977, client_id, 'Эвелина (Инициатива)', 'new', '27.10.2025', '31.10.2025', 5, 44, 0, 0, 0, 15170.0, 15170.0, true, 'Краснодар 2 До 14, кафе мед', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (976, client_id, 'Эвелина (Инициатива)', 'new', '27.10.2025', '31.10.2025', 5, 50, 0, 0, 0, 17390.0, 17390.0, true, 'Краснодар 1 До 14, кафе мед', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (975, client_id, 'Эвелина (Инициатива)', 'new', '23.10.2025', '27.10.2025', 5, 46, 0, 0, 0, 15910.0, 15910.0, true, 'Краснодар 0 НАЛ ВНРНУТ В КРИСТАЛЛ ПОСЛЕ 13:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (974, client_id, 'Арсен (Юнион)', 'new', '30.08.2025', '30.08.2025', 1, 25, 0, 0, 0, 1600.0, 1600.0, true, 'От Сафара в Корстон', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (973, client_id, 'Арсен (Юнион)', 'new', '30.08.2025', '30.08.2025', 1, 32, 0, 0, 0, 2480.0, 2480.0, true, 'От релиты до релиты', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (972, client_id, 'Эвелина (Инициатива)', 'new', '28.09.2025', '01.10.2025', 4, 38, 0, 0, 0, 8700.0, 8700.0, true, 'В офисе Инициативы', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (971, client_id, 'Эвелина (Инициатива)', 'new', '20.09.2025', '20.09.2025', 1, 47, 0, 0, 0, 3680.0, 3680.0, true, 'В офисе', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ленар (ИП Ножкин)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (970, client_id, 'Ленар (ИП Ножкин)', 'new', '29.08.2025', '01.09.2025', 4, 36, 0, 0, 0, 10560.0, 10560.0, true, 'Заберет 28.08 в 19:30 4 комплекта наушников', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (969, client_id, 'Андрей (Экскурс)', 'new', '27.08.2025', '27.08.2025', 1, 27, 0, 0, 0, 2080.0, 2080.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (968, client_id, 'Зельфира', 'new', '27.08.2025', '28.08.2025', 2, 33, 0, 0, 0, 4960.0, 4960.0, true, 'Заберет утром в 10:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (967, client_id, 'Камила Ягудина', 'new', '26.08.2025', '26.08.2025', 1, 11, 0, 0, 0, 800.0, 800.0, true, 'Заберут в 17:30 примерно', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (966, client_id, 'Любовь (ТИЦ)', 'new', '28.08.2025', '28.08.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'В офис тиц 27.08, вернут 29.08', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (965, client_id, 'Любовь (ТИЦ)', 'new', '27.08.2025', '27.08.2025', 1, 153, 0, 0, 0, 12000.0, 12000.0, true, 'В офис 26.08, вернут 28.08 Три сумки по 50', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (964, client_id, 'Мария Экскурсовод', 'new', '25.08.2025', '25.08.2025', 1, 40, 0, 0, 0, 3120.0, 3120.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина Тур Москва%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (963, client_id, 'Галина Тур Москва', 'new', '23.08.2025', '23.08.2025', 1, 48, 0, 0, 0, 3760.0, 3760.0, true, 'В АйТи парке', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (962, client_id, 'Ольга (Дольче Вита)', 'new', '23.08.2025', '24.08.2025', 2, 38, 0, 0, 0, 5760.0, 5760.0, true, 'В Кристалле', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сафина Алина (ФРГРТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (961, client_id, 'Сафина Алина (ФРГРТ)', 'new', '22.08.2025', '22.08.2025', 1, 150, 0, 0, 0, 12000.0, 12000.0, true, 'Утром заберут', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (960, client_id, 'Артем Агафонов', 'new', '30.08.2025', '30.08.2025', 1, 35, 0, 0, 0, 2720.0, 2720.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (959, client_id, 'Татьяна (Гольфстрим)', 'new', '22.08.2025', '23.08.2025', 2, 41, 0, 0, 0, 6240.0, 6240.0, true, 'Заберет утром Владимир 89178858409', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузелия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (958, client_id, 'Гузелия', 'new', '21.08.2025', '21.08.2025', 1, 10, 0, 0, 0, 800.0, 800.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (957, client_id, 'Андрей (Экскурс)', 'new', '16.09.2025', '19.09.2025', 3, 29, 0, 0, 0, 6480.0, 6480.0, true, 'Сулейман до 15:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анвар Каримов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (956, client_id, 'Анвар Каримов', 'new', '22.08.2025', '22.08.2025', 1, 140, 0, 0, 0, 11200.0, 11200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (955, client_id, 'Галина (Тур Урал)', 'new', '21.08.2025', '23.08.2025', 3, 30, 0, 0, 0, 8400.0, 8400.0, true, 'В кристалe', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (954, client_id, 'Татьяна (Гольфстрим)', 'new', '21.08.2025', '23.08.2025', 3, 20, 0, 0, 0, 4320.0, 4320.0, true, '18+ человек в Кристалл к 10 ч. На 3 или 4 дня. Гид Ирина 89046620732 Вернули в парк отель', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (953, client_id, 'Арсен (Юнион)', 'new', '24.08.2025', '24.08.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'В стерлядке', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (952, client_id, 'Ольга (Дольче Вита)', 'new', '22.08.2025', '24.08.2025', 3, 51, 0, 0, 0, 11760.0, 11760.0, true, 'В Кристалле', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (951, client_id, 'Камила Ягудина', 'new', '20.08.2025', '20.08.2025', 1, 14, 0, 0, 0, 1040.0, 1040.0, true, 'Заберут', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (950, client_id, 'Инна Экскурсовод', 'new', '22.08.2025', '23.08.2025', 2, 32, 0, 0, 0, 4800.0, 4800.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (949, client_id, 'Мира (ИП)', 'new', '19.08.2025', '21.08.2025', 3, 45, 0, 0, 0, 6020.0, 6020.0, true, 'Утром отправить в добрую столовую', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (948, client_id, 'Эдик Заказы для групп', 'new', '25.08.2025', '27.08.2025', 3, 51, 0, 0, 0, 11760.0, 11760.0, true, '25-27 августа , гид Катя Ильина . 25 августа в 14:20 на жд Восстания', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сафина Алина (ФРГРТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (947, client_id, 'Сафина Алина (ФРГРТ)', 'new', '18.08.2025', '18.08.2025', 1, 400, 0, 0, 0, 32000.0, 32000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Руслан (Тимсофт)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (946, client_id, 'Руслан (Тимсофт)', 'new', '22.08.2025', '22.08.2025', 1, 56, 0, 0, 0, 4400.0, 4400.0, true, 'Заберут вечером 21.08', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (945, client_id, 'Любовь (ТИЦ)', 'new', '18.08.2025', '18.08.2025', 1, 26, 0, 0, 0, 1920.0, 1920.0, true, '2 сумки по 12шт, в офис 18.08 к 10:00, Вернут вечером до 19:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (944, client_id, 'Любовь (ТИЦ)', 'new', '15.08.2025', '16.08.2025', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, 'В офис к 10:00, 15.08, двойной комплект наушников, Вернут 17.08 до 12:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (943, client_id, 'Эдик Заказы для групп', 'new', '15.08.2025', '15.08.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'Смак Сафар, Резеда, ваучер на кремль', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (942, client_id, 'Наталья', 'new', '23.08.2025', '24.08.2025', 2, 33, 0, 0, 0, 4960.0, 4960.0, true, 'Заберут утром', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузелия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (941, client_id, 'Гузелия', 'new', '14.08.2025', '14.08.2025', 1, 11, 0, 0, 0, 800.0, 800.0, true, 'Вернут в Кристал после 20:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (940, client_id, 'Мария Экскурсовод', 'new', '16.08.2025', '17.08.2025', 2, 48, 0, 0, 0, 7360.0, 7360.0, true, 'В Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (939, client_id, 'Алексей', 'new', '23.08.2025', '24.08.2025', 2, 53, 0, 0, 0, 8160.0, 8160.0, true, 'В Волгe', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (938, client_id, 'Ольга (Дольче Вита)', 'new', '15.08.2025', '17.08.2025', 3, 51, 0, 0, 0, 11760.0, 11760.0, true, 'В кристалл Оставила в кристалле', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (937, client_id, 'Арсен (Юнион)', 'new', '16.08.2025', '16.08.2025', 1, 16, 0, 0, 0, 1200.0, 1200.0, true, 'В Сулейман, вернут туда же', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (936, client_id, 'Арсен (Юнион)', 'new', '15.08.2025', '16.08.2025', 2, 38, 0, 0, 0, 4800.0, 4800.0, true, 'От амакса в Корстон около 20:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (935, client_id, 'Элина (Сититур)', 'new', '30.08.2025', '30.08.2025', 1, 47, 0, 0, 0, 3680.0, 3680.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (934, client_id, 'Ольга', 'new', '16.08.2025', '16.08.2025', 1, 40, 0, 0, 0, 3120.0, 3120.0, true, ', будет забирать +7 927 240-82-50 Лариса', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульназ%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (933, client_id, 'Гульназ', 'new', '16.08.2025', '16.08.2025', 1, 112, 0, 0, 0, 8800.0, 8800.0, true, 'Пушкина 8. В 8:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Вера%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (932, client_id, 'Вера', 'new', '13.08.2025', '13.08.2025', 1, 86, 0, 0, 0, 6720.0, 6720.0, true, 'Акварель хостел', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алла (Вятские Поляны)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (931, client_id, 'Алла (Вятские Поляны)', 'new', '13.08.2025', '13.08.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'Утром в 8 у Часов Вернут в реч порт, Эдику', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (930, client_id, 'Любовь (ТИЦ)', 'new', '13.08.2025', '14.08.2025', 2, 48, 0, 0, 0, 7360.0, 7360.0, true, 'В офис 13.08 к 10, вернут 15.08 до 12:00 Гид Диана', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (929, client_id, 'Любовь (ТИЦ)', 'new', '12.08.2025', '14.08.2025', 3, 18, 0, 0, 0, 3840.0, 3840.0, true, 'В офис тиц 12.08 в 10:15', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (928, client_id, 'Зельфира', 'new', '15.08.2025', '17.08.2025', 3, 49, 0, 0, 0, 11280.0, 11280.0, true, 'Заберет утром Оставила в бусике', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (927, client_id, 'Зельфира', 'new', '13.08.2025', '14.08.2025', 2, 46, 0, 0, 0, 7040.0, 7040.0, true, 'Заберет утром', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (926, client_id, 'Любовь (ТИЦ)', 'new', '10.08.2025', '10.08.2025', 1, 9, 0, 0, 0, 640.0, 640.0, true, 'В офис тиц в 10:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (925, client_id, 'Артем Агафонов', 'new', '08.08.2025', '09.08.2025', 2, 40, 0, 0, 0, 6240.0, 6240.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (924, client_id, 'Любовь (ТИЦ)', 'new', '11.08.2025', '11.08.2025', 1, 65, 0, 0, 0, 5040.0, 5040.0, true, '1 на 36 Ильмира; 2 на 27 Алсу, занеси накануне', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (923, client_id, 'Екатерина', 'new', '09.08.2025', '09.08.2025', 1, 20, 0, 0, 0, 1520.0, 1520.0, true, 'Сама заберет и вернет Экскурсия с 10:30 до 15:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (922, client_id, 'Ольга (Дольче Вита)', 'new', '09.08.2025', '10.08.2025', 2, 44, 0, 0, 0, 6720.0, 6720.0, true, 'В кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (921, client_id, 'Ольга (Дольче Вита)', 'new', '08.08.2025', '08.08.2025', 1, 45, 0, 0, 0, 3520.0, 3520.0, true, 'В кристалл, Мария Вернула в кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (920, client_id, 'Ольга (Дольче Вита)', 'new', '08.08.2025', '10.08.2025', 3, 49, 0, 0, 0, 11280.0, 11280.0, true, 'В кристалл, сопровождающий Ирина', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (919, client_id, 'Ольга (Сиалия)', 'new', '19.08.2025', '19.08.2025', 1, 49, 0, 0, 0, 3840.0, 3840.0, true, 'В кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (918, client_id, 'Гульнара', 'new', '08.08.2025', '10.08.2025', 3, 35, 0, 0, 0, 7920.0, 7920.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (917, client_id, 'Мира (ИП)', 'new', '07.08.2025', '07.08.2025', 1, 15, 0, 0, 0, 980.0, 980.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (916, client_id, 'Юлианна', 'new', '17.08.2025', '17.08.2025', 1, 38, 0, 0, 0, 2590.0, 2590.0, true, 'В волгу Оставила в бусике', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (915, client_id, 'Арсен (Юнион)', 'new', '09.08.2025', '09.08.2025', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, 'От Сафара до корстона', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (914, client_id, 'Арсен (Юнион)', 'new', '09.08.2025', '09.08.2025', 1, 40, 0, 0, 0, 3120.0, 3120.0, true, 'От релиты до релиты', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (913, client_id, 'Елена', 'new', '06.08.2025', '06.08.2025', 1, 35, 0, 0, 0, 2720.0, 2720.0, true, 'В 12:00 в трапезную', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Минеева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (912, client_id, 'Алина Минеева', 'new', '13.09.2025', '13.09.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'Созвониться', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (911, client_id, 'Мария Экскурсовод', 'new', '08.08.2025', '08.08.2025', 1, 45, 0, 0, 0, 3520.0, 3520.0, true, 'Волга', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (909, client_id, 'Любовь (ТИЦ)', 'new', '11.08.2025', '11.08.2025', 1, 138, 0, 0, 0, 10800.0, 10800.0, true, '2 сумки по 50, Нурия и Светлана 1 сумка на 35, Диляра В офис тиц 10. 08 до вечера', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (908, client_id, 'Ляйсан (Казань 360)', 'new', '11.08.2025', '13.08.2025', 3, 47, 0, 0, 0, 10800.0, 10800.0, true, 'Сами заберут 11.08 Гид Катя Кореева Вернут в отель Европа', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (907, client_id, 'Ляйсан (Казань 360)', 'new', '07.08.2025', '07.08.2025', 1, 46, 0, 0, 0, 3600.0, 3600.0, true, 'В офис 6 Гид Светлана +79677800066', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (906, client_id, 'Татьяна Чуб', 'new', '20.09.2025', '20.09.2025', 1, 20, 0, 0, 0, 1520.0, 1520.0, true, 'Заберут после 11:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алла (Вятские Поляны)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (905, client_id, 'Алла (Вятские Поляны)', 'new', '03.08.2025', '03.08.2025', 1, 39, 0, 0, 0, 3040.0, 3040.0, true, 'Заберут утром у часов, вернут в порт кому-нибудь', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (904, client_id, 'Ольга (Дольче Вита)', 'new', '01.08.2025', '03.08.2025', 3, 45, 0, 0, 0, 10320.0, 10320.0, true, 'В кристал', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузель (Юралс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (903, client_id, 'Гузель (Юралс)', 'new', '23.08.2025', '23.08.2025', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (902, client_id, 'Инна Экскурсовод', 'new', '08.08.2025', '09.08.2025', 2, 41, 0, 0, 0, 6240.0, 6240.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Минеева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (901, client_id, 'Алина Минеева', 'new', '02.08.2025', '02.08.2025', 1, 48, 0, 0, 0, 3760.0, 3760.0, true, 'Вечером перед вечер кой заберет Ирина Савельева', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (900, client_id, 'Анюта Родионова (Родина-тур)', 'new', '01.08.2025', '03.08.2025', 3, 45, 0, 0, 0, 10080.0, 10080.0, true, 'В мвияжск передать', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (899, client_id, 'Зельфира', 'new', '01.08.2025', '03.08.2025', 3, 54, 0, 0, 0, 12000.0, 12000.0, true, 'Сама заберет утром', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (898, client_id, 'Зельфира', 'new', '30.07.2025', '31.07.2025', 2, 48, 0, 0, 0, 7360.0, 7360.0, true, 'Сама заберет в 10:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (897, client_id, 'Эвелина (Инициатива)', 'new', '12.08.2025', '14.08.2025', 3, 32, 0, 0, 0, 6480.0, 6480.0, true, 'Группа 21 на 3 дня и группа 9 на 2 дня В кристалл 11.08 вечером', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (896, client_id, 'Арсен (Юнион)', 'new', '03.08.2025', '03.08.2025', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, 'От Релита до Ногая', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (895, client_id, 'Любовь (ТИЦ)', 'new', '28.07.2025', '28.07.2025', 1, 211, 0, 0, 0, 16480.0, 16480.0, true, '4 сумки по 49+1 1 сумка по 10+1 (Наталья) В офис тиц до 10:30, вернут 29.07 до 12:00 Ильмира, Яна, Инна, (Надия кристалл ) до 13:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Рената (Твоя Казань)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (894, client_id, 'Рената (Твоя Казань)', 'new', '01.08.2025', '02.08.2025', 2, 29, 0, 0, 0, 4320.0, 4320.0, true, 'Заберет гид Ольга вечером или утром', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (893, client_id, 'Любовь (ТИЦ)', 'new', '27.07.2025', '27.07.2025', 1, 62, 0, 0, 0, 4800.0, 4800.0, true, 'Гид Лариса на Баумана 49, 26.07 до 17:00 на 50шт Гид Гульнара на Баумана 49, 26.07 до 17:00 на 10шт Вернут 27.07 до 19:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (892, client_id, 'Любовь (ТИЦ)', 'new', '27.07.2025', '28.07.2025', 2, 104, 0, 0, 0, 16000.0, 16000.0, true, 'Гид Ванда в кристалл 26.07 до 20:00 на 50шт +2!!! Запасных(так как 2 дня) +двойной комплект наушников Гид Вероника в кристалл 26.07 до 20:00 на 50шт +2!!! Запасных(так как 2 дня) +двойной комплект наушников Вернут 29.07 до 12:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (891, client_id, 'Любовь (ТИЦ)', 'new', '27.07.2025', '27.07.2025', 1, 153, 0, 0, 0, 12000.0, 12000.0, true, 'Гид Алексей на Баумана 49, 26.07 до 17:00, 50 радиогидов Гид Елена в Кристалл, 26.07 вечером, 50 радиогидов Гид Ирина на Баумана 49, 26.07 до 17:00, 50 радиогидов Вернут 27.07 до 19:00 в офис ТИЦ', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (890, client_id, 'Ирина (Иль Мио Тур)', 'new', '28.07.2025', '28.07.2025', 1, 37, 0, 0, 0, 2880.0, 2880.0, true, 'Регину на университетской к 8', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (889, client_id, 'Мария Экскурсовод', 'new', '02.08.2025', '02.08.2025', 1, 46, 0, 0, 0, 3600.0, 3600.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (888, client_id, 'Мария Экскурсовод', 'new', '31.07.2025', '31.07.2025', 1, 38, 0, 0, 0, 2880.0, 2880.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (887, client_id, 'Эдик Заказы для групп', 'new', '26.07.2025', '27.07.2025', 2, 32, 0, 0, 0, 4800.0, 4800.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (886, client_id, 'Эдик Заказы для групп', 'new', '25.07.2025', '25.07.2025', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, 'Гузель. Корстон, до 14:00. Ваучер Кремль', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Владимир Нежданов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (885, client_id, 'Владимир Нежданов', 'new', '25.07.2025', '25.07.2025', 1, 66, 0, 0, 0, 5040.0, 5040.0, true, 'Заберет утром', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (884, client_id, 'Артем Агафонов', 'new', '26.07.2025', '26.07.2025', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, 'Владимир', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (883, client_id, 'Андрей (Экскурс)', 'new', '04.08.2025', '04.08.2025', 1, 15, 0, 0, 0, 1120.0, 1120.0, true, 'Корстон', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (882, client_id, 'Мира (ИП)', 'new', '26.07.2025', '26.07.2025', 1, 41, 0, 0, 0, 2800.0, 2800.0, true, 'Заберут вечером 25 числа', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (881, client_id, 'Сергей', 'new', '26.07.2025', '27.07.2025', 2, 28, 0, 0, 0, 4160.0, 4160.0, true, 'В азалию', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (880, client_id, 'Татьяна (Гольфстрим)', 'new', '26.07.2025', '27.07.2025', 2, 43, 0, 0, 0, 6560.0, 6560.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (879, client_id, 'Любовь (ТИЦ)', 'new', '25.07.2025', '25.07.2025', 1, 266, 0, 0, 0, 20800.0, 20800.0, true, '5 сумок по 50, гид Елена, Алексей, Инна, Яна, Ванда 1 сумка на 10 Диляра В офис тиц к 10:30 Вернут до 19:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (878, client_id, 'Ольга (Сиалия)', 'new', '05.08.2025', '05.08.2025', 1, 48, 0, 0, 0, 3680.0, 3680.0, true, 'Кристал Два микрофона и передатчика', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (877, client_id, 'Арсен (Юнион)', 'new', '26.07.2025', '26.07.2025', 1, 24, 0, 0, 0, 1840.0, 1840.0, true, 'От Сафара в Сулейман', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (876, client_id, 'Арсен (Юнион)', 'new', '25.07.2025', '26.07.2025', 2, 35, 0, 0, 0, 4960.0, 4960.0, true, 'От Сафара в релиту в районе 20:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ленар (ИП Ножкин)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (875, client_id, 'Ленар (ИП Ножкин)', 'new', '24.07.2025', '24.07.2025', 1, 136, 0, 0, 0, 10400.0, 10400.0, true, '4 сумки по 22 и 2 по 21', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (874, client_id, 'Эдик Заказы для групп', 'new', '23.07.2025', '23.07.2025', 1, 42, 0, 0, 0, 3280.0, 3280.0, true, 'Ольга ткач. Ваучер на свияжск', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (873, client_id, 'Ольга (Дольче Вита)', 'new', '25.07.2025', '27.07.2025', 3, 49, 0, 0, 0, 11280.0, 11280.0, true, 'В Кристал', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (872, client_id, 'Екатерина', 'new', '22.07.2025', '22.07.2025', 1, 13, 0, 0, 0, 960.0, 960.0, true, 'Хилтон. На имя Татьяна', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Виктор (Мастерминд)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (871, client_id, 'Виктор (Мастерминд)', 'new', '28.07.2025', '28.07.2025', 1, 50, 0, 0, 0, 5000.0, 5000.0, true, '27 заберут вечером Две сумки по 25шт', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (870, client_id, 'Ирина (Иль Мио Тур)', 'new', '21.07.2025', '21.07.2025', 1, 43, 0, 0, 0, 3360.0, 3360.0, true, 'В Татарстан к 8 Вернут туда же в 15:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (869, client_id, 'Мария Экскурсовод', 'new', '20.07.2025', '22.07.2025', 3, 17, 0, 0, 0, 3600.0, 3600.0, true, 'В Фатиму', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Агентство Удачи)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (868, client_id, 'Татьяна (Агентство Удачи)', 'new', '19.07.2025', '20.07.2025', 2, 70, 0, 0, 0, 10880.0, 10880.0, true, 'Сумки на 32 и 36 В Релиту на имя Эльзы +7 904 717-59-99', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Валентина Воронкова (Ввел Ком)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (867, client_id, 'Валентина Воронкова (Ввел Ком)', 'new', '22.07.2025', '24.07.2025', 3, 52, 0, 0, 0, 12000.0, 12000.0, true, 'В марриот 21.07', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Фируза%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (866, client_id, 'Фируза', 'new', '18.07.2025', '18.07.2025', 1, 15, 0, 0, 0, 1400.0, 1400.0, true, 'В офис', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (865, client_id, 'Ольга (Дольче Вита)', 'new', '18.07.2025', '18.07.2025', 1, 45, 0, 0, 0, 3520.0, 3520.0, true, 'Группа Марии', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (864, client_id, 'Ольга (Дольче Вита)', 'new', '18.07.2025', '20.07.2025', 3, 34, 0, 0, 0, 7680.0, 7680.0, true, 'Группа Ирины Вернули в кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (863, client_id, 'Ольга (Дольче Вита)', 'new', '18.07.2025', '20.07.2025', 3, 44, 0, 0, 0, 10080.0, 10080.0, true, 'Группа Кати Вернули в кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (862, client_id, 'Татьяна', 'new', '06.09.2025', '06.09.2025', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, 'Кристал, Лейла', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (861, client_id, 'Любовь (ТИЦ)', 'new', '18.07.2025', '18.07.2025', 1, 90, 0, 0, 0, 7040.0, 7040.0, true, 'Две сумки по 44шт В Тиц 17.07 до 17:00 Вернут 18.07 до 19:00 1) Гид Серов Алексей +7 917 255-38-26 2) Гид Елена Яхъяева +7 927 401-58-22', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (860, client_id, 'Арсен (Юнион)', 'new', '19.07.2025', '19.07.2025', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, 'В Сафар, вернут в корстон', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (859, client_id, 'Мира (ИП)', 'new', '18.07.2025', '18.07.2025', 1, 71, 0, 0, 0, 4900.0, 4900.0, true, 'Заберут 17', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (858, client_id, 'Арсен (Юнион)', 'new', '19.07.2025', '19.07.2025', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, 'От релита вернут в релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена (Конгресс Авиа)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (857, client_id, 'Елена (Конгресс Авиа)', 'new', '17.07.2025', '17.07.2025', 1, 28, 0, 0, 0, 2160.0, 2160.0, true, 'В здание присутсвеныхх мест 16.07 до 20:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (856, client_id, 'Галина (Тур Урал)', 'new', '17.07.2025', '19.07.2025', 3, 24, 0, 0, 0, 6600.0, 6600.0, true, 'В татарскую усадьбу не ресепшен', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (855, client_id, 'Мира (ИП)', 'new', '15.07.2025', '17.07.2025', 3, 47, 0, 0, 0, 9450.0, 9450.0, true, 'Доставка', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (854, client_id, 'Зельфира', 'new', '16.07.2025', '17.07.2025', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, 'Сама заберет утром в 10:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (853, client_id, 'Инна Экскурсовод', 'new', '25.07.2025', '26.07.2025', 2, 39, 0, 0, 0, 5920.0, 5920.0, true, 'Заберет утром', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (852, client_id, 'Камила Ягудина', 'new', '12.07.2025', '12.07.2025', 1, 11, 0, 0, 0, 800.0, 800.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (851, client_id, 'Екатерина', 'new', '12.07.2025', '12.07.2025', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, 'В тасиго нео. На имя Валерия Матросова', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (850, client_id, 'Татьяна (Гольфстрим)', 'new', '11.07.2025', '11.07.2025', 1, 29, 0, 0, 0, 2240.0, 2240.0, true, 'Добрый вечер, Леонид. На 11 июля надо на 28 чел. Радио гиды к 9.45 До вечера. Гид Ирина Палей +7 904 662-07-32. в А матти М. Джалиля1 Оставила в кристалле!', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (849, client_id, 'Гульнара', 'new', '12.07.2025', '13.07.2025', 2, 52, 0, 0, 0, 8000.0, 8000.0, true, 'Уточнить', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Яна Янова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (848, client_id, 'Яна Янова', 'new', '10.07.2025', '10.07.2025', 1, 16, 0, 0, 0, 1200.0, 1200.0, true, 'Заберет', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (847, client_id, 'Арсен (Юнион)', 'new', '11.07.2025', '11.07.2025', 1, 35, 0, 0, 0, 2720.0, 2720.0, true, 'В амакс Сафар, вернут в корстон', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (846, client_id, 'Ольга (Сиалия)', 'new', '22.07.2025', '22.07.2025', 1, 46, 0, 0, 0, 3520.0, 3520.0, true, 'Крсталл С группой наш сотрудник Елена 89277678701', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузель (Юралс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (845, client_id, 'Гузель (Юралс)', 'new', '12.07.2025', '12.07.2025', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, 'Уточнить', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (844, client_id, 'Элина (Сититур)', 'new', '12.07.2025', '12.07.2025', 1, 46, 0, 0, 0, 3600.0, 3600.0, true, 'Сумка в Мано', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (843, client_id, 'Ольга', 'new', '12.07.2025', '12.07.2025', 1, 53, 0, 0, 0, 4160.0, 4160.0, true, 'Заберут', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (842, client_id, 'Анюта Родионова (Родина-тур)', 'new', '11.07.2025', '13.07.2025', 3, 40, 0, 0, 0, 9120.0, 9120.0, true, 'Заберут 10 в течение дня', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (841, client_id, 'Ольга (Дольче Вита)', 'new', '11.07.2025', '13.07.2025', 3, 49, 0, 0, 0, 11280.0, 11280.0, true, 'Кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (840, client_id, 'Арсен (Юнион)', 'new', '09.07.2025', '09.07.2025', 1, 24, 0, 0, 0, 1840.0, 1840.0, true, 'В релиту, вернут в кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (839, client_id, 'Любовь (ТИЦ)', 'new', '19.07.2025', '19.07.2025', 1, 53, 0, 0, 0, 4160.0, 4160.0, true, '18.07 в офис, забрать 20.07 Гид: Алексей Серов +7 917 255-38-26', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Компания%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (838, client_id, 'Наталья Компания', 'new', '05.07.2025', '05.07.2025', 1, 31, 0, 0, 0, 2480.0, 2480.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (837, client_id, 'Любовь (ТИЦ)', 'new', '05.07.2025', '05.07.2025', 1, 22, 0, 0, 0, 1680.0, 1680.0, true, 'В Тиц до 10:30 Вернут до 19:00 в Тиц Мен Камилла Гид Эльвира +7 917 228-93-99', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (835, client_id, 'Артем Агафонов', 'new', '05.07.2025', '06.07.2025', 2, 36, 0, 0, 0, 5440.0, 5440.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (834, client_id, 'Зульхиза Кутлучурина', 'new', '04.07.2025', '05.07.2025', 2, 33, 0, 0, 0, 4800.0, 4800.0, true, 'Петербуржская 52', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (833, client_id, 'Татьяна (Гольфстрим)', 'new', '04.07.2025', '05.07.2025', 2, 41, 0, 0, 0, 6240.0, 6240.0, true, '4-5 июня 39 человек. Нужны радиогидв. Гид Ирина 89046620732', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (832, client_id, 'Ольга (Дольче Вита)', 'new', '04.07.2025', '06.07.2025', 3, 46, 0, 0, 0, 10560.0, 10560.0, true, 'В кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария (ОСР)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (831, client_id, 'Мария (ОСР)', 'new', '07.07.2025', '09.07.2025', 3, 19, 0, 0, 0, 4080.0, 4080.0, true, 'в офис 07.07 с 9:00 до 12:30?', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (830, client_id, 'Галина (Тур Урал)', 'new', '16.07.2025', '17.07.2025', 2, 55, 0, 0, 0, 10600.0, 10600.0, true, 'В 8 утра в алтын куль Гид Марина 8917 288-90-13', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айгуль Файзуллина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (829, client_id, 'Айгуль Файзуллина', 'new', '01.07.2025', '03.07.2025', 3, 52, 0, 0, 0, 12000.0, 12000.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (828, client_id, 'Эвелина (Инициатива)', 'new', '06.07.2025', '06.07.2025', 1, 41, 0, 0, 0, 2800.0, 2800.0, true, 'В Татарстан', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (827, client_id, 'Екатерина Кореева', 'new', '01.07.2025', '02.07.2025', 2, 25, 0, 0, 0, 3360.0, 3360.0, true, 'Сумка на 20 и 5', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (826, client_id, 'Эдик Заказы для групп', 'new', '30.06.2025', '30.06.2025', 1, 29, 0, 0, 0, 2240.0, 2240.0, true, 'Срочный заказ в Кремль', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (825, client_id, 'Зельфира', 'new', '02.07.2025', '03.07.2025', 2, 40, 0, 0, 0, 6080.0, 6080.0, true, 'Заберет примерно в 10:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (824, client_id, 'Татьяна (Гольфстрим)', 'new', '29.06.2025', '30.06.2025', 2, 30, 0, 0, 0, 4480.0, 4480.0, true, '29 июня к 7.30 в Кристалл надо радиогиды на 28 человек.сдадут в Кристалл 30 июня после 17.00 гид Ирина 89046620732', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (823, client_id, 'Татьяна (Гольфстрим)', 'new', '27.06.2025', '28.06.2025', 1, 49, 0, 0, 0, 7520.0, 7520.0, true, '27 июня надо на 47 чел. Радиогиды в Кристалл к 7.00. Сдадут в Кристал вечером 28. Гид Ванда 89655868806', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (822, client_id, 'Эдик Заказы для групп', 'new', '27.06.2025', '27.06.2025', 1, 37, 0, 0, 0, 2880.0, 2880.0, true, 'В 15:00 от Кремля', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Фируза%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (821, client_id, 'Фируза', 'new', '27.06.2025', '27.06.2025', 1, 17, 0, 0, 0, 1600.0, 1600.0, true, 'Заберет сама', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (820, client_id, 'Альберт (КТ)', 'new', '27.06.2025', '27.06.2025', 1, 18, 0, 0, 0, 1190.0, 1190.0, true, 'Заберут', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (819, client_id, 'Инна Экскурсовод', 'new', '04.07.2025', '05.07.2025', 2, 35, 0, 0, 0, 4000.0, 4000.0, true, 'Уточнить', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (818, client_id, 'Артем Агафонов', 'new', '28.06.2025', '28.06.2025', 1, 43, 0, 0, 0, 3200.0, 3200.0, true, 'Заберут. 28 утром', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (817, client_id, 'Мира (ИП)', 'new', '28.06.2025', '28.06.2025', 1, 21, 0, 0, 0, 1400.0, 1400.0, true, 'Карат', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (816, client_id, 'Альберт (КТ)', 'new', '28.06.2025', '28.06.2025', 1, 44, 0, 0, 0, 3010.0, 3010.0, true, 'Завтрак в Марджани 8. В 8:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (815, client_id, 'Альберт (КТ)', 'new', '27.06.2025', '28.06.2025', 2, 28, 0, 0, 0, 3640.0, 3640.0, true, 'Кристал. Ирина. 1 лежит отдельно, не работает', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (814, client_id, 'Альберт (КТ)', 'new', '27.06.2025', '28.06.2025', 2, 28, 0, 0, 0, 3640.0, 3640.0, true, 'Кристал. Владимир', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ленар (ИП Ножкин)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (813, client_id, 'Ленар (ИП Ножкин)', 'new', '26.06.2025', '26.06.2025', 1, 123, 0, 0, 0, 9600.0, 9600.0, true, '3 сумки по 40 в Ривьеру к 14:30, забрать в 18:20 из туган авылым 89377044790 Анастасия ответственная', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (812, client_id, 'Любовь (ТИЦ)', 'new', '28.06.2025', '28.06.2025', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, 'В офис к 10:30, забрать с отеля мираж после 20:00 +7 903 388-89-29 Гид Ильмира', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (811, client_id, 'Арсен (Юнион)', 'new', '28.06.2025', '28.06.2025', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, 'В релиту, вернут в релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (810, client_id, 'Арсен (Юнион)', 'new', '28.06.2025', '28.06.2025', 1, 23, 0, 0, 0, 1760.0, 1760.0, true, 'В Сафар, вернут в Корстон', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (809, client_id, 'Ольга (Сиалия)', 'new', '08.07.2025', '08.07.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'В Кристал', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (808, client_id, 'Камила Ягудина', 'new', '08.07.2025', '08.07.2025', 1, 25, 0, 0, 0, 1920.0, 1920.0, true, 'Заберет', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (807, client_id, 'Екатерина', 'new', '25.06.2025', '26.06.2025', 2, 20, 0, 0, 0, 2880.0, 2880.0, true, 'НЕО тасига', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (806, client_id, 'Любовь (ТИЦ)', 'new', '25.06.2025', '26.06.2025', 2, 156, 0, 0, 0, 20000.0, 20000.0, true, '3 сумки по 52шт в офис Тиц Забрать 27', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (805, client_id, 'Любовь (ТИЦ)', 'new', '25.06.2025', '25.06.2025', 1, 46, 0, 0, 0, 7200.0, 7200.0, true, 'В офис две сумки по 45', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена (Конгресс Авиа)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (804, client_id, 'Елена (Конгресс Авиа)', 'new', '24.06.2025', '25.06.2025', 2, 12, 0, 0, 0, 1600.0, 1600.0, true, 'В Нео Гид Эльзара для компании Пфайзер', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (803, client_id, 'Альберт (КТ)', 'new', '23.06.2025', '24.06.2025', 1, 34, 0, 0, 0, 4480.0, 4480.0, true, '23.06 и 24.06* Группа 32 чел+ гид Владимир т. +7 917 885-84-09, гид Владимир', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (802, client_id, 'Эдик Заказы для групп', 'new', '21.06.2025', '21.06.2025', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, 'и на завтра нужно 40 штук в 11:30 от ул Толстого д.14 . Гид Нурия', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (801, client_id, 'Ольга', 'new', '21.06.2025', '21.06.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'Заберет утром Елена Козлова', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (800, client_id, 'Любовь (ТИЦ)', 'new', '20.06.2025', '23.06.2025', 4, 25, 0, 0, 0, 7360.0, 7360.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (799, client_id, 'Любовь (ТИЦ)', 'new', '20.06.2025', '23.06.2025', 4, 43, 0, 0, 0, 13120.0, 13120.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (798, client_id, 'Альберт (КТ)', 'new', '20.06.2025', '20.06.2025', 1, 31, 0, 0, 0, 2100.0, 2100.0, true, 'Забрать из Сулеймана Ирина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александр%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (797, client_id, 'Александр', 'new', '21.06.2025', '22.06.2025', 2, 50, 0, 0, 0, 7680.0, 7680.0, true, 'Кристал Ольга', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (796, client_id, 'Екатерина', 'new', '20.06.2025', '20.06.2025', 2, 17, 0, 0, 0, 2560.0, 2560.0, true, 'Раймонд. Для Татьяны', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (795, client_id, 'Арсен (Юнион)', 'new', '21.06.2025', '21.06.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'В релиту, вернут туда же', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (794, client_id, 'Арсен (Юнион)', 'new', '20.06.2025', '21.06.2025', 1, 30, 0, 0, 0, 2240.0, 2240.0, true, 'В Сафар, вернут в Сулейман', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (792, client_id, 'Ольга (Сиалия)', 'new', '24.06.2025', '24.06.2025', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, 'В кристал', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина Тур Москва%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (791, client_id, 'Галина Тур Москва', 'new', '19.06.2025', '20.06.2025', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, 'В Европу , оставят в АйТи парке', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (790, client_id, 'Ольга', 'new', '21.06.2025', '21.06.2025', 1, 49, 0, 0, 0, 3760.0, 3760.0, true, 'В нео Тасиго с 9 до 18', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (789, client_id, 'Екатерина', 'new', '18.06.2025', '18.06.2025', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, 'Да, пусть оставят на ресепшене на мой номер (1617 Стрелкова Анастасия) корстон', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (788, client_id, 'Эдик Заказы для групп', 'new', '17.06.2025', '19.06.2025', 3, 55, 0, 0, 0, 12000.0, 12000.0, true, 'Элина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (786, client_id, 'Зельфира', 'new', '18.06.2025', '19.06.2025', 2, 44, 0, 0, 0, 6720.0, 6720.0, true, 'Заберет утром в 10:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Родина-тур%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (785, client_id, 'Родина-тур', 'new', '18.06.2025', '20.06.2025', 3, 24, 0, 0, 0, 5280.0, 5280.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (784, client_id, 'Татьяна Чуб', 'new', '15.06.2025', '15.06.2025', 1, 31, 0, 0, 0, 2480.0, 2480.0, true, 'Амстердам', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (783, client_id, 'Галина (Тур Урал)', 'new', '12.06.2025', '12.06.2025', 1, 26, 0, 0, 0, 5000.0, 5000.0, true, 'Оставила в бусинке', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (782, client_id, 'Любовь (ТИЦ)', 'new', '12.06.2025', '14.06.2025', 3, 40, 0, 0, 0, 12160.0, 12160.0, true, 'В офис Тиц', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (781, client_id, 'Любовь (ТИЦ)', 'new', '12.06.2025', '14.06.2025', 3, 39, 0, 0, 0, 11840.0, 11840.0, true, 'В офис тиц', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Дарья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (780, client_id, 'Дарья', 'new', '21.06.2025', '21.06.2025', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, 'Позвонит экскурсовод. Утром созвониться Сдали в татарскую усадьбу', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузель (Юралс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (779, client_id, 'Гузель (Юралс)', 'new', '28.06.2025', '28.06.2025', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, 'Заберет 27 вечером часов в 18:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (777, client_id, 'Эвелина (Инициатива)', 'new', '21.06.2025', '21.06.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'В мано до 12, вернут после 19 в Татарстан', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина (ОЛТА Трэвел)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (776, client_id, 'Екатерина (ОЛТА Трэвел)', 'new', '24.06.2025', '24.06.2025', 1, 21, 0, 0, 0, 1520.0, 1520.0, true, 'Сулейман к 10, вернут туда же +7 937 575-03-93 гид резеда', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (775, client_id, 'Ольга (Дольче Вита)', 'new', '12.06.2025', '14.06.2025', 3, 45, 0, 0, 0, 10320.0, 10320.0, true, 'Оставила в Кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (774, client_id, 'Ольга (Дольче Вита)', 'new', '13.06.2025', '13.06.2025', 1, 43, 0, 0, 0, 3360.0, 3360.0, true, 'В кристалл, оставят там же в 17;00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (773, client_id, 'Ирина (Иль Мио Тур)', 'new', '14.06.2025', '15.06.2025', 2, 42, 0, 0, 0, 6400.0, 6400.0, true, 'В космос, вернут туда же после 20:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (772, client_id, 'Мария Экскурсовод', 'new', '11.06.2025', '12.06.2025', 2, 20, 0, 0, 0, 2880.0, 2880.0, true, '18 штук на 11 и 12 июня. с 9.00 с апарт Отеля Пушкина 26', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (771, client_id, 'Татьяна (Гольфстрим)', 'new', '10.06.2025', '12.06.2025', 3, 34, 0, 0, 0, 7680.0, 7680.0, true, '10 июня надо 32 радиогида (гид Аида 89033440899) Можно,если успеете в 7.30 в Кристалл, или в 08:30 – 09:30 Завтрак Кафе «Овсянки» ул.Бутлерова 34а 89046660417', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (769, client_id, 'Арсен (Юнион)', 'new', '13.06.2025', '13.06.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'В Сафар, вернут в Сулейман', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (768, client_id, 'Арсен (Юнион)', 'new', '12.06.2025', '12.06.2025', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, 'В Сафар Вернут в релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (767, client_id, 'Зельфира', 'new', '12.06.2025', '12.06.2025', 1, 54, 0, 0, 0, 4080.0, 4080.0, true, 'Утром заберет в 08:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (765, client_id, 'Альберт (КТ)', 'new', '12.06.2025', '15.06.2025', 3, 42, 0, 0, 0, 8400.0, 8400.0, true, 'Радиогиды на все дни 40 человек 12-15 июня Отель Мираж Гид Ирина Баталова т +7 927 421-36-82 Приедут на жд в 10:50', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (764, client_id, 'Мира (ИП)', 'new', '09.06.2025', '10.06.2025', 2, 22, 0, 0, 0, 2800.0, 2800.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (763, client_id, 'Ирина (Иль Мио Тур)', 'new', '09.06.2025', '09.06.2025', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, 'В Татарстан Вернут туда же после 19', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Родина-тур%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (762, client_id, 'Родина-тур', 'new', '14.06.2025', '16.06.2025', 3, 40, 0, 0, 0, 9120.0, 9120.0, true, 'Ирина Пронина. Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Пронина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (761, client_id, 'Ирина Пронина', 'new', '13.06.2025', '13.06.2025', 1, 45, 0, 0, 0, 3200.0, 3200.0, true, 'Фатима', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (760, client_id, 'Татьяна (Гольфстрим)', 'new', '07.06.2025', '08.06.2025', 2, 46, 0, 0, 0, 7040.0, 7040.0, true, '. 7.июня в 10 в Кристалл , радиогиды. 44 человека Гид Владимир Николаевич 89178858409 сдадут вечером 8 июня в Кристалл', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (759, client_id, 'Алексей', 'new', '10.06.2025', '11.06.2025', 2, 53, 0, 0, 0, 8160.0, 8160.0, true, 'В 12 в Татарстан', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (758, client_id, 'Юлианна', 'new', '18.06.2025', '18.06.2025', 1, 42, 0, 0, 0, 2870.0, 2870.0, true, 'ВЕрнула в кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (757, client_id, 'Зульхиза Кутлучурина', 'new', '06.06.2025', '07.06.2025', 1, 49, 0, 0, 0, 7520.0, 7520.0, true, 'Будем в пятницу в кафе «Азу» в 15:00, возле айти', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (756, client_id, 'Ляйсан (Казань 360)', 'new', '12.06.2025', '14.06.2025', 3, 53, 0, 0, 0, 12240.0, 12240.0, true, 'В кристалл Гид Эльмира +7 917 878-83-60 Оставила в кристалле', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (755, client_id, 'Екатерина', 'new', '05.06.2025', '05.06.2025', 1, 16, 0, 0, 0, 1200.0, 1200.0, true, '08:30 утра отель Венера московская г. Казань, ул. Московская, д. 35. валерий матросов гид +7 905 319-54-86', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (754, client_id, 'Юлианна', 'new', '14.06.2025', '17.06.2025', 4, 26, 0, 0, 0, 6440.0, 6440.0, true, 'Максим горький', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (753, client_id, 'Юлианна', 'new', '13.06.2025', '14.06.2025', 2, 47, 0, 0, 0, 6300.0, 6300.0, true, 'Оставила в волге', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (752, client_id, 'Эдик Заказы для групп', 'new', '05.06.2025', '05.06.2025', 1, 28, 0, 0, 0, 2160.0, 2160.0, true, '27 штук , 5 июня в 06:00 забрать с жд вокзала Наталья. Ваучер на кремль', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена Павловна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (751, client_id, 'Елена Павловна', 'new', '06.06.2025', '06.06.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'Заберут. Ольга', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Минеева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (750, client_id, 'Алина Минеева', 'new', '28.06.2025', '28.06.2025', 1, 92, 0, 0, 0, 7200.0, 7200.0, true, 'Кристал. Лариса', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Имя%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (749, client_id, 'Имя', 'new', '12.06.2025', '12.06.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'Отель Дион Гид Юстасия, вернут утром к 10 на Баумана', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (748, client_id, 'Наталья', 'new', '21.06.2025', '21.06.2025', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, 'В кристалл Вернет в фургончик', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (747, client_id, 'Екатерина Кореева', 'new', '04.06.2025', '05.06.2025', 2, 17, 0, 0, 0, 2400.0, 2400.0, true, 'Заберет после обеда, на связи', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (746, client_id, 'Татьяна (Гольфстрим)', 'new', '03.06.2025', '05.06.2025', 3, 36, 0, 0, 0, 8160.0, 8160.0, true, '3-5 июня надо будет 34 радиогида в Кристалл к 10 . 30 сдадут вечером в Кристалл 5 июня гид Диана. +7 927 445-45-25', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (745, client_id, 'Арсен (Юнион)', 'new', '07.06.2025', '07.06.2025', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, 'В Сафар Вернут в Релиту в 23:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (744, client_id, 'Любовь (ТИЦ)', 'new', '04.06.2025', '06.06.2025', 3, 44, 0, 0, 0, 10080.0, 10080.0, true, 'В кристалл Вернут в кристал 06 после 21:00 Гид Ванда 1 утерян', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (743, client_id, 'Анюта Родионова (Родина-тур)', 'new', '20.06.2025', '21.06.2025', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, 'Ирина пронина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (742, client_id, 'Екатерина', 'new', '02.06.2025', '02.06.2025', 1, 82, 0, 0, 0, 6400.0, 6400.0, true, 'Рамада ~Антон Зенков +7 919 695‑73‑73', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (741, client_id, 'Любовь (ТИЦ)', 'new', '04.06.2025', '04.06.2025', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, '3 до 19 Забрать 5', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия Пашинин (НК Транс Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (740, client_id, 'Анастасия Пашинин (НК Транс Тур)', 'new', '08.08.2025', '10.08.2025', 3, 48, 0, 0, 0, 11040.0, 11040.0, true, 'Кристал, Яна', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия Пашинин (НК Транс Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (739, client_id, 'Анастасия Пашинин (НК Транс Тур)', 'new', '18.07.2025', '20.07.2025', 3, 40, 0, 0, 0, 9600.0, 9600.0, true, 'Кристал. Яна', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия Пашинин (НК Транс Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (738, client_id, 'Анастасия Пашинин (НК Транс Тур)', 'new', '04.07.2025', '06.07.2025', 3, 40, 0, 0, 0, 9600.0, 9600.0, true, 'Кристал. Яна', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия Пашинин (НК Транс Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (737, client_id, 'Анастасия Пашинин (НК Транс Тур)', 'new', '27.06.2025', '29.06.2025', 3, 43, 0, 0, 0, 9840.0, 9840.0, true, 'Кристал. Яна', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айгуль Файзуллина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (736, client_id, 'Айгуль Файзуллина', 'new', '06.06.2025', '08.06.2025', 2, 53, 0, 0, 0, 8320.0, 8320.0, true, 'Сумка в отели Раймонд', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия Пашинин (НК Транс Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (735, client_id, 'Анастасия Пашинин (НК Транс Тур)', 'new', '06.06.2025', '08.06.2025', 3, 43, 0, 0, 0, 9840.0, 9840.0, true, 'Кристал. Яна', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (734, client_id, 'Эдик Заказы для групп', 'new', '28.06.2025', '30.06.2025', 3, 24, 0, 0, 0, 5280.0, 5280.0, true, '22 штуки 27,28,29,30 июня . гид Наталья Никифорова . 27 июня в 15:00 от жд восстания', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (733, client_id, 'Эдик Заказы для групп', 'new', '09.06.2025', '11.06.2025', 3, 54, 0, 0, 0, 12480.0, 12480.0, true, '52 штуки 9,10,11 июня . гид Катя Ильина . 7:50 от центрального жд', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (732, client_id, 'Эдик Заказы для групп', 'new', '28.06.2025', '28.06.2025', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, '30 штук 28 июня 11:00 у отеля Шаляпин', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (731, client_id, 'Эдик Заказы для групп', 'new', '22.06.2025', '22.06.2025', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, '40 штук 22 июня в 10:00 отель Дион ул.Алексея Козина д.3', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (730, client_id, 'Эдик Заказы для групп', 'new', '21.06.2025', '21.06.2025', 1, 92, 0, 0, 0, 7200.0, 7200.0, true, '45 штук 21 июня в 9:00 от Казанского Цирка', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (729, client_id, 'Эдик Заказы для групп', 'new', '14.06.2025', '14.06.2025', 1, 22, 0, 0, 0, 1680.0, 1680.0, true, '21 штука 14 июня в 06:00 ул.Галиаскара Камала 18', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (728, client_id, 'Эдик Заказы для групп', 'new', '13.06.2025', '14.06.2025', 2, 36, 0, 0, 0, 5440.0, 5440.0, true, '34 штуки. 13 июня -09:00- встреча Деревня Универсиады КПП 14 - 14 июня в 9:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (727, client_id, 'Эдик Заказы для групп', 'new', '12.06.2025', '12.06.2025', 1, 52, 0, 0, 0, 4080.0, 4080.0, true, '51 штука . 12 июня 10:30 у глав.входа цирка. Нурия . Ваучер на Кремль', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (726, client_id, 'Эдик Заказы для групп', 'new', '03.06.2025', '03.06.2025', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, '3 июня нужно 43 штуки , в 9:00 ул.чернышевского 17. Гид Наталья Никифорова', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (725, client_id, 'Эдик Заказы для групп', 'new', '02.06.2025', '02.06.2025', 1, 70, 0, 0, 0, 5360.0, 5360.0, true, '67 штук в 10:00 . 2 гида . и 2 ваучера на кремль. Можно Диме передать вечером , он их будет отправлять', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (724, client_id, 'Екатерина', 'new', '30.05.2025', '30.05.2025', 1, 16, 0, 0, 0, 1200.0, 1200.0, true, 'Заберет из бусика', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александра (Александрия)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (723, client_id, 'Александра (Александрия)', 'new', '30.05.2025', '01.06.2025', 3, 35, 0, 0, 0, 7920.0, 7920.0, true, 'В Волгу Оставили в бусике', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (722, client_id, 'Эвелина (Инициатива)', 'new', '30.05.2025', '30.05.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'Вернет 31 в обед', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (721, client_id, 'Любовь (ТИЦ)', 'new', '31.05.2025', '31.05.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'В офис тиц Вернут вечером', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (720, client_id, 'Мария Экскурсовод', 'new', '30.05.2025', '31.05.2025', 2, 34, 0, 0, 0, 4960.0, 4960.0, true, 'Заберет в обед Завезет в кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (719, client_id, 'Карина (технологии путешествий)', 'new', '31.05.2025', '31.05.2025', 1, 60, 0, 0, 0, 4800.0, 4800.0, true, 'Две сумки по 30шт Привезти к новому театру Камала в 14:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (718, client_id, 'Ирина (Иль Мио Тур)', 'new', '30.05.2025', '30.05.2025', 1, 42, 0, 0, 0, 3280.0, 3280.0, true, 'В Регину на Петербургской Вернут в районе 20:30 в Регину', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Иванов Семён%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (716, client_id, 'Иванов Семён', 'new', '03.06.2025', '03.06.2025', 1, 20, 0, 0, 0, 1520.0, 1520.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (715, client_id, 'Анюта Родионова (Родина-тур)', 'new', '31.05.2025', '01.06.2025', 2, 26, 0, 0, 0, 3840.0, 3840.0, true, 'В Булак. Оставили в кристале', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Пронина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (714, client_id, 'Ирина Пронина', 'new', '31.05.2025', '31.05.2025', 1, 30, 0, 0, 0, 2320.0, 2320.0, true, 'Заберет 30.05. В 17:15', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лариса%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (713, client_id, 'Лариса', 'new', '28.05.2025', '28.05.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'Лейла. Оставят в кристале', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Рената (Твоя Казань)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (712, client_id, 'Рената (Твоя Казань)', 'new', '29.05.2025', '29.05.2025', 1, 29, 0, 0, 0, 2240.0, 2240.0, true, '29.05 до 16:00 в отель 13 на московской 13А', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (711, client_id, 'Арсен (Юнион)', 'new', '30.05.2025', '30.05.2025', 1, 18, 0, 0, 0, 1360.0, 1360.0, true, '23.30 Корстон оставят', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (710, client_id, 'Инна Экскурсовод', 'new', '13.06.2025', '14.06.2025', 2, 32, 0, 0, 0, 4800.0, 4800.0, true, 'Раймонд', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (709, client_id, 'Татьяна Чуб', 'new', '12.06.2025', '13.06.2025', 2, 42, 0, 0, 0, 6400.0, 6400.0, true, 'Утром в 8:30 заберет', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (708, client_id, 'Ляйсан (Казань 360)', 'new', '30.05.2025', '31.05.2025', 2, 57, 0, 0, 0, 8800.0, 8800.0, true, '+7 950 314-03-61 Ольга Оставит в кристалле', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (707, client_id, 'Ирина (Иль Мио Тур)', 'new', '27.05.2025', '27.05.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'Гранд отель Вернули туда же', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (706, client_id, 'Ирина (Иль Мио Тур)', 'new', '27.05.2025', '27.05.2025', 1, 34, 0, 0, 0, 2640.0, 2640.0, true, 'В Регину на университетской Вернули туда же', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Иванов Семён%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (705, client_id, 'Иванов Семён', 'new', '30.05.2025', '02.06.2025', 3, 36, 0, 0, 0, 8160.0, 8160.0, true, '30.05 В гостиницу Татарстан до 20:30, Оставит в бусике', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (704, client_id, 'Любовь (ТИЦ)', 'new', '28.05.2025', '28.05.2025', 1, 46, 0, 0, 0, 3600.0, 3600.0, true, '27 принести 29 забрать', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (703, client_id, 'Любовь (ТИЦ)', 'new', '31.05.2025', '01.06.2025', 2, 30, 0, 0, 0, 4480.0, 4480.0, true, '30 до 19:00 в мобильный трак Забрать можно 02.06 до 19:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (702, client_id, 'Альберт (КТ)', 'new', '26.05.2025', '27.05.2025', 2, 40, 0, 0, 0, 5320.0, 5320.0, true, 'Группа 38 чел+ гид Ирина т.+7 927 421-36-82 Нужны радиогиды *на завтра, на 26,27,мая* Завтра в 12:30 приезжают на ЖД центр, можно оставить в Кристалле. Забрать в Булаке', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (701, client_id, 'Татьяна (Гольфстрим)', 'new', '25.05.2025', '25.05.2025', 1, 37, 0, 0, 0, 2880.0, 2880.0, true, '25.05 надо 36 радиогидов завести в 9-10 на Каюма Насыри 1/5б 2 этаж музей Бик тэмле, бик матур. с ними будет работать гид Марина 89172526993', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (700, client_id, 'Эдик Заказы для групп', 'new', '26.05.2025', '26.05.2025', 1, 0, 0, 0, 0, 7680.0, 7680.0, true, '26 мая в 9:30 ул.Лядова 16 Шк.№112 96 штук. 2 группы', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (699, client_id, 'Эдик Заказы для групп', 'new', '25.05.2025', '25.05.2025', 1, 0, 0, 0, 0, 5200.0, 5200.0, true, '25 мая в 10:30 гост.Татарстан . 65 штук. 2 группы', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Валентина Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (698, client_id, 'Валентина Экскурсовод', 'new', '25.05.2025', '25.05.2025', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (697, client_id, 'Гульнара', 'new', '24.05.2025', '25.05.2025', 2, 47, 0, 0, 0, 7360.0, 7360.0, true, 'Заберет в 10:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Твой Гид%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (696, client_id, 'Твой Гид', 'new', '24.05.2025', '25.05.2025', 2, 26, 0, 0, 0, 3840.0, 3840.0, true, 'Сумка в Азалии', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (694, client_id, 'Татьяна (Гольфстрим)', 'new', '24.05.2025', '26.05.2025', 3, 38, 0, 0, 0, 8640.0, 8640.0, true, '24-26 мая гид Ольга 89503140361 36 человек 24- в Кристалл до 10.30 сдаст 26- в Кристалл после 17.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (693, client_id, 'Татьяна (Гольфстрим)', 'new', '29.05.2025', '30.05.2025', 2, 38, 0, 0, 0, 5760.0, 5760.0, true, 'гид Ирина Палей 89046620732 сдаст 30- в отеле Давыдов на Назарбаева после 19.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (692, client_id, 'Татьяна (Гольфстрим)', 'new', '25.05.2025', '25.05.2025', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, '24 в Кристалл к 15.00 привести радиогиды на 35 человек для Ирины Палей 89046620732 для работы на 25 мая,т.к. она уедет 25.05 в Йошкар-Олу с ними в 5.30 утра. сдаст 25 мая после 18.00 по созвону.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (691, client_id, 'Татьяна (Гольфстрим)', 'new', '24.05.2025', '25.05.2025', 2, 35, 0, 0, 0, 5280.0, 5280.0, true, '24-25 мая гид Владимир Николаевич 89178858409 заберет 24- в Кристалле в 7.30 на 33 человека.сдаст 25- на Баумана после 16.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (690, client_id, 'Любовь (ТИЦ)', 'new', '24.05.2025', '24.05.2025', 1, 16, 0, 0, 0, 1200.0, 1200.0, true, 'Офис тиц', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Рената (Твоя Казань)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (688, client_id, 'Рената (Твоя Казань)', 'new', '21.06.2025', '21.06.2025', 1, 25, 0, 0, 0, 1920.0, 1920.0, true, 'От отеля Мираж в 16:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Агентство Удачи)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (687, client_id, 'Татьяна (Агентство Удачи)', 'new', '19.06.2025', '19.06.2025', 1, 143, 0, 0, 0, 11200.0, 11200.0, true, 'Около 10 заберет утром Сумки на 48,48, 47 Вернет на следующий день к обеду', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (686, client_id, 'Любовь (ТИЦ)', 'new', '23.05.2025', '23.05.2025', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, 'Офис тиц Забрать утром 24', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (685, client_id, 'Любовь (ТИЦ)', 'new', '23.05.2025', '23.05.2025', 1, 70, 0, 0, 0, 5440.0, 5440.0, true, 'Две сумки по 34шт забрать утром 24', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (684, client_id, 'Андрей (Экскурс)', 'new', '04.06.2025', '04.06.2025', 1, 60, 0, 0, 0, 36000.0, 36000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (683, client_id, 'Любовь (ТИЦ)', 'new', '25.05.2025', '27.05.2025', 3, 53, 0, 0, 0, 12240.0, 12240.0, true, '24.05 в тиц офис до 17 Забрать можно 27.05 после 21:00 в кристалле +7 965 586-88-06 Гид Ванда', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Яна (Вариот)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (682, client_id, 'Яна (Вариот)', 'new', '24.05.2025', '24.05.2025', 1, 56, 0, 0, 0, 4400.0, 4400.0, true, '23 оставить вечером в Азимут Сдадут 24 в азимут в районе 18 Оставила в Космосе', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (681, client_id, 'Карина (технологии путешествий)', 'new', '22.05.2025', '22.05.2025', 1, 62, 0, 0, 0, 4800.0, 4800.0, true, 'оставить в Серфе на Подлужной и Сдала в бусик', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (680, client_id, 'Ольга', 'new', '28.05.2025', '28.05.2025', 1, 28, 0, 0, 0, 2160.0, 2160.0, true, 'Уточнить', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (678, client_id, 'Карина (технологии путешествий)', 'new', '22.05.2025', '22.05.2025', 1, 112, 0, 0, 0, 8800.0, 8800.0, true, 'Две сумки по 55, в Корстон к 12', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (677, client_id, 'Екатерина', 'new', '24.05.2025', '24.05.2025', 1, 14, 0, 0, 0, 1040.0, 1040.0, true, 'Заберет сама 23 вечером Вернула в бусик', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лариса Позднякова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (676, client_id, 'Лариса Позднякова', 'new', '20.05.2025', '21.05.2025', 2, 32, 0, 0, 0, 4800.0, 4800.0, true, 'Заказ Аудигид: 30шт на 20.05,21.05 гостиница Фатима Карла Маркса 2', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (675, client_id, 'Сергей (Авангард)', 'new', '17.05.2025', '18.05.2025', 2, 35, 0, 0, 0, 5280.0, 5280.0, true, 'Елена. +7 987 296‑95‑42. Сумка в кристале', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (674, client_id, 'Наталья', 'new', '23.05.2025', '23.05.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'Заберет в кристалле, Оставила в офисе', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (672, client_id, 'Любовь (ТИЦ)', 'new', '17.05.2025', '17.05.2025', 1, 52, 0, 0, 0, 4080.0, 4080.0, true, 'Закончат к 12', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (671, client_id, 'Альберт (КТ)', 'new', '17.05.2025', '17.05.2025', 1, 41, 0, 0, 0, 2800.0, 2800.0, true, 'Завезти в Булгар отель', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (670, client_id, 'Любовь (ТИЦ)', 'new', '17.05.2025', '17.05.2025', 1, 92, 0, 0, 0, 7200.0, 7200.0, true, 'Две сумки на 45 на один день', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (669, client_id, 'Любовь (ТИЦ)', 'new', '17.05.2025', '18.05.2025', 2, 94, 0, 0, 0, 14400.0, 14400.0, true, 'Две сумки по 45 на два дня', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (668, client_id, 'Андрей (Экскурс)', 'new', '15.06.2025', '16.06.2025', 2, 33, 0, 0, 0, 4960.0, 4960.0, true, '15 и 16 июня. На 31 человека. Забрать придется 14 июня, тк программа обслуживания начинается 15 июня в 05:00 утра.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (667, client_id, 'Сергей', 'new', '28.06.2025', '29.06.2025', 2, 37, 0, 0, 0, 5600.0, 5600.0, true, 'Уточнить', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (666, client_id, 'Любовь (ТИЦ)', 'new', '16.05.2025', '16.05.2025', 1, 25, 0, 0, 0, 1600.0, 1600.0, true, '5 переводчиков и 5 микрофонов', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (664, client_id, 'Галина (Тур Урал)', 'new', '27.05.2025', '28.05.2025', 2, 30, 0, 0, 0, 5600.0, 5600.0, true, '(Чайка Ю) Катя Кореева В дом чая к 15:30 Вернет в кристал', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузель (Юралс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (663, client_id, 'Гузель (Юралс)', 'new', '17.05.2025', '17.05.2025', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, 'Заберут 16 мая', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (662, client_id, 'Галина (Тур Урал)', 'new', '26.05.2025', '28.05.2025', 3, 31, 0, 0, 0, 8700.0, 8700.0, true, 'Воронеж Гид Екатерина Геннадьевна 89275662530 Оставила в Шаляпине', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия (Рыжий Слон)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (661, client_id, 'Юлия (Рыжий Слон)', 'new', '21.05.2025', '23.05.2025', 3, 38, 0, 0, 0, 8640.0, 8640.0, true, 'Кристал. Гид Элина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (660, client_id, 'Альберт (КТ)', 'new', '16.05.2025', '16.05.2025', 1, 31, 0, 0, 0, 2100.0, 2100.0, true, '16 мая, будет 30 человек + гид Владимир т. +7 917 885-84-09 Начало 16 мая в 8:00 от ЦЖД,(можно оставить в Кристалле) на 1 день, заканчивают в 17 ч в отеле 55 ( ул. Островского 55)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (659, client_id, 'Галина (Тур Урал)', 'new', '23.05.2025', '24.05.2025', 2, 33, 0, 0, 0, 6200.0, 6200.0, true, 'М- Поет-2 Экскурсовод Марина Николаевна +7 927 429-91-77 Вернет в 22 в Кристал', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (658, client_id, 'Наталья', 'new', '16.05.2025', '16.05.2025', 1, 25, 0, 0, 0, 1920.0, 1920.0, true, 'Заберут. Начало в 12:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (657, client_id, 'Арсен (Юнион)', 'new', '17.05.2025', '17.05.2025', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, 'В Сафар Заканчивают в 23:30 в Корстон', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (656, client_id, 'Эвелина (Инициатива)', 'new', '28.05.2025', '28.05.2025', 1, 48, 0, 0, 0, 3760.0, 3760.0, true, 'Сама заберет 29 утром занесет', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Москва%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (655, client_id, 'Наталья Москва', 'new', '24.05.2025', '25.05.2025', 2, 27, 0, 0, 0, 5000.0, 5000.0, true, 'На ресепшен отеля Максим Горький Вернула в Кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (654, client_id, 'Инна Экскурсовод', 'new', '17.05.2025', '17.05.2025', 1, 46, 0, 0, 0, 3600.0, 3600.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Сафина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (653, client_id, 'Алина Сафина', 'new', '12.05.2025', '12.05.2025', 1, 40, 0, 0, 0, 3120.0, 3120.0, true, 'Заберет в 8:20-8:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (652, client_id, 'Эдик Заказы для групп', 'new', '11.05.2025', '11.05.2025', 1, 37, 0, 0, 0, 2880.0, 2880.0, true, 'В стс. Чуб. Ваучер на кремль', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (651, client_id, 'Альберт (КТ)', 'new', '11.05.2025', '13.05.2025', 3, 50, 0, 0, 0, 10080.0, 10080.0, true, 'радиогиды на 11,12,13 мая, будет 48 человек + гид Ирина т. +7 927 421-36-82 Отель Булгар ( Ул Вишневского 21) Можно оставить накануне в отеле Кристалл, группа приезжает 11 мая в 7:50 утра на ЦЖД', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (650, client_id, 'Галия', 'new', '12.06.2025', '12.06.2025', 1, 39, 0, 0, 0, 3040.0, 3040.0, true, 'Заберет в 10:45', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Светлана (Лана-тур Казань)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (649, client_id, 'Светлана (Лана-тур Казань)', 'new', '13.05.2025', '15.05.2025', 3, 33, 0, 0, 0, 6880.0, 6880.0, true, 'Хилтон в обед', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина Рыжикова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (648, client_id, 'Галина Рыжикова', 'new', '09.05.2025', '09.05.2025', 1, 13, 0, 0, 0, 960.0, 960.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Вера (СК-Интур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (647, client_id, 'Вера (СК-Интур)', 'new', '01.05.2025', '04.05.2025', 4, 17, 0, 0, 0, 4800.0, 4800.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (646, client_id, 'Любовь (ТИЦ)', 'new', '15.05.2025', '15.05.2025', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, 'на 15 мая, 35 штук, прошу принести сумку 14 мая в первой половине дня, чтобы гид успел у нас её забрать. Сумку принесите в наш мобильный трак на петербургской. Забрать сумку можно будет 16 мая в течение дня до 19.00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (645, client_id, 'Эвелина (Инициатива)', 'new', '09.05.2025', '11.05.2025', 3, 30, 0, 0, 0, 4640.0, 4640.0, true, 'Группа №3(Екатеринбург) 29 человек, на 3 дня(09-11 мая) можно оставить в Кристалле до 11:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (644, client_id, 'Эвелина (Инициатива)', 'new', '08.05.2025', '10.05.2025', 3, 45, 0, 0, 0, 10560.0, 10560.0, true, 'Группа №2 (Ногинск) 44 человека,на 3 дня (08-10 мая) привезти накануне, т.к. встречают в 7 утра', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (643, client_id, 'Эвелина (Инициатива)', 'new', '08.05.2025', '09.05.2025', 2, 46, 0, 0, 0, 7200.0, 7200.0, true, 'Группа №1(Обнинск) 46 человек, на 2 дня (08-09 мая) привезти накануне в офис, т.к. встречают в 7 утра Вернули в кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (642, client_id, 'Зельфира', 'new', '08.05.2025', '08.05.2025', 1, 54, 0, 0, 0, 4240.0, 4240.0, true, 'Баскет холл, к 8', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (641, client_id, 'Эдик Заказы для групп', 'new', '30.05.2025', '31.05.2025', 2, 24, 0, 0, 0, 3520.0, 3520.0, true, '30,31 мая - 22 штуки. Гид Элина Гортэ. 30 мая в 10:50 от центрального жд', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (640, client_id, 'Эдик Заказы для групп', 'new', '29.05.2025', '01.06.2025', 4, 27, 0, 0, 0, 8000.0, 8000.0, true, '29,30,31 мая , 1 июня - 25 штук . Гид Наталья Никифорова . 29 мая в 10:50 от центрального жд. ваучер на Кремль и 220 600 рублей', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (639, client_id, 'Эдик Заказы для групп', 'new', '24.05.2025', '25.05.2025', 2, 32, 0, 0, 0, 4800.0, 4800.0, true, '24,25 мая - 30 штук . Гид Наталья Никифорова . 24 мая в 7:50 от центрального жд', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (638, client_id, 'Эдик Заказы для групп', 'new', '18.05.2025', '18.05.2025', 1, 53, 0, 0, 0, 4160.0, 4160.0, true, '18 мая- 52 штуки . гид Виктория Павлова . в 10:00 ул.Гвардейская 35', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (637, client_id, 'Эдик Заказы для групп', 'new', '17.05.2025', '17.05.2025', 1, 53, 0, 0, 0, 4160.0, 4160.0, true, '17 мая -52 штуки . 9:30 от центрального жд Гульнара 2 передатчика', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (634, client_id, 'Эдик Заказы для групп', 'new', '16.05.2025', '16.05.2025', 1, 28, 0, 0, 0, 2160.0, 2160.0, true, '16 мая -27 шт. гид Виктория Павлова в 8:30 от жд центрального Ваучер уремль', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (633, client_id, 'Эдик Заказы для групп', 'new', '16.05.2025', '19.05.2025', 4, 50, 0, 0, 0, 15360.0, 15360.0, true, '16,17,18,19 мая - 48 человек. гид Настя Семенова . 16 мая в 14:20 от жд Восстания', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (632, client_id, 'Эдик Заказы для групп', 'new', '16.05.2025', '17.05.2025', 2, 22, 0, 0, 0, 3200.0, 3200.0, true, '16,17 мая - 20 штук . гид Наталья Никифорова 16 мая в 8:00от центрального жд Ваучер Кремль и суияжск', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (630, client_id, 'Эдик Заказы для групп', 'new', '12.05.2025', '15.05.2025', 4, 32, 0, 0, 0, 9600.0, 9600.0, true, '12,13,14,15 мая- 30 штук . Гид Катя Ильина 12 мая в 14:20 на жд Восстания начало. Положить ваучеры Кремль, свияжск, болгар', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (629, client_id, 'Эдик Заказы для групп', 'new', '11.05.2025', '11.05.2025', 1, 48, 0, 0, 0, 3760.0, 3760.0, true, '11 мая - 47 шт. гид Лариса Семенова в 9:30 от кремля', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (628, client_id, 'Эдик Заказы для групп', 'new', '07.05.2025', '07.05.2025', 1, 60, 0, 0, 0, 4720.0, 4720.0, true, '7 мая -59 штук . Гид Резеда . в 9:00 Деревня Универсиады КПП 14', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (627, client_id, 'Эдик Заказы для групп', 'new', '06.05.2025', '07.05.2025', 2, 70, 0, 0, 0, 10400.0, 10400.0, true, '6 мая - 65 штук ( 2 группы) в 10:00 ул.Одностороняя Гривка д.1 7 мая они же поедут в свияжск , тоже в 10:00 Сумка на 20 и сумка на 50', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (626, client_id, 'Ирина (Иль Мио Тур)', 'new', '09.05.2025', '09.05.2025', 1, 38, 0, 0, 0, 2960.0, 2960.0, true, 'Кафе Хоррият до 11:00( петерьургая 57) Вернут после 20:00 в Татарстан', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Оксана%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (625, client_id, 'Оксана', 'new', '08.05.2025', '09.05.2025', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, 'Амансафар. Вернут в корстон', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (624, client_id, 'Любовь (ТИЦ)', 'new', '05.05.2025', '06.05.2025', 2, 46, 0, 0, 0, 7040.0, 7040.0, true, 'Гид Диана +7 927 445-45-25 05 в тиц до 15 Вернут в тиц 06 с 18:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (623, client_id, 'Татьяна (Гольфстрим)', 'new', '09.05.2025', '10.05.2025', 2, 27, 0, 0, 0, 4000.0, 4000.0, true, '9.05 гид Виктория 89196236810 25шт. 9.30 отель Давыдов на Павлюхина , сдаст 10.05 после 21.30 по созвону. ВЕРНУЛА В КРИСТАЛ', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (622, client_id, 'Татьяна (Гольфстрим)', 'new', '09.05.2025', '10.05.2025', 2, 46, 0, 0, 0, 7040.0, 7040.0, true, '9.05 гид Марина 89172526993 44 шт. в 9.30 отель Аматти сдаст 10.05 после 21.30 по созвону', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (621, client_id, 'Татьяна (Гольфстрим)', 'new', '08.05.2025', '09.05.2025', 2, 46, 0, 0, 0, 7040.0, 7040.0, true, '8.05 гид Владимир 89178858409 44 шт. в 9.00 Алан аш на Бутлерова 43 сдаст 9.05 после 16 по созвону', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (620, client_id, 'Татьяна (Гольфстрим)', 'new', '05.05.2025', '06.05.2025', 2, 29, 0, 0, 0, 4320.0, 4320.0, true, '5.05 гид Владимир 89178858409 27шт. в 8.00 кафе Овсянки сдаст 6.05 после 19.00 по созвону.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (619, client_id, 'Мария Экскурсовод', 'new', '03.05.2025', '03.05.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (618, client_id, 'Арсен (Юнион)', 'new', '10.05.2025', '10.05.2025', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, '10 мая с 08.00 до 23.30 от Сафара в Релиту', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (617, client_id, 'Арсен (Юнион)', 'new', '09.05.2025', '09.05.2025', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, 'с 08.00 до 23.30 от Сафара в Сулейман', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Диляра%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (615, client_id, 'Диляра', 'new', '03.05.2025', '03.05.2025', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'Утром Принесет на вечерку', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (614, client_id, 'Татьяна (Гольфстрим)', 'new', '03.05.2025', '04.05.2025', 2, 34, 0, 0, 0, 5280.0, 5280.0, true, '3.05 гид Владимир 89178858409 33 шт. в Кристалл к 7.30 сдаст 4.05 после 13. по созвону на Баумана', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (613, client_id, 'Татьяна (Гольфстрим)', 'new', '02.05.2025', '04.05.2025', 3, 36, 0, 0, 0, 8400.0, 8400.0, true, '2.05 гид Диана 89274454525 35 штук отель Кристалл к 7.30 сдадут 4.05 после 13.30 в кристалл', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (612, client_id, 'Альберт (КТ)', 'new', '01.05.2025', '02.05.2025', 2, 38, 0, 0, 0, 7770.0, 7770.0, true, '1 группа* На *1 и 2 мая* 37 человек + гид Владимир т.+7 917 885-84-09 отель Булгар ( ул Вишневского 21) 2 группа * На *2 мая* 37 человек + гид Ирина т. +7 927 421-36-82 Отель Биляр Палас ( ул Островского 61) Нужно положить два комплекта наушников. Оставили в биляр!!', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (611, client_id, 'Любовь (ТИЦ)', 'new', '02.05.2025', '04.05.2025', 3, 40, 0, 0, 0, 9120.0, 9120.0, true, '01.05 занести в офис Тиц', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (610, client_id, 'Галина (Тур Урал)', 'new', '08.05.2025', '10.05.2025', 3, 42, 0, 0, 0, 12300.0, 12300.0, true, 'Тула завезти ВЕРНУЛИ В КРИСТАЛЛ', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (609, client_id, 'Галина (Тур Урал)', 'new', '08.05.2025', '10.05.2025', 3, 44, 0, 0, 0, 12900.0, 12900.0, true, 'ЕКБ-2 завезти ВЕРНУЛИ В КРИСТАЛ', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (608, client_id, 'Любовь (ТИЦ)', 'new', '01.05.2025', '03.05.2025', 3, 32, 0, 0, 0, 7200.0, 7200.0, true, '30.04 занести в офис Тиц на Баумана Вернут 03.05 в офис Тиц вечером', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (607, client_id, 'Арсен (Юнион)', 'new', '03.05.2025', '03.05.2025', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, 'Оставить в Сафаре Забрать в Сулейман утром 04.05', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (606, client_id, 'Арсен (Юнион)', 'new', '03.05.2025', '03.05.2025', 1, 37, 0, 0, 0, 2880.0, 2880.0, true, 'Оставить в Сулейман до 08:30 и забрать в Сулейман Утром', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (605, client_id, 'Арсен (Юнион)', 'new', '02.05.2025', '02.05.2025', 1, 27, 0, 0, 0, 2080.0, 2080.0, true, 'Оставить в Амакс Оставят в Релите в 23:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (604, client_id, 'Ляйсан (Казань 360)', 'new', '30.04.2025', '01.05.2025', 2, 29, 0, 0, 0, 4320.0, 4320.0, true, 'Крисстал вернет гид Анна +7 987 290-73-09 Они в 18:00 заканчивают в Рамаде', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (602, client_id, 'Ирина (Иль Мио Тур)', 'new', '03.05.2025', '03.05.2025', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, 'Татарстан Алевтина Александровна 89033881755 Вернут туда же после 18:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (601, client_id, 'Галина (Тур Урал)', 'new', '03.05.2025', '04.05.2025', 2, 65, 0, 0, 0, 12200.0, 12200.0, true, 'Уточнить 63 гида Оставили в крисстал', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (600, client_id, 'Галина (Тур Урал)', 'new', '02.05.2025', '03.05.2025', 2, 37, 0, 0, 0, 7000.0, 7000.0, true, 'Завезу по пути в кристал Оставили в кристал', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (599, client_id, 'Эвелина (Инициатива)', 'new', '01.05.2025', '03.05.2025', 3, 47, 0, 0, 0, 10800.0, 10800.0, true, 'Завезти в офис инициативы Вернут в кристал в 22:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (598, client_id, 'Эвелина (Инициатива)', 'new', '01.05.2025', '01.05.2025', 1, 34, 0, 0, 0, 2640.0, 2640.0, true, 'Завезти в офис инициативы Вернут в Амстердам в 23:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (597, client_id, 'Галина (Тур Урал)', 'new', '01.05.2025', '03.05.2025', 3, 20, 0, 0, 0, 5400.0, 5400.0, true, 'Сами заберут Оставят в кристалле в 22:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (596, client_id, 'Галина (Тур Урал)', 'new', '01.05.2025', '02.05.2025', 2, 33, 0, 0, 0, 6200.0, 6200.0, true, 'Сами заберут', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (595, client_id, 'Галина (Тур Урал)', 'new', '01.05.2025', '03.05.2025', 3, 35, 0, 0, 0, 9900.0, 9900.0, true, 'Сами заберут', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (594, client_id, 'Алексей', 'new', '13.05.2025', '14.05.2025', 2, 54, 0, 0, 0, 8160.0, 8160.0, true, 'Заберут и оставят в Кристалле', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (593, client_id, 'Альберт (КТ)', 'new', '29.04.2025', '29.04.2025', 1, 66, 0, 0, 0, 4480.0, 4480.0, true, '29.04 1 группа 32 человека + гид Лариса тел. +7 927 240-82-50 2 группа 32 человека + гид Ольга тел. +7 927 401-81-84 Экскурсия будет от Амакс Сафар с 15 до 18 ч и заканчивается в Амакс', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (592, client_id, 'Ольга (Дольче Вита)', 'new', '02.05.2025', '02.05.2025', 1, 47, 0, 0, 0, 3680.0, 3680.0, true, 'На 02.05 в Крисстал, группа 46+1 запас+1 гид Сопровождающая Мария +7 901 282-25-77 Гид Алексей Вернут в фургончик в 15:30', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (591, client_id, 'Ольга (Дольче Вита)', 'new', '01.05.2025', '03.05.2025', 3, 48, 0, 0, 0, 11040.0, 11040.0, true, 'Кристалл Вернут в кристалл в районе 19', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елизавета Ткач%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (589, client_id, 'Елизавета Ткач', 'new', '05.05.2025', '06.05.2025', 2, 40, 0, 0, 0, 6080.0, 6080.0, true, 'Утром заберет', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (588, client_id, 'Анюта Родионова (Родина-тур)', 'new', '03.05.2025', '03.05.2025', 1, 42, 0, 0, 0, 3280.0, 3280.0, true, 'Заберут Вечером вернет', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (587, client_id, 'Татьяна (Гольфстрим)', 'new', '30.04.2025', '30.04.2025', 1, 29, 0, 0, 0, 2240.0, 2240.0, true, '. на 30.04. в Карат к 9.30 гид Диана 89274454525 сдаст 30.04 после 17.30 по созвону.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (586, client_id, 'Татьяна (Гольфстрим)', 'new', '29.04.2025', '30.04.2025', 2, 30, 0, 0, 0, 4480.0, 4480.0, true, 'на 29 апреля 28 чел. гид Ирина Палей 89046620732 Биляр к 9.30 сдадут 30.04 после 19 в Кристалл', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (585, client_id, 'Татьяна (Гольфстрим)', 'new', '28.04.2025', '29.04.2025', 2, 36, 0, 0, 0, 5600.0, 5600.0, true, '35 шт гид Гульнара 89600389286в Сулейман к 8.30 сдаст гид Ванда 89655868806 29 апреля по созвону после 17.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (584, client_id, 'Татьяна (Гольфстрим)', 'new', '28.04.2025', '28.04.2025', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, '32 шт. гид Зифа 89053162643 в Давыдов на Павлюхина , сдадут в этот же день после 19.00 в Давыдов', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (583, client_id, 'Татьяна (Гольфстрим)', 'new', '28.04.2025', '30.04.2025', 3, 38, 0, 0, 0, 8640.0, 8640.0, true, '36 шт. гид Марина 89172526993 в Кристалл в 10.30 отдадут 30.04 по созвону после 20.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (582, client_id, 'Эдик Заказы для групп', 'new', '28.04.2025', '28.04.2025', 1, 30, 0, 0, 0, 2320.0, 2320.0, true, 'на завтра 29 штук , поедет в иннополис в 11:30 Копылова д.11. С ними будет айдар садыков Он едет на вечерку ему надо отдать сумку и два передатчика', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Светлана Зеленина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (581, client_id, 'Светлана Зеленина', 'new', '08.05.2025', '08.05.2025', 1, 25, 0, 0, 0, 1920.0, 1920.0, true, 'Заберут сами рано утром', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айрат Нурмухаммадов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (580, client_id, 'Айрат Нурмухаммадов', 'new', '27.04.2025', '27.04.2025', 1, 38, 0, 0, 0, 2590.0, 2590.0, true, 'Заберет в 12:45', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (579, client_id, 'Гульнара', 'new', '26.04.2025', '26.04.2025', 1, 25, 0, 0, 0, 1920.0, 1920.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (578, client_id, 'Альберт (КТ)', 'new', '26.04.2025', '27.04.2025', 2, 42, 0, 0, 0, 5600.0, 5600.0, true, 'Заявка на завтра 26 и 27 апреля Группа 40 человек + гид Ирина тел. +7 927 421-36-82 Завтра приезжают на ЖД в 12 часов дня, можно оставить в отеле Кристалл. Сумка в отели Гвардейский', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Валентина Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (577, client_id, 'Валентина Экскурсовод', 'new', '01.05.2025', '01.05.2025', 1, 50, 0, 0, 0, 3920.0, 3920.0, true, 'Заберет в 8:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (576, client_id, 'Татьяна Чуб', 'new', '29.04.2025', '29.04.2025', 1, 43, 0, 0, 0, 3360.0, 3360.0, true, '29 апреля Регина на Петербургской 42 шт для Татьяны', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (575, client_id, 'Татьяна Чуб', 'new', '28.04.2025', '28.04.2025', 1, 75, 0, 0, 0, 5840.0, 5840.0, true, '28 го Региеа на Петербургской 73/2 для Айгуль и Александра. На 36 и 37.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (574, client_id, 'Татьяна Чуб', 'new', '28.04.2025', '28.04.2025', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, '28 го в Регину на Петербург для Ольги 35 штук', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (573, client_id, 'Татьяна Чуб', 'new', '26.04.2025', '26.04.2025', 1, 156, 0, 0, 0, 12000.0, 12000.0, true, '26 го в кристалле на имя Айгуль 44 шт На имя Эльвира 35 человек На имя Лиза 37 человек На имя Влада 36 Вернут в Регину после 16:00 на петербуржскую', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (572, client_id, 'Татьяна (Гольфстрим)', 'new', '24.04.2025', '24.04.2025', 1, 50, 0, 0, 0, 3680.0, 3680.0, true, 'Оставят в Волге,', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (571, client_id, 'Анна', 'new', '03.05.2025', '03.05.2025', 1, 132, 0, 0, 0, 10320.0, 10320.0, true, 'Заберут с Баумана в 16:30 Вернут в 20:30 в Регину на Баумана', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (570, client_id, 'Эдик Заказы для групп', 'new', '28.04.2025', '28.04.2025', 1, 20, 0, 0, 0, 1520.0, 1520.0, true, '28 апреля - 19 шт. Гид Гульнара. в 12:00 отель М.Горький Вернет туда же после 18', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (569, client_id, 'Эдик Заказы для групп', 'new', '26.04.2025', '27.04.2025', 2, 24, 0, 0, 0, 3680.0, 3680.0, true, '26,27 апреля - 23 шт . Гид Наталья Никифорова 26 апреля в 8:00 от центрального жд. Надо вечеро дать сумку, ваучер( обзорка, свияжск) деньги', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Константин%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (568, client_id, 'Константин', 'new', '24.04.2025', '24.04.2025', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (567, client_id, 'Эдик Заказы для групп', 'new', '23.04.2025', '23.04.2025', 1, 24, 0, 0, 0, 1840.0, 1840.0, true, 'Ольга ткач. Кристал. Вернет сама завтра к свияжску', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия (Рыжий Слон)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (566, client_id, 'Юлия (Рыжий Слон)', 'new', '04.05.2025', '06.05.2025', 3, 87, 0, 0, 0, 19920.0, 19920.0, true, 'Кристал. Информация будет в 19:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (565, client_id, 'Татьяна Чуб', 'new', '02.05.2025', '03.05.2025', 2, 75, 0, 0, 0, 11680.0, 11680.0, true, '2 мая 73/2 в кристалле Для Людмилы и Татьяны Вернули в Релиту', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (563, client_id, 'Татьяна Чуб', 'new', '25.04.2025', '28.04.2025', 4, 43, 0, 0, 0, 9840.0, 9840.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена Тамбова (Апрель)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (562, client_id, 'Елена Тамбова (Апрель)', 'new', '26.04.2025', '27.04.2025', 2, 64, 0, 0, 0, 4960.0, 4960.0, true, 'Она в Кристалле оборудование на 62 чел возьмёт,а отдаст в Татарской слободе на Марджани в 12.00 группа там будет. Самгина Ольг +7 953 717‑05‑28. Привезет Ильдар 051', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия Шадрина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (561, client_id, 'Анастасия Шадрина', 'new', '24.04.2025', '24.04.2025', 1, 77, 0, 0, 0, 6000.0, 6000.0, true, 'Одна сумка один передатчик. Марафон. Доставка', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (560, client_id, 'Мира (ИП)', 'new', '09.05.2025', '09.05.2025', 1, 77, 0, 0, 0, 5250.0, 5250.0, true, 'Уточнить в переписке', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (559, client_id, 'Мира (ИП)', 'new', '07.05.2025', '07.05.2025', 1, 56, 0, 0, 0, 3850.0, 3850.0, true, 'Уточнить в переписке Наталья Релита', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (557, client_id, 'Гульнара', 'new', '26.04.2025', '27.04.2025', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, 'Заберут утром', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (556, client_id, 'Екатерина', 'new', '24.04.2025', '24.04.2025', 1, 17, 0, 0, 0, 1280.0, 1280.0, true, 'Добрый день! На 24.04 ГРАНД ОТЕЛЬ КАЗАНЬ Нужны аудиогиды) 16 для группы+ запосной+ для гида', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эльвира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (555, client_id, 'Эльвира', 'new', '23.04.2025', '23.04.2025', 1, 21, 0, 0, 0, 1520.0, 1520.0, true, 'Забрать 23. У Кремля в 12:15', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (554, client_id, 'Эдик Заказы для групп', 'new', '21.04.2025', '21.04.2025', 2, 29, 0, 0, 0, 6720.0, 6720.0, true, 'Завтра в 12:00 от шаляпина гид Наталья Никифорова . Нужно 28 радиогидов.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (553, client_id, 'Эдик Заказы для групп', 'new', '19.04.2025', '20.04.2025', 2, 25, 0, 0, 0, 3680.0, 3680.0, true, 'Кристалл, Наталия', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (551, client_id, 'Татьяна (Гольфстрим)', 'new', '18.04.2025', '20.04.2025', 3, 47, 0, 0, 0, 10800.0, 10800.0, true, 'На 18-20 апреля нужно 45 шт. радиогидов в Кристалл к 7.00 .Вернут туда же после 20 часов Гид Владимир Николаевич 89178858409', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (550, client_id, 'Татьяна (Гольфстрим)', 'new', '17.04.2025', '18.04.2025', 2, 41, 0, 0, 0, 6240.0, 6240.0, true, '17 апреля надо 39 штук на 2 дня радио гидов в Хостел (Петербургская, 40Б) к 14.30 для гида Шуравиной Ольги89503140361 вернут 18.04 по созвону после 17 часов.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (548, client_id, 'Эдик Заказы для групп', 'new', '16.04.2025', '16.04.2025', 1, 58, 0, 0, 0, 4560.0, 4560.0, true, 'Гузель. Она едет сегодня на вечерку. Ей сумку дать и ваучер на Кремль', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (547, client_id, 'Мира (ИП)', 'new', '10.05.2025', '11.05.2025', 2, 45, 0, 0, 0, 3010.0, 3010.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (546, client_id, 'Татьяна (Гольфстрим)', 'new', '14.04.2025', '14.04.2025', 1, 21, 0, 0, 0, 1600.0, 1600.0, true, 'В отель Карат Гид+7 950 949-04-94 Беркут хан ( Радик) сдаст по созвону вечером', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Антон%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (544, client_id, 'Антон', 'new', '03.06.2025', '05.06.2025', 2, 68, 0, 0, 0, 9760.0, 9760.0, true, '3. В 12:00 у Кремля Даты: 3 июНя с 11 до 18 5 июНя с 9 до 20', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (543, client_id, 'Эдик Заказы для групп', 'new', '13.04.2025', '13.04.2025', 1, 27, 0, 0, 0, 2080.0, 2080.0, true, '26 радиогидов в иннополис в 9:00 от Отель Raymond ул.Большая Красная д.50 . С ними гид гузель будет. 2 передатчика Вернула в офис', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (542, client_id, 'Мира (ИП)', 'new', '13.04.2025', '13.04.2025', 1, 56, 0, 0, 0, 3850.0, 3850.0, true, 'Релита. Сумка в Шаляпин', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (541, client_id, 'Эдик Заказы для групп', 'new', '12.04.2025', '12.04.2025', 1, 55, 0, 0, 0, 4320.0, 4320.0, true, '54 чел. От жд центрального. Гид. +7 927 419-65-79 резеда', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (540, client_id, 'Юлианна', 'new', '01.05.2025', '02.05.2025', 2, 45, 0, 0, 0, 6020.0, 6020.0, true, 'Оставила в Волге', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (539, client_id, 'Эдик Заказы для групп', 'new', '11.04.2025', '12.04.2025', 2, 43, 0, 0, 0, 6560.0, 6560.0, true, '. Нужны радиогиды 41 шт. 11 - 12 апреля . гид Настя Семенова 11 апреля в 6:00 на жд Восстания', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (537, client_id, 'Элина (Сититур)', 'new', '13.04.2025', '13.04.2025', 1, 25, 0, 0, 0, 1920.0, 1920.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга Лукоянова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (536, client_id, 'Ольга Лукоянова', 'new', '02.05.2025', '03.05.2025', 2, 20, 0, 0, 0, 3040.0, 3040.0, true, '+79297259743 Утром сама заберет В кристалле', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (533, client_id, 'Юлия Воронова', 'new', '12.04.2025', '12.04.2025', 1, 102, 0, 0, 0, 8000.0, 8000.0, true, 'На субботу 12 апреля нужно 100 примерно радиогидов и 2 передатчика. Поможете?', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (532, client_id, 'Татьяна (Гольфстрим)', 'new', '13.04.2025', '13.04.2025', 1, 21, 0, 0, 0, 1600.0, 1600.0, true, '13.04 гид Палей Ирина 89046620732 20 чел. Сулейман к 11.30 сдаст в 20.30 в Кристалл ГИДА НЕ ПРЕДУПРЕДИЛИ! СУМКА ОСТАЛАСЬ В СУЛЕЙМАН!', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (531, client_id, 'Татьяна (Гольфстрим)', 'new', '11.04.2025', '11.04.2025', 1, 30, 0, 0, 0, 2240.0, 2240.0, true, '10.04 гид Дания 89172904415 28чел. в обед позвонит на Баумана. чтобы использовать 11.04. сдаст 11.04 поздно или по звонку потом', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Виолетта%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (530, client_id, 'Виолетта', 'new', '09.04.2025', '10.04.2025', 2, 28, 0, 0, 0, 4160.0, 4160.0, true, 'Полносью мой, сдадут в кристалл 10.04 в 20:00. Гольфстрим', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (529, client_id, 'Альберт (КТ)', 'new', '09.04.2025', '10.04.2025', 2, 42, 0, 0, 0, 5600.0, 5600.0, true, '9 и 10 апреля на группу 40 человек + гид Ирина Софронова тел.+7 917 293-48-70 Отель Ногай', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (528, client_id, 'Альберт (КТ)', 'new', '08.04.2025', '09.04.2025', 2, 44, 0, 0, 0, 5880.0, 5880.0, true, '8 и 9 апреля на группу 42 человека + гид Владимир тел.+7 917 885-84-09 Отель Татарская усадьба ( Марджани 8). Сдал в офис', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (527, client_id, 'Альберт (КТ)', 'new', '08.04.2025', '09.04.2025', 2, 29, 0, 0, 0, 3780.0, 3780.0, true, '8 и 9 апреля на группу 27 человек + гид Ирина Баталова тел.+7 927 421-36-82 Отель кристал 09.04 в 20:00 сумки в кристалле не было Сумку оставили в IT park', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (526, client_id, 'Татьяна (Гольфстрим)', 'new', '08.04.2025', '10.04.2025', 3, 47, 0, 0, 0, 10800.0, 10800.0, true, '8 апреля 45 чел.гид Аида 89033440899 в 7 утра уезжает в Йошкар-Олу для встречи группы там на вокзале. ( наверное опять доставка)…. Сдадут 10 апреля в Кристалл в 19.15', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (525, client_id, 'Татьяна (Гольфстрим)', 'new', '07.04.2025', '09.04.2025', 3, 39, 0, 0, 0, 8880.0, 8880.0, true, '7 апреля 37чел.гид Светлана. +79172969340 прибывают в 5 утра на Восстание сдадут 9 апреля в Кристалл после 17', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (524, client_id, 'Мира (ИП)', 'new', '06.04.2025', '06.04.2025', 1, 44, 0, 0, 0, 2870.0, 2870.0, true, 'Лилия 13 Наталья 14 Роман 14 В Кремль в 10:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (523, client_id, 'Гульнара', 'new', '06.04.2025', '06.04.2025', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, 'Заберут в 8:45. Забрать в кристале', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (522, client_id, 'Эдик Заказы для групп', 'new', '06.04.2025', '08.04.2025', 3, 30, 0, 0, 0, 6720.0, 6720.0, true, 'Нужно радио гиды 28 штук . 6-8 апреля. С группой гид Элина Гортэ . 6 апреля в 7:50 встреча на центральном жд 09.04 в 20:00 сумки в кристалле нет', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (521, client_id, 'Татьяна (Гольфстрим)', 'new', '06.04.2025', '07.04.2025', 2, 27, 0, 0, 0, 4000.0, 4000.0, true, '6 апреля гид Гульназ 89393902610 25шт.Прибытие, Казань-2 (Восстание-Пасс.) в 05:25 возвращение так же 7 апреля на Восстание в 19. Попробует оставить в гостинице Карат', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (520, client_id, 'Зельфира', 'new', '08.04.2025', '08.04.2025', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, '7 оставить в Татарстан 8 оставит в кристалле', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (519, client_id, 'Гульнара', 'new', '04.04.2025', '04.04.2025', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (518, client_id, 'Татьяна (Гольфстрим)', 'new', '05.04.2025', '07.04.2025', 3, 45, 0, 0, 0, 10320.0, 10320.0, true, '5 апреля 43 чел. гид Нелли Рифовна 89063237048 отель кристалл в 7.30 сдадут 7 апреля Кристалл после 17.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (517, client_id, 'Татьяна (Гольфстрим)', 'new', '05.04.2025', '06.04.2025', 2, 40, 0, 0, 0, 6080.0, 6080.0, true, '5 апреля Гид Ольга 89503140361 Кристалл в 7.00! 38 чел. сдадут в Кисталл 6 апреля после 17.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (516, client_id, 'Татьяна (Гольфстрим)', 'new', '05.04.2025', '06.04.2025', 2, 30, 0, 0, 0, 4480.0, 4480.0, true, '5 апреля 28 чел. Отель Берисон Камала 3* в 9.30 Гид Диляра Рафаровна 89179275489 сдадут 6 апреля отель Кристалл после 15.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (515, client_id, 'Татьяна (Гольфстрим)', 'new', '04.04.2025', '05.04.2025', 2, 41, 0, 0, 0, 6240.0, 6240.0, true, '4 апреля гид Ирина Палей 89046620732 39 чел. (созвон, прибытие Восстание в 5 утра) сдадут (созвон 5 апреля возвращение в Казань в 19 на Восстание) Завтрак в Овсянке Оставит в отеле Крисстал, 07.04 в 12:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (514, client_id, 'Сергей (Авангард)', 'new', '06.04.2025', '08.04.2025', 3, 44, 0, 0, 0, 10080.0, 10080.0, true, 'Елена Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (513, client_id, 'Юлия Воронова', 'new', '03.04.2025', '04.04.2025', 2, 27, 0, 0, 0, 4000.0, 4000.0, true, 'Заберет в 8:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (512, client_id, 'Мария Экскурсовод', 'new', '02.04.2025', '02.04.2025', 1, 24, 0, 0, 0, 1840.0, 1840.0, true, 'У замка сладостей в 8:45. В кристалле', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (509, client_id, 'Элина (Сититур)', 'new', '02.04.2025', '02.04.2025', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, 'Заберет 1 апреля в 14:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Обыденникова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (508, client_id, 'Ирина Обыденникова', 'new', '09.05.2025', '10.05.2025', 2, 41, 0, 0, 0, 6400.0, 6400.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (507, client_id, 'Мира (ИП)', 'new', '08.04.2025', '09.04.2025', 2, 29, 0, 0, 0, 3780.0, 3780.0, true, 'Кристал В 20:00, 09.04 сумки в кристалле не было. Вернули в Шаляпин', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (506, client_id, 'Мира (ИП)', 'new', '02.04.2025', '04.04.2025', 3, 21, 0, 0, 0, 4200.0, 4200.0, true, 'Оставить в Кристале. Забрать в Доме Муллина в СТС', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (505, client_id, 'Андрей (Экскурс)', 'new', '29.04.2025', '30.04.2025', 2, 31, 0, 0, 0, 4800.0, 4800.0, true, 'Рамада', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (504, client_id, 'Мария Экскурсовод', 'new', '01.04.2025', '01.04.2025', 1, 34, 0, 0, 0, 2560.0, 2560.0, true, '8:30 у часов Вернут в Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (503, client_id, 'Анастасия', 'new', '01.04.2025', '03.04.2025', 3, 38, 0, 0, 0, 8400.0, 8400.0, true, 'Карат', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (502, client_id, 'Галия', 'new', '27.03.2025', '27.03.2025', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, 'В обед заберут. 14:00 у Свито Холла', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (501, client_id, 'Мария Экскурсовод', 'new', '26.04.2025', '28.04.2025', 3, 50, 0, 0, 0, 11280.0, 11280.0, true, 'Берисон худикова', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (500, client_id, 'Альберт (КТ)', 'new', '26.03.2025', '27.03.2025', 2, 34, 0, 0, 0, 4480.0, 4480.0, true, 'Кристал Лариса', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (499, client_id, 'Эдик Заказы для групп', 'new', '26.03.2025', '26.03.2025', 1, 52, 0, 0, 0, 4080.0, 4080.0, true, 'Кристал Гузель', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (498, client_id, 'Эдик Заказы для групп', 'new', '25.03.2025', '25.03.2025', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, 'завтра 15:30 Гостиница Колибри ул.К.Фукса', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (497, client_id, 'Эдик Заказы для групп', 'new', '29.03.2025', '30.03.2025', 2, 23, 0, 0, 0, 3360.0, 3360.0, true, 'Настя Семенова Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (496, client_id, 'Эдик Заказы для групп', 'new', '26.03.2025', '29.03.2025', 4, 41, 0, 0, 0, 12480.0, 12480.0, true, 'Ольга ткач 2 передатчика. 14:55 восстание', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (495, client_id, 'Наталья', 'new', '01.05.2025', '01.05.2025', 1, 48, 0, 0, 0, 3760.0, 3760.0, true, 'Крисстал Заканчивает в 19:00 в Давыдов назарбаева', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (494, client_id, 'Наталья', 'new', '23.03.2025', '24.03.2025', 2, 28, 0, 0, 0, 4160.0, 4160.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (493, client_id, 'Альберт (КТ)', 'new', '23.03.2025', '23.03.2025', 1, 31, 0, 0, 0, 2100.0, 2100.0, true, 'Кристал Лариса', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (492, client_id, 'Эдик Заказы для групп', 'new', '20.03.2025', '20.03.2025', 1, 55, 0, 0, 0, 4240.0, 4240.0, true, 'Катя Ильина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (491, client_id, 'Татьяна (Гольфстрим)', 'new', '23.03.2025', '23.03.2025', 1, 25, 0, 0, 0, 1920.0, 1920.0, true, '23 марта 24шт.гид Лилия 89872975449 отель Кристалл в 12.00 отдадут после 19 в отель Волга', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия (Рыжий Слон)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (490, client_id, 'Юлия (Рыжий Слон)', 'new', '23.03.2025', '25.03.2025', 3, 49, 0, 0, 0, 11280.0, 11280.0, true, 'Кристал Диляра', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (489, client_id, 'Татьяна (Гольфстрим)', 'new', '27.03.2025', '29.03.2025', 3, 40, 0, 0, 0, 9120.0, 9120.0, true, 'Доставить экскурсоводу вечером Яндекс доставкой на Фучика. Аида. +7 903 344-08-99 Напомню адрес. Фучика 58 б кв 49 чтоб не было ошибк Оставит в Мано в районе 17 часов', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (488, client_id, 'Татьяна (Гольфстрим)', 'new', '26.03.2025', '28.03.2025', 3, 47, 0, 0, 0, 10800.0, 10800.0, true, '26 марта 45 шт отель Кристалл к 11.30 гид Аида89033440899. сдадут 28 в Мано', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (487, client_id, 'Татьяна (Гольфстрим)', 'new', '26.03.2025', '28.03.2025', 3, 53, 0, 0, 0, 12240.0, 12240.0, true, '26-28 марта- 51 шт.гид Светлана 89172969340 отель Регата 8.30 вернут 28 марта из Иннополиса возвращаются на ж.д.Восстание в 19.00 Решите, пожалуйста с гидом как лучше. Сдали в Татарстан!', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (486, client_id, 'Татьяна (Гольфстрим)', 'new', '26.03.2025', '27.03.2025', 2, 43, 0, 0, 0, 6560.0, 6560.0, true, '26-27 гид Виктория 89196236810 41шт. отель Берисон на Худякова 9.30 Вернула в офис!', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (485, client_id, 'Татьяна (Гольфстрим)', 'new', '25.03.2025', '27.03.2025', 3, 40, 0, 0, 0, 9120.0, 9120.0, true, '25-27 марта 38шт. гид Гульназ 89393902610 Кристалл к 11.30 сдадут 27 в кристалл в 22.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (484, client_id, 'Татьяна (Гольфстрим)', 'new', '25.03.2025', '27.03.2025', 3, 44, 0, 0, 0, 10080.0, 10080.0, true, '25-27 марта 42шт. отель Ямле в 9.30 гид Эльвира 89172639101 сдадут в Кисталл 27.03 в 13.30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (483, client_id, 'Татьяна (Гольфстрим)', 'new', '24.03.2025', '26.03.2025', 3, 36, 0, 0, 0, 8160.0, 8160.0, true, '24 марта 34шт. гид Гульнара 89600389286 15:45-16:30 Обед в Ресторане «ТАТАР»ул. Шигабутдина Марджани 4 . сдадут 26 марта 14:00-15:00 Обед в кафе города. Татарская усадьба Алан Аш ул.Шигабутдина Марджани,8', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (482, client_id, 'Татьяна (Гольфстрим)', 'new', '24.03.2025', '26.03.2025', 3, 32, 0, 0, 0, 7200.0, 7200.0, true, '24 марта 30 шт. гид Альбина 89503160154 в Сулейман в 8.40 отдадут 26 марта в Сулейман в 20.30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (481, client_id, 'Татьяна (Гольфстрим)', 'new', '24.03.2025', '24.03.2025', 1, 50, 0, 0, 0, 3920.0, 3920.0, true, '24 марта 49шт. в Сулейман к 9.30 сдадут в этот же день 13:00 – 14:00 Обед в кафе города Ресторанный двор ул.Астрономическая 7. гид Ирина 89046620732. Вернули в Офис', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (480, client_id, 'Татьяна (Гольфстрим)', 'new', '23.03.2025', '26.03.2025', 4, 36, 0, 0, 0, 10880.0, 10880.0, true, '23 марта 34шт.Гид Ольга 89503140361 15:00 – 16:00 Обед Кафе «Овсянки» ул.Бутлерова 34а отдадут 26 марта 12:00 – 13:30 Обед Ресторанный двор ул.Астрономическая,7', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (479, client_id, 'Татьяна (Гольфстрим)', 'new', '22.03.2025', '24.03.2025', 3, 25, 0, 0, 0, 5760.0, 5760.0, true, 'на 22.03 24шт. 8905323704822-гид Нелли Рифовна 09:00 - 10:00 Завтрак Кафе «Овсянки» ул.Бутлерова 34а сдаст 24 марта 19:00 Ужин Кафе Медина ул.Татарстан,7', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (478, client_id, 'Татьяна (Гольфстрим)', 'new', '22.03.2025', '24.03.2025', 3, 39, 0, 0, 0, 8880.0, 8880.0, true, 'на 22.03 37 шт гид Аида 89033440899в 13.30 ресторан ТАТАР в кремле,отдаст 24.03 в отель Кристалл после 21', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Дмитрий Попков%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (477, client_id, 'Дмитрий Попков', 'new', '02.05.2025', '03.05.2025', 2, 50, 0, 0, 0, 7680.0, 7680.0, true, 'Сулейман начало в 09:00. Забрать в Джузеппе', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (476, client_id, 'Ольга', 'new', '01.05.2025', '02.05.2025', 2, 52, 0, 0, 0, 8000.0, 8000.0, true, 'В 9:00 завтрак', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (475, client_id, 'Камила Ягудина', 'new', '04.04.2025', '04.04.2025', 1, 14, 0, 0, 0, 960.0, 960.0, true, 'С 13:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Луиза%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (474, client_id, 'Луиза', 'new', '06.04.2025', '06.04.2025', 1, 46, 0, 0, 0, 3520.0, 3520.0, true, 'В 09:00 заберет сама Две сумки по 22 Оставила в офисе', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Нина Тиханова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (473, client_id, 'Нина Тиханова', 'new', '03.04.2025', '03.04.2025', 1, 21, 0, 0, 0, 1600.0, 1600.0, true, 'Заберет из офиса', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга Тандалова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (472, client_id, 'Ольга Тандалова', 'new', '22.03.2025', '23.03.2025', 2, 24, 0, 0, 0, 3520.0, 3520.0, true, 'Валерий Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (470, client_id, 'Татьяна Чуб', 'new', '18.04.2025', '20.04.2025', 3, 35, 0, 0, 0, 7920.0, 7920.0, true, 'Кристал.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (469, client_id, 'Наталья', 'new', '08.05.2025', '09.05.2025', 2, 51, 0, 0, 0, 8000.0, 8000.0, true, '8 мая с 20 до 22 9 мая с 14 до 18 Порядка 50 человек. Отель Европа.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (468, client_id, 'Галия', 'new', '13.06.2025', '14.06.2025', 2, 15, 0, 0, 0, 2240.0, 2240.0, true, 'В Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (467, client_id, 'Элина (Сититур)', 'new', '06.04.2025', '07.04.2025', 2, 26, 0, 0, 0, 4000.0, 4000.0, true, '5 апреля в 14:00 заберет. Забрать в новинки', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (466, client_id, 'Элина (Сититур)', 'new', '25.03.2025', '29.03.2025', 5, 18, 0, 0, 0, 6400.0, 6400.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Аниса%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (465, client_id, 'Аниса', 'new', '14.03.2025', '15.03.2025', 2, 50, 0, 0, 0, 7680.0, 7680.0, true, 'Гид Елена +79376267304', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Варвара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (463, client_id, 'Варвара', 'new', '08.03.2025', '08.03.2025', 1, 37, 0, 0, 0, 2880.0, 2880.0, true, 'Гостиница пилигрим. Оставить 8 числа. Забрать 9 числа.', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (462, client_id, 'Екатерина', 'new', '05.03.2025', '05.03.2025', 1, 18, 0, 0, 0, 1360.0, 1360.0, true, 'Отель Рамада На имя Валерий', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (461, client_id, 'Мира (ИП)', 'new', '26.02.2025', '26.02.2025', 1, 52, 0, 0, 0, 3500.0, 3500.0, true, 'Старт в 15:00 от старого ИТ парка', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Сафронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (460, client_id, 'Ирина Сафронова', 'new', '14.02.2025', '16.02.2025', 3, 40, 0, 0, 0, 7770.0, 7770.0, true, 'Кристалл, Казанские Традиции', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (459, client_id, 'Юлия Воронова', 'new', '18.02.2025', '19.02.2025', 2, 26, 0, 0, 0, 3840.0, 3840.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Палитра Тур%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (458, client_id, 'Палитра Тур', 'new', '09.02.2025', '09.02.2025', 1, 45, 0, 0, 0, 3520.0, 3520.0, true, 'В 11:00-11:30 они приедут в Татарстан и встретятся там с экскурсоводом, Живут в Волге , +7 960 039-47-90 гид на 10 февраля Инна, они встречаются с группой в 11:00 возле гостиницы Татарстан', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (457, client_id, 'Галия', 'new', '29.04.2025', '29.04.2025', 1, 14, 0, 0, 0, 1040.0, 1040.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (455, client_id, 'Юлия Воронова', 'new', '17.02.2025', '19.02.2025', 3, 52, 0, 0, 0, 9840.0, 9840.0, true, 'Делать группу так же как 12 февраля', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (454, client_id, 'Юлия Воронова', 'new', '11.02.2025', '11.02.2025', 1, 52, 0, 0, 0, 4000.0, 4000.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (453, client_id, 'Мария', 'new', '26.07.2025', '27.07.2025', 2, 33, 0, 0, 0, 4960.0, 4960.0, true, 'В школу в 12', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (452, client_id, 'Мария', 'new', '12.06.2025', '12.06.2025', 1, 43, 0, 0, 0, 3360.0, 3360.0, true, 'Можно так же до 13.00 на Оренбургский тракт 4а. Светлана - +79954723715, для связи. +7 917 878-34-06. Сергей Слободенюк', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (451, client_id, 'Мария', 'new', '01.05.2025', '02.06.2025', 2, 48, 0, 0, 0, 7360.0, 7360.0, true, 'В 12:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Обыденникова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (450, client_id, 'Ирина Обыденникова', 'new', '30.04.2025', '30.04.2025', 1, 42, 0, 0, 0, 11840.0, 11840.0, true, 'Ривьера', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Обыденникова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (449, client_id, 'Ирина Обыденникова', 'new', '06.02.2025', '08.02.2025', 3, 32, 0, 0, 0, 7200.0, 7200.0, true, 'Татарстан Мастерская впечатлений', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (445, client_id, 'Мария Экскурсовод', 'new', '24.04.2025', '26.04.2025', 3, 31, 0, 0, 0, 6960.0, 6960.0, true, 'Кристал. Вернули в кристал. Привезет Ильдар 051', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульфия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (444, client_id, 'Гульфия', 'new', '26.01.2025', '26.01.2025', 1, 12, 0, 0, 0, 880.0, 880.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лариса%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (443, client_id, 'Лариса', 'new', '25.01.2025', '25.01.2025', 1, 55, 0, 0, 0, 4080.0, 4080.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (442, client_id, 'Татьяна (Гольфстрим)', 'new', '21.01.2025', '22.01.2025', 2, 54, 0, 0, 0, 8320.0, 8320.0, true, 'Сулейман Владимир Николаевич', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Пронина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (441, client_id, 'Ирина Пронина', 'new', '12.01.2025', '12.01.2025', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, 'Созвониться 11.01 до обеда', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (440, client_id, 'Инна Экскурсовод', 'new', '18.01.2025', '18.01.2025', 1, 20, 0, 0, 0, 1440.0, 1440.0, true, 'Свита холл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (439, client_id, 'Юлианна', 'new', '08.01.2025', '09.01.2025', 2, 25, 0, 0, 0, 3220.0, 3220.0, true, 'Волга', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Питер%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (438, client_id, 'Питер', 'new', '04.01.2025', '06.01.2025', 3, 28, 0, 0, 0, 5265.0, 5265.0, true, 'Тиц , Баумана', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Питер%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (437, client_id, 'Питер', 'new', '04.01.2025', '04.01.2025', 1, 40, 0, 0, 0, 2535.0, 2535.0, true, 'Юнион амакс Сафар', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Питер%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (436, client_id, 'Питер', 'new', '04.01.2025', '04.01.2025', 1, 40, 0, 0, 0, 2535.0, 2535.0, true, 'Юнион релита', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Питер%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (435, client_id, 'Питер', 'new', '04.01.2025', '04.01.2025', 1, 44, 0, 0, 0, 2795.0, 2795.0, true, 'Юнион, амакс сафар', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (434, client_id, 'Татьяна (Гольфстрим)', 'new', '06.01.2025', '07.01.2025', 2, 48, 0, 0, 0, 7360.0, 7360.0, true, '6-7.01 гид Марина Рукавишникова +79172526993 6.01 в Сулейман к 9.00 вернут 7.01 после 22.00 в Кристалл', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (433, client_id, 'Татьяна (Гольфстрим)', 'new', '05.01.2025', '07.01.2025', 3, 28, 0, 0, 0, 6240.0, 6240.0, true, '5-7 января Гид Владимир Николаевич +7917885840 5,01 в отель Сулейман к 8,30 вернут 7,01 после 18 по созвону, вернул в Сулейман', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (432, client_id, 'Татьяна (Гольфстрим)', 'new', '03.01.2025', '04.01.2025', 2, 25, 0, 0, 0, 3680.0, 3680.0, true, '3,4 января.гид Аида +79033440899 3.01 в 14:00 - 14:45 Обед в кафе города Кафе Медина ул.Татарстан,7 вернут 4.01 вернут после 15 в Кристалл', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (431, client_id, 'Татьяна (Гольфстрим)', 'new', '04.01.2025', '05.01.2025', 2, 42, 0, 0, 0, 6400.0, 6400.0, true, '4,5 января. Гид Виолетта +79053171049 4.01 в Отель Кристалл 3*к 8.30 вернут 5.01 после 22.00 в Кристалл', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (430, client_id, 'Татьяна (Гольфстрим)', 'new', '03.01.2025', '04.01.2025', 2, 48, 0, 0, 0, 7360.0, 7360.0, true, '3.4 января гид Шуравина Ольга +79503140361 3-привезти в ресторан Ферма.ул.Бурхана Шахиди,11 вернут 4.января в отель Сулейман. Обед 12-13', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алена Волина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (429, client_id, 'Алена Волина', 'new', '31.12.2024', '31.12.2024', 1, 46, 0, 0, 0, 3600.0, 3600.0, true, 'Колобок на Гафури', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (428, client_id, 'Альберт (КТ)', 'new', '08.01.2025', '09.01.2025', 2, 71, 0, 0, 0, 9380.0, 9380.0, true, 'Кристал 1 группа 30 человека + гид Ирина 2 группа 37 человек + гид Владимир', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юрий%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (427, client_id, 'Юрий', 'new', '06.01.2025', '08.01.2025', 3, 52, 0, 0, 0, 12000.0, 12000.0, true, 'Волга Гид Наталья', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (426, client_id, 'Гульнара', 'new', '31.12.2024', '02.01.2025', 3, 42, 0, 0, 0, 9600.0, 9600.0, true, 'Заберет сама вечером', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (425, client_id, 'Гульнара', 'new', '31.12.2024', '02.01.2025', 3, 47, 0, 0, 0, 10800.0, 10800.0, true, 'Заберет сама вечером', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (424, client_id, 'Анюта Родионова (Родина-тур)', 'new', '31.12.2024', '02.01.2025', 2, 50, 0, 0, 0, 11520.0, 11520.0, true, 'Хаял кушают в 9:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (423, client_id, 'Элина (Сититур)', 'new', '06.01.2025', '06.01.2025', 1, 47, 0, 0, 0, 3680.0, 3680.0, true, 'вернут в мано', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (422, client_id, 'Татьяна (Гольфстрим)', 'new', '27.12.2024', '29.12.2024', 2, 30, 0, 0, 0, 4480.0, 4480.0, true, 'Кристал Владимир Николаевич', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (421, client_id, 'Альберт (КТ)', 'new', '21.12.2024', '21.12.2024', 1, 26, 0, 0, 0, 1750.0, 1750.0, true, 'На завтра 21.12 на 1 день Нужны гиды для группы 25 человек + гид Владимир т. 89178858409 Оставить для Владимира Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (419, client_id, 'Мария', 'new', '05.01.2025', '05.01.2025', 1, 35, 0, 0, 0, 3120.0, 3120.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (418, client_id, 'Мария', 'new', '03.01.2025', '03.01.2025', 1, 47, 0, 0, 0, 3680.0, 3680.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (417, client_id, 'Мария Экскурсовод', 'new', '21.12.2024', '21.12.2024', 1, 24, 0, 0, 0, 1840.0, 1840.0, true, 'Экскурсовод Инна', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (416, client_id, 'Мария Экскурсовод', 'new', '05.01.2025', '07.01.2025', 3, 31, 0, 0, 0, 6960.0, 6960.0, true, '5 января начало в 16.00 от хостела Пушкин, (Пушкина 1/55)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Твой Гид%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (414, client_id, 'Твой Гид', 'new', '14.12.2024', '15.12.2024', 2, 40, 0, 0, 0, 5920.0, 5920.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александр Романов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (413, client_id, 'Александр Романов', 'new', '14.12.2024', '15.12.2024', 2, 21, 0, 0, 0, 3040.0, 3040.0, true, 'Карат', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (412, client_id, 'Эдик Заказы для групп', 'new', '14.12.2024', '14.12.2024', 1, 35, 0, 0, 0, 2640.0, 2640.0, true, 'Кристал Катя Ильина 2 передатчика', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга Лукоянова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (411, client_id, 'Ольга Лукоянова', 'new', '14.12.2024', '14.12.2024', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (410, client_id, 'Татьяна Чуб', 'new', '13.12.2024', '14.12.2024', 2, 39, 0, 0, 0, 5920.0, 5920.0, true, 'Гвардейская', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (409, client_id, 'Эдик Заказы для групп', 'new', '07.12.2024', '07.12.2024', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, 'В 11:00. От Шаляпина Катя Ильина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (408, client_id, 'Эдик Заказы для групп', 'new', '07.12.2024', '07.12.2024', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, 'Кристал. Элина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (407, client_id, 'Мира (ИП)', 'new', '06.12.2024', '06.12.2024', 1, 46, 0, 0, 0, 3150.0, 3150.0, true, 'Шаляпин', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (406, client_id, 'Мира (ИП)', 'new', '05.12.2024', '05.12.2024', 1, 20, 0, 0, 0, 1330.0, 1330.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (405, client_id, 'Екатерина', 'new', '05.12.2024', '05.12.2024', 1, 16, 0, 0, 0, 1200.0, 1200.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (404, client_id, 'Екатерина', 'new', '29.11.2024', '29.11.2024', 1, 16, 0, 0, 0, 1200.0, 1200.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (403, client_id, 'Юлия Воронова', 'new', '28.11.2024', '28.11.2024', 1, 112, 0, 0, 0, 8640.0, 8640.0, true, 'Приедет 13:30 к Шаляпину', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (402, client_id, 'Галия', 'new', '26.11.2024', '26.11.2024', 1, 16, 0, 0, 0, 1200.0, 1200.0, true, '9:50. У иконы. забрать в кристале', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (401, client_id, 'Эдик Заказы для групп', 'new', '22.11.2024', '22.11.2024', 1, 50, 0, 0, 0, 3920.0, 3920.0, true, 'Завтра в 13:00 отель Мано на Чистопольской 47А. Нужно 49 радиогидов. С ними будет Гульнара.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (400, client_id, 'Татьяна (Гольфстрим)', 'new', '22.11.2024', '22.11.2024', 1, 50, 0, 0, 0, 3840.0, 3840.0, true, '+7 917 252-69-93. Марина Рукавишникова 48 шт. В 9.30-19.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (399, client_id, 'Зельфира', 'new', '05.01.2025', '07.01.2025', 3, 54, 0, 0, 0, 12480.0, 12480.0, true, 'Оставила в офисе', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (398, client_id, 'Зельфира', 'new', '03.01.2025', '03.01.2025', 1, 53, 0, 0, 0, 4160.0, 4160.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (397, client_id, 'Эдик Заказы для групп', 'new', '18.11.2024', '18.11.2024', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, 'Наталья', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (396, client_id, 'Эдик Заказы для групп', 'new', '18.11.2024', '18.11.2024', 1, 60, 0, 0, 0, 4720.0, 4720.0, true, 'Элина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Титова Галина (Эллинлайн)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (395, client_id, 'Титова Галина (Эллинлайн)', 'new', '30.11.2024', '01.12.2024', 2, 34, 0, 0, 0, 5120.0, 5120.0, true, 'Прошу Вас выставить счёт на группу 32+1 гид. 30.11-1.12,, завтрак Биляр Палас, гид 89030624411 Елена Анатольевна.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (394, client_id, 'Альберт (КТ)', 'new', '18.11.2024', '20.11.2024', 3, 41, 0, 0, 0, 8190.0, 8190.0, true, 'Группа Хостел Пушкин, ул.Пушкина 1/55 а на 18-20 ноября 39 человек + гид Лариса т. 89272408250', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (393, client_id, 'Альберт (КТ)', 'new', '18.11.2024', '19.11.2024', 2, 38, 0, 0, 0, 5040.0, 5040.0, true, 'Группа Хостел Nice, ул. Петербургская 40 б на 18 и 19 ноября 36 человек + гид Татьяна т.89063271840', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лейла%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (392, client_id, 'Лейла', 'new', '19.11.2024', '19.11.2024', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (391, client_id, 'Эдик Заказы для групп', 'new', '17.11.2024', '17.11.2024', 1, 13, 0, 0, 0, 1200.0, 1200.0, true, 'Лариса. Сумка 14', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Искандер%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (390, client_id, 'Искандер', 'new', '16.11.2024', '18.11.2024', 3, 24, 0, 0, 0, 3300.0, 3300.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (389, client_id, 'Эдик Заказы для групп', 'new', '16.11.2024', '19.11.2024', 4, 35, 0, 0, 0, 10560.0, 10560.0, true, 'Кристал, Настя', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (388, client_id, 'Ирина', 'new', '15.11.2024', '15.11.2024', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, 'Добрый вечер. Заказ на 15.11 в 9 утра , ГОСТ. Кристалл, 32 чел. На имя Элли', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (387, client_id, 'Мира (ИП)', 'new', '10.11.2024', '10.11.2024', 1, 31, 0, 0, 0, 2100.0, 2100.0, true, 'Ривьера', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (386, client_id, 'Эдик Заказы для групп', 'new', '08.11.2024', '08.11.2024', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'и завтра в 10:00 отель Регата 50 человек радиогиды , с ними Лариса Семенова', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (385, client_id, 'Эдик Заказы для групп', 'new', '08.11.2024', '08.11.2024', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, 'на завтра в 10:00 от Сафар отеля нужно 35 радиогидов. с группой будет Катя Ильина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ильмира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (384, client_id, 'Ильмира', 'new', '07.11.2024', '07.11.2024', 1, 28, 0, 0, 0, 2160.0, 2160.0, true, '26 шт. радиогидов на 1 день (беру 07.11.(чт) в 14.00)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ильмира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (383, client_id, 'Ильмира', 'new', '04.11.2024', '04.11.2024', 1, 30, 0, 0, 0, 2320.0, 2320.0, true, 'Фиолетовые', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (382, client_id, 'Альберт (КТ)', 'new', '03.11.2024', '03.11.2024', 1, 25, 0, 0, 0, 1680.0, 1680.0, true, 'Кристал. Лилия. Мариотт', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (381, client_id, 'Татьяна (Гольфстрим)', 'new', '06.11.2024', '07.11.2024', 2, 45, 0, 0, 0, 7040.0, 7040.0, true, 'на 6,7 ноября. Гид Игорь. +7 927 405-50-70 44 шт. В Давыдов на Назарбаева к 10.30. Сдадут7 ноября в Кристалл после 17.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александр%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (380, client_id, 'Александр', 'new', '31.12.2024', '02.01.2025', 3, 46, 0, 0, 0, 10560.0, 10560.0, true, 'Инна +79869297050 Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (379, client_id, 'Мария Экскурсовод', 'new', '01.11.2024', '01.11.2024', 1, 45, 0, 0, 0, 3360.0, 3360.0, true, 'Баумана в 9:50. забрать в Мариотте', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (378, client_id, 'Эдик Заказы для групп', 'new', '01.11.2024', '02.11.2024', 1, 26, 0, 0, 0, 4000.0, 4000.0, true, 'Ольга ткач', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (377, client_id, 'Сергей (Авангард)', 'new', '05.11.2024', '06.11.2024', 2, 26, 0, 0, 0, 3500.0, 3500.0, true, '5.11 в 10.30 Казань 1 прибытие - 6.11 в 17.00 привозим на Казань 1 - Гид: +79872969542 Елена - 140 руб. * 25 наушников = 3 500 руб. - гид оплатит на месте', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (376, client_id, 'Элина (Сититур)', 'new', '01.11.2024', '01.11.2024', 1, 11, 0, 0, 0, 800.0, 800.0, true, 'Сулейман начало в 15:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (375, client_id, 'Анюта Родионова (Родина-тур)', 'new', '03.11.2024', '04.11.2024', 2, 44, 0, 0, 0, 6880.0, 6880.0, true, 'Карат на Сары садыковой', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (374, client_id, 'Мира (ИП)', 'new', '31.10.2024', '01.11.2024', 2, 20, 0, 0, 0, 2310.0, 2310.0, true, 'Сафар', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (373, client_id, 'Алексей', 'new', '30.11.2024', '01.12.2024', 2, 53, 0, 0, 0, 8160.0, 8160.0, true, 'Гид Елена', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (372, client_id, 'Алексей', 'new', '16.11.2024', '17.11.2024', 2, 51, 0, 0, 0, 8000.0, 8000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (371, client_id, 'Алексей', 'new', '09.11.2024', '10.11.2024', 2, 51, 0, 0, 0, 8000.0, 8000.0, true, 'Гид Елена Волга 12:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (370, client_id, 'Гульнара', 'new', '03.11.2024', '04.11.2024', 2, 43, 0, 0, 0, 6720.0, 6720.0, true, 'И нужно будет 3- 4.11 От меня Данил наберёт и заберёт.Он будет вести нашу группу', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Искандер%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (369, client_id, 'Искандер', 'new', '30.10.2024', '30.10.2024', 1, 34, 0, 0, 0, 1650.0, 1650.0, true, 'В офис 14:00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (368, client_id, 'Татьяна (Гольфстрим)', 'new', '31.10.2024', '01.11.2024', 2, 43, 0, 0, 0, 6720.0, 6720.0, true, 'Добрый вечер. На 31 надо в АМАКС сафар отель 42 шт на 31-1. Гид Игорь +7 927 405-50-70. По поводу возврата созвонитесь, пожалуйста', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (367, client_id, 'Альберт (КТ)', 'new', '30.10.2024', '31.10.2024', 2, 22, 0, 0, 0, 2940.0, 2940.0, true, 'Добрый вечер, Леонид! Группа 21 человек +гид Лиля т. +7 965 602-05-28 На 2 дня 30 октября и 31 октября Проживают в отеле Булгар, Вишневского 21 Будет возможность?', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (366, client_id, 'Екатерина', 'new', '30.10.2024', '31.10.2024', 2, 46, 0, 0, 0, 7200.0, 7200.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (365, client_id, 'Татьяна (Гольфстрим)', 'new', '28.10.2024', '30.10.2024', 2, 22, 0, 0, 0, 3360.0, 3360.0, true, 'На 28 и 30 нужны 21 радиогиды в 13,30 у них сегодня обед в Ресторанном дворе( стерлядке) гид Диляра +7 917 927-54-89', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (364, client_id, 'Наталья', 'new', '28.10.2024', '28.10.2024', 1, 22, 0, 0, 0, 1680.0, 1680.0, true, 'Ольга +79872965880', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (363, client_id, 'Татьяна (Гольфстрим)', 'new', '29.10.2024', '01.11.2024', 3, 37, 0, 0, 0, 8640.0, 8640.0, true, '29-31 36шт. 29-в Кристалл к 9.30 сдадут 1 ноября после 16.00 в Кристалл гид Марина +79053130120', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (362, client_id, 'Татьяна (Гольфстрим)', 'new', '28.10.2024', '30.10.2024', 3, 35, 0, 0, 0, 8160.0, 8160.0, true, '28-30 34шт. 28-Кристалл в 11.00 гид Игорь +79274055070, сдадут 30-после 16. 12:00 донкихот', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (361, client_id, 'Татьяна (Гольфстрим)', 'new', '28.10.2024', '30.10.2024', 3, 38, 0, 0, 0, 8880.0, 8880.0, true, '28-30 37 шт. 28-Кристалл к 12, сдадут 30 по созвону после 15 гид Диана +79274454525', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (360, client_id, 'Татьяна (Гольфстрим)', 'new', '27.10.2024', '29.10.2024', 3, 35, 0, 0, 0, 8160.0, 8160.0, true, '27-29 34 шт.27-Сулейман к 8.00 29-сдаст в офис после 15.00 гид Марина +79172526993', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (359, client_id, 'Татьяна (Гольфстрим)', 'new', '27.10.2024', '30.10.2024', 4, 35, 0, 0, 0, 10880.0, 10880.0, true, '27-30 34 шт. 27- отель Волга 8.40 завтрак сдадут 30-Кристалл после 21 гид Ольга +79503140361', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (358, client_id, 'Юлия Воронова', 'new', '30.10.2024', '30.10.2024', 1, 32, 0, 0, 0, 2480.0, 2480.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (357, client_id, 'Юлия Воронова', 'new', '28.10.2024', '28.10.2024', 1, 42, 0, 0, 0, 3280.0, 3280.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (356, client_id, 'Альберт (КТ)', 'new', '31.10.2024', '01.11.2024', 2, 24, 0, 0, 0, 3220.0, 3220.0, true, 'Группа 23 чел+гид Татьяна т.89063271840- 2 дня Оставить 30 октября в отеле Кристал. 1.11. отель болгар', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (355, client_id, 'Альберт (КТ)', 'new', '29.10.2024', '29.10.2024', 1, 18, 0, 0, 0, 1190.0, 1190.0, true, 'Группа 17 чел+гид Булат т.89376173315 - 1 день Оставить 28 октября в отеле Булгар 2,ул.Вишневского 21*', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (354, client_id, 'Альберт (КТ)', 'new', '28.10.2024', '29.10.2024', 2, 44, 0, 0, 0, 6020.0, 6020.0, true, '4) Группа 43 чел+гид Ирина т.89274213682 - 2 дня с 28-29 окт, Оставить 27 октября в хостоле "Дом 64", ул Большая Красная 64', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (353, client_id, 'Альберт (КТ)', 'new', '26.10.2024', '28.10.2024', 3, 42, 0, 0, 0, 8610.0, 8610.0, true, '3) Группа 41 чел+гид Маргарита т.89063263820 -на *3 ДНЯ* с 26-28 окт, на 3й день возращает гид Татьяна т.89063271840 Оставить сегодня в отеле Булгар 2,ул.Вишневского 21*сумка в Шаляпин', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (352, client_id, 'Эдик Заказы для групп', 'new', '25.10.2024', '27.10.2024', 3, 37, 0, 0, 0, 8640.0, 8640.0, true, 'Настя Автобус 981', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (351, client_id, 'Эдик Заказы для групп', 'new', '26.10.2024', '26.10.2024', 1, 29, 0, 0, 0, 2240.0, 2240.0, true, 'Уточнить у Кати', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (350, client_id, 'Мария Экскурсовод', 'new', '02.11.2024', '03.11.2024', 2, 25, 0, 0, 0, 3840.0, 3840.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (349, client_id, 'Альберт (КТ)', 'new', '26.10.2024', '26.10.2024', 1, 110, 0, 0, 0, 7560.0, 7560.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Валентина Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (348, client_id, 'Валентина Экскурсовод', 'new', '28.10.2024', '28.10.2024', 1, 54, 0, 0, 0, 4240.0, 4240.0, true, 'Волга', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена Марковна ( черный список)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (347, client_id, 'Елена Марковна ( черный список)', 'new', '30.10.2024', '31.10.2024', 2, 50, 0, 0, 0, 7840.0, 7840.0, true, 'Гранд отель к 12', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ксения%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (346, client_id, 'Ксения', 'new', '29.10.2024', '29.10.2024', 1, 86, 0, 0, 0, 6720.0, 6720.0, true, '2 группы', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (345, client_id, 'Галина', 'new', '31.10.2024', '02.11.2024', 3, 47, 0, 0, 0, 9660.0, 9660.0, true, 'Лейла +79172488804', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (344, client_id, 'Галина', 'new', '31.10.2024', '02.11.2024', 3, 42, 0, 0, 0, 8610.0, 8610.0, true, 'Диляра +79179275489', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (343, client_id, 'Галина', 'new', '29.10.2024', '31.10.2024', 3, 50, 0, 0, 0, 10290.0, 10290.0, true, 'Ангелина +79872050601. Татарская усадьба', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лиля Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (342, client_id, 'Лиля Экскурсовод', 'new', '26.10.2024', '26.10.2024', 1, 8, 0, 0, 0, 800.0, 800.0, true, 'в 12 заберет', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (341, client_id, 'Сергей (Авангард)', 'new', '28.10.2024', '29.10.2024', 2, 34, 0, 0, 0, 4620.0, 4620.0, true, '28.10 в 10.30 Казань 1 прибытие - 29.10 в 17.00 привозим на Казань 1 - Гид: +7 905 316-29-73 Елена - 140 руб. * 33 наушников = 4 620 руб. - гид оплатит на месте', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (340, client_id, 'Сергей (Авангард)', 'new', '25.10.2024', '26.10.2024', 2, 45, 0, 0, 0, 6160.0, 6160.0, true, '25.10 в 7.30 Казань 1 прибытие - 26.10 в 18.30 привозим на Казань 1 - Гид: +7 905 316-29-73 Елена - 140 руб. * 44 наушников = 6 160 руб. - гид оплатит на месте', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Светлана Клиент%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (339, client_id, 'Светлана Клиент', 'new', '25.10.2024', '27.10.2024', 3, 34, 0, 0, 0, 7680.0, 7680.0, true, 'Жд 11:00 вернут 27.10 в 15:00 Дурсун. +7 919 699-29-68', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга Волковец%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (338, client_id, 'Ольга Волковец', 'new', '18.10.2024', '20.10.2024', 3, 19, 0, 0, 0, 4080.0, 4080.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эмилия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (337, client_id, 'Эмилия', 'new', '26.10.2024', '26.10.2024', 1, 46, 0, 0, 0, 3600.0, 3600.0, true, '26.10 в 9 утра поезд, оставить в кристалл', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (335, client_id, 'Зульхиза Кутлучурина', 'new', '16.10.2024', '18.10.2024', 3, 29, 0, 0, 0, 6480.0, 6480.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (334, client_id, 'Эдик Заказы для групп', 'new', '12.10.2024', '12.10.2024', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камилла%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (333, client_id, 'Камилла', 'new', '11.10.2024', '13.10.2024', 2, 40, 0, 0, 0, 6400.0, 6400.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (332, client_id, 'Мира (ИП)', 'new', '11.10.2024', '13.10.2024', 2, 33, 0, 0, 0, 6510.0, 6510.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (331, client_id, 'Артем Агафонов', 'new', '27.10.2024', '27.10.2024', 1, 48, 0, 0, 0, 3760.0, 3760.0, true, 'Группа приезжает 26 октября в 13:00 и будет ночевать в Фатиме. 27 октября отправится на экскурсию в 08:00 И закончит в 14:00-14:30 у театра кукол', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (330, client_id, 'Мария Экскурсовод', 'new', '12.10.2024', '12.10.2024', 1, 53, 0, 0, 0, 4160.0, 4160.0, true, '14:00 туган авылым', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (329, client_id, 'Мария Экскурсовод', 'new', '11.10.2024', '11.10.2024', 1, 107, 0, 0, 0, 8400.0, 8400.0, true, '13:30 дом чая Забрать в крыльях', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (328, client_id, 'Мария Экскурсовод', 'new', '11.10.2024', '12.10.2024', 2, 26, 0, 0, 0, 3840.0, 3840.0, true, 'Волга', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (327, client_id, 'Гульнара', 'new', '12.10.2024', '13.10.2024', 2, 50, 0, 0, 0, 7680.0, 7680.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (326, client_id, 'Татьяна (Гольфстрим)', 'new', '30.10.2024', '30.10.2024', 1, 47, 0, 0, 0, 3680.0, 3680.0, true, '30-46 шт. в Давыдов на Назарбаева к 10, сдадут в Кристалл в 21 гид Марина +79053130120', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (324, client_id, 'Татьяна (Гольфстрим)', 'new', '30.10.2024', '01.11.2024', 3, 48, 0, 0, 0, 11520.0, 11520.0, true, '30-1.11 48 шт. 30-в 11.30 завтрак в Алан аш на Ш.Марджани,8 сдадут 1 ноября в 21.00 в Кристалл гид Нелли Рифовна +79063237048', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (323, client_id, 'Татьяна (Гольфстрим)', 'new', '29.10.2024', '31.10.2024', 3, 37, 0, 0, 0, 8640.0, 8640.0, true, '29-31 36шт. 29-Кристалл к 8.30 , сдадут 31-в Кристалл в 18.00 гид Аида +79033440899', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (322, client_id, 'Татьяна (Гольфстрим)', 'new', '29.10.2024', '31.10.2024', 3, 33, 0, 0, 0, 7920.0, 7920.0, true, '29-31 (без30) 33 шт. 29- завтрак в Волге в 7.30 гид Игорь +79274055070 сдадут 31 после 17 в Кристалл гид Виолетта +79053171049', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (321, client_id, 'Татьяна (Гольфстрим)', 'new', '28.10.2024', '30.10.2024', 3, 29, 0, 0, 0, 6720.0, 6720.0, true, '28-30 28 шт. 28-Кристаллв 13.00 гид Гузель +79033142074 сдадут 30- в 20.00 Кристалл гид Гульназ +79393902610', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (320, client_id, 'Татьяна (Гольфстрим)', 'new', '27.10.2024', '30.10.2024', 4, 36, 0, 0, 0, 8400.0, 8400.0, true, '27-30 без 28 октября 35шт.27-кафе Медина на Спартаковской к 8.30 возврат по созвону30 -после 16.00 гид Виолетта +79053171049. Забрать в офисе', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (319, client_id, 'Татьяна (Гольфстрим)', 'new', '27.10.2024', '28.10.2024', 3, 47, 0, 0, 0, 7360.0, 7360.0, true, '46 шт. 27-в Кристалл к 11.30 гид Юля +79178863309. сдадут 28- по созвону после 14.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (318, client_id, 'Татьяна (Гольфстрим)', 'new', '26.10.2024', '28.10.2024', 3, 35, 0, 0, 0, 8160.0, 8160.0, true, 'оставят в Кристалле 28.10. Гид Дания +79172904415 после 22.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (317, client_id, 'Татьяна (Гольфстрим)', 'new', '27.10.2024', '27.10.2024', 1, 30, 0, 0, 0, 2320.0, 2320.0, true, '29 шт. отель Ямле к 9.00 сдадут по договоренности после 14.30 гид Гульназ +79393902610', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (316, client_id, 'Татьяна (Гольфстрим)', 'new', '26.10.2024', '27.10.2024', 2, 28, 0, 0, 0, 4320.0, 4320.0, true, '26-27- 27 шт. В Кристалл к 7.30 , сдадут в Кристалл 27.10 после20. 30 26-27 последняя моя запись гид Лилия. +79872975449', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (315, client_id, 'Татьяна (Гольфстрим)', 'new', '26.10.2024', '26.10.2024', 1, 32, 0, 0, 0, 2480.0, 2480.0, true, '26 октября к 9.40 в Давыдов на Назарбаева 31 шт на один день сдадут туда же после 17,30 гид Ирина 89274213682', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (314, client_id, 'Татьяна (Гольфстрим)', 'new', '25.10.2024', '27.10.2024', 3, 31, 0, 0, 0, 7200.0, 7200.0, true, '25-27 октября в Кристалл к 7,30 сдадут в 17,30 - в Кристалл 30 шт. Гид Диляра Рафаровна +79179275489', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (313, client_id, 'Татьяна (Гольфстрим)', 'new', '25.10.2024', '25.10.2024', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, '25 шт. В Кристалл к 11.30 сдадут на Баумана в офис16. 30 гид Виолетта +79053171049', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (310, client_id, 'Андрей (Экскурс)', 'new', '28.10.2024', '30.10.2024', 3, 34, 0, 0, 0, 7680.0, 7680.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (308, client_id, 'Зульхиза Кутлучурина', 'new', '07.10.2024', '09.10.2024', 3, 38, 0, 0, 0, 8400.0, 8400.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (307, client_id, 'Мира (ИП)', 'new', '05.10.2024', '05.10.2024', 1, 56, 0, 0, 0, 7700.0, 7700.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (306, client_id, 'Сергей (Авангард)', 'new', '06.10.2024', '08.10.2024', 3, 28, 0, 0, 0, 5460.0, 5460.0, true, '6.10 в 10.30 Казань 1 прибытие - 8.10 в 17.00 привозим на Казань 1 - Гид: +79872969542 Елена - 210 руб. * 26 наушников = 5 460 руб. - гид оплатит на месте', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (305, client_id, 'Зельфира', 'new', '04.10.2024', '04.10.2024', 1, 50, 0, 0, 0, 3920.0, 3920.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (304, client_id, 'Юлия Воронова', 'new', '03.10.2024', '05.10.2024', 3, 27, 0, 0, 0, 4000.0, 4000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Морозова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (303, client_id, 'Морозова', 'new', '13.10.2024', '13.10.2024', 1, 55, 0, 0, 0, 4320.0, 4320.0, true, 'Света', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (302, client_id, 'Зельфира', 'new', '02.10.2024', '03.10.2024', 2, 28, 0, 0, 0, 4160.0, 4160.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (301, client_id, 'Эдик Заказы для групп', 'new', '02.10.2024', '02.10.2024', 1, 50, 0, 0, 0, 3920.0, 3920.0, true, 'Кристал, Катя', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айрат Нурмухаммадов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (300, client_id, 'Айрат Нурмухаммадов', 'new', '08.10.2024', '09.10.2024', 2, 31, 0, 0, 0, 3920.0, 3920.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (299, client_id, 'Гульнара', 'new', '05.10.2024', '06.10.2024', 2, 51, 0, 0, 0, 7840.0, 7840.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (298, client_id, 'Татьяна (Гольфстрим)', 'new', '30.09.2024', '03.10.2024', 4, 54, 0, 0, 0, 16640.0, 16640.0, true, '30 . 09 надо 52 радиогида в Кристалле в 7.30 отдадут 3.10 в Кристалл после 15.00 гид Диляра Рафаровна 89179275489', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (297, client_id, 'Альберт (КТ)', 'new', '28.09.2024', '28.09.2024', 1, 49, 0, 0, 0, 3360.0, 3360.0, true, '46 человек +1 гид Встреча возле ЦУМа ожидается прибытие в 14:00,в 20:30 ужинают в отеле Хаял, и едут на заселение в Биляр Инн, краснокошайская 187 Гид Екатерина +7 927 430-72-44', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (296, client_id, 'Татьяна (Гольфстрим)', 'new', '27.09.2024', '29.09.2024', 3, 46, 0, 0, 0, 10560.0, 10560.0, true, '27-29 44 шт. Кристалл 11.30-вернут в Авиатор в 19.00 гид Баталова Ирина 89274213682', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (295, client_id, 'Татьяна (Гольфстрим)', 'new', '27.09.2024', '29.09.2024', 3, 28, 0, 0, 0, 6240.0, 6240.0, true, '27-29 26 шт. Кристалл в 10.30, вернут Кристалл в 20.00 гид Шуравина Ольга 89503140361', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (294, client_id, 'Татьяна (Гольфстрим)', 'new', '27.09.2024', '28.09.2024', 2, 30, 0, 0, 0, 4480.0, 4480.0, true, '27-28 - 28 шт. Кристалл в 9.00 вернут Кристалл в 14. гид Диляра Рафаровна 89179275489', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (293, client_id, 'Сергей (Авангард)', 'new', '28.09.2024', '29.09.2024', 2, 35, 0, 0, 0, 4620.0, 4620.0, true, 'Кристал Гид: Елена +79872969542', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (292, client_id, 'Татьяна', 'new', '31.10.2024', '31.10.2024', 1, 46, 0, 0, 0, 3600.0, 3600.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (291, client_id, 'Татьяна', 'new', '28.09.2024', '28.09.2024', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (290, client_id, 'Мира (ИП)', 'new', '27.09.2024', '28.09.2024', 2, 24, 0, 0, 0, 3080.0, 3080.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (289, client_id, 'Андрей', 'new', '25.09.2024', '28.09.2024', 4, 53, 0, 0, 0, 16000.0, 16000.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (288, client_id, 'Наталья', 'new', '02.11.2024', '02.11.2024', 1, 50, 0, 0, 0, 3920.0, 3920.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (287, client_id, 'Наталья', 'new', '26.09.2024', '26.09.2024', 1, 34, 0, 0, 0, 2640.0, 2640.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (286, client_id, 'Мира (ИП)', 'new', '23.09.2024', '23.09.2024', 1, 51, 0, 0, 0, 3500.0, 3500.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (283, client_id, 'Зульхиза Кутлучурина', 'new', '05.10.2024', '06.10.2024', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (282, client_id, 'Зульхиза Кутлучурина', 'new', '28.09.2024', '29.09.2024', 2, 39, 0, 0, 0, 5920.0, 5920.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (281, client_id, 'Зульхиза Кутлучурина', 'new', '25.09.2024', '27.09.2024', 3, 51, 0, 0, 0, 11760.0, 11760.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (280, client_id, 'Гульнара', 'new', '20.09.2024', '20.09.2024', 1, 40, 0, 0, 0, 3040.0, 3040.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (279, client_id, 'Зульхиза Кутлучурина', 'new', '20.09.2024', '22.09.2024', 3, 50, 0, 0, 0, 11520.0, 11520.0, true, 'Забрать в свияжске', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (278, client_id, 'Мира (ИП)', 'new', '20.09.2024', '21.09.2024', 2, 17, 0, 0, 0, 2100.0, 2100.0, true, 'Кристал. Сумка 1', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (277, client_id, 'Татьяна (Гольфстрим)', 'new', '20.09.2024', '22.09.2024', 3, 35, 0, 0, 0, 7920.0, 7920.0, true, 'В хаял. Вернут в офис. Сумка 2', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (276, client_id, 'Татьяна (Гольфстрим)', 'new', '20.09.2024', '21.09.2024', 2, 32, 0, 0, 0, 4800.0, 4800.0, true, 'В хаял. Вернут в кристал. Сумка 10', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (275, client_id, 'Зельфира', 'new', '18.09.2024', '18.09.2024', 1, 35, 0, 0, 0, 2720.0, 2720.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (274, client_id, 'Наталья', 'new', '31.10.2024', '02.11.2024', 3, 27, 0, 0, 0, 6000.0, 6000.0, true, 'Отель Парисон', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (272, client_id, 'Мария', 'cancelled', '31.12.2024', '31.12.2024', 1, 50, 0, 0, 0, 0.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (271, client_id, 'Елена', 'new', '21.09.2024', '21.09.2024', 1, 47, 0, 0, 0, 3680.0, 3680.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (270, client_id, 'Татьяна (Гольфстрим)', 'new', '17.09.2024', '18.09.2024', 2, 50, 0, 0, 0, 7680.0, 7680.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (269, client_id, 'Элина (Сититур)', 'new', '21.09.2024', '21.09.2024', 1, 31, 0, 0, 0, 2240.0, 2240.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Минеева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (268, client_id, 'Алина Минеева', 'new', '05.10.2024', '05.10.2024', 1, 81, 0, 0, 0, 6320.0, 6320.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь Ким%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (267, client_id, 'Любовь Ким', 'new', '14.09.2024', '14.09.2024', 1, 28, 0, 0, 0, 2160.0, 2160.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Жукова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (266, client_id, 'Наталья Жукова', 'new', '14.09.2024', '14.09.2024', 1, 34, 0, 0, 0, 2400.0, 2400.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (265, client_id, 'Зульхиза Кутлучурина', 'new', '14.09.2024', '15.09.2024', 2, 38, 0, 0, 0, 5760.0, 5760.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (264, client_id, 'Анюта Родионова (Родина-тур)', 'new', '13.09.2024', '15.09.2024', 3, 37, 0, 0, 0, 7350.0, 7350.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (263, client_id, 'Юлия Воронова', 'new', '12.09.2024', '16.09.2024', 5, 20, 0, 0, 0, 6400.0, 6400.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (262, client_id, 'Эдик Заказы для групп', 'cancelled', '16.09.2024', '16.09.2024', 1, 30, 0, 0, 0, 2320.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (261, client_id, 'Эдик Заказы для групп', 'new', '19.09.2024', '19.09.2024', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (260, client_id, 'Екатерина', 'new', '14.09.2024', '14.09.2024', 1, 48, 0, 0, 0, 3760.0, 3760.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Марианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (259, client_id, 'Марианна', 'new', '11.09.2024', '11.09.2024', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Жукова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (258, client_id, 'Наталья Жукова', 'new', '07.09.2024', '07.09.2024', 1, 31, 0, 0, 0, 3520.0, 3520.0, true, 'Двойной комплект наушников', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (257, client_id, 'Эдик Заказы для групп', 'new', '07.09.2024', '08.09.2024', 2, 29, 0, 0, 0, 4320.0, 4320.0, true, 'Кристал, Элина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (256, client_id, 'Татьяна (Гольфстрим)', 'new', '06.09.2024', '06.09.2024', 1, 39, 0, 0, 0, 3040.0, 3040.0, true, 'Кристалл к 10.30 38 шт. Гид Диана 89274454525. Вернуть этот день день. Отель Сулейман в 18.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (255, client_id, 'Гульнара', 'new', '28.09.2024', '29.09.2024', 2, 50, 0, 0, 0, 7680.0, 7680.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (254, client_id, 'Камила Ягудина', 'new', '06.09.2024', '06.09.2024', 1, 12, 0, 0, 0, 880.0, 880.0, true, '6.09 нужно 11 аудиогидов🙏🏻с 13 до 19', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Игорь Воронов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (253, client_id, 'Игорь Воронов', 'new', '07.09.2024', '09.09.2024', 3, 15, 0, 0, 0, 3120.0, 3120.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Нина Салькова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (252, client_id, 'Нина Салькова', 'new', '08.09.2024', '11.09.2024', 3, 52, 0, 0, 0, 16000.0, 16000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Михайловна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (251, client_id, 'Ирина Михайловна', 'new', '11.09.2024', '13.09.2024', 3, 24, 0, 0, 0, 5280.0, 5280.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (250, client_id, 'Камила Ягудина', 'new', '05.09.2024', '05.09.2024', 1, 11, 0, 0, 0, 800.0, 800.0, true, 'Заберут 10:00 вернут 13:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Игорь Воронов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (249, client_id, 'Игорь Воронов', 'new', '05.09.2024', '07.09.2024', 3, 15, 0, 0, 0, 3120.0, 3120.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (248, client_id, 'Юлианна', 'new', '06.09.2024', '07.09.2024', 2, 49, 0, 0, 0, 6580.0, 6580.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Евгения Заговорина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (247, client_id, 'Евгения Заговорина', 'new', '14.09.2024', '14.09.2024', 1, 250, 0, 0, 0, 22400.0, 22400.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (246, client_id, 'Мира (ИП)', 'new', '06.09.2024', '06.09.2024', 1, 41, 0, 0, 0, 2800.0, 2800.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (245, client_id, 'Мира (ИП)', 'new', '04.09.2024', '06.09.2024', 3, 31, 0, 0, 0, 6090.0, 6090.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (244, client_id, 'Мира (ИП)', 'new', '05.09.2024', '05.09.2024', 1, 31, 0, 0, 0, 2100.0, 2100.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Салькова Нина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (243, client_id, 'Салькова Нина', 'cancelled', '08.09.2024', '11.09.2024', 4, 50, 0, 0, 0, 0.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Рыжкова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (242, client_id, 'Наталья Рыжкова', 'new', '28.09.2024', '29.09.2024', 2, 31, 0, 0, 0, 4640.0, 4640.0, true, 'Лейла', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (241, client_id, 'Элина (Сититур)', 'new', '31.08.2024', '31.08.2024', 1, 46, 0, 0, 0, 3680.0, 3680.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (240, client_id, 'Артем Агафонов', 'new', '31.08.2024', '31.08.2024', 1, 36, 0, 0, 0, 2960.0, 2960.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (239, client_id, 'Гульнара', 'new', '25.08.2024', '25.08.2024', 1, 34, 0, 0, 0, 2640.0, 2640.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (238, client_id, 'Юлианна', 'new', '08.09.2024', '08.09.2024', 1, 45, 0, 0, 0, 3080.0, 3080.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (237, client_id, 'Юлианна', 'new', '10.09.2024', '14.09.2024', 5, 48, 0, 0, 0, 15750.0, 15750.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Автокруиз%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (236, client_id, 'Автокруиз', 'new', '24.08.2024', '24.08.2024', 1, 35, 0, 0, 0, 2720.0, 2720.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (235, client_id, 'Мария', 'new', '23.08.2024', '23.08.2024', 1, 44, 0, 0, 0, 6720.0, 6720.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Оксана%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (234, client_id, 'Оксана', 'new', '23.08.2024', '23.08.2024', 1, 12, 0, 0, 0, 880.0, 880.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (232, client_id, 'Эдик Заказы для групп', 'new', '02.09.2024', '02.09.2024', 1, 60, 0, 0, 0, 4640.0, 4640.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (231, client_id, 'Эдик Заказы для групп', 'new', '29.08.2024', '29.08.2024', 1, 60, 0, 0, 0, 4640.0, 4640.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (230, client_id, 'Эдик Заказы для групп', 'new', '06.10.2024', '10.10.2024', 5, 29, 0, 0, 0, 8640.0, 8640.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (229, client_id, 'Анюта Родионова (Родина-тур)', 'new', '18.08.2024', '18.08.2024', 1, 45, 0, 0, 0, 3520.0, 3520.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Клиент%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (228, client_id, 'Клиент', 'new', '26.09.2024', '29.09.2024', 3, 43, 0, 0, 0, 9840.0, 9840.0, true, 'У Натальи', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (227, client_id, 'Галия', 'cancelled', '05.10.2024', '06.10.2024', 2, 50, 0, 0, 0, 0.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей Вологда%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (226, client_id, 'Андрей Вологда', 'new', '23.08.2024', '24.08.2024', 2, 44, 0, 0, 0, 6720.0, 6720.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (225, client_id, 'Сергей', 'cancelled', '22.08.2024', '22.08.2024', 1, 22, 0, 0, 0, 3200.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (224, client_id, 'Мира (ИП)', 'new', '21.08.2024', '21.08.2024', 1, 25, 0, 0, 0, 1470.0, 1470.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (223, client_id, 'Зельфира', 'new', '21.08.2024', '22.08.2024', 2, 39, 0, 0, 0, 5920.0, 5920.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (222, client_id, 'Юлианна', 'new', '20.08.2024', '21.08.2024', 2, 51, 0, 0, 0, 6860.0, 6860.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камилла%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (221, client_id, 'Камилла', 'new', '16.08.2024', '16.08.2024', 1, 40, 0, 0, 0, 3040.0, 3040.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (220, client_id, 'Мария Экскурсовод', 'new', '16.08.2024', '17.08.2024', 2, 45, 0, 0, 0, 6880.0, 6880.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (219, client_id, 'Наталья', 'new', '17.08.2024', '17.08.2024', 1, 39, 0, 0, 0, 2960.0, 2960.0, true, 'В 11:30 в туган авылым', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульназ%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (218, client_id, 'Гульназ', 'new', '17.08.2024', '17.08.2024', 1, 22, 0, 0, 0, 1680.0, 1680.0, true, 'Болгар отель', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Клиент%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (217, client_id, 'Клиент', 'new', '06.09.2024', '06.09.2024', 1, 50, 0, 0, 0, 3200.0, 3200.0, true, 'Дата: 06.09.2024 Время: 13:00 Место начала экскурсии: Казань, ул. Толстого д. 14 Место окончания экскурсии: Казань, ул. Вишневского д. 21 Время окончания экскурсии: 17:00 Количество участников: ориентировочно 40 человек', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Минеева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (216, client_id, 'Алина Минеева', 'cancelled', '05.10.2024', '05.10.2024', 1, 50, 0, 0, 0, 3840.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Минеева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (215, client_id, 'Алина Минеева', 'new', '28.09.2024', '28.09.2024', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, 'Альбина Николаевна +79503160154', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Минеева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (214, client_id, 'Алина Минеева', 'new', '17.08.2024', '17.08.2024', 1, 57, 0, 0, 0, 4480.0, 4480.0, true, 'Ирина Совельва', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (213, client_id, 'Юлия Воронова', 'new', '17.08.2024', '17.08.2024', 1, 170, 0, 0, 0, 8160.0, 8160.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (212, client_id, 'Юлия Воронова', 'new', '15.08.2024', '17.08.2024', 3, 35, 0, 0, 0, 7680.0, 7680.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (211, client_id, 'Екатерина Кореева', 'new', '17.08.2024', '21.08.2024', 5, 52, 0, 0, 0, 19200.0, 19200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (210, client_id, 'Камила Ягудина', 'new', '19.08.2024', '19.08.2024', 1, 11, 0, 0, 0, 800.0, 800.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (208, client_id, 'Зельфира', 'new', '14.08.2024', '15.08.2024', 2, 32, 0, 0, 0, 4800.0, 4800.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (207, client_id, 'Юлианна', 'new', '13.08.2024', '14.08.2024', 2, 49, 0, 0, 0, 6580.0, 6580.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (206, client_id, 'Мария Экскурсовод', 'new', '09.08.2024', '10.08.2024', 2, 36, 0, 0, 0, 5440.0, 5440.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (205, client_id, 'Гульнара', 'new', '10.08.2024', '12.08.2024', 3, 50, 0, 0, 0, 7680.0, 7680.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (204, client_id, 'Гульнара', 'new', '09.08.2024', '11.08.2024', 3, 47, 0, 0, 0, 10800.0, 10800.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алёна Лазука%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (203, client_id, 'Алёна Лазука', 'new', '09.08.2024', '09.08.2024', 1, 17, 0, 0, 0, 1280.0, 1280.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Автокруиз%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (202, client_id, 'Автокруиз', 'new', '10.08.2024', '10.08.2024', 1, 0, 0, 0, 0, 880.0, 880.0, true, 'С 9 до 13 Количество скажут впритык', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (201, client_id, 'Зельфира', 'new', '09.08.2024', '09.08.2024', 1, 14, 0, 0, 0, 1040.0, 1040.0, true, 'Заберет сама в районе 15:00', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Рыжкова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (200, client_id, 'Наталья Рыжкова', 'new', '17.08.2024', '17.08.2024', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лиля Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (199, client_id, 'Лиля Экскурсовод', 'new', '03.08.2024', '04.08.2024', 2, 11, 0, 0, 0, 1760.0, 1760.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (198, client_id, 'Татьяна (Гольфстрим)', 'new', '30.08.2024', '31.08.2024', 2, 48, 0, 0, 0, 7360.0, 7360.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (197, client_id, 'Татьяна (Гольфстрим)', 'new', '28.08.2024', '29.08.2024', 2, 30, 0, 0, 0, 4480.0, 4480.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (196, client_id, 'Татьяна (Гольфстрим)', 'new', '06.08.2024', '07.08.2024', 2, 43, 0, 0, 0, 6560.0, 6560.0, true, 'Карат', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (195, client_id, 'Сергей', 'cancelled', '11.08.2024', '12.08.2024', 2, 33, 0, 0, 0, 4960.0, 0, false, 'Азалия', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь Ким%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (194, client_id, 'Любовь Ким', 'new', '13.08.2024', '13.08.2024', 1, 0, 0, 0, 0, 2400.0, 2400.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (193, client_id, 'Мария Экскурсовод', 'new', '02.08.2024', '03.08.2024', 2, 20, 0, 0, 0, 2880.0, 2880.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (192, client_id, 'Андрей (Экскурс)', 'new', '02.08.2024', '02.08.2024', 1, 40, 0, 0, 0, 3040.0, 3040.0, true, 'Гранд отель', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Автокруиз%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (191, client_id, 'Автокруиз', 'new', '03.08.2024', '03.08.2024', 1, 47, 0, 0, 0, 3680.0, 3680.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (190, client_id, 'Юлианна', 'new', '02.08.2024', '03.08.2024', 2, 48, 0, 0, 0, 6440.0, 6440.0, true, 'Живут в Волге', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (189, client_id, 'Юлианна', 'new', '03.08.2024', '06.08.2024', 4, 34, 0, 0, 0, 8680.0, 8680.0, true, 'Давыдов ИНН', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина Тур Москва%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (188, client_id, 'Галина Тур Москва', 'new', '09.08.2024', '11.08.2024', 2, 42, 0, 0, 0, 6400.0, 6400.0, true, 'Используют 9 и 11 оплата по счёту,', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (187, client_id, 'Зельфира', 'new', '02.08.2024', '04.08.2024', 3, 42, 0, 0, 0, 8880.0, 8880.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (186, client_id, 'Зельфира', 'new', '31.07.2024', '01.08.2024', 2, 33, 0, 0, 0, 4960.0, 4960.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Снежана%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (185, client_id, 'Снежана', 'new', '27.07.2024', '27.07.2024', 1, 41, 0, 0, 0, 3200.0, 3200.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Автокруиз%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (184, client_id, 'Автокруиз', 'new', '27.07.2024', '28.07.2024', 2, 29, 0, 0, 0, 4320.0, 4320.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лиля Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (183, client_id, 'Лиля Экскурсовод', 'new', '25.07.2024', '25.07.2024', 1, 10, 0, 0, 0, 800.0, 800.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (182, client_id, 'Мария Экскурсовод', 'new', '26.07.2024', '27.07.2024', 2, 20, 0, 0, 0, 2880.0, 2880.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (181, client_id, 'Татьяна Чуб', 'new', '29.08.2024', '29.08.2024', 1, 29, 0, 0, 0, 2240.0, 2240.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей Вологда%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (180, client_id, 'Андрей Вологда', 'new', '02.08.2024', '03.08.2024', 2, 44, 0, 0, 0, 6720.0, 6720.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (179, client_id, 'Гульнара', 'new', '26.07.2024', '28.07.2024', 3, 47, 0, 0, 0, 13300.0, 13300.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (178, client_id, 'Наталья', 'new', '27.07.2024', '27.07.2024', 1, 47, 0, 0, 0, 3600.0, 3600.0, true, 'Туган авылым', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (177, client_id, 'Галия', 'new', '07.08.2024', '08.08.2024', 2, 22, 0, 0, 0, 3200.0, 3200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (176, client_id, 'Анюта Родионова (Родина-тур)', 'new', '27.07.2024', '27.07.2024', 1, 50, 0, 0, 0, 6720.0, 6720.0, true, 'Отель Гагарин', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (175, client_id, 'Элина (Сититур)', 'new', '09.08.2024', '11.08.2024', 2, 51, 0, 0, 0, 11760.0, 11760.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульфия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (174, client_id, 'Гульфия', 'new', '26.07.2024', '27.07.2024', 2, 46, 0, 0, 0, 11040.0, 11040.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (173, client_id, 'Юлианна', 'new', '23.07.2024', '24.07.2024', 2, 40, 0, 0, 0, 5320.0, 5320.0, true, 'Волга', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лиля Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (172, client_id, 'Лиля Экскурсовод', 'new', '21.07.2024', '21.07.2024', 1, 10, 0, 0, 0, 800.0, 800.0, true, 'Без сумки', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (171, client_id, 'Татьяна (Гольфстрим)', 'new', '24.07.2024', '27.07.2024', 4, 46, 0, 0, 0, 14080.0, 14080.0, true, 'Леонид нам надо будет на 24-27 июня 44 радиогида гид. Владимир Николаевич 89178858409 в отель Давыдов на Назарбаева к 9.30 Записка "для В.Н."', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (170, client_id, 'Татьяна (Гольфстрим)', 'new', '19.07.2024', '21.07.2024', 3, 42, 0, 0, 0, 9600.0, 9600.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (169, client_id, 'Мария Экскурсовод', 'new', '19.07.2024', '20.07.2024', 2, 41, 0, 0, 0, 6240.0, 6240.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (168, client_id, 'Гульнара', 'new', '19.07.2024', '21.07.2024', 3, 46, 0, 0, 0, 10560.0, 10560.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (167, client_id, 'Зельфира', 'new', '17.07.2024', '18.07.2024', 2, 49, 0, 0, 0, 7520.0, 7520.0, true, 'Регина на Баумана', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Светлана%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (166, client_id, 'Светлана', 'new', '20.07.2024', '20.07.2024', 1, 300, 0, 0, 0, 24000.0, 24000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Яна Янова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (165, client_id, 'Яна Янова', 'new', '12.07.2024', '12.07.2024', 1, 20, 0, 0, 0, 0.0, 0.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (164, client_id, 'Мария Экскурсовод', 'new', '13.07.2024', '14.07.2024', 2, 19, 0, 0, 0, 2720.0, 2720.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульфия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (163, client_id, 'Гульфия', 'new', '12.07.2024', '13.07.2024', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Светлана%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (162, client_id, 'Светлана', 'new', '14.07.2024', '14.07.2024', 1, 300, 0, 0, 0, 24000.0, 24000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (161, client_id, 'Екатерина', 'new', '09.07.2024', '10.07.2024', 2, 27, 0, 0, 0, 4160.0, 4160.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Рамис%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (160, client_id, 'Рамис', 'new', '08.07.2024', '08.07.2024', 1, 2, 0, 0, 0, 160.0, 160.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Яна Янова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (159, client_id, 'Яна Янова', 'new', '07.07.2024', '07.07.2024', 1, 15, 0, 0, 0, 1712.0, 1712.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена Игнатьева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (158, client_id, 'Елена Игнатьева', 'new', '10.09.2024', '11.09.2024', 2, 39, 0, 0, 0, 5920.0, 5920.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (157, client_id, 'Елена Экскурсовод', 'new', '10.07.2024', '10.07.2024', 1, 11, 0, 0, 0, 800.0, 800.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (156, client_id, 'Юлия Воронова', 'new', '07.07.2024', '09.07.2024', 2, 8, 0, 0, 0, 1200.0, 1200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (155, client_id, 'Мира (ИП)', 'new', '19.07.2024', '21.07.2024', 3, 49, 0, 0, 0, 9870.0, 9870.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (154, client_id, 'Эдик Заказы для групп', 'new', '23.09.2024', '26.09.2024', 4, 51, 0, 0, 0, 15680.0, 15680.0, true, 'Настя будет', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Сафина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (153, client_id, 'Алина Сафина', 'new', '06.07.2024', '06.07.2024', 1, 42, 0, 0, 0, 3200.0, 3200.0, true, 'Улица Баумана, 15. Хостел на Баумана', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наргиз%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (152, client_id, 'Наргиз', 'new', '06.07.2024', '07.07.2024', 2, 44, 0, 0, 0, 6400.0, 6400.0, true, 'Кристал', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Светлана%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (151, client_id, 'Светлана', 'new', '08.07.2024', '08.07.2024', 1, 300, 0, 0, 0, 24000.0, 24000.0, true, 'Ит парк Рамеева. 14:30..14:40 примерно', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (150, client_id, 'Татьяна (Гольфстрим)', 'new', '06.07.2024', '08.07.2024', 3, 57, 0, 0, 0, 13200.0, 13200.0, true, 'Давыдов на Назарбаева к 8.30. На 3 дня. Сдадут 8.07 с 14-15 в Ресторанном дворе. Гид Диана. 89274454525', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей Вологда%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (149, client_id, 'Андрей Вологда', 'new', '05.07.2024', '06.07.2024', 2, 41, 0, 0, 0, 6240.0, 6240.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (148, client_id, 'Мария Экскурсовод', 'new', '05.07.2024', '06.07.2024', 2, 37, 0, 0, 0, 5600.0, 5600.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Клиент%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (147, client_id, 'Клиент', 'new', '21.07.2024', '21.07.2024', 1, 110, 0, 0, 0, 7700.0, 7700.0, true, 'Позвонить 19.07', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ксения%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (146, client_id, 'Ксения', 'new', '04.07.2024', '04.07.2024', 1, 55, 0, 0, 0, 4240.0, 4240.0, true, 'Релита', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (145, client_id, 'Юлианна', 'new', '05.07.2024', '06.07.2024', 2, 46, 0, 0, 0, 6160.0, 6160.0, true, 'В Волгу 04, вечером', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%София%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (144, client_id, 'София', 'new', '03.07.2024', '03.07.2024', 1, 39, 0, 0, 0, 3040.0, 3040.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (143, client_id, 'Сергей', 'new', '07.07.2024', '07.07.2024', 1, 31, 0, 0, 0, 2400.0, 2400.0, true, 'Азалия', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Яна Янова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (142, client_id, 'Яна Янова', 'new', '30.06.2024', '30.06.2024', 1, 15, 0, 0, 0, 20640.0, 20640.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (140, client_id, 'Юлия Воронова', 'new', '30.06.2024', '02.07.2024', 3, 26, 0, 0, 0, 5760.0, 5760.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Яна Янова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (139, client_id, 'Яна Янова', 'new', '28.06.2024', '29.06.2024', 1, 20, 0, 0, 0, 2400.0, 2400.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (138, client_id, 'Татьяна (Гольфстрим)', 'new', '28.06.2024', '30.06.2024', 3, 42, 0, 0, 0, 9600.0, 9600.0, true, 'Завтра к 8.30 в Лимончелло 40 шт. На 3 дня. Оставят в Кристалле. Гид Яна +7 952 034-45-43', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (137, client_id, 'Наталья', 'new', '24.09.2024', '24.09.2024', 1, 50, 0, 0, 0, 3840.0, 3840.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (136, client_id, 'Мария Экскурсовод', 'new', '28.06.2024', '29.06.2024', 2, 46, 0, 0, 0, 7040.0, 7040.0, true, 'Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (135, client_id, 'Анюта Родионова (Родина-тур)', 'new', '29.06.2024', '29.06.2024', 1, 22, 0, 0, 0, 1680.0, 1680.0, true, 'Новинка', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (134, client_id, 'Андрей (Экскурс)', 'new', '27.06.2024', '29.06.2024', 3, 6, 0, 0, 0, 1200.0, 1200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зуфар(Аграрный Университет)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (133, client_id, 'Зуфар(Аграрный Университет)', 'cancelled', '10.07.2024', '10.07.2024', 1, 100, 0, 0, 0, 8000.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алсу%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (132, client_id, 'Алсу', 'cancelled', '29.06.2024', '30.06.2024', 2, 26, 0, 0, 0, 3840.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Сафина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (131, client_id, 'Алина Сафина', 'new', '27.06.2024', '27.06.2024', 1, 32, 0, 0, 0, 2720.0, 2720.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Яна Янова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (130, client_id, 'Яна Янова', 'new', '25.06.2024', '25.06.2024', 1, 0, 0, 0, 0, 1209.0, 1209.0, true, '15', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (129, client_id, 'Сергей (Авангард)', 'new', '29.06.2024', '30.06.2024', 2, 26, 0, 0, 0, 3360.0, 3360.0, true, '29.06 в 10.00 Аэропорт и вернут 30.06 в 19.30 Аэропорт - 24 наушника - +7 960 036-25-22 алсу', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (128, client_id, 'Наталья', 'new', '28.06.2024', '28.06.2024', 1, 46, 0, 0, 0, 3600.0, 3600.0, true, 'Отель Европа завезти 27 вечером. Забрать там же', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Яна Янова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (127, client_id, 'Яна Янова', 'new', '23.06.2024', '23.06.2024', 1, 14, 0, 0, 0, 1200.0, 1200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (126, client_id, 'Зельфира', 'new', '22.06.2024', '22.06.2024', 1, 43, 0, 0, 0, 3360.0, 3360.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Сафина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (125, client_id, 'Алина Сафина', 'new', '22.06.2024', '22.06.2024', 1, 51, 0, 0, 0, 4000.0, 4000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Данил (Антей Групп)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (124, client_id, 'Данил (Антей Групп)', 'new', '25.06.2024', '26.06.2024', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, 'Двойной комплект наушников', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Марат Даутов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (123, client_id, 'Марат Даутов', 'new', '22.06.2024', '22.06.2024', 1, 58, 0, 0, 0, 4480.0, 4480.0, true, 'Заберет 21.06, вернет 23.06', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульфия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (122, client_id, 'Гульфия', 'new', '21.06.2024', '22.06.2024', 2, 38, 0, 0, 0, 5760.0, 5760.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Рамис%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (121, client_id, 'Рамис', 'cancelled', '22.06.2024', '22.06.2024', 1, 49, 0, 0, 0, 14400.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Рамис%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (120, client_id, 'Рамис', 'new', '21.06.2024', '22.06.2024', 2, 62, 0, 0, 0, 10880.0, 10880.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (119, client_id, 'Мира (ИП)', 'new', '29.06.2024', '29.06.2024', 1, 50, 0, 0, 0, 3360.0, 3360.0, true, 'Шаляпина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (118, client_id, 'Гульнара', 'new', '21.06.2024', '23.06.2024', 3, 36, 0, 0, 0, 8160.0, 8160.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (117, client_id, 'Галия', 'new', '06.07.2024', '06.07.2024', 1, 42, 0, 0, 0, 3200.0, 3200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (116, client_id, 'Зельфира', 'new', '19.06.2024', '20.06.2024', 2, 34, 0, 0, 0, 5120.0, 5120.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (115, client_id, 'Артем Агафонов', 'new', '29.06.2024', '29.06.2024', 1, 36, 0, 0, 0, 2800.0, 2800.0, true, '29 июня с 12:00 (привезти к театру Кукол) до 23:00 (оставим в гостинице Татарстан на ваше имя и телефон)', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (114, client_id, 'Сергей (Авангард)', 'new', '29.06.2024', '30.06.2024', 2, 59, 0, 0, 0, 7700.0, 7700.0, true, '29.06 в 10.30 Казань - 1 и вернут 30.06 в 17.00 казань 1 - Гид: +7 987 296-95-42. 29 шт. Елена + +7 927 243-37-92 Ангелина - 26 шт.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (113, client_id, 'Юлия Воронова', 'new', '17.06.2024', '17.06.2024', 1, 34, 0, 0, 0, 2640.0, 2640.0, true, 'В фургончике забрать', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (112, client_id, 'Татьяна (Гольфстрим)', 'new', '14.05.2024', '17.05.2024', 4, 0, 0, 0, 0, 12480.0, 12480.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (111, client_id, 'Татьяна (Гольфстрим)', 'new', '09.05.2024', '11.05.2024', 3, 0, 0, 0, 0, 11280.0, 11280.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (110, client_id, 'Татьяна (Гольфстрим)', 'new', '09.05.2024', '10.05.2024', 2, 0, 0, 0, 0, 7520.0, 7520.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (109, client_id, 'Татьяна (Гольфстрим)', 'new', '07.05.2024', '09.05.2024', 3, 0, 0, 0, 0, 15360.0, 15360.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (108, client_id, 'Татьяна (Гольфстрим)', 'new', '07.05.2024', '07.05.2024', 1, 0, 0, 0, 0, 5360.0, 5360.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (107, client_id, 'Татьяна (Гольфстрим)', 'new', '05.05.2024', '07.05.2024', 3, 0, 0, 0, 0, 12240.0, 12240.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (106, client_id, 'Мария Экскурсовод', 'new', '15.06.2024', '16.06.2024', 2, 46, 0, 0, 0, 7040.0, 7040.0, true, 'Забрать в кристалле', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Динар (ТатКабель)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (105, client_id, 'Динар (ТатКабель)', 'new', '25.06.2024', '25.06.2024', 1, 51, 0, 0, 0, 3200.0, 3200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульфия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (104, client_id, 'Гульфия', 'new', '14.06.2024', '15.06.2024', 2, 47, 0, 0, 0, 7200.0, 7200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульфия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (103, client_id, 'Гульфия', 'new', '14.06.2024', '15.06.2024', 2, 26, 0, 0, 0, 3840.0, 3840.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей Вологда%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (102, client_id, 'Андрей Вологда', 'new', '14.06.2024', '16.06.2024', 3, 24, 0, 0, 0, 5280.0, 5280.0, true, 'На 14-16.06 (3 дня) нужны радиогиды на 22 чел. Подвезти нужно 14.06 к 8.30 Давыдов ИНН (К.Маркса, 42).', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ильмира%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (101, client_id, 'Ильмира', 'new', '08.06.2024', '08.06.2024', 1, 13, 0, 0, 0, 960.0, 960.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (100, client_id, 'Эдик Заказы для групп', 'new', '08.06.2024', '11.06.2024', 4, 40, 0, 0, 0, 0.0, 0.0, true, 'Живут в корстане. Гид Настя', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эмилия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (99, client_id, 'Эмилия', 'cancelled', '11.06.2024', '14.06.2024', 4, 38, 0, 0, 0, 11520.0, 0, false, 'Уточнить', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (98, client_id, 'Юлианна', 'new', '10.06.2024', '10.06.2024', 1, 47, 0, 0, 0, 3220.0, 3220.0, true, 'Самовывоз', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (97, client_id, 'Сергей (Авангард)', 'new', '08.06.2024', '09.06.2024', 2, 33, 0, 0, 0, 4340.0, 4340.0, true, '8.06 в 5.27 прибывают Казань 2 и 9.06 в 17.00 привозим группу Казань 1 - Гид: +7 905 316-29-73 Елена - 31 радиогид - деньги передаст на месте', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Обыденникова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (96, client_id, 'Ирина Обыденникова', 'new', '25.06.2024', '26.06.2024', 2, 62, 0, 0, 0, 9100.0, 9100.0, true, 'Ривьера', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена (Магазин Путешествий)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (95, client_id, 'Елена (Магазин Путешествий)', 'new', '07.06.2024', '09.06.2024', 3, 50, 0, 0, 0, 11520.0, 11520.0, true, 'Оставить 6 в отеле Давыдов, там же забрать', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (94, client_id, 'Татьяна (Гольфстрим)', 'new', '22.06.2024', '23.06.2024', 2, 44, 0, 0, 0, 6720.0, 6720.0, true, '22.06 гид Владимир+7 917 885-84-09 оставить ему в Медине, Татарстан, 7 в 14.00 42 радиогила. Вернёт он же в 16.00 на рецепшн в Кристалл', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (93, client_id, 'Татьяна (Гольфстрим)', 'cancelled', '18.06.2024', '19.06.2024', 2, 28, 0, 0, 0, 4160.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (92, client_id, 'Татьяна (Гольфстрим)', 'new', '15.06.2024', '16.06.2024', 2, 28, 0, 0, 0, 4160.0, 4160.0, true, 'На 15-16 надо 26 радио гидов. Заберёт Марсель +7 904 762-46-40 лимончелло к 9.00. Сдаст 16 июня Никита в 19.00 в рфис. Оставили в кристале', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (91, client_id, 'Татьяна (Гольфстрим)', 'new', '11.06.2024', '13.06.2024', 3, 26, 0, 0, 0, 5760.0, 5760.0, true, '11-13 июня 24 шт. возьмет Диана 89274454525 в 15.30 в нац музее..сдаст Ирина 89046620732 в Туган Авлым с 18-19часов.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (90, client_id, 'Татьяна (Гольфстрим)', 'new', '11.06.2024', '12.06.2024', 2, 37, 0, 0, 0, 5600.0, 5600.0, true, '11-12 июня 35 радиогидов.Наш гид Ольга 89503140361 оставить в кафе Лимончелло в 9.00 сдаст на Баумана Вам в офис примерно в 17.30-18.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (89, client_id, 'Татьяна (Гольфстрим)', 'new', '04.06.2024', '06.06.2024', 2, 33, 0, 0, 0, 4960.0, 4960.0, true, 'Завезти в отель Венера. Вернут в Кристал. Марина. +7 917 252-69-93', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга Лукоянова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (88, client_id, 'Ольга Лукоянова', 'new', '04.06.2024', '04.06.2024', 1, 19, 0, 0, 0, 1440.0, 1440.0, true, 'Калинина 60', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (87, client_id, 'Мира (ИП)', 'new', '04.06.2024', '04.06.2024', 1, 56, 0, 0, 0, 3850.0, 3850.0, true, 'Регина на Питербуржской', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (86, client_id, 'Наталья', 'new', '03.06.2024', '04.06.2024', 2, 22, 0, 0, 0, 3200.0, 3200.0, true, 'Азалия. На имя Наталья', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (85, client_id, 'Инна Экскурсовод', 'new', '07.06.2024', '07.06.2024', 1, 44, 0, 0, 0, 3440.0, 3440.0, true, 'На 7.06 43 шт Либо я вечером 6-го заберу, либо нужно привезти 7 июня на Северный вокзал к 7.48', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (84, client_id, 'Татьяна (Гольфстрим)', 'new', '02.06.2024', '03.06.2024', 2, 29, 0, 0, 0, 4320.0, 4320.0, true, '+7 917 270-83-69. гид Татьяна Александровна Давыдов Инн на Карла Маркса. На 2 дня 27 человек. Вернут в хаял в 15.00', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульфия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (83, client_id, 'Гульфия', 'new', '01.06.2024', '01.06.2024', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, 'Заберет в 8:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (82, client_id, 'Мира (ИП)', 'new', '05.06.2024', '05.06.2024', 1, 46, 0, 0, 0, 3150.0, 3150.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (81, client_id, 'Гульнара', 'new', '01.06.2024', '02.06.2024', 2, 47, 0, 0, 0, 7360.0, 7360.0, true, 'Оставить в Арон', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Обыденникова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (80, client_id, 'Ирина Обыденникова', 'new', '06.07.2024', '06.07.2024', 1, 47, 0, 0, 0, 3680.0, 3680.0, true, 'Утром в 8:00 у Кремля', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алёна Лазука%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (79, client_id, 'Алёна Лазука', 'new', '01.06.2024', '02.06.2024', 2, 53, 0, 0, 0, 8160.0, 8160.0, true, 'После 14:00 позвонить Алене, в нагай', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (78, client_id, 'Екатерина', 'new', '30.05.2024', '31.05.2024', 1, 66, 0, 0, 0, 7600.0, 7600.0, true, 'Забрать из Шаляпина', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (77, client_id, 'Екатерина', 'cancelled', '29.05.2024', '29.05.2024', 1, 12, 0, 0, 0, 880.0, 0, false, 'Заберет сама', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (76, client_id, 'Екатерина Кореева', 'new', '31.05.2024', '31.05.2024', 1, 12, 0, 0, 0, 880.0, 880.0, true, 'В обед 13:00 у аптеки', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (75, client_id, 'Сергей (Авангард)', 'new', '01.06.2024', '02.06.2024', 2, 42, 0, 0, 0, 5460.0, 5460.0, true, '1.06 в 5.27 прибывают Казань 2 и 2.06 в 17.00 привозим группу Казань 1 - Гид: +7 927 243-37-92 Ангелина - деньги передаст на месте', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (74, client_id, 'Татьяна (Гольфстрим)', 'new', '28.05.2024', '30.05.2024', 2, 24, 0, 0, 0, 3520.0, 3520.0, true, '22 чел к 14 в Ресторанный двор гид Марина +7 917 252-69-93. На 28 и 30. Сдаст в Кристалл.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (73, client_id, 'Андрей (Экскурс)', 'new', '29.05.2024', '29.05.2024', 1, 48, 0, 0, 0, 1880.0, 1880.0, true, 'Лазука', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елизавета Ткач%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (72, client_id, 'Елизавета Ткач', 'new', '27.05.2024', '27.05.2024', 1, 52, 0, 0, 0, 4000.0, 4000.0, true, 'Сама заберет', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Рыжкова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (71, client_id, 'Наталья Рыжкова', 'new', '01.07.2024', '02.07.2024', 2, 34, 0, 0, 0, 5120.0, 5120.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Нечаева Тамара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (70, client_id, 'Нечаева Тамара', 'new', '26.05.2024', '28.05.2024', 3, 50, 0, 0, 0, 11280.0, 11280.0, true, 'Живут в Волге. Группа из донецка', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей Вологда%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (69, client_id, 'Андрей Вологда', 'cancelled', '14.07.2024', '15.07.2024', 2, 0, 0, 0, 0, 0.0, 0, false, 'Уточнить по количеству', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зеленина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (68, client_id, 'Зеленина', 'new', '29.07.2024', '31.07.2024', 3, 44, 0, 0, 0, 10080.0, 10080.0, true, 'Татарстан вечером 28 числа', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (67, client_id, 'Мария', 'cancelled', '05.07.2024', '06.07.2024', 2, 51, 0, 0, 0, 5600.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (66, client_id, 'Мария', 'cancelled', '24.08.2024', '25.08.2024', 2, 51, 0, 0, 0, 8000.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (65, client_id, 'Мария', 'new', '16.07.2024', '17.07.2024', 2, 52, 0, 0, 0, 8000.0, 8000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (КБПИЭ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (64, client_id, 'Татьяна (КБПИЭ)', 'cancelled', '25.06.2024', '26.06.2024', 2, 47, 0, 0, 0, 7200.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (63, client_id, 'Мира (ИП)', 'new', '15.06.2024', '15.06.2024', 1, 36, 0, 0, 0, 2450.0, 2450.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (62, client_id, 'Мира (ИП)', 'new', '13.05.2024', '13.05.2024', 1, 31, 0, 0, 0, 2100.0, 2100.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (61, client_id, 'Альберт (КТ)', 'new', '11.05.2024', '13.05.2024', 3, 51, 0, 0, 0, 10290.0, 10290.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (КБПИЭ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (60, client_id, 'Татьяна (КБПИЭ)', 'new', '10.05.2024', '11.05.2024', 2, 46, 0, 0, 0, 7040.0, 7040.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (59, client_id, 'Мира (ИП)', 'new', '10.05.2024', '11.05.2024', 2, 19, 0, 0, 0, 2100.0, 2100.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (58, client_id, 'Галина', 'new', '07.05.2024', '09.05.2024', 3, 38, 0, 0, 0, 7560.0, 7560.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (57, client_id, 'Галина', 'new', '01.05.2024', '03.05.2024', 3, 38, 0, 0, 0, 7560.0, 7560.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (56, client_id, 'Галина', 'new', '01.05.2024', '03.05.2024', 3, 39, 0, 0, 0, 7770.0, 7770.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (55, client_id, 'Сергей (Авангард)', 'new', '10.04.2024', '12.04.2024', 3, 40, 0, 0, 0, 7980.0, 7980.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (КБПИЭ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (54, client_id, 'Татьяна (КБПИЭ)', 'new', '26.04.2024', '26.04.2024', 1, 21, 0, 0, 0, 1600.0, 1600.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (КБПИЭ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (53, client_id, 'Татьяна (КБПИЭ)', 'new', '26.04.2024', '26.04.2024', 1, 62, 0, 0, 0, 5600.0, 5600.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (КБПИЭ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (52, client_id, 'Татьяна (КБПИЭ)', 'new', '25.04.2024', '25.04.2024', 1, 102, 0, 0, 0, 8000.0, 8000.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (51, client_id, 'Андрей (Экскурс)', 'new', '16.04.2024', '17.04.2024', 2, 18, 0, 0, 0, 2560.0, 2560.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (КБПИЭ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (50, client_id, 'Татьяна (КБПИЭ)', 'new', '12.04.2024', '12.04.2024', 1, 21, 0, 0, 0, 1600.0, 1600.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Светлана Клиент%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (49, client_id, 'Светлана Клиент', 'new', '26.05.2024', '28.05.2024', 3, 31, 0, 0, 0, 5000.0, 5000.0, true, 'Легче мы приезжаем 26 мая в11 часов нас 29 + Гид ты сказал за5000 сделаешь буду благодарна выезд 28 мая. Экскурсовод Дина +7 919 699-29-68', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (48, client_id, 'Татьяна (Гольфстрим)', 'new', '26.05.2024', '26.05.2024', 1, 27, 0, 0, 0, 2080.0, 2080.0, true, '26 мая отель Давыдов Инн на К. Маркса 9.45 до 17 ч. Гид Дания. +7 917 290-44-15 надо26 шт. Забирать там же в этот же день', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (47, client_id, 'Мира (ИП)', 'new', '24.05.2024', '24.05.2024', 1, 41, 0, 0, 0, 2800.0, 2800.0, true, 'Начало в 16:00. Улица Карла Маркса, 11а. Кarl House', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (46, client_id, 'Альберт (КТ)', 'new', '25.05.2024', '25.05.2024', 1, 53, 0, 0, 0, 3640.0, 3640.0, true, 'Завтракают в Волге . Для Екатерины +7 927 430‑72‑44. Забрать Гостиница Болгар', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (45, client_id, 'Галия', 'new', '05.10.2024', '06.10.2024', 2, 49, 0, 0, 0, 7520.0, 7520.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (44, client_id, 'Андрей (Экскурс)', 'cancelled', '05.06.2024', '06.06.2024', 2, 31, 0, 0, 0, 4640.0, 0, false, 'В Сулейман', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (43, client_id, 'Галина', 'cancelled', '14.06.2024', '16.06.2024', 3, 42, 0, 0, 0, 9600.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Тамара%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (42, client_id, 'Тамара', 'cancelled', '27.07.2024', '27.07.2024', 1, 47, 0, 0, 0, 3680.0, 0, false, 'Добрый день, Леонид, заказ на 27 июля на 46 человек,группа из Пензы. Экскурсовод Татьяна т.89063271840 и 89503287480.', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга Лукоянова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (41, client_id, 'Ольга Лукоянова', 'new', '29.05.2024', '30.05.2024', 2, 31, 0, 0, 0, 4800.0, 4800.0, true, 'Забрать в Татаринн на Марджани', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (40, client_id, 'Андрей (Экскурс)', 'new', '23.05.2024', '23.05.2024', 1, 26, 0, 0, 0, 2000.0, 2000.0, true, 'До 11:00 КНИИТУ (К.Маркса, 68) Просим передать Ирине Дубровской: +7 927 403 99 95. Забрать из офиса Экскурс в обед', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (КБПИЭ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (39, client_id, 'Татьяна (КБПИЭ)', 'new', '22.05.2024', '23.05.2024', 2, 40, 0, 0, 0, 5920.0, 5920.0, true, 'Забрать в Мано', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (КБПИЭ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (38, client_id, 'Татьяна (КБПИЭ)', 'new', '26.05.2024', '26.05.2024', 1, 23, 0, 0, 0, 1760.0, 1760.0, true, '26 мая 22 чел в 11.30 Оставить в кристалле. Для Екатерины. Забрать в татарской усадьбе', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (37, client_id, 'Татьяна (Гольфстрим)', 'new', '30.04.2024', '01.05.2024', 2, 0, 0, 0, 0, 6560.0, 6560.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (36, client_id, 'Татьяна (Гольфстрим)', 'cancelled', '30.04.2024', '30.04.2024', 1, 0, 0, 0, 0, 3280.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (35, client_id, 'Татьяна (Гольфстрим)', 'new', '28.04.2024', '29.04.2024', 2, 0, 0, 0, 0, 4480.0, 4480.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (34, client_id, 'Татьяна (Гольфстрим)', 'new', '28.04.2024', '29.04.2024', 2, 0, 0, 0, 0, 5280.0, 5280.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (33, client_id, 'Татьяна (Гольфстрим)', 'new', '28.04.2024', '28.04.2024', 1, 0, 0, 0, 0, 2160.0, 2160.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (32, client_id, 'Татьяна (Гольфстрим)', 'new', '27.04.2024', '27.04.2024', 1, 0, 0, 0, 0, 1840.0, 1840.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (31, client_id, 'Татьяна (Гольфстрим)', 'new', '22.04.2024', '23.04.2024', 2, 0, 0, 0, 0, 3520.0, 3520.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (30, client_id, 'Татьяна (Гольфстрим)', 'new', '21.04.2024', '22.04.2024', 2, 0, 0, 0, 0, 3680.0, 3680.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (29, client_id, 'Татьяна (Гольфстрим)', 'new', '20.04.2024', '20.04.2024', 1, 0, 0, 0, 0, 1200.0, 1200.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (28, client_id, 'Татьяна (Гольфстрим)', 'new', '18.04.2024', '18.04.2024', 1, 0, 0, 0, 0, 3760.0, 3760.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (27, client_id, 'Татьяна (Гольфстрим)', 'new', '17.04.2024', '18.04.2024', 2, 0, 0, 0, 0, 7360.0, 7360.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (26, client_id, 'Татьяна (Гольфстрим)', 'new', '09.04.2024', '09.04.2024', 1, 0, 0, 0, 0, 2480.0, 2480.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (25, client_id, 'Татьяна (Гольфстрим)', 'new', '09.04.2024', '11.05.2024', 3, 0, 0, 0, 0, 11280.0, 11280.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (24, client_id, 'Татьяна (Гольфстрим)', 'new', '07.04.2024', '09.04.2024', 3, 0, 0, 0, 0, 8880.0, 8880.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (23, client_id, 'Татьяна (Гольфстрим)', 'new', '05.04.2024', '06.04.2024', 2, 0, 0, 0, 0, 5920.0, 5920.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (22, client_id, 'Элина (Сититур)', 'new', '24.05.2024', '24.05.2024', 1, 62, 0, 0, 0, 4800.0, 4800.0, true, 'Группа 60 чел в свияжск делиться на 2 группы. Положить 2 передатчика. Отправить видео по настройке', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (19, client_id, 'Татьяна (Гольфстрим)', 'new', '17.05.2024', '19.05.2024', 3, 45, 0, 0, 0, 10320.0, 10320.0, true, '-', stas_id, stas_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (18, client_id, 'Юлия Воронова', 'new', '24.05.2024', '26.05.2024', 3, 44, 0, 0, 0, 14080.0, 14080.0, true, 'Сами', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена Игнатьева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (17, client_id, 'Елена Игнатьева', 'new', '28.06.2024', '30.06.2024', 3, 28, 0, 0, 0, 6240.0, 6240.0, true, 'Кристал. Забрать дом чая 30 числа в 15:30', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (16, client_id, 'Татьяна Чуб', 'new', '27.05.2024', '29.05.2024', 3, 46, 0, 0, 0, 6880.0, 6880.0, true, 'Оставили в кристале', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Батяева%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (15, client_id, 'Мария Батяева', 'new', '24.05.2024', '26.05.2024', 3, 48, 0, 0, 0, 11040.0, 11040.0, true, '8:30 гостиница Татарстан. +7 960 036‑74‑49', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Сафина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (14, client_id, 'Алина Сафина', 'new', '20.05.2024', '20.05.2024', 1, 42, 0, 0, 0, 3280.0, 3280.0, true, 'в 11:40 отель Наган', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (13, client_id, 'Татьяна (Гольфстрим)', 'new', '31.05.2024', '31.05.2024', 1, 33, 0, 0, 0, 2560.0, 2560.0, true, '31 мая отель Легенда к 8.00 до 17.00 оставят там же . 32 шт гид Ирина +7 904 662-07-32', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (12, client_id, 'Галина', 'new', '27.05.2024', '29.05.2024', 3, 54, 0, 0, 0, 12480.0, 12480.0, true, 'Передать вечером Татьяне. Положить запасные наушники', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Рыжкова%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (11, client_id, 'Наталья Рыжкова', 'new', '26.05.2024', '28.05.2024', 3, 49, 0, 0, 0, 11280.0, 11280.0, true, 'Передать Лейле. В Кристал', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (9, client_id, 'Татьяна (Гольфстрим)', 'new', '25.05.2024', '27.05.2024', 2, 28, 0, 0, 0, 4160.0, 4160.0, true, '25 мая к 8.15 отель Давыдов Инн на К. Маркса 26 шт. Вернут 27 мая в 17 отель Кристалл! Им надо на 25 и 27. Гид Палей Ирина +7 904 662-07-32', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (8, client_id, 'Татьяна (Гольфстрим)', 'new', '24.05.2024', '25.05.2024', 2, 28, 0, 0, 0, 4160.0, 4160.0, true, '26 шт. В Биляр к 8.00 гид Диана +7 927 242-10-38. Отдаст их гид Марина 25 мая в20. 00 в Кристалле', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (7, client_id, 'Татьяна (Гольфстрим)', 'new', '24.05.2024', '25.05.2024', 2, 32, 0, 0, 0, 4800.0, 4800.0, true, 'На завтра 24 мая 30 шт в Сулейман до 9.45 гид Баталова Ирина. +7 927 421-36-82, вернет25 мая в 20.00 в Сулейман', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (6, client_id, 'Татьяна (Гольфстрим)', 'new', '23.05.2024', '24.05.2024', 2, 24, 0, 0, 0, 3520.0, 3520.0, true, 'Оставить и забрать из кристалла , Гид Гульназ +7 939 390-26-10', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (5, client_id, 'Наталья', 'cancelled', '20.05.2024', '20.05.2024', 1, 41, 0, 0, 0, 2800.0, 0, false, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (4, client_id, 'Галия', 'new', '20.05.2024', '20.05.2024', 1, 20, 0, 0, 0, 1440.0, 1440.0, true, '-', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (3, client_id, 'Альберт (КТ)', 'new', '19.05.2024', '20.05.2024', 2, 32, 0, 0, 0, 4200.0, 4200.0, true, 'ЖД1 в 13:30 гид Татьяна +79063271840', leonid_id, leonid_id, NOW(), NOW());

  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%%' LIMIT 1;
  INSERT INTO rental_orders (order_number, client_id, client_name, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, total_price, prepayment, is_charged, receiver_notes, manager_id, owner_manager_id, created_at, updated_at)
  VALUES (265, client_id, '', 'new', NULL, NULL, 1, 0, 0, 0, 0, 0, 0, false, NULL, NULL, NULL, NOW(), NOW());

END $$;