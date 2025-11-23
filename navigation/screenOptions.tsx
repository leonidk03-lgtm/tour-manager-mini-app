import { NativeStackNavigationOptions } from "@react-navigation/native-stack";

interface ScreenOptionsParams {
  theme: {
    backgroundRoot: string;
    text: string;
  };
  isDark: boolean;
  transparent?: boolean;
}

export const getCommonScreenOptions = ({
  theme,
  isDark,
  transparent = false,
}: ScreenOptionsParams): NativeStackNavigationOptions => ({
  headerTitleAlign: "center",
  headerTransparent: transparent,
  headerTintColor: theme.text,
  headerStyle: {
    backgroundColor: theme.backgroundRoot,
  },
  gestureEnabled: true,
  gestureDirection: "horizontal",
  fullScreenGestureEnabled: true,
  contentStyle: {
    backgroundColor: theme.backgroundRoot,
  },
});
