import { useState, useMemo } from "react";
import {
  View,
  StyleSheet,
  Pressable,
  TextInput,
  FlatList,
} from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useRental, RentalOrder, RentalOrderStatus } from "@/contexts/RentalContext";
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
  const { rentalOrders, rentalClients } = useRental();

  const [searchQuery, setSearchQuery] = useState("");
  const [activeFilter, setActiveFilter] = useState<FilterType>("all");

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
      result = result.filter(o => isUpcoming(o) && o.status !== "completed" && o.status !== "cancelled");
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

  const getClientName = (clientId: string): string => {
    return rentalClients.find(c => c.id === clientId)?.name || "Неизвестный клиент";
  };

  const getClientPhone = (clientId: string): string | null => {
    return rentalClients.find(c => c.id === clientId)?.phone || null;
  };

  const renderOrderItem = ({ item }: { item: RentalOrder }) => {
    const statusConfig = STATUS_CONFIG[item.status];
    const clientName = item.clientName || getClientName(item.clientId);
    const clientPhone = item.clientPhone || getClientPhone(item.clientId);

    return (
      <Pressable
        onPress={() => navigation.navigate("RentalOrderDetail", { orderId: item.id })}
        style={({ pressed }) => [
          styles.orderCard,
          { backgroundColor: theme.backgroundSecondary, opacity: pressed ? 0.8 : 1 },
        ]}
      >
        <View style={styles.orderHeader}>
          <View style={styles.orderInfo}>
            <View style={styles.orderTitleRow}>
              <ThemedText style={styles.orderNumber}>
                #{item.orderNumber}
              </ThemedText>
              <View style={[styles.statusBadge, { backgroundColor: statusConfig.color + "20" }]}>
                <ThemedText style={[styles.statusText, { color: statusConfig.color }]}>
                  {statusConfig.label}
                </ThemedText>
              </View>
            </View>
            <ThemedText style={styles.clientName} numberOfLines={1}>
              {clientName}
            </ThemedText>
            {clientPhone ? (
              <ThemedText style={[styles.clientPhone, { color: theme.textSecondary }]}>
                {clientPhone}
              </ThemedText>
            ) : null}
          </View>
          <View style={styles.orderPrice}>
            <ThemedText style={[styles.priceText, { color: theme.primary }]}>
              {item.totalPrice.toLocaleString("ru-RU")}₽
            </ThemedText>
            <ThemedText style={[styles.daysText, { color: theme.textSecondary }]}>
              {item.daysCount} дн.
            </ThemedText>
          </View>
        </View>

        <View style={[styles.divider, { backgroundColor: theme.border }]} />

        <View style={styles.orderDetails}>
          <View style={styles.detailRow}>
            <Icon name="calendar" size={14} color={theme.textSecondary} />
            <ThemedText style={[styles.detailText, { color: theme.textSecondary }]}>
              {formatDate(item.startDate)} - {formatDate(item.endDate)}
            </ThemedText>
          </View>
          <View style={styles.detailRow}>
            <Icon name="radio" size={14} color={theme.textSecondary} />
            <ThemedText style={[styles.detailText, { color: theme.textSecondary }]}>
              {item.kitCount} шт.
              {item.transmitterCount > 0 ? ` • ${item.transmitterCount} перед.` : ""}
              {item.microphoneCount > 0 ? ` • ${item.microphoneCount} микр.` : ""}
            </ThemedText>
          </View>
          {item.receiverNotes ? (
            <View style={styles.detailRow}>
              <Icon name="file-text" size={14} color={theme.textSecondary} />
              <ThemedText style={[styles.detailText, { color: theme.textSecondary }]} numberOfLines={1}>
                {item.receiverNotes}
              </ThemedText>
            </View>
          ) : null}
          {item.managerName ? (
            <View style={styles.detailRow}>
              <Icon name="user" size={14} color={theme.textSecondary} />
              <ThemedText style={[styles.detailText, { color: theme.textSecondary }]}>
                {item.managerName}
              </ThemedText>
            </View>
          ) : null}
        </View>
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

      <Pressable
        onPress={() => navigation.navigate("AddRentalOrder")}
        style={[
          styles.fab,
          { backgroundColor: theme.primary, bottom: insets.bottom + Spacing.xl },
        ]}
      >
        <Icon name="plus" size={24} color="#fff" />
      </Pressable>
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
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
    marginBottom: Spacing.sm,
  },
  orderHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "flex-start",
  },
  orderInfo: {
    flex: 1,
  },
  orderTitleRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    marginBottom: Spacing.xs,
  },
  orderNumber: {
    fontSize: 16,
    fontWeight: "700",
  },
  statusBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  statusText: {
    fontSize: 11,
    fontWeight: "600",
  },
  clientName: {
    fontSize: 15,
    fontWeight: "500",
  },
  clientPhone: {
    fontSize: 13,
    marginTop: 2,
  },
  orderPrice: {
    alignItems: "flex-end",
  },
  priceText: {
    fontSize: 18,
    fontWeight: "700",
  },
  daysText: {
    fontSize: 12,
    marginTop: 2,
  },
  divider: {
    height: 1,
    marginVertical: Spacing.sm,
  },
  orderDetails: {
    gap: Spacing.xs,
  },
  detailRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  detailText: {
    fontSize: 13,
    flex: 1,
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
});
