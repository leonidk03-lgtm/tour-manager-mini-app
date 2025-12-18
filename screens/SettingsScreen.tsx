import { useState } from "react";
import { View, StyleSheet, Pressable, Alert, TextInput, Modal } from "react-native";
import { Icon } from "@/components/Icon";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";
import { useData } from "@/contexts/DataContext";
import { hapticFeedback } from "@/utils/haptics";

export default function SettingsScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<SettingsStackParamList>>();
  const { profile, isAdmin, isRadioDispatcher, signOut } = useAuth();
  const { radioGuidePrice, updateRadioGuidePrice } = useData();

  const [showPriceModal, setShowPriceModal] = useState(false);
  const [priceInput, setPriceInput] = useState(String(radioGuidePrice));
  const [saving, setSaving] = useState(false);

  const handleSavePrice = async () => {
    const newPrice = parseInt(priceInput, 10);
    if (isNaN(newPrice) || newPrice < 0) {
      Alert.alert("Ошибка", "Введите корректную сумму");
      return;
    }
    setSaving(true);
    try {
      await updateRadioGuidePrice(newPrice);
      setShowPriceModal(false);
      Alert.alert("Сохранено", "Стоимость аренды радиогида обновлена");
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось сохранить");
    } finally {
      setSaving(false);
    }
  };

  const handleLogout = () => {
    Alert.alert("Выйти из аккаунта?", "Вы уверены, что хотите выйти?", [
      { text: "Отмена", style: "cancel" },
      {
        text: "Выйти",
        style: "destructive",
        onPress: async () => {
          await signOut();
        },
      },
    ]);
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <ThemedView
          style={[
            styles.profileCard,
            {
              borderColor: theme.border,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <View style={styles.avatarContainer}>
            <View
              style={[
                styles.avatar,
                {
                  backgroundColor: theme.primary,
                },
              ]}
            >
              <ThemedText style={[styles.avatarText, { color: theme.buttonText }]}>
                {profile?.display_name?.charAt(0).toUpperCase() || "U"}
              </ThemedText>
            </View>
            <View style={styles.profileInfo}>
              <ThemedText style={styles.profileName}>{profile?.display_name || "Пользователь"}</ThemedText>
              <ThemedView
                style={[
                  styles.roleBadge,
                  {
                    backgroundColor: theme.primary,
                  },
                ]}
              >
                <ThemedText style={[styles.roleText, { color: theme.buttonText }]}>
                  {isAdmin ? "Администратор" : isRadioDispatcher ? "Диспетчер" : "Менеджер"}
                </ThemedText>
              </ThemedView>
            </View>
          </View>
          <Pressable
            style={({ pressed }) => [
              styles.editProfileButton,
              { backgroundColor: theme.primary, opacity: pressed ? 0.7 : 1 },
            ]}
            onPress={() => {
              hapticFeedback.light();
              navigation.navigate("EditProfile");
            }}
          >
            <Icon name="edit-2" size={16} color={theme.buttonText} />
            <ThemedText style={[styles.editProfileText, { color: theme.buttonText }]}>
              Редактировать профиль
            </ThemedText>
          </Pressable>
        </ThemedView>

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>Настройки</ThemedText>
          <ThemedView
            style={[
              styles.settingsGroup,
              {
                borderColor: theme.border,
                borderRadius: BorderRadius.sm,
              },
            ]}
          >
            {isAdmin ? (
              <>
                <Pressable
                  onPress={() => { hapticFeedback.selection(); navigation.navigate("TicketPrices"); }}
                  style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
                >
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Icon name="file-text" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>Цены на билеты</ThemedText>
                    </View>
                    <Icon name="chevron-right" size={20} color={theme.textSecondary} />
                  </View>
                </Pressable>
                <View style={[styles.divider, { backgroundColor: theme.border }]} />
              </>
            ) : null}
            <Pressable
              onPress={() => { hapticFeedback.selection(); navigation.navigate("DeletedData"); }}
              style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
            >
              <View style={styles.settingItem}>
                <View style={styles.settingLeft}>
                  <Icon name="trash" size={20} color={theme.textSecondary} />
                  <ThemedText style={styles.settingText}>Удаленные данные</ThemedText>
                </View>
                <Icon name="chevron-right" size={20} color={theme.textSecondary} />
              </View>
            </Pressable>

            {isAdmin ? (
              <>
                <View style={[styles.divider, { backgroundColor: theme.border }]} />
                <Pressable
                  onPress={() => { hapticFeedback.selection(); navigation.navigate("AdminPanel"); }}
                  style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
                >
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Icon name="users" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>Панель администратора</ThemedText>
                    </View>
                    <Icon name="chevron-right" size={20} color={theme.textSecondary} />
                  </View>
                </Pressable>
                <View style={[styles.divider, { backgroundColor: theme.border }]} />
                <Pressable
                  onPress={() => { hapticFeedback.selection(); navigation.navigate("Reports"); }}
                  style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
                >
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Icon name="bar-chart-2" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>Отчёты</ThemedText>
                    </View>
                    <Icon name="chevron-right" size={20} color={theme.textSecondary} />
                  </View>
                </Pressable>
              </>
            ) : null}

            <View style={[styles.divider, { backgroundColor: theme.border }]} />
            <Pressable
              onPress={() => { hapticFeedback.selection(); navigation.navigate("RadioGuides"); }}
              style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
            >
              <View style={styles.settingItem}>
                <View style={styles.settingLeft}>
                  <Icon name="radio" size={20} color={theme.textSecondary} />
                  <ThemedText style={styles.settingText}>Радиогиды</ThemedText>
                </View>
                <Icon name="chevron-right" size={20} color={theme.textSecondary} />
              </View>
            </Pressable>
            <View style={[styles.divider, { backgroundColor: theme.border }]} />
            <Pressable
              onPress={() => { hapticFeedback.selection(); navigation.navigate("EquipmentLosses"); }}
              style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
            >
              <View style={styles.settingItem}>
                <View style={styles.settingLeft}>
                  <Icon name="alert-triangle" size={20} color={theme.textSecondary} />
                  <ThemedText style={styles.settingText}>Утери оборудования</ThemedText>
                </View>
                <Icon name="chevron-right" size={20} color={theme.textSecondary} />
              </View>
            </Pressable>
            <View style={[styles.divider, { backgroundColor: theme.border }]} />
            <Pressable
              onPress={() => { hapticFeedback.selection(); navigation.navigate("Notifications"); }}
              style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
            >
              <View style={styles.settingItem}>
                <View style={styles.settingLeft}>
                  <Icon name="mail" size={20} color={theme.textSecondary} />
                  <ThemedText style={styles.settingText}>Уведомления</ThemedText>
                </View>
                <Icon name="chevron-right" size={20} color={theme.textSecondary} />
              </View>
            </Pressable>
            {isAdmin ? (
              <>
                <View style={[styles.divider, { backgroundColor: theme.border }]} />
                <Pressable
                  onPress={() => { hapticFeedback.selection(); navigation.navigate("DatabaseSettings"); }}
                  style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
                >
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Icon name="server" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>База данных</ThemedText>
                    </View>
                    <Icon name="chevron-right" size={20} color={theme.textSecondary} />
                  </View>
                </Pressable>
                <View style={[styles.divider, { backgroundColor: theme.border }]} />
                <Pressable
                  onPress={() => {
                    setPriceInput(String(radioGuidePrice));
                    setShowPriceModal(true);
                  }}
                  style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
                >
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Icon name="radio" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>Стоимость радиогида</ThemedText>
                    </View>
                    <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>
                      {radioGuidePrice}₽
                    </ThemedText>
                  </View>
                </Pressable>
              </>
            ) : null}
          </ThemedView>
        </View>

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>О приложении</ThemedText>
          <ThemedView
            style={[
              styles.settingsGroup,
              {
                borderColor: theme.border,
                borderRadius: BorderRadius.sm,
              },
            ]}
          >
            <View style={styles.settingItem}>
              <ThemedText style={[styles.settingText, { color: theme.textSecondary }]}>
                Версия
              </ThemedText>
              <ThemedText style={styles.settingText}>1.0.0</ThemedText>
            </View>
          </ThemedView>
        </View>

        <Pressable
          onPress={handleLogout}
          style={({ pressed }) => [
            styles.logoutButton,
            {
              backgroundColor: theme.error,
              opacity: pressed ? 0.7 : 1,
            },
          ]}
        >
          <Icon name="log-out" size={20} color={theme.buttonText} />
          <ThemedText style={[styles.logoutText, { color: theme.buttonText }]}>Выйти</ThemedText>
        </Pressable>
      </View>

      <Modal
        visible={showPriceModal}
        transparent
        animationType="fade"
        onRequestClose={() => setShowPriceModal(false)}
      >
        <Pressable
          style={styles.modalOverlay}
          onPress={() => setShowPriceModal(false)}
        >
          <Pressable
            style={[styles.modalContent, { backgroundColor: theme.backgroundSecondary }]}
            onPress={(e) => e.stopPropagation()}
          >
            <ThemedText style={styles.modalTitle}>Стоимость аренды радиогида</ThemedText>
            <ThemedText style={[styles.modalSubtitle, { color: theme.textSecondary }]}>
              Цена за одного участника для расчёта в отчётах
            </ThemedText>
            <TextInput
              style={[styles.priceInput, { backgroundColor: theme.backgroundRoot, color: theme.text, borderColor: theme.border }]}
              value={priceInput}
              onChangeText={setPriceInput}
              keyboardType="numeric"
              placeholder="Введите сумму"
              placeholderTextColor={theme.textSecondary}
            />
            <View style={styles.modalButtons}>
              <Pressable
                style={[styles.modalButton, { backgroundColor: theme.backgroundRoot }]}
                onPress={() => setShowPriceModal(false)}
              >
                <ThemedText>Отмена</ThemedText>
              </Pressable>
              <Pressable
                style={[styles.modalButton, { backgroundColor: theme.primary }]}
                onPress={handleSavePrice}
                disabled={saving}
              >
                <ThemedText style={{ color: theme.buttonText }}>
                  {saving ? "Сохранение..." : "Сохранить"}
                </ThemedText>
              </Pressable>
            </View>
          </Pressable>
        </Pressable>
      </Modal>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing["2xl"],
  },
  profileCard: {
    padding: Spacing.xl,
    borderWidth: 1,
  },
  avatarContainer: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.lg,
  },
  avatar: {
    width: 64,
    height: 64,
    borderRadius: 32,
    alignItems: "center",
    justifyContent: "center",
  },
  avatarText: {
    fontSize: 28,
    fontWeight: "700",
    lineHeight: 32,
    textAlign: "center",
  },
  profileInfo: {
    flex: 1,
    gap: Spacing.sm,
  },
  profileName: {
    fontSize: 20,
    fontWeight: "600",
  },
  roleBadge: {
    alignSelf: "flex-start",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.xs,
  },
  roleText: {
    fontSize: 12,
    fontWeight: "500",
  },
  section: {
    gap: Spacing.md,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  settingsGroup: {
    borderWidth: 1,
    overflow: "hidden",
  },
  settingItem: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    padding: Spacing.lg,
  },
  settingLeft: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
  },
  settingText: {
    fontSize: 16,
  },
  divider: {
    height: 1,
    marginLeft: Spacing.lg + 20 + Spacing.md,
  },
  logoutButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.lg,
    borderRadius: BorderRadius.xs,
    gap: Spacing.sm,
  },
  logoutText: {
    fontSize: 16,
    fontWeight: "600",
  },
  editProfileButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.xs,
    marginTop: Spacing.md,
  },
  editProfileText: {
    fontSize: 14,
    fontWeight: "500",
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
    justifyContent: "center",
    alignItems: "center",
    padding: Spacing.xl,
  },
  modalContent: {
    width: "100%",
    maxWidth: 400,
    padding: Spacing.xl,
    borderRadius: BorderRadius.md,
    gap: Spacing.md,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "600",
    textAlign: "center",
  },
  modalSubtitle: {
    fontSize: 14,
    textAlign: "center",
  },
  priceInput: {
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    fontSize: 18,
    textAlign: "center",
  },
  modalButtons: {
    flexDirection: "row",
    gap: Spacing.md,
    marginTop: Spacing.md,
  },
  modalButton: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
});
