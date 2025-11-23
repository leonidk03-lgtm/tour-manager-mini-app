# Design Guidelines: Tour Excursion Reporting App

## Architecture Decisions

### Authentication
**Auth Required** - The application explicitly mentions manager accounts and an admin panel.

**Implementation:**
- Use email/password authentication (SSO less common for business tools in Russian market)
- Include Apple Sign-In for iOS compliance
- Mock auth flow with local state for prototype
- User roles: Admin and Manager
- Login screen with email/password fields
- Include "Forgot Password?" link (placeholder)
- Privacy policy & terms links (placeholder URLs)
- Account screen with:
  - User profile (avatar, name, role badge)
  - Log out (with confirmation alert: "Вы уверены, что хотите выйти?")
  - Delete account (Admin panel only, double confirmation)

### Navigation
**Tab Navigation** with 4 tabs + FAB:

1. **Dashboard** (Главная) - Overview statistics
2. **Excursions** (Экскурсии) - List of all tours
3. **[FAB] Add Tour** - Floating action button for creating new excursion entry
4. **Finances** (Финансы) - Additional expenses/income management
5. **Settings** (Настройки) - App settings, admin panel access

**Navigation Stack:**
- Each tab has its own stack
- Admin panel accessed from Settings (Admin users only)
- Modals for: Add/Edit Excursion, Add Expense/Income, Ticket Price Configuration

## Screen Specifications

### 1. Dashboard Screen (Главная)
**Purpose:** Display financial overview and key metrics for selected period

**Layout:**
- Header: Custom with date range picker (left: calendar icon, center: date display, right: filter icon)
- Scrollable content
- Top inset: headerHeight + Spacing.xl
- Bottom inset: tabBarHeight + Spacing.xl

**Components:**
- Period selector cards (День, Неделя, Месяц)
- Summary cards: Total Revenue, Total Expenses, Net Profit
- Small chart showing profit trend (simple bar/line chart)
- Quick stats: Number of tours, Average profit per tour
- Recent excursions list (last 5)

### 2. Excursions List Screen (Экскурсии)
**Purpose:** Browse and manage all excursion entries

**Layout:**
- Header: Default with search bar and filter button (right)
- List view (FlatList)
- Top inset: Spacing.xl
- Bottom inset: tabBarHeight + Spacing.xl

**Components:**
- Search bar in header
- Date grouping headers (styled as cards)
- Excursion cards showing:
  - Tour name and time
  - Participant counts (icons with numbers)
  - Revenue, Expenses, Profit (color-coded: profit green, loss red)
  - Tap to view details
- Empty state: "Нет экскурсий за выбранный период"

### 3. Add/Edit Excursion Screen (Modal)
**Purpose:** Input excursion data

**Layout:**
- Header: Custom with "Отмена" (left) and "Сохранить" (right) buttons
- Scrollable form
- Top inset: headerHeight + Spacing.xl
- Bottom inset: insets.bottom + Spacing.xl

**Components:**
- Tour name dropdown/autocomplete (with saved tour types)
- Date picker (calendar icon)
- Time picker
- Participant inputs:
  - Full price (Полная оплата)
  - Discounted (Льготная)
  - Free (Бесплатные)
  - Tour package (По туру)
  - Each with +/- steppers
- Additional services section:
  - Checkboxes for: Теплоход, Колесо обозрения, etc.
  - Quantity adjusters
- Expenses section:
  - Multiple expense line items
  - "Добавить расход" button
  - Type: Экскурсовод, Предоплата, Прочее
  - Amount input

### 4. Excursion Detail Screen
**Purpose:** View complete excursion breakdown

**Layout:**
- Header: Default with "Edit" button (right)
- Scrollable content
- Top inset: Spacing.xl
- Bottom inset: tabBarHeight + Spacing.xl

**Components:**
- Tour header card (name, date, time)
- Participants breakdown table
- Revenue calculation card
- Expenses list
- Net profit summary (prominent, color-coded)

### 5. Finances Screen (Финансы)
**Purpose:** Manage additional expenses and income not tied to specific tours

**Layout:**
- Header: Default with "Add" button (right)
- List view with tabs: Расходы (Expenses) / Доходы (Income)
- Top inset: Spacing.xl
- Bottom inset: tabBarHeight + Spacing.xl

