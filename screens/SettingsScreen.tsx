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

type SettingItemProps = {
  icon: string;
  label: string;
  onPress: () => void;
  value?: string;
  showChevron?: boolean;
};

function SettingItem({ icon, label, onPress, value, showChevron = true }: SettingItemProps) {
  const { theme } = useTheme();
  return (
    <Pressable
      onPress={() => { hapticFeedback.selection(); onPress(); }}
      style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
    >
      <View style={styles.settingItem}>
        <View style={styles.settingLeft}>
          <Icon name={icon as any} size={20} color={theme.textSecondary} />
          <ThemedText style={styles.settingText}>{label}</ThemedText>
        </View>
        {value ? (
          <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>{value}</ThemedText>
        ) : showChevron ? (
          <Icon name="chevron-right" size={20} color={theme.textSecondary} />
        ) : null}
      </View>
    </Pressable>
  );
}

function SettingsCard({ title, children }: { title: string; children: React.ReactNode }) {
  const { theme } = useTheme();
  return (
    <View style={styles.section}>
      <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>{title}</ThemedText>
      <ThemedView
        style={[
          styles.settingsGroup,
          { borderColor: theme.border, borderRadius: BorderRadius.sm },
        ]}
      >
        {children}
      </ThemedView>
    </View>
  );
}

function Divider() {
  const { theme } = useTheme();
  return <View style={[styles.divider, { backgroundColor: theme.border }]} />;
}

