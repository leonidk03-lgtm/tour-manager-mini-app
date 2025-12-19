import { useState, useMemo } from "react";
import {
  View,
  StyleSheet,
  Pressable,
  Alert,
  TextInput,
  Modal,
  ScrollView,
} from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { useNavigation, useRoute, RouteProp } from "@react-navigation/native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useRental, RentalOrderStatus, RentalPaymentType } from "@/contexts/RentalContext";
import { useAuth } from "@/contexts/AuthContext";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";
import { hapticFeedback } from "@/utils/haptics";

type RouteParams = RouteProp<SettingsStackParamList, "RentalOrderDetail">;
type ManagerSelectType = "owner" | "executor";

const STATUS_CONFIG: Record<RentalOrderStatus, { label: string; color: string; icon: string }> = {
  new: { label: "Новый", color: "#2196F3", icon: "clock" },
  issued: { label: "Выдан", color: "#4CAF50", icon: "check-circle" },
  returned: { label: "Возвращён", color: "#FF9800", icon: "rotate-ccw" },
  completed: { label: "Завершён", color: "#9C27B0", icon: "check-square" },
  cancelled: { label: "Отменён", color: "#F44336", icon: "x-circle" },
};

const PAYMENT_TYPE_CONFIG: Record<RentalPaymentType, { label: string; color: string }> = {
  prepayment: { label: "Предоплата", color: "#4CAF50" },
  refund: { label: "Возврат", color: "#F44336" },
  service_expense: { label: "Служебный расход", color: "#FF9800" },
  final: { label: "Окончательный расчёт", color: "#2196F3" },
};

