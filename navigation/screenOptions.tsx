import React from "react";
import { Platform, StyleSheet } from "react-native";
import { NativeStackNavigationOptions } from "@react-navigation/native-stack";
import { GlassView, isLiquidGlassAvailable } from "expo-glass-effect";

interface ScreenOptionsParams {
  theme: {
    backgroundRoot: string;
    text: string;
    glassMist: string;
    glassTint: string;
    glassStroke: string;
  };
  isDark: boolean;
  transparent?: boolean;
}

export const getCommonScreenOptions = ({
  theme,
  isDark,
  transparent = true,
}: ScreenOptionsParams): NativeStackNavigationOptions => ({
  headerTitleAlign: "center",
  headerTransparent: transparent,
  headerBlurEffect: undefined,
  headerTintColor: theme.text,
  headerBackground: () => (
    <GlassView
      glassEffectStyle={isDark ? "regular" : "clear"}
      tintColor={isDark ? theme.glassTint : theme.glassMist}
      style={[
        StyleSheet.absoluteFill,
        {
          borderBottomWidth: 0.5,
          borderBottomColor: theme.glassStroke,
        },
      ]}
    />
  ),
  headerStyle: {
    backgroundColor: Platform.select({
      ios: "transparent",
      android: theme.backgroundRoot,
      web: theme.backgroundRoot,
    }),
  },
  gestureEnabled: true,
  gestureDirection: "horizontal",
  fullScreenGestureEnabled: isLiquidGlassAvailable() ? false : true,
  contentStyle: {
    backgroundColor: theme.backgroundRoot,
  },
});
