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

type AppIconProps = {
  icon: string;
  label: string;
  color: string;
  onPress: () => void;
  badge?: string;
};

function AppIcon({ icon, label, color, onPress, badge }: AppIconProps) {
  const { theme } = useTheme();
  return (
    <Pressable
      onPress={() => { hapticFeedback.light(); onPress(); }}
      style={({ pressed }) => [styles.appIconContainer, { opacity: pressed ? 0.7 : 1 }]}
    >
      <View style={[styles.appIconSquare, { backgroundColor: color }]}>
        <Icon name={icon as any} size={28} color="#fff" />
        {badge ? (
          <View style={[styles.badge, { backgroundColor: theme.error }]}>
            <ThemedText style={styles.badgeText}>{badge}</ThemedText>
          </View>
        ) : null}
      </View>
      <ThemedText style={[styles.appIconLabel, { color: theme.text }]} numberOfLines={2}>
        {label}
      </ThemedText>
    </Pressable>
  );
}

function SectionTitle({ title }: { title: string }) {
  const { theme } = useTheme();
  return (
    <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
      {title}
    </ThemedText>
  );
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
      { text: "Выйти", style: "destructive", onPress: async () => { await signOut(); } },
    ]);
  };

  const canAccessWarehouse = isAdmin || hasPermission('warehouse');
  
  const canAccessRentalClients = isAdmin || hasPermission('rental') || hasPermission('rental_clients');
  const canAccessRentalOrders = isAdmin || hasPermission('rental') || hasPermission('rental_orders');
  const canAccessRentalPayments = isAdmin || hasPermission('rental') || hasPermission('rental_payments');
  const canAccessRentalCommissions = isAdmin || hasPermission('rental') || hasPermission('rental_commissions');
  const canAccessRentalCalendar = isAdmin || hasPermission('rental') || hasPermission('rental_calendar');
  const hasAnyRentalAccess = canAccessRentalClients || canAccessRentalOrders || canAccessRentalPayments || canAccessRentalCommissions || canAccessRentalCalendar;

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <Pressable
          onPress={() => { hapticFeedback.light(); navigation.navigate("EditProfile"); }}
          style={({ pressed }) => ({ opacity: pressed ? 0.8 : 1 })}
        >
          <ThemedView style={[styles.profileCard, { borderColor: theme.border, borderRadius: BorderRadius.md }]}>
            <View style={[styles.profileAvatar, { backgroundColor: theme.primary }]}>
              <ThemedText style={[styles.avatarText, { color: theme.buttonText }]}>
                {profile?.display_name?.charAt(0).toUpperCase() || "U"}
              </ThemedText>
            </View>
            <View style={styles.profileInfo}>
              <ThemedText style={styles.profileName}>{profile?.display_name || "Пользователь"}</ThemedText>
              <ThemedText style={[styles.profileRole, { color: theme.textSecondary }]}>
                {isAdmin ? "Администратор" : isRadioDispatcher ? "Диспетчер" : "Менеджер"}
              </ThemedText>
            </View>
            <Icon name="chevron-right" size={20} color={theme.textSecondary} />
          </ThemedView>
        </Pressable>

        {isAdmin ? (
          <View style={styles.section}>
            <SectionTitle title="Администрирование" />
            <View style={styles.iconGrid}>
              <AppIcon icon="users" label="Менеджеры" color="#5856D6" onPress={() => navigation.navigate("AdminPanel")} />
              <AppIcon icon="bar-chart-2" label="Отчёты" color="#FF9500" onPress={() => navigation.navigate("Reports")} />
              <AppIcon icon="file-text" label="Цены" color="#34C759" onPress={() => navigation.navigate("TicketPrices")} />
              <AppIcon icon="database" label="База данных" color="#007AFF" onPress={() => navigation.navigate("DatabaseSettings")} />
              <AppIcon
                icon="radio"
                label="Радиогид"
                color="#FF3B30"
                badge={`${radioGuidePrice}₽`}
                onPress={() => { setPriceInput(String(radioGuidePrice)); setShowPriceModal(true); }}
              />
              <AppIcon
                icon="tool"
                label="Себестоим."
                color="#AF52DE"
                badge={`${rentalCostPerReceiver}₽`}
                onPress={() => { setCostInput(String(rentalCostPerReceiver)); setShowCostModal(true); }}
              />
            </View>
          </View>
        ) : null}

        <View style={styles.section}>
          <SectionTitle title="Оборудование" />
          <View style={styles.iconGrid}>
            <AppIcon icon="radio" label="Радиогиды" color="#FF9500" onPress={() => navigation.navigate("RadioGuides")} />
            <AppIcon icon="alert-triangle" label="Утери" color="#FF3B30" onPress={() => navigation.navigate("EquipmentLosses")} />
            {canAccessWarehouse ? (
              <AppIcon icon="package" label="Склад" color="#8E8E93" onPress={() => navigation.navigate("Warehouse")} />
            ) : null}
          </View>
        </View>

        {hasAnyRentalAccess ? (
          <View style={styles.section}>
            <SectionTitle title="Аренда" />
            <View style={styles.iconGrid}>
              {canAccessRentalClients ? (
                <AppIcon icon="users" label="Клиенты" color="#007AFF" onPress={() => navigation.navigate("RentalClients")} />
              ) : null}
              {canAccessRentalOrders ? (
                <AppIcon icon="file-text" label="Заказы" color="#5856D6" onPress={() => navigation.navigate("RentalOrders")} />
              ) : null}
              {canAccessRentalPayments ? (
                <AppIcon icon="credit-card" label="Платежи" color="#34C759" onPress={() => navigation.navigate("RentalPayments")} />
              ) : null}
              {canAccessRentalCommissions ? (
                <AppIcon icon="dollar-sign" label="Комиссии" color="#FF9500" onPress={() => navigation.navigate("RentalCommissions")} />
              ) : null}
              {canAccessRentalCalendar ? (
                <AppIcon icon="calendar" label="Календарь" color="#FF2D55" onPress={() => navigation.navigate("RentalCalendar")} />
              ) : null}
              {isAdmin ? (
                <AppIcon icon="gift" label="Услуги" color="#AF52DE" onPress={() => navigation.navigate("RentalServices")} />
              ) : null}
            </View>
          </View>
        ) : null}

        <View style={styles.section}>
          <SectionTitle title="Общее" />
          <View style={styles.iconGrid}>
            <AppIcon icon="bell" label="Уведомления" color="#FF3B30" onPress={() => navigation.navigate("Notifications")} />
            <AppIcon icon="trash-2" label="Удалённые" color="#8E8E93" onPress={() => navigation.navigate("DeletedData")} />
          </View>
        </View>

        <View style={styles.footer}>
          <ThemedText style={[styles.versionText, { color: theme.textSecondary }]}>
            Версия 1.0.0
          </ThemedText>
          <Pressable
            onPress={handleLogout}
            style={({ pressed }) => [styles.logoutButton, { opacity: pressed ? 0.7 : 1 }]}
          >
            <Icon name="log-out" size={18} color={theme.error} />
            <ThemedText style={[styles.logoutText, { color: theme.error }]}>Выйти</ThemedText>
          </Pressable>
        </View>
      </View>

      <Modal visible={showPriceModal} transparent animationType="fade" onRequestClose={() => setShowPriceModal(false)}>
        <Pressable style={styles.modalOverlay} onPress={() => setShowPriceModal(false)}>
          <Pressable style={[styles.modalContent, { backgroundColor: theme.backgroundSecondary }]} onPress={(e) => e.stopPropagation()}>
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
              <Pressable style={[styles.modalButton, { backgroundColor: theme.backgroundRoot }]} onPress={() => setShowPriceModal(false)}>
                <ThemedText>Отмена</ThemedText>
              </Pressable>
              <Pressable style={[styles.modalButton, { backgroundColor: theme.primary }]} onPress={handleSavePrice} disabled={saving}>
                <ThemedText style={{ color: theme.buttonText }}>{saving ? "Сохранение..." : "Сохранить"}</ThemedText>
              </Pressable>
            </View>
          </Pressable>
        </Pressable>
      </Modal>

      <Modal visible={showCostModal} transparent animationType="fade" onRequestClose={() => setShowCostModal(false)}>
        <Pressable style={styles.modalOverlay} onPress={() => setShowCostModal(false)}>
          <Pressable style={[styles.modalContent, { backgroundColor: theme.backgroundSecondary }]} onPress={(e) => e.stopPropagation()}>
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
              <Pressable style={[styles.modalButton, { backgroundColor: theme.backgroundRoot }]} onPress={() => setShowCostModal(false)}>
                <ThemedText>Отмена</ThemedText>
              </Pressable>
              <Pressable style={[styles.modalButton, { backgroundColor: theme.primary }]} onPress={handleSaveCost} disabled={saving}>
                <ThemedText style={{ color: theme.buttonText }}>{saving ? "Сохранение..." : "Сохранить"}</ThemedText>
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
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.lg,
    borderWidth: 1,
    gap: Spacing.md,
  },
  profileAvatar: {
    width: 56,
    height: 56,
    borderRadius: 28,
    alignItems: "center",
    justifyContent: "center",
  },
  avatarText: {
    fontSize: 24,
    fontWeight: "700",
  },
  profileInfo: {
    flex: 1,
    gap: 2,
  },
  profileName: {
    fontSize: 18,
    fontWeight: "600",
  },
  profileRole: {
    fontSize: 14,
  },
  section: {
    gap: Spacing.md,
  },
  sectionTitle: {
    fontSize: 13,
    fontWeight: "600",
    textTransform: "uppercase",
    letterSpacing: 0.5,
    marginLeft: Spacing.xs,
  },
  iconGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.sm,
  },
  appIconContainer: {
    width: "23%",
    alignItems: "center",
    gap: Spacing.xs,
  },
  appIconSquare: {
    width: 60,
    height: 60,
    borderRadius: 14,
    alignItems: "center",
    justifyContent: "center",
  },
  appIconLabel: {
    fontSize: 11,
    textAlign: "center",
    lineHeight: 13,
  },
  badge: {
    position: "absolute",
    top: -4,
    right: -4,
    minWidth: 20,
    height: 18,
    borderRadius: 9,
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: 4,
  },
  badgeText: {
    color: "#fff",
    fontSize: 10,
    fontWeight: "700",
  },
  footer: {
    alignItems: "center",
    gap: Spacing.md,
    paddingTop: Spacing.md,
  },
  versionText: {
    fontSize: 13,
  },
  logoutButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.lg,
  },
  logoutText: {
    fontSize: 16,
    fontWeight: "500",
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
