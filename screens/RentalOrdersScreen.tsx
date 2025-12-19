import { useState, useMemo } from "react";
import {
  View,
  StyleSheet,
  Pressable,
  TextInput,
  FlatList,
  SectionList,
  Linking,
  Alert,
  ActionSheetIOS,
  Platform,
} from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { PaymentModal } from "@/components/PaymentModal";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useRental, RentalOrder, RentalOrderStatus } from "@/contexts/RentalContext";
import { useAuth } from "@/contexts/AuthContext";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";
import { hapticFeedback } from "@/utils/haptics";

type FilterType = "all" | "срок" | "new" | "issued" | "returned" | "completed" | "cancelled";

const STATUS_CONFIG: Record<RentalOrderStatus, { label: string; color: string }> = {
  new: { label: "Новый", color: "#2196F3" },
  issued: { label: "Выдан", color: "#4CAF50" },
  returned: { label: "Возвращён", color: "#FF9800" },
  completed: { label: "Завершён", color: "#9C27B0" },
  cancelled: { label: "Отменён", color: "#F44336" },
};

export default function RentalOrdersScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<SettingsStackParamList>>();
  const insets = useSafeAreaInsets();
  const { rentalOrders, rentalClients, updateRentalOrder, addRentalPayment, getOrderPayments } = useRental();
  const { managers } = useAuth();

  const [searchQuery, setSearchQuery] = useState("");
  const [activeFilter, setActiveFilter] = useState<FilterType>("срок");
  const [paymentModalVisible, setPaymentModalVisible] = useState(false);
  const [selectedOrderForPayment, setSelectedOrderForPayment] = useState<RentalOrder | null>(null);

  const formatDate = (dateStr: string): string => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU", { day: "2-digit", month: "2-digit", year: "numeric" });
  };

  const isUpcoming = (order: RentalOrder): boolean => {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const startDate = new Date(order.startDate);
    startDate.setHours(0, 0, 0, 0);
    const endDate = new Date(order.endDate);
    endDate.setHours(23, 59, 59, 999);
    return startDate >= today || (order.status === "issued" && endDate >= today);
  };

  const filteredOrders = useMemo(() => {
    let result = [...rentalOrders];

    if (activeFilter === "срок") {
      result = result.filter(o => o.status === "new");
      result.sort((a, b) => new Date(a.startDate).getTime() - new Date(b.startDate).getTime());
    } else if (activeFilter !== "all") {
      result = result.filter(o => o.status === activeFilter);
    }

    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase();
      result = result.filter(o => {
        const client = rentalClients.find(c => c.id === o.clientId);
        return (
          o.orderNumber.toString().includes(query) ||
          client?.name.toLowerCase().includes(query) ||
          client?.phone?.toLowerCase().includes(query) ||
          o.receiverNotes?.toLowerCase().includes(query)
        );
      });
    }

    return result;
  }, [rentalOrders, rentalClients, activeFilter, searchQuery]);

  const groupedOrders = useMemo(() => {
    if (activeFilter !== "срок") return [];
    
    const groups: { [key: string]: RentalOrder[] } = {};
    filteredOrders.forEach(order => {
      const dateKey = formatDate(order.startDate);
      if (!groups[dateKey]) {
        groups[dateKey] = [];
      }
      groups[dateKey].push(order);
    });

    return Object.entries(groups)
      .sort((a, b) => {
        const dateA = new Date(filteredOrders.find(o => formatDate(o.startDate) === a[0])?.startDate || "");
        const dateB = new Date(filteredOrders.find(o => formatDate(o.startDate) === b[0])?.startDate || "");
        return dateA.getTime() - dateB.getTime();
      })
      .map(([title, data]) => ({ title, data }));
  }, [filteredOrders, activeFilter]);

  const getClientName = (clientId: string): string => {
    return rentalClients.find(c => c.id === clientId)?.name || "Неизвестный клиент";
  };

  const getClientPhone = (clientId: string): string | null => {
    return rentalClients.find(c => c.id === clientId)?.phone || null;
  };

  const handlePhonePress = (phone: string) => {
    hapticFeedback.selection();
    const cleanPhone = phone.replace(/[^0-9+]/g, "");
    
    if (Platform.OS === "ios") {
      ActionSheetIOS.showActionSheetWithOptions(
        {
          options: ["Отмена", "Позвонить", "WhatsApp", "Telegram"],
          cancelButtonIndex: 0,
        },
        (buttonIndex) => {
          if (buttonIndex === 1) {
            Linking.openURL(`tel:${cleanPhone}`);
          } else if (buttonIndex === 2) {
            Linking.openURL(`https://wa.me/${cleanPhone.replace("+", "")}`);
          } else if (buttonIndex === 3) {
            Linking.openURL(`tg://resolve?phone=${cleanPhone.replace("+", "")}`);
          }
        }
      );
    } else {
      Alert.alert("Связаться", `Выберите способ связи с ${phone}`, [
        { text: "Отмена", style: "cancel" },
        { text: "Позвонить", onPress: () => Linking.openURL(`tel:${cleanPhone}`) },
        { text: "WhatsApp", onPress: () => Linking.openURL(`https://wa.me/${cleanPhone.replace("+", "")}`) },
        { text: "Telegram", onPress: () => Linking.openURL(`tg://resolve?phone=${cleanPhone.replace("+", "")}`) },
      ]);
    }
  };

  const handleStatusSelection = async (order: RentalOrder, newStatus: RentalOrderStatus) => {
    if (newStatus === "completed") {
      setSelectedOrderForPayment(order);
      setPaymentModalVisible(true);
    } else {
      try {
        await updateRentalOrder(order.id, { status: newStatus });
        hapticFeedback.success();
      } catch (error) {
        console.error("Error updating status:", error);
      }
    }
  };

  const handleStatusChange = (order: RentalOrder) => {
    hapticFeedback.selection();
    const statuses: RentalOrderStatus[] = ["new", "issued", "returned", "completed", "cancelled"];
    const statusLabels = statuses.map(s => STATUS_CONFIG[s].label);
    
    if (Platform.OS === "ios") {
      ActionSheetIOS.showActionSheetWithOptions(
        {
          options: ["Отмена", ...statusLabels],
          cancelButtonIndex: 0,
        },
        (buttonIndex) => {
          if (buttonIndex > 0) {
            const newStatus = statuses[buttonIndex - 1];
            handleStatusSelection(order, newStatus);
          }
        }
      );
    } else {
      Alert.alert("Изменить статус", "Выберите новый статус", [
        { text: "Отмена", style: "cancel" },
        ...statuses.map(status => ({
          text: STATUS_CONFIG[status].label,
          onPress: () => handleStatusSelection(order, status),
        })),
      ]);
    }
  };

  const handlePaymentSubmit = async (data: { amount: number; method: string; notes: string }) => {
    if (!selectedOrderForPayment) return;
    
    await addRentalPayment({
      orderId: selectedOrderForPayment.id,
      type: "final",
      amount: data.amount,
      notes: data.notes || `Оплата (${data.method === "cash" ? "наличные" : data.method === "card" ? "карта" : "перевод"})`,
    });
    
    await updateRentalOrder(selectedOrderForPayment.id, { status: "completed" });
    setPaymentModalVisible(false);
    setSelectedOrderForPayment(null);
  };

  const getOrderTotalPaid = (orderId: string): number => {
    const payments = getOrderPayments(orderId);
    return payments
      .filter(p => p.type !== "refund" && p.type !== "service_expense")
      .reduce((sum, p) => sum + p.amount, 0);
  };

  const renderOrderItem = ({ item }: { item: RentalOrder }) => {
    const statusConfig = STATUS_CONFIG[item.status];
    const clientName = item.clientName || getClientName(item.clientId);
    const clientPhone = item.clientPhone || getClientPhone(item.clientId);

    const client = rentalClients.find(c => c.id === item.clientId);
    const ownerManager = client?.assignedManagerId ? managers.find(m => m.id === client.assignedManagerId) : null;
    const executorManager = item.executorId ? managers.find(m => m.id === item.executorId) : null;

    const equipmentParts = [];
    if (item.kitCount > 0) equipmentParts.push(`${item.kitCount} комп.`);
    if (item.transmitterCount > 0) equipmentParts.push(`${item.transmitterCount} пер.`);
    if (item.microphoneCount > 0) equipmentParts.push(`${item.microphoneCount} мик.`);
    const equipmentText = equipmentParts.join(" / ") || "—";

    return (
      <Pressable
        onPress={() => navigation.navigate("RentalOrderDetail", { orderId: item.id })}
        style={({ pressed }) => [
          styles.orderCard,
          { backgroundColor: theme.backgroundSecondary, opacity: pressed ? 0.8 : 1 },
        ]}
      >
        <View style={styles.orderRow}>
          <Pressable
            onPress={(e) => {
              e.stopPropagation();
              handleStatusChange(item);
            }}
            style={[styles.statusIndicator, { backgroundColor: statusConfig.color }]}
          />
          <View style={styles.orderMainInfo}>
            <View style={styles.orderTopRow}>
              <ThemedText style={styles.orderNumber}>#{item.orderNumber}</ThemedText>
              <Pressable onPress={() => handleStatusChange(item)}>
                <ThemedText style={[styles.statusLabel, { color: statusConfig.color }]}>
                  {statusConfig.label}
                </ThemedText>
              </Pressable>
            </View>
            <ThemedText style={styles.clientName} numberOfLines={1}>
              {clientName}
            </ThemedText>
            {clientPhone ? (
              <Pressable onPress={() => handlePhonePress(clientPhone)} style={styles.phoneRow}>
                <Icon name="phone" size={14} color={theme.primary} />
                <ThemedText style={[styles.phoneText, { color: theme.primary }]}>
                  {clientPhone}
                </ThemedText>
              </Pressable>
            ) : null}
            <View style={styles.orderMetaRow}>
              <ThemedText style={[styles.dateText, { color: theme.textSecondary }]}>
                {formatDate(item.startDate)} — {formatDate(item.endDate)}
              </ThemedText>
              <ThemedText style={[styles.equipmentText, { color: theme.textSecondary }]}>
                {equipmentText}
              </ThemedText>
            </View>
            {(ownerManager || executorManager) ? (
              <View style={styles.managersRow}>
                {ownerManager ? (
                  <View style={styles.managerTag}>
                    <Icon name="user" size={12} color={theme.primary} />
                    <ThemedText style={[styles.managerTagText, { color: theme.textSecondary }]}>
                      {ownerManager.display_name?.split(" ")[0] || "Менеджер"}
                    </ThemedText>
                  </View>
                ) : null}
                {executorManager ? (
                  <View style={styles.managerTag}>
                    <Icon name="truck" size={12} color={theme.success} />
                    <ThemedText style={[styles.managerTagText, { color: theme.textSecondary }]}>
                      {executorManager.display_name?.split(" ")[0] || "Исполнитель"}
                    </ThemedText>
                  </View>
                ) : null}
              </View>
            ) : null}
          </View>
          <View style={styles.orderPriceBlock}>
            <ThemedText style={[styles.priceText, { color: theme.primary }]}>
              {item.totalPrice.toLocaleString("ru-RU")}
            </ThemedText>
            <ThemedText style={[styles.priceCurrency, { color: theme.primary }]}>₽</ThemedText>
          </View>
        </View>
        {item.receiverNotes ? (
          <View style={[styles.notesRow, { backgroundColor: theme.primary + "15" }]}>
            <Icon name="message-circle" size={16} color={theme.primary} />
            <ThemedText style={styles.notesText} numberOfLines={2}>
              {item.receiverNotes}
            </ThemedText>
          </View>
        ) : null}
      </Pressable>
    );
  };

  const filters: { key: FilterType; label: string }[] = [
    { key: "all", label: "Все" },
    { key: "срок", label: "Срок" },
    { key: "new", label: "Новые" },
    { key: "issued", label: "В аренде" },
    { key: "returned", label: "Возвращённые" },
    { key: "completed", label: "Завершённые" },
  ];

  return (
    <ThemedView style={styles.container}>
      <View style={styles.searchContainer}>
        <View style={[styles.searchBox, { backgroundColor: theme.backgroundSecondary }]}>
          <Icon name="search" size={20} color={theme.textSecondary} />
          <TextInput
            style={[styles.searchInput, { color: theme.text }]}
            placeholder="Поиск заказов..."
            placeholderTextColor={theme.textSecondary}
            value={searchQuery}
            onChangeText={setSearchQuery}
          />
          {searchQuery ? (
            <Pressable onPress={() => setSearchQuery("")}>
              <Icon name="x" size={20} color={theme.textSecondary} />
            </Pressable>
          ) : null}
        </View>
      </View>

      <View style={styles.filtersContainer}>
        <FlatList
          horizontal
          showsHorizontalScrollIndicator={false}
          data={filters}
          keyExtractor={(item) => item.key}
          contentContainerStyle={styles.filtersList}
          renderItem={({ item }) => (
            <Pressable
              onPress={() => {
                hapticFeedback.selection();
                setActiveFilter(item.key);
              }}
              style={[
                styles.filterChip,
                { backgroundColor: activeFilter === item.key ? theme.primary : theme.backgroundSecondary },
              ]}
            >
              <ThemedText
                style={[
                  styles.filterText,
                  { color: activeFilter === item.key ? "#fff" : theme.text },
                ]}
              >
                {item.label}
              </ThemedText>
            </Pressable>
          )}
        />
      </View>

      {activeFilter === "срок" ? (
        <SectionList
          sections={groupedOrders}
          keyExtractor={(item) => item.id}
          renderItem={({ item }) => renderOrderItem({ item })}
          renderSectionHeader={({ section: { title } }) => (
            <View style={[styles.sectionHeader, { backgroundColor: theme.backgroundDefault }]}>
              <ThemedText style={styles.sectionHeaderText}>{title}</ThemedText>
            </View>
          )}
          contentContainerStyle={[
            styles.listContent,
            { paddingBottom: insets.bottom + 80 },
          ]}
          stickySectionHeadersEnabled
          ListEmptyComponent={
            <View style={styles.emptyContainer}>
              <Icon name="file-text" size={48} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                Нет предстоящих заказов
              </ThemedText>
            </View>
          }
        />
      ) : (
        <FlatList
          data={filteredOrders}
          keyExtractor={(item) => item.id}
          renderItem={renderOrderItem}
          contentContainerStyle={[
            styles.listContent,
            { paddingBottom: insets.bottom + 80 },
          ]}
          ListEmptyComponent={
            <View style={styles.emptyContainer}>
              <Icon name="file-text" size={48} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                {searchQuery ? "Заказы не найдены" : "Нет заказов"}
              </ThemedText>
            </View>
          }
        />
      )}

      <Pressable
        onPress={() => navigation.navigate("AddRentalOrder")}
        style={[
          styles.fab,
          { backgroundColor: theme.primary, bottom: insets.bottom + Spacing.xl },
        ]}
      >
        <Icon name="plus" size={24} color="#fff" />
      </Pressable>

      {selectedOrderForPayment ? (
        <PaymentModal
          visible={paymentModalVisible}
          onClose={() => {
            setPaymentModalVisible(false);
            setSelectedOrderForPayment(null);
          }}
          onSubmit={handlePaymentSubmit}
          orderTotal={selectedOrderForPayment.totalPrice}
          totalPaid={getOrderTotalPaid(selectedOrderForPayment.id)}
          clientName={selectedOrderForPayment.clientName || getClientName(selectedOrderForPayment.clientId)}
          orderNumber={selectedOrderForPayment.orderNumber}
        />
      ) : null}
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  searchContainer: {
    padding: Spacing.md,
    paddingBottom: Spacing.sm,
  },
  searchBox: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.lg,
    gap: Spacing.sm,
  },
  searchInput: {
    flex: 1,
    fontSize: 16,
    paddingVertical: Spacing.xs,
  },
  filtersContainer: {
    marginBottom: Spacing.sm,
  },
  filtersList: {
    paddingHorizontal: Spacing.md,
    gap: Spacing.sm,
  },
  filterChip: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.full,
    marginRight: Spacing.sm,
  },
  filterText: {
    fontSize: 14,
    fontWeight: "500",
  },
  listContent: {
    padding: Spacing.md,
    gap: Spacing.sm,
  },
  orderCard: {
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.sm,
    overflow: "hidden",
  },
  orderRow: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: Spacing.md,
    paddingRight: Spacing.md,
  },
  statusIndicator: {
    width: 5,
    alignSelf: "stretch",
    marginRight: Spacing.md,
  },
  orderMainInfo: {
    flex: 1,
    paddingRight: Spacing.sm,
  },
  orderTopRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    marginBottom: 4,
  },
  orderNumber: {
    fontSize: 17,
    fontWeight: "700",
  },
  statusLabel: {
    fontSize: 14,
    fontWeight: "600",
  },
  clientName: {
    fontSize: 18,
    fontWeight: "600",
    marginBottom: 4,
  },
  phoneRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    marginBottom: 6,
  },
  phoneText: {
    fontSize: 15,
    fontWeight: "500",
  },
  orderMetaRow: {
    flexDirection: "row",
    alignItems: "center",
    flexWrap: "wrap",
    gap: Spacing.sm,
  },
  managersRow: {
    flexDirection: "row",
    alignItems: "center",
    flexWrap: "wrap",
    gap: Spacing.sm,
    marginTop: 4,
  },
  managerTag: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
  },
  managerTagText: {
    fontSize: 13,
  },
  dateText: {
    fontSize: 15,
    fontWeight: "500",
  },
  equipmentText: {
    fontSize: 15,
    fontWeight: "500",
  },
  orderPriceBlock: {
    flexDirection: "row",
    alignItems: "baseline",
  },
  priceText: {
    fontSize: 22,
    fontWeight: "700",
  },
  priceCurrency: {
    fontSize: 16,
    fontWeight: "600",
    marginLeft: 2,
  },
  notesRow: {
    flexDirection: "row",
    alignItems: "flex-start",
    gap: Spacing.sm,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    marginHorizontal: Spacing.sm,
    marginBottom: Spacing.sm,
    borderRadius: BorderRadius.sm,
  },
  notesText: {
    fontSize: 15,
    fontWeight: "500",
    flex: 1,
    lineHeight: 20,
  },
  emptyContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    paddingTop: 100,
    gap: Spacing.md,
  },
  emptyText: {
    fontSize: 16,
  },
  fab: {
    position: "absolute",
    right: Spacing.lg,
    width: 56,
    height: 56,
    borderRadius: 28,
    justifyContent: "center",
    alignItems: "center",
    elevation: 4,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 4,
  },
  sectionHeader: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    marginBottom: Spacing.xs,
  },
  sectionHeaderText: {
    fontSize: 18,
    fontWeight: "700",
  },
});
