import { Platform } from "react-native";

const tintColorLight = "#2563EB";
const tintColorDark = "#3B82F6";

export const Colors = {
  light: {
    text: "#111827",
    textSecondary: "#6B7280",
    buttonText: "#FFFFFF",
    tabIconDefault: "rgba(156, 163, 175, 0.6)",
    tabIconSelected: tintColorLight,
    link: "#2563EB",
    primary: "#2563EB",
    secondary: "#10B981",
    error: "#EF4444",
    warning: "#F59E0B",
    success: "#10B981",
    backgroundRoot: "#F9FAFB",
    backgroundDefault: "#FFFFFF",
    backgroundSecondary: "#F3F4F6",
    backgroundTertiary: "#E5E7EB",
    border: "#E5E7EB",
    inputBorder: "#E5E7EB",
    inputBorderFocused: "#2563EB",
    glassMist: "rgba(255, 255, 255, 0.65)",
    glassVeil: "rgba(255, 255, 255, 0.45)",
    glassTint: "rgba(255, 255, 255, 0.85)",
    glassStroke: "rgba(255, 255, 255, 0.25)",
    glassHighlight: "rgba(255, 255, 255, 0.95)",
    glassShadow: "rgba(0, 0, 0, 0.08)",
  },
  dark: {
    text: "#F9FAFB",
    textSecondary: "#9CA3AF",
    buttonText: "#FFFFFF",
    tabIconDefault: "rgba(107, 114, 128, 0.6)",
    tabIconSelected: tintColorDark,
    link: "#3B82F6",
    primary: "#3B82F6",
    secondary: "#34D399",
    error: "#F87171",
    warning: "#FBBF24",
    success: "#34D399",
    backgroundRoot: "#111827",
    backgroundDefault: "#1F2937",
    backgroundSecondary: "#374151",
    backgroundTertiary: "#4B5563",
    border: "#374151",
    inputBorder: "#4B5563",
    inputBorderFocused: "#3B82F6",
    glassMist: "rgba(31, 41, 55, 0.75)",
    glassVeil: "rgba(31, 41, 55, 0.55)",
    glassTint: "rgba(31, 41, 55, 0.90)",
    glassStroke: "rgba(255, 255, 255, 0.15)",
    glassHighlight: "rgba(255, 255, 255, 0.05)",
    glassShadow: "rgba(0, 0, 0, 0.3)",
  },
};

export const Gradients = {
  light: {
    primaryStart: "#3B82F6",
    primaryEnd: "#6366F1",
    successStart: "#10B981",
    successEnd: "#14B8A6",
    backgroundStart: "#F9FAFB",
    backgroundEnd: "#EFF6FF",
  },
  dark: {
    primaryStart: "#3B82F6",
    primaryEnd: "#6366F1",
    successStart: "#34D399",
    successEnd: "#2DD4BF",
    backgroundStart: "#0F172A",
    backgroundEnd: "#1E293B",
  },
};

export const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 20,
  "2xl": 24,
  "3xl": 32,
  "4xl": 40,
  "5xl": 48,
  inputHeight: 48,
  buttonHeight: 52,
};

export const BorderRadius = {
  xs: 8,
  sm: 12,
  md: 18,
  lg: 24,
  xl: 30,
  "2xl": 40,
  "3xl": 50,
  full: 9999,
};

export const Typography = {
  h1: {
    fontSize: 32,
    lineHeight: 40,
    fontWeight: "700" as const,
  },
  h2: {
    fontSize: 28,
    lineHeight: 36,
    fontWeight: "700" as const,
  },
  h3: {
    fontSize: 24,
    lineHeight: 32,
    fontWeight: "600" as const,
  },
  h4: {
    fontSize: 20,
    lineHeight: 28,
    fontWeight: "600" as const,
  },
  body: {
    fontSize: 16,
    lineHeight: 24,
    fontWeight: "400" as const,
  },
  small: {
    fontSize: 14,
    lineHeight: 20,
    fontWeight: "400" as const,
  },
  link: {
    fontSize: 16,
    lineHeight: 24,
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
