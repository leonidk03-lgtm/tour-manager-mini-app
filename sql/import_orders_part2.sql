-- Часть 2 из 7
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
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1072, client_id, 'completed', '2025-09-28', '2025-09-28', 1, 43, 0, 0, 0, NULL, true, 0, 3360.0, 3360.0, 'Оставить в фургончике до 13:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1071, client_id, 'completed', '2025-09-30', '2025-09-30', 1, 21, 0, 0, 0, NULL, true, 0, 1600.0, 1600.0, 'Кристалл для Веры Валерьевны', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1070, client_id, 'completed', '2025-09-27', '2025-09-27', 1, 28, 0, 0, 0, NULL, true, 0, 2160.0, 2160.0, 'Оставить в бусике до 16:00, вернут в 18:40', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1069, client_id, 'completed', '2025-09-26', '2025-09-28', 3, 41, 0, 0, 0, NULL, true, 0, 9360.0, 9360.0, 'Сумка в офисе', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1068, client_id, 'completed', '2025-09-26', '2025-09-26', 1, 39, 0, 0, 0, NULL, true, 0, 3040.0, 3040.0, 'Светлана Чиж, ваучер на Кремль , Московская 48', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1067, client_id, 'completed', '2025-09-24', '2025-09-24', 1, 11, 0, 0, 0, NULL, true, 0, 800.0, 800.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1066, client_id, 'completed', '2025-09-26', '2025-09-28', 3, 32, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'В офис 25, гид Николай и Татьяна, мен Римма', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1065, client_id, 'completed', '2025-09-26', '2025-09-26', 1, 18, 0, 0, 0, NULL, true, 0, 1360.0, 1360.0, 'От Сафара до Сулеймана', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1064, client_id, 'completed', '2025-09-25', '2025-09-28', 4, 36, 0, 0, 0, NULL, true, 0, 10880.0, 10880.0, '25-28 нужно 34 радиогида гид Владимир Николаевич 89178858409 привезти надо в отель Давыдов на К! Маркса к 9.30 , а сдаст сам к Вам в офис после обеда 28.09 или по созвону.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1063, client_id, 'completed', '2025-09-27', '2025-09-28', 2, 29, 0, 0, 0, NULL, true, 0, 4320.0, 4320.0, 'Заберет сама и вернет сама. 28.09 оставят в кафе азу после 13:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1062, client_id, 'cancelled', '2025-10-02', '2025-10-02', 1, 16, 0, 0, 0, NULL, false, 0, 1200.0, 0, 'заберет сам', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1061, client_id, 'completed', '2025-09-28', '2025-09-28', 1, 35, 0, 0, 0, NULL, true, 0, 2720.0, 2720.0, 'Вернут либо в воскресенье вечером либо в понедельник', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1060, client_id, 'completed', '2025-09-28', '2025-09-28', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'Заберет утром +7 927 240-82-50 Лариса', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айрат Нурмухаммадов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1059, client_id, 'completed', '2025-10-29', '2025-10-30', 2, 40, 0, 0, 0, NULL, true, 0, 6080.0, 6080.0, 'Кристалл', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айрат Нурмухаммадов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1058, client_id, 'cancelled', '2025-10-26', '2025-10-28', 3, 70, 0, 0, 0, NULL, false, 0, 0.0, 0, '2 сумки по 35', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1057, client_id, 'completed', '2025-09-24', '2025-09-24', 1, 30, 0, 0, 0, NULL, true, 0, 2320.0, 2320.0, 'Ольга ткач. Ваучер Кремль, заберет утром', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1056, client_id, 'completed', '2025-09-24', '2025-09-24', 1, 31, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'Утром заберет, вернут 24.09 к 18:00 Гид Алексей, мен Камилла', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина «Романова Трэвел»%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1055, client_id, 'completed', '2025-09-24', '2025-09-27', 4, 22, 0, 0, 0, NULL, true, 0, 6080.0, 6080.0, 'Оставят в кристалле', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1054, client_id, 'completed', '2025-09-25', '2025-09-26', 2, 42, 0, 0, 0, NULL, true, 0, 6400.0, 6400.0, 'Ривьера. Валерий', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1053, client_id, 'completed', '2025-09-24', '2025-09-24', 1, 26, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, 'грант отель. Валерий', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Мои Каникулы) (Круиз)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1052, client_id, 'completed', '2025-09-27', '2025-10-01', 5, 25, 0, 0, 0, NULL, true, 0, 8400.0, 8400.0, 'Азимут', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Управление Природными Территориями (УПТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1051, client_id, 'completed', '2025-09-21', '2025-09-21', 1, 29, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, '22.09 утром привезут', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1050, client_id, 'completed', '2025-09-20', '2025-09-20', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'В 7:45 от свита Холла', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь Ким%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1049, client_id, 'completed', '2025-09-30', '2025-09-30', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, 'Волга', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена (Конгресс Авиа)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1048, client_id, 'completed', '2025-09-24', '2025-09-25', 2, 37, 0, 0, 0, NULL, true, 0, 5600.0, 5600.0, 'Гид Катя Кореева, из бусика', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1046, client_id, 'completed', '2025-09-19', '2025-09-19', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'в 12:00 от цирка, Элина, ваучер на кремль', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина Тур Москва%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1044, client_id, 'completed', '2025-09-20', '2025-09-20', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, 'в Давыдов на Карла Маркса', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1043, client_id, 'completed', '2025-09-23', '2025-09-23', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1042, client_id, 'completed', '2025-09-20', '2025-09-20', 1, 44, 0, 0, 0, NULL, true, 0, 3440.0, 3440.0, 'Вернула в офис', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1041, client_id, 'completed', '2025-10-08', '2025-10-08', 1, 48, 0, 0, 0, NULL, true, 0, 3760.0, 3760.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1040, client_id, 'completed', '2025-09-20', '2025-09-20', 1, 306, 0, 0, 0, NULL, true, 0, 25000.0, 25000.0, '6 групп по 50, привезти в деревню универсиады к 14:00 Забрать от Кремля в 16:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1039, client_id, 'completed', '2025-09-20', '2025-09-20', 1, 22, 0, 0, 0, NULL, true, 0, 1680.0, 1680.0, 'Заберет утром от свита холла Гид оставит сумку 20 сентября к 16:00 в офисе ТИЦ на Баумана, 49. Гид Серов Алексей +7 917 255-38-26', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1038, client_id, 'completed', '2025-09-20', '2025-09-21', 2, 35, 0, 0, 0, NULL, true, 0, 6600.0, 6600.0, 'Оставили в кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Давид (КФУ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1037, client_id, 'cancelled', '2025-10-10', '2025-10-11', 2, 36, 0, 0, 0, NULL, false, 0, 5600.0, 0, 'Отказ,', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1036, client_id, 'new', '2026-01-05', '2026-01-05', 1, 50, 0, 0, 0, NULL, false, 0, 0.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1035, client_id, 'new', '2026-01-03', '2026-01-03', 1, 50, 0, 0, 0, NULL, false, 0, 0.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Пронина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1034, client_id, 'completed', '2025-10-04', '2025-10-05', 2, 46, 0, 0, 0, NULL, true, 0, 6240.0, 6240.0, '46 приемников и 88 наушников', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1033, client_id, 'completed', '2025-09-20', '2025-09-20', 1, 26, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, 'От Сафара в Корстон', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1032, client_id, 'completed', '2025-09-20', '2025-09-20', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'От корстона в Корстон', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1031, client_id, 'completed', '2025-09-17', '2025-09-18', 2, 44, 0, 0, 0, NULL, true, 0, 6720.0, 6720.0, 'В офис к 10, забрать 18 до 19:00 Ответственным лицом будет представитель Госкомитета РТ - Анастасия Софьина +7 904 765-52-93 Мен Камилла', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1030, client_id, 'completed', '2025-09-16', '2025-09-16', 1, 16, 0, 0, 0, NULL, true, 0, 1670.0, 1670.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1029, client_id, 'completed', '2025-09-17', '2025-09-18', 2, 32, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, 'Заберет в 9.30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1027, client_id, 'completed', '2025-09-17', '2025-09-17', 1, 35, 0, 0, 0, NULL, true, 0, 2720.0, 2720.0, 'В офис Гид любовь, мен полина', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Сафина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1026, client_id, 'completed', '2025-09-20', '2025-09-20', 1, 42, 0, 0, 0, NULL, true, 0, 3280.0, 3280.0, 'Заберут 19 числа вечером.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1025, client_id, 'completed', '2025-09-18', '2025-09-19', 2, 27, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Биляр. Игорь. 89274055070 Вернут в Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1024, client_id, 'completed', '2025-09-15', '2025-09-16', 2, 29, 0, 0, 0, NULL, true, 0, 4320.0, 4320.0, 'Игорь. 89274055070', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александр%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1023, client_id, 'new', '2026-01-01', '2026-01-02', 2, 50, 0, 0, 0, NULL, false, 0, 9600.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей СПБ%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1022, client_id, 'completed', '2025-09-14', '2025-09-14', 1, 46, 0, 0, 0, NULL, true, 0, 3600.0, 3600.0, 'В Раймонд Аида +7 903 344-08-99', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1021, client_id, 'completed', '2025-09-13', '2025-09-14', 1, 42, 0, 0, 0, NULL, true, 0, 6560.0, 6560.0, 'Сами заберут', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1020, client_id, 'completed', '2025-09-18', '2025-09-20', 3, 38, 0, 0, 0, NULL, true, 0, 8640.0, 8640.0, 'Светлана +79677800066 В кафе Азу на Чернышевского до 15:30 Вернет в Азимут (ибис) 21 утром', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1019, client_id, 'completed', '2025-09-19', '2025-09-21', 3, 49, 0, 0, 0, NULL, true, 0, 11280.0, 11280.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1018, client_id, 'completed', '2025-09-12', '2025-09-12', 1, 22, 0, 0, 0, NULL, true, 0, 3360.0, 3360.0, 'Азу. Петербургская 52', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1017, client_id, 'completed', '2025-09-16', '2025-09-19', 4, 59, 0, 0, 0, NULL, true, 0, 17600.0, 17600.0, '55шт двойной комплект наушников', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Управление Природными Территориями (УПТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1016, client_id, 'completed', '2025-09-13', '2025-09-13', 1, 31, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'В АйТи парк на спартаковской 12.09 в', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1015, client_id, 'completed', '2025-09-12', '2025-09-13', 2, 22, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, 'Кристал, Диана', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1014, client_id, 'completed', '2025-09-12', '2025-09-14', 3, 38, 0, 0, 0, NULL, true, 0, 8640.0, 8640.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1012, client_id, 'completed', '2025-09-11', '2025-09-11', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Ольга Ткач', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александр%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1011, client_id, 'completed', '2025-09-12', '2025-09-14', 3, 36, 0, 0, 0, NULL, true, 0, 8160.0, 8160.0, 'Кристал. Разина', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Марина Экс%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1010, client_id, 'completed', '2025-09-12', '2025-09-12', 1, 43, 0, 0, 0, NULL, true, 0, 4200.0, 4200.0, 'В отель Давыдов на назарбаева, вечером 11.09, забрать можно 12 вечером', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1009, client_id, 'completed', '2025-09-12', '2025-09-14', 3, 34, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Тольятти)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1008, client_id, 'completed', '2025-09-12', '2025-09-12', 1, 183, 0, 0, 0, NULL, true, 0, 14400.0, 14400.0, '180шт + доп наушники, 3 сумки по 60шт 11.09 заберут от часов в 13:30 13.09 вернут', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1007, client_id, 'completed', '2025-09-11', '2025-09-11', 1, 102, 0, 0, 0, NULL, true, 0, 8000.0, 8000.0, 'В офис тиц к вечеру 10.09 Вернут 11.09 к вечеру , две сумки по 50', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1006, client_id, 'completed', '2025-09-12', '2025-09-14', 3, 39, 0, 0, 0, NULL, true, 0, 8880.0, 8880.0, 'Начало от Релиты, 12 сентября радиогиды должны там быть к 12.30. А вернут их в Стерлядку 14 сентября к 16.00.', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1005, client_id, 'completed', '2025-09-09', '2025-09-09', 1, 24, 0, 0, 0, NULL, true, 0, 1840.0, 1840.0, 'К 10 в офис, гид Алексей, вернут к 19', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1004, client_id, 'completed', '2025-09-06', '2025-09-06', 1, 45, 0, 0, 0, NULL, true, 0, 3520.0, 3520.0, 'В офис тиц к 10:00, забрать до 19:00 Гид Алиса Мен Камилла', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузелия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1003, client_id, 'completed', '2025-09-05', '2025-09-06', 2, 14, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'Из фургончика заберет 18:00. Наушников положить 33 шт', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1002, client_id, 'completed', '2025-09-05', '2025-09-05', 1, 200, 0, 0, 0, NULL, true, 0, 14400.0, 14400.0, 'Реч.порт. 14:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия (Рыжий Слон)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1001, client_id, 'completed', '2025-09-10', '2025-09-12', 3, 32, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'Кристал до 12:00, Владлена', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (1000, client_id, 'completed', '2025-09-06', '2025-09-06', 1, 51, 0, 0, 0, NULL, true, 0, 3500.0, 3500.0, 'Зебурт 5 вечером', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лариса Перминова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (999, client_id, 'completed', '2025-09-06', '2025-09-06', 1, 54, 0, 0, 0, NULL, true, 0, 4240.0, 4240.0, 'Заберет утром', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузелия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (998, client_id, 'completed', '2025-09-02', '2025-09-02', 1, 12, 0, 0, 0, NULL, true, 0, 880.0, 880.0, 'Заберет', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (997, client_id, 'completed', '2025-09-02', '2025-09-02', 1, 23, 0, 0, 0, NULL, true, 0, 1760.0, 1760.0, 'В кристалл для Фирузы', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Рената (Твоя Казань)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (996, client_id, 'completed', '2025-09-06', '2025-09-06', 1, 58, 0, 0, 0, NULL, true, 0, 4480.0, 4480.0, 'Две сумки на 28шт В рамаду, забрать там же', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (995, client_id, 'completed', '2025-09-01', '2025-09-01', 1, 39, 0, 0, 0, NULL, true, 0, 5760.0, 5760.0, 'Сами заберу.т Двойной комплект наушников, днем группа 38 человек, вечером 35', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (994, client_id, 'completed', '2025-08-29', '2025-08-30', 2, 26, 0, 0, 0, NULL, true, 0, 3840.0, 3840.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (993, client_id, 'completed', '2025-09-01', '2025-09-01', 1, 97, 0, 0, 0, NULL, true, 0, 7520.0, 7520.0, 'Сумки на 33, 28, 33шт Заберут сами около 10', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Жанна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (992, client_id, 'completed', '2025-09-12', '2025-09-12', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Корстон. Номер 1807', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (990, client_id, 'completed', '2025-08-29', '2025-08-30', 2, 48, 0, 0, 0, NULL, true, 0, 7360.0, 7360.0, '29-30 августа надо 46 радиогидов в кристалл к 7.30 гид Аида 89520385698', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (989, client_id, 'completed', '2025-08-30', '2025-08-30', 1, 40, 0, 0, 0, NULL, true, 0, 3500.0, 3500.0, 'Отправить утром в Новинку', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айрат Нурмухаммадов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (988, client_id, 'completed', '2025-10-25', '2025-10-25', 1, 306, 0, 0, 0, NULL, true, 0, 24000.0, 24000.0, '6 сумок по 51. Старт от Лучано с Островского в 13:30 передать', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (987, client_id, 'completed', '2025-09-07', '2025-09-07', 1, 35, 0, 0, 0, NULL, true, 0, 2380.0, 2380.0, 'Уточнить', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Фируза%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (986, client_id, 'completed', '2025-08-28', '2025-08-28', 1, 13, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, 'Оставить в офисе Вернет в Шаляпин', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (985, client_id, 'completed', '2025-10-31', '2025-11-03', 4, 29, 0, 0, 0, NULL, true, 0, 7800.0, 7800.0, 'Краснодар 4 До 14, кафе мед Оставили в кристалле!', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (984, client_id, 'completed', '2025-10-26', '2025-10-27', 2, 41, 0, 0, 0, NULL, true, 0, 6240.0, 6240.0, 'Марина Трэвел Юлия НАЛ ВЕРНУТ В ОФИС ИНИЦ 28.10 в 10:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (983, client_id, 'completed', '2025-10-26', '2025-10-28', 3, 46, 0, 0, 0, NULL, true, 0, 10120.0, 10120.0, 'Арапова В кристалл до 11:00 нал ВЕРНУТ В КРИСТАЛЛ ПОСЛЕ 22:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (982, client_id, 'completed', '2025-10-25', '2025-10-26', 2, 55, 0, 0, 0, NULL, true, 0, 8480.0, 8480.0, 'Марина Трэвел Олеся В кристалл, нал', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (981, client_id, 'completed', '2025-10-27', '2025-10-29', 3, 52, 0, 0, 0, NULL, true, 0, 11500.0, 11500.0, 'ЮВА 3 В кристалл до 11:00, нал ВЕРНУТ в КРИСТАЛЛ ПОСЛЕ 22:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (980, client_id, 'completed', '2025-10-25', '2025-10-27', 3, 52, 0, 0, 0, NULL, true, 0, 11500.0, 11500.0, 'ЮВА 2 ВЕРНУТ В кристалл ПОСЛЕ 22:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (979, client_id, 'completed', '2025-10-25', '2025-10-27', 3, 51, 0, 0, 0, NULL, true, 0, 16270.0, 16270.0, 'ЮВА 1 ВЕРНУТ В крисстал ПОСЛЕ 22:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (978, client_id, 'completed', '2025-10-27', '2025-10-31', 5, 26, 0, 0, 0, NULL, true, 0, 8510.0, 8510.0, 'Краснодар 3 До 14, кафе мед', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (977, client_id, 'completed', '2025-10-27', '2025-10-31', 5, 44, 0, 0, 0, NULL, true, 0, 15170.0, 15170.0, 'Краснодар 2 До 14, кафе мед', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (976, client_id, 'completed', '2025-10-27', '2025-10-31', 5, 50, 0, 0, 0, NULL, true, 0, 17390.0, 17390.0, 'Краснодар 1 До 14, кафе мед', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (975, client_id, 'completed', '2025-10-23', '2025-10-27', 5, 46, 0, 0, 0, NULL, true, 0, 15910.0, 15910.0, 'Краснодар 0 НАЛ ВНРНУТ В КРИСТАЛЛ ПОСЛЕ 13:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (974, client_id, 'completed', '2025-08-30', '2025-08-30', 1, 25, 0, 0, 0, NULL, true, 0, 1600.0, 1600.0, 'От Сафара в Корстон', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (973, client_id, 'completed', '2025-08-30', '2025-08-30', 1, 32, 0, 0, 0, NULL, true, 0, 2480.0, 2480.0, 'От релиты до релиты', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (972, client_id, 'completed', '2025-09-28', '2025-10-01', 4, 38, 0, 0, 0, NULL, true, 0, 8700.0, 8700.0, 'В офисе Инициативы', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (971, client_id, 'completed', '2025-09-20', '2025-09-20', 1, 47, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, 'В офисе', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ленар (ИП Ножкин)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (970, client_id, 'completed', '2025-08-29', '2025-09-01', 4, 36, 0, 0, 0, NULL, true, 0, 10560.0, 10560.0, 'Заберет 28.08 в 19:30 4 комплекта наушников', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (969, client_id, 'completed', '2025-08-27', '2025-08-27', 1, 27, 0, 0, 0, NULL, true, 0, 2080.0, 2080.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (968, client_id, 'completed', '2025-08-27', '2025-08-28', 2, 33, 0, 0, 0, NULL, true, 0, 4960.0, 4960.0, 'Заберет утром в 10:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (967, client_id, 'completed', '2025-08-26', '2025-08-26', 1, 11, 0, 0, 0, NULL, true, 0, 800.0, 800.0, 'Заберут в 17:30 примерно', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (966, client_id, 'completed', '2025-08-28', '2025-08-28', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'В офис тиц 27.08, вернут 29.08', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (965, client_id, 'completed', '2025-08-27', '2025-08-27', 1, 153, 0, 0, 0, NULL, true, 0, 12000.0, 12000.0, 'В офис 26.08, вернут 28.08 Три сумки по 50', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (964, client_id, 'completed', '2025-08-25', '2025-08-25', 1, 40, 0, 0, 0, NULL, true, 0, 3120.0, 3120.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина Тур Москва%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (963, client_id, 'completed', '2025-08-23', '2025-08-23', 1, 48, 0, 0, 0, NULL, true, 0, 3760.0, 3760.0, 'В АйТи парке', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (962, client_id, 'completed', '2025-08-23', '2025-08-24', 2, 38, 0, 0, 0, NULL, true, 0, 5760.0, 5760.0, 'В Кристалле', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сафина Алина (ФРГРТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (961, client_id, 'completed', '2025-08-22', '2025-08-22', 1, 150, 0, 0, 0, NULL, true, 0, 12000.0, 12000.0, 'Утром заберут', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (960, client_id, 'completed', '2025-08-30', '2025-08-30', 1, 35, 0, 0, 0, NULL, true, 0, 2720.0, 2720.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (959, client_id, 'completed', '2025-08-22', '2025-08-23', 2, 41, 0, 0, 0, NULL, true, 0, 6240.0, 6240.0, 'Заберет утром Владимир 89178858409', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузелия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (958, client_id, 'completed', '2025-08-21', '2025-08-21', 1, 10, 0, 0, 0, NULL, true, 0, 800.0, 800.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (957, client_id, 'completed', '2025-09-16', '2025-09-19', 3, 29, 0, 0, 0, NULL, true, 0, 6480.0, 6480.0, 'Сулейман до 15:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анвар Каримов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (956, client_id, 'completed', '2025-08-22', '2025-08-22', 1, 140, 0, 0, 0, NULL, true, 0, 11200.0, 11200.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (955, client_id, 'completed', '2025-08-21', '2025-08-23', 3, 30, 0, 0, 0, NULL, true, 0, 8400.0, 8400.0, 'В кристалe', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (954, client_id, 'completed', '2025-08-21', '2025-08-23', 3, 20, 0, 0, 0, NULL, true, 0, 4320.0, 4320.0, '18+ человек в Кристалл к 10 ч. На 3 или 4 дня. Гид Ирина 89046620732 Вернули в парк отель', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (953, client_id, 'completed', '2025-08-24', '2025-08-24', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'В стерлядке', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (952, client_id, 'completed', '2025-08-22', '2025-08-24', 3, 51, 0, 0, 0, NULL, true, 0, 11760.0, 11760.0, 'В Кристалле', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (951, client_id, 'completed', '2025-08-20', '2025-08-20', 1, 14, 0, 0, 0, NULL, true, 0, 1040.0, 1040.0, 'Заберут', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (950, client_id, 'completed', '2025-08-22', '2025-08-23', 2, 32, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (949, client_id, 'completed', '2025-08-19', '2025-08-21', 3, 45, 0, 0, 0, NULL, true, 0, 6020.0, 6020.0, 'Утром отправить в добрую столовую', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (948, client_id, 'completed', '2025-08-25', '2025-08-27', 3, 51, 0, 0, 0, NULL, true, 0, 11760.0, 11760.0, '25-27 августа , гид Катя Ильина . 25 августа в 14:20 на жд Восстания', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сафина Алина (ФРГРТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (947, client_id, 'completed', '2025-08-18', '2025-08-18', 1, 400, 0, 0, 0, NULL, true, 0, 32000.0, 32000.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Руслан (Тимсофт)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (946, client_id, 'completed', '2025-08-22', '2025-08-22', 1, 56, 0, 0, 0, NULL, true, 0, 4400.0, 4400.0, 'Заберут вечером 21.08', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (945, client_id, 'completed', '2025-08-18', '2025-08-18', 1, 26, 0, 0, 0, NULL, true, 0, 1920.0, 1920.0, '2 сумки по 12шт, в офис 18.08 к 10:00, Вернут вечером до 19:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (944, client_id, 'completed', '2025-08-15', '2025-08-16', 2, 47, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'В офис к 10:00, 15.08, двойной комплект наушников, Вернут 17.08 до 12:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (943, client_id, 'completed', '2025-08-15', '2025-08-15', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Смак Сафар, Резеда, ваучер на кремль', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (942, client_id, 'completed', '2025-08-23', '2025-08-24', 2, 33, 0, 0, 0, NULL, true, 0, 4960.0, 4960.0, 'Заберут утром', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузелия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (941, client_id, 'completed', '2025-08-14', '2025-08-14', 1, 11, 0, 0, 0, NULL, true, 0, 800.0, 800.0, 'Вернут в Кристал после 20:30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (940, client_id, 'completed', '2025-08-16', '2025-08-17', 2, 48, 0, 0, 0, NULL, true, 0, 7360.0, 7360.0, 'В Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (939, client_id, 'completed', '2025-08-23', '2025-08-24', 2, 53, 0, 0, 0, NULL, true, 0, 8160.0, 8160.0, 'В Волгe', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (938, client_id, 'completed', '2025-08-15', '2025-08-17', 3, 51, 0, 0, 0, NULL, true, 0, 11760.0, 11760.0, 'В кристалл Оставила в кристалле', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (937, client_id, 'completed', '2025-08-16', '2025-08-16', 1, 16, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, 'В Сулейман, вернут туда же', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (936, client_id, 'completed', '2025-08-15', '2025-08-16', 2, 38, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, 'От амакса в Корстон около 20:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (935, client_id, 'completed', '2025-08-30', '2025-08-30', 1, 47, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (934, client_id, 'completed', '2025-08-16', '2025-08-16', 1, 40, 0, 0, 0, NULL, true, 0, 3120.0, 3120.0, ', будет забирать +7 927 240-82-50 Лариса', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульназ%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (933, client_id, 'completed', '2025-08-16', '2025-08-16', 1, 112, 0, 0, 0, NULL, true, 0, 8800.0, 8800.0, 'Пушкина 8. В 8:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Вера%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (932, client_id, 'completed', '2025-08-13', '2025-08-13', 1, 86, 0, 0, 0, NULL, true, 0, 6720.0, 6720.0, 'Акварель хостел', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алла (Вятские Поляны)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (931, client_id, 'completed', '2025-08-13', '2025-08-13', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'Утром в 8 у Часов Вернут в реч порт, Эдику', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (930, client_id, 'completed', '2025-08-13', '2025-08-14', 2, 48, 0, 0, 0, NULL, true, 0, 7360.0, 7360.0, 'В офис 13.08 к 10, вернут 15.08 до 12:00 Гид Диана', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (929, client_id, 'completed', '2025-08-12', '2025-08-14', 3, 18, 0, 0, 0, NULL, true, 0, 3840.0, 3840.0, 'В офис тиц 12.08 в 10:15', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (928, client_id, 'completed', '2025-08-15', '2025-08-17', 3, 49, 0, 0, 0, NULL, true, 0, 11280.0, 11280.0, 'Заберет утром Оставила в бусике', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (927, client_id, 'completed', '2025-08-13', '2025-08-14', 2, 46, 0, 0, 0, NULL, true, 0, 7040.0, 7040.0, 'Заберет утром', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (926, client_id, 'completed', '2025-08-10', '2025-08-10', 1, 9, 0, 0, 0, NULL, true, 0, 640.0, 640.0, 'В офис тиц в 10:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (925, client_id, 'completed', '2025-08-08', '2025-08-09', 2, 40, 0, 0, 0, NULL, true, 0, 6240.0, 6240.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (924, client_id, 'completed', '2025-08-11', '2025-08-11', 1, 65, 0, 0, 0, NULL, true, 0, 5040.0, 5040.0, '1 на 36 Ильмира; 2 на 27 Алсу, занеси накануне', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (923, client_id, 'completed', '2025-08-09', '2025-08-09', 1, 20, 0, 0, 0, NULL, true, 0, 1520.0, 1520.0, 'Сама заберет и вернет Экскурсия с 10:30 до 15:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (922, client_id, 'completed', '2025-08-09', '2025-08-10', 2, 44, 0, 0, 0, NULL, true, 0, 6720.0, 6720.0, 'В кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (921, client_id, 'completed', '2025-08-08', '2025-08-08', 1, 45, 0, 0, 0, NULL, true, 0, 3520.0, 3520.0, 'В кристалл, Мария Вернула в кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (920, client_id, 'completed', '2025-08-08', '2025-08-10', 3, 49, 0, 0, 0, NULL, true, 0, 11280.0, 11280.0, 'В кристалл, сопровождающий Ирина', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (919, client_id, 'completed', '2025-08-19', '2025-08-19', 1, 49, 0, 0, 0, NULL, true, 0, 3840.0, 3840.0, 'В кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (918, client_id, 'completed', '2025-08-08', '2025-08-10', 3, 35, 0, 0, 0, NULL, true, 0, 7920.0, 7920.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (917, client_id, 'completed', '2025-08-07', '2025-08-07', 1, 15, 0, 0, 0, NULL, true, 0, 980.0, 980.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (916, client_id, 'completed', '2025-08-17', '2025-08-17', 1, 38, 0, 0, 0, NULL, true, 0, 2590.0, 2590.0, 'В волгу Оставила в бусике', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (915, client_id, 'completed', '2025-08-09', '2025-08-09', 1, 33, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, 'От Сафара до корстона', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (914, client_id, 'completed', '2025-08-09', '2025-08-09', 1, 40, 0, 0, 0, NULL, true, 0, 3120.0, 3120.0, 'От релиты до релиты', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (913, client_id, 'completed', '2025-08-06', '2025-08-06', 1, 35, 0, 0, 0, NULL, true, 0, 2720.0, 2720.0, 'В 12:00 в трапезную', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Минеева%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (912, client_id, 'completed', '2025-09-13', '2025-09-13', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Созвониться', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (911, client_id, 'completed', '2025-08-08', '2025-08-08', 1, 45, 0, 0, 0, NULL, true, 0, 3520.0, 3520.0, 'Волга', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (909, client_id, 'completed', '2025-08-11', '2025-08-11', 1, 138, 0, 0, 0, NULL, true, 0, 10800.0, 10800.0, '2 сумки по 50, Нурия и Светлана 1 сумка на 35, Диляра В офис тиц 10. 08 до вечера', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (908, client_id, 'completed', '2025-08-11', '2025-08-13', 3, 47, 0, 0, 0, NULL, true, 0, 10800.0, 10800.0, 'Сами заберут 11.08 Гид Катя Кореева Вернут в отель Европа', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (907, client_id, 'completed', '2025-08-07', '2025-08-07', 1, 46, 0, 0, 0, NULL, true, 0, 3600.0, 3600.0, 'В офис 6 Гид Светлана +79677800066', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (906, client_id, 'completed', '2025-09-20', '2025-09-20', 1, 20, 0, 0, 0, NULL, true, 0, 1520.0, 1520.0, 'Заберут после 11:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алла (Вятские Поляны)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (905, client_id, 'completed', '2025-08-03', '2025-08-03', 1, 39, 0, 0, 0, NULL, true, 0, 3040.0, 3040.0, 'Заберут утром у часов, вернут в порт кому-нибудь', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (904, client_id, 'completed', '2025-08-01', '2025-08-03', 3, 45, 0, 0, 0, NULL, true, 0, 10320.0, 10320.0, 'В кристал', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузель (Юралс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (903, client_id, 'completed', '2025-08-23', '2025-08-23', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (902, client_id, 'completed', '2025-08-08', '2025-08-09', 2, 41, 0, 0, 0, NULL, true, 0, 6240.0, 6240.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Минеева%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (901, client_id, 'completed', '2025-08-02', '2025-08-02', 1, 48, 0, 0, 0, NULL, true, 0, 3760.0, 3760.0, 'Вечером перед вечер кой заберет Ирина Савельева', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (900, client_id, 'completed', '2025-08-01', '2025-08-03', 3, 45, 0, 0, 0, NULL, true, 0, 10080.0, 10080.0, 'В мвияжск передать', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (899, client_id, 'completed', '2025-08-01', '2025-08-03', 3, 54, 0, 0, 0, NULL, true, 0, 12000.0, 12000.0, 'Сама заберет утром', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (898, client_id, 'completed', '2025-07-30', '2025-07-31', 2, 48, 0, 0, 0, NULL, true, 0, 7360.0, 7360.0, 'Сама заберет в 10:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (897, client_id, 'completed', '2025-08-12', '2025-08-14', 3, 32, 0, 0, 0, NULL, true, 0, 6480.0, 6480.0, 'Группа 21 на 3 дня и группа 9 на 2 дня В кристалл 11.08 вечером', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (896, client_id, 'completed', '2025-08-03', '2025-08-03', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, 'От Релита до Ногая', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (895, client_id, 'completed', '2025-07-28', '2025-07-28', 1, 211, 0, 0, 0, NULL, true, 0, 16480.0, 16480.0, '4 сумки по 49+1 1 сумка по 10+1 (Наталья) В офис тиц до 10:30, вернут 29.07 до 12:00 Ильмира, Яна, Инна, (Надия кристалл ) до 13:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Рената (Твоя Казань)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (894, client_id, 'completed', '2025-08-01', '2025-08-02', 2, 29, 0, 0, 0, NULL, true, 0, 4320.0, 4320.0, 'Заберет гид Ольга вечером или утром', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (893, client_id, 'completed', '2025-07-27', '2025-07-27', 1, 62, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, 'Гид Лариса на Баумана 49, 26.07 до 17:00 на 50шт Гид Гульнара на Баумана 49, 26.07 до 17:00 на 10шт Вернут 27.07 до 19:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (892, client_id, 'completed', '2025-07-27', '2025-07-28', 2, 104, 0, 0, 0, NULL, true, 0, 16000.0, 16000.0, 'Гид Ванда в кристалл 26.07 до 20:00 на 50шт +2!!! Запасных(так как 2 дня) +двойной комплект наушников Гид Вероника в кристалл 26.07 до 20:00 на 50шт +2!!! Запасных(так как 2 дня) +двойной комплект наушников Вернут 29.07 до 12:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (891, client_id, 'completed', '2025-07-27', '2025-07-27', 1, 153, 0, 0, 0, NULL, true, 0, 12000.0, 12000.0, 'Гид Алексей на Баумана 49, 26.07 до 17:00, 50 радиогидов Гид Елена в Кристалл, 26.07 вечером, 50 радиогидов Гид Ирина на Баумана 49, 26.07 до 17:00, 50 радиогидов Вернут 27.07 до 19:00 в офис ТИЦ', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (890, client_id, 'completed', '2025-07-28', '2025-07-28', 1, 37, 0, 0, 0, NULL, true, 0, 2880.0, 2880.0, 'Регину на университетской к 8', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (889, client_id, 'completed', '2025-08-02', '2025-08-02', 1, 46, 0, 0, 0, NULL, true, 0, 3600.0, 3600.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (888, client_id, 'completed', '2025-07-31', '2025-07-31', 1, 38, 0, 0, 0, NULL, true, 0, 2880.0, 2880.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (887, client_id, 'completed', '2025-07-26', '2025-07-27', 2, 32, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (886, client_id, 'completed', '2025-07-25', '2025-07-25', 1, 31, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'Гузель. Корстон, до 14:00. Ваучер Кремль', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Владимир Нежданов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (885, client_id, 'completed', '2025-07-25', '2025-07-25', 1, 66, 0, 0, 0, NULL, true, 0, 5040.0, 5040.0, 'Заберет утром', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (884, client_id, 'completed', '2025-07-26', '2025-07-26', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, 'Владимир', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (883, client_id, 'completed', '2025-08-04', '2025-08-04', 1, 15, 0, 0, 0, NULL, true, 0, 1120.0, 1120.0, 'Корстон', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (882, client_id, 'completed', '2025-07-26', '2025-07-26', 1, 41, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, 'Заберут вечером 25 числа', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (881, client_id, 'completed', '2025-07-26', '2025-07-27', 2, 28, 0, 0, 0, NULL, true, 0, 4160.0, 4160.0, 'В азалию', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (880, client_id, 'completed', '2025-07-26', '2025-07-27', 2, 43, 0, 0, 0, NULL, true, 0, 6560.0, 6560.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (879, client_id, 'completed', '2025-07-25', '2025-07-25', 1, 266, 0, 0, 0, NULL, true, 0, 20800.0, 20800.0, '5 сумок по 50, гид Елена, Алексей, Инна, Яна, Ванда 1 сумка на 10 Диляра В офис тиц к 10:30 Вернут до 19:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (878, client_id, 'completed', '2025-08-05', '2025-08-05', 1, 48, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, 'Кристал Два микрофона и передатчика', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (877, client_id, 'completed', '2025-07-26', '2025-07-26', 1, 24, 0, 0, 0, NULL, true, 0, 1840.0, 1840.0, 'От Сафара в Сулейман', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (876, client_id, 'completed', '2025-07-25', '2025-07-26', 2, 35, 0, 0, 0, NULL, true, 0, 4960.0, 4960.0, 'От Сафара в релиту в районе 20:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ленар (ИП Ножкин)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (875, client_id, 'completed', '2025-07-24', '2025-07-24', 1, 136, 0, 0, 0, NULL, true, 0, 10400.0, 10400.0, '4 сумки по 22 и 2 по 21', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (874, client_id, 'completed', '2025-07-23', '2025-07-23', 1, 42, 0, 0, 0, NULL, true, 0, 3280.0, 3280.0, 'Ольга ткач. Ваучер на свияжск', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (873, client_id, 'completed', '2025-07-25', '2025-07-27', 3, 49, 0, 0, 0, NULL, true, 0, 11280.0, 11280.0, 'В Кристал', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (872, client_id, 'completed', '2025-07-22', '2025-07-22', 1, 13, 0, 0, 0, NULL, true, 0, 960.0, 960.0, 'Хилтон. На имя Татьяна', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Виктор (Мастерминд)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (871, client_id, 'completed', '2025-07-28', '2025-07-28', 1, 50, 0, 0, 0, NULL, true, 0, 5000.0, 5000.0, '27 заберут вечером Две сумки по 25шт', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (870, client_id, 'completed', '2025-07-21', '2025-07-21', 1, 43, 0, 0, 0, NULL, true, 0, 3360.0, 3360.0, 'В Татарстан к 8 Вернут туда же в 15:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (869, client_id, 'completed', '2025-07-20', '2025-07-22', 3, 17, 0, 0, 0, NULL, true, 0, 3600.0, 3600.0, 'В Фатиму', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Агентство Удачи)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (868, client_id, 'completed', '2025-07-19', '2025-07-20', 2, 70, 0, 0, 0, NULL, true, 0, 10880.0, 10880.0, 'Сумки на 32 и 36 В Релиту на имя Эльзы +7 904 717-59-99', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Валентина Воронкова (Ввел Ком)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (867, client_id, 'completed', '2025-07-22', '2025-07-24', 3, 52, 0, 0, 0, NULL, true, 0, 12000.0, 12000.0, 'В марриот 21.07', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
END $$;