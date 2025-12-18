import { View, StyleSheet } from "react-native";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { Icon } from "@/components/Icon";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";
import { PermissionKey, PERMISSION_DEFINITIONS } from "@/lib/supabase";
import { Spacing, BorderRadius } from "@/constants/theme";

interface PermissionGateProps {
  permission: PermissionKey;
  children: React.ReactNode;
}

export function PermissionGate({ permission, children }: PermissionGateProps) {
  const { theme } = useTheme();
  const { hasPermission, isAdmin } = useAuth();

  if (isAdmin || hasPermission(permission)) {
    return <>{children}</>;
  }

  return (
    <View style={[styles.container, { backgroundColor: theme.backgroundRoot }]}>
      <ThemedView style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
        <View style={[styles.iconContainer, { backgroundColor: theme.error + '20' }]}>
          <Icon name="lock" size={32} color={theme.error} />
        </View>
        <ThemedText style={styles.title}>Нет доступа</ThemedText>
        <ThemedText style={[styles.description, { color: theme.textSecondary }]}>
          У вас нет прав для доступа к функции "{PERMISSION_DEFINITIONS[permission]}"
        </ThemedText>
        <ThemedText style={[styles.hint, { color: theme.textSecondary }]}>
          Обратитесь к администратору для получения доступа
        </ThemedText>
      </ThemedView>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    padding: Spacing.xl,
  },
  card: {
    padding: Spacing.xl,
    borderRadius: BorderRadius.lg,
    alignItems: "center",
    maxWidth: 320,
    gap: Spacing.md,
  },
  iconContainer: {
    width: 64,
    height: 64,
    borderRadius: 32,
    justifyContent: "center",
    alignItems: "center",
    marginBottom: Spacing.sm,
  },
  title: {
    fontSize: 18,
    fontWeight: "600",
  },
  description: {
    fontSize: 14,
    textAlign: "center",
    lineHeight: 20,
  },
  hint: {
    fontSize: 12,
    textAlign: "center",
  },
});
