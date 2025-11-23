# TourManager - Tour Excursion Reporting App

## Overview

TourManager is a React Native mobile application designed for managing tour excursions and financial reporting. The app targets tour managers and administrators in the Russian market, providing tools to track excursions, manage finances, configure pricing, and oversee manager accounts. Built with Expo for cross-platform deployment (iOS, Android, Web), the application features a modern glassmorphic UI with comprehensive data management capabilities.

## User Preferences

Preferred communication style: Simple, everyday language.

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
- Glassmorphic design system using `expo-glass-effect`
- Gradient backgrounds via `expo-linear-gradient`
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
- Light/dark mode support using system color scheme
- Centralized theme constants with semantic color tokens
- Elevation-based color system (backgroundRoot, backgroundDefault, backgroundSecondary, backgroundTertiary)
- Glass effect variations for different UI depths
- Custom typography scale (h1-h4, body, small, link)

**Component Architecture**
- Themed components (`ThemedText`, `ThemedView`) for consistent styling
- Specialized screen wrappers (`ScreenScrollView`, `ScreenKeyboardAwareScrollView`, `ScreenFlatList`) that handle insets automatically
- Reusable cards (`StatCard`, `ExcursionCard`) with glass effects
- Error boundary for graceful error handling
- Platform-specific adaptations (web fallbacks for native-only features)

### Data Model

**Core Entities**
- `TourType`: Excursion types with pricing (fullPrice, discountedPrice)
- `Excursion`: Tour instance with participant counts, date/time, expenses, and additional services
- `AdditionalService`: Extra services that can be added to excursions
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

**SettingsScreen** - User profile, logout, navigation to TicketPrices and AdminPanel

**TicketPricesScreen** - Configure pricing for tour types and additional services

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