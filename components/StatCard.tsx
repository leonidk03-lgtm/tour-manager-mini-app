import { StyleSheet, Pressable, View, Platform } from "react-native";
import { GlassView } from "expo-glass-effect";
import { ThemedText } from "@/components/ThemedText";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";

interface StatCardProps {
  title: string;
  value: string;
  color?: "primary" | "success" | "error" | "default";
  onPress?: () => void;
}

export function StatCard({ title, value, color = "default", onPress }: StatCardProps) {
  const { theme, isDark } = useTheme();

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
        styles.cardWrapper,
        {
          borderRadius: BorderRadius.md,
          shadowColor: theme.glassShadow,
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.1,
          shadowRadius: 8,
          elevation: 3,
        },
      ]}
    >
      <GlassView
        glassEffectStyle={isDark ? "regular" : "clear"}
        tintColor={isDark ? theme.glassVeil : theme.glassMist}
        style={[
          styles.card,
          {
            borderRadius: BorderRadius.md,
            borderWidth: 1,
            borderColor: theme.glassStroke,
          },
        ]}
      >
        <View
          style={[
            styles.highlightLine,
            {
              backgroundColor: theme.glassHighlight,
            },
          ]}
        />
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
      </GlassView>
    </View>
  );

  if (onPress) {
    return (
      <Pressable onPress={onPress} style={({ pressed }) => ({ opacity: pressed ? 0.95 : 1 })}>
        {content}
      </Pressable>
    );
  }

  return content;
}

const styles = StyleSheet.create({
  cardWrapper: {
    overflow: "visible",
  },
  card: {
    padding: Spacing.lg,
    gap: Spacing.sm,
    overflow: "hidden",
  },
  highlightLine: {
    position: "absolute",
    top: 0,
    left: 0,
    right: 0,
    height: 1,
    opacity: 0.6,
  },
  title: {
    fontSize: 14,
  },
  value: {
    fontSize: 24,
    fontWeight: "700",
  },
});
