-- Import rental clients - UPDATED
-- name = contact person name (e.g. 'Арсен (Юнион)')
-- company_name = full legal name

-- Add company_name column if not exists:
ALTER TABLE rental_clients ADD COLUMN IF NOT EXISTS company_name TEXT;

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга Лотова', '+79170779471', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79170779471' OR name = 'Ольга Лотова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья Флот', '+79038307370', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79038307370' OR name = 'Наталья Флот');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Дмитрий (Алабуга-Волокно)', '+79178516882', NULL, 'company', 'Дмитрий (Алабуга-Волокно)', 'Габерлинг Андрей Владимирович', 'Общество с ограниченной ответственностью «АЛАБУГА-ВОЛОКНО»', '423601, Республика Татарстан (Татарстан), муниципальный район Елабужский, городское поселение город Елабуга, территория ОЭЗ Алабуга, улица Ш-2, строение 11/9.', '1646031132', '164601001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79178516882' OR name = 'Дмитрий (Алабуга-Волокно)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Дамир (Экскурс)', '+79969526558', NULL, 'company', 'Дамир (Экскурс)', 'ЗАКИРОВ РУШАН ЗАГИРОВИЧ', 'ИНДИВИДУАЛЬНЫЙ ПРЕДПРИНИМАТЕЛЬ ЗАКИРОВ РУШАН ЗАГИРОВИЧ', NULL, '165718122372', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79969526558' OR name = 'Дамир (Экскурс)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Юлия Супрунова (от Миры)', '+79372883686', NULL, 'company', 'Юлия Супрунова (от Миры)', 'СОКОЛОВА ЭЛЬМИРА РАВИЛЬЕВНА', 'ИП СОКОЛОВА ЭЛЬМИРА РАВИЛЬЕВНА', 'Казань, Зур Урам 1к,К5, 21', '165811612950', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79372883686' OR name = 'Юлия Супрунова (от Миры)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Вадим', '+79196451838', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79196451838' OR name = 'Вадим');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна ( Банк Путешествий)', '+79503192552', 'travelbank2020@mail.ru', 'company', 'Татьяна ( Банк Путешествий)', 'Белозеров Дмитрий Леонидович', 'ООО «Банк Путешествий»', '420061, РТ, г. Казань, ул. Николая Ершова, д.35 А, оф.33', '1655441368', '166001001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79503192552' OR name = 'Татьяна ( Банк Путешествий)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна', '+79509693961', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79509693961' OR name = 'Татьяна');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина «Романова Трэвел»', '+79159441878', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79159441878' OR name = 'Екатерина «Романова Трэвел»');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна (Мои Каникулы) (Круиз)', '+79246802568', NULL, 'company', 'Татьяна (Мои Каникулы) (Круиз)', 'Козлова Людмила Владимировна', 'Агентство туризма и отдыха «Круиз», ИП Козлова Л.В.', '676306, Амурская обл., г.Шимановск, ул.Мухина д.12 кв.2', '282911358577', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79246802568' OR name = 'Татьяна (Мои Каникулы) (Круиз)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Давид (КФУ)', '+79168133609', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79168133609' OR name = 'Давид (КФУ)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Андрей СПБ', '+79043349504', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79043349504' OR name = 'Андрей СПБ');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Управление Природными Территориями (УПТ)', '+79061135111', 'info@upt.tatar', 'company', 'Управление Природными Территориями (УПТ)', 'Минуллин Марсель Гумарович', 'Общество с ограниченной ответственностью «Управление природными территориями»', '420107, Республика Татарстан, г. Казань, ул. Спартаковская, д. 2, офис 327', '1655494592', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79061135111' OR name = 'Управление Природными Территориями (УПТ)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Марина Экс', '+79264062333', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79264062333' OR name = 'Марина Экс');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга (Тольятти)', '+79171208622', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79171208622' OR name = 'Ольга (Тольятти)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Лариса Перминова', '+79272408250', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79272408250' OR name = 'Лариса Перминова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Жанна', '+79262332196', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79262332196' OR name = 'Жанна');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анвар Каримов', '+79178844225', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79178844225' OR name = 'Анвар Каримов');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Сафина Алина (ФРГРТ)', '+79274163395', NULL, 'company', 'Сафина Алина (ФРГРТ)', 'Зиннатуллина Наиля Мудамилевна', 'Фонд «Институт развития городов РТ»', '420015, г. Казань, ул. Большая Красная, д. 64, литер. Б, пом. 2101', '1655360824', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79274163395' OR name = 'Сафина Алина (ФРГРТ)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Руслан (Тимсофт)', '+79600501515', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 80, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79600501515' OR name = 'Руслан (Тимсофт)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Гузелия', '+79510610028', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79510610028' OR name = 'Гузелия');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Вера', '+79377745735', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79377745735' OR name = 'Вера');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена', '+79872969542', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872969542' OR name = 'Елена');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алла (Вятские Поляны)', '+79226624712', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79226624712' OR name = 'Алла (Вятские Поляны)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Владимир Нежданов', '+79172788430', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79172788430' OR name = 'Владимир Нежданов');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Виктор (Мастерминд)', '+79506781207', NULL, 'company', 'Виктор (Мастерминд)', 'Валиев Марсель Камилович', 'Общество с ограниченной ответственностью «Мастерминд»', '420021, Республика Татарстан, г. Казань, ул. Чернышевского, 43/2', '1655295100', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79506781207' OR name = 'Виктор (Мастерминд)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Валентина Воронкова (Ввел Ком)', '+79032182869', 'voronkovavp@yandex.ru', 'company', 'Валентина Воронкова (Ввел Ком)', 'Воронкова Валентина Петровна', 'Общество с ограниченной ответственностью «Ввел Ком Ру»', '125475, г.Москва, ул. Зеленоградская, дом 17, кв. 51', '7743312316', '774301001', 80, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79032182869' OR name = 'Валентина Воронкова (Ввел Ком)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья Компания', '+79172891133', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79172891133' OR name = 'Наталья Компания');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Мария (ОСР)', '+79869160808', NULL, 'company', 'Мария (ОСР)', 'Казакова Мария Валерьевна', 'Общество с ограниченной ответственностью «ОСР»', '125375, г. Москва, Тверской бульвар, 20 строение 1, офис 4', '9728030631', '770301001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79869160808' OR name = 'Мария (ОСР)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Фируза', '+79534837004', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79534837004' OR name = 'Фируза');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ленар (ИП Ножкин)', '+79376252850', NULL, 'company', 'Ленар (ИП Ножкин)', 'Ножкин Ленар Геннадьевич', 'Индивидуальный предприниматель Ножкин Ленар Геннадьевич', '420124, г.Казань, ул. Четаева, д.42а, кв.78', '164807364692', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79376252850' OR name = 'Ленар (ИП Ножкин)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Элеонора Шадина', '+79172261987', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79172261987' OR name = 'Элеонора Шадина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга (Сиалия)', '+79108272699', NULL, 'company', 'Ольга (Сиалия)', 'Смирнова Ольга Евгеньевна', 'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ ТУРОПЕРАТОР «СИАЛИЯ»', '353535, КРАСНОДАРСКИЙ КРАЙ, М.Р-Н ТЕМРЮКСКИЙ, С.П. НОВОТАМАНСКОЕ, П ТАМАНСКИЙ, ПЕР НОВОРОССИЙСКИЙ, Д. 7', '2301109196', '230101001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79108272699' OR name = 'Ольга (Сиалия)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга', '+79118348339', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79118348339' OR name = 'Ольга');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Дарья', '+79677022929', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79677022929' OR name = 'Дарья');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина (ОЛТА Трэвел)', '+79111708200', NULL, 'company', 'Екатерина (ОЛТА Трэвел)', 'Смирнова Ольга Валерьевна', 'Общество с ограниченной ответственностью "ОЛТА Трэвел"', '191002, Г САНКТ-ПЕТЕРБУРГ, УЛ РАЗЪЕЗЖАЯ, ДОМ 5 ЛИТЕР А, ОФИС 140\3, ПОМЕЩ. 27Н-В1', '7839096793', '784001001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79111708200' OR name = 'Екатерина (ОЛТА Трэвел)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Родина-тур', '+79190117253', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79190117253' OR name = 'Родина-тур');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена Павловна', '+79515639790', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79515639790' OR name = 'Елена Павловна');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Имя', '+79534880189', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79534880189' OR name = 'Имя');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анастасия Пашинин (НК Транс Тур)', '+79639629332', 'info@nktrans-group.ru', 'company', 'Анастасия Пашинин (НК Транс Тур)', 'Киреева Елена Александровна', 'ООО «НК Транс Тур»', '121357 г. Москва, Верейская, д.29, стр.134, помещ.2Н/3', '7734738644', '773101001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79639629332' OR name = 'Анастасия Пашинин (НК Транс Тур)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Александра (Александрия)', '+79105850558', NULL, 'company', 'Александра (Александрия)', 'Александра Романова', 'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ "АЛЕКСАНДРИЯ СП/Б"', '300041, РОССИЯ, ТУЛЬСКАЯ ОБЛАСТЬ, Г.О. ГОРОД ТУЛА, Г ТУЛА, ПР-КТ ЛЕНИНА, Д. 32, ОФИС 303', '7106515620', '710701001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79105850558' OR name = 'Александра (Александрия)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Айгуль Файзуллина', '+79872961933', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872961933' OR name = 'Айгуль Файзуллина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Лариса', '+79273735552', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79273735552' OR name = 'Лариса');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Иванов Семён', '+79677791807', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79677791807' OR name = 'Иванов Семён');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Рената (Твоя Казань)', '+79196862442', 'tvoyakazanadm@mail.ru', 'company', 'Рената (Твоя Казань)', 'Зарипова Рената Наилевна', 'Общество с ограниченной ответственностью «Твоя Казань»', 'Юридический адрес:420055, РТ, г. Казань, ул. Ново - Давликеевская, д. 2А', '1684015318', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79196862442' OR name = 'Рената (Твоя Казань)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна (Агентство Удачи)', '+79178533525', NULL, 'company', 'Татьяна (Агентство Удачи)', 'Ганиев И.Р.', 'Общество с ограниченной ответственностью «АГЕНТСТВО УДАЧИ»', '420111, ТАТАРСТАН РЕСПУБЛИКА, ГОРОД КАЗАНЬ, УЛИЦА ПУШКИНА, ДОМ 29, ЛИТЕРА А, ОФИС 11', '1655405320', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79178533525' OR name = 'Татьяна (Агентство Удачи)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Яна (Вариот)', '+79778302928', NULL, 'company', 'Яна (Вариот)', 'Бабичев Дмитрий Сергеевич', 'ООО «ВАРИОТ»', '107078, г. Москва, ул. Садовая-Спасская, д.20, стр.1, 4 этаж, пом.1, ком.13', '7708734918', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79778302928' OR name = 'Яна (Вариот)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга', '+79278000133', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79278000133' OR name = 'Ольга');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Валерий', '+79053195486', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79053195486' OR name = 'Валерий');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Карина (технологии путешествий)', '+79179221193', NULL, 'company', 'Карина (технологии путешествий)', 'Ханнанов Ришат Асфанович', 'Индивидуальный Предприниматель Ханнанов Ришат Асфанович', '420500, Россия, Респ. Татарстан, Верхнеуслонский р-н, г. Иннополис, Ул. Спортивная, д. 114, Кв 5', '164444448875', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79179221193' OR name = 'Карина (технологии путешествий)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Лариса Позднякова', '+79172403085', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79172403085' OR name = 'Лариса Позднякова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена (Конгресс Авиа)', '+79172914815', NULL, 'company', 'Елена (Конгресс Авиа)', 'Ибрагимова Эльвира Баязитовна', 'ООО "Конгресс Авиа"', '420107, г.Казань, ул.Петербургская, 42, помещение 14', '1655321180', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79172914815' OR name = 'Елена (Конгресс Авиа)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Марат Забиров', '+79871865303', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79871865303' OR name = 'Марат Забиров');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Гузель (Юралс)', '+79063310993', NULL, 'company', 'Гузель (Юралс)', NULL, 'Общество с ограниченной ответственностью «СК «Юралс »', '423330, г . Азнакаево , ул. Тукая, д .1, офис 1010', '1655278129', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79063310993' OR name = 'Гузель (Юралс)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья Москва', '+79161638158', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79161638158' OR name = 'Наталья Москва');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Светлана (Лана-тур Казань)', '+79870051978', NULL, 'company', 'Светлана (Лана-тур Казань)', 'Абрамова Светлана Александровна', 'ООО «Лана-тур Казань»', '420140, г. Казань, ул. Вербная, д.1, кв. 217', '1659149438', '166001001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79870051978' OR name = 'Светлана (Лана-тур Казань)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Галина Рыжикова', '+79297259743', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79297259743' OR name = 'Галина Рыжикова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Вера (СК-Интур)', '+79112636331', NULL, 'company', 'Вера (СК-Интур)', 'Веренева Юлия Александровна', 'Общество с ограниченной ответственностью «СК-Интур»', '191119, город Санкт-Петербург, вн.тер. г. Муниципальный Округ Семеновский, ул Звенигородская, дом 1, корпус 2, литера А, помещ. 85-Н, офис 524', '7816579917', '783801001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79112636331' OR name = 'Вера (СК-Интур)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Оксана', '+79099242488', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79099242488' OR name = 'Оксана');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Диляра', '+79179275489', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79179275489' OR name = 'Диляра');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Любовь (ТИЦ)', '+79503118747', NULL, 'company', 'Любовь (ТИЦ)', 'Ковалева Любовь Анатольевна', 'Общество с ограниченной ответственностью "Туристско-информационный центр"', '420126, г.Казань, ул. Четаева д.13 кв.94', '1655456830', '168501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79503118747' OR name = 'Любовь (ТИЦ)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Арсен (Юнион)', '+79152964580', NULL, 'company', 'Арсен (Юнион)', NULL, 'ООО «Юнион»', NULL, '7733827429', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79152964580' OR name = 'Арсен (Юнион)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ляйсан (Казань 360)', '+79179062560', 'kazan360.com@gmail.com', 'company', 'Ляйсан (Казань 360)', 'Насретдинова Резеда Рафиковна', 'ООО «Казань360»', NULL, '1657246267', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79179062560' OR name = 'Ляйсан (Казань 360)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ирина (Иль Мио Тур)', '+79050249197', 'info@il-miotur.ru', 'company', 'Ирина (Иль Мио Тур)', 'Краснова Ирина Сергеевна', 'ООО «Иль Мио Тур»', NULL, '1648037080', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79050249197' OR name = 'Ирина (Иль Мио Тур)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Эвелина (Инициатива)', '+79600523400', 'info@iniciativa-kzn.ru', 'company', 'Эвелина (Инициатива)', 'Кузнецова Эвелина Юрьевна', 'Инициатива +', NULL, '1655146073', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79600523400' OR name = 'Эвелина (Инициатива)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Галина (Тур Урал)', '+79872904401', NULL, 'company', 'Галина (Тур Урал)', 'Таланкина Наталья Ивановна', 'ООО «Бюро путешествий и экскурсий «ТУР-УРАЛ»', NULL, '6659145369', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872904401' OR name = 'Галина (Тур Урал)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга (Дольче Вита)', '+79206736156', NULL, 'company', 'Ольга (Дольче Вита)', 'Тарарыкина Анастасия Валерьевна', 'Дольче Вита', NULL, '3702184562', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79206736156' OR name = 'Ольга (Дольче Вита)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Светлана Зеленина', '+79190783257', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79190783257' OR name = 'Светлана Зеленина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анна', '+79179332160', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79179332160' OR name = 'Анна');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Константин', '+79063248898', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79063248898' OR name = 'Константин');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анастасия Шадрина', '+79274143743', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79274143743' OR name = 'Анастасия Шадрина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Эльвира', '+79377797273', NULL, 'company', 'Эльвира', NULL, 'CROSS Турагентство.', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79377797273' OR name = 'Эльвира');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Антон', '+79103961028', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79103961028' OR name = 'Антон');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена Тамбова (Апрель)', '+79158685892', NULL, 'company', 'Елена Тамбова (Апрель)', 'Говердовская Ольга Михайловна', 'ООО «Апрель»', '392000, г. Тамбов, ул. Интернациональная, д. 13,к5', '6829043455', '682901001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79158685892' OR name = 'Елена Тамбова (Апрель)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анастасия', '+79042786414', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79042786414' OR name = 'Анастасия');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79172922000', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79172922000' OR name = 'Наталья');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Юлия (Рыжий Слон)', '+79222673014', NULL, 'company', 'Юлия (Рыжий Слон)', 'Матиевская Любовь Сергеевна', 'ООО «МП «Рыжий Слон»', '625007, г.Тюмень, ул.Н.Чаплина, 125, кв. 155', '7204178764', '720301001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79222673014' OR name = 'Юлия (Рыжий Слон)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Дмитрий Попков', '+79089197168', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79089197168' OR name = 'Дмитрий Попков');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга', '+79006000057', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79006000057' OR name = 'Ольга');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Луиза', '+79196855619', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79196855619' OR name = 'Луиза');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Нина Тиханова', '+79033061734', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79033061734' OR name = 'Нина Тиханова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга Тандалова', '+79261608591', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79261608591' OR name = 'Ольга Тандалова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Аниса', '+79031562454', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79031562454' OR name = 'Аниса');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Варвара', '+79161550131', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79161550131' OR name = 'Варвара');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина', '+79950953373', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79950953373' OR name = 'Екатерина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ирина Сафронова', '+79172934870', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79172934870' OR name = 'Ирина Сафронова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Палитра Тур', '+79171014003', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79171014003' OR name = 'Палитра Тур');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Лариса', '+79022870302', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79022870302' OR name = 'Лариса');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ирина Пронина', '+79276703000', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79276703000' OR name = 'Ирина Пронина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Питер', '+79179064739', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79179064739' OR name = 'Питер');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алена Волина', '+79503244678', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79503244678' OR name = 'Алена Волина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Юрий', '+79129231660', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79129231660' OR name = 'Юрий');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Твой Гид', NULL, NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = NULL OR name = 'Твой Гид');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Александр Романов', '+79112872606', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79112872606' OR name = 'Александр Романов');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Титова Галина (Эллинлайн)', '+79219733344', NULL, 'company', 'Титова Галина (Эллинлайн)', 'Титовой Галины Леонидовны', 'ООО «Эллинлайн»', '198329, Санкт-Петербург, ул. Тамбасова, 4\2 -280', '7807028247', '780701001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79219733344' OR name = 'Титова Галина (Эллинлайн)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Лейла', '+79172488804', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79172488804' OR name = 'Лейла');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'С+р', NULL, NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = NULL OR name = 'С+р');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ирина', '+79169501665', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79169501665' OR name = 'Ирина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Александр', '+79272534202', NULL, 'company', 'Александр', NULL, 'Грэйс-тревел', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79272534202' OR name = 'Александр');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алексей', '+79225115900', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79225115900' OR name = 'Алексей');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Искандер', '+79033449007', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79033449007' OR name = 'Искандер');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина', '+79109939725', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79109939725' OR name = 'Екатерина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79827935377', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79827935377' OR name = 'Наталья');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Валентина Экскурсовод', '+79172989675', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79172989675' OR name = 'Валентина Экскурсовод');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена Марковна ( черный список)', '+79122438485', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79122438485' OR name = 'Елена Марковна ( черный список)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга Волковец', '+79273838350', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79273838350' OR name = 'Ольга Волковец');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Мария Экскурсовод', '+79274900014', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79274900014' OR name = 'Мария Экскурсовод');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Морозова', '+79631166119', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79631166119' OR name = 'Морозова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Айрат Нурмухаммадов', '+79274463215', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 80, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79274463215' OR name = 'Айрат Нурмухаммадов');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна', '+79027805858', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79027805858' OR name = 'Татьяна');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Андрей', '+79600311560', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79600311560' OR name = 'Андрей');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79257337010', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79257337010' OR name = 'Наталья');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена', '+79376267304', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79376267304' OR name = 'Елена');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Зульхиза Кутлучурина', '+79659400307', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79659400307' OR name = 'Зульхиза Кутлучурина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина', '+79087256018', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79087256018' OR name = 'Екатерина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Марианна', '+79003225015', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79003225015' OR name = 'Марианна');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья Жукова', '+79272434367', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79272434367' OR name = 'Наталья Жукова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Нина Салькова', '380714403848', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '380714403848' OR name = 'Нина Салькова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ирина Михайловна', '+79033403252', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79033403252' OR name = 'Ирина Михайловна');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Игорь Воронов', '+79053770542', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79053770542' OR name = 'Игорь Воронов');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Евгения Заговорина', '+79013633803', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79013633803' OR name = 'Евгения Заговорина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Салькова Нина', NULL, NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = NULL OR name = 'Салькова Нина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Оксана', '+79872816240', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872816240' OR name = 'Оксана');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Клиент', '+79141859919', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79141859919' OR name = 'Клиент');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Камилла', '+79874092737', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79874092737' OR name = 'Камилла');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Гульназ', '+79393902610', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79393902610' OR name = 'Гульназ');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Клиент', NULL, NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = NULL OR name = 'Клиент');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алина Минеева', '+79530225627', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79530225627' OR name = 'Алина Минеева');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Камила Ягудина', '+79600565131', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79600565131' OR name = 'Камила Ягудина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена Николаева', '+79141859919', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79141859919' OR name = 'Елена Николаева');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Любовь Ким', '+79277213758', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79277213758' OR name = 'Любовь Ким');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Галина Тур Москва', '+79163108629', NULL, 'company', 'Галина Тур Москва', 'Лобутева Галина Александровна', 'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ "ФЭМИЛИ-ТУР"', '140250, МОСКОВСКАЯ ОБЛАСТЬ, Г.О. ВОСКРЕСЕНСК, С ЮРАСОВО, УЛ СОЛНЕЧНАЯ, ДВЛД. 23А', '5005075270', '500501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79163108629' OR name = 'Галина Тур Москва');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Снежана', '+79625795347', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79625795347' OR name = 'Снежана');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Автокруиз', '+79028352353', NULL, 'company', 'Автокруиз', NULL, 'Автокруиз', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79028352353' OR name = 'Автокруиз');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79036945019', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79036945019' OR name = 'Наталья');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Лиля Экскурсовод', '+79872902704', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872902704' OR name = 'Лиля Экскурсовод');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена Экскурсовод', '+79003208221', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79003208221' OR name = 'Елена Экскурсовод');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наргиз', '+79867215041', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79867215041' OR name = 'Наргиз');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Светлана', '+79033428060', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79033428060' OR name = 'Светлана');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Клиент', '+79991640682', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79991640682' OR name = 'Клиент');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ксения', '+79872141100', NULL, 'company', 'Ксения', NULL, 'АВИТ', NULL, '1655135610', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872141100' OR name = 'Ксения');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'София', '+79274111993', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79274111993' OR name = 'София');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Сергей', '+79220064070', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79220064070' OR name = 'Сергей');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79033405711', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79033405711' OR name = 'Наталья');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анюта Родионова (Родина-тур)', '+79101776156', NULL, 'company', 'Анюта Родионова (Родина-тур)', NULL, 'ООО «Родина-тур»', '601650, Владимирская обл., г. Александров, ул. Ленина, д. 16', '3301024280', '330101001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79101776156' OR name = 'Анюта Родионова (Родина-тур)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Зуфар(Аграрный Университет)', '+79872961344', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872961344' OR name = 'Зуфар(Аграрный Университет)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алсу', '+79600362522', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79600362522' OR name = 'Алсу');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79261409872', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79261409872' OR name = 'Наталья');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Яна Янова', '+79397368972', NULL, 'company', 'Яна Янова', NULL, 'ИП Кондренков Денис Дмитриевич', '420101 РТ, г. Казань ул. Рихарда Зорге, д. 13Б, кв. 89', '166017525632', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79397368972' OR name = 'Яна Янова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Данил (Антей Групп)', '+79534129930', NULL, 'company', 'Данил (Антей Групп)', NULL, 'Антей Групп', NULL, '1657147153', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79534129930' OR name = 'Данил (Антей Групп)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Марат Даутов', '+79033063787', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79033063787' OR name = 'Марат Даутов');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Рамис', '+79033414430', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79033414430' OR name = 'Рамис');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Гульнара', '+79625552796', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79625552796' OR name = 'Гульнара');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Зельфира', '+79872750395', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872750395' OR name = 'Зельфира');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Артем Агафонов', '+79068185524', 'club_teatralov@mail.ru', 'company', 'Артем Агафонов', 'Данилиной Елены Викторовны', 'ООО «Клуб Театральных Путешествий»', 'г. Ижевск, ул. Ленина 14', '1831181573', '183101001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79068185524' OR name = 'Артем Агафонов');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Мария Экскурсовод', '+79274299177', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79274299177' OR name = 'Мария Экскурсовод');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Динар (ТатКабель)', '+79063279749', NULL, 'company', 'Динар (ТатКабель)', 'Савин Евгений Викторович', 'ТАТКАБЕЛЬ', NULL, '1657259971', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79063279749' OR name = 'Динар (ТатКабель)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ильмира', '+79033888929', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79033888929' OR name = 'Ильмира');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Эмилия', '+79872231391', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872231391' OR name = 'Эмилия');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Юлианна', '+79033408152', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79033408152' OR name = 'Юлианна');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена (Магазин Путешествий)', '+79219471867', NULL, 'company', 'Елена (Магазин Путешествий)', NULL, 'Магазин Путешествий', NULL, '7841419410', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79219471867' OR name = 'Елена (Магазин Путешествий)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79624554760', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79624554760' OR name = 'Наталья');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Инна Экскурсовод', '+79869297050', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79869297050' OR name = 'Инна Экскурсовод');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Гульфия', '+79872821123', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872821123' OR name = 'Гульфия');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Гульнара', '+79178605272', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79178605272' OR name = 'Гульнара');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ирина Обыденникова', '+79270303303', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79270303303' OR name = 'Ирина Обыденникова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алёна Лазука', '+79172733148', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79172733148' OR name = 'Алёна Лазука');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина', '+79274662530', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79274662530' OR name = 'Екатерина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина Кореева', '+79046623179', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79046623179' OR name = 'Екатерина Кореева');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елизавета Ткач', '+79276797970', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79276797970' OR name = 'Елизавета Ткач');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Нечаева Тамара', '+79493022939', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79493022939' OR name = 'Нечаева Тамара');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Андрей Вологда', '+79211263650', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79211263650' OR name = 'Андрей Вологда');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Зеленина', '+79627930811', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79627930811' OR name = 'Зеленина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Светлана Клиент', '+79633126228', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79633126228' OR name = 'Светлана Клиент');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Мира (ИП)', '+79662409276', NULL, 'company', 'Мира (ИП)', NULL, 'ИП Соколова Эльмира Равильевна', NULL, '165811612950', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79662409276' OR name = 'Мира (ИП)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Светлана Клиент', '+79633126228', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79633126228' OR name = 'Светлана Клиент');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Тамара', '+79022038859', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79022038859' OR name = 'Тамара');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга Лукоянова', '+79872965880', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872965880' OR name = 'Ольга Лукоянова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Андрей (Экскурс)', '+79393309448', NULL, 'company', 'Андрей (Экскурс)', 'Нефёдова Раиса Петровна', 'ООО «ЭКСКУРС»', '420015, Казань, Горького, 10, офис №1', '1654018897', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79393309448' OR name = 'Андрей (Экскурс)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анна', '+79897718307', NULL, 'company', 'Анна', 'Кукшенева Инга Дмитриевна', 'ЕДЕМЕДЕМ.РУ', NULL, '5022048118', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79897718307' OR name = 'Анна');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Элина (Сититур)', '+79033443111', NULL, 'company', 'Элина (Сититур)', 'Гайсина Элина Ильгизяровна', 'ООО «Казань-Сититур»', '420021, г.Казань, ул.Н.Столбова, д.2', '1655187619', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79033443111' OR name = 'Элина (Сититур)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Эдик Заказы для групп', NULL, NULL, 'company', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = NULL OR name = 'Эдик Заказы для групп');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Мария', '+79127740429', NULL, 'company', 'Мария', NULL, 'ВЕЛЕС-ТУР г.Миасс', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79127740429' OR name = 'Мария');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена Игнатьева', '+79262118230', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79262118230' OR name = 'Елена Игнатьева');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна Чуб', '+79872827166', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872827166' OR name = 'Татьяна Чуб');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Мария Батяева', '+79159613586', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79159613586' OR name = 'Мария Батяева');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алина Сафина', '+79872797484', NULL, 'company', 'Алина Сафина', NULL, 'Белая Зебра', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79872797484' OR name = 'Алина Сафина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79172751068', NULL, 'company', 'Наталья', NULL, 'Вернисаж-Казань', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79172751068' OR name = 'Наталья');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Юлия Воронова', '+79172278327', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79172278327' OR name = 'Юлия Воронова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья Рыжкова', '+79107527951', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79107527951' OR name = 'Наталья Рыжкова');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Галия', '+79600336033', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79600336033' OR name = 'Галия');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анастасия', '+79134535624', NULL, 'company', 'Анастасия', 'Раткевич Римма Викторовна', 'Парнас Новосибирск', NULL, '5404417303', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79134535624' OR name = 'Анастасия');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Галина', '+79994502017', NULL, 'company', 'Галина', 'Раткевич Римма Викторовна', 'Парнас Новосибирск', NULL, '5404417303', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79994502017' OR name = 'Галина');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Альберт (КТ)', '+79046699399', NULL, 'company', 'Альберт (КТ)', 'Насибуллин Альберт Наилевич', 'ООО "КАЗАНСКИЕ ТРАДИЦИИ "', '420021, Республика Татарстан, Г Казань, ул. Каюма Насыри, д. 28, помещ. 91а, офис 79', '1655484509', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79046699399' OR name = 'Альберт (КТ)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Сергей (Авангард)', '+79853891999', NULL, 'company', 'Сергей (Авангард)', NULL, 'Авангард', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79853891999' OR name = 'Сергей (Авангард)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна (Гольфстрим)', '+79179142756', NULL, 'company', 'Татьяна (Гольфстрим)', 'Лазарева Наталья Алексеевна', 'ООО «ГОЛЬФСТРИМ»', '420107, Республика Татарстан, город Казань, ул. Островского, д.57Б, офис 407', '1655493045', '165501001', 80, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79179142756' OR name = 'Татьяна (Гольфстрим)');

INSERT INTO rental_clients (name, phone, email, client_type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна (КБПИЭ)', '+79178761282', NULL, 'company', 'Татьяна (КБПИЭ)', 'Ишматова Татьяна Геннадьевна', 'КБПИЭ', NULL, '1655322547', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone = '+79178761282' OR name = 'Татьяна (КБПИЭ)');


SELECT COUNT(*) as imported_clients FROM rental_clients;