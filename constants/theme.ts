import { Platform } from "react-native";

const tintColorLight = "#2AABEE";
const tintColorDark = "#2AABEE";

export const Colors = {
  light: {
    text: "#000000",
    textSecondary: "#8E8E93",
    textTertiary: "#6D6D72",
    buttonText: "#FFFFFF",
    tabIconDefault: "#8E8E93",
    tabIconSelected: tintColorLight,
    link: "#2AABEE",
    primary: "#2AABEE",
    secondary: "#34C759",
    error: "#FF3B30",
    warning: "#FF9500",
    success: "#34C759",
    backgroundRoot: "#FFFFFF",
    backgroundDefault: "#F2F2F7",
    backgroundSecondary: "#E5E5EA",
    backgroundTertiary: "#D1D1D6",
    border: "#E5E5EA",
    divider: "#E5E5EA",
    inputBorder: "transparent",
    inputBorderFocused: "#2AABEE",
  },
  dark: {
    text: "#FFFFFF",
    textSecondary: "#8E8E93",
    textTertiary: "#6D6D72",
    buttonText: "#FFFFFF",
    tabIconDefault: "#8E8E93",
    tabIconSelected: tintColorDark,
    link: "#2AABEE",
    primary: "#2AABEE",
    secondary: "#34C759",
    error: "#FF3B30",
    warning: "#FF9500",
    success: "#34C759",
    backgroundRoot: "#0E1621",
    backgroundDefault: "#1C2733",
    backgroundSecondary: "#2B3641",
    backgroundTertiary: "#3A4651",
    border: "#2B3641",
    divider: "#2B3641",
    inputBorder: "transparent",
    inputBorderFocused: "#2AABEE",
  },
};

export const Spacing = {
  xxs: 2,
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 20,
  "2xl": 24,
  "3xl": 32,
  "4xl": 40,
  "5xl": 48,
  inputHeight: 50,
  buttonHeight: 50,
  listItemMinHeight: 76,
  tabBarHeight: 50,
  headerHeight: 44,
};

export const BorderRadius = {
  xs: 6,
  sm: 10,
  md: 12,
  lg: 16,
  xl: 20,
  "2xl": 24,
  "3xl": 30,
  full: 9999,
};

export const Typography = {
  h1: {
    fontSize: 28,
    lineHeight: 34,
    fontWeight: "700" as const,
  },
  h2: {
    fontSize: 22,
    lineHeight: 28,
    fontWeight: "600" as const,
  },
  h3: {
    fontSize: 17,
    lineHeight: 22,
    fontWeight: "600" as const,
  },
  body: {
    fontSize: 17,
    lineHeight: 22,
    fontWeight: "400" as const,
  },
  bodySecondary: {
    fontSize: 15,
    lineHeight: 20,
    fontWeight: "400" as const,
  },
  caption: {
    fontSize: 13,
    lineHeight: 18,
    fontWeight: "400" as const,
  },
  small: {
    fontSize: 11,
    lineHeight: 16,
    fontWeight: "400" as const,
  },
  link: {
    fontSize: 17,
    lineHeight: 22,
    fontWeight: "400" as const,
  },
};

export const Fonts = Platform.select({
  ios: {
    /** iOS `UIFontDescriptorSystemDesignDefault` */
    sans: "system-ui",
    /** iOS `UIFontDescriptorSystemDesignSerif` */
    serif: "ui-serif",
    /** iOS `UIFontDescriptorSystemDesignRounded` */
    rounded: "ui-rounded",
    /** iOS `UIFontDescriptorSystemDesignMonospaced` */
    mono: "ui-monospace",
  },
  default: {
    sans: "normal",
    serif: "serif",
    rounded: "normal",
    mono: "monospace",
  },
  web: {
    sans: "system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif",
    serif: "Georgia, 'Times New Roman', serif",
    rounded:
      "'SF Pro Rounded', 'Hiragino Maru Gothic ProN', Meiryo, 'MS PGothic', sans-serif",
    mono: "SFMono-Regular, Menlo, Monaco, Consolas, 'Liberation Mono', 'Courier New', monospace",
  },
});
