# TourManager - Tour Excursion Reporting App

## Overview
TourManager is a React Native mobile application designed for the Russian market to assist tour managers and administrators. Its primary purpose is to track excursions, manage finances, configure pricing, and oversee manager accounts. Built with Expo, it supports cross-platform deployment (iOS, Android, Web) and features a Telegram-inspired UI, comprehensive data management, and real-time synchronization. The application aims to optimize tour operations and financial reporting for tourism businesses. Key capabilities include managing tour types, excursions, transactions, equipment, and a robust rental CRM module with commission tracking and auto-writeoff features. The project's ambition is to provide an all-in-one solution for streamlining the complex logistics and financial aspects of tour management.

## User Preferences
Preferred communication style: Simple, everyday language.
Design style: Telegram-inspired dark theme with flat design.

## System Architecture

### UI/UX Decisions
The application features a Telegram-inspired flat design with a dark-first theme, using semantic color tokens and Telegram blue as the primary accent. It utilizes reusable, themed components and specialized screen wrappers for consistent styling. Platform-specific UI adjustments are implemented for iOS (e.g., blur effects) and Android (e.g., edge-to-edge layout), with web fallbacks for native-only features.

### Technical Implementations
The application is built with React Native (v0.81.5), React (v19.1.0), and Expo SDK (v54), leveraging TypeScript for type safety and the New Architecture for performance. Navigation is managed by React Navigation v7, featuring a bottom tab bar with dedicated stack navigators for Dashboard, Excursions, Finances, and Settings. Animations are handled by Reanimated 4.1, and native touch interactions by Gesture Handler. State management is primarily done via React Context API (`DataContext`, `AuthContext`), with data persistence and real-time synchronization handled by Supabase PostgreSQL.

### Feature Specifications
*   **Core Modules**: Dashboard, Excursions, Finances, Settings, Admin Panel, Reports, Radio Guides, Chat, Notifications, and Warehouse management.
*   **Data Model**: Interconnected entities such as `TourType`, `Excursion`, `AdditionalService`, `Transaction`, `Manager`, `RadioGuideKit`, `RentalOrder`, `EquipmentItem`, `TourGuide`, and `ChatMessage` facilitate comprehensive data tracking.
*   **Authentication & Authorization**: Supabase handles username/password authentication with `Manager` and `Admin` roles. Row Level Security (RLS) enforces data access based on roles, with `AuthContext` managing the authentication state.
*   **Rental CRM Module**: Manages clients, orders, commissions, and equipment. Supports multi-block equipment orders, automatic commission calculation based on profit, and an auto-writeoff system for consumables.
*   **Advanced Features**:
    *   **Customizable Dashboard**: Widgets visible and order configurable by the user.
    *   **Commission System**: Profit-based commission calculation for owner and executor managers with configurable percentages.
    *   **Auto-Writeoff System**: Automatic deduction of consumables from inventory upon equipment issuance (excursions or rentals) or service sales.
    *   **Bulk Payment & Reconciliation**: Features for bulk payment of multiple orders and generating reconciliation reports for clients.
    *   **Granular Rental Permissions**: Fine-grained access control for different sections of the rental module.
    *   **Equipment Loss Tracking**: System for registering, tracking, and recovering lost equipment from both excursions and rental orders, integrating with inventory.
    *   **Dispatch Marking Activity Tracking**: Monitors and reports manager activity in the dispatching system, including marked phones and tourists, with an admin report for performance analysis.
    *   **Tour Guides Directory**: Справочник экскурсоводов с CRUD операциями и поиском по имени и номеру телефона. Доступ через Настройки -> Оборудование -> Гиды.

### System Design Choices
The architecture emphasizes modularity, reusability, and scalability. The choice of Expo facilitates cross-platform deployment, while Supabase provides a robust backend with real-time capabilities. The New Architecture of React Native is leveraged for enhanced performance. Data integrity is maintained through a well-defined relational data model and Supabase RLS.

### Telegram Notifications System
The application includes a Telegram notification system for sending alerts to clients and guides. **Important security note**: The Telegram bot token must NEVER be exposed in frontend code. The system uses a Supabase Edge Function to securely handle Telegram API calls.