export default function RentalOrderDetailScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation();
  const route = useRoute<RouteParams>();
  const insets = useSafeAreaInsets();
  const { rentalOrders, rentalClients, updateRentalOrder, updateRentalClient, updateOrderStatus, addRentalPayment, getOrderPayments, getOrderHistory, deleteRentalOrder } = useRental();
  const { managers } = useAuth();

  const orderId = route.params?.orderId;
  const order = rentalOrders.find(o => o.id === orderId);
  const client = order ? rentalClients.find(c => c.id === order.clientId) : null;
  const payments = order ? getOrderPayments(order.id) : [];
  const history = order ? getOrderHistory(order.id) : [];

  const ownerManager = client?.assignedManagerId ? managers.find(m => m.id === client.assignedManagerId) : null;
  const executorManager = order?.executorId ? managers.find(m => m.id === order.executorId) : null;

  const [showStatusModal, setShowStatusModal] = useState(false);
  const [showPaymentModal, setShowPaymentModal] = useState(false);
  const [showManagerModal, setShowManagerModal] = useState(false);
  const [managerSelectType, setManagerSelectType] = useState<ManagerSelectType>("owner");
  const [paymentType, setPaymentType] = useState<RentalPaymentType>("prepayment");
  const [paymentAmount, setPaymentAmount] = useState("");
  const [paymentNotes, setPaymentNotes] = useState("");

  const totalPaid = useMemo(() => {
    return payments.reduce((sum, p) => {
      if (p.type === "refund" || p.type === "service_expense") return sum - p.amount;
      return sum + p.amount;
    }, 0);
  }, [payments]);

  const remainingAmount = order ? order.totalPrice - totalPaid : 0;

  const formatDate = (dateStr: string): string => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU", { day: "2-digit", month: "2-digit", year: "numeric" });
  };

  const formatDateTime = (dateStr: string): string => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU", { day: "2-digit", month: "2-digit", year: "numeric", hour: "2-digit", minute: "2-digit" });
  };

  const handleStatusChange = async (status: RentalOrderStatus) => {
    if (!order) return;
    hapticFeedback.selection();
    try {
      await updateOrderStatus(order.id, status);
      setShowStatusModal(false);
      hapticFeedback.success();
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось изменить статус");
    }
  };

  const handleAddPayment = async () => {
    if (!order) return;
    const amount = parseFloat(paymentAmount);
    if (!amount || amount <= 0) {
      Alert.alert("Ошибка", "Введите сумму платежа");
      return;
    }

    hapticFeedback.selection();
    try {
      await addRentalPayment({
        orderId: order.id,
        type: paymentType,
        amount,
        notes: paymentNotes.trim() || null,
      });
      setShowPaymentModal(false);
      setPaymentAmount("");
      setPaymentNotes("");
      hapticFeedback.success();
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось добавить платёж");
    }
  };

  const handleDelete = () => {
    if (!order) return;
    Alert.alert(
      "Удалить заказ",
      `Вы уверены, что хотите удалить заказ #${order.orderNumber}?`,
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Удалить",
          style: "destructive",
          onPress: async () => {
            await deleteRentalOrder(order.id);
            hapticFeedback.success();
            navigation.goBack();
          },
        },
      ]
    );
  };

  const openManagerSelect = (type: ManagerSelectType) => {
    setManagerSelectType(type);
    setShowManagerModal(true);
  };

  const handleManagerSelect = async (managerId: string | null) => {
    if (!order || !client) return;
    hapticFeedback.selection();
    try {
      if (managerSelectType === "owner") {
        await updateRentalClient(client.id, { assignedManagerId: managerId });
      } else {
        await updateRentalOrder(order.id, { executorId: managerId });
      }
      setShowManagerModal(false);
      hapticFeedback.success();
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось изменить менеджера");
    }
  };

  if (!order) {
    return (
      <ThemedView style={[styles.container, styles.center]}>
        <Icon name="file-text" size={48} color={theme.textSecondary} />
        <ThemedText style={{ color: theme.textSecondary, marginTop: Spacing.md }}>
          Заказ не найден
        </ThemedText>
      </ThemedView>
    );
  }

  const statusConfig = STATUS_CONFIG[order.status];

  return (
    <ThemedView style={styles.container}>
      <ScreenScrollView contentContainerStyle={styles.scrollContent}>
        <View style={[styles.headerCard, { backgroundColor: theme.backgroundSecondary }]}>
          <View style={styles.orderHeaderRow}>
            <View>
              <ThemedText style={styles.orderNumber}>Заказ #{order.orderNumber}</ThemedText>
              <ThemedText style={[styles.totalPrice, { color: theme.primary }]}>
                {order.totalPrice.toLocaleString("ru-RU")}₽
              </ThemedText>
            </View>
            <Pressable
              onPress={() => setShowStatusModal(true)}
              style={[styles.statusBadge, { backgroundColor: statusConfig.color + "20" }]}
            >
              <Icon name={statusConfig.icon as "clock"} size={16} color={statusConfig.color} />
              <ThemedText style={[styles.statusText, { color: statusConfig.color }]}>
                {statusConfig.label}
              </ThemedText>
              <Icon name="chevron-down" size={14} color={statusConfig.color} />
            </Pressable>
          </View>
        </View>

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            Клиент
          </ThemedText>
          {client ? (
            <View style={styles.clientRow}>
              <View style={[styles.clientAvatar, { backgroundColor: client.type === "company" ? theme.primary : theme.secondary }]}>
                <ThemedText style={styles.avatarText}>
                  {client.name.slice(0, 2).toUpperCase()}
                </ThemedText>
              </View>
              <View style={styles.clientInfo}>
                <ThemedText style={styles.clientName}>{client.name}</ThemedText>
                {client.phone ? (
                  <ThemedText style={[styles.clientPhone, { color: theme.textSecondary }]}>
                    {client.phone}
                  </ThemedText>
                ) : null}
              </View>
            </View>
          ) : (
            <ThemedText style={{ color: theme.textSecondary }}>Клиент не найден</ThemedText>
          )}
        </View>

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            Менеджеры
          </ThemedText>
          
          <Pressable
            style={[styles.managerRow, { borderColor: theme.border }]}
            onPress={() => openManagerSelect("owner")}
          >
            <View style={styles.managerLabel}>
              <Icon name="user" size={16} color={theme.primary} />
              <ThemedText style={[styles.managerLabelText, { color: theme.textSecondary }]}>
                Менеджер клиента
              </ThemedText>
            </View>
            <View style={styles.managerValue}>
              <ThemedText style={ownerManager ? styles.managerName : { color: theme.textSecondary }}>
                {ownerManager?.display_name || "Не назначен"}
              </ThemedText>
              <Icon name="chevron-right" size={16} color={theme.textSecondary} />
            </View>
          </Pressable>

          <Pressable
            style={[styles.managerRow, { borderColor: theme.border, borderTopWidth: 0 }]}
            onPress={() => openManagerSelect("executor")}
          >
            <View style={styles.managerLabel}>
              <Icon name="truck" size={16} color={theme.success} />
              <ThemedText style={[styles.managerLabelText, { color: theme.textSecondary }]}>
                Исполнитель
              </ThemedText>
            </View>
            <View style={styles.managerValue}>
              <ThemedText style={executorManager ? styles.managerName : { color: theme.textSecondary }}>
                {executorManager?.display_name || "Не назначен"}
              </ThemedText>
              <Icon name="chevron-right" size={16} color={theme.textSecondary} />
            </View>
          </Pressable>
        </View>

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            Информация
          </ThemedText>
          <View style={styles.infoGrid}>
            <View style={styles.infoItem}>
              <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>Дней</ThemedText>
              <ThemedText style={styles.infoValue}>{order.daysCount}</ThemedText>
            </View>
            <View style={styles.infoItem}>
              <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>Начало</ThemedText>
              <ThemedText style={styles.infoValue}>{formatDate(order.startDate)}</ThemedText>
            </View>
            <View style={styles.infoItem}>
              <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>Окончание</ThemedText>
              <ThemedText style={styles.infoValue}>{formatDate(order.endDate)}</ThemedText>
            </View>
            <View style={styles.infoItem}>
              <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>Комплектация</ThemedText>
              <ThemedText style={styles.infoValue}>{order.kitCount}</ThemedText>
            </View>
            <View style={styles.infoItem}>
              <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>Передатчик</ThemedText>
              <ThemedText style={styles.infoValue}>{order.transmitterCount}</ThemedText>
            </View>
            <View style={styles.infoItem}>
              <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>Микрофон</ThemedText>
              <ThemedText style={styles.infoValue}>{order.microphoneCount}</ThemedText>
            </View>
            {order.bagNumber ? (
              <View style={styles.infoItem}>
                <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>Номер сумки</ThemedText>
                <ThemedText style={styles.infoValue}>{order.bagNumber}</ThemedText>
              </View>
            ) : null}
            <View style={styles.infoItem}>
              <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>Заряжен</ThemedText>
              <ThemedText style={styles.infoValue}>{order.isCharged ? "Да" : "Нет"}</ThemedText>
            </View>
          </View>
          {order.receiverNotes ? (
            <View style={[styles.notesBox, { backgroundColor: theme.backgroundSecondary }]}>
              <Icon name="file-text" size={14} color={theme.textSecondary} />
              <ThemedText style={[styles.notesText, { color: theme.textSecondary }]}>
                {order.receiverNotes}
              </ThemedText>
            </View>
          ) : null}
        </View>

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <View style={styles.sectionHeader}>
            <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
              Платежи
            </ThemedText>
            <Pressable
              onPress={() => setShowPaymentModal(true)}
              style={[styles.addBtn, { backgroundColor: theme.primary + "20" }]}
            >
              <Icon name="plus" size={16} color={theme.primary} />
              <ThemedText style={{ color: theme.primary, fontSize: 13 }}>Добавить</ThemedText>
            </Pressable>
          </View>

          {payments.length > 0 ? (
            <View style={styles.paymentsList}>
              {payments.map(payment => {
                const config = PAYMENT_TYPE_CONFIG[payment.type];
                return (
                  <View key={payment.id} style={[styles.paymentItem, { borderLeftColor: config.color }]}>
                    <View style={styles.paymentInfo}>
                      <ThemedText style={styles.paymentLabel}>{config.label}</ThemedText>
                      <ThemedText style={[styles.paymentDate, { color: theme.textSecondary }]}>
                        {formatDateTime(payment.createdAt)}
                      </ThemedText>
                      {payment.notes ? (
                        <ThemedText style={[styles.paymentNotes, { color: theme.textSecondary }]}>
                          {payment.notes}
                        </ThemedText>
                      ) : null}
                    </View>
                    <ThemedText style={[styles.paymentAmount, { color: config.color }]}>
                      {payment.type === "refund" || payment.type === "service_expense" ? "-" : "+"}
                      {payment.amount.toLocaleString("ru-RU")}₽
                    </ThemedText>
                  </View>
                );
              })}
            </View>
          ) : (
            <ThemedText style={{ color: theme.textSecondary, textAlign: "center", padding: Spacing.md }}>
              Платежей пока нет
            </ThemedText>
          )}

          <View style={[styles.summaryRow, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={{ color: theme.textSecondary }}>Оплачено:</ThemedText>
            <ThemedText style={{ fontWeight: "600" }}>{totalPaid.toLocaleString("ru-RU")}₽</ThemedText>
          </View>
          <View style={[styles.summaryRow, { backgroundColor: remainingAmount > 0 ? theme.error + "15" : theme.success + "15" }]}>
            <ThemedText style={{ color: remainingAmount > 0 ? theme.error : theme.success }}>
              {remainingAmount > 0 ? "К оплате:" : "Переплата:"}
            </ThemedText>
            <ThemedText style={{ fontWeight: "700", color: remainingAmount > 0 ? theme.error : theme.success }}>
              {Math.abs(remainingAmount).toLocaleString("ru-RU")}₽
            </ThemedText>
          </View>
        </View>

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            История
          </ThemedText>
          {history.length > 0 ? (
            <View style={styles.historyList}>
              {history.map(item => (
                <View key={item.id} style={styles.historyItem}>
                  <View style={[styles.historyDot, { backgroundColor: theme.primary }]} />
                  <View style={styles.historyContent}>
                    <ThemedText style={styles.historyAction}>{item.action}</ThemedText>
                    <ThemedText style={[styles.historyMeta, { color: theme.textSecondary }]}>
                      {item.managerName} • {formatDateTime(item.createdAt)}
                    </ThemedText>
                  </View>
                </View>
              ))}
            </View>
          ) : (
            <ThemedText style={{ color: theme.textSecondary, textAlign: "center", padding: Spacing.md }}>
              История пуста
            </ThemedText>
          )}
        </View>

        <Pressable
          onPress={handleDelete}
          style={[styles.deleteBtn, { backgroundColor: theme.error + "15" }]}
        >
          <Icon name="trash-2" size={20} color={theme.error} />
          <ThemedText style={{ color: theme.error }}>Удалить заказ</ThemedText>
        </Pressable>

        <View style={{ height: insets.bottom + Spacing.xl }} />
      </ScreenScrollView>

      <Modal visible={showStatusModal} animationType="fade" transparent>
        <Pressable style={styles.modalOverlay} onPress={() => setShowStatusModal(false)}>
          <View style={[styles.statusModalContent, { backgroundColor: theme.backgroundDefault }]}>
            <ThemedText style={styles.modalTitle}>Изменить статус</ThemedText>
            {(Object.keys(STATUS_CONFIG) as RentalOrderStatus[]).map(status => {
              const config = STATUS_CONFIG[status];
              const isActive = order.status === status;
              return (
                <Pressable
                  key={status}
                  onPress={() => handleStatusChange(status)}
                  style={[
                    styles.statusOption,
                    { backgroundColor: isActive ? config.color + "20" : "transparent" },
                  ]}
                >
                  <Icon name={config.icon as "clock"} size={20} color={config.color} />
                  <ThemedText style={[styles.statusOptionText, { color: config.color }]}>
                    {config.label}
                  </ThemedText>
                  {isActive ? (
                    <Icon name="check" size={20} color={config.color} />
                  ) : null}
                </Pressable>
              );
            })}
          </View>
        </Pressable>
      </Modal>

      <Modal visible={showPaymentModal} animationType="slide" transparent>
        <View style={[styles.modalOverlay, { justifyContent: "flex-end" }]}>
          <View style={[styles.paymentModalContent, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Добавить платёж</ThemedText>
              <Pressable onPress={() => setShowPaymentModal(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <ScrollView style={styles.paymentModalScroll}>
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Тип платежа
              </ThemedText>
              <View style={styles.paymentTypeRow}>
                {(Object.keys(PAYMENT_TYPE_CONFIG) as RentalPaymentType[]).map(type => {
                  const config = PAYMENT_TYPE_CONFIG[type];
                  const isActive = paymentType === type;
                  return (
                    <Pressable
                      key={type}
                      onPress={() => setPaymentType(type)}
                      style={[
                        styles.paymentTypeBtn,
                        { backgroundColor: isActive ? config.color + "20" : theme.backgroundSecondary },
                      ]}
                    >
                      <ThemedText style={{ color: isActive ? config.color : theme.textSecondary, fontSize: 12 }}>
                        {config.label}
                      </ThemedText>
                    </Pressable>
                  );
                })}
              </View>

              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>
                Сумма
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={paymentAmount}
                onChangeText={setPaymentAmount}
                placeholder="0"
                placeholderTextColor={theme.textSecondary}
                keyboardType="numeric"
              />

              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>
                Примечание
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={paymentNotes}
                onChangeText={setPaymentNotes}
                placeholder="Необязательно"
                placeholderTextColor={theme.textSecondary}
              />

              <Pressable
                onPress={handleAddPayment}
                style={[styles.savePaymentBtn, { backgroundColor: theme.primary }]}
              >
                <ThemedText style={{ color: "#fff", fontWeight: "600" }}>Добавить платёж</ThemedText>
              </Pressable>
            </ScrollView>
          </View>
        </View>
      </Modal>

      <Modal visible={showManagerModal} animationType="fade" transparent>
        <Pressable style={styles.modalOverlay} onPress={() => setShowManagerModal(false)}>
          <View style={[styles.statusModalContent, { backgroundColor: theme.backgroundDefault, maxHeight: "60%" }]}>
            <ThemedText style={styles.modalTitle}>
              {managerSelectType === "owner" ? "Менеджер клиента" : "Исполнитель"}
            </ThemedText>
            <ScrollView>
              <Pressable
                onPress={() => handleManagerSelect(null)}
                style={[
                  styles.statusOption,
                  { backgroundColor: (managerSelectType === "owner" ? !ownerManager : !executorManager) ? theme.primary + "20" : "transparent" },
                ]}
              >
                <Icon name="user-x" size={20} color={theme.textSecondary} />
                <ThemedText style={[styles.statusOptionText, { color: theme.textSecondary }]}>
                  Не назначен
                </ThemedText>
                {(managerSelectType === "owner" ? !ownerManager : !executorManager) ? (
                  <Icon name="check" size={20} color={theme.primary} />
                ) : null}
              </Pressable>
              {managers.filter(m => m.role !== "admin").map(manager => {
                const isActive = managerSelectType === "owner"
                  ? client?.assignedManagerId === manager.id
                  : order?.executorId === manager.id;
                return (
                  <Pressable
                    key={manager.id}
                    onPress={() => handleManagerSelect(manager.id)}
                    style={[
                      styles.statusOption,
                      { backgroundColor: isActive ? theme.primary + "20" : "transparent" },
                    ]}
                  >
                    <Icon name="user" size={20} color={theme.primary} />
                    <ThemedText style={[styles.statusOptionText, { color: theme.text }]}>
                      {manager.display_name}
                    </ThemedText>
                    {isActive ? (
                      <Icon name="check" size={20} color={theme.primary} />
                    ) : null}
                  </Pressable>
                );
              })}
            </ScrollView>
          </View>
        </Pressable>
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
  orderHeaderRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "flex-start",
  },
  orderNumber: {
    fontSize: 20,
    fontWeight: "700",
  },
  totalPrice: {
    fontSize: 24,
    fontWeight: "700",
    marginTop: Spacing.xs,
  },
  statusBadge: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.md,
    gap: Spacing.xs,
  },
  statusText: {
    fontSize: 13,
    fontWeight: "600",
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
    marginBottom: Spacing.sm,
  },
  addBtn: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.md,
    gap: Spacing.xs,
  },
  clientRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
  },
  clientAvatar: {
    width: 44,
    height: 44,
    borderRadius: 22,
    justifyContent: "center",
    alignItems: "center",
  },
  avatarText: {
    color: "#fff",
    fontSize: 16,
    fontWeight: "600",
  },
  clientInfo: {
    flex: 1,
  },
  clientName: {
    fontSize: 16,
    fontWeight: "600",
  },
  clientPhone: {
    fontSize: 14,
    marginTop: 2,
  },
  infoGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.sm,
  },
  infoItem: {
    width: "31%",
    marginBottom: Spacing.xs,
  },
  infoLabel: {
    fontSize: 12,
  },
  infoValue: {
    fontSize: 15,
    fontWeight: "600",
  },
  notesBox: {
    flexDirection: "row",
    alignItems: "flex-start",
    gap: Spacing.sm,
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
    marginTop: Spacing.sm,
  },
  notesText: {
    flex: 1,
    fontSize: 13,
  },
  paymentsList: {
    gap: Spacing.sm,
    marginBottom: Spacing.sm,
  },
  paymentItem: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "flex-start",
    paddingLeft: Spacing.sm,
    borderLeftWidth: 3,
  },
  paymentInfo: {
    flex: 1,
  },
  paymentLabel: {
    fontSize: 14,
    fontWeight: "500",
  },
  paymentDate: {
    fontSize: 12,
    marginTop: 2,
  },
  paymentNotes: {
    fontSize: 12,
    marginTop: 2,
  },
  paymentAmount: {
    fontSize: 15,
    fontWeight: "600",
  },
  summaryRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
    marginTop: Spacing.xs,
  },
  historyList: {
    gap: Spacing.sm,
  },
  historyItem: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  historyDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    marginTop: 6,
  },
  historyContent: {
    flex: 1,
  },
  historyAction: {
    fontSize: 14,
  },
  historyMeta: {
    fontSize: 12,
    marginTop: 2,
  },
  deleteBtn: {
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
    justifyContent: "center",
    alignItems: "center",
    padding: Spacing.xl,
  },
  statusModalContent: {
    width: "100%",
    borderRadius: BorderRadius.lg,
    padding: Spacing.md,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "600",
    marginBottom: Spacing.md,
    textAlign: "center",
  },
  statusOption: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
    marginBottom: Spacing.xs,
  },
  statusOptionText: {
    flex: 1,
    fontSize: 15,
    fontWeight: "500",
  },
  paymentModalContent: {
    width: "100%",
    maxHeight: "70%",
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
  paymentModalScroll: {
    padding: Spacing.md,
  },
  inputLabel: {
    fontSize: 13,
    marginBottom: Spacing.xs,
  },
  paymentTypeRow: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.xs,
  },
  paymentTypeBtn: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.md,
  },
  input: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    fontSize: 16,
  },
  savePaymentBtn: {
    marginTop: Spacing.lg,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.md,
    alignItems: "center",
    marginBottom: Spacing.xl,
  },
  managerRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.sm,
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
  },
  managerLabel: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  managerLabelText: {
    fontSize: 13,
  },
  managerValue: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
  },
  managerName: {
    fontSize: 14,
    fontWeight: "500",
  },
});
