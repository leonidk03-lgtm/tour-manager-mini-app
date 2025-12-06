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
- React Context API (`DataContext`) for global application state
- Local state management with React hooks
- No external state management libraries (Redux/MobX) - keeping it simple
- In-memory data storage (no persistence layer currently implemented)

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
- Mock authentication with local state
- User roles: Manager and Admin
- `currentUser` stored in DataContext
- Admin-only features: AdminPanel access, manager management

**Planned Features (not yet implemented)**
- Email/password authentication
- Apple Sign-In for iOS compliance
- Forgot password flow
- Account deletion (admin only)
- Privacy policy and terms links

### Screen Structure

**DashboardScreen** - Financial overview with period selector, summary cards (revenue/expenses/profit), recent excursions list

**ExcursionsListScreen** - Searchable list of excursions grouped by date, period filtering, navigation to detail view

**ExcursionDetailScreen** - Detailed view of single excursion with edit/delete actions (edit not yet implemented)

**FinancesScreen** - Separate income/expense transaction management with tabbed interface, add/delete capabilities

**SettingsScreen** - User profile, logout, navigation to TicketPrices, DeletedData, and AdminPanel

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

**AdminPanelScreen** - Manage manager accounts (toggle active status, delete managers)

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

### Notable Absences
- **No database**: Currently using in-memory storage via React Context
- **No backend API**: All data is client-side only
- **No authentication service**: Mock auth implementation
- **No form library**: Native TextInput components used directly
- **No date library**: Using native Date objects and ISO strings
- **No charting library**: Charts mentioned in design doc but not yet implemented