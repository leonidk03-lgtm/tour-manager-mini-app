-- Часть 4 из 7
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
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (654, client_id, 'completed', '2025-05-17', '2025-05-17', 1, 46, 0, 0, 0, NULL, true, 0, 3600.0, 3600.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алина Сафина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (653, client_id, 'completed', '2025-05-12', '2025-05-12', 1, 40, 0, 0, 0, NULL, true, 0, 3120.0, 3120.0, 'Заберет в 8:20-8:30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (652, client_id, 'completed', '2025-05-11', '2025-05-11', 1, 37, 0, 0, 0, NULL, true, 0, 2880.0, 2880.0, 'В стс. Чуб. Ваучер на кремль', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (651, client_id, 'completed', '2025-05-11', '2025-05-13', 3, 50, 0, 0, 0, NULL, true, 0, 10080.0, 10080.0, 'радиогиды на 11,12,13 мая, будет 48 человек + гид Ирина т. +7 927 421-36-82 Отель Булгар ( Ул Вишневского 21) Можно оставить накануне в отеле Кристалл, группа приезжает 11 мая в 7:50 утра на ЦЖД', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (650, client_id, 'completed', '2025-06-12', '2025-06-12', 1, 39, 0, 0, 0, NULL, true, 0, 3040.0, 3040.0, 'Заберет в 10:45', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Светлана (Лана-тур Казань)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (649, client_id, 'completed', '2025-05-13', '2025-05-15', 3, 33, 0, 0, 0, NULL, true, 0, 6880.0, 6880.0, 'Хилтон в обед', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина Рыжикова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (648, client_id, 'completed', '2025-05-09', '2025-05-09', 1, 13, 0, 0, 0, NULL, true, 0, 960.0, 960.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Вера (СК-Интур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (647, client_id, 'completed', '2025-05-01', '2025-05-04', 4, 17, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (646, client_id, 'completed', '2025-05-15', '2025-05-15', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, 'на 15 мая, 35 штук, прошу принести сумку 14 мая в первой половине дня, чтобы гид успел у нас её забрать. Сумку принесите в наш мобильный трак на петербургской. Забрать сумку можно будет 16 мая в течение дня до 19.00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (645, client_id, 'completed', '2025-05-09', '2025-05-11', 3, 30, 0, 0, 0, NULL, true, 0, 4640.0, 4640.0, 'Группа №3(Екатеринбург) 29 человек, на 3 дня(09-11 мая) можно оставить в Кристалле до 11:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (644, client_id, 'completed', '2025-05-08', '2025-05-10', 3, 45, 0, 0, 0, NULL, true, 0, 10560.0, 10560.0, 'Группа №2 (Ногинск) 44 человека,на 3 дня (08-10 мая) привезти накануне, т.к. встречают в 7 утра', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (643, client_id, 'completed', '2025-05-08', '2025-05-09', 2, 46, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'Группа №1(Обнинск) 46 человек, на 2 дня (08-09 мая) привезти накануне в офис, т.к. встречают в 7 утра Вернули в кристалл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (642, client_id, 'completed', '2025-05-08', '2025-05-08', 1, 54, 0, 0, 0, NULL, true, 0, 4240.0, 4240.0, 'Баскет холл, к 8', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (641, client_id, 'completed', '2025-05-30', '2025-05-31', 2, 24, 0, 0, 0, NULL, true, 0, 3520.0, 3520.0, '30,31 мая - 22 штуки. Гид Элина Гортэ. 30 мая в 10:50 от центрального жд', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (640, client_id, 'completed', '2025-05-29', '2025-06-01', 4, 27, 0, 0, 0, NULL, true, 0, 8000.0, 8000.0, '29,30,31 мая , 1 июня - 25 штук . Гид Наталья Никифорова . 29 мая в 10:50 от центрального жд. ваучер на Кремль и 220 600 рублей', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (639, client_id, 'completed', '2025-05-24', '2025-05-25', 2, 32, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, '24,25 мая - 30 штук . Гид Наталья Никифорова . 24 мая в 7:50 от центрального жд', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (638, client_id, 'completed', '2025-05-18', '2025-05-18', 1, 53, 0, 0, 0, NULL, true, 0, 4160.0, 4160.0, '18 мая- 52 штуки . гид Виктория Павлова . в 10:00 ул.Гвардейская 35', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (637, client_id, 'completed', '2025-05-17', '2025-05-17', 1, 53, 0, 0, 0, NULL, true, 0, 4160.0, 4160.0, '17 мая -52 штуки . 9:30 от центрального жд Гульнара 2 передатчика', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (634, client_id, 'completed', '2025-05-16', '2025-05-16', 1, 28, 0, 0, 0, NULL, true, 0, 2160.0, 2160.0, '16 мая -27 шт. гид Виктория Павлова в 8:30 от жд центрального Ваучер уремль', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (633, client_id, 'completed', '2025-05-16', '2025-05-19', 4, 50, 0, 0, 0, NULL, true, 0, 15360.0, 15360.0, '16,17,18,19 мая - 48 человек. гид Настя Семенова . 16 мая в 14:20 от жд Восстания', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (632, client_id, 'completed', '2025-05-16', '2025-05-17', 2, 22, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, '16,17 мая - 20 штук . гид Наталья Никифорова 16 мая в 8:00от центрального жд Ваучер Кремль и суияжск', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (630, client_id, 'completed', '2025-05-12', '2025-05-15', 4, 32, 0, 0, 0, NULL, true, 0, 9600.0, 9600.0, '12,13,14,15 мая- 30 штук . Гид Катя Ильина 12 мая в 14:20 на жд Восстания начало. Положить ваучеры Кремль, свияжск, болгар', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (629, client_id, 'completed', '2025-05-11', '2025-05-11', 1, 48, 0, 0, 0, NULL, true, 0, 3760.0, 3760.0, '11 мая - 47 шт. гид Лариса Семенова в 9:30 от кремля', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (628, client_id, 'completed', '2025-05-07', '2025-05-07', 1, 60, 0, 0, 0, NULL, true, 0, 4720.0, 4720.0, '7 мая -59 штук . Гид Резеда . в 9:00 Деревня Универсиады КПП 14', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (627, client_id, 'completed', '2025-05-06', '2025-05-07', 2, 70, 0, 0, 0, NULL, true, 0, 10400.0, 10400.0, '6 мая - 65 штук ( 2 группы) в 10:00 ул.Одностороняя Гривка д.1 7 мая они же поедут в свияжск , тоже в 10:00 Сумка на 20 и сумка на 50', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (626, client_id, 'completed', '2025-05-09', '2025-05-09', 1, 38, 0, 0, 0, NULL, true, 0, 2960.0, 2960.0, 'Кафе Хоррият до 11:00( петерьургая 57) Вернут после 20:00 в Татарстан', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Оксана%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (625, client_id, 'completed', '2025-05-08', '2025-05-09', 2, 47, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'Амансафар. Вернут в корстон', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (624, client_id, 'completed', '2025-05-05', '2025-05-06', 2, 46, 0, 0, 0, NULL, true, 0, 7040.0, 7040.0, 'Гид Диана +7 927 445-45-25 05 в тиц до 15 Вернут в тиц 06 с 18:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (623, client_id, 'completed', '2025-05-09', '2025-05-10', 2, 27, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, '9.05 гид Виктория 89196236810 25шт. 9.30 отель Давыдов на Павлюхина , сдаст 10.05 после 21.30 по созвону. ВЕРНУЛА В КРИСТАЛ', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (622, client_id, 'completed', '2025-05-09', '2025-05-10', 2, 46, 0, 0, 0, NULL, true, 0, 7040.0, 7040.0, '9.05 гид Марина 89172526993 44 шт. в 9.30 отель Аматти сдаст 10.05 после 21.30 по созвону', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (621, client_id, 'completed', '2025-05-08', '2025-05-09', 2, 46, 0, 0, 0, NULL, true, 0, 7040.0, 7040.0, '8.05 гид Владимир 89178858409 44 шт. в 9.00 Алан аш на Бутлерова 43 сдаст 9.05 после 16 по созвону', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (620, client_id, 'completed', '2025-05-05', '2025-05-06', 2, 29, 0, 0, 0, NULL, true, 0, 4320.0, 4320.0, '5.05 гид Владимир 89178858409 27шт. в 8.00 кафе Овсянки сдаст 6.05 после 19.00 по созвону.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (619, client_id, 'completed', '2025-05-03', '2025-05-03', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (618, client_id, 'completed', '2025-05-10', '2025-05-10', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, '10 мая с 08.00 до 23.30 от Сафара в Релиту', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (617, client_id, 'completed', '2025-05-09', '2025-05-09', 1, 26, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, 'с 08.00 до 23.30 от Сафара в Сулейман', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Диляра%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (615, client_id, 'completed', '2025-05-03', '2025-05-03', 1, 51, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Утром Принесет на вечерку', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (614, client_id, 'completed', '2025-05-03', '2025-05-04', 2, 34, 0, 0, 0, NULL, true, 0, 5280.0, 5280.0, '3.05 гид Владимир 89178858409 33 шт. в Кристалл к 7.30 сдаст 4.05 после 13. по созвону на Баумана', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (613, client_id, 'completed', '2025-05-02', '2025-05-04', 3, 36, 0, 0, 0, NULL, true, 0, 8400.0, 8400.0, '2.05 гид Диана 89274454525 35 штук отель Кристалл к 7.30 сдадут 4.05 после 13.30 в кристалл', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (612, client_id, 'completed', '2025-05-01', '2025-05-02', 2, 38, 0, 0, 0, NULL, true, 0, 7770.0, 7770.0, '1 группа* На *1 и 2 мая* 37 человек + гид Владимир т.+7 917 885-84-09 отель Булгар ( ул Вишневского 21) 2 группа * На *2 мая* 37 человек + гид Ирина т. +7 927 421-36-82 Отель Биляр Палас ( ул Островского 61) Нужно положить два комплекта наушников. Оставили в биляр!!', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (611, client_id, 'completed', '2025-05-02', '2025-05-04', 3, 40, 0, 0, 0, NULL, true, 0, 9120.0, 9120.0, '01.05 занести в офис Тиц', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (610, client_id, 'completed', '2025-05-08', '2025-05-10', 3, 42, 0, 0, 0, NULL, true, 0, 12300.0, 12300.0, 'Тула завезти ВЕРНУЛИ В КРИСТАЛЛ', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (609, client_id, 'completed', '2025-05-08', '2025-05-10', 3, 44, 0, 0, 0, NULL, true, 0, 12900.0, 12900.0, 'ЕКБ-2 завезти ВЕРНУЛИ В КРИСТАЛ', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Любовь (ТИЦ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (608, client_id, 'completed', '2025-05-01', '2025-05-03', 3, 32, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, '30.04 занести в офис Тиц на Баумана Вернут 03.05 в офис Тиц вечером', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (607, client_id, 'completed', '2025-05-03', '2025-05-03', 1, 44, 0, 0, 0, NULL, true, 0, 3440.0, 3440.0, 'Оставить в Сафаре Забрать в Сулейман утром 04.05', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (606, client_id, 'completed', '2025-05-03', '2025-05-03', 1, 37, 0, 0, 0, NULL, true, 0, 2880.0, 2880.0, 'Оставить в Сулейман до 08:30 и забрать в Сулейман Утром', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Арсен (Юнион)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (605, client_id, 'completed', '2025-05-02', '2025-05-02', 1, 27, 0, 0, 0, NULL, true, 0, 2080.0, 2080.0, 'Оставить в Амакс Оставят в Релите в 23:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ляйсан (Казань 360)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (604, client_id, 'completed', '2025-04-30', '2025-05-01', 2, 29, 0, 0, 0, NULL, true, 0, 4320.0, 4320.0, 'Крисстал вернет гид Анна +7 987 290-73-09 Они в 18:00 заканчивают в Рамаде', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина (Иль Мио Тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (602, client_id, 'completed', '2025-05-03', '2025-05-03', 1, 44, 0, 0, 0, NULL, true, 0, 3440.0, 3440.0, 'Татарстан Алевтина Александровна 89033881755 Вернут туда же после 18:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (601, client_id, 'completed', '2025-05-03', '2025-05-04', 2, 65, 0, 0, 0, NULL, true, 0, 12200.0, 12200.0, 'Уточнить 63 гида Оставили в крисстал', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (600, client_id, 'completed', '2025-05-02', '2025-05-03', 2, 37, 0, 0, 0, NULL, true, 0, 7000.0, 7000.0, 'Завезу по пути в кристал Оставили в кристал', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (599, client_id, 'completed', '2025-05-01', '2025-05-03', 3, 47, 0, 0, 0, NULL, true, 0, 10800.0, 10800.0, 'Завезти в офис инициативы Вернут в кристал в 22:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эвелина (Инициатива)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (598, client_id, 'completed', '2025-05-01', '2025-05-01', 1, 34, 0, 0, 0, NULL, true, 0, 2640.0, 2640.0, 'Завезти в офис инициативы Вернут в Амстердам в 23:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (597, client_id, 'completed', '2025-05-01', '2025-05-03', 3, 20, 0, 0, 0, NULL, true, 0, 5400.0, 5400.0, 'Сами заберут Оставят в кристалле в 22:00', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (596, client_id, 'completed', '2025-05-01', '2025-05-02', 2, 33, 0, 0, 0, NULL, true, 0, 6200.0, 6200.0, 'Сами заберут', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галина (Тур Урал)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (595, client_id, 'completed', '2025-05-01', '2025-05-03', 3, 35, 0, 0, 0, NULL, true, 0, 9900.0, 9900.0, 'Сами заберут', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Алексей%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (594, client_id, 'completed', '2025-05-13', '2025-05-14', 2, 54, 0, 0, 0, NULL, true, 0, 8160.0, 8160.0, 'Заберут и оставят в Кристалле', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (593, client_id, 'completed', '2025-04-29', '2025-04-29', 1, 66, 0, 0, 0, NULL, true, 0, 4480.0, 4480.0, '29.04 1 группа 32 человека + гид Лариса тел. +7 927 240-82-50 2 группа 32 человека + гид Ольга тел. +7 927 401-81-84 Экскурсия будет от Амакс Сафар с 15 до 18 ч и заканчивается в Амакс', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (592, client_id, 'completed', '2025-05-02', '2025-05-02', 1, 47, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, 'На 02.05 в Крисстал, группа 46+1 запас+1 гид Сопровождающая Мария +7 901 282-25-77 Гид Алексей Вернут в фургончик в 15:30', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга (Дольче Вита)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (591, client_id, 'completed', '2025-05-01', '2025-05-03', 3, 48, 0, 0, 0, NULL, true, 0, 11040.0, 11040.0, 'Кристалл Вернут в кристалл в районе 19', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елизавета Ткач%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (589, client_id, 'completed', '2025-05-05', '2025-05-06', 2, 40, 0, 0, 0, NULL, true, 0, 6080.0, 6080.0, 'Утром заберет', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анюта Родионова (Родина-тур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (588, client_id, 'completed', '2025-05-03', '2025-05-03', 1, 42, 0, 0, 0, NULL, true, 0, 3280.0, 3280.0, 'Заберут Вечером вернет', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (587, client_id, 'completed', '2025-04-30', '2025-04-30', 1, 29, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, '. на 30.04. в Карат к 9.30 гид Диана 89274454525 сдаст 30.04 после 17.30 по созвону.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (586, client_id, 'completed', '2025-04-29', '2025-04-30', 2, 30, 0, 0, 0, NULL, true, 0, 4480.0, 4480.0, 'на 29 апреля 28 чел. гид Ирина Палей 89046620732 Биляр к 9.30 сдадут 30.04 после 19 в Кристалл', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (585, client_id, 'completed', '2025-04-28', '2025-04-29', 2, 36, 0, 0, 0, NULL, true, 0, 5600.0, 5600.0, '35 шт гид Гульнара 89600389286в Сулейман к 8.30 сдаст гид Ванда 89655868806 29 апреля по созвону после 17.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (584, client_id, 'completed', '2025-04-28', '2025-04-28', 1, 33, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, '32 шт. гид Зифа 89053162643 в Давыдов на Павлюхина , сдадут в этот же день после 19.00 в Давыдов', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (583, client_id, 'completed', '2025-04-28', '2025-04-30', 3, 38, 0, 0, 0, NULL, true, 0, 8640.0, 8640.0, '36 шт. гид Марина 89172526993 в Кристалл в 10.30 отдадут 30.04 по созвону после 20.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (582, client_id, 'completed', '2025-04-28', '2025-04-28', 1, 30, 0, 0, 0, NULL, true, 0, 2320.0, 2320.0, 'на завтра 29 штук , поедет в иннополис в 11:30 Копылова д.11. С ними будет айдар садыков Он едет на вечерку ему надо отдать сумку и два передатчика', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Светлана Зеленина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (581, client_id, 'completed', '2025-05-08', '2025-05-08', 1, 25, 0, 0, 0, NULL, true, 0, 1920.0, 1920.0, 'Заберут сами рано утром', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Айрат Нурмухаммадов%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (580, client_id, 'completed', '2025-04-27', '2025-04-27', 1, 38, 0, 0, 0, NULL, true, 0, 2590.0, 2590.0, 'Заберет в 12:45', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (579, client_id, 'completed', '2025-04-26', '2025-04-26', 1, 25, 0, 0, 0, NULL, true, 0, 1920.0, 1920.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (578, client_id, 'completed', '2025-04-26', '2025-04-27', 2, 42, 0, 0, 0, NULL, true, 0, 5600.0, 5600.0, 'Заявка на завтра 26 и 27 апреля Группа 40 человек + гид Ирина тел. +7 927 421-36-82 Завтра приезжают на ЖД в 12 часов дня, можно оставить в отеле Кристалл. Сумка в отели Гвардейский', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Валентина Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (577, client_id, 'completed', '2025-05-01', '2025-05-01', 1, 50, 0, 0, 0, NULL, true, 0, 3920.0, 3920.0, 'Заберет в 8:30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (576, client_id, 'completed', '2025-04-29', '2025-04-29', 1, 43, 0, 0, 0, NULL, true, 0, 3360.0, 3360.0, '29 апреля Регина на Петербургской 42 шт для Татьяны', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (575, client_id, 'completed', '2025-04-28', '2025-04-28', 1, 75, 0, 0, 0, NULL, true, 0, 5840.0, 5840.0, '28 го Региеа на Петербургской 73/2 для Айгуль и Александра. На 36 и 37.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (574, client_id, 'completed', '2025-04-28', '2025-04-28', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, '28 го в Регину на Петербург для Ольги 35 штук', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (573, client_id, 'completed', '2025-04-26', '2025-04-26', 1, 156, 0, 0, 0, NULL, true, 0, 12000.0, 12000.0, '26 го в кристалле на имя Айгуль 44 шт На имя Эльвира 35 человек На имя Лиза 37 человек На имя Влада 36 Вернут в Регину после 16:00 на петербуржскую', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (572, client_id, 'completed', '2025-04-24', '2025-04-24', 1, 50, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, 'Оставят в Волге,', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (571, client_id, 'completed', '2025-05-03', '2025-05-03', 1, 132, 0, 0, 0, NULL, true, 0, 10320.0, 10320.0, 'Заберут с Баумана в 16:30 Вернут в 20:30 в Регину на Баумана', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (570, client_id, 'completed', '2025-04-28', '2025-04-28', 1, 20, 0, 0, 0, NULL, true, 0, 1520.0, 1520.0, '28 апреля - 19 шт. Гид Гульнара. в 12:00 отель М.Горький Вернет туда же после 18', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (569, client_id, 'completed', '2025-04-26', '2025-04-27', 2, 24, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, '26,27 апреля - 23 шт . Гид Наталья Никифорова 26 апреля в 8:00 от центрального жд. Надо вечеро дать сумку, ваучер( обзорка, свияжск) деньги', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Константин%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (568, client_id, 'completed', '2025-04-24', '2025-04-24', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (567, client_id, 'completed', '2025-04-23', '2025-04-23', 1, 24, 0, 0, 0, NULL, true, 0, 1840.0, 1840.0, 'Ольга ткач. Кристал. Вернет сама завтра к свияжску', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия (Рыжий Слон)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (566, client_id, 'completed', '2025-05-04', '2025-05-06', 3, 87, 0, 0, 0, NULL, true, 0, 19920.0, 19920.0, 'Кристал. Информация будет в 19:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (565, client_id, 'completed', '2025-05-02', '2025-05-03', 2, 75, 0, 0, 0, NULL, true, 0, 11680.0, 11680.0, '2 мая 73/2 в кристалле Для Людмилы и Татьяны Вернули в Релиту', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (563, client_id, 'completed', '2025-04-25', '2025-04-28', 4, 43, 0, 0, 0, NULL, true, 0, 9840.0, 9840.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Елена Тамбова (Апрель)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (562, client_id, 'completed', '2025-04-26', '2025-04-27', 2, 64, 0, 0, 0, NULL, true, 0, 4960.0, 4960.0, 'Она в Кристалле оборудование на 62 чел возьмёт,а отдаст в Татарской слободе на Марджани в 12.00 группа там будет. Самгина Ольг +7 953 717‑05‑28. Привезет Ильдар 051', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия Шадрина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (561, client_id, 'completed', '2025-04-24', '2025-04-24', 1, 77, 0, 0, 0, NULL, true, 0, 6000.0, 6000.0, 'Одна сумка один передатчик. Марафон. Доставка', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (560, client_id, 'completed', '2025-05-09', '2025-05-09', 1, 77, 0, 0, 0, NULL, true, 0, 5250.0, 5250.0, 'Уточнить в переписке', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (559, client_id, 'completed', '2025-05-07', '2025-05-07', 1, 56, 0, 0, 0, NULL, true, 0, 3850.0, 3850.0, 'Уточнить в переписке Наталья Релита', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (557, client_id, 'completed', '2025-04-26', '2025-04-27', 2, 47, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'Заберут утром', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (556, client_id, 'completed', '2025-04-24', '2025-04-24', 1, 17, 0, 0, 0, NULL, true, 0, 1280.0, 1280.0, 'Добрый день! На 24.04 ГРАНД ОТЕЛЬ КАЗАНЬ Нужны аудиогиды) 16 для группы+ запосной+ для гида', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эльвира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (555, client_id, 'completed', '2025-04-23', '2025-04-23', 1, 21, 0, 0, 0, NULL, true, 0, 1520.0, 1520.0, 'Забрать 23. У Кремля в 12:15', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (554, client_id, 'completed', '2025-04-21', '2025-04-21', 2, 29, 0, 0, 0, NULL, true, 0, 6720.0, 6720.0, 'Завтра в 12:00 от шаляпина гид Наталья Никифорова . Нужно 28 радиогидов.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (553, client_id, 'completed', '2025-04-19', '2025-04-20', 2, 25, 0, 0, 0, NULL, true, 0, 3680.0, 3680.0, 'Кристалл, Наталия', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (551, client_id, 'completed', '2025-04-18', '2025-04-20', 3, 47, 0, 0, 0, NULL, true, 0, 10800.0, 10800.0, 'На 18-20 апреля нужно 45 шт. радиогидов в Кристалл к 7.00 .Вернут туда же после 20 часов Гид Владимир Николаевич 89178858409', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (550, client_id, 'completed', '2025-04-17', '2025-04-18', 2, 41, 0, 0, 0, NULL, true, 0, 6240.0, 6240.0, '17 апреля надо 39 штук на 2 дня радио гидов в Хостел (Петербургская, 40Б) к 14.30 для гида Шуравиной Ольги89503140361 вернут 18.04 по созвону после 17 часов.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (548, client_id, 'completed', '2025-04-16', '2025-04-16', 1, 58, 0, 0, 0, NULL, true, 0, 4560.0, 4560.0, 'Гузель. Она едет сегодня на вечерку. Ей сумку дать и ваучер на Кремль', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (547, client_id, 'completed', '2025-05-10', '2025-05-11', 2, 45, 0, 0, 0, NULL, true, 0, 3010.0, 3010.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (546, client_id, 'completed', '2025-04-14', '2025-04-14', 1, 21, 0, 0, 0, NULL, true, 0, 1600.0, 1600.0, 'В отель Карат Гид+7 950 949-04-94 Беркут хан ( Радик) сдаст по созвону вечером', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Антон%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (544, client_id, 'completed', '2025-06-03', '2025-06-05', 2, 68, 0, 0, 0, NULL, true, 0, 9760.0, 9760.0, '3. В 12:00 у Кремля Даты: 3 июНя с 11 до 18 5 июНя с 9 до 20', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (543, client_id, 'completed', '2025-04-13', '2025-04-13', 1, 27, 0, 0, 0, NULL, true, 0, 2080.0, 2080.0, '26 радиогидов в иннополис в 9:00 от Отель Raymond ул.Большая Красная д.50 . С ними гид гузель будет. 2 передатчика Вернула в офис', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (542, client_id, 'completed', '2025-04-13', '2025-04-13', 1, 56, 0, 0, 0, NULL, true, 0, 3850.0, 3850.0, 'Релита. Сумка в Шаляпин', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (541, client_id, 'completed', '2025-04-12', '2025-04-12', 1, 55, 0, 0, 0, NULL, true, 0, 4320.0, 4320.0, '54 чел. От жд центрального. Гид. +7 927 419-65-79 резеда', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (540, client_id, 'completed', '2025-05-01', '2025-05-02', 2, 45, 0, 0, 0, NULL, true, 0, 6020.0, 6020.0, 'Оставила в Волге', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (539, client_id, 'completed', '2025-04-11', '2025-04-12', 2, 43, 0, 0, 0, NULL, true, 0, 6560.0, 6560.0, '. Нужны радиогиды 41 шт. 11 - 12 апреля . гид Настя Семенова 11 апреля в 6:00 на жд Восстания', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (537, client_id, 'completed', '2025-04-13', '2025-04-13', 1, 25, 0, 0, 0, NULL, true, 0, 1920.0, 1920.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга Лукоянова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (536, client_id, 'completed', '2025-05-02', '2025-05-03', 2, 20, 0, 0, 0, NULL, true, 0, 3040.0, 3040.0, '+79297259743 Утром сама заберет В кристалле', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (533, client_id, 'completed', '2025-04-12', '2025-04-12', 1, 102, 0, 0, 0, NULL, true, 0, 8000.0, 8000.0, 'На субботу 12 апреля нужно 100 примерно радиогидов и 2 передатчика. Поможете?', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (532, client_id, 'completed', '2025-04-13', '2025-04-13', 1, 21, 0, 0, 0, NULL, true, 0, 1600.0, 1600.0, '13.04 гид Палей Ирина 89046620732 20 чел. Сулейман к 11.30 сдаст в 20.30 в Кристалл ГИДА НЕ ПРЕДУПРЕДИЛИ! СУМКА ОСТАЛАСЬ В СУЛЕЙМАН!', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (531, client_id, 'completed', '2025-04-11', '2025-04-11', 1, 30, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, '10.04 гид Дания 89172904415 28чел. в обед позвонит на Баумана. чтобы использовать 11.04. сдаст 11.04 поздно или по звонку потом', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Виолетта%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (530, client_id, 'completed', '2025-04-09', '2025-04-10', 2, 28, 0, 0, 0, NULL, true, 0, 4160.0, 4160.0, 'Полносью мой, сдадут в кристалл 10.04 в 20:00. Гольфстрим', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (529, client_id, 'completed', '2025-04-09', '2025-04-10', 2, 42, 0, 0, 0, NULL, true, 0, 5600.0, 5600.0, '9 и 10 апреля на группу 40 человек + гид Ирина Софронова тел.+7 917 293-48-70 Отель Ногай', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (528, client_id, 'completed', '2025-04-08', '2025-04-09', 2, 44, 0, 0, 0, NULL, true, 0, 5880.0, 5880.0, '8 и 9 апреля на группу 42 человека + гид Владимир тел.+7 917 885-84-09 Отель Татарская усадьба ( Марджани 8). Сдал в офис', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (527, client_id, 'completed', '2025-04-08', '2025-04-09', 2, 29, 0, 0, 0, NULL, true, 0, 3780.0, 3780.0, '8 и 9 апреля на группу 27 человек + гид Ирина Баталова тел.+7 927 421-36-82 Отель кристал 09.04 в 20:00 сумки в кристалле не было Сумку оставили в IT park', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (526, client_id, 'completed', '2025-04-08', '2025-04-10', 3, 47, 0, 0, 0, NULL, true, 0, 10800.0, 10800.0, '8 апреля 45 чел.гид Аида 89033440899 в 7 утра уезжает в Йошкар-Олу для встречи группы там на вокзале. ( наверное опять доставка)…. Сдадут 10 апреля в Кристалл в 19.15', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (525, client_id, 'completed', '2025-04-07', '2025-04-09', 3, 39, 0, 0, 0, NULL, true, 0, 8880.0, 8880.0, '7 апреля 37чел.гид Светлана. +79172969340 прибывают в 5 утра на Восстание сдадут 9 апреля в Кристалл после 17', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (524, client_id, 'completed', '2025-04-06', '2025-04-06', 1, 44, 0, 0, 0, NULL, true, 0, 2870.0, 2870.0, 'Лилия 13 Наталья 14 Роман 14 В Кремль в 10:30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (523, client_id, 'completed', '2025-04-06', '2025-04-06', 1, 33, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, 'Заберут в 8:45. Забрать в кристале', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (522, client_id, 'completed', '2025-04-06', '2025-04-08', 3, 30, 0, 0, 0, NULL, true, 0, 6720.0, 6720.0, 'Нужно радио гиды 28 штук . 6-8 апреля. С группой гид Элина Гортэ . 6 апреля в 7:50 встреча на центральном жд 09.04 в 20:00 сумки в кристалле нет', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (521, client_id, 'completed', '2025-04-06', '2025-04-07', 2, 27, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, '6 апреля гид Гульназ 89393902610 25шт.Прибытие, Казань-2 (Восстание-Пасс.) в 05:25 возвращение так же 7 апреля на Восстание в 19. Попробует оставить в гостинице Карат', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Зельфира%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (520, client_id, 'completed', '2025-04-08', '2025-04-08', 1, 41, 0, 0, 0, NULL, true, 0, 3200.0, 3200.0, '7 оставить в Татарстан 8 оставит в кристалле', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульнара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (519, client_id, 'completed', '2025-04-04', '2025-04-04', 1, 33, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (518, client_id, 'completed', '2025-04-05', '2025-04-07', 3, 45, 0, 0, 0, NULL, true, 0, 10320.0, 10320.0, '5 апреля 43 чел. гид Нелли Рифовна 89063237048 отель кристалл в 7.30 сдадут 7 апреля Кристалл после 17.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (517, client_id, 'completed', '2025-04-05', '2025-04-06', 2, 40, 0, 0, 0, NULL, true, 0, 6080.0, 6080.0, '5 апреля Гид Ольга 89503140361 Кристалл в 7.00! 38 чел. сдадут в Кисталл 6 апреля после 17.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (516, client_id, 'completed', '2025-04-05', '2025-04-06', 2, 30, 0, 0, 0, NULL, true, 0, 4480.0, 4480.0, '5 апреля 28 чел. Отель Берисон Камала 3* в 9.30 Гид Диляра Рафаровна 89179275489 сдадут 6 апреля отель Кристалл после 15.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (515, client_id, 'completed', '2025-04-04', '2025-04-05', 2, 41, 0, 0, 0, NULL, true, 0, 6240.0, 6240.0, '4 апреля гид Ирина Палей 89046620732 39 чел. (созвон, прибытие Восстание в 5 утра) сдадут (созвон 5 апреля возвращение в Казань в 19 на Восстание) Завтрак в Овсянке Оставит в отеле Крисстал, 07.04 в 12:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Сергей (Авангард)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (514, client_id, 'completed', '2025-04-06', '2025-04-08', 3, 44, 0, 0, 0, NULL, true, 0, 10080.0, 10080.0, 'Елена Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (513, client_id, 'completed', '2025-04-03', '2025-04-04', 2, 27, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, 'Заберет в 8:30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (512, client_id, 'completed', '2025-04-02', '2025-04-02', 1, 24, 0, 0, 0, NULL, true, 0, 1840.0, 1840.0, 'У замка сладостей в 8:45. В кристалле', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (509, client_id, 'completed', '2025-04-02', '2025-04-02', 1, 36, 0, 0, 0, NULL, true, 0, 2800.0, 2800.0, 'Заберет 1 апреля в 14:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Обыденникова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (508, client_id, 'completed', '2025-05-09', '2025-05-10', 2, 41, 0, 0, 0, NULL, true, 0, 6400.0, 6400.0, 'Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (507, client_id, 'completed', '2025-04-08', '2025-04-09', 2, 29, 0, 0, 0, NULL, true, 0, 3780.0, 3780.0, 'Кристал В 20:00, 09.04 сумки в кристалле не было. Вернули в Шаляпин', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (506, client_id, 'completed', '2025-04-02', '2025-04-04', 3, 21, 0, 0, 0, NULL, true, 0, 4200.0, 4200.0, 'Оставить в Кристале. Забрать в Доме Муллина в СТС', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Андрей (Экскурс)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (505, client_id, 'completed', '2025-04-29', '2025-04-30', 2, 31, 0, 0, 0, NULL, true, 0, 4800.0, 4800.0, 'Рамада', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (504, client_id, 'completed', '2025-04-01', '2025-04-01', 1, 34, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, '8:30 у часов Вернут в Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Анастасия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (503, client_id, 'completed', '2025-04-01', '2025-04-03', 3, 38, 0, 0, 0, NULL, true, 0, 8400.0, 8400.0, 'Карат', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (502, client_id, 'completed', '2025-03-27', '2025-03-27', 1, 33, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, 'В обед заберут. 14:00 у Свито Холла', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (501, client_id, 'completed', '2025-04-26', '2025-04-28', 3, 50, 0, 0, 0, NULL, true, 0, 11280.0, 11280.0, 'Берисон худикова', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (500, client_id, 'completed', '2025-03-26', '2025-03-27', 2, 34, 0, 0, 0, NULL, true, 0, 4480.0, 4480.0, 'Кристал Лариса', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (499, client_id, 'completed', '2025-03-26', '2025-03-26', 1, 52, 0, 0, 0, NULL, true, 0, 4080.0, 4080.0, 'Кристал Гузель', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (498, client_id, 'completed', '2025-03-25', '2025-03-25', 1, 26, 0, 0, 0, NULL, true, 0, 2000.0, 2000.0, 'завтра 15:30 Гостиница Колибри ул.К.Фукса', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (497, client_id, 'completed', '2025-03-29', '2025-03-30', 2, 23, 0, 0, 0, NULL, true, 0, 3360.0, 3360.0, 'Настя Семенова Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (496, client_id, 'completed', '2025-03-26', '2025-03-29', 4, 41, 0, 0, 0, NULL, true, 0, 12480.0, 12480.0, 'Ольга ткач 2 передатчика. 14:55 восстание', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (495, client_id, 'completed', '2025-05-01', '2025-05-01', 1, 48, 0, 0, 0, NULL, true, 0, 3760.0, 3760.0, 'Крисстал Заканчивает в 19:00 в Давыдов назарбаева', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (494, client_id, 'completed', '2025-03-23', '2025-03-24', 2, 28, 0, 0, 0, NULL, true, 0, 4160.0, 4160.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Альберт (КТ)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (493, client_id, 'completed', '2025-03-23', '2025-03-23', 1, 31, 0, 0, 0, NULL, true, 0, 2100.0, 2100.0, 'Кристал Лариса', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Эдик Заказы для групп%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (492, client_id, 'completed', '2025-03-20', '2025-03-20', 1, 55, 0, 0, 0, NULL, true, 0, 4240.0, 4240.0, 'Катя Ильина', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (491, client_id, 'completed', '2025-03-23', '2025-03-23', 1, 25, 0, 0, 0, NULL, true, 0, 1920.0, 1920.0, '23 марта 24шт.гид Лилия 89872975449 отель Кристалл в 12.00 отдадут после 19 в отель Волга', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия (Рыжий Слон)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (490, client_id, 'completed', '2025-03-23', '2025-03-25', 3, 49, 0, 0, 0, NULL, true, 0, 11280.0, 11280.0, 'Кристал Диляра', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (489, client_id, 'completed', '2025-03-27', '2025-03-29', 3, 40, 0, 0, 0, NULL, true, 0, 9120.0, 9120.0, 'Доставить экскурсоводу вечером Яндекс доставкой на Фучика. Аида. +7 903 344-08-99 Напомню адрес. Фучика 58 б кв 49 чтоб не было ошибк Оставит в Мано в районе 17 часов', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (488, client_id, 'completed', '2025-03-26', '2025-03-28', 3, 47, 0, 0, 0, NULL, true, 0, 10800.0, 10800.0, '26 марта 45 шт отель Кристалл к 11.30 гид Аида89033440899. сдадут 28 в Мано', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (487, client_id, 'completed', '2025-03-26', '2025-03-28', 3, 53, 0, 0, 0, NULL, true, 0, 12240.0, 12240.0, '26-28 марта- 51 шт.гид Светлана 89172969340 отель Регата 8.30 вернут 28 марта из Иннополиса возвращаются на ж.д.Восстание в 19.00 Решите, пожалуйста с гидом как лучше. Сдали в Татарстан!', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (486, client_id, 'completed', '2025-03-26', '2025-03-27', 2, 43, 0, 0, 0, NULL, true, 0, 6560.0, 6560.0, '26-27 гид Виктория 89196236810 41шт. отель Берисон на Худякова 9.30 Вернула в офис!', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (485, client_id, 'completed', '2025-03-25', '2025-03-27', 3, 40, 0, 0, 0, NULL, true, 0, 9120.0, 9120.0, '25-27 марта 38шт. гид Гульназ 89393902610 Кристалл к 11.30 сдадут 27 в кристалл в 22.00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (484, client_id, 'completed', '2025-03-25', '2025-03-27', 3, 44, 0, 0, 0, NULL, true, 0, 10080.0, 10080.0, '25-27 марта 42шт. отель Ямле в 9.30 гид Эльвира 89172639101 сдадут в Кисталл 27.03 в 13.30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (483, client_id, 'completed', '2025-03-24', '2025-03-26', 3, 36, 0, 0, 0, NULL, true, 0, 8160.0, 8160.0, '24 марта 34шт. гид Гульнара 89600389286 15:45-16:30 Обед в Ресторане «ТАТАР»ул. Шигабутдина Марджани 4 . сдадут 26 марта 14:00-15:00 Обед в кафе города. Татарская усадьба Алан Аш ул.Шигабутдина Марджани,8', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (482, client_id, 'completed', '2025-03-24', '2025-03-26', 3, 32, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, '24 марта 30 шт. гид Альбина 89503160154 в Сулейман в 8.40 отдадут 26 марта в Сулейман в 20.30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (481, client_id, 'completed', '2025-03-24', '2025-03-24', 1, 50, 0, 0, 0, NULL, true, 0, 3920.0, 3920.0, '24 марта 49шт. в Сулейман к 9.30 сдадут в этот же день 13:00 – 14:00 Обед в кафе города Ресторанный двор ул.Астрономическая 7. гид Ирина 89046620732. Вернули в Офис', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (480, client_id, 'completed', '2025-03-23', '2025-03-26', 4, 36, 0, 0, 0, NULL, true, 0, 10880.0, 10880.0, '23 марта 34шт.Гид Ольга 89503140361 15:00 – 16:00 Обед Кафе «Овсянки» ул.Бутлерова 34а отдадут 26 марта 12:00 – 13:30 Обед Ресторанный двор ул.Астрономическая,7', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (479, client_id, 'completed', '2025-03-22', '2025-03-24', 3, 25, 0, 0, 0, NULL, true, 0, 5760.0, 5760.0, 'на 22.03 24шт. 8905323704822-гид Нелли Рифовна 09:00 - 10:00 Завтрак Кафе «Овсянки» ул.Бутлерова 34а сдаст 24 марта 19:00 Ужин Кафе Медина ул.Татарстан,7', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (478, client_id, 'completed', '2025-03-22', '2025-03-24', 3, 39, 0, 0, 0, NULL, true, 0, 8880.0, 8880.0, 'на 22.03 37 шт гид Аида 89033440899в 13.30 ресторан ТАТАР в кремле,отдаст 24.03 в отель Кристалл после 21', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Дмитрий Попков%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (477, client_id, 'completed', '2025-05-02', '2025-05-03', 2, 50, 0, 0, 0, NULL, true, 0, 7680.0, 7680.0, 'Сулейман начало в 09:00. Забрать в Джузеппе', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (476, client_id, 'completed', '2025-05-01', '2025-05-02', 2, 52, 0, 0, 0, NULL, true, 0, 8000.0, 8000.0, 'В 9:00 завтрак', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Камила Ягудина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (475, client_id, 'completed', '2025-04-04', '2025-04-04', 1, 14, 0, 0, 0, NULL, true, 0, 960.0, 960.0, 'С 13:30', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Луиза%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (474, client_id, 'completed', '2025-04-06', '2025-04-06', 1, 46, 0, 0, 0, NULL, true, 0, 3520.0, 3520.0, 'В 09:00 заберет сама Две сумки по 22 Оставила в офисе', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Нина Тиханова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (473, client_id, 'completed', '2025-04-03', '2025-04-03', 1, 21, 0, 0, 0, NULL, true, 0, 1600.0, 1600.0, 'Заберет из офиса', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ольга Тандалова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (472, client_id, 'completed', '2025-03-22', '2025-03-23', 2, 24, 0, 0, 0, NULL, true, 0, 3520.0, 3520.0, 'Валерий Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна Чуб%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (470, client_id, 'completed', '2025-04-18', '2025-04-20', 3, 35, 0, 0, 0, NULL, true, 0, 7920.0, 7920.0, 'Кристал.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Наталья%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (469, client_id, 'completed', '2025-05-08', '2025-05-09', 2, 51, 0, 0, 0, NULL, true, 0, 8000.0, 8000.0, '8 мая с 20 до 22 9 мая с 14 до 18 Порядка 50 человек. Отель Европа.', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (468, client_id, 'completed', '2025-06-13', '2025-06-14', 2, 15, 0, 0, 0, NULL, true, 0, 2240.0, 2240.0, 'В Кристал', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (467, client_id, 'completed', '2025-04-06', '2025-04-07', 2, 26, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, '5 апреля в 14:00 заберет. Забрать в новинки', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Элина (Сититур)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (466, client_id, 'completed', '2025-03-25', '2025-03-29', 5, 18, 0, 0, 0, NULL, true, 0, 6400.0, 6400.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Аниса%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (465, client_id, 'completed', '2025-03-14', '2025-03-15', 2, 50, 0, 0, 0, NULL, true, 0, 7680.0, 7680.0, 'Гид Елена +79376267304', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Варвара%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (463, client_id, 'completed', '2025-03-08', '2025-03-08', 1, 37, 0, 0, 0, NULL, true, 0, 2880.0, 2880.0, 'Гостиница пилигрим. Оставить 8 числа. Забрать 9 числа.', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Екатерина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (462, client_id, 'completed', '2025-03-05', '2025-03-05', 1, 18, 0, 0, 0, NULL, true, 0, 1360.0, 1360.0, 'Отель Рамада На имя Валерий', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мира (ИП)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (461, client_id, 'completed', '2025-02-26', '2025-02-26', 1, 52, 0, 0, 0, NULL, true, 0, 3500.0, 3500.0, 'Старт в 15:00 от старого ИТ парка', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Сафронова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (460, client_id, 'completed', '2025-02-14', '2025-02-16', 3, 40, 0, 0, 0, NULL, true, 0, 7770.0, 7770.0, 'Кристалл, Казанские Традиции', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (459, client_id, 'completed', '2025-02-18', '2025-02-19', 2, 26, 0, 0, 0, NULL, true, 0, 3840.0, 3840.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Палитра Тур%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (458, client_id, 'completed', '2025-02-09', '2025-02-09', 1, 45, 0, 0, 0, NULL, true, 0, 3520.0, 3520.0, 'В 11:00-11:30 они приедут в Татарстан и встретятся там с экскурсоводом, Живут в Волге , +7 960 039-47-90 гид на 10 февраля Инна, они встречаются с группой в 11:00 возле гостиницы Татарстан', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Галия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (457, client_id, 'completed', '2025-04-29', '2025-04-29', 1, 14, 0, 0, 0, NULL, true, 0, 1040.0, 1040.0, '-', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (455, client_id, 'completed', '2025-02-17', '2025-02-19', 3, 52, 0, 0, 0, NULL, true, 0, 9840.0, 9840.0, 'Делать группу так же как 12 февраля', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлия Воронова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (454, client_id, 'completed', '2025-02-11', '2025-02-11', 1, 52, 0, 0, 0, NULL, true, 0, 4000.0, 4000.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (453, client_id, 'completed', '2025-07-26', '2025-07-27', 2, 33, 0, 0, 0, NULL, true, 0, 4960.0, 4960.0, 'В школу в 12', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (452, client_id, 'completed', '2025-06-12', '2025-06-12', 1, 43, 0, 0, 0, NULL, true, 0, 3360.0, 3360.0, 'Можно так же до 13.00 на Оренбургский тракт 4а. Светлана - +79954723715, для связи. +7 917 878-34-06. Сергей Слободенюк', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (451, client_id, 'completed', '2025-05-01', '2025-06-02', 2, 48, 0, 0, 0, NULL, true, 0, 7360.0, 7360.0, 'В 12:00', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Обыденникова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (450, client_id, 'completed', '2025-04-30', '2025-04-30', 1, 42, 0, 0, 0, NULL, true, 0, 11840.0, 11840.0, 'Ривьера', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Обыденникова%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (449, client_id, 'completed', '2025-02-06', '2025-02-08', 3, 32, 0, 0, 0, NULL, true, 0, 7200.0, 7200.0, 'Татарстан Мастерская впечатлений', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Мария Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (445, client_id, 'completed', '2025-04-24', '2025-04-26', 3, 31, 0, 0, 0, NULL, true, 0, 6960.0, 6960.0, 'Кристал. Вернули в кристал. Привезет Ильдар 051', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Гульфия%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (444, client_id, 'completed', '2025-01-26', '2025-01-26', 1, 12, 0, 0, 0, NULL, true, 0, 880.0, 880.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Лариса%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (443, client_id, 'completed', '2025-01-25', '2025-01-25', 1, 55, 0, 0, 0, NULL, true, 0, 4080.0, 4080.0, '-', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (442, client_id, 'completed', '2025-01-21', '2025-01-22', 2, 54, 0, 0, 0, NULL, true, 0, 8320.0, 8320.0, 'Сулейман Владимир Николаевич', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Ирина Пронина%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (441, client_id, 'completed', '2025-01-12', '2025-01-12', 1, 33, 0, 0, 0, NULL, true, 0, 2560.0, 2560.0, 'Созвониться 11.01 до обеда', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Инна Экскурсовод%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (440, client_id, 'completed', '2025-01-18', '2025-01-18', 1, 20, 0, 0, 0, NULL, true, 0, 1440.0, 1440.0, 'Свита холл', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Юлианна%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (439, client_id, 'completed', '2025-01-08', '2025-01-09', 2, 25, 0, 0, 0, NULL, true, 0, 3220.0, 3220.0, 'Волга', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Питер%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (438, client_id, 'completed', '2025-01-04', '2025-01-06', 3, 28, 0, 0, 0, NULL, true, 0, 5265.0, 5265.0, 'Тиц , Баумана', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Питер%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (437, client_id, 'completed', '2025-01-04', '2025-01-04', 1, 40, 0, 0, 0, NULL, true, 0, 2535.0, 2535.0, 'Юнион амакс Сафар', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Питер%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (436, client_id, 'completed', '2025-01-04', '2025-01-04', 1, 40, 0, 0, 0, NULL, true, 0, 2535.0, 2535.0, 'Юнион релита', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Питер%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (435, client_id, 'completed', '2025-01-04', '2025-01-04', 1, 44, 0, 0, 0, NULL, true, 0, 2795.0, 2795.0, 'Юнион, амакс сафар', stas_id, stas_name, stas_id, stas_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (434, client_id, 'completed', '2025-01-06', '2025-01-07', 2, 48, 0, 0, 0, NULL, true, 0, 7360.0, 7360.0, '6-7.01 гид Марина Рукавишникова +79172526993 6.01 в Сулейман к 9.00 вернут 7.01 после 22.00 в Кристалл', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
  SELECT id INTO client_id FROM rental_clients WHERE name ILIKE '%Татьяна (Гольфстрим)%' LIMIT 1;
  IF client_id IS NOT NULL THEN
    INSERT INTO rental_orders (order_number, client_id, status, start_date, end_date, days_count, kit_count, spare_receiver_count, transmitter_count, microphone_count, bag_number, is_charged, price_per_unit, total_price, prepayment, receiver_notes, manager_id, manager_name, owner_manager_id, owner_manager_name, created_at, updated_at) VALUES (433, client_id, 'completed', '2025-01-05', '2025-01-07', 3, 28, 0, 0, 0, NULL, true, 0, 6240.0, 6240.0, '5-7 января Гид Владимир Николаевич +7917885840 5,01 в отель Сулейман к 8,30 вернут 7,01 после 18 по созвону, вернул в Сулейман', leonid_id, leonid_name, leonid_id, leonid_name, NOW(), NOW());
  END IF;
END $$;