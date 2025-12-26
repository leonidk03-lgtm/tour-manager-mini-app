# TourManager - Приложение для отчётности по экскурсиям

## Обзор
TourManager - мобильное приложение на React Native для российского рынка, предназначенное для помощи тур-менеджерам и администраторам в отслеживании экскурсий, управлении финансами, настройке ценообразования и контроле аккаунтов менеджеров. Построено на Expo, поддерживает кроссплатформенный деплой (iOS, Android, Web) с интерфейсом в стиле Telegram.

## Предпочтения пользователя
Стиль общения: Простой, повседневный язык.
Стиль дизайна: Тёмная тема в стиле Telegram с плоским дизайном.

## Архитектура системы

### UI/UX решения
Приложение использует плоский дизайн в стиле Telegram с тёмной темой, синий Telegram как основной акцент. Включает переиспользуемые компоненты с темизацией и адаптацию под iOS и Android.

### Технические реализации
Приложение построено на React Native (v0.81.5), React (v19.1.0) и Expo SDK (v54) с TypeScript. Навигация через React Navigation v7 с нижней панелью вкладок. Управление состоянием через React Context API, хранение данных в Supabase PostgreSQL.

### Основные модули
- Dashboard, Экскурсии, Финансы, Настройки, Админ-панель, Отчёты, Радиогиды, Чат, Уведомления, Склад

### Модель данных
- TourType, Excursion, Transaction, Manager, RadioGuideKit, RentalOrder, EquipmentItem, ChatMessage

### Аутентификация
Supabase управляет аутентификацией по логину/паролю для ролей Manager и Admin с Row Level Security (RLS).

### CRM модуль аренды
Управление клиентами, заказами, комиссиями и оборудованием. Поддержка мульти-блочных заказов, расчёт комиссии от прибыли, авто-списание расходников.

---

## Система Telegram-уведомлений

### Основные таблицы
- `telegram_contacts` - связанные контакты Telegram
- `notification_logs` - логи уведомлений
- `notification_settings` - настройки бота и уведомлений

### Типы уведомлений
`order_issued`, `order_returned`, `bag_issued`, `reminder`, `order_cancelled`, `status_change`, `equipment_issued`

### Одноразовые ссылки-приглашения
Система генерирует ссылки `https://t.me/{botname}?start={code}` для подключения клиентов и гидов.
Поля БД: `telegram_invite_code`, `telegram_chat_id`, `invite_code_used`, `invite_code_expires_at`

---

## Telegram-бот v2.0

### Команды
- `/start` - начало работы с ботом
- `/start {code}` - подключение по коду приглашения
- `/menu` - главное меню
- `/orders` - список заказов
- `/help` - справка

### Inline-кнопки меню
- Активные заказы
- История заказов
- Новый заказ (открывает Mini App)
- Помощь

### Обработка callback-запросов
Навигация по меню, список заказов с пагинацией, детали заказа, создание нового заказа.

---

## Telegram Mini App

Отдельное веб-приложение React + Vite в папке `/mini-app/` для создания заказов прямо в Telegram.

### Функциональность
- Форма заказа: даты аренды, количество дней, комплекты, доп. оборудование, комментарий
- Автоматический расчёт стоимости
- Интеграция с Telegram WebApp API (HapticFeedback, MainButton)
- Определение клиента по telegram_chat_id

### Валидация формы
- Дата начала не может быть в прошлом
- Дата окончания >= дата начала
- Минимум 1 комплект
- Минимум 1 день аренды

### Безопасность
- Mini App использует anon key (публичный) - безопасно для клиентского кода
- Edge Functions используют service_role key через переменные окружения Supabase
- Telegram initData валидируется для определения клиента

---

## Инструкция по настройке

### Шаг 1: Задеплоить Edge Functions
```bash
supabase functions deploy send-telegram-message --project-ref ВАШ_PROJECT_REF
supabase functions deploy telegram-webhook --project-ref ВАШ_PROJECT_REF
supabase functions deploy notify-new-order --project-ref ВАШ_PROJECT_REF
```

### Шаг 2: Выполнить SQL миграции
```sql
-- Добавить поле для telegram_chat_id менеджеров
ALTER TABLE managers ADD COLUMN IF NOT EXISTS telegram_chat_id TEXT;

-- Добавить поле для URL Mini App
ALTER TABLE notification_settings ADD COLUMN IF NOT EXISTS mini_app_url TEXT;

-- Установить telegram_chat_id для админов (получите через @userinfobot)
UPDATE managers SET telegram_chat_id = 'ВАШ_CHAT_ID' WHERE is_admin = true;

-- Установить URL Mini App после деплоя
UPDATE notification_settings SET mini_app_url = 'https://your-mini-app-url.com';
```

### Шаг 3: Настроить Database Webhook
1. Перейдите: https://supabase.com/dashboard/project/ВАШ_PROJECT_REF/database/hooks
2. Создайте новый hook:
   - Имя: `notify_new_order`
   - Таблица: `rental_orders`
   - События: `INSERT`
   - Тип: HTTP Request
   - Метод: POST
   - URL: `https://ВАШ_PROJECT_REF.supabase.co/functions/v1/notify-new-order`
3. Добавьте заголовки:
   - `Authorization`: `Bearer ВАШ_SERVICE_ROLE_KEY`
   - `Content-Type`: `application/json`

### Шаг 4: Настроить Telegram Webhook
Откройте в браузере:
```
https://api.telegram.org/botВАШ_BOT_TOKEN/setWebhook?url=https://ВАШ_PROJECT_REF.supabase.co/functions/v1/telegram-webhook
```

### Шаг 5: Задеплоить Mini App
1. `cd mini-app && npm install`
2. Создать `.env`:
   ```
   VITE_SUPABASE_URL=ваш_supabase_url
   VITE_SUPABASE_ANON_KEY=ваш_anon_key
   ```
3. `npm run build`
4. Захостить папку `dist/` на публичном HTTPS (Vercel, Netlify, Cloudflare Pages)
5. Настроить Mini App в BotFather: `/newapp`
6. Обновить `mini_app_url` в notification_settings

### Шаг 6: Тестирование
1. Напишите боту `/start` - должно появиться главное меню
2. Нажмите "Новый заказ" - откроется Mini App
3. Создайте заказ - админы получат уведомление в Telegram
4. Проверьте логи Edge Functions в Supabase Dashboard

---

## Внешние зависимости

**Expo**: expo, expo-splash-screen, expo-status-bar, expo-constants, expo-font, expo-linking, expo-web-browser, expo-haptics, expo-system-ui, expo-image, expo-symbols, expo-blur, expo-linear-gradient, expo-glass-effect

**Навигация**: @react-navigation/native, @react-navigation/bottom-tabs, @react-navigation/native-stack, @react-navigation/elements, react-native-screens, react-native-safe-area-context

**Анимации**: react-native-reanimated, react-native-gesture-handler, react-native-worklets, react-native-keyboard-controller

**UI**: @expo/vector-icons

**Backend**: @supabase/supabase-js, Supabase PostgreSQL
