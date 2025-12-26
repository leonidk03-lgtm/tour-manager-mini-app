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
  KeyboardAvoidingView,
  ScrollView,
} from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { useNavigation, useRoute, RouteProp, NavigationProp } from "@react-navigation/native";
import * as Clipboard from "expo-clipboard";
import * as Sharing from "expo-sharing";
import DateTimePicker from "@react-native-community/datetimepicker";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useRental, RentalOrder, RentalOrderStatus, RentalPaymentMethod } from "@/contexts/RentalContext";
import { useAuth } from "@/contexts/AuthContext";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";
import { hapticFeedback } from "@/utils/haptics";
import { normalizePhoneNumber } from "@/utils/calculations";
import { useCompanySettings } from "@/contexts/CompanySettingsContext";
import { useDocumentTemplates, DocumentTemplate } from "@/contexts/DocumentTemplatesContext";
import { generateAndShareDocument, DocumentType } from "@/utils/documents";

type RouteParams = RouteProp<SettingsStackParamList, "RentalClientDetail">;

const STATUS_CONFIG: Record<RentalOrderStatus, { label: string; color: string }> = {
  new: { label: "Новый", color: "#2196F3" },
  issued: { label: "Выдан", color: "#4CAF50" },
  returned: { label: "Возвращён", color: "#FF9800" },
  completed: { label: "Завершён", color: "#9C27B0" },
  cancelled: { label: "Отменён", color: "#F44336" },
};

const PAYMENT_METHODS: { value: RentalPaymentMethod; label: string }[] = [
  { value: "cash", label: "Наличные" },
  { value: "card", label: "Карта" },
  { value: "transfer", label: "Перевод" },
];