export default function SettingsScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<SettingsStackParamList>>();
  const { profile, isAdmin, isRadioDispatcher, hasPermission, signOut } = useAuth();
  const { radioGuidePrice, updateRadioGuidePrice, rentalCostPerReceiver, updateRentalCostPerReceiver } = useData();

  const [showPriceModal, setShowPriceModal] = useState(false);
  const [priceInput, setPriceInput] = useState(String(radioGuidePrice));
  const [showCostModal, setShowCostModal] = useState(false);
  const [costInput, setCostInput] = useState(String(rentalCostPerReceiver));
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

  const handleSaveCost = async () => {
    const newCost = parseInt(costInput, 10);
    if (isNaN(newCost) || newCost < 0) {
      Alert.alert("Ошибка", "Введите корректную сумму");
      return;
    }
    setSaving(true);
    try {
      await updateRentalCostPerReceiver(newCost);
      setShowCostModal(false);
      Alert.alert("Сохранено", "Себестоимость приёмника обновлена");
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

  const canAccessRental = isAdmin || hasPermission('rental');
  const canAccessWarehouse = isAdmin || hasPermission('warehouse');

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <ThemedView
          style={[
            styles.profileCard,
            { borderColor: theme.border, borderRadius: BorderRadius.sm },
          ]}
        >
          <View style={styles.avatarContainer}>
            <View style={[styles.avatar, { backgroundColor: theme.primary }]}>
              <ThemedText style={[styles.avatarText, { color: theme.buttonText }]}>
                {profile?.display_name?.charAt(0).toUpperCase() || "U"}
              </ThemedText>
            </View>
            <View style={styles.profileInfo}>
              <ThemedText style={styles.profileName}>{profile?.display_name || "Пользователь"}</ThemedText>
              <ThemedView style={[styles.roleBadge, { backgroundColor: theme.primary }]}>
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

        {isAdmin ? (
          <SettingsCard title="Администрирование">
            <SettingItem icon="users" label="Панель администратора" onPress={() => navigation.navigate("AdminPanel")} />
            <Divider />
            <SettingItem icon="bar-chart-2" label="Отчёты" onPress={() => navigation.navigate("Reports")} />
            <Divider />
            <SettingItem icon="file-text" label="Цены на билеты" onPress={() => navigation.navigate("TicketPrices")} />
            <Divider />
            <SettingItem icon="folder" label="База данных" onPress={() => navigation.navigate("DatabaseSettings")} />
            <Divider />
            <SettingItem
              icon="radio"
              label="Стоимость радиогида"
              value={`${radioGuidePrice}₽`}
              showChevron={false}
              onPress={() => {
                setPriceInput(String(radioGuidePrice));
                setShowPriceModal(true);
              }}
            />
            <Divider />
            <SettingItem
              icon="package"
              label="Себестоимость приёмника"
              value={`${rentalCostPerReceiver}₽`}
              showChevron={false}
              onPress={() => {
                setCostInput(String(rentalCostPerReceiver));
                setShowCostModal(true);
              }}
            />
          </SettingsCard>
        ) : null}

        <SettingsCard title="Оборудование">
          <SettingItem icon="radio" label="Радиогиды" onPress={() => navigation.navigate("RadioGuides")} />
          <Divider />
          <SettingItem icon="alert-triangle" label="Утери оборудования" onPress={() => navigation.navigate("EquipmentLosses")} />
          {canAccessWarehouse ? (
            <>
              <Divider />
              <SettingItem icon="package" label="Склад" onPress={() => navigation.navigate("Warehouse")} />
            </>
          ) : null}
        </SettingsCard>

        {canAccessRental ? (
          <SettingsCard title="Аренда">
            <SettingItem icon="users" label="Клиенты" onPress={() => navigation.navigate("RentalClients")} />
            <Divider />
            <SettingItem icon="file-text" label="Заказы" onPress={() => navigation.navigate("RentalOrders")} />
            <Divider />
            <SettingItem icon="credit-card" label="Платежи" onPress={() => navigation.navigate("RentalPayments")} />
            <Divider />
            <SettingItem icon="dollar-sign" label="Комиссии" onPress={() => navigation.navigate("RentalCommissions")} />
            <Divider />
            <SettingItem icon="calendar" label="Календарь загрузки" onPress={() => navigation.navigate("RentalCalendar")} />
            {isAdmin ? (
              <>
                <Divider />
                <SettingItem icon="gift" label="Услуги аренды" onPress={() => navigation.navigate("RentalServices")} />
              </>
            ) : null}
          </SettingsCard>
        ) : null}

        <SettingsCard title="Общее">
          <SettingItem icon="mail" label="Уведомления" onPress={() => navigation.navigate("Notifications")} />
          <Divider />
          <SettingItem icon="trash" label="Удалённые данные" onPress={() => navigation.navigate("DeletedData")} />
        </SettingsCard>

        <SettingsCard title="О приложении">
          <View style={styles.settingItem}>
            <ThemedText style={[styles.settingText, { color: theme.textSecondary }]}>Версия</ThemedText>
            <ThemedText style={styles.settingText}>1.0.0</ThemedText>
          </View>
        </SettingsCard>

        <Pressable
          onPress={handleLogout}
          style={({ pressed }) => [
            styles.logoutButton,
            { backgroundColor: theme.error, opacity: pressed ? 0.7 : 1 },
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
        <Pressable style={styles.modalOverlay} onPress={() => setShowPriceModal(false)}>
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

      <Modal
        visible={showCostModal}
        transparent
        animationType="fade"
        onRequestClose={() => setShowCostModal(false)}
      >
        <Pressable style={styles.modalOverlay} onPress={() => setShowCostModal(false)}>
          <Pressable
            style={[styles.modalContent, { backgroundColor: theme.backgroundSecondary }]}
            onPress={(e) => e.stopPropagation()}
          >
            <ThemedText style={styles.modalTitle}>Себестоимость приёмника</ThemedText>
            <ThemedText style={[styles.modalSubtitle, { color: theme.textSecondary }]}>
              Стоимость 1 приёмника для расчёта прибыли и комиссий
            </ThemedText>
            <TextInput
              style={[styles.priceInput, { backgroundColor: theme.backgroundRoot, color: theme.text, borderColor: theme.border }]}
              value={costInput}
              onChangeText={setCostInput}
              keyboardType="numeric"
              placeholder="Введите сумму"
              placeholderTextColor={theme.textSecondary}
            />
            <View style={styles.modalButtons}>
              <Pressable
                style={[styles.modalButton, { backgroundColor: theme.backgroundRoot }]}
                onPress={() => setShowCostModal(false)}
              >
                <ThemedText>Отмена</ThemedText>
              </Pressable>
              <Pressable
                style={[styles.modalButton, { backgroundColor: theme.primary }]}
                onPress={handleSaveCost}
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
    gap: Spacing.xl,
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
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.xs,
  },
  roleText: {
    fontSize: 12,
    fontWeight: "500",
  },
  editProfileButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    marginTop: Spacing.lg,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.sm,
  },
  editProfileText: {
    fontWeight: "600",
    fontSize: 14,
  },
  section: {
    gap: Spacing.sm,
  },
  sectionTitle: {
    fontSize: 13,
    fontWeight: "600",
    textTransform: "uppercase",
    letterSpacing: 0.5,
    marginLeft: Spacing.xs,
  },
  settingsGroup: {
    borderWidth: 1,
    overflow: "hidden",
  },
  settingItem: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingVertical: Spacing.lg,
    paddingHorizontal: Spacing.lg,
  },
  settingLeft: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
    flex: 1,
  },
  settingText: {
    fontSize: 16,
  },
  divider: {
    height: StyleSheet.hairlineWidth,
    marginLeft: Spacing.xl + Spacing.lg + Spacing.md,
  },
  logoutButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    padding: Spacing.lg,
    borderRadius: BorderRadius.sm,
  },
  logoutText: {
    fontWeight: "600",
    fontSize: 16,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
    justifyContent: "center",
    alignItems: "center",
    padding: Spacing.xl,
  },
  modalContent: {
    width: "100%",
    borderRadius: BorderRadius.md,
    padding: Spacing.xl,
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
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    padding: Spacing.md,
    fontSize: 18,
    textAlign: "center",
  },
  modalButtons: {
    flexDirection: "row",
    gap: Spacing.md,
    marginTop: Spacing.sm,
  },
  modalButton: {
    flex: 1,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
});