**Required Tables** (created via SQL in Supabase - TABLES ARE NOW CREATED):
- `telegram_contacts`: Stores phone-to-Telegram chat ID mappings
- `notification_logs`: Logs all sent notifications with status  
- `notification_settings`: Stores bot token and global settings

**Notification Types Supported**:
- `order_issued` - Order issued to client
- `order_returned` - Equipment returned
- `bag_issued` - Equipment block issued to guide
- `reminder` - Reminder before rental date
- `order_cancelled` - Order cancelled
- `status_change` - Order status changed
- `equipment_issued` - Equipment issued

**Admin Settings** (in NotificationsScreen):
- Toggle Telegram notifications on/off
- Set Bot Token (stored securely in notification_settings table)
- Set Bot Username (required for invite links)
- View connected Telegram contacts count
- Configure reminder days before rental
- Configure reminder time (09:00, 10:00, 12:00, 14:00, 18:00)

### Telegram One-Time Invite Links
Система одноразовых приглашений для привязки клиентов и гидов к Telegram:
- Ссылки формата `https://t.me/{botname}?start={code}`
- Код генерируется автоматически (16 hex символов)
- Срок действия: 7 дней
- После активации ссылка становится недействительной (inviteCodeUsed = true)
- UI-блок в карточках клиентов и гидов для генерации/копирования ссылок

**Поля в таблицах rental_clients и tour_guides**:
- `telegram_invite_code` - уникальный код приглашения
- `telegram_chat_id` - ID чата после привязки
- `invite_code_used` - флаг использования кода
- `invite_code_expires_at` - срок действия кода

**Required SQL Migrations** (execute in Supabase Dashboard → SQL Editor):
```sql
-- Добавить поля для приглашений в rental_clients
ALTER TABLE rental_clients 
ADD COLUMN IF NOT EXISTS telegram_invite_code TEXT,
ADD COLUMN IF NOT EXISTS telegram_chat_id TEXT,
ADD COLUMN IF NOT EXISTS invite_code_used BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS invite_code_expires_at TIMESTAMPTZ;

-- Добавить поля для приглашений в tour_guides
ALTER TABLE tour_guides 
ADD COLUMN IF NOT EXISTS telegram_invite_code TEXT,
ADD COLUMN IF NOT EXISTS telegram_chat_id TEXT,
ADD COLUMN IF NOT EXISTS invite_code_used BOOLEAN DEFAULT FALSE,
ADD COLUMN IF NOT EXISTS invite_code_expires_at TIMESTAMPTZ;

-- Добавить поле для имени бота
ALTER TABLE notification_settings 
ADD COLUMN IF NOT EXISTS telegram_bot_username TEXT;

-- Добавить поле для времени напоминания
ALTER TABLE notification_settings 
ADD COLUMN IF NOT EXISTS reminder_time TEXT DEFAULT '12:00';

-- Добавить поле для URL Mini App
ALTER TABLE notification_settings 
ADD COLUMN IF NOT EXISTS mini_app_url TEXT;

-- Добавить поле telegram_chat_id для менеджеров (для получения уведомлений о новых заказах)
ALTER TABLE managers 
ADD COLUMN IF NOT EXISTS telegram_chat_id TEXT;
```

**Supabase Edge Function Deployment**:
1. Install Supabase CLI: `npm install -g supabase`
2. Login: `supabase login`
3. Link project: `supabase link --project-ref YOUR_PROJECT_REF`
4. Deploy functions:
   - `supabase functions deploy send-telegram-message`
   - `supabase functions deploy telegram-webhook`
5. Set the `telegram_bot_token` via app settings or directly in notification_settings table
6. **Set up Telegram Webhook**:
   - Get your function URL: `https://<project-ref>.supabase.co/functions/v1/telegram-webhook`
   - Set webhook via Telegram API:
   ```
   https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook?url=https://<project-ref>.supabase.co/functions/v1/telegram-webhook
   ```
7. **Тестирование webhook**:
   - Откройте Telegram и напишите боту `/start`
   - Для подключённых клиентов должно показаться главное меню
   - Протестируйте кнопки: Активные заказы, История, Помощь
