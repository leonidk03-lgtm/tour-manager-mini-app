import { useSafeAreaInsets } from "react-native-safe-area-context";
import { useHeaderHeight } from "@react-navigation/elements";
import { useBottomTabBarHeight } from "@react-navigation/bottom-tabs";

import { Spacing } from "@/constants/theme";

export function useScreenInsets() {
  const insets = useSafeAreaInsets();
  const headerHeight = useHeaderHeight();
  const tabBarHeight = useBottomTabBarHeight();

  return {
    paddingTop: headerHeight > 0 ? headerHeight + Spacing.md : insets.top + Spacing.md,
    paddingBottom: tabBarHeight + Spacing.md,
    scrollInsetBottom: insets.bottom + 16,
  };
}
