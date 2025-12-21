# TourManager - Tour Excursion Reporting App

## Overview
TourManager is a React Native mobile application for the Russian market, designed to help tour managers and administrators track excursions, manage finances, configure pricing, and oversee manager accounts. Built with Expo, it offers cross-platform deployment (iOS, Android, Web) and features a Telegram-inspired UI with comprehensive data management and real-time synchronization. The application aims to streamline tour operations and financial reporting for businesses in the tourism sector.

## User Preferences
Preferred communication style: Simple, everyday language.
Design style: Telegram-inspired dark theme with flat design.

## System Architecture

### Frontend Architecture
The application is built with React Native 0.81.5, React 19.1.0, and Expo SDK 54, leveraging TypeScript for type safety and the New Architecture for performance. Navigation is handled by React Navigation v7, featuring a bottom tab bar with Dashboard, Excursions, Finances, and Settings sections, each with its own stack navigator. The UI adheres to a Telegram-inspired flat design with a dark theme, utilizing Reanimated 4.1 for animations and Gesture Handler for native touch interactions. State management is managed with React Context API (`DataContext`, `AuthContext`), and data persistence is achieved via a Supabase PostgreSQL database with Realtime subscriptions for instant synchronization. Theming is dark-first with support for a light theme, using semantic color tokens and Telegram blue as the primary accent. Component architecture emphasizes reusable, themed components and specialized screen wrappers for consistent styling and layout.

### Data Model
The core entities include `TourType`, `Excursion`, `DeletedItem`, `AdditionalService`, `Transaction`, `Manager`, `RadioGuideKit`, `RadioGuideAssignment`, `DispatchingNote`, `ExcursionNote`, `ChatMessage`, `AppNotification`, `NotificationSettings`, `EquipmentCategory`, `EquipmentItem`, and `EquipmentMovement`. These entities are interconnected to track excursions, financial transactions, equipment management, and internal communication. Business logic utilities handle revenue, expense, and profit calculations, along with date range filtering.

### Authentication & Authorization
Supabase handles user authentication with username/password. Users are assigned `Manager` or `Admin` roles, with `AuthContext` managing authentication state. Managers can only view and modify their own excursions and transactions, enforced by Supabase Row Level Security (RLS). Admins have full data access, can manage manager accounts via an AdminPanel, and attribute data to specific managers.

### Screen Structure
Key screens include:
- **DashboardScreen**: Financial overview and recent excursions with customizable widget visibility and ordering via DashboardConfigScreen.
- **DashboardConfigScreen**: Configure which dashboard widgets are visible and their display order.
- **ExcursionsListScreen**: Searchable list of excursions.
- **ExcursionDetailScreen**: Detailed excursion view.
- **FinancesScreen**: Income/expense transaction management.
- **SettingsScreen**: User profile, logout, and access to other settings.
- **EditProfileScreen**: User profile editing.
- **DeletedDataScreen**: Soft-deleted data management.
- **TicketPricesScreen**: Management of tour types and additional services with seasonal availability.
- **AddExcursionForm**: Form for creating/editing excursions with participant breakdown and expense management.
- **AdminPanelScreen**: Manager account management.
- **ManagerDetailScreen**: Detailed view of individual manager activity and statistics.
- **ReportsScreen**: Admin-only hub for Financial, Excursions, Radio Guides Reports, and Data Export.
- **FinancialReportScreen**: Detailed financial analytics.
- **ExcursionsReportScreen**: Excursion and participant statistics.
- **RadioGuidesReportScreen**: Equipment usage and loss tracking.
- **ExportDataScreen**: CSV/JSON data export.
- **RadioGuidesScreen**: Radio guide equipment management, including issuing and returning.
- **ChatScreen**: Real-time chat for managers and admins.
- **NotificationsScreen**: In-app notification center and settings.
- **WarehouseScreen**: Inventory management for equipment and consumables, including low stock alerts and movement tracking.

### Rental CRM Module
The rental module provides comprehensive equipment rental management:
- **RentalClientsScreen**: Client management (individuals and companies) with contact info and assigned managers.
- **RentalOrdersScreen**: Order list with status filters, quick status changes, and phone contact options (call, WhatsApp, Telegram).
- **RentalOrderDetailScreen**: Detailed order view with payment history, equipment tracking, status management, equipment loss registration, and equipment blocks breakdown display.
- **AddRentalOrderScreen**: Order creation with client selection, multiple equipment blocks support (each block with independent kit counts, spare receivers, transmitters, microphones, and bag selection), pricing, and executor assignment.
- **RentalCommissionsScreen**: View and manage manager commissions from completed orders.

### Multi-Block Equipment Orders
Orders can have multiple equipment blocks, each with independent equipment counts and one bag assignment:
- Each block stores: bagNumber, kitCount, spareReceiverCount, transmitterCount, microphoneCount
- Auto-fill for spare receivers: 1 spare for 1-day rentals, 2 spares for 2+ day rentals
- Equipment blocks are persisted in `equipment_blocks` JSONB column for accurate round-trip editing
- Legacy orders (without equipment_blocks) fall back to aggregated totals with bag number parsing
- Order detail screen displays "Разбивка по сумкам" section when multiple blocks exist

**Database Setup**:
- Execute `sql/equipment_blocks_update.sql` in Supabase SQL Editor to add the equipment_blocks column

### Commission System
Automatic commission calculation when orders are marked as paid:
- **Profit-Based Calculation**: Commissions are calculated from profit, not total revenue.
  - Total Receivers = kitCount + spareReceiverCount
  - Cost = totalReceivers x costPerReceiver (configurable in Settings, default 17₽)
  - Profit = totalPrice - Cost
  - Commissions are percentages of profit
