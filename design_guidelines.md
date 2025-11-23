# Design Guidelines: Tour Excursion Reporting App
## Telegram-inspired Design

## Design Philosophy
This application follows Telegram's design principles: clean, efficient, and focused on content. The interface prioritizes readability, quick access to information, and minimal visual noise.

## Visual Style

### Design Principles
- **Flat Design**: No gradients, no glassmorphic effects, no heavy shadows
- **Content First**: UI elements don't compete with content
- **Clarity**: Clear hierarchy, readable text, intuitive interactions
- **Efficiency**: Quick access to all features, minimal taps needed
- **Dark Theme**: Primary dark theme similar to Telegram Night mode

### Color Palette

**Dark Theme (Primary):**
- Background Root: `#0E1621` (Deep dark blue-gray, main app background)
- Background Default: `#1C2733` (Card background, slightly lighter)
- Background Secondary: `#2B3641` (Elevated elements, hover states)
- Background Tertiary: `#3A4651` (Input fields, subtle elements)
- Divider: `#2B3641` (Subtle separators between items)

**Text Colors:**
- Primary Text: `#FFFFFF` (Main content, headings)
- Secondary Text: `#8E8E93` (Descriptions, captions, timestamps)
- Tertiary Text: `#6D6D72` (Placeholders, disabled text)

**Accent Colors:**
- Primary (Telegram Blue): `#2AABEE` (Links, active states, buttons)
- Success (Green): `#34C759` (Profit, positive values, success states)
- Error (Red): `#FF3B30` (Loss, negative values, delete actions)
- Warning (Orange): `#FF9500` (Warnings, pending states)

**Badge/Indicator Colors:**
- Unread Badge: `#2AABEE` (Blue circle with white text)
- Active Status: `#34C759` (Green dot)

### Typography

**Font Families:**
- iOS: SF Pro Text / SF Pro Display (system default)
- Android: Roboto (system default)
- Web: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, system-ui

**Type Scale:**
- H1 (Screen Titles): 28pt, Bold, #FFFFFF
- H2 (Section Headers): 22pt, Semibold, #FFFFFF  
- H3 (Card Titles): 17pt, Semibold, #FFFFFF
- Body (Main Text): 17pt, Regular, #FFFFFF
- Body Secondary: 15pt, Regular, #8E8E93
- Caption (Timestamps): 13pt, Regular, #8E8E93
- Small: 11pt, Regular, #6D6D72

**Number Formatting:**
- Use tabular figures for currency and numbers
- Format: 10 000 ₽ (space as thousands separator)
- Negative numbers: -500 ₽ (no parentheses)

### Layout & Spacing

**Spacing Scale:**
- XXS: 2pt
- XS: 4pt
- SM: 8pt
- MD: 12pt
- LG: 16pt
- XL: 20pt
- 2XL: 24pt
- 3XL: 32pt

**Screen Insets:**
- Top (with header): Spacing.XL (20pt)
- Top (with transparent header): headerHeight + Spacing.XL
- Bottom (with tab bar): tabBarHeight + Spacing.XL
- Bottom (no tab bar): insets.bottom + Spacing.XL
- Horizontal: Spacing.LG (16pt)

**Component Spacing:**
- Between sections: Spacing.3XL (32pt)
- Between cards in list: 0pt (cards touch with dividers)
- Card internal padding: Spacing.LG (16pt)
- List item height: 76pt minimum

### Components

#### Cards & Lists

