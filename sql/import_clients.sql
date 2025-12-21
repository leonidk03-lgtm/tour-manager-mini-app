-- Import rental clients - FIXED duplicate check
-- Uses AND instead of OR for unique check

ALTER TABLE rental_clients ADD COLUMN IF NOT EXISTS company_name TEXT;

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга Лотова', '+79170779471', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79170779471' AND name IS NOT DISTINCT FROM 'Ольга Лотова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья Флот', '+79038307370', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79038307370' AND name IS NOT DISTINCT FROM 'Наталья Флот');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Дмитрий (Алабуга-Волокно)', '+79178516882', NULL, 'company', 'Дмитрий (Алабуга-Волокно)', 'Габерлинг Андрей Владимирович', 'Общество с ограниченной ответственностью «АЛАБУГА-ВОЛОКНО»', '423601, Республика Татарстан (Татарстан), муниципальный район Елабужский, городское поселение город Елабуга, территория ОЭЗ Алабуга, улица Ш-2, строение 11/9.', '1646031132', '164601001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79178516882' AND name IS NOT DISTINCT FROM 'Дмитрий (Алабуга-Волокно)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Дамир (Экскурс)', '+79969526558', NULL, 'company', 'Дамир (Экскурс)', 'ЗАКИРОВ РУШАН ЗАГИРОВИЧ', 'ИНДИВИДУАЛЬНЫЙ ПРЕДПРИНИМАТЕЛЬ ЗАКИРОВ РУШАН ЗАГИРОВИЧ', NULL, '165718122372', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79969526558' AND name IS NOT DISTINCT FROM 'Дамир (Экскурс)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Юлия Супрунова (от Миры)', '+79372883686', NULL, 'company', 'Юлия Супрунова (от Миры)', 'СОКОЛОВА ЭЛЬМИРА РАВИЛЬЕВНА', 'ИП СОКОЛОВА ЭЛЬМИРА РАВИЛЬЕВНА', 'Казань, Зур Урам 1к,К5, 21', '165811612950', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79372883686' AND name IS NOT DISTINCT FROM 'Юлия Супрунова (от Миры)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Вадим', '+79196451838', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79196451838' AND name IS NOT DISTINCT FROM 'Вадим');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна ( Банк Путешествий)', '+79503192552', 'travelbank2020@mail.ru', 'company', 'Татьяна ( Банк Путешествий)', 'Белозеров Дмитрий Леонидович', 'ООО «Банк Путешествий»', '420061, РТ, г. Казань, ул. Николая Ершова, д.35 А, оф.33', '1655441368', '166001001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79503192552' AND name IS NOT DISTINCT FROM 'Татьяна ( Банк Путешествий)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна', '+79509693961', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79509693961' AND name IS NOT DISTINCT FROM 'Татьяна');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина «Романова Трэвел»', '+79159441878', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79159441878' AND name IS NOT DISTINCT FROM 'Екатерина «Романова Трэвел»');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна (Мои Каникулы) (Круиз)', '+79246802568', NULL, 'company', 'Татьяна (Мои Каникулы) (Круиз)', 'Козлова Людмила Владимировна', 'Агентство туризма и отдыха «Круиз», ИП Козлова Л.В.', '676306, Амурская обл., г.Шимановск, ул.Мухина д.12 кв.2', '282911358577', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79246802568' AND name IS NOT DISTINCT FROM 'Татьяна (Мои Каникулы) (Круиз)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Давид (КФУ)', '+79168133609', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79168133609' AND name IS NOT DISTINCT FROM 'Давид (КФУ)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Андрей СПБ', '+79043349504', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79043349504' AND name IS NOT DISTINCT FROM 'Андрей СПБ');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Управление Природными Территориями (УПТ)', '+79061135111', 'info@upt.tatar', 'company', 'Управление Природными Территориями (УПТ)', 'Минуллин Марсель Гумарович', 'Общество с ограниченной ответственностью «Управление природными территориями»', '420107, Республика Татарстан, г. Казань, ул. Спартаковская, д. 2, офис 327', '1655494592', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79061135111' AND name IS NOT DISTINCT FROM 'Управление Природными Территориями (УПТ)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Марина Экс', '+79264062333', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79264062333' AND name IS NOT DISTINCT FROM 'Марина Экс');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга (Тольятти)', '+79171208622', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79171208622' AND name IS NOT DISTINCT FROM 'Ольга (Тольятти)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Лариса Перминова', '+79272408250', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79272408250' AND name IS NOT DISTINCT FROM 'Лариса Перминова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Жанна', '+79262332196', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79262332196' AND name IS NOT DISTINCT FROM 'Жанна');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анвар Каримов', '+79178844225', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79178844225' AND name IS NOT DISTINCT FROM 'Анвар Каримов');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Сафина Алина (ФРГРТ)', '+79274163395', NULL, 'company', 'Сафина Алина (ФРГРТ)', 'Зиннатуллина Наиля Мудамилевна', 'Фонд «Институт развития городов РТ»', '420015, г. Казань, ул. Большая Красная, д. 64, литер. Б, пом. 2101', '1655360824', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79274163395' AND name IS NOT DISTINCT FROM 'Сафина Алина (ФРГРТ)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Руслан (Тимсофт)', '+79600501515', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 80, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79600501515' AND name IS NOT DISTINCT FROM 'Руслан (Тимсофт)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Гузелия', '+79510610028', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79510610028' AND name IS NOT DISTINCT FROM 'Гузелия');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Вера', '+79377745735', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79377745735' AND name IS NOT DISTINCT FROM 'Вера');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена', '+79872969542', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872969542' AND name IS NOT DISTINCT FROM 'Елена');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алла (Вятские Поляны)', '+79226624712', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79226624712' AND name IS NOT DISTINCT FROM 'Алла (Вятские Поляны)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Владимир Нежданов', '+79172788430', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79172788430' AND name IS NOT DISTINCT FROM 'Владимир Нежданов');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Виктор (Мастерминд)', '+79506781207', NULL, 'company', 'Виктор (Мастерминд)', 'Валиев Марсель Камилович', 'Общество с ограниченной ответственностью «Мастерминд»', '420021, Республика Татарстан, г. Казань, ул. Чернышевского, 43/2', '1655295100', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79506781207' AND name IS NOT DISTINCT FROM 'Виктор (Мастерминд)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Валентина Воронкова (Ввел Ком)', '+79032182869', 'voronkovavp@yandex.ru', 'company', 'Валентина Воронкова (Ввел Ком)', 'Воронкова Валентина Петровна', 'Общество с ограниченной ответственностью «Ввел Ком Ру»', '125475, г.Москва, ул. Зеленоградская, дом 17, кв. 51', '7743312316', '774301001', 80, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79032182869' AND name IS NOT DISTINCT FROM 'Валентина Воронкова (Ввел Ком)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья Компания', '+79172891133', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79172891133' AND name IS NOT DISTINCT FROM 'Наталья Компания');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Мария (ОСР)', '+79869160808', NULL, 'company', 'Мария (ОСР)', 'Казакова Мария Валерьевна', 'Общество с ограниченной ответственностью «ОСР»', '125375, г. Москва, Тверской бульвар, 20 строение 1, офис 4', '9728030631', '770301001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79869160808' AND name IS NOT DISTINCT FROM 'Мария (ОСР)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Фируза', '+79534837004', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79534837004' AND name IS NOT DISTINCT FROM 'Фируза');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ленар (ИП Ножкин)', '+79376252850', NULL, 'company', 'Ленар (ИП Ножкин)', 'Ножкин Ленар Геннадьевич', 'Индивидуальный предприниматель Ножкин Ленар Геннадьевич', '420124, г.Казань, ул. Четаева, д.42а, кв.78', '164807364692', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79376252850' AND name IS NOT DISTINCT FROM 'Ленар (ИП Ножкин)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Элеонора Шадина', '+79172261987', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79172261987' AND name IS NOT DISTINCT FROM 'Элеонора Шадина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга (Сиалия)', '+79108272699', NULL, 'company', 'Ольга (Сиалия)', 'Смирнова Ольга Евгеньевна', 'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ ТУРОПЕРАТОР «СИАЛИЯ»', '353535, КРАСНОДАРСКИЙ КРАЙ, М.Р-Н ТЕМРЮКСКИЙ, С.П. НОВОТАМАНСКОЕ, П ТАМАНСКИЙ, ПЕР НОВОРОССИЙСКИЙ, Д. 7', '2301109196', '230101001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79108272699' AND name IS NOT DISTINCT FROM 'Ольга (Сиалия)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга', '+79118348339', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79118348339' AND name IS NOT DISTINCT FROM 'Ольга');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Дарья', '+79677022929', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79677022929' AND name IS NOT DISTINCT FROM 'Дарья');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина (ОЛТА Трэвел)', '+79111708200', NULL, 'company', 'Екатерина (ОЛТА Трэвел)', 'Смирнова Ольга Валерьевна', 'Общество с ограниченной ответственностью "ОЛТА Трэвел"', '191002, Г САНКТ-ПЕТЕРБУРГ, УЛ РАЗЪЕЗЖАЯ, ДОМ 5 ЛИТЕР А, ОФИС 140\3, ПОМЕЩ. 27Н-В1', '7839096793', '784001001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79111708200' AND name IS NOT DISTINCT FROM 'Екатерина (ОЛТА Трэвел)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Родина-тур', '+79190117253', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79190117253' AND name IS NOT DISTINCT FROM 'Родина-тур');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена Павловна', '+79515639790', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79515639790' AND name IS NOT DISTINCT FROM 'Елена Павловна');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Имя', '+79534880189', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79534880189' AND name IS NOT DISTINCT FROM 'Имя');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анастасия Пашинин (НК Транс Тур)', '+79639629332', 'info@nktrans-group.ru', 'company', 'Анастасия Пашинин (НК Транс Тур)', 'Киреева Елена Александровна', 'ООО «НК Транс Тур»', '121357 г. Москва, Верейская, д.29, стр.134, помещ.2Н/3', '7734738644', '773101001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79639629332' AND name IS NOT DISTINCT FROM 'Анастасия Пашинин (НК Транс Тур)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Александра (Александрия)', '+79105850558', NULL, 'company', 'Александра (Александрия)', 'Александра Романова', 'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ "АЛЕКСАНДРИЯ СП/Б"', '300041, РОССИЯ, ТУЛЬСКАЯ ОБЛАСТЬ, Г.О. ГОРОД ТУЛА, Г ТУЛА, ПР-КТ ЛЕНИНА, Д. 32, ОФИС 303', '7106515620', '710701001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79105850558' AND name IS NOT DISTINCT FROM 'Александра (Александрия)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Айгуль Файзуллина', '+79872961933', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872961933' AND name IS NOT DISTINCT FROM 'Айгуль Файзуллина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Лариса', '+79273735552', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79273735552' AND name IS NOT DISTINCT FROM 'Лариса');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Иванов Семён', '+79677791807', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79677791807' AND name IS NOT DISTINCT FROM 'Иванов Семён');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Рената (Твоя Казань)', '+79196862442', 'tvoyakazanadm@mail.ru', 'company', 'Рената (Твоя Казань)', 'Зарипова Рената Наилевна', 'Общество с ограниченной ответственностью «Твоя Казань»', 'Юридический адрес:420055, РТ, г. Казань, ул. Ново - Давликеевская, д. 2А', '1684015318', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79196862442' AND name IS NOT DISTINCT FROM 'Рената (Твоя Казань)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна (Агентство Удачи)', '+79178533525', NULL, 'company', 'Татьяна (Агентство Удачи)', 'Ганиев И.Р.', 'Общество с ограниченной ответственностью «АГЕНТСТВО УДАЧИ»', '420111, ТАТАРСТАН РЕСПУБЛИКА, ГОРОД КАЗАНЬ, УЛИЦА ПУШКИНА, ДОМ 29, ЛИТЕРА А, ОФИС 11', '1655405320', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79178533525' AND name IS NOT DISTINCT FROM 'Татьяна (Агентство Удачи)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Яна (Вариот)', '+79778302928', NULL, 'company', 'Яна (Вариот)', 'Бабичев Дмитрий Сергеевич', 'ООО «ВАРИОТ»', '107078, г. Москва, ул. Садовая-Спасская, д.20, стр.1, 4 этаж, пом.1, ком.13', '7708734918', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79778302928' AND name IS NOT DISTINCT FROM 'Яна (Вариот)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга', '+79278000133', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79278000133' AND name IS NOT DISTINCT FROM 'Ольга');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Валерий', '+79053195486', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79053195486' AND name IS NOT DISTINCT FROM 'Валерий');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Карина (технологии путешествий)', '+79179221193', NULL, 'company', 'Карина (технологии путешествий)', 'Ханнанов Ришат Асфанович', 'Индивидуальный Предприниматель Ханнанов Ришат Асфанович', '420500, Россия, Респ. Татарстан, Верхнеуслонский р-н, г. Иннополис, Ул. Спортивная, д. 114, Кв 5', '164444448875', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79179221193' AND name IS NOT DISTINCT FROM 'Карина (технологии путешествий)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Лариса Позднякова', '+79172403085', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79172403085' AND name IS NOT DISTINCT FROM 'Лариса Позднякова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена (Конгресс Авиа)', '+79172914815', NULL, 'company', 'Елена (Конгресс Авиа)', 'Ибрагимова Эльвира Баязитовна', 'ООО "Конгресс Авиа"', '420107, г.Казань, ул.Петербургская, 42, помещение 14', '1655321180', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79172914815' AND name IS NOT DISTINCT FROM 'Елена (Конгресс Авиа)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Марат Забиров', '+79871865303', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79871865303' AND name IS NOT DISTINCT FROM 'Марат Забиров');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Гузель (Юралс)', '+79063310993', NULL, 'company', 'Гузель (Юралс)', NULL, 'Общество с ограниченной ответственностью «СК «Юралс »', '423330, г . Азнакаево , ул. Тукая, д .1, офис 1010', '1655278129', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79063310993' AND name IS NOT DISTINCT FROM 'Гузель (Юралс)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья Москва', '+79161638158', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79161638158' AND name IS NOT DISTINCT FROM 'Наталья Москва');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Светлана (Лана-тур Казань)', '+79870051978', NULL, 'company', 'Светлана (Лана-тур Казань)', 'Абрамова Светлана Александровна', 'ООО «Лана-тур Казань»', '420140, г. Казань, ул. Вербная, д.1, кв. 217', '1659149438', '166001001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79870051978' AND name IS NOT DISTINCT FROM 'Светлана (Лана-тур Казань)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Галина Рыжикова', '+79297259743', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79297259743' AND name IS NOT DISTINCT FROM 'Галина Рыжикова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Вера (СК-Интур)', '+79112636331', NULL, 'company', 'Вера (СК-Интур)', 'Веренева Юлия Александровна', 'Общество с ограниченной ответственностью «СК-Интур»', '191119, город Санкт-Петербург, вн.тер. г. Муниципальный Округ Семеновский, ул Звенигородская, дом 1, корпус 2, литера А, помещ. 85-Н, офис 524', '7816579917', '783801001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79112636331' AND name IS NOT DISTINCT FROM 'Вера (СК-Интур)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Оксана', '+79099242488', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79099242488' AND name IS NOT DISTINCT FROM 'Оксана');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Диляра', '+79179275489', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79179275489' AND name IS NOT DISTINCT FROM 'Диляра');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Любовь (ТИЦ)', '+79503118747', NULL, 'company', 'Любовь (ТИЦ)', 'Ковалева Любовь Анатольевна', 'Общество с ограниченной ответственностью "Туристско-информационный центр"', '420126, г.Казань, ул. Четаева д.13 кв.94', '1655456830', '168501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79503118747' AND name IS NOT DISTINCT FROM 'Любовь (ТИЦ)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Арсен (Юнион)', '+79152964580', NULL, 'company', 'Арсен (Юнион)', NULL, 'ООО «Юнион»', NULL, '7733827429', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79152964580' AND name IS NOT DISTINCT FROM 'Арсен (Юнион)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ляйсан (Казань 360)', '+79179062560', 'kazan360.com@gmail.com', 'company', 'Ляйсан (Казань 360)', 'Насретдинова Резеда Рафиковна', 'ООО «Казань360»', NULL, '1657246267', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79179062560' AND name IS NOT DISTINCT FROM 'Ляйсан (Казань 360)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ирина (Иль Мио Тур)', '+79050249197', 'info@il-miotur.ru', 'company', 'Ирина (Иль Мио Тур)', 'Краснова Ирина Сергеевна', 'ООО «Иль Мио Тур»', NULL, '1648037080', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79050249197' AND name IS NOT DISTINCT FROM 'Ирина (Иль Мио Тур)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Эвелина (Инициатива)', '+79600523400', 'info@iniciativa-kzn.ru', 'company', 'Эвелина (Инициатива)', 'Кузнецова Эвелина Юрьевна', 'Инициатива +', NULL, '1655146073', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79600523400' AND name IS NOT DISTINCT FROM 'Эвелина (Инициатива)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Галина (Тур Урал)', '+79872904401', NULL, 'company', 'Галина (Тур Урал)', 'Таланкина Наталья Ивановна', 'ООО «Бюро путешествий и экскурсий «ТУР-УРАЛ»', NULL, '6659145369', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872904401' AND name IS NOT DISTINCT FROM 'Галина (Тур Урал)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга (Дольче Вита)', '+79206736156', NULL, 'company', 'Ольга (Дольче Вита)', 'Тарарыкина Анастасия Валерьевна', 'Дольче Вита', NULL, '3702184562', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79206736156' AND name IS NOT DISTINCT FROM 'Ольга (Дольче Вита)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Светлана Зеленина', '+79190783257', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79190783257' AND name IS NOT DISTINCT FROM 'Светлана Зеленина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анна', '+79179332160', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79179332160' AND name IS NOT DISTINCT FROM 'Анна');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Константин', '+79063248898', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79063248898' AND name IS NOT DISTINCT FROM 'Константин');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анастасия Шадрина', '+79274143743', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79274143743' AND name IS NOT DISTINCT FROM 'Анастасия Шадрина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Эльвира', '+79377797273', NULL, 'company', 'Эльвира', NULL, 'CROSS Турагентство.', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79377797273' AND name IS NOT DISTINCT FROM 'Эльвира');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Антон', '+79103961028', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79103961028' AND name IS NOT DISTINCT FROM 'Антон');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена Тамбова (Апрель)', '+79158685892', NULL, 'company', 'Елена Тамбова (Апрель)', 'Говердовская Ольга Михайловна', 'ООО «Апрель»', '392000, г. Тамбов, ул. Интернациональная, д. 13,к5', '6829043455', '682901001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79158685892' AND name IS NOT DISTINCT FROM 'Елена Тамбова (Апрель)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анастасия', '+79042786414', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79042786414' AND name IS NOT DISTINCT FROM 'Анастасия');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79172922000', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79172922000' AND name IS NOT DISTINCT FROM 'Наталья');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Юлия (Рыжий Слон)', '+79222673014', NULL, 'company', 'Юлия (Рыжий Слон)', 'Матиевская Любовь Сергеевна', 'ООО «МП «Рыжий Слон»', '625007, г.Тюмень, ул.Н.Чаплина, 125, кв. 155', '7204178764', '720301001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79222673014' AND name IS NOT DISTINCT FROM 'Юлия (Рыжий Слон)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Дмитрий Попков', '+79089197168', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79089197168' AND name IS NOT DISTINCT FROM 'Дмитрий Попков');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга', '+79006000057', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79006000057' AND name IS NOT DISTINCT FROM 'Ольга');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Луиза', '+79196855619', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79196855619' AND name IS NOT DISTINCT FROM 'Луиза');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Нина Тиханова', '+79033061734', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79033061734' AND name IS NOT DISTINCT FROM 'Нина Тиханова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга Тандалова', '+79261608591', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79261608591' AND name IS NOT DISTINCT FROM 'Ольга Тандалова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Аниса', '+79031562454', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79031562454' AND name IS NOT DISTINCT FROM 'Аниса');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Варвара', '+79161550131', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79161550131' AND name IS NOT DISTINCT FROM 'Варвара');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина', '+79950953373', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79950953373' AND name IS NOT DISTINCT FROM 'Екатерина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ирина Сафронова', '+79172934870', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79172934870' AND name IS NOT DISTINCT FROM 'Ирина Сафронова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Палитра Тур', '+79171014003', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79171014003' AND name IS NOT DISTINCT FROM 'Палитра Тур');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Лариса', '+79022870302', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79022870302' AND name IS NOT DISTINCT FROM 'Лариса');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ирина Пронина', '+79276703000', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79276703000' AND name IS NOT DISTINCT FROM 'Ирина Пронина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Питер', '+79179064739', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79179064739' AND name IS NOT DISTINCT FROM 'Питер');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алена Волина', '+79503244678', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79503244678' AND name IS NOT DISTINCT FROM 'Алена Волина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Юрий', '+79129231660', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79129231660' AND name IS NOT DISTINCT FROM 'Юрий');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Твой Гид', NULL, NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM NULL AND name IS NOT DISTINCT FROM 'Твой Гид');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Александр Романов', '+79112872606', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79112872606' AND name IS NOT DISTINCT FROM 'Александр Романов');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Титова Галина (Эллинлайн)', '+79219733344', NULL, 'company', 'Титова Галина (Эллинлайн)', 'Титовой Галины Леонидовны', 'ООО «Эллинлайн»', '198329, Санкт-Петербург, ул. Тамбасова, 4\2 -280', '7807028247', '780701001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79219733344' AND name IS NOT DISTINCT FROM 'Титова Галина (Эллинлайн)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Лейла', '+79172488804', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79172488804' AND name IS NOT DISTINCT FROM 'Лейла');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'С+р', NULL, NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM NULL AND name IS NOT DISTINCT FROM 'С+р');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ирина', '+79169501665', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79169501665' AND name IS NOT DISTINCT FROM 'Ирина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Александр', '+79272534202', NULL, 'company', 'Александр', NULL, 'Грэйс-тревел', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79272534202' AND name IS NOT DISTINCT FROM 'Александр');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алексей', '+79225115900', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79225115900' AND name IS NOT DISTINCT FROM 'Алексей');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Искандер', '+79033449007', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79033449007' AND name IS NOT DISTINCT FROM 'Искандер');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина', '+79109939725', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79109939725' AND name IS NOT DISTINCT FROM 'Екатерина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79827935377', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79827935377' AND name IS NOT DISTINCT FROM 'Наталья');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Валентина Экскурсовод', '+79172989675', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79172989675' AND name IS NOT DISTINCT FROM 'Валентина Экскурсовод');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена Марковна ( черный список)', '+79122438485', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79122438485' AND name IS NOT DISTINCT FROM 'Елена Марковна ( черный список)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга Волковец', '+79273838350', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79273838350' AND name IS NOT DISTINCT FROM 'Ольга Волковец');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Мария Экскурсовод', '+79274900014', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79274900014' AND name IS NOT DISTINCT FROM 'Мария Экскурсовод');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Морозова', '+79631166119', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79631166119' AND name IS NOT DISTINCT FROM 'Морозова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Айрат Нурмухаммадов', '+79274463215', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 80, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79274463215' AND name IS NOT DISTINCT FROM 'Айрат Нурмухаммадов');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна', '+79027805858', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79027805858' AND name IS NOT DISTINCT FROM 'Татьяна');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Андрей', '+79600311560', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79600311560' AND name IS NOT DISTINCT FROM 'Андрей');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79257337010', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79257337010' AND name IS NOT DISTINCT FROM 'Наталья');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена', '+79376267304', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79376267304' AND name IS NOT DISTINCT FROM 'Елена');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Зульхиза Кутлучурина', '+79659400307', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79659400307' AND name IS NOT DISTINCT FROM 'Зульхиза Кутлучурина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина', '+79087256018', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79087256018' AND name IS NOT DISTINCT FROM 'Екатерина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Марианна', '+79003225015', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79003225015' AND name IS NOT DISTINCT FROM 'Марианна');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья Жукова', '+79272434367', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79272434367' AND name IS NOT DISTINCT FROM 'Наталья Жукова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Нина Салькова', '380714403848', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '380714403848' AND name IS NOT DISTINCT FROM 'Нина Салькова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ирина Михайловна', '+79033403252', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79033403252' AND name IS NOT DISTINCT FROM 'Ирина Михайловна');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Игорь Воронов', '+79053770542', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79053770542' AND name IS NOT DISTINCT FROM 'Игорь Воронов');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Евгения Заговорина', '+79013633803', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79013633803' AND name IS NOT DISTINCT FROM 'Евгения Заговорина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Салькова Нина', NULL, NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM NULL AND name IS NOT DISTINCT FROM 'Салькова Нина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Оксана', '+79872816240', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872816240' AND name IS NOT DISTINCT FROM 'Оксана');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Клиент', '+79141859919', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79141859919' AND name IS NOT DISTINCT FROM 'Клиент');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Камилла', '+79874092737', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79874092737' AND name IS NOT DISTINCT FROM 'Камилла');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Гульназ', '+79393902610', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79393902610' AND name IS NOT DISTINCT FROM 'Гульназ');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Клиент', NULL, NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM NULL AND name IS NOT DISTINCT FROM 'Клиент');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алина Минеева', '+79530225627', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79530225627' AND name IS NOT DISTINCT FROM 'Алина Минеева');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Камила Ягудина', '+79600565131', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79600565131' AND name IS NOT DISTINCT FROM 'Камила Ягудина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена Николаева', '+79141859919', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79141859919' AND name IS NOT DISTINCT FROM 'Елена Николаева');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Любовь Ким', '+79277213758', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79277213758' AND name IS NOT DISTINCT FROM 'Любовь Ким');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Галина Тур Москва', '+79163108629', NULL, 'company', 'Галина Тур Москва', 'Лобутева Галина Александровна', 'ОБЩЕСТВО С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ "ФЭМИЛИ-ТУР"', '140250, МОСКОВСКАЯ ОБЛАСТЬ, Г.О. ВОСКРЕСЕНСК, С ЮРАСОВО, УЛ СОЛНЕЧНАЯ, ДВЛД. 23А', '5005075270', '500501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79163108629' AND name IS NOT DISTINCT FROM 'Галина Тур Москва');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Снежана', '+79625795347', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79625795347' AND name IS NOT DISTINCT FROM 'Снежана');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Автокруиз', '+79028352353', NULL, 'company', 'Автокруиз', NULL, 'Автокруиз', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79028352353' AND name IS NOT DISTINCT FROM 'Автокруиз');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79036945019', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79036945019' AND name IS NOT DISTINCT FROM 'Наталья');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Лиля Экскурсовод', '+79872902704', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872902704' AND name IS NOT DISTINCT FROM 'Лиля Экскурсовод');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена Экскурсовод', '+79003208221', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79003208221' AND name IS NOT DISTINCT FROM 'Елена Экскурсовод');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наргиз', '+79867215041', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79867215041' AND name IS NOT DISTINCT FROM 'Наргиз');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Светлана', '+79033428060', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79033428060' AND name IS NOT DISTINCT FROM 'Светлана');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Клиент', '+79991640682', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79991640682' AND name IS NOT DISTINCT FROM 'Клиент');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ксения', '+79872141100', NULL, 'company', 'Ксения', NULL, 'АВИТ', NULL, '1655135610', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872141100' AND name IS NOT DISTINCT FROM 'Ксения');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'София', '+79274111993', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79274111993' AND name IS NOT DISTINCT FROM 'София');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Сергей', '+79220064070', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79220064070' AND name IS NOT DISTINCT FROM 'Сергей');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79033405711', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79033405711' AND name IS NOT DISTINCT FROM 'Наталья');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анюта Родионова (Родина-тур)', '+79101776156', NULL, 'company', 'Анюта Родионова (Родина-тур)', NULL, 'ООО «Родина-тур»', '601650, Владимирская обл., г. Александров, ул. Ленина, д. 16', '3301024280', '330101001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79101776156' AND name IS NOT DISTINCT FROM 'Анюта Родионова (Родина-тур)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Зуфар(Аграрный Университет)', '+79872961344', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872961344' AND name IS NOT DISTINCT FROM 'Зуфар(Аграрный Университет)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алсу', '+79600362522', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79600362522' AND name IS NOT DISTINCT FROM 'Алсу');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79261409872', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79261409872' AND name IS NOT DISTINCT FROM 'Наталья');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Яна Янова', '+79397368972', NULL, 'company', 'Яна Янова', NULL, 'ИП Кондренков Денис Дмитриевич', '420101 РТ, г. Казань ул. Рихарда Зорге, д. 13Б, кв. 89', '166017525632', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79397368972' AND name IS NOT DISTINCT FROM 'Яна Янова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Данил (Антей Групп)', '+79534129930', NULL, 'company', 'Данил (Антей Групп)', NULL, 'Антей Групп', NULL, '1657147153', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79534129930' AND name IS NOT DISTINCT FROM 'Данил (Антей Групп)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Марат Даутов', '+79033063787', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79033063787' AND name IS NOT DISTINCT FROM 'Марат Даутов');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Рамис', '+79033414430', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79033414430' AND name IS NOT DISTINCT FROM 'Рамис');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Гульнара', '+79625552796', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79625552796' AND name IS NOT DISTINCT FROM 'Гульнара');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Зельфира', '+79872750395', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872750395' AND name IS NOT DISTINCT FROM 'Зельфира');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Артем Агафонов', '+79068185524', 'club_teatralov@mail.ru', 'company', 'Артем Агафонов', 'Данилиной Елены Викторовны', 'ООО «Клуб Театральных Путешествий»', 'г. Ижевск, ул. Ленина 14', '1831181573', '183101001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79068185524' AND name IS NOT DISTINCT FROM 'Артем Агафонов');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Мария Экскурсовод', '+79274299177', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79274299177' AND name IS NOT DISTINCT FROM 'Мария Экскурсовод');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Динар (ТатКабель)', '+79063279749', NULL, 'company', 'Динар (ТатКабель)', 'Савин Евгений Викторович', 'ТАТКАБЕЛЬ', NULL, '1657259971', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79063279749' AND name IS NOT DISTINCT FROM 'Динар (ТатКабель)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ильмира', '+79033888929', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79033888929' AND name IS NOT DISTINCT FROM 'Ильмира');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Эмилия', '+79872231391', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872231391' AND name IS NOT DISTINCT FROM 'Эмилия');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Юлианна', '+79033408152', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79033408152' AND name IS NOT DISTINCT FROM 'Юлианна');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена (Магазин Путешествий)', '+79219471867', NULL, 'company', 'Елена (Магазин Путешествий)', NULL, 'Магазин Путешествий', NULL, '7841419410', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79219471867' AND name IS NOT DISTINCT FROM 'Елена (Магазин Путешествий)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79624554760', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79624554760' AND name IS NOT DISTINCT FROM 'Наталья');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Инна Экскурсовод', '+79869297050', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79869297050' AND name IS NOT DISTINCT FROM 'Инна Экскурсовод');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Гульфия', '+79872821123', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872821123' AND name IS NOT DISTINCT FROM 'Гульфия');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Гульнара', '+79178605272', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79178605272' AND name IS NOT DISTINCT FROM 'Гульнара');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ирина Обыденникова', '+79270303303', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79270303303' AND name IS NOT DISTINCT FROM 'Ирина Обыденникова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алёна Лазука', '+79172733148', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79172733148' AND name IS NOT DISTINCT FROM 'Алёна Лазука');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина', '+79274662530', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79274662530' AND name IS NOT DISTINCT FROM 'Екатерина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Екатерина Кореева', '+79046623179', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79046623179' AND name IS NOT DISTINCT FROM 'Екатерина Кореева');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елизавета Ткач', '+79276797970', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79276797970' AND name IS NOT DISTINCT FROM 'Елизавета Ткач');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Нечаева Тамара', '+79493022939', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79493022939' AND name IS NOT DISTINCT FROM 'Нечаева Тамара');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Андрей Вологда', '+79211263650', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79211263650' AND name IS NOT DISTINCT FROM 'Андрей Вологда');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Зеленина', '+79627930811', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79627930811' AND name IS NOT DISTINCT FROM 'Зеленина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Светлана Клиент', '+79633126228', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79633126228' AND name IS NOT DISTINCT FROM 'Светлана Клиент');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Мира (ИП)', '+79662409276', NULL, 'company', 'Мира (ИП)', NULL, 'ИП Соколова Эльмира Равильевна', NULL, '165811612950', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79662409276' AND name IS NOT DISTINCT FROM 'Мира (ИП)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Светлана Клиент', '+79633126228', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79633126228' AND name IS NOT DISTINCT FROM 'Светлана Клиент');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Тамара', '+79022038859', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79022038859' AND name IS NOT DISTINCT FROM 'Тамара');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Ольга Лукоянова', '+79872965880', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872965880' AND name IS NOT DISTINCT FROM 'Ольга Лукоянова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Андрей (Экскурс)', '+79393309448', NULL, 'company', 'Андрей (Экскурс)', 'Нефёдова Раиса Петровна', 'ООО «ЭКСКУРС»', '420015, Казань, Горького, 10, офис №1', '1654018897', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79393309448' AND name IS NOT DISTINCT FROM 'Андрей (Экскурс)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анна', '+79897718307', NULL, 'company', 'Анна', 'Кукшенева Инга Дмитриевна', 'ЕДЕМЕДЕМ.РУ', NULL, '5022048118', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79897718307' AND name IS NOT DISTINCT FROM 'Анна');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Элина (Сититур)', '+79033443111', NULL, 'company', 'Элина (Сититур)', 'Гайсина Элина Ильгизяровна', 'ООО «Казань-Сититур»', '420021, г.Казань, ул.Н.Столбова, д.2', '1655187619', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79033443111' AND name IS NOT DISTINCT FROM 'Элина (Сититур)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Эдик Заказы для групп', NULL, NULL, 'company', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM NULL AND name IS NOT DISTINCT FROM 'Эдик Заказы для групп');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Мария', '+79127740429', NULL, 'company', 'Мария', NULL, 'ВЕЛЕС-ТУР г.Миасс', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79127740429' AND name IS NOT DISTINCT FROM 'Мария');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Елена Игнатьева', '+79262118230', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79262118230' AND name IS NOT DISTINCT FROM 'Елена Игнатьева');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна Чуб', '+79872827166', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872827166' AND name IS NOT DISTINCT FROM 'Татьяна Чуб');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Мария Батяева', '+79159613586', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79159613586' AND name IS NOT DISTINCT FROM 'Мария Батяева');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Алина Сафина', '+79872797484', NULL, 'company', 'Алина Сафина', NULL, 'Белая Зебра', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79872797484' AND name IS NOT DISTINCT FROM 'Алина Сафина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья', '+79172751068', NULL, 'company', 'Наталья', NULL, 'Вернисаж-Казань', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79172751068' AND name IS NOT DISTINCT FROM 'Наталья');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Юлия Воронова', '+79172278327', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79172278327' AND name IS NOT DISTINCT FROM 'Юлия Воронова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Наталья Рыжкова', '+79107527951', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79107527951' AND name IS NOT DISTINCT FROM 'Наталья Рыжкова');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Галия', '+79600336033', NULL, 'individual', NULL, NULL, NULL, NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79600336033' AND name IS NOT DISTINCT FROM 'Галия');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Анастасия', '+79134535624', NULL, 'company', 'Анастасия', 'Раткевич Римма Викторовна', 'Парнас Новосибирск', NULL, '5404417303', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79134535624' AND name IS NOT DISTINCT FROM 'Анастасия');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Галина', '+79994502017', NULL, 'company', 'Галина', 'Раткевич Римма Викторовна', 'Парнас Новосибирск', NULL, '5404417303', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79994502017' AND name IS NOT DISTINCT FROM 'Галина');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Альберт (КТ)', '+79046699399', NULL, 'company', 'Альберт (КТ)', 'Насибуллин Альберт Наилевич', 'ООО "КАЗАНСКИЕ ТРАДИЦИИ "', '420021, Республика Татарстан, Г Казань, ул. Каюма Насыри, д. 28, помещ. 91а, офис 79', '1655484509', '165501001', 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79046699399' AND name IS NOT DISTINCT FROM 'Альберт (КТ)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Сергей (Авангард)', '+79853891999', NULL, 'company', 'Сергей (Авангард)', NULL, 'Авангард', NULL, NULL, NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79853891999' AND name IS NOT DISTINCT FROM 'Сергей (Авангард)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна (Гольфстрим)', '+79179142756', NULL, 'company', 'Татьяна (Гольфстрим)', 'Лазарева Наталья Алексеевна', 'ООО «ГОЛЬФСТРИМ»', '420107, Республика Татарстан, город Казань, ул. Островского, д.57Б, офис 407', '1655493045', '165501001', 80, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79179142756' AND name IS NOT DISTINCT FROM 'Татьяна (Гольфстрим)');

INSERT INTO rental_clients (name, phone, email, type, director_name, ceo_name, company_name, legal_address, inn, kpp, default_price, created_at, updated_at)
SELECT 'Татьяна (КБПИЭ)', '+79178761282', NULL, 'company', 'Татьяна (КБПИЭ)', 'Ишматова Татьяна Геннадьевна', 'КБПИЭ', NULL, '1655322547', NULL, 100, NOW(), NOW()
WHERE NOT EXISTS (SELECT 1 FROM rental_clients WHERE phone IS NOT DISTINCT FROM '+79178761282' AND name IS NOT DISTINCT FROM 'Татьяна (КБПИЭ)');


SELECT COUNT(*) as imported_clients FROM rental_clients;