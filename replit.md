# TourManager - Tour Excursion Reporting App

## Overview

TourManager is a React Native mobile application designed for managing tour excursions and financial reporting. The app targets tour managers and administrators in the Russian market, providing tools to track excursions, manage finances, configure pricing, and oversee manager accounts. Built with Expo for cross-platform deployment (iOS, Android, Web), the application features a clean Telegram-inspired UI with comprehensive data management capabilities.

## User Preferences

Preferred communication style: Simple, everyday language.
Design style: Telegram-inspired dark theme with flat design (November 2025 update)

## System Architecture

### Frontend Architecture

**Framework & Runtime**
- React Native 0.81.5 with React 19.1.0
- Expo SDK 54 for managed workflow and cross-platform deployment
- New Architecture enabled for improved performance
- TypeScript for type safety

**Navigation**
- React Navigation v7 for routing
- Bottom tab navigation with 4 main sections (Dashboard, Excursions, Finances, Settings)
- Stack navigators for each tab to support nested screens
- Modal-based flows for adding/editing excursions and transactions

**UI/UX Design Patterns**
- Telegram-inspired flat design with dark theme (#0E1621 background)
- Minimalist UI with focus on content and readability  
- Reanimated 4.1 for performant animations with spring physics
- Gesture Handler for native-quality touch interactions
- Keyboard Controller for proper keyboard handling on forms
- Safe Area Context for notch/status bar handling

**State Management**
- React Context API (`DataContext` + `AuthContext`) for global application state
- Local state management with React hooks
- No external state management libraries (Redux/MobX) - keeping it simple
- Data persisted in Supabase PostgreSQL database
- **Data Synchronization**: Supabase Realtime subscriptions for instant data sync across all tables (tour_types, additional_services, excursions, transactions, activities, deleted_items, radio_guide_kits, radio_guide_assignments, equipment_losses, dispatching_notes, excursion_notes)
- **Network Error Handling**: Centralized error handling with NetworkErrorBanner component shows user-friendly messages on connection issues; retry button only clears error on successful reload

**Theming System**
- Dark-first design (Telegram-style) with light theme support
- Centralized theme constants with semantic color tokens
- Elevation-based color system (backgroundRoot, backgroundDefault, backgroundSecondary, backgroundTertiary)
- Flat design - no glassmorphic effects, no gradients, no heavy shadows
- Custom typography scale (h1-h3, body, bodySecondary, caption, small, link)
- Telegram blue (#2AABEE) as primary accent color

**Component Architecture**
- Themed components (`ThemedText`, `ThemedView`) for consistent styling
- Specialized screen wrappers (`ScreenScrollView`, `ScreenKeyboardAwareScrollView`, `ScreenFlatList`) that handle insets automatically
- Reusable cards (`StatCard`, `ExcursionCard`) with glass effects
- Error boundary for graceful error handling
- Platform-specific adaptations (web fallbacks for native-only features)

### Data Model

**Core Entities**
- `TourType`: Excursion types with pricing (fullPrice, discountedPrice), article numbers (articleNumber), and seasonal availability (isEnabled)
- `Excursion`: Tour instance with participant counts (fullPrice, discounted, free, tourPackage, byTour, paid), date/time, expenses, and additional services
- `DeletedItem`: Soft-deleted excursions and transactions with restore capability
- `AdditionalService`: Extra services that can be added to excursions, with seasonal availability (isEnabled)
- `Expense`: Individual expense items within an excursion
- `Transaction`: Standalone income/expense entries
- `Manager`: User accounts with active/inactive status
- `RadioGuideKit`: Radio guide equipment bags with bagNumber, receiverCount, status (available/issued/maintenance)
- `RadioGuideAssignment`: Equipment issue/return records with kitId, guideName, busNumber, receiversIssued, receiversReturned
- `DispatchingNote`: Personal notes for managers, synced across devices via Supabase Realtime with offline caching
- `ExcursionNote`: Notes attached to specific excursions, visible only on excursion day to managers (all notes), always visible to admins; auto-deleted after 14 days (moved to deleted_items for restoration)

**Data Relationships**
- Excursions reference TourTypes by ID
- Excursions contain embedded Expense arrays
- Excursions reference AdditionalServices by ID with counts
- All data currently lives in React Context (DataContext)

**Business Logic Utilities**
- Revenue calculation: ticket sales + additional services
- Expense aggregation from embedded expense items
- Profit calculation: revenue - expenses
- Date range filtering for period views (day/week/month)
- Transaction totals separated by type (income/expense)

### Authentication & Authorization

**Current Implementation**
- Supabase authentication with username/password
- User roles: Manager and Admin (stored in managers table)
- `AuthContext` manages auth state with `signIn`, `signOut`, `isAdmin` helpers
- `currentUser` stored in AuthContext after successful login
- Admin-only features: AdminPanel access, manager management, see all data with manager names
- Managers can only see their own excursions and transactions (enforced by RLS)
- Admin creates manager accounts via AdminPanel (no self-registration)

**Data Access Rules**
- Managers: See only own excursions/transactions, can add/edit/delete own data
- Admins: See all data with manager attribution, manage all accounts

### Screen Structure

**DashboardScreen** - Financial overview with period selector, summary cards (revenue/expenses/profit), recent excursions list

**ExcursionsListScreen** - Searchable list of excursions grouped by date, period filtering, navigation to detail view

**ExcursionDetailScreen** - Detailed view of single excursion with edit/delete actions (edit not yet implemented)

**FinancesScreen** - Separate income/expense transaction management with tabbed interface, add/delete capabilities

**SettingsScreen** - User profile, logout, navigation to TicketPrices, DeletedData, AdminPanel, and EditProfile

**EditProfileScreen** - Self-service profile editing:
- Change display name
- Change password (with confirmation)
- Email is displayed but cannot be changed (read-only)

**DeletedDataScreen** - Soft-deleted data management with restore and permanent delete options

**TicketPricesScreen** - Full price list management with add/edit/delete capabilities for tour types and additional services, article number assignment for tour types, and seasonal enable/disable toggle (e.g., summer-only or winter-only excursions). Additional services do not have article numbers.

**AddExcursionForm** - Form for creating/editing excursions with:
- Custom modal picker for tour type selection (works on mobile/Expo Go)
- DateTimePicker calendar for date selection
- Participant input: total count first, then breakdown (discounted/free/tourPackage/byTour/paid), with auto-calculated full price
- Paid participants are tracked separately but do not contribute to revenue (like free participants)
- Additional services with direct numeric input for quantity (not +/- steppers)
- Expense management with custom modal picker for expense type
- Only enabled (isEnabled: true) tour types shown; validates before save

**AdminPanelScreen** - Manage manager accounts (toggle active status, delete managers, view individual manager activity)

**ManagerDetailScreen** - Detailed view of individual manager showing:
- Profile information (name, email, role, status)
- Admin actions: edit manager name, send password reset link
- Period filter (day/week/month/all)
- Statistics (excursions count, participants, revenue, profit)
- List of manager's excursions with revenue
- List of manager's transactions

**ReportsScreen** - Admin-only reports hub with 4 report types:
- Financial Report: Revenue, expenses, profit breakdown by period
- Excursions Report: Tour type statistics and participant distribution
- Radio Guides Report: Equipment assignments and losses tracking
- Data Export: Export to CSV/JSON (excursions, transactions, radio guides)

**FinancialReportScreen** - Financial analytics with period filtering (day/week/month/year/all), revenue breakdown (tickets, services, transactions), expenses, and profit calculation

**ExcursionsReportScreen** - Excursions analytics with tour type distribution, participant statistics, and service usage

**RadioGuidesReportScreen** - Radio guide equipment analytics with kit usage, assignment statistics, and loss tracking

**ExportDataScreen** - Data export functionality supporting CSV and JSON formats for excursions, transactions, radio guide assignments, and equipment losses. Uses expo-file-system/legacy API for mobile and blob downloads for web.

**RadioGuidesScreen** - Radio guide equipment management:
- View all radio guide bags (kits) with bag number, receiver count, and status
- Issue equipment to guides (with guide name, optional bus number, receivers issued)
- Return equipment with tracking of receivers returned vs issued (loss detection)
- Admins: add/edit/delete kits
- Managers: can issue and return equipment (not add/edit/delete kits)

### Platform-Specific Considerations

**iOS**
- Blur effects for navigation headers
- Liquid glass effects where available
- Tab bar with glass effect

**Android**
- Edge-to-edge layout enabled
- Adaptive icon with monochrome variant
- Predictive back gesture disabled

**Web**
- Single-page output mode
- Fallback from KeyboardAwareScrollView to ScreenScrollView
- Standard navigation headers (no blur)

**Replit Deployment**
- Custom dev script with proxy URL configuration
- Build script for static hosting with Metro bundler
- Environment variable usage for deployment domains

## External Dependencies

### Expo Ecosystem
- `expo` - Core managed workflow framework
- `expo-splash-screen` - Splash screen configuration
- `expo-status-bar` - Status bar styling
- `expo-constants` - Access to app constants
- `expo-font` - Custom font loading
- `expo-linking` - Deep linking support
- `expo-web-browser` - In-app browser
- `expo-haptics` - Haptic feedback
- `expo-system-ui` - System UI configuration
- `expo-image` - Optimized image component
- `expo-symbols` - SF Symbols support
- `expo-blur` - Blur effect component
- `expo-linear-gradient` - Gradient backgrounds
- `expo-glass-effect` - Glassmorphic UI effects

### Navigation
- `@react-navigation/native` - Core navigation library
- `@react-navigation/bottom-tabs` - Tab navigation
- `@react-navigation/native-stack` - Stack navigation
- `@react-navigation/elements` - Shared navigation elements
- `react-native-screens` - Native screen optimization
- `react-native-safe-area-context` - Safe area handling

### Animation & Gestures
- `react-native-reanimated` - High-performance animations
- `react-native-gesture-handler` - Native gesture system
- `react-native-worklets` - JavaScript worklets for animations
- `react-native-keyboard-controller` - Advanced keyboard handling

### UI Components
- `@expo/vector-icons` - Icon library (Feather icons primarily used)

### Development Tools
- `typescript` - Type checking
- `eslint` - Code linting with Expo config
- `prettier` - Code formatting
- `babel-plugin-module-resolver` - Path aliasing (@/ prefix)

### Backend & Database
- `@supabase/supabase-js` - Supabase client for PostgreSQL database and authentication
- Supabase PostgreSQL with Row Level Security (RLS) for data access control
- Real-time data synchronization between managers
- Environment variables: EXPO_PUBLIC_SUPABASE_URL, EXPO_PUBLIC_SUPABASE_ANON_KEY

### Notable Absences
- **No form library**: Native TextInput components used directly
- **No date library**: Using native Date objects and ISO strings
- **No charting library**: Charts mentioned in design doc but not yet implemented
- **No push notifications**: Requires native build (expo-notifications doesn't work in Expo Go for remote push)