-- Часть 3 из 7
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
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Фируза%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (866, client_id, 'completed', '2025-07-18', '2025-07-18', 1, 15, 0, 0, 0, NULL, true, 0, 1400.0, 1400.0, 'В офис', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (865, client_id, 'completed', '2025-07-18', '2025-07-18', 1, 45, 0, 0, 0, NULL, true, 0, 3520.0, 3520.0, 'Группа Марии', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (864, client_id, 'completed', '2025-07-18', '2025-07-20', 3, 34, 0, 0, 0, NULL, true, 0, 7680.0, 7680.0, 'Группа Ирины Вернули в кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (863, client_id, 'completed', '2025-07-18', '2025-07-20', 3, 44, 0, 0, 0, NULL, true, 0, 10080.0, 10080.0, 'Группа Кати Вернули в кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (862, client_id, 'completed', '2025-09-06', '2025-09-06', 1, 44, 0, 0, 0, NULL, true, 0, 3440.0, 3440.0, 'Кристал, Лейла', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (861, client_id, 'completed', '2025-07-18', '2025-07-18', 1, 90, 0, 0, 0, NULL, true, 0, 7040.0, 7040.0, 'Две сумки по 44шт В Тиц 17.07 до 17:00 Вернут 18.07 до 19:00 1) Гид Серов Алексей +7 917 255-38-26 2) Гид Елена Яхъяева +7 927 401-58-22', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (860, client_id, 'completed', '2025-07-19', '2025-07-19', 1, 44, 0, 0, 0, NULL, true, 0, 3440.0, 3440.0, 'В Сафар, вернут в корстон', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (859, client_id, 'completed', '2025-07-18', '2025-07-18', 1, 71, 0, 0, 0, NULL, true, 0, 4900.0, 4900.0, 'Заберут 17', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (858, client_id, 'completed', '2025-07-19', '2025-07-19', 1, 44, 0, 0, 0, NULL, true, 0, 3440.0, 3440.0, 'От релита вернут в релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена (Конгресс Авиа)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (857, client_id, 'completed', '2025-07-17', '2025-07-17', 1, 28, 0, 0, 0, NULL, true, 0, 2160.0, 2160.0, 'В здание присутсвеныхх мест 16.07 до 20:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (856, client_id, 'completed', '2025-07-17', '2025-07-19', 3, 24, 0, 0, 0, NULL, true, 0, 6600.0, 6600.0, 'В татарскую усадьбу не ресепшен', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (855, client_id, 'completed', '2025-07-15', '2025-07-17', 3, 47, 0, 0, 0, NULL, true, 0, 9450.0, 9450.0, 'Доставка', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (854, client_id, 'completed', '2025-07-16', '2025-07-17', 2, 47, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'Сама заберет утром в 10:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (853, client_id, 'completed', '2025-07-25', '2025-07-26', 2, 39, 0, 0, 0, NULL, true, 0, 5920.0, 5920.0, 'Заберет утром', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (852, client_id, 'completed', '2025-07-12', '2025-07-12', 1, 11, 0, 0, 0, NULL, true, 0, 800.0, 800.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (851, client_id, 'completed', '2025-07-12', '2025-07-12', 1, 33, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, 'В тасиго нео. На имя Валерия Матросова', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (850, client_id, 'completed', '2025-07-11', '2025-07-11', 1, 29, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, 'Добрый вечер, Леонид. На 11 июля надо на 28 чел. Радио гиды к 9.45 До вечера. Гид Ирина Палей +7 904 662-07-32. в А матти М. Джалиля1 Оставила в кристалле!', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (849, client_id, 'completed', '2025-07-12', '2025-07-13', 2, 52, 0, 0, 0, NULL, true, 0, 8000.0, 8000.0, 'Уточнить', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Яна Янова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (848, client_id, 'completed', '2025-07-10', '2025-07-10', 1, 16, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, 'Заберет', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (847, client_id, 'completed', '2025-07-11', '2025-07-11', 1, 35, 0, 0, 0, NULL, true, 0, 2720.0, 2720.0, 'В амакс Сафар, вернут в корстон', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (846, client_id, 'completed', '2025-07-22', '2025-07-22', 1, 46, 0, 0, 0, NULL, true, 0, 3520.0, 3520.0, 'Крсталл С группой наш сотрудник Елена 89277678701', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузель (Юралс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (845, client_id, 'completed', '2025-07-12', '2025-07-12', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, 'Уточнить', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (844, client_id, 'completed', '2025-07-12', '2025-07-12', 1, 46, 0, 0, 0, NULL, true, 0, 3600.0, 3600.0, 'Сумка в Мано', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (843, client_id, 'completed', '2025-07-12', '2025-07-12', 1, 53, 0, 0, 0, NULL, true, 0, 4160.0, 4160.0, 'Заберут', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (842, client_id, 'completed', '2025-07-11', '2025-07-13', 3, 40, 0, 0, 0, NULL, true, 0, 9120.0, 9120.0, 'Заберут 10 в течение дня', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (841, client_id, 'completed', '2025-07-11', '2025-07-13', 3, 49, 0, 0, 0, NULL, true, 0, 11280.0, 11280.0, 'Кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (840, client_id, 'completed', '2025-07-09', '2025-07-09', 1, 24, 0, 0, 0, NULL, true, 0, 1840.0, 1840.0, 'В релиту, вернут в кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (839, client_id, 'completed', '2025-07-19', '2025-07-19', 1, 53, 0, 0, 0, NULL, true, 0, 4160.0, 4160.0, '18.07 в офис, забрать 20.07 Гид: Алексей Серов +7 917 255-38-26', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Компания%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (838, client_id, 'completed', '2025-07-05', '2025-07-05', 1, 31, 0, 0, 0, NULL, true, 0, 2480.0, 2480.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (837, client_id, 'completed', '2025-07-05', '2025-07-05', 1, 22, 0, 0, 0, NULL, true, 0, 1680.0, 1680.0, 'В Тиц до 10:30 Вернут до 19:00 в Тиц Мен Камилла Гид Эльвира +7 917 228-93-99', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (835, client_id, 'completed', '2025-07-05', '2025-07-06', 2, 36, 0, 0, 0, NULL, true, 0, 5440.0, 5440.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (834, client_id, 'completed', '2025-07-04', '2025-07-05', 2, 33, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, 'Петербуржская 52', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (833, client_id, 'completed', '2025-07-04', '2025-07-05', 2, 41, 0, 0, 0, NULL, true, 0, 6240.0, 6240.0, '4-5 июня 39 человек. Нужны радиогидв. Гид Ирина 89046620732', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (832, client_id, 'completed', '2025-07-04', '2025-07-06', 3, 46, 0, 0, 0, NULL, true, 0, 10560.0, 10560.0, 'В кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария (ОСР)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (831, client_id, 'completed', '2025-07-07', '2025-07-09', 3, 19, 0, 0, 0, NULL, true, 0, 4080.0, 4080.0, 'в офис 07.07 с 9:00 до 12:30?', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (830, client_id, 'completed', '2025-07-16', '2025-07-17', 2, 55, 0, 0, 0, NULL, true, 0, 10600.0, 10600.0, 'В 8 утра в алтын куль Гид Марина 8917 288-90-13', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айгуль Файзуллина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (829, client_id, 'completed', '2025-07-01', '2025-07-03', 3, 52, 0, 0, 0, NULL, true, 0, 12000.0, 12000.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (828, client_id, 'completed', '2025-07-06', '2025-07-06', 1, 41, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, 'В Татарстан', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (827, client_id, 'completed', '2025-07-01', '2025-07-02', 2, 25, 0, 0, 0, NULL, true, 0, 3360.0, 3360.0, 'Сумка на 20 и 5', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (826, client_id, 'completed', '2025-06-30', '2025-06-30', 1, 29, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, 'Срочный заказ в Кремль', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (825, client_id, 'completed', '2025-07-02', '2025-07-03', 2, 40, 0, 0, 0, NULL, true, 0, 6080.0, 6080.0, 'Заберет примерно в 10:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (824, client_id, 'completed', '2025-06-29', '2025-06-30', 2, 30, 0, 0, 0, NULL, true, 0, 4480.0, 4480.0, '29 июня к 7.30 в Кристалл надо радиогиды на 28 человек.сдадут в Кристалл 30 июня после 17.00 гид Ирина 89046620732', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (823, client_id, 'completed', '2025-06-27', '2025-06-28', 1, 49, 0, 0, 0, NULL, true, 0, 7520.0, 7520.0, '27 июня надо на 47 чел. Радиогиды в Кристалл к 7.00. Сдадут в Кристал вечером 28. Гид Ванда 89655868806', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (822, client_id, 'completed', '2025-06-27', '2025-06-27', 1, 37, 0, 0, 0, NULL, true, 0, 2880.0, 2880.0, 'В 15:00 от Кремля', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Фируза%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (821, client_id, 'completed', '2025-06-27', '2025-06-27', 1, 17, 0, 0, 0, NULL, true, 0, 1600.0, 1600.0, 'Заберет сама', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (820, client_id, 'completed', '2025-06-27', '2025-06-27', 1, 18, 0, 0, 0, NULL, true, 0, 1190.0, 1190.0, 'Заберут', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (819, client_id, 'completed', '2025-07-04', '2025-07-05', 2, 35, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Уточнить', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (818, client_id, 'completed', '2025-06-28', '2025-06-28', 1, 43, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, 'Заберут. 28 утром', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (817, client_id, 'completed', '2025-06-28', '2025-06-28', 1, 21, 0, 0, 0, NULL, true, 0, 1400.0, 1400.0, 'Карат', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (816, client_id, 'completed', '2025-06-28', '2025-06-28', 1, 44, 0, 0, 0, NULL, true, 0, 3010.0, 3010.0, 'Завтрак в Марджани 8. В 8:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (815, client_id, 'completed', '2025-06-27', '2025-06-28', 2, 28, 0, 0, 0, NULL, true, 0, 3640.0, 3640.0, 'Кристал. Ирина. 1 лежит отдельно, не работает', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (814, client_id, 'completed', '2025-06-27', '2025-06-28', 2, 28, 0, 0, 0, NULL, true, 0, 3640.0, 3640.0, 'Кристал. Владимир', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ленар (ИП Ножкин)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (813, client_id, 'completed', '2025-06-26', '2025-06-26', 1, 123, 0, 0, 0, NULL, true, 0, 9600.0, 9600.0, '3 сумки по 40 в Ривьеру к 14:30, забрать в 18:20 из туган авылым 89377044790 Анастасия ответственная', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (812, client_id, 'completed', '2025-06-28', '2025-06-28', 1, 26, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, 'В офис к 10:30, забрать с отеля мираж после 20:00 +7 903 388-89-29 Гид Ильмира', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (811, client_id, 'completed', '2025-06-28', '2025-06-28', 1, 44, 0, 0, 0, NULL, true, 0, 3440.0, 3440.0, 'В релиту, вернут в релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (810, client_id, 'completed', '2025-06-28', '2025-06-28', 1, 23, 0, 0, 0, NULL, true, 0, 1760.0, 1760.0, 'В Сафар, вернут в Корстон', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (809, client_id, 'completed', '2025-07-08', '2025-07-08', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'В Кристал', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (808, client_id, 'completed', '2025-07-08', '2025-07-08', 1, 25, 0, 0, 0, NULL, true, 0, 1920.0, 1920.0, 'Заберет', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (807, client_id, 'completed', '2025-06-25', '2025-06-26', 2, 20, 0, 0, 0, NULL, true, 0, 2880.0, 2880.0, 'НЕО тасига', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (806, client_id, 'completed', '2025-06-25', '2025-06-26', 2, 156, 0, 0, 0, NULL, true, 0, 20000.0, 20000.0, '3 сумки по 52шт в офис Тиц Забрать 27', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (805, client_id, 'completed', '2025-06-25', '2025-06-25', 1, 46, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'В офис две сумки по 45', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена (Конгресс Авиа)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (804, client_id, 'completed', '2025-06-24', '2025-06-25', 2, 12, 0, 0, 0, NULL, true, 0, 1600.0, 1600.0, 'В Нео Гид Эльзара для компании Пфайзер', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (803, client_id, 'completed', '2025-06-23', '2025-06-24', 1, 34, 0, 0, 0, NULL, true, 0, 4480.0, 4480.0, '23.06 и 24.06* Группа 32 чел+ гид Владимир т. +7 917 885-84-09, гид Владимир', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (802, client_id, 'completed', '2025-06-21', '2025-06-21', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, 'и на завтра нужно 40 штук в 11:30 от ул Толстого д.14 . Гид Нурия', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (801, client_id, 'completed', '2025-06-21', '2025-06-21', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'Заберет утром Елена Козлова', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (800, client_id, 'completed', '2025-06-20', '2025-06-23', 4, 25, 0, 0, 0, NULL, true, 0, 7360.0, 7360.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (799, client_id, 'completed', '2025-06-20', '2025-06-23', 4, 43, 0, 0, 0, NULL, true, 0, 13120.0, 13120.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (798, client_id, 'completed', '2025-06-20', '2025-06-20', 1, 31, 0, 0, 0, NULL, true, 0, 2100.0, 2100.0, 'Забрать из Сулеймана Ирина', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александр%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (797, client_id, 'completed', '2025-06-21', '2025-06-22', 2, 50, 0, 0, 0, NULL, true, 0, 7680.0, 7680.0, 'Кристал Ольга', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (796, client_id, 'completed', '2025-06-20', '2025-06-20', 2, 17, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, 'Раймонд. Для Татьяны', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (795, client_id, 'completed', '2025-06-21', '2025-06-21', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'В релиту, вернут туда же', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (794, client_id, 'completed', '2025-06-20', '2025-06-21', 1, 30, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, 'В Сафар, вернут в Сулейман', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Сиалия)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (792, client_id, 'completed', '2025-06-24', '2025-06-24', 1, 31, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'В кристал', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина Тур Москва%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (791, client_id, 'completed', '2025-06-19', '2025-06-20', 2, 47, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'В Европу , оставят в АйТи парке', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (790, client_id, 'completed', '2025-06-21', '2025-06-21', 1, 49, 0, 0, 0, NULL, true, 0, 3760.0, 3760.0, 'В нео Тасиго с 9 до 18', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (789, client_id, 'completed', '2025-06-18', '2025-06-18', 1, 31, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'Да, пусть оставят на ресепшене на мой номер (1617 Стрелкова Анастасия) корстон', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (788, client_id, 'completed', '2025-06-17', '2025-06-19', 3, 55, 0, 0, 0, NULL, true, 0, 12000.0, 12000.0, 'Элина', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (786, client_id, 'completed', '2025-06-18', '2025-06-19', 2, 44, 0, 0, 0, NULL, true, 0, 6720.0, 6720.0, 'Заберет утром в 10:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Родина-тур%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (785, client_id, 'completed', '2025-06-18', '2025-06-20', 3, 24, 0, 0, 0, NULL, true, 0, 5280.0, 5280.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (784, client_id, 'completed', '2025-06-15', '2025-06-15', 1, 31, 0, 0, 0, NULL, true, 0, 2480.0, 2480.0, 'Амстердам', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (783, client_id, 'completed', '2025-06-12', '2025-06-12', 1, 26, 0, 0, 0, NULL, true, 0, 5000.0, 5000.0, 'Оставила в бусинке', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (782, client_id, 'completed', '2025-06-12', '2025-06-14', 3, 40, 0, 0, 0, NULL, true, 0, 12160.0, 12160.0, 'В офис Тиц', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (781, client_id, 'completed', '2025-06-12', '2025-06-14', 3, 39, 0, 0, 0, NULL, true, 0, 11840.0, 11840.0, 'В офис тиц', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Дарья%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (780, client_id, 'completed', '2025-06-21', '2025-06-21', 1, 44, 0, 0, 0, NULL, true, 0, 3440.0, 3440.0, 'Позвонит экскурсовод. Утром созвониться Сдали в татарскую усадьбу', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузель (Юралс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (779, client_id, 'completed', '2025-06-28', '2025-06-28', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, 'Заберет 27 вечером часов в 18:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (777, client_id, 'completed', '2025-06-21', '2025-06-21', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'В мано до 12, вернут после 19 в Татарстан', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина (ОЛТА Трэвел)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (776, client_id, 'completed', '2025-06-24', '2025-06-24', 1, 21, 0, 0, 0, NULL, true, 0, 1520.0, 1520.0, 'Сулейман к 10, вернут туда же +7 937 575-03-93 гид резеда', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (775, client_id, 'completed', '2025-06-12', '2025-06-14', 3, 45, 0, 0, 0, NULL, true, 0, 10320.0, 10320.0, 'Оставила в Кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (774, client_id, 'completed', '2025-06-13', '2025-06-13', 1, 43, 0, 0, 0, NULL, true, 0, 3360.0, 3360.0, 'В кристалл, оставят там же в 17;00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (773, client_id, 'completed', '2025-06-14', '2025-06-15', 2, 42, 0, 0, 0, NULL, true, 0, 6400.0, 6400.0, 'В космос, вернут туда же после 20:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (772, client_id, 'completed', '2025-06-11', '2025-06-12', 2, 20, 0, 0, 0, NULL, true, 0, 2880.0, 2880.0, '18 штук на 11 и 12 июня. с 9.00 с апарт Отеля Пушкина 26', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (771, client_id, 'completed', '2025-06-10', '2025-06-12', 3, 34, 0, 0, 0, NULL, true, 0, 7680.0, 7680.0, '10 июня надо 32 радиогида (гид Аида 89033440899) Можно,если успеете в 7.30 в Кристалл, или в 08:30 – 09:30 Завтрак Кафе «Овсянки» ул.Бутлерова 34а 89046660417', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (769, client_id, 'completed', '2025-06-13', '2025-06-13', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'В Сафар, вернут в Сулейман', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (768, client_id, 'completed', '2025-06-12', '2025-06-12', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, 'В Сафар Вернут в релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (767, client_id, 'completed', '2025-06-12', '2025-06-12', 1, 54, 0, 0, 0, NULL, true, 0, 4080.0, 4080.0, 'Утром заберет в 08:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (765, client_id, 'completed', '2025-06-12', '2025-06-15', 3, 42, 0, 0, 0, NULL, true, 0, 8400.0, 8400.0, 'Радиогиды на все дни 40 человек 12-15 июня Отель Мираж Гид Ирина Баталова т +7 927 421-36-82 Приедут на жд в 10:50', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (764, client_id, 'completed', '2025-06-09', '2025-06-10', 2, 22, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (763, client_id, 'completed', '2025-06-09', '2025-06-09', 1, 26, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, 'В Татарстан Вернут туда же после 19', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Родина-тур%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (762, client_id, 'completed', '2025-06-14', '2025-06-16', 3, 40, 0, 0, 0, NULL, true, 0, 9120.0, 9120.0, 'Ирина Пронина. Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Пронина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (761, client_id, 'completed', '2025-06-13', '2025-06-13', 1, 45, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, 'Фатима', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (760, client_id, 'completed', '2025-06-07', '2025-06-08', 2, 46, 0, 0, 0, NULL, true, 0, 7040.0, 7040.0, '. 7.июня в 10 в Кристалл , радиогиды. 44 человека Гид Владимир Николаевич 89178858409 сдадут вечером 8 июня в Кристалл', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (759, client_id, 'completed', '2025-06-10', '2025-06-11', 2, 53, 0, 0, 0, NULL, true, 0, 8160.0, 8160.0, 'В 12 в Татарстан', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (758, client_id, 'completed', '2025-06-18', '2025-06-18', 1, 42, 0, 0, 0, NULL, true, 0, 2870.0, 2870.0, 'ВЕрнула в кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (757, client_id, 'completed', '2025-06-06', '2025-06-07', 1, 49, 0, 0, 0, NULL, true, 0, 7520.0, 7520.0, 'Будем в пятницу в кафе «Азу» в 15:00, возле айти', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (756, client_id, 'completed', '2025-06-12', '2025-06-14', 3, 53, 0, 0, 0, NULL, true, 0, 12240.0, 12240.0, 'В кристалл Гид Эльмира +7 917 878-83-60 Оставила в кристалле', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (755, client_id, 'completed', '2025-06-05', '2025-06-05', 1, 16, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, '08:30 утра отель Венера московская г. Казань, ул. Московская, д. 35. валерий матросов гид +7 905 319-54-86', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (754, client_id, 'completed', '2025-06-14', '2025-06-17', 4, 26, 0, 0, 0, NULL, true, 0, 6440.0, 6440.0, 'Максим горький', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (753, client_id, 'completed', '2025-06-13', '2025-06-14', 2, 47, 0, 0, 0, NULL, true, 0, 6300.0, 6300.0, 'Оставила в волге', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (752, client_id, 'completed', '2025-06-05', '2025-06-05', 1, 28, 0, 0, 0, NULL, true, 0, 2160.0, 2160.0, '27 штук , 5 июня в 06:00 забрать с жд вокзала Наталья. Ваучер на кремль', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена Павловна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (751, client_id, 'completed', '2025-06-06', '2025-06-06', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'Заберут. Ольга', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Минеева%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (750, client_id, 'completed', '2025-06-28', '2025-06-28', 1, 92, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'Кристал. Лариса', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Имя%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (749, client_id, 'completed', '2025-06-12', '2025-06-12', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Отель Дион Гид Юстасия, вернут утром к 10 на Баумана', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (748, client_id, 'completed', '2025-06-21', '2025-06-21', 1, 31, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'В кристалл Вернет в фургончик', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина Кореева%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (747, client_id, 'completed', '2025-06-04', '2025-06-05', 2, 17, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'Заберет после обеда, на связи', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (746, client_id, 'completed', '2025-06-03', '2025-06-05', 3, 36, 0, 0, 0, NULL, true, 0, 8160.0, 8160.0, '3-5 июня надо будет 34 радиогида в Кристалл к 10 . 30 сдадут вечером в Кристалл 5 июня гид Диана. +7 927 445-45-25', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (745, client_id, 'completed', '2025-06-07', '2025-06-07', 1, 44, 0, 0, 0, NULL, true, 0, 3440.0, 3440.0, 'В Сафар Вернут в Релиту в 23:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (744, client_id, 'completed', '2025-06-04', '2025-06-06', 3, 44, 0, 0, 0, NULL, true, 0, 10080.0, 10080.0, 'В кристалл Вернут в кристал 06 после 21:00 Гид Ванда 1 утерян', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (743, client_id, 'completed', '2025-06-20', '2025-06-21', 2, 47, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'Ирина пронина', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (742, client_id, 'completed', '2025-06-02', '2025-06-02', 1, 82, 0, 0, 0, NULL, true, 0, 6400.0, 6400.0, 'Рамада ~Антон Зенков +7 919 695‑73‑73', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (741, client_id, 'completed', '2025-06-04', '2025-06-04', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, '3 до 19 Забрать 5', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия Пашинин (НК Транс Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (740, client_id, 'completed', '2025-08-08', '2025-08-10', 3, 48, 0, 0, 0, NULL, true, 0, 11040.0, 11040.0, 'Кристал, Яна', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия Пашинин (НК Транс Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (739, client_id, 'completed', '2025-07-18', '2025-07-20', 3, 40, 0, 0, 0, NULL, true, 0, 9600.0, 9600.0, 'Кристал. Яна', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия Пашинин (НК Транс Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (738, client_id, 'completed', '2025-07-04', '2025-07-06', 3, 40, 0, 0, 0, NULL, true, 0, 9600.0, 9600.0, 'Кристал. Яна', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия Пашинин (НК Транс Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (737, client_id, 'completed', '2025-06-27', '2025-06-29', 3, 43, 0, 0, 0, NULL, true, 0, 9840.0, 9840.0, 'Кристал. Яна', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айгуль Файзуллина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (736, client_id, 'completed', '2025-06-06', '2025-06-08', 2, 53, 0, 0, 0, NULL, true, 0, 8320.0, 8320.0, 'Сумка в отели Раймонд', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия Пашинин (НК Транс Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (735, client_id, 'completed', '2025-06-06', '2025-06-08', 3, 43, 0, 0, 0, NULL, true, 0, 9840.0, 9840.0, 'Кристал. Яна', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (734, client_id, 'completed', '2025-06-28', '2025-06-30', 3, 24, 0, 0, 0, NULL, true, 0, 5280.0, 5280.0, '22 штуки 27,28,29,30 июня . гид Наталья Никифорова . 27 июня в 15:00 от жд восстания', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (733, client_id, 'completed', '2025-06-09', '2025-06-11', 3, 54, 0, 0, 0, NULL, true, 0, 12480.0, 12480.0, '52 штуки 9,10,11 июня . гид Катя Ильина . 7:50 от центрального жд', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (732, client_id, 'completed', '2025-06-28', '2025-06-28', 1, 31, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, '30 штук 28 июня 11:00 у отеля Шаляпин', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (731, client_id, 'completed', '2025-06-22', '2025-06-22', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, '40 штук 22 июня в 10:00 отель Дион ул.Алексея Козина д.3', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (730, client_id, 'completed', '2025-06-21', '2025-06-21', 1, 92, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, '45 штук 21 июня в 9:00 от Казанского Цирка', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (729, client_id, 'completed', '2025-06-14', '2025-06-14', 1, 22, 0, 0, 0, NULL, true, 0, 1680.0, 1680.0, '21 штука 14 июня в 06:00 ул.Галиаскара Камала 18', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (728, client_id, 'completed', '2025-06-13', '2025-06-14', 2, 36, 0, 0, 0, NULL, true, 0, 5440.0, 5440.0, '34 штуки. 13 июня -09:00- встреча Деревня Универсиады КПП 14 - 14 июня в 9:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (727, client_id, 'completed', '2025-06-12', '2025-06-12', 1, 52, 0, 0, 0, NULL, true, 0, 4080.0, 4080.0, '51 штука . 12 июня 10:30 у глав.входа цирка. Нурия . Ваучер на Кремль', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (726, client_id, 'completed', '2025-06-03', '2025-06-03', 1, 44, 0, 0, 0, NULL, true, 0, 3440.0, 3440.0, '3 июня нужно 43 штуки , в 9:00 ул.чернышевского 17. Гид Наталья Никифорова', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (725, client_id, 'completed', '2025-06-02', '2025-06-02', 1, 70, 0, 0, 0, NULL, true, 0, 5360.0, 5360.0, '67 штук в 10:00 . 2 гида . и 2 ваучера на кремль. Можно Диме передать вечером , он их будет отправлять', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (724, client_id, 'completed', '2025-05-30', '2025-05-30', 1, 16, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, 'Заберет из бусика', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александра (Александрия)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (723, client_id, 'completed', '2025-05-30', '2025-06-01', 3, 35, 0, 0, 0, NULL, true, 0, 7920.0, 7920.0, 'В Волгу Оставили в бусике', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (722, client_id, 'completed', '2025-05-30', '2025-05-30', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Вернет 31 в обед', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (721, client_id, 'completed', '2025-05-31', '2025-05-31', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'В офис тиц Вернут вечером', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (720, client_id, 'completed', '2025-05-30', '2025-05-31', 2, 34, 0, 0, 0, NULL, true, 0, 4960.0, 4960.0, 'Заберет в обед Завезет в кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (719, client_id, 'completed', '2025-05-31', '2025-05-31', 1, 60, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, 'Две сумки по 30шт Привезти к новому театру Камала в 14:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (718, client_id, 'completed', '2025-05-30', '2025-05-30', 1, 42, 0, 0, 0, NULL, true, 0, 3280.0, 3280.0, 'В Регину на Петербургской Вернут в районе 20:30 в Регину', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Иванов Семён%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (716, client_id, 'completed', '2025-06-03', '2025-06-03', 1, 20, 0, 0, 0, NULL, true, 0, 1520.0, 1520.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (715, client_id, 'completed', '2025-05-31', '2025-06-01', 2, 26, 0, 0, 0, NULL, true, 0, 3840.0, 3840.0, 'В Булак. Оставили в кристале', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Пронина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (714, client_id, 'completed', '2025-05-31', '2025-05-31', 1, 30, 0, 0, 0, NULL, true, 0, 2320.0, 2320.0, 'Заберет 30.05. В 17:15', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лариса%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (713, client_id, 'completed', '2025-05-28', '2025-05-28', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Лейла. Оставят в кристале', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Рената (Твоя Казань)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (712, client_id, 'completed', '2025-05-29', '2025-05-29', 1, 29, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, '29.05 до 16:00 в отель 13 на московской 13А', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (711, client_id, 'completed', '2025-05-30', '2025-05-30', 1, 18, 0, 0, 0, NULL, true, 0, 1360.0, 1360.0, '23.30 Корстон оставят', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (710, client_id, 'completed', '2025-06-13', '2025-06-14', 2, 32, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, 'Раймонд', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (709, client_id, 'completed', '2025-06-12', '2025-06-13', 2, 42, 0, 0, 0, NULL, true, 0, 6400.0, 6400.0, 'Утром в 8:30 заберет', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (708, client_id, 'completed', '2025-05-30', '2025-05-31', 2, 57, 0, 0, 0, NULL, true, 0, 8800.0, 8800.0, '+7 950 314-03-61 Ольга Оставит в кристалле', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (707, client_id, 'completed', '2025-05-27', '2025-05-27', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'Гранд отель Вернули туда же', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (706, client_id, 'completed', '2025-05-27', '2025-05-27', 1, 34, 0, 0, 0, NULL, true, 0, 2640.0, 2640.0, 'В Регину на университетской Вернули туда же', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Иванов Семён%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (705, client_id, 'completed', '2025-05-30', '2025-06-02', 3, 36, 0, 0, 0, NULL, true, 0, 8160.0, 8160.0, '30.05 В гостиницу Татарстан до 20:30, Оставит в бусике', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (704, client_id, 'completed', '2025-05-28', '2025-05-28', 1, 46, 0, 0, 0, NULL, true, 0, 3600.0, 3600.0, '27 принести 29 забрать', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (703, client_id, 'completed', '2025-05-31', '2025-06-01', 2, 30, 0, 0, 0, NULL, true, 0, 4480.0, 4480.0, '30 до 19:00 в мобильный трак Забрать можно 02.06 до 19:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (702, client_id, 'completed', '2025-05-26', '2025-05-27', 2, 40, 0, 0, 0, NULL, true, 0, 5320.0, 5320.0, 'Группа 38 чел+ гид Ирина т.+7 927 421-36-82 Нужны радиогиды *на завтра, на 26,27,мая* Завтра в 12:30 приезжают на ЖД центр, можно оставить в Кристалле. Забрать в Булаке', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (701, client_id, 'completed', '2025-05-25', '2025-05-25', 1, 37, 0, 0, 0, NULL, true, 0, 2880.0, 2880.0, '25.05 надо 36 радиогидов завести в 9-10 на Каюма Насыри 1/5б 2 этаж музей Бик тэмле, бик матур. с ними будет работать гид Марина 89172526993', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (700, client_id, 'completed', '2025-05-26', '2025-05-26', 1, 0, 0, 0, 0, NULL, true, 0, 7680.0, 7680.0, '26 мая в 9:30 ул.Лядова 16 Шк.№112 96 штук. 2 группы', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (699, client_id, 'completed', '2025-05-25', '2025-05-25', 1, 0, 0, 0, 0, NULL, true, 0, 5200.0, 5200.0, '25 мая в 10:30 гост.Татарстан . 65 штук. 2 группы', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Валентина Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (698, client_id, 'completed', '2025-05-25', '2025-05-25', 1, 31, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (697, client_id, 'completed', '2025-05-24', '2025-05-25', 2, 47, 0, 0, 0, NULL, true, 0, 7360.0, 7360.0, 'Заберет в 10:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Твой Гид%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (696, client_id, 'completed', '2025-05-24', '2025-05-25', 2, 26, 0, 0, 0, NULL, true, 0, 3840.0, 3840.0, 'Сумка в Азалии', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (694, client_id, 'completed', '2025-05-24', '2025-05-26', 3, 38, 0, 0, 0, NULL, true, 0, 8640.0, 8640.0, '24-26 мая гид Ольга 89503140361 36 человек 24- в Кристалл до 10.30 сдаст 26- в Кристалл после 17.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (693, client_id, 'completed', '2025-05-29', '2025-05-30', 2, 38, 0, 0, 0, NULL, true, 0, 5760.0, 5760.0, 'гид Ирина Палей 89046620732 сдаст 30- в отеле Давыдов на Назарбаева после 19.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (692, client_id, 'completed', '2025-05-25', '2025-05-25', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, '24 в Кристалл к 15.00 привести радиогиды на 35 человек для Ирины Палей 89046620732 для работы на 25 мая,т.к. она уедет 25.05 в Йошкар-Олу с ними в 5.30 утра. сдаст 25 мая после 18.00 по созвону.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (691, client_id, 'completed', '2025-05-24', '2025-05-25', 2, 35, 0, 0, 0, NULL, true, 0, 5280.0, 5280.0, '24-25 мая гид Владимир Николаевич 89178858409 заберет 24- в Кристалле в 7.30 на 33 человека.сдаст 25- на Баумана после 16.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (690, client_id, 'completed', '2025-05-24', '2025-05-24', 1, 16, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, 'Офис тиц', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Рената (Твоя Казань)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (688, client_id, 'completed', '2025-06-21', '2025-06-21', 1, 25, 0, 0, 0, NULL, true, 0, 1920.0, 1920.0, 'От отеля Мираж в 16:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Агентство Удачи)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (687, client_id, 'completed', '2025-06-19', '2025-06-19', 1, 143, 0, 0, 0, NULL, true, 0, 11200.0, 11200.0, 'Около 10 заберет утром Сумки на 48,48, 47 Вернет на следующий день к обеду', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (686, client_id, 'completed', '2025-05-23', '2025-05-23', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, 'Офис тиц Забрать утром 24', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (685, client_id, 'completed', '2025-05-23', '2025-05-23', 1, 70, 0, 0, 0, NULL, true, 0, 5440.0, 5440.0, 'Две сумки по 34шт забрать утром 24', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (684, client_id, 'completed', '2025-06-04', '2025-06-04', 1, 60, 0, 0, 0, NULL, true, 0, 36000.0, 36000.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (683, client_id, 'completed', '2025-05-25', '2025-05-27', 3, 53, 0, 0, 0, NULL, true, 0, 12240.0, 12240.0, '24.05 в тиц офис до 17 Забрать можно 27.05 после 21:00 в кристалле +7 965 586-88-06 Гид Ванда', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Яна (Вариот)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (682, client_id, 'completed', '2025-05-24', '2025-05-24', 1, 56, 0, 0, 0, NULL, true, 0, 4400.0, 4400.0, '23 оставить вечером в Азимут Сдадут 24 в азимут в районе 18 Оставила в Космосе', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (681, client_id, 'completed', '2025-05-22', '2025-05-22', 1, 62, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, 'оставить в Серфе на Подлужной и Сдала в бусик', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (680, client_id, 'completed', '2025-05-28', '2025-05-28', 1, 28, 0, 0, 0, NULL, true, 0, 2160.0, 2160.0, 'Уточнить', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Карина (технологии путешествий)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (678, client_id, 'completed', '2025-05-22', '2025-05-22', 1, 112, 0, 0, 0, NULL, true, 0, 8800.0, 8800.0, 'Две сумки по 55, в Корстон к 12', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (677, client_id, 'completed', '2025-05-24', '2025-05-24', 1, 14, 0, 0, 0, NULL, true, 0, 1040.0, 1040.0, 'Заберет сама 23 вечером Вернула в бусик', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лариса Позднякова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (676, client_id, 'completed', '2025-05-20', '2025-05-21', 2, 32, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, 'Заказ Аудигид: 30шт на 20.05,21.05 гостиница Фатима Карла Маркса 2', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (675, client_id, 'completed', '2025-05-17', '2025-05-18', 2, 35, 0, 0, 0, NULL, true, 0, 5280.0, 5280.0, 'Елена. +7 987 296‑95‑42. Сумка в кристале', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (674, client_id, 'completed', '2025-05-23', '2025-05-23', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'Заберет в кристалле, Оставила в офисе', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (672, client_id, 'completed', '2025-05-17', '2025-05-17', 1, 52, 0, 0, 0, NULL, true, 0, 4080.0, 4080.0, 'Закончат к 12', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (671, client_id, 'completed', '2025-05-17', '2025-05-17', 1, 41, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, 'Завезти в Булгар отель', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (670, client_id, 'completed', '2025-05-17', '2025-05-17', 1, 92, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'Две сумки на 45 на один день', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (669, client_id, 'completed', '2025-05-17', '2025-05-18', 2, 94, 0, 0, 0, NULL, true, 0, 14400.0, 14400.0, 'Две сумки по 45 на два дня', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (668, client_id, 'completed', '2025-06-15', '2025-06-16', 2, 33, 0, 0, 0, NULL, true, 0, 4960.0, 4960.0, '15 и 16 июня. На 31 человека. Забрать придется 14 июня, тк программа обслуживания начинается 15 июня в 05:00 утра.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (667, client_id, 'completed', '2025-06-28', '2025-06-29', 2, 37, 0, 0, 0, NULL, true, 0, 5600.0, 5600.0, 'Уточнить', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (666, client_id, 'completed', '2025-05-16', '2025-05-16', 1, 25, 0, 0, 0, NULL, true, 0, 1600.0, 1600.0, '5 переводчиков и 5 микрофонов', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (664, client_id, 'completed', '2025-05-27', '2025-05-28', 2, 30, 0, 0, 0, NULL, true, 0, 5600.0, 5600.0, '(Чайка Ю) Катя Кореева В дом чая к 15:30 Вернет в кристал', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гузель (Юралс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (663, client_id, 'completed', '2025-05-17', '2025-05-17', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, 'Заберут 16 мая', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (662, client_id, 'completed', '2025-05-26', '2025-05-28', 3, 31, 0, 0, 0, NULL, true, 0, 8700.0, 8700.0, 'Воронеж Гид Екатерина Геннадьевна 89275662530 Оставила в Шаляпине', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия (Рыжий Слон)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (661, client_id, 'completed', '2025-05-21', '2025-05-23', 3, 38, 0, 0, 0, NULL, true, 0, 8640.0, 8640.0, 'Кристал. Гид Элина', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (660, client_id, 'completed', '2025-05-16', '2025-05-16', 1, 31, 0, 0, 0, NULL, true, 0, 2100.0, 2100.0, '16 мая, будет 30 человек + гид Владимир т. +7 917 885-84-09 Начало 16 мая в 8:00 от ЦЖД,(можно оставить в Кристалле) на 1 день, заканчивают в 17 ч в отеле 55 ( ул. Островского 55)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (659, client_id, 'completed', '2025-05-23', '2025-05-24', 2, 33, 0, 0, 0, NULL, true, 0, 6200.0, 6200.0, 'М- Поет-2 Экскурсовод Марина Николаевна +7 927 429-91-77 Вернет в 22 в Кристал', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (658, client_id, 'completed', '2025-05-16', '2025-05-16', 1, 25, 0, 0, 0, NULL, true, 0, 1920.0, 1920.0, 'Заберут. Начало в 12:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (657, client_id, 'completed', '2025-05-17', '2025-05-17', 1, 44, 0, 0, 0, NULL, true, 0, 3440.0, 3440.0, 'В Сафар Заканчивают в 23:30 в Корстон', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (656, client_id, 'completed', '2025-05-28', '2025-05-28', 1, 48, 0, 0, 0, NULL, true, 0, 3760.0, 3760.0, 'Сама заберет 29 утром занесет', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Москва%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (655, client_id, 'completed', '2025-05-24', '2025-05-25', 2, 27, 0, 0, 0, NULL, true, 0, 5000.0, 5000.0, 'На ресепшен отеля Максим Горький Вернула в Кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
END $$;