export default function RentalClientDetailScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<SettingsStackParamList>>();
  const route = useRoute<RouteParams>();
  const insets = useSafeAreaInsets();
  const { 
    rentalClients, 
    rentalOrders, 
    rentalOrderServices,
    rentalPayments,
    updateRentalClient, 
    deleteRentalClient,
    getClientUnpaidOrders,
    getOrderRemainingAmount,
    bulkPayOrders,
  } = useRental();
  const { managers } = useAuth();
  const { settings: companySettings, getNextDocumentNumber } = useCompanySettings();
  const { getTemplatesByType, getDefaultTemplate } = useDocumentTemplates();

  const clientId = route.params?.clientId;
  const client = rentalClients.find(c => c.id === clientId);

  const [showEditModal, setShowEditModal] = useState(false);
  const [showManagerModal, setShowManagerModal] = useState(false);
  const [showBulkPaymentModal, setShowBulkPaymentModal] = useState(false);
  const [showReconciliationModal, setShowReconciliationModal] = useState(false);
  const [editName, setEditName] = useState(client?.name || "");
  const [editPhone, setEditPhone] = useState(client?.phone || "");
  const [editEmail, setEditEmail] = useState(client?.email || "");
  const [editDefaultPrice, setEditDefaultPrice] = useState(client?.defaultPrice?.toString() || "100");
  const [editNotes, setEditNotes] = useState(client?.notes || "");
  const [editType, setEditType] = useState<"individual" | "company">(client?.type || "individual");
  const [editDirectorName, setEditDirectorName] = useState(client?.directorName || "");
  const [editCeoName, setEditCeoName] = useState(client?.ceoName || "");
  const [editCompanyName, setEditCompanyName] = useState(client?.companyName || "");
  const [editLegalAddress, setEditLegalAddress] = useState(client?.legalAddress || "");
  const [editInn, setEditInn] = useState(client?.inn || "");
  const [editKpp, setEditKpp] = useState(client?.kpp || "");

  const [selectedOrderIds, setSelectedOrderIds] = useState<string[]>([]);
  const [bulkPaymentMethod, setBulkPaymentMethod] = useState<RentalPaymentMethod>("cash");
  const [bulkPaymentNotes, setBulkPaymentNotes] = useState("");
  const [isBulkPaymentProcessing, setIsBulkPaymentProcessing] = useState(false);

  const [reconciliationStartDate, setReconciliationStartDate] = useState<Date | null>(null);
  const [reconciliationEndDate, setReconciliationEndDate] = useState<Date | null>(null);
  const [showStartDatePicker, setShowStartDatePicker] = useState(false);
  const [showEndDatePicker, setShowEndDatePicker] = useState(false);
  const [isGeneratingDoc, setIsGeneratingDoc] = useState(false);
  const [showContractTemplateModal, setShowContractTemplateModal] = useState(false);

  const clientOrders = useMemo(() => {
    if (!client) return [];
    return rentalOrders.filter(o => o.clientId === client.id).sort((a, b) => 
      new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
    );
  }, [rentalOrders, client]);

  const unpaidOrders = useMemo(() => {
    if (!client) return [];
    return getClientUnpaidOrders(client.id);
  }, [client, getClientUnpaidOrders]);

  const filteredUnpaidOrders = useMemo(() => {
    let filtered = unpaidOrders;
    
    if (reconciliationStartDate) {
      const startOfDay = new Date(reconciliationStartDate);
      startOfDay.setHours(0, 0, 0, 0);
      filtered = filtered.filter(order => new Date(order.startDate) >= startOfDay);
    }
    
    if (reconciliationEndDate) {
      const endOfDay = new Date(reconciliationEndDate);
      endOfDay.setHours(23, 59, 59, 999);
      filtered = filtered.filter(order => new Date(order.startDate) <= endOfDay);
    }
    
    return filtered;
  }, [unpaidOrders, reconciliationStartDate, reconciliationEndDate]);

  const stats = useMemo(() => {
    const totalOrders = clientOrders.length;
    
    const clientOrderIds = new Set(clientOrders.map(o => o.id));
    const paidRevenue = rentalPayments
      .filter(p => clientOrderIds.has(p.orderId) && p.type !== "refund" && p.type !== "service_expense")
      .reduce((sum, p) => sum + p.amount, 0);
    
    const upcomingRevenue = clientOrders
      .filter(o => o.status === "new")
      .reduce((sum, o) => sum + o.totalPrice, 0);
    
    const activeOrders = clientOrders.filter(o => o.status === "issued").length;
    return { totalOrders, paidRevenue, upcomingRevenue, activeOrders };
  }, [clientOrders, rentalPayments]);

  const selectedOrdersTotal = useMemo(() => {
    return selectedOrderIds.reduce((sum, orderId) => {
      return sum + getOrderRemainingAmount(orderId);
    }, 0);
  }, [selectedOrderIds, getOrderRemainingAmount]);

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
        directorName: editDirectorName.trim() || null,
        ceoName: editCeoName.trim() || null,
        companyName: editCompanyName.trim() || null,
        legalAddress: editLegalAddress.trim() || null,
        inn: editInn.trim() || null,
        kpp: editKpp.trim() || null,
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

  const handleSelectManager = async (managerId: string | null) => {
    if (!client) return;
    hapticFeedback.selection();
    try {
      await updateRentalClient(client.id, { assignedManagerId: managerId });
      setShowManagerModal(false);
      hapticFeedback.success();
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось назначить менеджера");
    }
  };

  const handleOpenBulkPaymentModal = () => {
    setSelectedOrderIds([]);
    setBulkPaymentMethod("cash");
    setBulkPaymentNotes("");
    setShowBulkPaymentModal(true);
  };

  const handleToggleOrderSelection = (orderId: string) => {
    hapticFeedback.selection();
    setSelectedOrderIds(prev => 
      prev.includes(orderId)
        ? prev.filter(id => id !== orderId)
        : [...prev, orderId]
    );
  };

  const handleSelectAllOrders = () => {
    hapticFeedback.selection();
    if (selectedOrderIds.length === unpaidOrders.length) {
      setSelectedOrderIds([]);
    } else {
      setSelectedOrderIds(unpaidOrders.map(o => o.id));
    }
  };

  const handleBulkPayment = async () => {
    if (!client || selectedOrderIds.length === 0) return;

    setIsBulkPaymentProcessing(true);
    hapticFeedback.selection();

    try {
      const result = await bulkPayOrders(
        client.id,
        selectedOrderIds,
        bulkPaymentMethod,
        bulkPaymentNotes.trim() || undefined
      );

      setShowBulkPaymentModal(false);
      hapticFeedback.success();

      Alert.alert(
        "Оплата успешна",
        `Оплачено ${result.successCount} заказов на сумму ${result.totalAmount.toLocaleString("ru-RU")}₽`
      );
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось выполнить оплату");
    } finally {
      setIsBulkPaymentProcessing(false);
    }
  };

  const annualContractTemplates = useMemo(() => {
    return getTemplatesByType('contract_annual');
  }, [getTemplatesByType]);

  const handleContractButtonPress = () => {
    if (!client || !companySettings) {
      Alert.alert("Ошибка", "Заполните настройки компании перед созданием документов");
      return;
    }
    
    if (annualContractTemplates.length > 1) {
      setShowContractTemplateModal(true);
    } else {
      handleGenerateContract(annualContractTemplates[0]?.htmlContent);
    }
  };

  const handleGenerateContract = async (templateHtml?: string) => {
    if (!client || !companySettings) {
      Alert.alert("Ошибка", "Заполните настройки компании перед созданием документов");
      return;
    }
    
    setIsGeneratingDoc(true);
    setShowContractTemplateModal(false);
    hapticFeedback.selection();
    
    try {
      const documentNumber = await getNextDocumentNumber('contract_annual');
      
      const dummyOrder: RentalOrder = {
        id: 'annual-contract',
        orderNumber: 0,
        clientId: client.id,
        clientName: client.name,
        clientPhone: client.phone || undefined,
        status: 'new',
        startDate: new Date().toISOString(),
        endDate: new Date(Date.now() + 365 * 24 * 60 * 60 * 1000).toISOString(),
        daysCount: 365,
        kitCount: 0,
        spareReceiverCount: 0,
        transmitterCount: 0,
        microphoneCount: 0,
        bagNumber: null,
        isCharged: false,
        pricePerUnit: client.defaultPrice || 100,
        totalPrice: 0,
        prepayment: 0,
        receiverNotes: null,
        managerId: null,
        managerName: null,
        executorId: null,
        executorName: null,
        ownerManagerId: null,
        ownerManagerName: null,
        equipmentBlocks: null,
        createdAt: new Date().toISOString(),
        updatedAt: new Date().toISOString(),
      };
      
      await generateAndShareDocument({
        type: 'contract_annual',
        order: dummyOrder as any,
        client,
        company: companySettings,
        documentNumber,
        templateHtml: templateHtml || getDefaultTemplate('contract_annual')?.htmlContent,
      });
      
      hapticFeedback.success();
    } catch (error) {
      console.error("Error generating contract:", error);
      hapticFeedback.error();
      Alert.alert("Ошибка", "Не удалось создать договор. Проверьте настройки реквизитов компании.");
    } finally {
      setIsGeneratingDoc(false);
    }
  };

  const generateReconciliationReport = (): string => {
    if (!client) return "";

    const lines: string[] = [];
    lines.push(`СВЕРКА: ${client.name}`);
    lines.push(`Дата: ${formatDate(new Date().toISOString())}`);
    
    if (reconciliationStartDate || reconciliationEndDate) {
      const periodStart = reconciliationStartDate ? formatDate(reconciliationStartDate.toISOString()) : "...";
      const periodEnd = reconciliationEndDate ? formatDate(reconciliationEndDate.toISOString()) : "...";
      lines.push(`Период: ${periodStart} - ${periodEnd}`);
    }
    
    lines.push("");
    lines.push("НЕОПЛАЧЕННЫЕ ЗАКАЗЫ:");
    lines.push("─".repeat(40));

    let total = 0;

    filteredUnpaidOrders.forEach((order, index) => {
      const remaining = getOrderRemainingAmount(order.id);
      total += remaining;

      lines.push(`${index + 1}. Заказ #${order.orderNumber}`);
      lines.push(`   ${formatDate(order.startDate)} - ${formatDate(order.endDate)}`);
      
      if (order.receiverNotes && order.receiverNotes.trim()) {
        lines.push(`   Комментарий: ${order.receiverNotes.trim()}`);
      }
      
      const equipment: string[] = [];
      if (order.kitCount > 0) equipment.push(`Комплекты: ${order.kitCount}`);
      if (order.spareReceiverCount > 0) equipment.push(`Зап. приёмники: ${order.spareReceiverCount}`);
      if (order.transmitterCount > 0) equipment.push(`Передатчики: ${order.transmitterCount}`);
      if (order.microphoneCount > 0) equipment.push(`Микрофоны: ${order.microphoneCount}`);
      
      if (equipment.length > 0) {
        lines.push(`   ${equipment.join(", ")}`);
      }

      const orderServices = rentalOrderServices.filter(s => s.orderId === order.id);
      if (orderServices.length > 0) {
        lines.push(`   Услуги: ${orderServices.map(s => `${s.serviceName} x${s.quantity}`).join(", ")}`);
      }

      lines.push(`   К оплате: ${remaining.toLocaleString("ru-RU")}₽`);
      lines.push("");
    });

    lines.push("─".repeat(40));
    lines.push(`ИТОГО К ОПЛАТЕ: ${total.toLocaleString("ru-RU")}₽`);

    return lines.join("\n");
  };

  const handleCopyReconciliation = async () => {
    const report = generateReconciliationReport();
    await Clipboard.setStringAsync(report);
    hapticFeedback.success();
    Alert.alert("Скопировано", "Отчёт сверки скопирован в буфер обмена");
  };

  const handleShareReconciliation = async () => {
    const report = generateReconciliationReport();
    
    if (!(await Sharing.isAvailableAsync())) {
      Alert.alert("Ошибка", "Функция не доступна на данном устройстве");
      return;
    }

    try {
      const fileName = `reconciliation_${client?.name.replace(/\s+/g, "_")}_${Date.now()}.txt`;
      const fileUri = `${Platform.OS === "ios" ? "" : "file://"}${fileName}`;
      
      await Clipboard.setStringAsync(report);
      hapticFeedback.success();
      Alert.alert("Отчёт готов", "Текст скопирован в буфер обмена. Вставьте в любое приложение для отправки.");
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось поделиться отчётом");
    }
  };

  const assignedManager = client?.assignedManagerId 
    ? managers.find(m => m.id === client.assignedManagerId) 
    : null;

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

  const totalUnpaidAmount = useMemo(() => {
    return filteredUnpaidOrders.reduce((sum, order) => sum + getOrderRemainingAmount(order.id), 0);
  }, [filteredUnpaidOrders, getOrderRemainingAmount]);

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
            <Pressable onPress={() => {
              setEditName(client.name);
              setEditPhone(client.phone || "");
              setEditEmail(client.email || "");
              setEditDefaultPrice(client.defaultPrice?.toString() || "100");
              setEditNotes(client.notes || "");
              setEditType(client.type);
              setEditDirectorName(client.directorName || "");
              setEditCeoName(client.ceoName || "");
              setEditLegalAddress(client.legalAddress || "");
              setEditInn(client.inn || "");
              setEditKpp(client.kpp || "");
              setShowEditModal(true);
            }}>
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

          {client.type === "company" && (client.directorName || client.ceoName || client.companyName || client.legalAddress || client.inn) ? (
            <View style={[styles.requisitesBox, { backgroundColor: theme.backgroundTertiary }]}>
              {client.directorName ? (
                <View style={styles.requisiteRow}>
                  <ThemedText style={[styles.requisiteLabel, { color: theme.textSecondary }]}>Контактное лицо:</ThemedText>
                  <ThemedText style={styles.requisiteValue}>{client.directorName}</ThemedText>
                </View>
              ) : null}
              {client.companyName ? (
                <View style={styles.requisiteRow}>
                  <ThemedText style={[styles.requisiteLabel, { color: theme.textSecondary }]}>Компания:</ThemedText>
                  <ThemedText style={[styles.requisiteValue, { flex: 1 }]} numberOfLines={2}>{client.companyName}</ThemedText>
                </View>
              ) : null}
              {client.ceoName ? (
                <View style={styles.requisiteRow}>
                  <ThemedText style={[styles.requisiteLabel, { color: theme.textSecondary }]}>Директор:</ThemedText>
                  <ThemedText style={styles.requisiteValue}>{client.ceoName}</ThemedText>
                </View>
              ) : null}
              {client.inn ? (
                <View style={styles.requisiteRow}>
                  <ThemedText style={[styles.requisiteLabel, { color: theme.textSecondary }]}>ИНН:</ThemedText>
                  <ThemedText style={styles.requisiteValue}>{client.inn}</ThemedText>
                  {client.kpp ? (
                    <>
                      <ThemedText style={[styles.requisiteLabel, { color: theme.textSecondary, marginLeft: Spacing.md }]}>КПП:</ThemedText>
                      <ThemedText style={styles.requisiteValue}>{client.kpp}</ThemedText>
                    </>
                  ) : null}
                </View>
              ) : null}
              {client.legalAddress ? (
                <View style={styles.requisiteRow}>
                  <ThemedText style={[styles.requisiteLabel, { color: theme.textSecondary }]}>Адрес:</ThemedText>
                  <ThemedText style={[styles.requisiteValue, { flex: 1 }]} numberOfLines={2}>{client.legalAddress}</ThemedText>
                </View>
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

          <Pressable
            onPress={() => setShowManagerModal(true)}
            style={[styles.managerRow, { backgroundColor: theme.backgroundTertiary }]}
          >
            <View style={styles.managerInfo}>
              <Icon name="user" size={16} color={theme.primary} />
              <ThemedText style={{ color: theme.textSecondary }}>Менеджер:</ThemedText>
              <ThemedText style={{ color: assignedManager ? theme.text : theme.textSecondary, fontWeight: "500" }}>
                {assignedManager?.display_name || "Не назначен"}
              </ThemedText>
            </View>
            <Icon name="chevron-right" size={18} color={theme.textSecondary} />
          </Pressable>
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
                {stats.paidRevenue.toLocaleString("ru-RU")}₽
              </ThemedText>
              <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                Оплачено
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
          
          {stats.upcomingRevenue > 0 ? (
            <View style={[styles.upcomingRow, { backgroundColor: theme.backgroundTertiary }]}>
              <ThemedText style={{ color: theme.textSecondary }}>Предстоящие заказы:</ThemedText>
              <ThemedText style={[styles.upcomingValue, { color: "#2196F3" }]}>
                {stats.upcomingRevenue.toLocaleString("ru-RU")}₽
              </ThemedText>
            </View>
          ) : null}
          <View style={[styles.priceRow, { backgroundColor: theme.backgroundTertiary }]}>
            <ThemedText style={{ color: theme.textSecondary }}>Цена по умолчанию:</ThemedText>
            <ThemedText style={[styles.defaultPrice, { color: theme.primary }]}>
              {client.defaultPrice}₽
            </ThemedText>
          </View>

          {unpaidOrders.length > 0 ? (
            <View style={styles.bulkActionsRow}>
              <Pressable
                onPress={handleOpenBulkPaymentModal}
                style={[styles.bulkActionBtn, { backgroundColor: theme.success + "15" }]}
              >
                <Icon name="credit-card" size={18} color={theme.success} />
                <ThemedText style={{ color: theme.success, fontSize: 13, fontWeight: "500" }}>
                  Оплатить заказы
                </ThemedText>
              </Pressable>
              <Pressable
                onPress={() => setShowReconciliationModal(true)}
                style={[styles.bulkActionBtn, { backgroundColor: theme.primary + "15" }]}
              >
                <Icon name="file-text" size={18} color={theme.primary} />
                <ThemedText style={{ color: theme.primary, fontSize: 13, fontWeight: "500" }}>
                  Сверка
                </ThemedText>
              </Pressable>
            </View>
          ) : null}
        </View>

        {client.type === "company" ? (
          <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
              Документы
            </ThemedText>
            <Pressable
              onPress={handleContractButtonPress}
              disabled={isGeneratingDoc}
              style={[styles.contractBtn, { backgroundColor: "#9C27B0" + "15", opacity: isGeneratingDoc ? 0.5 : 1 }]}
            >
              <Icon name="file" size={20} color="#9C27B0" />
              <ThemedText style={{ color: "#9C27B0", fontWeight: "500" }}>
                Годовой договор
              </ThemedText>
            </Pressable>
          </View>
        ) : null}

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
        <KeyboardAvoidingView 
          behavior={Platform.OS === "ios" ? "padding" : "height"}
          style={{ flex: 1 }}
        >
          <View style={[styles.modalOverlay, { justifyContent: "flex-end" }]}>
            <View style={[styles.modalContent, { backgroundColor: theme.backgroundDefault, maxHeight: "90%" }]}>
              <View style={styles.modalHeader}>
                <ThemedText style={styles.modalTitle}>Редактировать клиента</ThemedText>
                <Pressable onPress={() => setShowEditModal(false)}>
                  <Icon name="x" size={24} color={theme.text} />
                </Pressable>
              </View>

              <ScrollView style={styles.modalBody} showsVerticalScrollIndicator={false}>
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
                onChangeText={(v) => setEditPhone(normalizePhoneNumber(v))}
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

              {editType === "company" ? (
                <>
                  <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>Контактное лицо</ThemedText>
                  <TextInput
                    style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                    value={editDirectorName}
                    onChangeText={setEditDirectorName}
                    placeholder="ФИО контактного лица"
                    placeholderTextColor={theme.textSecondary}
                  />

                  <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>Название компании</ThemedText>
                  <TextInput
                    style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                    value={editCompanyName}
                    onChangeText={setEditCompanyName}
                    placeholder="Полное название организации"
                    placeholderTextColor={theme.textSecondary}
                  />

                  <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>ФИО директора</ThemedText>
                  <TextInput
                    style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                    value={editCeoName}
                    onChangeText={setEditCeoName}
                    placeholder="ФИО генерального директора"
                    placeholderTextColor={theme.textSecondary}
                  />

                  <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>Юридический адрес</ThemedText>
                  <TextInput
                    style={[styles.input, styles.textArea, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                    value={editLegalAddress}
                    onChangeText={setEditLegalAddress}
                    placeholder="Юридический адрес компании"
                    placeholderTextColor={theme.textSecondary}
                    multiline
                    numberOfLines={2}
                  />

                  <View style={styles.rowInputs}>
                    <View style={{ flex: 1 }}>
                      <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>ИНН</ThemedText>
                      <TextInput
                        style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                        value={editInn}
                        onChangeText={setEditInn}
                        placeholder="ИНН"
                        placeholderTextColor={theme.textSecondary}
                        keyboardType="numeric"
                      />
                    </View>
                    <View style={{ flex: 1 }}>
                      <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>КПП</ThemedText>
                      <TextInput
                        style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                        value={editKpp}
                        onChangeText={setEditKpp}
                        placeholder="КПП"
                        placeholderTextColor={theme.textSecondary}
                        keyboardType="numeric"
                      />
                    </View>
                  </View>
                </>
              ) : null}

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
                <View style={{ height: Spacing.xl }} />
              </ScrollView>
            </View>
          </View>
        </KeyboardAvoidingView>
      </Modal>

      <Modal visible={showManagerModal} animationType="slide" transparent>
        <View style={[styles.modalOverlay, { justifyContent: "flex-end" }]}>
          <View style={[styles.modalContent, { backgroundColor: theme.backgroundDefault, maxHeight: "70%" }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Выберите менеджера</ThemedText>
              <Pressable onPress={() => setShowManagerModal(false)}>
                <Icon name="x" size={24} color={theme.textSecondary} />
              </Pressable>
            </View>

            <FlatList
              data={[{ id: null, display_name: "Без менеджера" }, ...managers.filter(m => m.role === 'admin' || m.permissions?.rental === true)]}
              keyExtractor={(item) => item.id || "none"}
              renderItem={({ item }) => (
                <Pressable
                  onPress={() => handleSelectManager(item.id)}
                  style={[
                    styles.managerOption,
                    { 
                      backgroundColor: client?.assignedManagerId === item.id 
                        ? theme.primary + "20" 
                        : theme.backgroundSecondary 
                    },
                  ]}
                >
                  <View style={[styles.managerAvatar, { backgroundColor: item.id ? theme.primary : theme.textSecondary }]}>
                    <Icon name={item.id ? "user" : "user-x"} size={16} color="#fff" />
                  </View>
                  <ThemedText style={styles.managerOptionName}>
                    {item.display_name || "Без имени"}
                  </ThemedText>
                  {client?.assignedManagerId === item.id ? (
                    <Icon name="check" size={20} color={theme.primary} />
                  ) : null}
                </Pressable>
              )}
              contentContainerStyle={{ paddingBottom: insets.bottom + Spacing.md }}
            />
          </View>
        </View>
      </Modal>

      <Modal visible={showBulkPaymentModal} animationType="slide" transparent>
        <KeyboardAvoidingView 
          behavior={Platform.OS === "ios" ? "padding" : "height"}
          style={{ flex: 1 }}
        >
          <View style={[styles.modalOverlay, { justifyContent: "flex-end" }]}>
            <View style={[styles.modalContent, { backgroundColor: theme.backgroundDefault, maxHeight: "85%" }]}>
              <View style={styles.modalHeader}>
                <ThemedText style={styles.modalTitle}>Массовая оплата</ThemedText>
                <Pressable onPress={() => setShowBulkPaymentModal(false)}>
                  <Icon name="x" size={24} color={theme.text} />
                </Pressable>
              </View>

              <ScrollView style={styles.modalBody} showsVerticalScrollIndicator={false}>
                <Pressable
                  onPress={handleSelectAllOrders}
                  style={[styles.selectAllRow, { backgroundColor: theme.backgroundSecondary }]}
                >
                  <View style={[
                    styles.checkbox,
                    { 
                      backgroundColor: selectedOrderIds.length === unpaidOrders.length ? theme.primary : "transparent",
                      borderColor: selectedOrderIds.length === unpaidOrders.length ? theme.primary : theme.textSecondary,
                    }
                  ]}>
                    {selectedOrderIds.length === unpaidOrders.length ? (
                      <Icon name="check" size={14} color="#fff" />
                    ) : null}
                  </View>
                  <ThemedText style={{ fontWeight: "500" }}>
                    Выбрать все ({unpaidOrders.length})
                  </ThemedText>
                </Pressable>

                <View style={styles.unpaidOrdersList}>
                  {unpaidOrders.map(order => {
                    const remaining = getOrderRemainingAmount(order.id);
                    const isSelected = selectedOrderIds.includes(order.id);
                    return (
                      <Pressable
                        key={order.id}
                        onPress={() => handleToggleOrderSelection(order.id)}
                        style={[
                          styles.unpaidOrderItem,
                          { 
                            backgroundColor: isSelected ? theme.primary + "10" : theme.backgroundSecondary,
                            borderColor: isSelected ? theme.primary : "transparent",
                          }
                        ]}
                      >
                        <View style={[
                          styles.checkbox,
                          { 
                            backgroundColor: isSelected ? theme.primary : "transparent",
                            borderColor: isSelected ? theme.primary : theme.textSecondary,
                          }
                        ]}>
                          {isSelected ? (
                            <Icon name="check" size={14} color="#fff" />
                          ) : null}
                        </View>
                        <View style={{ flex: 1 }}>
                          <ThemedText style={styles.unpaidOrderNumber}>
                            #{order.orderNumber}
                          </ThemedText>
                          <ThemedText style={[styles.unpaidOrderDates, { color: theme.textSecondary }]}>
                            {formatDate(order.startDate)} - {formatDate(order.endDate)}
                          </ThemedText>
                        </View>
                        <ThemedText style={[styles.unpaidOrderAmount, { color: theme.error }]}>
                          {remaining.toLocaleString("ru-RU")}₽
                        </ThemedText>
                      </Pressable>
                    );
                  })}
                </View>

                <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.lg }]}>
                  Способ оплаты
                </ThemedText>
                <View style={styles.paymentMethodsRow}>
                  {PAYMENT_METHODS.map(method => (
                    <Pressable
                      key={method.value}
                      onPress={() => {
                        hapticFeedback.selection();
                        setBulkPaymentMethod(method.value);
                      }}
                      style={[
                        styles.paymentMethodBtn,
                        { 
                          backgroundColor: bulkPaymentMethod === method.value 
                            ? theme.primary + "20" 
                            : theme.backgroundSecondary 
                        }
                      ]}
                    >
                      <ThemedText style={{ 
                        color: bulkPaymentMethod === method.value ? theme.primary : theme.textSecondary,
                        fontWeight: bulkPaymentMethod === method.value ? "600" : "400",
                      }}>
                        {method.label}
                      </ThemedText>
                    </Pressable>
                  ))}
                </View>

                <ThemedText style={[styles.inputLabel, { color: theme.textSecondary, marginTop: Spacing.md }]}>
                  Комментарий (опционально)
                </ThemedText>
                <TextInput
                  style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                  value={bulkPaymentNotes}
                  onChangeText={setBulkPaymentNotes}
                  placeholder="Комментарий к платежу"
                  placeholderTextColor={theme.textSecondary}
                />

                <View style={[styles.totalRow, { backgroundColor: theme.backgroundSecondary }]}>
                  <ThemedText style={{ color: theme.textSecondary }}>
                    Выбрано заказов: {selectedOrderIds.length}
                  </ThemedText>
                  <ThemedText style={[styles.totalAmount, { color: theme.success }]}>
                    {selectedOrdersTotal.toLocaleString("ru-RU")}₽
                  </ThemedText>
                </View>

                <Pressable
                  onPress={handleBulkPayment}
                  disabled={selectedOrderIds.length === 0 || isBulkPaymentProcessing}
                  style={[
                    styles.saveBtn,
                    { 
                      backgroundColor: selectedOrderIds.length === 0 ? theme.textSecondary : theme.success,
                      opacity: isBulkPaymentProcessing ? 0.6 : 1,
                    }
                  ]}
                >
                  <ThemedText style={{ color: "#fff", fontWeight: "600" }}>
                    {isBulkPaymentProcessing ? "Обработка..." : "Оплатить"}
                  </ThemedText>
                </Pressable>

                <View style={{ height: Spacing.xl }} />
              </ScrollView>
            </View>
          </View>
        </KeyboardAvoidingView>
      </Modal>

      <Modal visible={showReconciliationModal} animationType="slide" transparent>
        <View style={[styles.modalOverlay, { justifyContent: "flex-end" }]}>
          <View style={[styles.modalContent, { backgroundColor: theme.backgroundDefault, maxHeight: "85%" }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Сверка</ThemedText>
              <Pressable onPress={() => {
                setReconciliationStartDate(null);
                setReconciliationEndDate(null);
                setShowReconciliationModal(false);
              }}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <ScrollView style={styles.modalBody} showsVerticalScrollIndicator={false}>
              <ThemedText style={[styles.reconciliationTitle, { color: theme.textSecondary }]}>
                Период (по дате начала заказа)
              </ThemedText>
              
              <View style={styles.periodRow}>
                <View style={styles.periodDateBox}>
                  <ThemedText style={[styles.periodLabel, { color: theme.textSecondary }]}>С:</ThemedText>
                  <Pressable 
                    onPress={() => setShowStartDatePicker(true)}
                    style={[styles.periodDateBtn, { backgroundColor: theme.backgroundSecondary }]}
                  >
                    <ThemedText>
                      {reconciliationStartDate ? formatDate(reconciliationStartDate.toISOString()) : "Выбрать"}
                    </ThemedText>
                    {reconciliationStartDate ? (
                      <Pressable onPress={() => setReconciliationStartDate(null)} hitSlop={8}>
                        <Icon name="x" size={16} color={theme.textSecondary} />
                      </Pressable>
                    ) : (
                      <Icon name="calendar" size={16} color={theme.textSecondary} />
                    )}
                  </Pressable>
                </View>
                
                <View style={styles.periodDateBox}>
                  <ThemedText style={[styles.periodLabel, { color: theme.textSecondary }]}>По:</ThemedText>
                  <Pressable 
                    onPress={() => setShowEndDatePicker(true)}
                    style={[styles.periodDateBtn, { backgroundColor: theme.backgroundSecondary }]}
                  >
                    <ThemedText>
                      {reconciliationEndDate ? formatDate(reconciliationEndDate.toISOString()) : "Выбрать"}
                    </ThemedText>
                    {reconciliationEndDate ? (
                      <Pressable onPress={() => setReconciliationEndDate(null)} hitSlop={8}>
                        <Icon name="x" size={16} color={theme.textSecondary} />
                      </Pressable>
                    ) : (
                      <Icon name="calendar" size={16} color={theme.textSecondary} />
                    )}
                  </Pressable>
                </View>
              </View>

              {(showStartDatePicker && Platform.OS !== "web") ? (
                <DateTimePicker
                  value={reconciliationStartDate || new Date()}
                  mode="date"
                  display="spinner"
                  onChange={(event, date) => {
                    setShowStartDatePicker(false);
                    if (date) setReconciliationStartDate(date);
                  }}
                  themeVariant="dark"
                  locale="ru"
                />
              ) : null}

              {(showEndDatePicker && Platform.OS !== "web") ? (
                <DateTimePicker
                  value={reconciliationEndDate || new Date()}
                  mode="date"
                  display="spinner"
                  onChange={(event, date) => {
                    setShowEndDatePicker(false);
                    if (date) setReconciliationEndDate(date);
                  }}
                  themeVariant="dark"
                  locale="ru"
                />
              ) : null}

              <ThemedText style={[styles.reconciliationTitle, { color: theme.textSecondary, marginTop: Spacing.md }]}>
                Неоплаченные заказы ({filteredUnpaidOrders.length})
              </ThemedText>

              {filteredUnpaidOrders.length === 0 ? (
                <View style={[styles.emptyReconciliation, { backgroundColor: theme.backgroundSecondary }]}>
                  <Icon name="check-circle" size={32} color={theme.success} />
                  <ThemedText style={{ color: theme.textSecondary, marginTop: Spacing.sm }}>
                    {unpaidOrders.length === 0 ? "Все заказы оплачены" : "Нет заказов за выбранный период"}
                  </ThemedText>
                </View>
              ) : (
                <View style={styles.reconciliationList}>
                  {filteredUnpaidOrders.map((order, index) => {
                    const remaining = getOrderRemainingAmount(order.id);
                    const orderServices = rentalOrderServices.filter(s => s.orderId === order.id);

                    return (
                      <View 
                        key={order.id} 
                        style={[styles.reconciliationItem, { backgroundColor: theme.backgroundSecondary }]}
                      >
                        <View style={styles.reconciliationItemHeader}>
                          <ThemedText style={styles.reconciliationOrderNumber}>
                            {index + 1}. Заказ #{order.orderNumber}
                          </ThemedText>
                          <ThemedText style={[styles.reconciliationAmount, { color: theme.error }]}>
                            {remaining.toLocaleString("ru-RU")}₽
                          </ThemedText>
                        </View>

                        <ThemedText style={[styles.reconciliationDates, { color: theme.textSecondary }]}>
                          {formatDate(order.startDate)} - {formatDate(order.endDate)}
                        </ThemedText>

                        <View style={styles.reconciliationEquipment}>
                          {order.kitCount > 0 ? (
                            <View style={[styles.equipmentTag, { backgroundColor: theme.backgroundTertiary }]}>
                              <ThemedText style={[styles.equipmentTagText, { color: theme.textSecondary }]}>
                                Компл: {order.kitCount}
                              </ThemedText>
                            </View>
                          ) : null}
                          {order.spareReceiverCount > 0 ? (
                            <View style={[styles.equipmentTag, { backgroundColor: theme.backgroundTertiary }]}>
                              <ThemedText style={[styles.equipmentTagText, { color: theme.textSecondary }]}>
                                Зап.прм: {order.spareReceiverCount}
                              </ThemedText>
                            </View>
                          ) : null}
                          {order.transmitterCount > 0 ? (
                            <View style={[styles.equipmentTag, { backgroundColor: theme.backgroundTertiary }]}>
                              <ThemedText style={[styles.equipmentTagText, { color: theme.textSecondary }]}>
                                Передат: {order.transmitterCount}
                              </ThemedText>
                            </View>
                          ) : null}
                          {order.microphoneCount > 0 ? (
                            <View style={[styles.equipmentTag, { backgroundColor: theme.backgroundTertiary }]}>
                              <ThemedText style={[styles.equipmentTagText, { color: theme.textSecondary }]}>
                                Микр: {order.microphoneCount}
                              </ThemedText>
                            </View>
                          ) : null}
                        </View>

                        {orderServices.length > 0 ? (
                          <View style={styles.reconciliationServices}>
                            <ThemedText style={[styles.servicesLabel, { color: theme.textSecondary }]}>
                              Услуги:
                            </ThemedText>
                            {orderServices.map(service => (
                              <ThemedText key={service.id} style={[styles.serviceName, { color: theme.text }]}>
                                {service.serviceName} x{service.quantity}
                              </ThemedText>
                            ))}
                          </View>
                        ) : null}
                      </View>
                    );
                  })}
                </View>
              )}

              {filteredUnpaidOrders.length > 0 ? (
                <>
                  <View style={[styles.reconciliationTotal, { backgroundColor: theme.primary + "15" }]}>
                    <ThemedText style={{ fontWeight: "600" }}>ИТОГО К ОПЛАТЕ:</ThemedText>
                    <ThemedText style={[styles.reconciliationTotalAmount, { color: theme.primary }]}>
                      {totalUnpaidAmount.toLocaleString("ru-RU")}₽
                    </ThemedText>
                  </View>

                  <View style={styles.reconciliationActions}>
                    <Pressable
                      onPress={handleCopyReconciliation}
                      style={[styles.reconciliationActionBtn, { backgroundColor: theme.backgroundSecondary }]}
                    >
                      <Icon name="copy" size={18} color={theme.primary} />
                      <ThemedText style={{ color: theme.primary, fontWeight: "500" }}>
                        Копировать
                      </ThemedText>
                    </Pressable>
                    <Pressable
                      onPress={handleShareReconciliation}
                      style={[styles.reconciliationActionBtn, { backgroundColor: theme.primary }]}
                    >
                      <Icon name="share-2" size={18} color="#fff" />
                      <ThemedText style={{ color: "#fff", fontWeight: "500" }}>
                        Поделиться
                      </ThemedText>
                    </Pressable>
                  </View>
                </>
              ) : null}

              <View style={{ height: insets.bottom + Spacing.xl }} />
            </ScrollView>
          </View>
        </View>
      </Modal>

      <Modal visible={showContractTemplateModal} animationType="fade" transparent>
        <Pressable 
          style={styles.modalOverlay} 
          onPress={() => setShowContractTemplateModal(false)}
        >
          <View style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Выберите шаблон</ThemedText>
              <Pressable onPress={() => setShowContractTemplateModal(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>
            <ScrollView style={{ maxHeight: 300 }}>
              {annualContractTemplates.map(template => (
                <Pressable
                  key={template.id}
                  onPress={() => handleGenerateContract(template.htmlContent)}
                  style={[
                    styles.contractBtn,
                    { 
                      backgroundColor: template.isDefault ? theme.primary + "15" : theme.backgroundSecondary,
                      borderWidth: 1,
                      borderColor: template.isDefault ? theme.primary : theme.border,
                      marginBottom: Spacing.sm,
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
              ))}
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
  contractBtn: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
  },
  templateOption: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    flex: 1,
  },
  contactText: {
    fontSize: 13,
    fontWeight: "500",
  },
  requisitesBox: {
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
    marginTop: Spacing.md,
    gap: Spacing.xs,
  },
  requisiteRow: {
    flexDirection: "row",
    alignItems: "flex-start",
    flexWrap: "wrap",
  },
  requisiteLabel: {
    fontSize: 12,
    marginRight: Spacing.xs,
  },
  requisiteValue: {
    fontSize: 12,
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
  upcomingRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
    marginTop: Spacing.md,
  },
  upcomingValue: {
    fontSize: 16,
    fontWeight: "600",
  },
  defaultPrice: {
    fontSize: 18,
    fontWeight: "700",
  },
  bulkActionsRow: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginTop: Spacing.md,
  },
  bulkActionBtn: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.xs,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.sm,
    borderRadius: BorderRadius.md,
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
  rowInputs: {
    flexDirection: "row",
    gap: Spacing.md,
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
  managerRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
    marginTop: Spacing.md,
  },
  managerInfo: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  managerOption: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
    padding: Spacing.md,
    marginHorizontal: Spacing.md,
    marginBottom: Spacing.sm,
    borderRadius: BorderRadius.md,
  },
  managerAvatar: {
    width: 32,
    height: 32,
    borderRadius: 16,
    justifyContent: "center",
    alignItems: "center",
  },
  managerOptionName: {
    flex: 1,
    fontSize: 16,
    fontWeight: "500",
  },
  selectAllRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.sm,
  },
  checkbox: {
    width: 22,
    height: 22,
    borderRadius: 4,
    borderWidth: 2,
    justifyContent: "center",
    alignItems: "center",
  },
  unpaidOrdersList: {
    gap: Spacing.sm,
  },
  unpaidOrderItem: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
  },
  unpaidOrderNumber: {
    fontSize: 15,
    fontWeight: "600",
  },
  unpaidOrderDates: {
    fontSize: 12,
    marginTop: 2,
  },
  unpaidOrderAmount: {
    fontSize: 15,
    fontWeight: "600",
  },
  paymentMethodsRow: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  paymentMethodBtn: {
    flex: 1,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
  totalRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginTop: Spacing.lg,
  },
  totalAmount: {
    fontSize: 20,
    fontWeight: "700",
  },
  reconciliationTitle: {
    fontSize: 13,
    fontWeight: "500",
    textTransform: "uppercase",
    marginBottom: Spacing.md,
  },
  periodRow: {
    flexDirection: "row",
    gap: Spacing.md,
    marginBottom: Spacing.md,
  },
  periodDateBox: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  periodLabel: {
    fontSize: 13,
    fontWeight: "500",
  },
  periodDateBtn: {
    flex: 1,
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
  },
  emptyReconciliation: {
    padding: Spacing.xl,
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
  reconciliationList: {
    gap: Spacing.sm,
  },
  reconciliationItem: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
  },
  reconciliationItemHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  reconciliationOrderNumber: {
    fontSize: 15,
    fontWeight: "600",
  },
  reconciliationAmount: {
    fontSize: 15,
    fontWeight: "600",
  },
  reconciliationDates: {
    fontSize: 12,
    marginTop: 2,
  },
  reconciliationEquipment: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.xs,
    marginTop: Spacing.sm,
  },
  equipmentTag: {
    paddingHorizontal: Spacing.xs,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  equipmentTagText: {
    fontSize: 11,
  },
  reconciliationServices: {
    marginTop: Spacing.sm,
  },
  servicesLabel: {
    fontSize: 12,
    marginBottom: 2,
  },
  serviceName: {
    fontSize: 12,
  },
  reconciliationTotal: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginTop: Spacing.md,
  },
  reconciliationTotalAmount: {
    fontSize: 20,
    fontWeight: "700",
  },
  reconciliationActions: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginTop: Spacing.md,
  },
  reconciliationActionBtn: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.md,
  },
});