**Components:**
- Transaction list cards showing:
  - Description (e.g., "Вильдану", "Поступление от партнера")
  - Amount
  - Date
  - Type badge
- Summary at top: Total additional expenses, Total additional income

### 6. Settings Screen
**Purpose:** App configuration and admin tools

**Layout:**
- Header: Default
- Scrollable list
- Top inset: Spacing.xl
- Bottom inset: tabBarHeight + Spacing.xl

**Components:**
- User profile card (avatar, name, role)
- Ticket Prices section → navigates to price configuration
- Admin Panel (visible only to admins)
- App preferences (notifications, theme)
- About app
- Log out button

### 7. Admin Panel Screen
**Purpose:** Manage manager accounts

**Layout:**
- Header: Default with "Add Manager" button (right)
- List view
- Top inset: Spacing.xl
- Bottom inset: tabBarHeight + Spacing.xl

**Components:**
- Manager list cards showing:
  - Avatar and name
  - Email
  - Status (Active/Inactive toggle)
  - Action buttons: Edit, Delete
- Add/Edit manager form (modal)

### 8. Ticket Price Configuration Screen
**Purpose:** Set and manage pricing for tour types

**Layout:**
- Header: Default with "Save" button (right)
- Scrollable form
- Top inset: Spacing.xl
- Bottom inset: tabBarHeight + Spacing.xl

**Components:**
- Tour type cards with price inputs:
  - Full price (Полная цена)
  - Discounted price (Льготная цена)
- Additional services pricing section
- "Add New Tour Type" button

## Design System

### Color Palette
**Primary:** #2563EB (Blue - trust, professionalism)
**Secondary:** #10B981 (Green - profit, success)
**Error:** #EF4444 (Red - loss, warnings)
**Warning:** #F59E0B (Orange)
**Background:** #F9FAFB (Light gray)
**Surface:** #FFFFFF
**Text Primary:** #111827
**Text Secondary:** #6B7280
**Border:** #E5E7EB

### Typography
- Headings: SF Pro Display (iOS) / Roboto (Android), Bold, 24-28pt
- Subheadings: Medium, 18-20pt
- Body: Regular, 16pt
- Caption: Regular, 14pt
- Numbers/Currency: Tabular figures, Medium weight for emphasis

### Visual Design
- Use system icons (Feather icons from @expo/vector-icons) for:
  - Navigation: home, list, plus-circle, dollar-sign, settings
  - Actions: edit, trash-2, save, x, check
  - Data: users, calendar, clock, trending-up
- Floating Action Button (Add Tour):
  - Position: bottom-right, 16pt from edge
  - Size: 56x56pt
  - Icon: plus
  - Color: Primary blue
  - Shadow: shadowOffset {width: 0, height: 2}, shadowOpacity: 0.10, shadowRadius: 2
- Cards:
  - Background: Surface white
  - Border radius: 12pt
  - Padding: 16pt
  - No drop shadow, use subtle border (#E5E7EB)
- Input fields:
  - Border: 1pt solid #E5E7EB
  - Border radius: 8pt
  - Focus state: Primary blue border
  - Padding: 12pt
- Buttons:
  - Primary: Filled primary color, white text
  - Secondary: Outlined primary color
  - Height: 48pt
  - Border radius: 8pt
  - Press feedback: opacity 0.7

### Interaction Design
- All touchable elements have opacity feedback (0.7) on press
- Swipe actions on list items: swipe left to delete (confirmation required)
- Pull-to-refresh on Dashboard and Excursions list
- Date picker: native iOS/Android picker
- Currency inputs: numeric keyboard with automatic formatting (add ₽ symbol)
- Form validation: inline error messages below invalid fields
- Success confirmations: brief toast notifications at bottom
- Deletion confirmations: alert dialogs with "Отмена" and "Удалить"

### Accessibility
- Minimum touch target: 44x44pt
- Color contrast ratio: 4.5:1 for text, 3:1 for UI components
- Support for Russian localization
- Currency always displayed with ₽ symbol
- Numbers formatted with space thousands separator (10 000₽)
- Profit/loss color-coded but also labeled with text
- Form labels always visible (not placeholder-only)
- VoiceOver/TalkBack support for all interactive elements
- Semantic headings for screen readers