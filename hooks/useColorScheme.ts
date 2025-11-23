/**
 * TourManager uses a dark-first design inspired by Telegram.
 * Always return "dark" theme for consistent UX across all platforms.
 */
export function useColorScheme() {
  return "dark" as const;
}
