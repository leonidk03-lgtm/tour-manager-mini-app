-- Часть 5 из 7
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
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (432, client_id, 'completed', '2025-01-03', '2025-01-04', 2, 25, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, '3,4 января.гид Аида +79033440899 3.01 в 14:00 - 14:45 Обед в кафе города Кафе Медина ул.Татарстан,7 вернут 4.01 вернут после 15 в Кристалл', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (431, client_id, 'completed', '2025-01-04', '2025-01-05', 2, 42, 0, 0, 0, NULL, true, 0, 6400.0, 6400.0, '4,5 января. Гид Виолетта +79053171049 4.01 в Отель Кристалл 3*к 8.30 вернут 5.01 после 22.00 в Кристалл', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (430, client_id, 'completed', '2025-01-03', '2025-01-04', 2, 48, 0, 0, 0, NULL, true, 0, 7360.0, 7360.0, '3.4 января гид Шуравина Ольга +79503140361 3-привезти в ресторан Ферма.ул.Бурхана Шахиди,11 вернут 4.января в отель Сулейман. Обед 12-13', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алена Волина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (429, client_id, 'completed', '2024-12-31', '2024-12-31', 1, 46, 0, 0, 0, NULL, true, 0, 3600.0, 3600.0, 'Колобок на Гафури', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (428, client_id, 'completed', '2025-01-08', '2025-01-09', 2, 71, 0, 0, 0, NULL, true, 0, 9380.0, 9380.0, 'Кристал 1 группа 30 человека + гид Ирина 2 группа 37 человек + гид Владимир', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юрий%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (427, client_id, 'completed', '2025-01-06', '2025-01-08', 3, 52, 0, 0, 0, NULL, true, 0, 12000.0, 12000.0, 'Волга Гид Наталья', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (426, client_id, 'completed', '2024-12-31', '2025-01-02', 3, 42, 0, 0, 0, NULL, true, 0, 9600.0, 9600.0, 'Заберет сама вечером', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (425, client_id, 'completed', '2024-12-31', '2025-01-02', 3, 47, 0, 0, 0, NULL, true, 0, 10800.0, 10800.0, 'Заберет сама вечером', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (424, client_id, 'completed', '2024-12-31', '2025-01-02', 2, 50, 0, 0, 0, NULL, true, 0, 11520.0, 11520.0, 'Хаял кушают в 9:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (423, client_id, 'completed', '2025-01-06', '2025-01-06', 1, 47, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, 'вернут в мано', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (422, client_id, 'completed', '2024-12-27', '2024-12-29', 2, 30, 0, 0, 0, NULL, true, 0, 4480.0, 4480.0, 'Кристал Владимир Николаевич', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (421, client_id, 'completed', '2024-12-21', '2024-12-21', 1, 26, 0, 0, 0, NULL, true, 0, 1750.0, 1750.0, 'На завтра 21.12 на 1 день Нужны гиды для группы 25 человек + гид Владимир т. 89178858409 Оставить для Владимира Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (419, client_id, 'completed', '2025-01-05', '2025-01-05', 1, 35, 0, 0, 0, NULL, true, 0, 3120.0, 3120.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (418, client_id, 'completed', '2025-01-03', '2025-01-03', 1, 47, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (417, client_id, 'completed', '2024-12-21', '2024-12-21', 1, 24, 0, 0, 0, NULL, true, 0, 1840.0, 1840.0, 'Экскурсовод Инна', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (416, client_id, 'completed', '2025-01-05', '2025-01-07', 3, 31, 0, 0, 0, NULL, true, 0, 6960.0, 6960.0, '5 января начало в 16.00 от хостела Пушкин, (Пушкина 1/55)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Твой Гид%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (414, client_id, 'completed', '2024-12-14', '2024-12-15', 2, 40, 0, 0, 0, NULL, true, 0, 5920.0, 5920.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александр Романов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (413, client_id, 'completed', '2024-12-14', '2024-12-15', 2, 21, 0, 0, 0, NULL, true, 0, 3040.0, 3040.0, 'Карат', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (412, client_id, 'completed', '2024-12-14', '2024-12-14', 1, 35, 0, 0, 0, NULL, true, 0, 2640.0, 2640.0, 'Кристал Катя Ильина 2 передатчика', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга Лукоянова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (411, client_id, 'completed', '2024-12-14', '2024-12-14', 1, 31, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (410, client_id, 'completed', '2024-12-13', '2024-12-14', 2, 39, 0, 0, 0, NULL, true, 0, 5920.0, 5920.0, 'Гвардейская', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (409, client_id, 'completed', '2024-12-07', '2024-12-07', 1, 33, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, 'В 11:00. От Шаляпина Катя Ильина', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (408, client_id, 'completed', '2024-12-07', '2024-12-07', 1, 26, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, 'Кристал. Элина', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (407, client_id, 'completed', '2024-12-06', '2024-12-06', 1, 46, 0, 0, 0, NULL, true, 0, 3150.0, 3150.0, 'Шаляпин', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (406, client_id, 'completed', '2024-12-05', '2024-12-05', 1, 20, 0, 0, 0, NULL, true, 0, 1330.0, 1330.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (405, client_id, 'completed', '2024-12-05', '2024-12-05', 1, 16, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (404, client_id, 'completed', '2024-11-29', '2024-11-29', 1, 16, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (403, client_id, 'completed', '2024-11-28', '2024-11-28', 1, 112, 0, 0, 0, NULL, true, 0, 8640.0, 8640.0, 'Приедет 13:30 к Шаляпину', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (402, client_id, 'completed', '2024-11-26', '2024-11-26', 1, 16, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, '9:50. У иконы. забрать в кристале', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (401, client_id, 'completed', '2024-11-22', '2024-11-22', 1, 50, 0, 0, 0, NULL, true, 0, 3920.0, 3920.0, 'Завтра в 13:00 отель Мано на Чистопольской 47А. Нужно 49 радиогидов. С ними будет Гульнара.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (400, client_id, 'completed', '2024-11-22', '2024-11-22', 1, 50, 0, 0, 0, NULL, true, 0, 3840.0, 3840.0, '+7 917 252-69-93. Марина Рукавишникова 48 шт. В 9.30-19.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (399, client_id, 'completed', '2025-01-05', '2025-01-07', 3, 54, 0, 0, 0, NULL, true, 0, 12480.0, 12480.0, 'Оставила в офисе', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (398, client_id, 'completed', '2025-01-03', '2025-01-03', 1, 53, 0, 0, 0, NULL, true, 0, 4160.0, 4160.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (397, client_id, 'completed', '2024-11-18', '2024-11-18', 1, 26, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, 'Наталья', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (396, client_id, 'completed', '2024-11-18', '2024-11-18', 1, 60, 0, 0, 0, NULL, true, 0, 4720.0, 4720.0, 'Элина', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Титова Галина (Эллинлайн)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (395, client_id, 'completed', '2024-11-30', '2024-12-01', 2, 34, 0, 0, 0, NULL, true, 0, 5120.0, 5120.0, 'Прошу Вас выставить счёт на группу 32+1 гид. 30.11-1.12,, завтрак Биляр Палас, гид 89030624411 Елена Анатольевна.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (394, client_id, 'completed', '2024-11-18', '2024-11-20', 3, 41, 0, 0, 0, NULL, true, 0, 8190.0, 8190.0, 'Группа Хостел Пушкин, ул.Пушкина 1/55 а на 18-20 ноября 39 человек + гид Лариса т. 89272408250', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (393, client_id, 'completed', '2024-11-18', '2024-11-19', 2, 38, 0, 0, 0, NULL, true, 0, 5040.0, 5040.0, 'Группа Хостел Nice, ул. Петербургская 40 б на 18 и 19 ноября 36 человек + гид Татьяна т.89063271840', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лейла%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (392, client_id, 'completed', '2024-11-19', '2024-11-19', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (391, client_id, 'completed', '2024-11-17', '2024-11-17', 1, 13, 0, 0, 0, NULL, true, 0, 1200.0, 1200.0, 'Лариса. Сумка 14', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Искандер%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (390, client_id, 'completed', '2024-11-16', '2024-11-18', 3, 24, 0, 0, 0, NULL, true, 0, 3300.0, 3300.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (389, client_id, 'completed', '2024-11-16', '2024-11-19', 4, 35, 0, 0, 0, NULL, true, 0, 10560.0, 10560.0, 'Кристал, Настя', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (388, client_id, 'completed', '2024-11-15', '2024-11-15', 1, 33, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, 'Добрый вечер. Заказ на 15.11 в 9 утра , ГОСТ. Кристалл, 32 чел. На имя Элли', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (387, client_id, 'completed', '2024-11-10', '2024-11-10', 1, 31, 0, 0, 0, NULL, true, 0, 2100.0, 2100.0, 'Ривьера', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (386, client_id, 'completed', '2024-11-08', '2024-11-08', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'и завтра в 10:00 отель Регата 50 человек радиогиды , с ними Лариса Семенова', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (385, client_id, 'completed', '2024-11-08', '2024-11-08', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, 'на завтра в 10:00 от Сафар отеля нужно 35 радиогидов. с группой будет Катя Ильина', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ильмира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (384, client_id, 'completed', '2024-11-07', '2024-11-07', 1, 28, 0, 0, 0, NULL, true, 0, 2160.0, 2160.0, '26 шт. радиогидов на 1 день (беру 07.11.(чт) в 14.00)', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ильмира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (383, client_id, 'completed', '2024-11-04', '2024-11-04', 1, 30, 0, 0, 0, NULL, true, 0, 2320.0, 2320.0, 'Фиолетовые', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (382, client_id, 'completed', '2024-11-03', '2024-11-03', 1, 25, 0, 0, 0, NULL, true, 0, 1680.0, 1680.0, 'Кристал. Лилия. Мариотт', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (381, client_id, 'completed', '2024-11-06', '2024-11-07', 2, 45, 0, 0, 0, NULL, true, 0, 7040.0, 7040.0, 'на 6,7 ноября. Гид Игорь. +7 927 405-50-70 44 шт. В Давыдов на Назарбаева к 10.30. Сдадут7 ноября в Кристалл после 17.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Александр%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (380, client_id, 'completed', '2024-12-31', '2025-01-02', 3, 46, 0, 0, 0, NULL, true, 0, 10560.0, 10560.0, 'Инна +79869297050 Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (379, client_id, 'completed', '2024-11-01', '2024-11-01', 1, 45, 0, 0, 0, NULL, true, 0, 3360.0, 3360.0, 'Баумана в 9:50. забрать в Мариотте', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (378, client_id, 'completed', '2024-11-01', '2024-11-02', 1, 26, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Ольга ткач', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (377, client_id, 'completed', '2024-11-05', '2024-11-06', 2, 26, 0, 0, 0, NULL, true, 0, 3500.0, 3500.0, '5.11 в 10.30 Казань 1 прибытие - 6.11 в 17.00 привозим на Казань 1 - Гид: +79872969542 Елена - 140 руб. * 25 наушников = 3 500 руб. - гид оплатит на месте', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (376, client_id, 'completed', '2024-11-01', '2024-11-01', 1, 11, 0, 0, 0, NULL, true, 0, 800.0, 800.0, 'Сулейман начало в 15:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (375, client_id, 'completed', '2024-11-03', '2024-11-04', 2, 44, 0, 0, 0, NULL, true, 0, 6880.0, 6880.0, 'Карат на Сары садыковой', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (374, client_id, 'completed', '2024-10-31', '2024-11-01', 2, 20, 0, 0, 0, NULL, true, 0, 2310.0, 2310.0, 'Сафар', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (373, client_id, 'completed', '2024-11-30', '2024-12-01', 2, 53, 0, 0, 0, NULL, true, 0, 8160.0, 8160.0, 'Гид Елена', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (372, client_id, 'completed', '2024-11-16', '2024-11-17', 2, 51, 0, 0, 0, NULL, true, 0, 8000.0, 8000.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (371, client_id, 'completed', '2024-11-09', '2024-11-10', 2, 51, 0, 0, 0, NULL, true, 0, 8000.0, 8000.0, 'Гид Елена Волга 12:30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (370, client_id, 'completed', '2024-11-03', '2024-11-04', 2, 43, 0, 0, 0, NULL, true, 0, 6720.0, 6720.0, 'И нужно будет 3- 4.11 От меня Данил наберёт и заберёт.Он будет вести нашу группу', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Искандер%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (369, client_id, 'completed', '2024-10-30', '2024-10-30', 1, 34, 0, 0, 0, NULL, true, 0, 1650.0, 1650.0, 'В офис 14:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (368, client_id, 'completed', '2024-10-31', '2024-11-01', 2, 43, 0, 0, 0, NULL, true, 0, 6720.0, 6720.0, 'Добрый вечер. На 31 надо в АМАКС сафар отель 42 шт на 31-1. Гид Игорь +7 927 405-50-70. По поводу возврата созвонитесь, пожалуйста', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (367, client_id, 'completed', '2024-10-30', '2024-10-31', 2, 22, 0, 0, 0, NULL, true, 0, 2940.0, 2940.0, 'Добрый вечер, Леонид! Группа 21 человек +гид Лиля т. +7 965 602-05-28 На 2 дня 30 октября и 31 октября Проживают в отеле Булгар, Вишневского 21 Будет возможность?', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (366, client_id, 'completed', '2024-10-30', '2024-10-31', 2, 46, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (365, client_id, 'completed', '2024-10-28', '2024-10-30', 2, 22, 0, 0, 0, NULL, true, 0, 3360.0, 3360.0, 'На 28 и 30 нужны 21 радиогиды в 13,30 у них сегодня обед в Ресторанном дворе( стерлядке) гид Диляра +7 917 927-54-89', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (364, client_id, 'completed', '2024-10-28', '2024-10-28', 1, 22, 0, 0, 0, NULL, true, 0, 1680.0, 1680.0, 'Ольга +79872965880', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (363, client_id, 'completed', '2024-10-29', '2024-11-01', 3, 37, 0, 0, 0, NULL, true, 0, 8640.0, 8640.0, '29-31 36шт. 29-в Кристалл к 9.30 сдадут 1 ноября после 16.00 в Кристалл гид Марина +79053130120', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (362, client_id, 'completed', '2024-10-28', '2024-10-30', 3, 35, 0, 0, 0, NULL, true, 0, 8160.0, 8160.0, '28-30 34шт. 28-Кристалл в 11.00 гид Игорь +79274055070, сдадут 30-после 16. 12:00 донкихот', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (361, client_id, 'completed', '2024-10-28', '2024-10-30', 3, 38, 0, 0, 0, NULL, true, 0, 8880.0, 8880.0, '28-30 37 шт. 28-Кристалл к 12, сдадут 30 по созвону после 15 гид Диана +79274454525', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (360, client_id, 'completed', '2024-10-27', '2024-10-29', 3, 35, 0, 0, 0, NULL, true, 0, 8160.0, 8160.0, '27-29 34 шт.27-Сулейман к 8.00 29-сдаст в офис после 15.00 гид Марина +79172526993', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (359, client_id, 'completed', '2024-10-27', '2024-10-30', 4, 35, 0, 0, 0, NULL, true, 0, 10880.0, 10880.0, '27-30 34 шт. 27- отель Волга 8.40 завтрак сдадут 30-Кристалл после 21 гид Ольга +79503140361', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (358, client_id, 'completed', '2024-10-30', '2024-10-30', 1, 32, 0, 0, 0, NULL, true, 0, 2480.0, 2480.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (357, client_id, 'completed', '2024-10-28', '2024-10-28', 1, 42, 0, 0, 0, NULL, true, 0, 3280.0, 3280.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (356, client_id, 'completed', '2024-10-31', '2024-11-01', 2, 24, 0, 0, 0, NULL, true, 0, 3220.0, 3220.0, 'Группа 23 чел+гид Татьяна т.89063271840- 2 дня Оставить 30 октября в отеле Кристал. 1.11. отель болгар', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (355, client_id, 'completed', '2024-10-29', '2024-10-29', 1, 18, 0, 0, 0, NULL, true, 0, 1190.0, 1190.0, 'Группа 17 чел+гид Булат т.89376173315 - 1 день Оставить 28 октября в отеле Булгар 2,ул.Вишневского 21*', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (354, client_id, 'completed', '2024-10-28', '2024-10-29', 2, 44, 0, 0, 0, NULL, true, 0, 6020.0, 6020.0, '4) Группа 43 чел+гид Ирина т.89274213682 - 2 дня с 28-29 окт, Оставить 27 октября в хостоле "Дом 64", ул Большая Красная 64', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (353, client_id, 'completed', '2024-10-26', '2024-10-28', 3, 42, 0, 0, 0, NULL, true, 0, 8610.0, 8610.0, '3) Группа 41 чел+гид Маргарита т.89063263820 -на *3 ДНЯ* с 26-28 окт, на 3й день возращает гид Татьяна т.89063271840 Оставить сегодня в отеле Булгар 2,ул.Вишневского 21*сумка в Шаляпин', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (352, client_id, 'completed', '2024-10-25', '2024-10-27', 3, 37, 0, 0, 0, NULL, true, 0, 8640.0, 8640.0, 'Настя Автобус 981', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (351, client_id, 'completed', '2024-10-26', '2024-10-26', 1, 29, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, 'Уточнить у Кати', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (350, client_id, 'completed', '2024-11-02', '2024-11-03', 2, 25, 0, 0, 0, NULL, true, 0, 3840.0, 3840.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (349, client_id, 'completed', '2024-10-26', '2024-10-26', 1, 110, 0, 0, 0, NULL, true, 0, 7560.0, 7560.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Валентина Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (348, client_id, 'completed', '2024-10-28', '2024-10-28', 1, 54, 0, 0, 0, NULL, true, 0, 4240.0, 4240.0, 'Волга', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена Марковна ( черный список)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (347, client_id, 'completed', '2024-10-30', '2024-10-31', 2, 50, 0, 0, 0, NULL, true, 0, 7840.0, 7840.0, 'Гранд отель к 12', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ксения%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (346, client_id, 'completed', '2024-10-29', '2024-10-29', 1, 86, 0, 0, 0, NULL, true, 0, 6720.0, 6720.0, '2 группы', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (345, client_id, 'completed', '2024-10-31', '2024-11-02', 3, 47, 0, 0, 0, NULL, true, 0, 9660.0, 9660.0, 'Лейла +79172488804', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (344, client_id, 'completed', '2024-10-31', '2024-11-02', 3, 42, 0, 0, 0, NULL, true, 0, 8610.0, 8610.0, 'Диляра +79179275489', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (343, client_id, 'completed', '2024-10-29', '2024-10-31', 3, 50, 0, 0, 0, NULL, true, 0, 10290.0, 10290.0, 'Ангелина +79872050601. Татарская усадьба', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лиля Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (342, client_id, 'completed', '2024-10-26', '2024-10-26', 1, 8, 0, 0, 0, NULL, true, 0, 800.0, 800.0, 'в 12 заберет', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (341, client_id, 'completed', '2024-10-28', '2024-10-29', 2, 34, 0, 0, 0, NULL, true, 0, 4620.0, 4620.0, '28.10 в 10.30 Казань 1 прибытие - 29.10 в 17.00 привозим на Казань 1 - Гид: +7 905 316-29-73 Елена - 140 руб. * 33 наушников = 4 620 руб. - гид оплатит на месте', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (340, client_id, 'completed', '2024-10-25', '2024-10-26', 2, 45, 0, 0, 0, NULL, true, 0, 6160.0, 6160.0, '25.10 в 7.30 Казань 1 прибытие - 26.10 в 18.30 привозим на Казань 1 - Гид: +7 905 316-29-73 Елена - 140 руб. * 44 наушников = 6 160 руб. - гид оплатит на месте', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Светлана Клиент%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (339, client_id, 'completed', '2024-10-25', '2024-10-27', 3, 34, 0, 0, 0, NULL, true, 0, 7680.0, 7680.0, 'Жд 11:00 вернут 27.10 в 15:00 Дурсун. +7 919 699-29-68', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга Волковец%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (338, client_id, 'completed', '2024-10-18', '2024-10-20', 3, 19, 0, 0, 0, NULL, true, 0, 4080.0, 4080.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эмилия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (337, client_id, 'completed', '2024-10-26', '2024-10-26', 1, 46, 0, 0, 0, NULL, true, 0, 3600.0, 3600.0, '26.10 в 9 утра поезд, оставить в кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (335, client_id, 'completed', '2024-10-16', '2024-10-18', 3, 29, 0, 0, 0, NULL, true, 0, 6480.0, 6480.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (334, client_id, 'completed', '2024-10-12', '2024-10-12', 1, 26, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камилла%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (333, client_id, 'completed', '2024-10-11', '2024-10-13', 2, 40, 0, 0, 0, NULL, true, 0, 6400.0, 6400.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (332, client_id, 'completed', '2024-10-11', '2024-10-13', 2, 33, 0, 0, 0, NULL, true, 0, 6510.0, 6510.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (331, client_id, 'completed', '2024-10-27', '2024-10-27', 1, 48, 0, 0, 0, NULL, true, 0, 3760.0, 3760.0, 'Группа приезжает 26 октября в 13:00 и будет ночевать в Фатиме. 27 октября отправится на экскурсию в 08:00 И закончит в 14:00-14:30 у театра кукол', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (330, client_id, 'completed', '2024-10-12', '2024-10-12', 1, 53, 0, 0, 0, NULL, true, 0, 4160.0, 4160.0, '14:00 туган авылым', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (329, client_id, 'completed', '2024-10-11', '2024-10-11', 1, 107, 0, 0, 0, NULL, true, 0, 8400.0, 8400.0, '13:30 дом чая Забрать в крыльях', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (328, client_id, 'completed', '2024-10-11', '2024-10-12', 2, 26, 0, 0, 0, NULL, true, 0, 3840.0, 3840.0, 'Волга', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (327, client_id, 'completed', '2024-10-12', '2024-10-13', 2, 50, 0, 0, 0, NULL, true, 0, 7680.0, 7680.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (326, client_id, 'completed', '2024-10-30', '2024-10-30', 1, 47, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, '30-46 шт. в Давыдов на Назарбаева к 10, сдадут в Кристалл в 21 гид Марина +79053130120', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (324, client_id, 'completed', '2024-10-30', '2024-11-01', 3, 48, 0, 0, 0, NULL, true, 0, 11520.0, 11520.0, '30-1.11 48 шт. 30-в 11.30 завтрак в Алан аш на Ш.Марджани,8 сдадут 1 ноября в 21.00 в Кристалл гид Нелли Рифовна +79063237048', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (323, client_id, 'completed', '2024-10-29', '2024-10-31', 3, 37, 0, 0, 0, NULL, true, 0, 8640.0, 8640.0, '29-31 36шт. 29-Кристалл к 8.30 , сдадут 31-в Кристалл в 18.00 гид Аида +79033440899', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (322, client_id, 'completed', '2024-10-29', '2024-10-31', 3, 33, 0, 0, 0, NULL, true, 0, 7920.0, 7920.0, '29-31 (без30) 33 шт. 29- завтрак в Волге в 7.30 гид Игорь +79274055070 сдадут 31 после 17 в Кристалл гид Виолетта +79053171049', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (321, client_id, 'completed', '2024-10-28', '2024-10-30', 3, 29, 0, 0, 0, NULL, true, 0, 6720.0, 6720.0, '28-30 28 шт. 28-Кристаллв 13.00 гид Гузель +79033142074 сдадут 30- в 20.00 Кристалл гид Гульназ +79393902610', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (320, client_id, 'completed', '2024-10-27', '2024-10-30', 4, 36, 0, 0, 0, NULL, true, 0, 8400.0, 8400.0, '27-30 без 28 октября 35шт.27-кафе Медина на Спартаковской к 8.30 возврат по созвону30 -после 16.00 гид Виолетта +79053171049. Забрать в офисе', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (319, client_id, 'completed', '2024-10-27', '2024-10-28', 3, 47, 0, 0, 0, NULL, true, 0, 7360.0, 7360.0, '46 шт. 27-в Кристалл к 11.30 гид Юля +79178863309. сдадут 28- по созвону после 14.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (318, client_id, 'completed', '2024-10-26', '2024-10-28', 3, 35, 0, 0, 0, NULL, true, 0, 8160.0, 8160.0, 'оставят в Кристалле 28.10. Гид Дания +79172904415 после 22.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (317, client_id, 'completed', '2024-10-27', '2024-10-27', 1, 30, 0, 0, 0, NULL, true, 0, 2320.0, 2320.0, '29 шт. отель Ямле к 9.00 сдадут по договоренности после 14.30 гид Гульназ +79393902610', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (316, client_id, 'completed', '2024-10-26', '2024-10-27', 2, 28, 0, 0, 0, NULL, true, 0, 4320.0, 4320.0, '26-27- 27 шт. В Кристалл к 7.30 , сдадут в Кристалл 27.10 после20. 30 26-27 последняя моя запись гид Лилия. +79872975449', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (315, client_id, 'completed', '2024-10-26', '2024-10-26', 1, 32, 0, 0, 0, NULL, true, 0, 2480.0, 2480.0, '26 октября к 9.40 в Давыдов на Назарбаева 31 шт на один день сдадут туда же после 17,30 гид Ирина 89274213682', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (314, client_id, 'completed', '2024-10-25', '2024-10-27', 3, 31, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, '25-27 октября в Кристалл к 7,30 сдадут в 17,30 - в Кристалл 30 шт. Гид Диляра Рафаровна +79179275489', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (313, client_id, 'completed', '2024-10-25', '2024-10-25', 1, 26, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, '25 шт. В Кристалл к 11.30 сдадут на Баумана в офис16. 30 гид Виолетта +79053171049', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (310, client_id, 'completed', '2024-10-28', '2024-10-30', 3, 34, 0, 0, 0, NULL, true, 0, 7680.0, 7680.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (308, client_id, 'completed', '2024-10-07', '2024-10-09', 3, 38, 0, 0, 0, NULL, true, 0, 8400.0, 8400.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (307, client_id, 'completed', '2024-10-05', '2024-10-05', 1, 56, 0, 0, 0, NULL, true, 0, 7700.0, 7700.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (306, client_id, 'completed', '2024-10-06', '2024-10-08', 3, 28, 0, 0, 0, NULL, true, 0, 5460.0, 5460.0, '6.10 в 10.30 Казань 1 прибытие - 8.10 в 17.00 привозим на Казань 1 - Гид: +79872969542 Елена - 210 руб. * 26 наушников = 5 460 руб. - гид оплатит на месте', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (305, client_id, 'completed', '2024-10-04', '2024-10-04', 1, 50, 0, 0, 0, NULL, true, 0, 3920.0, 3920.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (304, client_id, 'completed', '2024-10-03', '2024-10-05', 3, 27, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Морозова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (303, client_id, 'completed', '2024-10-13', '2024-10-13', 1, 55, 0, 0, 0, NULL, true, 0, 4320.0, 4320.0, 'Света', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (302, client_id, 'completed', '2024-10-02', '2024-10-03', 2, 28, 0, 0, 0, NULL, true, 0, 4160.0, 4160.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (301, client_id, 'completed', '2024-10-02', '2024-10-02', 1, 50, 0, 0, 0, NULL, true, 0, 3920.0, 3920.0, 'Кристал, Катя', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айрат Нурмухаммадов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (300, client_id, 'completed', '2024-10-08', '2024-10-09', 2, 31, 0, 0, 0, NULL, true, 0, 3920.0, 3920.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (299, client_id, 'completed', '2024-10-05', '2024-10-06', 2, 51, 0, 0, 0, NULL, true, 0, 7840.0, 7840.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (298, client_id, 'completed', '2024-09-30', '2024-10-03', 4, 54, 0, 0, 0, NULL, true, 0, 16640.0, 16640.0, '30 . 09 надо 52 радиогида в Кристалле в 7.30 отдадут 3.10 в Кристалл после 15.00 гид Диляра Рафаровна 89179275489', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (297, client_id, 'completed', '2024-09-28', '2024-09-28', 1, 49, 0, 0, 0, NULL, true, 0, 3360.0, 3360.0, '46 человек +1 гид Встреча возле ЦУМа ожидается прибытие в 14:00,в 20:30 ужинают в отеле Хаял, и едут на заселение в Биляр Инн, краснокошайская 187 Гид Екатерина +7 927 430-72-44', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (296, client_id, 'completed', '2024-09-27', '2024-09-29', 3, 46, 0, 0, 0, NULL, true, 0, 10560.0, 10560.0, '27-29 44 шт. Кристалл 11.30-вернут в Авиатор в 19.00 гид Баталова Ирина 89274213682', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (295, client_id, 'completed', '2024-09-27', '2024-09-29', 3, 28, 0, 0, 0, NULL, true, 0, 6240.0, 6240.0, '27-29 26 шт. Кристалл в 10.30, вернут Кристалл в 20.00 гид Шуравина Ольга 89503140361', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (294, client_id, 'completed', '2024-09-27', '2024-09-28', 2, 30, 0, 0, 0, NULL, true, 0, 4480.0, 4480.0, '27-28 - 28 шт. Кристалл в 9.00 вернут Кристалл в 14. гид Диляра Рафаровна 89179275489', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (293, client_id, 'completed', '2024-09-28', '2024-09-29', 2, 35, 0, 0, 0, NULL, true, 0, 4620.0, 4620.0, 'Кристал Гид: Елена +79872969542', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (292, client_id, 'completed', '2024-10-31', '2024-10-31', 1, 46, 0, 0, 0, NULL, true, 0, 3600.0, 3600.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (291, client_id, 'completed', '2024-09-28', '2024-09-28', 1, 33, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (290, client_id, 'completed', '2024-09-27', '2024-09-28', 2, 24, 0, 0, 0, NULL, true, 0, 3080.0, 3080.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (289, client_id, 'completed', '2024-09-25', '2024-09-28', 4, 53, 0, 0, 0, NULL, true, 0, 16000.0, 16000.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (288, client_id, 'completed', '2024-11-02', '2024-11-02', 1, 50, 0, 0, 0, NULL, true, 0, 3920.0, 3920.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (287, client_id, 'completed', '2024-09-26', '2024-09-26', 1, 34, 0, 0, 0, NULL, true, 0, 2640.0, 2640.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (286, client_id, 'completed', '2024-09-23', '2024-09-23', 1, 51, 0, 0, 0, NULL, true, 0, 3500.0, 3500.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (283, client_id, 'completed', '2024-10-05', '2024-10-06', 2, 47, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (282, client_id, 'completed', '2024-09-28', '2024-09-29', 2, 39, 0, 0, 0, NULL, true, 0, 5920.0, 5920.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (281, client_id, 'completed', '2024-09-25', '2024-09-27', 3, 51, 0, 0, 0, NULL, true, 0, 11760.0, 11760.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (280, client_id, 'completed', '2024-09-20', '2024-09-20', 1, 40, 0, 0, 0, NULL, true, 0, 3040.0, 3040.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (279, client_id, 'completed', '2024-09-20', '2024-09-22', 3, 50, 0, 0, 0, NULL, true, 0, 11520.0, 11520.0, 'Забрать в свияжске', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (278, client_id, 'completed', '2024-09-20', '2024-09-21', 2, 17, 0, 0, 0, NULL, true, 0, 2100.0, 2100.0, 'Кристал. Сумка 1', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (277, client_id, 'completed', '2024-09-20', '2024-09-22', 3, 35, 0, 0, 0, NULL, true, 0, 7920.0, 7920.0, 'В хаял. Вернут в офис. Сумка 2', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (276, client_id, 'completed', '2024-09-20', '2024-09-21', 2, 32, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, 'В хаял. Вернут в кристал. Сумка 10', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (275, client_id, 'completed', '2024-09-18', '2024-09-18', 1, 35, 0, 0, 0, NULL, true, 0, 2720.0, 2720.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (274, client_id, 'completed', '2024-10-31', '2024-11-02', 3, 27, 0, 0, 0, NULL, true, 0, 6000.0, 6000.0, 'Отель Парисон', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (272, client_id, 'cancelled', '2024-12-31', '2024-12-31', 1, 50, 0, 0, 0, NULL, false, 0, 0.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (271, client_id, 'completed', '2024-09-21', '2024-09-21', 1, 47, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (270, client_id, 'completed', '2024-09-17', '2024-09-18', 2, 50, 0, 0, 0, NULL, true, 0, 7680.0, 7680.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (269, client_id, 'completed', '2024-09-21', '2024-09-21', 1, 31, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Минеева%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (268, client_id, 'completed', '2024-10-05', '2024-10-05', 1, 81, 0, 0, 0, NULL, true, 0, 6320.0, 6320.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь Ким%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (267, client_id, 'completed', '2024-09-14', '2024-09-14', 1, 28, 0, 0, 0, NULL, true, 0, 2160.0, 2160.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Жукова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (266, client_id, 'completed', '2024-09-14', '2024-09-14', 1, 34, 0, 0, 0, NULL, true, 0, 2400.0, 2400.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зульхиза Кутлучурина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (265, client_id, 'completed', '2024-09-14', '2024-09-15', 2, 38, 0, 0, 0, NULL, true, 0, 5760.0, 5760.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (264, client_id, 'completed', '2024-09-13', '2024-09-15', 3, 37, 0, 0, 0, NULL, true, 0, 7350.0, 7350.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (263, client_id, 'completed', '2024-09-12', '2024-09-16', 5, 20, 0, 0, 0, NULL, true, 0, 6400.0, 6400.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (262, client_id, 'cancelled', '2024-09-16', '2024-09-16', 1, 30, 0, 0, 0, NULL, false, 0, 2320.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (261, client_id, 'completed', '2024-09-19', '2024-09-19', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (260, client_id, 'completed', '2024-09-14', '2024-09-14', 1, 48, 0, 0, 0, NULL, true, 0, 3760.0, 3760.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Марианна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (259, client_id, 'completed', '2024-09-11', '2024-09-11', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Жукова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (258, client_id, 'completed', '2024-09-07', '2024-09-07', 1, 31, 0, 0, 0, NULL, true, 0, 3520.0, 3520.0, 'Двойной комплект наушников', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (257, client_id, 'completed', '2024-09-07', '2024-09-08', 2, 29, 0, 0, 0, NULL, true, 0, 4320.0, 4320.0, 'Кристал, Элина', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (256, client_id, 'completed', '2024-09-06', '2024-09-06', 1, 39, 0, 0, 0, NULL, true, 0, 3040.0, 3040.0, 'Кристалл к 10.30 38 шт. Гид Диана 89274454525. Вернуть этот день день. Отель Сулейман в 18.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (255, client_id, 'completed', '2024-09-28', '2024-09-29', 2, 50, 0, 0, 0, NULL, true, 0, 7680.0, 7680.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (254, client_id, 'completed', '2024-09-06', '2024-09-06', 1, 12, 0, 0, 0, NULL, true, 0, 880.0, 880.0, '6.09 нужно 11 аудиогидов🙏🏻с 13 до 19', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Игорь Воронов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (253, client_id, 'completed', '2024-09-07', '2024-09-09', 3, 15, 0, 0, 0, NULL, true, 0, 3120.0, 3120.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Нина Салькова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (252, client_id, 'completed', '2024-09-08', '2024-09-11', 3, 52, 0, 0, 0, NULL, true, 0, 16000.0, 16000.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Михайловна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (251, client_id, 'completed', '2024-09-11', '2024-09-13', 3, 24, 0, 0, 0, NULL, true, 0, 5280.0, 5280.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (250, client_id, 'completed', '2024-09-05', '2024-09-05', 1, 11, 0, 0, 0, NULL, true, 0, 800.0, 800.0, 'Заберут 10:00 вернут 13:30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Игорь Воронов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (249, client_id, 'completed', '2024-09-05', '2024-09-07', 3, 15, 0, 0, 0, NULL, true, 0, 3120.0, 3120.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (248, client_id, 'completed', '2024-09-06', '2024-09-07', 2, 49, 0, 0, 0, NULL, true, 0, 6580.0, 6580.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Евгения Заговорина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (247, client_id, 'completed', '2024-09-14', '2024-09-14', 1, 250, 0, 0, 0, NULL, true, 0, 22400.0, 22400.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (246, client_id, 'completed', '2024-09-06', '2024-09-06', 1, 41, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (245, client_id, 'completed', '2024-09-04', '2024-09-06', 3, 31, 0, 0, 0, NULL, true, 0, 6090.0, 6090.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (244, client_id, 'completed', '2024-09-05', '2024-09-05', 1, 31, 0, 0, 0, NULL, true, 0, 2100.0, 2100.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Салькова Нина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (243, client_id, 'cancelled', '2024-09-08', '2024-09-11', 4, 50, 0, 0, 0, NULL, false, 0, 0.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья Рыжкова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (242, client_id, 'completed', '2024-09-28', '2024-09-29', 2, 31, 0, 0, 0, NULL, true, 0, 4640.0, 4640.0, 'Лейла', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (241, client_id, 'completed', '2024-08-31', '2024-08-31', 1, 46, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Артем Агафонов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (240, client_id, 'completed', '2024-08-31', '2024-08-31', 1, 36, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (239, client_id, 'completed', '2024-08-25', '2024-08-25', 1, 34, 0, 0, 0, NULL, true, 0, 2640.0, 2640.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (238, client_id, 'completed', '2024-09-08', '2024-09-08', 1, 45, 0, 0, 0, NULL, true, 0, 3080.0, 3080.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (237, client_id, 'completed', '2024-09-10', '2024-09-14', 5, 48, 0, 0, 0, NULL, true, 0, 15750.0, 15750.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Автокруиз%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (236, client_id, 'completed', '2024-08-24', '2024-08-24', 1, 35, 0, 0, 0, NULL, true, 0, 2720.0, 2720.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (235, client_id, 'completed', '2024-08-23', '2024-08-23', 1, 44, 0, 0, 0, NULL, true, 0, 6720.0, 6720.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Оксана%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (234, client_id, 'completed', '2024-08-23', '2024-08-23', 1, 12, 0, 0, 0, NULL, true, 0, 880.0, 880.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (232, client_id, 'completed', '2024-09-02', '2024-09-02', 1, 60, 0, 0, 0, NULL, true, 0, 4640.0, 4640.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (231, client_id, 'completed', '2024-08-29', '2024-08-29', 1, 60, 0, 0, 0, NULL, true, 0, 4640.0, 4640.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (230, client_id, 'completed', '2024-10-06', '2024-10-10', 5, 29, 0, 0, 0, NULL, true, 0, 8640.0, 8640.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (229, client_id, 'completed', '2024-08-18', '2024-08-18', 1, 45, 0, 0, 0, NULL, true, 0, 3520.0, 3520.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Клиент%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (228, client_id, 'completed', '2024-09-26', '2024-09-29', 3, 43, 0, 0, 0, NULL, true, 0, 9840.0, 9840.0, 'У Натальи', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (227, client_id, 'cancelled', '2024-10-05', '2024-10-06', 2, 50, 0, 0, 0, NULL, false, 0, 0.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей Вологда%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (226, client_id, 'completed', '2024-08-23', '2024-08-24', 2, 44, 0, 0, 0, NULL, true, 0, 6720.0, 6720.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (225, client_id, 'cancelled', '2024-08-22', '2024-08-22', 1, 22, 0, 0, 0, NULL, false, 0, 3200.0, 0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (224, client_id, 'completed', '2024-08-21', '2024-08-21', 1, 25, 0, 0, 0, NULL, true, 0, 1470.0, 1470.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (223, client_id, 'completed', '2024-08-21', '2024-08-22', 2, 39, 0, 0, 0, NULL, true, 0, 5920.0, 5920.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (222, client_id, 'completed', '2024-08-20', '2024-08-21', 2, 51, 0, 0, 0, NULL, true, 0, 6860.0, 6860.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
END $$;