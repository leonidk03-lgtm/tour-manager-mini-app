import React, { memo } from "react";
import { StyleSheet, Pressable, View } from "react-native";
import { ThemedText } from "@/components/ThemedText";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";

interface StatCardProps {
  title: string;
  value: string;
  color?: "primary" | "success" | "error" | "default";
  onPress?: () => void;
}

export const StatCard = memo(function StatCard({ title, value, color = "default", onPress }: StatCardProps) {
  const { theme } = useTheme();

  const getColor = () => {
    switch (color) {
      case "primary":
        return theme.primary;
      case "success":
        return theme.success;
      case "error":
        return theme.error;
      default:
        return theme.text;
    }
  };

  const content = (
    <View
      style={[
        styles.card,
        {
          backgroundColor: theme.backgroundDefault,
          borderRadius: BorderRadius.md,
        },
      ]}
    >
      <ThemedText
        style={[
          styles.title,
          {
            color: theme.textSecondary,
          },
        ]}
      >
        {title}
      </ThemedText>
      <ThemedText
        style={[
          styles.value,
          {
            color: getColor(),
          },
        ]}
      >
        {value}
      </ThemedText>
    </View>
  );

  if (onPress) {
    return (
      <Pressable onPress={onPress} style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}>
        {content}
      </Pressable>
    );
  }

  return content;
});

const styles = StyleSheet.create({
  card: {
    padding: Spacing.lg,
    gap: Spacing.md,
    minHeight: 90,
    justifyContent: "space-between",
  },
  title: {
    fontSize: 13,
    fontWeight: "400",
    textTransform: "uppercase",
    letterSpacing: 0.5,
  },
  value: {
    fontSize: 28,
    fontWeight: "700",
    lineHeight: 34,
  },
});