**List Items (Telegram Style):**
```
┌──────────────────────────────────────┐
│ [Icon]  Title                  Time  │
│         Subtitle/Description         │
│         Secondary info         Badge │
└──────────────────────────────────────┘
```
- No background color (transparent)
- 1pt divider at bottom (#2B3641)
- Padding: 12pt vertical, 16pt horizontal
- Press feedback: Background changes to #1C2733
- Icon/Avatar: 48x48pt circle on left
- Content: fills middle space
- Right accessories: time, badges, chevron

**Cards (for summaries, stats):**
- Background: #1C2733
- Border radius: 12pt
- Padding: 16pt
- No shadow
- No border
- Margin bottom: 12pt

**Section Headers:**
- Text: 13pt, Semibold, #8E8E93, uppercase
- Padding: 20pt top, 16pt horizontal, 8pt bottom
- Background: transparent

#### Buttons

**Primary Button:**
- Background: #2AABEE
- Text: #FFFFFF, 17pt, Semibold
- Height: 50pt
- Border radius: 10pt
- Press opacity: 0.7
- No shadow

**Secondary Button:**
- Background: transparent
- Text: #2AABEE, 17pt, Semibold
- Height: 50pt
- Border radius: 10pt
- Press opacity: 0.5

**Destructive Button:**
- Background: transparent
- Text: #FF3B30, 17pt, Semibold
- Height: 50pt
- Press opacity: 0.5

**Icon Button:**
- Size: 44x44pt (minimum touch target)
- Icon size: 24pt
- Color: #2AABEE or #FFFFFF
- Press opacity: 0.5

#### Input Fields

**Text Input:**
- Background: #1C2733
- Border: none
- Border radius: 10pt
- Padding: 12pt
- Text: 17pt, Regular, #FFFFFF
- Placeholder: 17pt, Regular, #6D6D72
- Focus state: subtle border #2AABEE (1pt)

**Date/Time Picker:**
- Use native pickers with dark theme
- Trigger button styled as text input

#### Navigation

**Bottom Tab Bar:**
- Background: #1C2733
- Height: 50pt + safe area bottom
- Border top: 0.5pt solid #2B3641
- Items spacing: evenly distributed
- Active item:
  - Icon: #2AABEE
  - Label: #2AABEE, 10pt, Medium
- Inactive item:
  - Icon: #8E8E93
  - Label: #8E8E93, 10pt, Regular

**Top Header:**
- Background: #0E1621
- Height: 44pt + safe area top
- Title: 17pt, Semibold, #FFFFFF, centered
- Back button: chevron + text, #2AABEE
- Right button: icon or text, #2AABEE

**Search Bar:**
- Background: #1C2733
- Border radius: 10pt
- Height: 36pt
- Icon: search icon, #8E8E93
- Placeholder: #6D6D72
- Text: #FFFFFF

#### Icons & Badges

**Icons:**
- Use Feather icons from @expo/vector-icons
- Default size: 24pt
- Colors: #FFFFFF (primary), #8E8E93 (secondary), #2AABEE (accent)

**Badge (unread counter):**
- Background: #2AABEE
- Text: white, 12pt, Medium
- Min size: 20x20pt
- Padding: 2pt horizontal
- Border radius: 10pt (fully rounded)

**Status Indicators:**
- Active: 8pt circle, #34C759
- Inactive: 8pt circle, #8E8E93

### Interaction Patterns

**Feedback:**
- Press: opacity 0.7 for buttons, background #1C2733 for list items
- Pull to refresh: native spinner with #2AABEE
- Loading: spinner in center, #2AABEE
- Success: brief toast at bottom (3 seconds)
- Error: alert dialog or inline message

**Gestures:**
- Swipe left to delete: reveals red delete button
- Pull down to refresh: on Dashboard and lists
- Tap: standard action
- Long press: context menu (if needed)

**Animations:**
- Keep subtle and fast (200-300ms)
- Use native spring physics where appropriate
- Prefer fade and slide over complex animations

**Modals:**
- Full screen on mobile
- Slide up from bottom animation
- Close via swipe down or cancel button
- Header with title and cancel/save buttons

## Screen Specifications

### 1. Dashboard (Главная)

**Layout:**
- Scrollable list of sections
- No custom header - standard navigation

**Components:**
1. Period selector (horizontal scroll, pills):
   - Options: День, Неделя, Месяц
   - Active: #2AABEE background, white text
   - Inactive: transparent, #8E8E93 text

2. Summary cards (3 cards in section):
   - Card style as defined above
   - Each shows: Label (secondary text), Value (large primary text), Icon
   - Revenue: green icon
   - Expenses: red icon  
   - Profit: blue icon if positive, red if negative

3. Manager Activities section:
   - Section header: "Действия менеджеров"
   - List items (Telegram style):
     - Icon left (based on action type)
     - Manager name + action text
     - Timestamp (right, top)
   - Last 10 activities shown

### 2. Excursions List (Экскурсии)

**Layout:**
- Search bar at top
- Date filter input
- List of excursions grouped by date

**Components:**
- Date headers (section headers)
- Excursion list items:
  - Tour name (17pt, semibold, white)
  - Time + participant counts (15pt, secondary)
  - Revenue/Expenses/Profit row (13pt):
    - Revenue: white
    - Expenses: white  
    - Profit: green if positive, red if negative
  - Divider between items
  - Tap to view details

### 3. Add Excursion (Modal)

**Layout:**
- Full screen modal
- Header with "Отмена" and "Сохранить"
- Scrollable form

**Components:**
- Form sections with headers
- Input fields (text inputs, pickers)
- Participant inputs: plain text inputs, no steppers
- Expenses list with add button
- Additional services checkboxes

### 4. Finances (Финансы)

**Layout:**
- Tabs at top: Доходы / Расходы
- Date filter
- List of transactions

**Components:**
- Tab selector (2 pills):
  - Active: #2AABEE background
  - Inactive: transparent
- Transaction list items:
  - Description (17pt, white)
  - Amount + date (15pt, secondary)
  - Divider
- FAB for adding transactions

### 5. Settings (Настройки)

**Layout:**
- List of sections with items

**Components:**
- User profile section:
  - Avatar (64pt circle)
  - Name (17pt, semibold)
  - Role badge
- Settings items (Telegram list style):
  - Label left
  - Chevron right
  - Tap to navigate
- Log out button (destructive)

### 6. Ticket Prices

**Layout:**
- List of tour types and additional services
- Add button in header

**Components:**
- Tour type cards:
  - Name
  - Price inputs (full, discounted)
- Additional service cards:
  - Name  
  - Price input
- Save button at bottom

### 7. Admin Panel

**Layout:**
- List of managers

**Components:**
- Manager list items:
  - Avatar + name
  - Email (secondary)
  - Active/inactive toggle
  - Chevron to details

## Implementation Notes

### Component Reuse
- Use ThemedText and ThemedView for consistent theming
- Create reusable ListItem component for Telegram-style list items
- Create reusable Card component for summary cards
- Remove glass effects and gradients from all components

### Colors in Code
- Update constants/theme.ts with new color palette
- Remove all glassmorphic effects
- Remove expo-glass-effect and expo-blur usage
- Use flat colors only

### Testing
- Test in dark mode only (primary theme)
- Ensure text contrast meets accessibility standards
- Test on both iOS and Android
- Verify touch targets are minimum 44x44pt