- **Owner Commission**: Percentage earned by the manager who owns the client (default 20% of profit).
- **Executor Commission**: Percentage earned by the manager who delivers/picks up equipment (default 10% of profit).
- If the same manager is both owner and executor, percentages combine.
- Commission percentages are configurable per manager in the Admin Panel (ManagerDetailScreen).
- Cost per receiver is configurable in Settings (admin only) via "Себестоимость приёмника".
- Order detail screen shows profit calculation (cost and profit) for admins.
- Commissions are tracked in `rental_commissions` table with pending/paid status.
- Admins can mark commissions as paid from RentalCommissionsScreen.

**Database Setup**: 
- Execute `sql/rental_commissions_setup.sql` in Supabase SQL Editor to create the commissions table and add commission fields to profiles.
- Execute `sql/equipment_losses_rental_update.sql` to add rental_order_id column to equipment_losses table for tracking losses from rental orders.
- Execute `sql/rental_permissions_setup.sql` to migrate existing rental permissions to granular sub-permissions.
- Execute `sql/dashboard_config_setup.sql` to add dashboard_config column for customizable dashboard widgets.
- Execute `sql/auto_writeoff_setup.sql` to add auto_writeoff columns for automatic consumables writeoff.

### Auto-Writeoff System
Automatic consumables writeoff when equipment is issued (excursions or rentals):
- Formula: `receivers_count + 5` headphones are deducted from consumables
- Works for both excursion radio guide issuance and rental order issuance
- Requires `auto_writeoff` and `auto_writeoff_source_id` columns in `equipment_categories`
- Configure by setting `auto_writeoff = true` on a consumables category and linking it to the radio guides category via `auto_writeoff_source_id`

### Granular Rental Permissions
The rental module uses granular permissions for fine-grained access control:
- **rental**: Legacy permission - grants access to all rental sections (for backwards compatibility)
- **rental_clients**: Access to Clients section
- **rental_orders**: Access to Orders section
- **rental_payments**: Access to Payments section
- **rental_commissions**: Access to Commissions section
- **rental_calendar**: Access to Calendar section

Permissions are managed per-manager in Admin Panel -> Manager Details. Users with the legacy `rental` permission automatically get access to all sections. Admins always have full access.

### Equipment Loss Tracking
Equipment losses can be registered from both excursion radio guide assignments and rental orders:
- From RadioGuidesScreen for excursion-related losses (linked via assignment_id/kit_id)
- From RentalOrderDetailScreen for rental-related losses (linked via rental_order_id)
- **Rental Return in RadioGuidesScreen**: "Accept" button on rental cards triggers equipment return workflow
  - Shows confirmation dialog: "Everything in place?"
  - If yes: frees the bag and marks order as "returned"
  - If no: opens loss registration modal for the rental order
- Both integrate with WarehouseScreen inventory via equipment_movements table
- Losses are tracked in equipment_losses table with nullable assignment_id, kit_id, and rental_order_id fields
- **EquipmentLossesScreen**: Central hub for viewing and managing all equipment losses
  - Displays losses from both excursions (by bag number) and rentals (marked as "Rental")
  - Shows equipment type name, quantity, reason, and manager who registered the loss
  - Filter by status: Lost, Found, or All
  - Statistics showing total lost, found, and outstanding items
  - **Recovery tracking**: Mark lost equipment as found with optional notes
  - When equipment is marked as found, quantity is automatically restored to warehouse inventory

### Dispatch Marking Activity Tracking
Tracks manager activity when marking tourists in the dispatching WebView:
- **dispatch_mark_events table**: Stores individual mark/unmark events with phone, pax count, and timestamp
- **Batched writes**: Events are collected locally and flushed every 30 seconds or when 10 events accumulate
- **Net calculation**: Aggregates marks minus unmarks to get actual work done
- **RPC function**: `get_dispatch_stats(start_date, end_date)` returns aggregated stats per manager
- **DispatchActivityReportScreen**: Admin-only report showing manager rankings by phones/tourists marked
- **Session counter**: Real-time feedback in DispatchingScreen showing current session progress

**Database Setup**:
- Execute `sql/dispatch_mark_events_setup.sql` in Supabase SQL Editor to create the table, RLS policies, and aggregation function

### Platform-Specific Considerations
The app implements platform-specific UI adjustments (e.g., iOS blur effects, Android edge-to-edge layout) and web fallbacks for native-only features. Replit deployment includes custom dev and build scripts with environment variable usage.

## External Dependencies

### Expo Ecosystem
- `expo`: Core framework
- `expo-splash-screen`, `expo-status-bar`, `expo-constants`, `expo-font`, `expo-linking`, `expo-web-browser`, `expo-haptics`, `expo-system-ui`, `expo-image`, `expo-symbols`, `expo-blur`, `expo-linear-gradient`, `expo-glass-effect`.

### Navigation
- `@react-navigation/native`, `@react-navigation/bottom-tabs`, `@react-navigation/native-stack`, `@react-navigation/elements`.
- `react-native-screens`, `react-native-safe-area-context`.

### Animation & Gestures
- `react-native-reanimated`, `react-native-gesture-handler`, `react-native-worklets`.
- `react-native-keyboard-controller`.

### UI Components
- `@expo/vector-icons`.

### Development Tools
- `typescript`, `eslint`, `prettier`, `babel-plugin-module-resolver`.

### Backend & Database
- `@supabase/supabase-js`: Supabase client for PostgreSQL and authentication.
- Supabase PostgreSQL: Utilized for the database with Row Level Security (RLS) and Realtime synchronization.
- Environment variables: `EXPO_PUBLIC_SUPABASE_URL`, `EXPO_PUBLIC_SUPABASE_ANON_KEY`.