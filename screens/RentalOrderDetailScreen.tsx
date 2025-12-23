import { useState, useMemo } from "react";
import {
  View,
  StyleSheet,
  Pressable,
  Alert,
  TextInput,
  Modal,
  ScrollView,
  KeyboardAvoidingView,
  Platform,
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
import { useData, EquipmentItem } from "@/contexts/DataContext";
import { useCompanySettings } from "@/contexts/CompanySettingsContext";
import { useDocumentTemplates } from "@/contexts/DocumentTemplatesContext";
import { generateAndShareDocument, DocumentType } from "@/utils/documents";
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
  const { rentalOrders, rentalClients, rentalOrderServices, updateRentalOrder, updateRentalClient, updateOrderStatus, addRentalPayment, getOrderPayments, getOrderHistory, deleteRentalOrder } = useRental();
  const { managers, isAdmin } = useAuth();
  const { equipmentItems, equipmentCategories, addEquipmentMovement, addEquipmentLoss } = useData();
  const { settings: companySettings, getNextDocumentNumber } = useCompanySettings();
  const { getDefaultTemplate, getTemplatesByType } = useDocumentTemplates();

  const orderId = route.params?.orderId;
  const order = rentalOrders.find(o => o.id === orderId);
  const client = order ? rentalClients.find(c => c.id === order.clientId) : null;
  const payments = order ? getOrderPayments(order.id) : [];
  const rawHistory = order ? getOrderHistory(order.id) : [];
  const history = rawHistory.filter(h => !h.action.startsWith("Начислены комиссии"));

  const ownerManager = order?.ownerManagerId ? managers.find(m => m.id === order.ownerManagerId) : null;
  const executorManager = order?.executorId ? managers.find(m => m.id === order.executorId) : null;
  const orderServices = order ? rentalOrderServices.filter(s => s.orderId === order.id) : [];
  const servicesTotal = orderServices.reduce((sum, s) => sum + s.price * s.quantity, 0);
  const equipmentPrice = order ? order.totalPrice - servicesTotal : 0;

  const [showStatusModal, setShowStatusModal] = useState(false);
  const [showPaymentModal, setShowPaymentModal] = useState(false);
  const [showManagerModal, setShowManagerModal] = useState(false);
  const [managerSelectType, setManagerSelectType] = useState<ManagerSelectType>("owner");
  const [paymentType, setPaymentType] = useState<RentalPaymentType>("prepayment");
  const [paymentMethod, setPaymentMethod] = useState<"cash" | "card" | "transfer">("cash");
  const [paymentAmount, setPaymentAmount] = useState("");
  const [paymentNotes, setPaymentNotes] = useState("");

  // Loss tracking states
  const [showLossModal, setShowLossModal] = useState(false);
  const [selectedLossItem, setSelectedLossItem] = useState<EquipmentItem | null>(null);
  const [lossCount, setLossCount] = useState("");
  const [lossReason, setLossReason] = useState("");
  
  // Loading state for status change
  const [isChangingStatus, setIsChangingStatus] = useState(false);
  
  // Document generation state
  const [isGeneratingDoc, setIsGeneratingDoc] = useState(false);
  const [showTemplateModal, setShowTemplateModal] = useState(false);
  const [pendingDocType, setPendingDocType] = useState<DocumentType | null>(null);

  // Get equipment items that can be tracked for loss based on order contents
  // For rentals: receivers = kitCount, transmitters = microphoneCount
  const trackableLossItems = useMemo(() => {
    if (!order) return [];
    
    // Filter items that are trackable and have quantity in this order
    return equipmentItems.filter(item => {
      if (!item.trackLoss) return false;
      
      const name = item.name.toLowerCase();
      // Receivers - limit by kitCount
      if (name.includes("приемник") || name.includes("receiver")) {
        return order.kitCount > 0;
      }
      // Transmitters - limit by microphoneCount
      if (name.includes("передатчик") || name.includes("transmitter") || name.includes("микрофон")) {
        return order.microphoneCount > 0;
      }
      // Other trackable items
      return true;
    });
  }, [equipmentItems, order]);

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
    if (!order || isChangingStatus) return;
    setIsChangingStatus(true);
    hapticFeedback.selection();
    try {
      await updateOrderStatus(order.id, status);
      setShowStatusModal(false);
      hapticFeedback.success();
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось изменить статус");
    } finally {
      setIsChangingStatus(false);
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
        method: paymentMethod,
        amount,
        notes: paymentNotes.trim() || null,
      });
      setShowPaymentModal(false);
      setPaymentAmount("");
      setPaymentNotes("");
      setPaymentMethod("cash");
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
    if (!order) return;
    hapticFeedback.selection();
    const selectedManager = managerId ? managers.find(m => m.id === managerId) : null;
    try {
      if (managerSelectType === "owner") {
        await updateRentalOrder(order.id, { 
          ownerManagerId: managerId,
          ownerManagerName: selectedManager?.display_name || null 
        });
      } else {
        await updateRentalOrder(order.id, { 
          executorId: managerId,
          executorName: selectedManager?.display_name || null 
        });
      }
      setShowManagerModal(false);
      hapticFeedback.success();
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось изменить менеджера");
    }
  };

  // Calculate max loss count based on equipment type and order contents
  const getMaxLossCount = (item: EquipmentItem): number => {
    if (!order) return 0;
    const name = item.name.toLowerCase();
    
    // Receivers - limit by kitCount
    if (name.includes("приемник") || name.includes("receiver")) {
      return order.kitCount;
    }
    // Transmitters - limit by microphoneCount
    if (name.includes("передатчик") || name.includes("transmitter") || name.includes("микрофон")) {
      return order.microphoneCount;
    }
    // For other items, use warehouse quantity as max
    return item.quantity;
  };

  const handleAddLoss = async () => {
    if (!order || !selectedLossItem) return;
    
    const count = parseInt(lossCount);
    if (!count || count <= 0) {
      Alert.alert("Ошибка", "Введите количество утерянного оборудования");
      return;
    }
    
    // Validate count against order contents
    const maxCount = getMaxLossCount(selectedLossItem);
    if (count > maxCount) {
      Alert.alert("Ошибка", `Максимальное количество для утери: ${maxCount} шт.`);
      return;
    }
    
    // Validate count against warehouse quantity
    if (count > selectedLossItem.quantity) {
      Alert.alert("Ошибка", `На складе доступно только ${selectedLossItem.quantity} шт.`);
      return;
    }
    
    if (!lossReason.trim()) {
      Alert.alert("Ошибка", "Укажите причину утери");
      return;
    }
    
    hapticFeedback.selection();
    
    try {
      // Record loss movement on warehouse
      await addEquipmentMovement({
        itemId: selectedLossItem.id,
        type: 'loss',
        quantity: count,
        note: `Утеря из аренды #${order.orderNumber}. Клиент: ${order.clientName || client?.name || "Не указан"}. Причина: ${lossReason.trim()}`,
      });
      
      // Record in equipment_losses for tracking
      await addEquipmentLoss({
        assignmentId: null,
        kitId: null,
        guideName: order.clientName || client?.name || "Клиент аренды",
        missingCount: count,
        reason: lossReason.trim(),
        equipmentItemId: selectedLossItem.id,
        rentalOrderId: order.id,
      });
      
      setShowLossModal(false);
      setSelectedLossItem(null);
      setLossCount("");
      setLossReason("");
      hapticFeedback.success();
      Alert.alert("Успех", "Утеря оборудования зарегистрирована");
    } catch (error) {
      console.error("Error adding loss:", error);
      Alert.alert("Ошибка", "Не удалось зарегистрировать утерю");
    }
  };

  const handleDocumentButtonPress = (docType: DocumentType) => {
    if (!order || !client || !companySettings) {
      Alert.alert("Ошибка", "Заполните настройки компании перед созданием документов");
      return;
    }
    
    const templates = getTemplatesByType(docType);
    if (templates.length > 1) {
      setPendingDocType(docType);
      setShowTemplateModal(true);
    } else {
      handleGenerateDocument(docType, templates[0]?.htmlContent);
    }
  };

  const handleGenerateDocument = async (docType: DocumentType, templateHtml?: string) => {
    if (!order || !client || !companySettings) {
      Alert.alert("Ошибка", "Заполните настройки компании перед созданием документов");
      return;
    }
    
    setIsGeneratingDoc(true);
    setShowTemplateModal(false);
    setPendingDocType(null);
    hapticFeedback.selection();
    
    try {
      const documentNumber = await getNextDocumentNumber(docType);
      
      await generateAndShareDocument({
        type: docType,
        order,
        client,
        services: orderServices,
        company: companySettings,
        documentNumber,
        templateHtml: templateHtml || getDefaultTemplate(docType)?.htmlContent,
      });
      
      hapticFeedback.success();
    } catch (error) {
      console.error("Error generating document:", error);
      hapticFeedback.error();
      Alert.alert("Ошибка", "Не удалось создать документ. Проверьте настройки реквизитов компании.");
    } finally {
      setIsGeneratingDoc(false);
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
            <View style={styles.headerActions}>
              <Pressable
                onPress={() => (navigation as any).navigate("AddRentalOrder", { orderId: order.id })}
                style={[styles.editButton, { backgroundColor: theme.primary + "20" }]}
              >
                <Icon name="edit-2" size={16} color={theme.primary} />
              </Pressable>
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
              <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>Комплектов</ThemedText>
              <ThemedText style={styles.infoValue}>
                {order.kitCount || 0}{(order.spareReceiverCount || 0) > 0 ? ` + ${order.spareReceiverCount}` : ""}
              </ThemedText>
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

        {order.equipmentBlocks && order.equipmentBlocks.length > 1 ? (
          <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
              Разбивка по сумкам
            </ThemedText>
            {order.equipmentBlocks.map((block, index) => (
              <View 
                key={index} 
                style={[
                  styles.equipmentBlockCard, 
                  { 
                    backgroundColor: theme.backgroundTertiary,
                    borderLeftColor: theme.primary,
                  }
                ]}
              >
                <View style={styles.equipmentBlockHeader}>
                  <Icon name="briefcase" size={16} color={theme.primary} />
                  <ThemedText style={[styles.equipmentBlockTitle, { color: theme.text }]}>
                    {block.bagNumber ? `Сумка ${block.bagNumber}` : `Блок ${index + 1}`}
                  </ThemedText>
                </View>
                <View style={styles.equipmentBlockGrid}>
                  <View style={styles.equipmentBlockItem}>
                    <ThemedText style={[styles.equipmentBlockValue, { color: theme.primary }]}>
                      {block.kitCount}
                    </ThemedText>
                    <ThemedText style={[styles.equipmentBlockLabel, { color: theme.textSecondary }]}>
                      компл.
                    </ThemedText>
                  </View>
                  {block.spareReceiverCount > 0 ? (
                    <View style={styles.equipmentBlockItem}>
                      <ThemedText style={[styles.equipmentBlockValue, { color: theme.text }]}>
                        {block.spareReceiverCount}
                      </ThemedText>
                      <ThemedText style={[styles.equipmentBlockLabel, { color: theme.textSecondary }]}>
                        запас.
                      </ThemedText>
                    </View>
                  ) : null}
                  <View style={styles.equipmentBlockItem}>
                    <ThemedText style={[styles.equipmentBlockValue, { color: theme.text }]}>
                      {block.transmitterCount}
                    </ThemedText>
                    <ThemedText style={[styles.equipmentBlockLabel, { color: theme.textSecondary }]}>
                      перед.
                    </ThemedText>
                  </View>
                  <View style={styles.equipmentBlockItem}>
                    <ThemedText style={[styles.equipmentBlockValue, { color: theme.text }]}>
                      {block.microphoneCount}
                    </ThemedText>
                    <ThemedText style={[styles.equipmentBlockLabel, { color: theme.textSecondary }]}>
                      микр.
                    </ThemedText>
                  </View>
                </View>
              </View>
            ))}
          </View>
        ) : null}

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            Стоимость
          </ThemedText>
          
          <View style={styles.priceRow}>
            <ThemedText style={{ color: theme.textSecondary }}>
              Оборудование ({order.kitCount} x {order.pricePerUnit.toLocaleString("ru-RU")}₽ x {order.daysCount} дн.)
            </ThemedText>
            <ThemedText style={{ fontWeight: "500" }}>
              {equipmentPrice.toLocaleString("ru-RU")}₽
            </ThemedText>
          </View>

          {orderServices.length > 0 ? (
            <View style={styles.servicesSection}>
              {orderServices.map(service => (
                <View key={service.id} style={styles.priceRow}>
                  <ThemedText style={{ color: theme.textSecondary }}>
                    {service.serviceName} x {service.quantity}
                  </ThemedText>
                  <ThemedText style={{ fontWeight: "500" }}>
                    {(service.price * service.quantity).toLocaleString("ru-RU")}₽
                  </ThemedText>
                </View>
              ))}
              <View style={[styles.priceRow, { marginTop: Spacing.xs }]}>
                <ThemedText style={{ color: theme.textSecondary }}>Услуги:</ThemedText>
                <ThemedText style={{ fontWeight: "500", color: theme.success }}>
                  +{servicesTotal.toLocaleString("ru-RU")}₽
                </ThemedText>
              </View>
            </View>
          ) : null}

          <View style={[styles.totalPriceRow, { borderTopColor: theme.border }]}>
            <ThemedText style={styles.totalLabel}>Итого:</ThemedText>
            <ThemedText style={[styles.totalValue, { color: theme.success }]}>
              {order.totalPrice.toLocaleString("ru-RU")}₽
            </ThemedText>
          </View>

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

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            Документы
          </ThemedText>
          <View style={styles.documentsGrid}>
            <Pressable
              onPress={() => handleDocumentButtonPress("invoice")}
              disabled={isGeneratingDoc}
              style={[styles.documentBtn, { backgroundColor: theme.primary + "15", opacity: isGeneratingDoc ? 0.5 : 1 }]}
            >
              <Icon name="file-text" size={20} color={theme.primary} />
              <ThemedText style={[styles.documentBtnText, { color: theme.primary }]}>Счёт</ThemedText>
            </Pressable>
            <Pressable
              onPress={() => handleDocumentButtonPress("act")}
              disabled={isGeneratingDoc}
              style={[styles.documentBtn, { backgroundColor: theme.success + "15", opacity: isGeneratingDoc ? 0.5 : 1 }]}
            >
              <Icon name="check-square" size={20} color={theme.success} />
              <ThemedText style={[styles.documentBtnText, { color: theme.success }]}>Акт</ThemedText>
            </Pressable>
            <Pressable
              onPress={() => handleDocumentButtonPress("contract")}
              disabled={isGeneratingDoc}
              style={[styles.documentBtn, { backgroundColor: "#9C27B0" + "15", opacity: isGeneratingDoc ? 0.5 : 1 }]}
            >
              <Icon name="file" size={20} color="#9C27B0" />
              <ThemedText style={[styles.documentBtnText, { color: "#9C27B0" }]}>Договор</ThemedText>
            </Pressable>
            <Pressable
              onPress={() => handleDocumentButtonPress("waybill")}
              disabled={isGeneratingDoc}
              style={[styles.documentBtn, { backgroundColor: theme.warning + "15", opacity: isGeneratingDoc ? 0.5 : 1 }]}
            >
              <Icon name="truck" size={20} color={theme.warning} />
              <ThemedText style={[styles.documentBtnText, { color: theme.warning }]}>Накладная</ThemedText>
            </Pressable>
          </View>
        </View>

        {(order.status === "issued" || order.status === "returned") && trackableLossItems.length > 0 ? (
          <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
            <View style={styles.sectionHeader}>
              <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
                Утеря оборудования
              </ThemedText>
            </View>
            <Pressable
              onPress={() => setShowLossModal(true)}
              style={[styles.lossButton, { backgroundColor: theme.error + "15", borderColor: theme.error }]}
            >
              <Icon name="alert-triangle" size={18} color={theme.error} />
              <ThemedText style={{ color: theme.error, fontWeight: "500" }}>
                Зарегистрировать утерю
              </ThemedText>
            </Pressable>
          </View>
        ) : null}

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
                  disabled={isChangingStatus}
                  style={[
                    styles.statusOption,
                    { 
                      backgroundColor: isActive ? config.color + "20" : "transparent",
                      opacity: isChangingStatus ? 0.5 : 1,
                    },
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
                Способ оплаты
              </ThemedText>
              <View style={styles.paymentTypeRow}>
                {([
                  { key: 'cash' as const, label: 'Наличные', icon: 'dollar-sign' },
                  { key: 'card' as const, label: 'Карта', icon: 'credit-card' },
                  { key: 'transfer' as const, label: 'Перевод', icon: 'send' },
                ]).map(method => {
                  const isActive = paymentMethod === method.key;
                  return (
                    <Pressable
                      key={method.key}
                      onPress={() => setPaymentMethod(method.key)}
                      style={[
                        styles.paymentTypeBtn,
                        { backgroundColor: isActive ? theme.primary + "20" : theme.backgroundSecondary },
                      ]}
                    >
                      <Icon name={method.icon as any} size={14} color={isActive ? theme.primary : theme.textSecondary} />
                      <ThemedText style={{ color: isActive ? theme.primary : theme.textSecondary, fontSize: 12 }}>
                        {method.label}
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
              {managers.map(manager => {
                const isActive = managerSelectType === "owner"
                  ? order?.ownerManagerId === manager.id
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

      <Modal visible={showLossModal} animationType="slide" transparent>
        <KeyboardAvoidingView 
          behavior={Platform.OS === "ios" ? "padding" : "height"}
          style={{ flex: 1, justifyContent: "flex-end" }}
        >
          <View style={[styles.modalOverlay, { justifyContent: "flex-end", flex: 1 }]}>
            <View style={[styles.paymentModalContent, { backgroundColor: theme.backgroundDefault }]}>
              <View style={styles.modalHeader}>
                <ThemedText style={styles.modalTitle}>Зарегистрировать утерю</ThemedText>
                <Pressable onPress={() => {
                  setShowLossModal(false);
                  setSelectedLossItem(null);
                  setLossCount("");
                  setLossReason("");
                }}>
                  <Icon name="x" size={24} color={theme.text} />
                </Pressable>
              </View>

              <ScrollView style={styles.paymentModalScroll} keyboardShouldPersistTaps="handled">
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Тип оборудования
              </ThemedText>
              <View style={styles.lossItemsGrid}>
                {trackableLossItems.map(item => {
                  const category = equipmentCategories.find(c => c.id === item.categoryId);
                  const isActive = selectedLossItem?.id === item.id;
                  return (
                    <Pressable
                      key={item.id}
                      onPress={() => setSelectedLossItem(item)}
                      style={[
                        styles.lossItemBtn,
                        { 
                          backgroundColor: isActive ? theme.error + "20" : theme.backgroundSecondary,
                          borderColor: isActive ? theme.error : theme.border,
                        },
                      ]}
                    >
                      <ThemedText style={{ color: isActive ? theme.error : theme.text, fontSize: 13 }}>
                        {item.name}
                      </ThemedText>
                      <ThemedText style={{ color: theme.textSecondary, fontSize: 11 }}>
                        Макс.: {getMaxLossCount(item)} шт.
                      </ThemedText>
                    </Pressable>
                  );
                })}
              </View>

              {selectedLossItem ? (
                <>
                  <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>
                    Количество утерянных (макс. {getMaxLossCount(selectedLossItem)})
                  </ThemedText>
                  <TextInput
                    value={lossCount}
                    onChangeText={setLossCount}
                    style={[styles.textInput, { backgroundColor: theme.backgroundSecondary, color: theme.text, borderColor: theme.border }]}
                    placeholder={`Максимум: ${getMaxLossCount(selectedLossItem)}`}
                    placeholderTextColor={theme.textSecondary}
                    keyboardType="numeric"
                  />

                  <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>
                    Причина утери
                  </ThemedText>
                  <TextInput
                    value={lossReason}
                    onChangeText={setLossReason}
                    style={[styles.textInput, styles.textArea, { backgroundColor: theme.backgroundSecondary, color: theme.text, borderColor: theme.border }]}
                    placeholder="Опишите причину"
                    placeholderTextColor={theme.textSecondary}
                    multiline
                    numberOfLines={3}
                  />
                </>
              ) : null}
            </ScrollView>

            <Pressable
              onPress={handleAddLoss}
              style={[
                styles.submitBtn,
                { 
                  backgroundColor: selectedLossItem && lossCount && lossReason.trim() ? theme.error : theme.border,
                  marginBottom: insets.bottom + Spacing.md,
                },
              ]}
              disabled={!selectedLossItem || !lossCount || !lossReason.trim()}
            >
              <ThemedText style={{ color: "#fff", fontWeight: "600" }}>
                Зарегистрировать утерю
              </ThemedText>
              </Pressable>
            </View>
          </View>
        </KeyboardAvoidingView>
      </Modal>

      <Modal visible={showTemplateModal} animationType="fade" transparent>
        <Pressable 
          style={styles.modalOverlay} 
          onPress={() => {
            setShowTemplateModal(false);
            setPendingDocType(null);
          }}
        >
          <View style={[styles.statusModalContent, { backgroundColor: theme.backgroundDefault }]}>
            <ThemedText style={styles.modalTitle}>Выберите шаблон</ThemedText>
            <ScrollView style={{ maxHeight: 300 }}>
              {pendingDocType ? getTemplatesByType(pendingDocType).map(template => (
                <Pressable
                  key={template.id}
                  onPress={() => handleGenerateDocument(pendingDocType, template.htmlContent)}
                  style={[
                    styles.statusOption,
                    { 
                      backgroundColor: template.isDefault ? theme.primary + "15" : "transparent",
                      borderColor: template.isDefault ? theme.primary : theme.border 
                    },
                  ]}
                >
                  <View style={styles.templateOption}>
                    <Icon name={template.isDefault ? "star" : "file-text"} size={18} color={template.isDefault ? theme.primary : theme.text} />
                    <View style={{ flex: 1 }}>
                      <ThemedText style={{ fontWeight: template.isDefault ? "600" : "400" }}>
                        {template.name}
                      </ThemedText>
                      {template.isDefault ? (
                        <ThemedText style={{ fontSize: 12, color: theme.textSecondary }}>
                          По умолчанию
                        </ThemedText>
                      ) : null}
                    </View>
                    <Icon name="chevron-right" size={18} color={theme.textSecondary} />
                  </View>
                </Pressable>
              )) : null}
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
  headerActions: {
    flexDirection: "row",
    alignItems: "flex-start",
    gap: Spacing.sm,
  },
  editButton: {
    width: 36,
    height: 36,
    borderRadius: BorderRadius.md,
    justifyContent: "center",
    alignItems: "center",
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
  priceRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingVertical: Spacing.xs,
  },
  servicesSection: {
    marginTop: Spacing.xs,
    paddingTop: Spacing.xs,
  },
  totalPriceRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginTop: Spacing.sm,
    paddingTop: Spacing.sm,
    borderTopWidth: StyleSheet.hairlineWidth,
  },
  profitSection: {
    marginTop: Spacing.sm,
    paddingTop: Spacing.sm,
    borderTopWidth: StyleSheet.hairlineWidth,
    gap: Spacing.xs,
  },
  totalLabel: {
    fontSize: 16,
    fontWeight: "600",
  },
  totalValue: {
    fontSize: 20,
    fontWeight: "700",
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
  templateOption: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    flex: 1,
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
  lossButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
  },
  lossItemsGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.sm,
  },
  lossItemBtn: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    minWidth: 100,
  },
  textInput: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    fontSize: 15,
  },
  textArea: {
    minHeight: 80,
    textAlignVertical: "top",
  },
  submitBtn: {
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.md,
    alignItems: "center",
    marginHorizontal: Spacing.md,
  },
  equipmentBlockCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.sm,
    borderLeftWidth: 3,
  },
  equipmentBlockHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    marginBottom: Spacing.sm,
  },
  equipmentBlockTitle: {
    fontSize: 14,
    fontWeight: "600",
  },
  equipmentBlockGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.md,
  },
  equipmentBlockItem: {
    alignItems: "center",
    minWidth: 50,
  },
  equipmentBlockValue: {
    fontSize: 18,
    fontWeight: "700",
  },
  equipmentBlockLabel: {
    fontSize: 11,
    marginTop: 2,
  },
  documentsGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.sm,
  },
  documentBtn: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    flex: 1,
    minWidth: 140,
  },
  documentBtnText: {
    fontSize: 14,
    fontWeight: "500",
  },
});
