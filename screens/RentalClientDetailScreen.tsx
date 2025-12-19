import { useState, useMemo } from "react";
import {
  View,
  StyleSheet,
  Pressable,
  Alert,
  TextInput,
  Modal,
  FlatList,
  Linking,
  Platform,
} from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { useNavigation, useRoute, RouteProp, NavigationProp } from "@react-navigation/native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useRental, RentalOrder, RentalOrderStatus } from "@/contexts/RentalContext";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";
import { hapticFeedback } from "@/utils/haptics";

type RouteParams = RouteProp<SettingsStackParamList, "RentalClientDetail">;

const STATUS_CONFIG: Record<RentalOrderStatus, { label: string; color: string }> = {
  new: { label: "Новый", color: "#2196F3" },
  issued: { label: "Выдан", color: "#4CAF50" },
  returned: { label: "Возвращён", color: "#FF9800" },
  completed: { label: "Завершён", color: "#9C27B0" },
  cancelled: { label: "Отменён", color: "#F44336" },
};

export default function RentalClientDetailScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<SettingsStackParamList>>();
  const route = useRoute<RouteParams>();
  const insets = useSafeAreaInsets();
  const { rentalClients, rentalOrders, updateRentalClient, deleteRentalClient } = useRental();

  const clientId = route.params?.clientId;
  const client = rentalClients.find(c => c.id === clientId);

  const [showEditModal, setShowEditModal] = useState(false);
  const [editName, setEditName] = useState(client?.name || "");
  const [editPhone, setEditPhone] = useState(client?.phone || "");
  const [editEmail, setEditEmail] = useState(client?.email || "");
  const [editDefaultPrice, setEditDefaultPrice] = useState(client?.defaultPrice?.toString() || "100");
  const [editNotes, setEditNotes] = useState(client?.notes || "");
  const [editType, setEditType] = useState<"individual" | "company">(client?.type || "individual");

  const clientOrders = useMemo(() => {
    if (!client) return [];
    return rentalOrders.filter(o => o.clientId === client.id).sort((a, b) => 
      new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
    );
  }, [rentalOrders, client]);

  const stats = useMemo(() => {
    const totalOrders = clientOrders.length;
    const totalRevenue = clientOrders
      .filter(o => o.status !== "cancelled")
      .reduce((sum, o) => sum + o.totalPrice, 0);
    const activeOrders = clientOrders.filter(o => o.status === "issued").length;
    return { totalOrders, totalRevenue, activeOrders };
  }, [clientOrders]);

  const formatDate = (dateStr: string): string => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU", { day: "2-digit", month: "2-digit", year: "numeric" });
  };

  const handleCallPhone = () => {
    if (client?.phone) {
      Linking.openURL(`tel:${client.phone}`);
    }
  };

  const handleSendEmail = () => {
    if (client?.email) {
      Linking.openURL(`mailto:${client.email}`);
    }
  };

  const handleSaveEdit = async () => {
    if (!client) return;
    if (!editName.trim()) {
      Alert.alert("Ошибка", "Введите имя клиента");
      return;
    }

    hapticFeedback.selection();
    try {
      await updateRentalClient(client.id, {
        name: editName.trim(),
        phone: editPhone.trim() || null,
        email: editEmail.trim() || null,
        defaultPrice: parseFloat(editDefaultPrice) || 100,
        notes: editNotes.trim() || null,
        type: editType,
      });
      setShowEditModal(false);
      hapticFeedback.success();
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось обновить клиента");
    }
  };

  const handleDelete = () => {
    if (!client) return;
    Alert.alert(
      "Удалить клиента",
      `Вы уверены, что хотите удалить клиента "${client.name}"?`,
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Удалить",
          style: "destructive",
          onPress: async () => {
            await deleteRentalClient(client.id);
            hapticFeedback.success();
            navigation.goBack();
          },
        },
      ]
    );
  };

  const handleToggleActive = async () => {
    if (!client) return;
    hapticFeedback.selection();
    try {
      await updateRentalClient(client.id, { isActive: !client.isActive });
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось обновить статус клиента");
    }
  };

  if (!client) {
    return (
      <ThemedView style={[styles.container, styles.center]}>
        <Icon name="users" size={48} color={theme.textSecondary} />
        <ThemedText style={{ color: theme.textSecondary, marginTop: Spacing.md }}>
          Клиент не найден
        </ThemedText>
      </ThemedView>
    );
  }

  const renderOrderItem = ({ item }: { item: RentalOrder }) => {
    const statusConfig = STATUS_CONFIG[item.status];
    return (
      <Pressable
        onPress={() => navigation.navigate("RentalOrderDetail", { orderId: item.id })}
        style={[styles.orderCard, { backgroundColor: theme.backgroundSecondary }]}
      >
        <View style={styles.orderRow}>
          <View style={styles.orderInfo}>
            <View style={styles.orderTitleRow}>
              <ThemedText style={styles.orderNumber}>#{item.orderNumber}</ThemedText>
              <View style={[styles.statusBadge, { backgroundColor: statusConfig.color + "20" }]}>
                <ThemedText style={[styles.statusText, { color: statusConfig.color }]}>
                  {statusConfig.label}
                </ThemedText>
              </View>
            </View>
            <ThemedText style={[styles.orderDate, { color: theme.textSecondary }]}>
              {formatDate(item.startDate)} - {formatDate(item.endDate)}
            </ThemedText>
          </View>
          <ThemedText style={[styles.orderPrice, { color: theme.primary }]}>
            {item.totalPrice.toLocaleString("ru-RU")}₽
          </ThemedText>
        </View>
      </Pressable>
    );
  };

  return (
    <ThemedView style={styles.container}>
      <ScreenScrollView contentContainerStyle={styles.scrollContent}>
        <View style={[styles.headerCard, { backgroundColor: theme.backgroundSecondary }]}>
          <View style={styles.headerRow}>
            <View style={[styles.avatar, { backgroundColor: client.type === "company" ? theme.primary : theme.secondary }]}>
              <ThemedText style={styles.avatarText}>
                {client.name.slice(0, 2).toUpperCase()}
              </ThemedText>
            </View>
            <View style={styles.headerInfo}>
              <View style={styles.nameRow}>
                <ThemedText style={styles.clientName}>{client.name}</ThemedText>
                {!client.isActive ? (
                  <View style={[styles.inactiveBadge, { backgroundColor: theme.error + "20" }]}>
                    <ThemedText style={[styles.inactiveText, { color: theme.error }]}>
                      Неактивен
                    </ThemedText>
                  </View>
                ) : null}
              </View>
              <ThemedText style={[styles.clientType, { color: theme.textSecondary }]}>
                {client.type === "company" ? "Компания" : "Физ. лицо"}
              </ThemedText>
            </View>
            <Pressable onPress={() => setShowEditModal(true)}>
              <Icon name="edit-2" size={20} color={theme.primary} />
            </Pressable>
          </View>

          {(client.phone || client.email) ? (
            <View style={styles.contactsRow}>
              {client.phone ? (
                <Pressable
                  onPress={handleCallPhone}
                  style={[styles.contactBtn, { backgroundColor: theme.success + "20" }]}
                >
                  <Icon name="phone" size={18} color={theme.success} />
                  <ThemedText style={[styles.contactText, { color: theme.success }]}>
                    {client.phone}
                  </ThemedText>
                </Pressable>
              ) : null}
              {client.email ? (
                <Pressable
                  onPress={handleSendEmail}
                  style={[styles.contactBtn, { backgroundColor: theme.primary + "20" }]}
                >
                  <Icon name="mail" size={18} color={theme.primary} />
                  <ThemedText style={[styles.contactText, { color: theme.primary }]} numberOfLines={1}>
                    {client.email}
                  </ThemedText>
                </Pressable>
              ) : null}
            </View>
          ) : null}

          {client.notes ? (
            <View style={[styles.notesBox, { backgroundColor: theme.backgroundTertiary }]}>
              <Icon name="file-text" size={14} color={theme.textSecondary} />
              <ThemedText style={[styles.notesText, { color: theme.textSecondary }]}>
                {client.notes}
              </ThemedText>
            </View>
          ) : null}
        </View>

        <View style={[styles.statsCard, { backgroundColor: theme.backgroundSecondary }]}>
          <View style={styles.statsRow}>
            <View style={styles.statItem}>
              <ThemedText style={[styles.statValue, { color: theme.primary }]}>
                {stats.totalOrders}
              </ThemedText>
              <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                Заказов
              </ThemedText>
            </View>
            <View style={[styles.statDivider, { backgroundColor: theme.border }]} />
            <View style={styles.statItem}>
              <ThemedText style={[styles.statValue, { color: theme.success }]}>
                {stats.totalRevenue.toLocaleString("ru-RU")}₽
              </ThemedText>
              <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                Выручка
              </ThemedText>
            </View>
            <View style={[styles.statDivider, { backgroundColor: theme.border }]} />
            <View style={styles.statItem}>
              <ThemedText style={[styles.statValue, { color: theme.secondary }]}>
                {stats.activeOrders}
              </ThemedText>
              <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                Активных
              </ThemedText>
            </View>
          </View>
          <View style={[styles.priceRow, { backgroundColor: theme.backgroundTertiary }]}>
            <ThemedText style={{ color: theme.textSecondary }}>Цена по умолчанию:</ThemedText>
            <ThemedText style={[styles.defaultPrice, { color: theme.primary }]}>
              {client.defaultPrice}₽
            </ThemedText>
          </View>
        </View>

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <View style={styles.sectionHeader}>
            <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
              История заказов
            </ThemedText>
            <Pressable
              onPress={() => navigation.navigate("AddRentalOrder", { clientId: client.id })}
              style={[styles.addBtn, { backgroundColor: theme.primary + "20" }]}
            >
              <Icon name="plus" size={16} color={theme.primary} />
              <ThemedText style={{ color: theme.primary, fontSize: 13 }}>Новый</ThemedText>
            </Pressable>
          </View>

          {clientOrders.length > 0 ? (
            <View style={styles.ordersList}>
              {clientOrders.slice(0, 10).map(order => (
                <View key={order.id}>
                  {renderOrderItem({ item: order })}
                </View>
              ))}
              {clientOrders.length > 10 ? (
                <ThemedText style={[styles.moreText, { color: theme.textSecondary }]}>
                  И ещё {clientOrders.length - 10} заказов...
                </ThemedText>
              ) : null}
            </View>
          ) : (
            <ThemedText style={{ color: theme.textSecondary, textAlign: "center", padding: Spacing.md }}>
              Заказов пока нет
            </ThemedText>
          )}
        </View>

        <View style={styles.actionsCard}>
          <Pressable
            onPress={handleToggleActive}
            style={[
              styles.actionBtn,
              { backgroundColor: client.isActive ? theme.error + "15" : theme.success + "15" },
            ]}
          >
            <Icon name={client.isActive ? "eye-off" : "eye"} size={20} color={client.isActive ? theme.error : theme.success} />
            <ThemedText style={{ color: client.isActive ? theme.error : theme.success }}>
              {client.isActive ? "Деактивировать" : "Активировать"}
            </ThemedText>
          </Pressable>

          <Pressable
            onPress={handleDelete}
            style={[styles.actionBtn, { backgroundColor: theme.error + "15" }]}
          >
            <Icon name="trash-2" size={20} color={theme.error} />
            <ThemedText style={{ color: theme.error }}>Удалить клиента</ThemedText>
          </Pressable>
        </View>

        <View style={{ height: insets.bottom + Spacing.xl }} />
      </ScreenScrollView>

      <Modal visible={showEditModal} animationType="slide" transparent>
        <View style={[styles.modalOverlay, { justifyContent: "flex-end" }]}>
          <View style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Редактировать клиента</ThemedText>
              <Pressable onPress={() => setShowEditModal(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <View style={styles.modalBody}>
              <View style={styles.typeRow}>
                <Pressable
                  onPress={() => setEditType("individual")}
                  style={[
                    styles.typeBtn,
                    { backgroundColor: editType === "individual" ? theme.secondary + "20" : theme.backgroundSecondary },
                  ]}
                >
                  <ThemedText style={{ color: editType === "individual" ? theme.secondary : theme.textSecondary }}>
                    Физ. лицо
                  </ThemedText>
                </Pressable>
                <Pressable
                  onPress={() => setEditType("company")}
                  style={[
                    styles.typeBtn,
                    { backgroundColor: editType === "company" ? theme.primary + "20" : theme.backgroundSecondary },
                  ]}
                >
                  <ThemedText style={{ color: editType === "company" ? theme.primary : theme.textSecondary }}>
                    Компания
                  </ThemedText>
                </Pressable>
              </View>

              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>Имя *</ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={editName}
                onChangeText={setEditName}
                placeholder="Имя клиента"
                placeholderTextColor={theme.textSecondary}
              />

              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>Телефон</ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={editPhone}
                onChangeText={setEditPhone}
                placeholder="+7 (999) 123-45-67"
                placeholderTextColor={theme.textSecondary}
                keyboardType="phone-pad"
              />

              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>Email</ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={editEmail}
                onChangeText={setEditEmail}
                placeholder="email@example.com"
                placeholderTextColor={theme.textSecondary}
                keyboardType="email-address"
              />

              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>Цена по умолчанию</ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={editDefaultPrice}
                onChangeText={setEditDefaultPrice}
                placeholder="100"
                placeholderTextColor={theme.textSecondary}
                keyboardType="numeric"
              />

              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>Заметки</ThemedText>
              <TextInput
                style={[styles.input, styles.textArea, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={editNotes}
                onChangeText={setEditNotes}
                placeholder="Дополнительная информация"
                placeholderTextColor={theme.textSecondary}
                multiline
                numberOfLines={3}
              />

              <Pressable
                onPress={handleSaveEdit}
                style={[styles.saveBtn, { backgroundColor: theme.primary }]}
              >
                <ThemedText style={{ color: "#fff", fontWeight: "600" }}>Сохранить</ThemedText>
              </Pressable>
            </View>
          </View>
        </View>
      </Modal>
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  center: {
    justifyContent: "center",
    alignItems: "center",
  },
  scrollContent: {
    padding: Spacing.md,
    gap: Spacing.md,
  },
  headerCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
  },
  headerRow: {
    flexDirection: "row",
    alignItems: "flex-start",
    gap: Spacing.md,
  },
  avatar: {
    width: 56,
    height: 56,
    borderRadius: 28,
    justifyContent: "center",
    alignItems: "center",
  },
  avatarText: {
    color: "#fff",
    fontSize: 20,
    fontWeight: "700",
  },
  headerInfo: {
    flex: 1,
  },
  nameRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  clientName: {
    fontSize: 20,
    fontWeight: "700",
  },
  inactiveBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  inactiveText: {
    fontSize: 11,
    fontWeight: "600",
  },
  clientType: {
    fontSize: 14,
    marginTop: 2,
  },
  contactsRow: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginTop: Spacing.md,
    flexWrap: "wrap",
  },
  contactBtn: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.md,
  },
  contactText: {
    fontSize: 13,
    fontWeight: "500",
  },
  notesBox: {
    flexDirection: "row",
    alignItems: "flex-start",
    gap: Spacing.sm,
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
    marginTop: Spacing.md,
  },
  notesText: {
    flex: 1,
    fontSize: 13,
  },
  statsCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
  },
  statsRow: {
    flexDirection: "row",
    alignItems: "center",
  },
  statItem: {
    flex: 1,
    alignItems: "center",
  },
  statValue: {
    fontSize: 20,
    fontWeight: "700",
  },
  statLabel: {
    fontSize: 12,
    marginTop: 2,
  },
  statDivider: {
    width: 1,
    height: 40,
  },
  priceRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
    marginTop: Spacing.md,
  },
  defaultPrice: {
    fontSize: 18,
    fontWeight: "700",
  },
  card: {
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
  },
  sectionHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.sm,
  },
  sectionTitle: {
    fontSize: 13,
    fontWeight: "500",
    textTransform: "uppercase",
  },
  addBtn: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.md,
    gap: Spacing.xs,
  },
  ordersList: {
    gap: Spacing.sm,
  },
  orderCard: {
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
  },
  orderRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  orderInfo: {
    flex: 1,
  },
  orderTitleRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  orderNumber: {
    fontSize: 14,
    fontWeight: "600",
  },
  statusBadge: {
    paddingHorizontal: Spacing.xs,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  statusText: {
    fontSize: 10,
    fontWeight: "600",
  },
  orderDate: {
    fontSize: 12,
    marginTop: 2,
  },
  orderPrice: {
    fontSize: 15,
    fontWeight: "600",
  },
  moreText: {
    textAlign: "center",
    fontSize: 13,
    marginTop: Spacing.xs,
  },
  actionsCard: {
    gap: Spacing.sm,
  },
  actionBtn: {
    flexDirection: "row",
    justifyContent: "center",
    alignItems: "center",
    gap: Spacing.sm,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
  },
  modalContent: {
    maxHeight: "85%",
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.md,
    borderBottomWidth: 1,
    borderBottomColor: "rgba(0,0,0,0.1)",
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  modalBody: {
    padding: Spacing.md,
    paddingBottom: 40,
  },
  typeRow: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginBottom: Spacing.md,
  },
  typeBtn: {
    flex: 1,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
  inputLabel: {
    fontSize: 13,
    marginBottom: Spacing.xs,
  },
  input: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    fontSize: 16,
  },
  textArea: {
    minHeight: 80,
    textAlignVertical: "top",
  },
  saveBtn: {
    marginTop: Spacing.lg,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
});
