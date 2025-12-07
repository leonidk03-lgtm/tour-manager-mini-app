import React from "react";
import { View, Pressable, StyleSheet } from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "./ThemedText";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";
import { Spacing } from "@/constants/theme";

export function NetworkErrorBanner() {
  const { theme } = useTheme();
  const { networkError, clearNetworkError, refreshData } = useData();

  if (!networkError) return null;

  return (
    <View style={[styles.container, { backgroundColor: theme.error + '15' }]}>
      <View style={styles.content}>
        <Feather name="wifi-off" size={20} color={theme.error} />
        <ThemedText style={[styles.message, { color: theme.error }]}>
          {networkError}
        </ThemedText>
      </View>
      <View style={styles.actions}>
        <Pressable
          onPress={refreshData}
          style={[styles.button, { backgroundColor: theme.error }]}
        >
          <Feather name="refresh-cw" size={14} color="#fff" />
          <ThemedText style={styles.buttonText}>Повторить</ThemedText>
        </Pressable>
        <Pressable onPress={clearNetworkError} style={styles.closeButton}>
          <Feather name="x" size={18} color={theme.error} />
        </Pressable>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: 8,
    marginHorizontal: Spacing.md,
    marginBottom: Spacing.sm,
  },
  content: {
    flexDirection: "row",
    alignItems: "center",
    flex: 1,
    gap: Spacing.sm,
  },
  message: {
    fontSize: 13,
    flex: 1,
  },
  actions: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
  },
  button: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
    paddingHorizontal: Spacing.sm,
    paddingVertical: 6,
    borderRadius: 6,
  },
  buttonText: {
    color: "#fff",
    fontSize: 12,
    fontWeight: "600",
  },
  closeButton: {
    padding: 4,
  },
});