8. **Привязка менеджеров для уведомлений**:
   - В Supabase добавьте telegram_chat_id для админ-менеджеров:
   ```sql
   UPDATE managers SET telegram_chat_id = 'CHAT_ID' WHERE username = 'admin';
   ```
   - Chat ID можно получить через @userinfobot или отправив сообщение боту

**Edge Function Files**:
- `supabase/functions/send-telegram-message/index.ts` - отправка сообщений
- `supabase/functions/telegram-webhook/index.ts` - обработка входящих сообщений, меню, callback-запросов

### Telegram Bot Features (v2.0)
Расширенный бот с интерактивным интерфейсом для клиентов:

**Команды**:
- `/start` - Приветствие и главное меню (для подключённых клиентов)
- `/start {код}` - Привязка через ссылку-приглашение
- `/menu` - Открыть главное меню
- `/orders` - Список заказов
- `/help` - Справка

**Inline-кнопки меню**:
- 📋 Активные заказы - заказы со статусом "new" или "issued"
- 📚 История - завершённые, возвращённые, отменённые заказы
- ➕ Новый заказ - информация о создании заказа (Mini App)
- ❓ Помощь - справка по командам и статусам

**Callback-обработка**:
- `menu` - возврат в главное меню
- `orders:{offset}` - список заказов с пагинацией
- `order:{id}` - детали конкретного заказа
- `active_orders` - только активные заказы
- `history:{offset}` - история заказов с пагинацией
- `new_order` - создание заказа
- `help` - справка

### Telegram Mini App
Веб-приложение для создания заказов прямо в Telegram:

**Расположение**: `/mini-app/`
- Изолированный React + Vite проект
- Metro bundler исключает эту папку через `metro.config.js`
- Собственный `package.json` и зависимости

**Функционал**:
- Форма создания заказа (даты, количество дней, комментарий)
- Выбор оборудования (комплекты, приёмники, передатчики, микрофоны)
- Автоматический расчёт стоимости
- Интеграция с Telegram WebApp API (HapticFeedback, MainButton)
- Автоматическое определение клиента по telegram_chat_id

**Настройка Mini App**:
1. Установить зависимости: `cd mini-app && npm install`
2. Создать `.env` файл в `/mini-app/`:
   ```
   VITE_SUPABASE_URL=your_supabase_url
   VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
   ```
3. Собрать: `npm run build`
4. Захостить dist/ на публичном HTTPS URL (Vercel, Netlify, Cloudflare Pages)
5. Настроить Mini App в BotFather: `/newapp` или `/editapp`
6. **Важно**: Добавить URL Mini App в таблицу notification_settings:
   ```sql
   UPDATE notification_settings SET mini_app_url = 'https://your-mini-app-url.com';
   ```
7. Уведомления о новых заказах отправляются админ-менеджерам с telegram_chat_id

**Валидация формы заказа**:
- Дата начала не может быть в прошлом
- Дата окончания >= дата начала
- Минимум 1 комплект
- Минимум 1 день аренды

**Безопасность**:
- Mini App использует anon key (публичный), безопасно для клиентского кода
- Edge Functions используют service_role key через переменные окружения Supabase
- Telegram initData валидируется для определения клиента

## External Dependencies

*   **Expo Ecosystem**: `expo` (core framework), `expo-splash-screen`, `expo-status-bar`, `expo-constants`, `expo-font`, `expo-linking`, `expo-web-browser`, `expo-haptics`, `expo-system-ui`, `expo-image`, `expo-symbols`, `expo-blur`, `expo-linear-gradient`, `expo-glass-effect`.
*   **Navigation**: `@react-navigation/native`, `@react-navigation/bottom-tabs`, `@react-navigation/native-stack`, `@react-navigation/elements`, `react-native-screens`, `react-native-safe-area-context`.
*   **Animation & Gestures**: `react-native-reanimated`, `react-native-gesture-handler`, `react-native-worklets`, `react-native-keyboard-controller`.
*   **UI Components**: `@expo/vector-icons`.
*   **Backend & Database**: `@supabase/supabase-js` (Supabase client), Supabase PostgreSQL (database with RLS and Realtime).