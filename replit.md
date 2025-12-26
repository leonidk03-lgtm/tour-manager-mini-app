# TourManager - Tour Excursion Reporting App

## Overview
TourManager is a React Native mobile application for the Russian market, designed to assist tour managers and administrators in tracking excursions, managing finances, configuring pricing, and overseeing manager accounts. Built with Expo, it supports cross-platform deployment (iOS, Android, Web) and features a Telegram-inspired UI, comprehensive data management, and real-time synchronization. The application's purpose is to optimize tour operations and financial reporting for tourism businesses, offering an all-in-one solution for streamlining logistics and financial aspects of tour management.

## User Preferences
Preferred communication style: Simple, everyday language.
Design style: Telegram-inspired dark theme with flat design.

## System Architecture

### UI/UX Decisions
The application features a Telegram-inspired flat design with a dark-first theme, utilizing semantic color tokens and Telegram blue as the primary accent. It incorporates reusable, themed components, specialized screen wrappers for consistent styling, and platform-specific UI adjustments for iOS and Android.

### Technical Implementations
The application is built with React Native (v0.81.5), React (v19.1.0), and Expo SDK (v54), leveraging TypeScript and the New Architecture for performance. Navigation uses React Navigation v7 with a bottom tab bar. State management is primarily handled via React Context API, with data persistence and real-time synchronization provided by Supabase PostgreSQL.

### Feature Specifications
*   **Core Modules**: Dashboard, Excursions, Finances, Settings, Admin Panel, Reports, Radio Guides, Chat, Notifications, and Warehouse management.
*   **Data Model**: Interconnected entities like `TourType`, `Excursion`, `Transaction`, `Manager`, `RadioGuideKit`, `RentalOrder`, `EquipmentItem`, and `ChatMessage`.
*   **Authentication & Authorization**: Supabase manages username/password authentication for `Manager` and `Admin` roles, with Row Level Security (RLS) enforcing data access.
*   **Rental CRM Module**: Manages clients, orders, commissions, and equipment, supporting multi-block equipment orders, profit-based commission calculation, and an auto-writeoff system for consumables.
*   **Advanced Features**: Customizable Dashboard, Commission System, Auto-Writeoff System, Bulk Payment & Reconciliation, Granular Rental Permissions, Equipment Loss Tracking, Dispatch Marking Activity Tracking, and a Tour Guides Directory.

### System Design Choices
The architecture emphasizes modularity, reusability, and scalability. Expo enables cross-platform deployment, while Supabase provides a robust backend with real-time capabilities. The React Native New Architecture is used for enhanced performance.

### Telegram Notifications System
A Telegram notification system sends alerts to clients and guides, securely handled by a Supabase Edge Function to prevent bot token exposure.
*   **Key Tables**: `telegram_contacts`, `notification_logs`, `notification_settings`.
*   **Supported Notification Types**: `order_issued`, `order_returned`, `bag_issued`, `reminder`, `order_cancelled`, `status_change`, `equipment_issued`.
*   **Admin Settings**: Toggle notifications, set Bot Token, Bot Username, connected contacts count, reminder days, and reminder time.

### Telegram One-Time Invite Links
The system generates one-time invite links (`https://t.me/{botname}?start={code}`) for connecting clients and guides to Telegram.
*   **Database Fields**: `telegram_invite_code`, `telegram_chat_id`, `invite_code_used`, `invite_code_expires_at` in `rental_clients` and `tour_guides` tables.

### Telegram Bot Features (v2.0)
An expanded bot with an interactive interface for clients.
*   **Commands**: `/start`, `/start {code}`, `/menu`, `/orders`, `/help`.
*   **Inline Menu Buttons**: Active orders, History, New order, Help.
*   **Callback Handling**: Menu navigation, order listing with pagination, specific order details, and new order creation.

### Telegram Mini App
A dedicated React + Vite web application (`/mini-app/`) for creating orders directly within Telegram.
*   **Functionality**: Order creation form (dates, quantity, comments), equipment selection, automatic cost calculation, Telegram WebApp API integration, and client identification via `telegram_chat_id`.
*   **Setup**: Requires separate build, hosting on a public HTTPS URL, and configuration in BotFather and `notification_settings` table.
*   **Security**: Uses Supabase anon key for the client-side and validates Telegram initData for client identification.
*   **Manager Notifications**: New orders trigger server-side notifications via Supabase Database Webhook (rental_orders INSERT → notify-new-order Edge Function).

### Server-Side Order Notifications
To notify admin managers when new orders are created via Mini App:

**Step 1: Deploy Edge Functions**
```bash
supabase functions deploy send-telegram-message --project-ref YOUR_PROJECT_REF
supabase functions deploy telegram-webhook --project-ref YOUR_PROJECT_REF
supabase functions deploy notify-new-order --project-ref YOUR_PROJECT_REF
```

**Step 2: Run SQL Migrations**
```sql
ALTER TABLE managers ADD COLUMN IF NOT EXISTS telegram_chat_id TEXT;
ALTER TABLE notification_settings ADD COLUMN IF NOT EXISTS mini_app_url TEXT;
UPDATE managers SET telegram_chat_id = 'YOUR_CHAT_ID' WHERE is_admin = true;
UPDATE notification_settings SET mini_app_url = 'https://your-mini-app-url.com';
```

**Step 3: Configure Database Webhook** (Supabase Dashboard → Database → Hooks)
1. Go to: https://supabase.com/dashboard/project/YOUR_PROJECT_REF/database/hooks
2. Create new hook:
   - Name: `notify_new_order`
   - Table: `rental_orders`
   - Events: `INSERT`
   - Hook type: HTTP Request
   - Method: POST
   - URL: `https://YOUR_PROJECT_REF.supabase.co/functions/v1/notify-new-order`
3. Add Headers:
   - `Authorization`: `Bearer YOUR_SERVICE_ROLE_KEY`
   - `Content-Type`: `application/json`

**Step 4: Set Telegram Webhook**
```
https://api.telegram.org/botYOUR_BOT_TOKEN/setWebhook?url=https://YOUR_PROJECT_REF.supabase.co/functions/v1/telegram-webhook
```

**Step 5: Testing**
1. Create order via Mini App
2. Verify admin managers with `telegram_chat_id` receive Telegram notification
3. Check Supabase Edge Function logs for errors

**Helper Script**: See `supabase/scripts/setup-webhook.sh` for step-by-step guide.

## External Dependencies

*   **Expo Ecosystem**: Core framework and various modules for splash screens, status bar, constants, fonts, linking, web browser, haptics, system UI, images, symbols, blur, linear gradient, and glass effect.
*   **Navigation**: `@react-navigation/native`, `@react-navigation/bottom-tabs`, `@react-navigation/native-stack`, `@react-navigation/elements`, `react-native-screens`, `react-native-safe-area-context`.
*   **Animation & Gestures**: `react-native-reanimated`, `react-native-gesture-handler`, `react-native-worklets`, `react-native-keyboard-controller`.
*   **UI Components**: `@expo/vector-icons`.
*   **Backend & Database**: `@supabase/supabase-js` (Supabase client), Supabase PostgreSQL (database with RLS and Realtime capabilities).