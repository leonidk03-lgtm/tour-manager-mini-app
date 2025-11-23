import { View, StyleSheet, Pressable, Alert, Switch } from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";

export default function AdminPanelScreen() {
  const { theme } = useTheme();
  const { managers, updateManager, deleteManager } = useData();

  const handleToggleStatus = (id: string, currentStatus: boolean) => {
    const manager = managers.find((m) => m.id === id);
    if (!manager) return;
    updateManager(id, { ...manager, isActive: !currentStatus });
  };

  const handleDeleteManager = (id: string, name: string) => {
    Alert.alert("Удалить менеджера?", `Вы уверены, что хотите удалить ${name}?`, [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: () => deleteManager(id),
      },
    ]);
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <ThemedText style={styles.sectionTitle}>Менеджеры</ThemedText>
            <Pressable
              onPress={() =>
                Alert.alert("Добавить менеджера", "Функция будет доступна в следующей версии")
              }
              style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
            >
              <Feather name="user-plus" size={22} color={theme.primary} />
            </Pressable>
          </View>

          <View style={styles.managersList}>
            {managers.map((manager) => (
              <ThemedView
                key={manager.id}
                style={[
                  styles.managerCard,
                  {
                    borderColor: theme.border,
                    borderRadius: BorderRadius.sm,
                  },
                ]}
              >
                <View style={styles.managerMain}>
                  <View
                    style={[
                      styles.managerAvatar,
                      {
                        backgroundColor: manager.isActive ? theme.primary : theme.textSecondary,
                      },
                    ]}
                  >
                    <ThemedText style={[styles.avatarText, { color: theme.buttonText }]}>
                      {manager.name.charAt(0).toUpperCase()}
                    </ThemedText>
                  </View>
                  <View style={styles.managerInfo}>
                    <ThemedText style={styles.managerName}>{manager.name}</ThemedText>
                    <ThemedText style={[styles.managerEmail, { color: theme.textSecondary }]}>
                      {manager.email}
                    </ThemedText>
                  </View>
                </View>

                <View style={styles.managerActions}>
                  <View style={styles.statusRow}>
                    <ThemedText style={[styles.statusLabel, { color: theme.textSecondary }]}>
                      {manager.isActive ? "Активен" : "Неактивен"}
                    </ThemedText>
                    <Switch
                      value={manager.isActive}
                      onValueChange={() => handleToggleStatus(manager.id, manager.isActive)}
                      trackColor={{ false: theme.textSecondary, true: theme.success }}
                      thumbColor={theme.buttonText}
                    />
                  </View>

                  <View style={styles.actionButtons}>
                    <Pressable
                      onPress={() =>
                        Alert.alert(
                          "Редактировать",
                          "Функция редактирования будет доступна в следующей версии"
                        )
                      }
                      style={({ pressed }) => [
                        styles.actionButton,
                        {
                          backgroundColor: theme.backgroundSecondary,
                          opacity: pressed ? 0.7 : 1,
                        },
                      ]}
                    >
                      <Feather name="edit" size={18} color={theme.primary} />
                      <ThemedText style={[styles.actionButtonText, { color: theme.primary }]}>
                        Изменить
                      </ThemedText>
                    </Pressable>
                    <Pressable
                      onPress={() => handleDeleteManager(manager.id, manager.name)}
                      style={({ pressed }) => [
                        styles.actionButton,
                        {
                          backgroundColor: theme.backgroundSecondary,
                          opacity: pressed ? 0.7 : 1,
                        },
                      ]}
                    >
                      <Feather name="trash-2" size={18} color={theme.error} />
                      <ThemedText style={[styles.actionButtonText, { color: theme.error }]}>
                        Удалить
                      </ThemedText>
                    </Pressable>
                  </View>
                </View>
              </ThemedView>
            ))}
          </View>
        </View>

        <ThemedView
          style={[
            styles.infoCard,
            {
              backgroundColor: theme.backgroundSecondary,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <Feather name="info" size={20} color={theme.primary} />
          <ThemedText style={[styles.infoText, { color: theme.textSecondary }]}>
            Неактивные менеджеры не смогут войти в приложение и добавлять новые экскурсии.
          </ThemedText>
        </ThemedView>
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing["2xl"],
  },
  section: {
    gap: Spacing.md,
  },
  sectionHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: "600",
  },
  managersList: {
    gap: Spacing.md,
  },
  managerCard: {
    padding: Spacing.lg,
    borderWidth: 1,
    gap: Spacing.lg,
  },
  managerMain: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
  },
  managerAvatar: {
    width: 48,
    height: 48,
    borderRadius: 24,
    alignItems: "center",
    justifyContent: "center",
  },
  avatarText: {
    fontSize: 20,
    fontWeight: "700",
  },
  managerInfo: {
    flex: 1,
    gap: Spacing.xs,
  },
  managerName: {
    fontSize: 18,
    fontWeight: "600",
  },
  managerEmail: {
    fontSize: 14,
  },
  managerActions: {
    gap: Spacing.md,
  },
  statusRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  statusLabel: {
    fontSize: 14,
  },
  actionButtons: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  actionButton: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.xs,
    gap: Spacing.xs,
  },
  actionButtonText: {
    fontSize: 14,
    fontWeight: "500",
  },
  infoCard: {
    flexDirection: "row",
    alignItems: "flex-start",
    padding: Spacing.lg,
    gap: Spacing.md,
  },
  infoText: {
    flex: 1,
    fontSize: 14,
    lineHeight: 20,
  },
});
