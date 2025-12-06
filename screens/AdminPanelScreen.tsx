import { useState, useEffect } from "react";
import { View, StyleSheet, Pressable, Alert, Switch, Modal, TextInput } from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";

export default function AdminPanelScreen() {
  const { theme } = useTheme();
  const { managers, createManager, updateManagerStatus, deleteManager, refreshManagers } = useAuth();
  const [showAddModal, setShowAddModal] = useState(false);
  const [newEmail, setNewEmail] = useState("");
  const [newPassword, setNewPassword] = useState("");
  const [newDisplayName, setNewDisplayName] = useState("");
  const [isCreating, setIsCreating] = useState(false);

  useEffect(() => {
    refreshManagers();
  }, []);

  const handleToggleStatus = async (id: string, currentStatus: boolean) => {
    const { error } = await updateManagerStatus(id, !currentStatus);
    if (error) {
      Alert.alert("Ошибка", error);
    }
  };

  const handleDeleteManager = (id: string, name: string) => {
    Alert.alert("Удалить менеджера?", `Вы уверены, что хотите удалить ${name}?`, [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: async () => {
          const { error } = await deleteManager(id);
          if (error) {
            Alert.alert("Ошибка", error);
          }
        },
      },
    ]);
  };

  const handleCreateManager = async () => {
    if (!newEmail.trim() || !newPassword.trim() || !newDisplayName.trim()) {
      Alert.alert("Ошибка", "Заполните все поля");
      return;
    }

    setIsCreating(true);
    const { error } = await createManager(newEmail.trim(), newPassword, newDisplayName.trim());
    setIsCreating(false);

    if (error) {
      Alert.alert("Ошибка", error);
    } else {
      setShowAddModal(false);
      setNewEmail("");
      setNewPassword("");
      setNewDisplayName("");
      Alert.alert("Успешно", "Менеджер создан");
    }
  };

  const activeManagers = managers.filter((m) => m.role === "manager");

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <ThemedText style={styles.sectionTitle}>Менеджеры</ThemedText>
            <Pressable
              onPress={() => setShowAddModal(true)}
              style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
            >
              <Feather name="user-plus" size={22} color={theme.primary} />
            </Pressable>
          </View>

          <View style={styles.managersList}>
            {activeManagers.length === 0 ? (
              <ThemedView
                style={[
                  styles.emptyState,
                  { borderColor: theme.border, backgroundColor: theme.backgroundSecondary },
                ]}
              >
                <Feather name="users" size={48} color={theme.textSecondary} />
                <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                  Нет менеджеров
                </ThemedText>
                <ThemedText style={[styles.emptySubtext, { color: theme.textSecondary }]}>
                  Нажмите + чтобы добавить
                </ThemedText>
              </ThemedView>
            ) : (
              activeManagers.map((manager) => (
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
                          backgroundColor: manager.is_active ? theme.primary : theme.textSecondary,
                        },
                      ]}
                    >
                      <ThemedText style={[styles.avatarText, { color: theme.buttonText }]}>
                        {manager.display_name?.charAt(0).toUpperCase() || "M"}
                      </ThemedText>
                    </View>
                    <View style={styles.managerInfo}>
                      <ThemedText style={styles.managerName}>{manager.display_name}</ThemedText>
                      <ThemedText style={[styles.managerEmail, { color: theme.textSecondary }]}>
                        {manager.email}
                      </ThemedText>
                    </View>
                  </View>

                  <View style={styles.managerActions}>
                    <View style={styles.statusRow}>
                      <ThemedText style={[styles.statusLabel, { color: theme.textSecondary }]}>
                        {manager.is_active ? "Активен" : "Неактивен"}
                      </ThemedText>
                      <Switch
                        value={manager.is_active}
                        onValueChange={() => handleToggleStatus(manager.id, manager.is_active)}
                        trackColor={{ false: theme.textSecondary, true: theme.success }}
                        thumbColor={theme.buttonText}
                      />
                    </View>

                    <View style={styles.actionButtons}>
                      <Pressable
                        onPress={() => handleDeleteManager(manager.id, manager.display_name)}
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
              ))
            )}
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

      <Modal visible={showAddModal} transparent animationType="fade">
        <View style={styles.modalOverlay}>
          <Pressable style={styles.modalBackdrop} onPress={() => setShowAddModal(false)} />
          <ThemedView style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Новый менеджер</ThemedText>
              <Pressable onPress={() => setShowAddModal(false)}>
                <Feather name="x" size={24} color={theme.textSecondary} />
              </Pressable>
            </View>

            <View style={styles.formGroup}>
              <ThemedText style={[styles.label, { color: theme.textSecondary }]}>Имя</ThemedText>
              <TextInput
                style={[
                  styles.input,
                  {
                    backgroundColor: theme.backgroundSecondary,
                    borderColor: theme.border,
                    color: theme.text,
                  },
                ]}
                placeholder="Введите имя"
                placeholderTextColor={theme.textSecondary}
                value={newDisplayName}
                onChangeText={setNewDisplayName}
                editable={!isCreating}
              />
            </View>

            <View style={styles.formGroup}>
              <ThemedText style={[styles.label, { color: theme.textSecondary }]}>Email</ThemedText>
              <TextInput
                style={[
                  styles.input,
                  {
                    backgroundColor: theme.backgroundSecondary,
                    borderColor: theme.border,
                    color: theme.text,
                  },
                ]}
                placeholder="manager@example.com"
                placeholderTextColor={theme.textSecondary}
                value={newEmail}
                onChangeText={setNewEmail}
                keyboardType="email-address"
                autoCapitalize="none"
                editable={!isCreating}
              />
            </View>

            <View style={styles.formGroup}>
              <ThemedText style={[styles.label, { color: theme.textSecondary }]}>Пароль</ThemedText>
              <TextInput
                style={[
                  styles.input,
                  {
                    backgroundColor: theme.backgroundSecondary,
                    borderColor: theme.border,
                    color: theme.text,
                  },
                ]}
                placeholder="Минимум 6 символов"
                placeholderTextColor={theme.textSecondary}
                value={newPassword}
                onChangeText={setNewPassword}
                secureTextEntry
                editable={!isCreating}
              />
            </View>

            <Pressable
              onPress={handleCreateManager}
              disabled={isCreating}
              style={({ pressed }) => [
                styles.createButton,
                {
                  backgroundColor: theme.primary,
                  opacity: pressed || isCreating ? 0.7 : 1,
                },
              ]}
            >
              <ThemedText style={[styles.createButtonText, { color: theme.buttonText }]}>
                {isCreating ? "Создание..." : "Создать менеджера"}
              </ThemedText>
            </Pressable>
          </ThemedView>
        </View>
      </Modal>
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
  emptyState: {
    padding: Spacing["3xl"],
    alignItems: "center",
    gap: Spacing.md,
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
  },
  emptyText: {
    fontSize: 18,
    fontWeight: "600",
  },
  emptySubtext: {
    fontSize: 14,
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
  modalOverlay: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  modalBackdrop: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "rgba(0,0,0,0.5)",
  },
  modalContent: {
    width: "90%",
    maxWidth: 400,
    borderRadius: BorderRadius.md,
    padding: Spacing.xl,
    gap: Spacing.lg,
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  modalTitle: {
    fontSize: 20,
    fontWeight: "600",
  },
  formGroup: {
    gap: Spacing.sm,
  },
  label: {
    fontSize: 14,
    fontWeight: "500",
  },
  input: {
    height: 48,
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    paddingHorizontal: Spacing.md,
    fontSize: 16,
  },
  createButton: {
    height: 48,
    borderRadius: BorderRadius.sm,
    justifyContent: "center",
    alignItems: "center",
    marginTop: Spacing.sm,
  },
  createButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
});
