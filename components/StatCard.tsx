import { View, StyleSheet, Pressable } from "react-native";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";

interface StatCardProps {
  title: string;
  value: string;
  color?: "primary" | "success" | "error" | "default";
  onPress?: () => void;
}

export function StatCard({ title, value, color = "default", onPress }: StatCardProps) {
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
    <ThemedView
      style={[
        styles.card,
        {
          borderColor: theme.border,
          borderRadius: BorderRadius.sm,
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
    </ThemedView>
  );

  if (onPress) {
    return (
      <Pressable onPress={onPress} style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}>
        {content}
      </Pressable>
    );
  }

  return content;
}

const styles = StyleSheet.create({
  card: {
    padding: Spacing.lg,
    borderWidth: 1,
    gap: Spacing.sm,
  },
  title: {
    fontSize: 14,
  },
  value: {
    fontSize: 24,
    fontWeight: "700",
  },
});
