import { useState, useMemo, useCallback } from "react";
import { View, StyleSheet, Pressable, ScrollView, Modal } from "react-native";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useRental, RentalOrder, RentalOrderStatus, RentalClient } from "@/contexts/RentalContext";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";
import { hapticFeedback } from "@/utils/haptics";

const MONTH_NAMES = [
  "Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
  "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"
];

const WEEKDAY_NAMES = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];

const STATUS_CONFIG: Record<RentalOrderStatus, { label: string; color: string }> = {
  new: { label: "Новый", color: "#2196F3" },
  issued: { label: "Выдан", color: "#4CAF50" },
  returned: { label: "Возвращён", color: "#FF9800" },
  completed: { label: "Завершён", color: "#9C27B0" },
  cancelled: { label: "Отменён", color: "#F44336" },
};

interface DayData {
  date: Date;
  isCurrentMonth: boolean;
  isToday: boolean;
  kitCount: number;
  orders: RentalOrder[];
}

export default function RentalCalendarScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<SettingsStackParamList>>();
  const { rentalOrders, rentalClients } = useRental();

  const getClientName = useCallback((clientId: string): string => {
    const client = rentalClients.find(c => c.id === clientId);
    return client?.name || "Неизвестный клиент";
  }, [rentalClients]);

  const [currentDate, setCurrentDate] = useState(new Date());
  const [selectedDate, setSelectedDate] = useState<Date | null>(null);
  const [showOrdersModal, setShowOrdersModal] = useState(false);

  const formatDateKey = (date: Date): string => {
    return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}-${String(date.getDate()).padStart(2, "0")}`;
  };

  const formatDisplayDate = (date: Date): string => {
    return date.toLocaleDateString("ru-RU", { day: "numeric", month: "long", year: "numeric" });
  };

  const getOrdersForDate = useCallback((date: Date): RentalOrder[] => {
    const dateKey = formatDateKey(date);
    return rentalOrders.filter(order => {
      if (order.status === "cancelled" || order.status === "completed") return false;
      const startDate = new Date(order.startDate);
      const endDate = new Date(order.endDate);
      startDate.setHours(0, 0, 0, 0);
      endDate.setHours(23, 59, 59, 999);
      const checkDate = new Date(date);
      checkDate.setHours(12, 0, 0, 0);
      return checkDate >= startDate && checkDate <= endDate;
    });
  }, [rentalOrders]);

  const getKitCountForDate = useCallback((date: Date): number => {
    const orders = getOrdersForDate(date);
    return orders.reduce((sum, order) => sum + order.kitCount + (order.spareReceiverCount || 0), 0);
  }, [getOrdersForDate]);

  const calendarDays = useMemo((): DayData[] => {
    const year = currentDate.getFullYear();
    const month = currentDate.getMonth();

    const firstDayOfMonth = new Date(year, month, 1);
    const lastDayOfMonth = new Date(year, month + 1, 0);

    let startDay = firstDayOfMonth.getDay() - 1;
    if (startDay < 0) startDay = 6;

    const days: DayData[] = [];
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    for (let i = startDay - 1; i >= 0; i--) {
      const date = new Date(year, month, -i);
      days.push({
        date,
        isCurrentMonth: false,
        isToday: false,
        kitCount: getKitCountForDate(date),
        orders: getOrdersForDate(date),
      });
    }

    for (let day = 1; day <= lastDayOfMonth.getDate(); day++) {
      const date = new Date(year, month, day);
      const dateToday = new Date(today);
      date.setHours(0, 0, 0, 0);
      days.push({
        date,
        isCurrentMonth: true,
        isToday: date.getTime() === dateToday.getTime(),
        kitCount: getKitCountForDate(date),
        orders: getOrdersForDate(date),
      });
    }

    const remainingDays = 42 - days.length;
    for (let i = 1; i <= remainingDays; i++) {
      const date = new Date(year, month + 1, i);
      days.push({
        date,
        isCurrentMonth: false,
        isToday: false,
        kitCount: getKitCountForDate(date),
        orders: getOrdersForDate(date),
      });
    }

    return days;
  }, [currentDate, getKitCountForDate, getOrdersForDate]);

  const goToPreviousMonth = () => {
    hapticFeedback.selection();
    setCurrentDate(new Date(currentDate.getFullYear(), currentDate.getMonth() - 1, 1));
  };

  const goToNextMonth = () => {
    hapticFeedback.selection();
    setCurrentDate(new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 1));
  };

  const goToToday = () => {
    hapticFeedback.selection();
    setCurrentDate(new Date());
  };

  const handleDayPress = (day: DayData) => {
    hapticFeedback.selection();
    setSelectedDate(day.date);
    setShowOrdersModal(true);
  };

  const handleOrderPress = (orderId: string) => {
    setShowOrdersModal(false);
    navigation.navigate("RentalOrderDetail", { orderId });
  };

  const handleCreateOrder = () => {
    setShowOrdersModal(false);
    navigation.navigate("AddRentalOrder", selectedDate ? { startDate: selectedDate.toISOString() } : undefined);
  };

  const selectedOrders = useMemo(() => {
    if (!selectedDate) return [];
    return getOrdersForDate(selectedDate);
  }, [selectedDate, getOrdersForDate]);

  const totalKitsToday = useMemo(() => {
    const today = new Date();
    return getKitCountForDate(today);
  }, [getKitCountForDate]);

  const monthStats = useMemo(() => {
    let maxKits = 0;
    let avgKits = 0;
    let daysWithOrders = 0;

    calendarDays.filter(d => d.isCurrentMonth).forEach(day => {
      if (day.kitCount > maxKits) maxKits = day.kitCount;
      if (day.kitCount > 0) {
        avgKits += day.kitCount;
        daysWithOrders++;
      }
    });

    return {
      maxKits,
      avgKits: daysWithOrders > 0 ? Math.round(avgKits / daysWithOrders) : 0,
      daysWithOrders,
    };
  }, [calendarDays]);

  return (
    <>
      <ScreenScrollView style={styles.container}>
        <View style={styles.header}>
          <Pressable onPress={goToPreviousMonth} style={styles.navButton}>
            <Icon name="chevron-left" size={24} color={theme.text} />
          </Pressable>
          <Pressable onPress={goToToday}>
            <ThemedText style={styles.monthTitle}>
              {MONTH_NAMES[currentDate.getMonth()]} {currentDate.getFullYear()}
            </ThemedText>
          </Pressable>
          <Pressable onPress={goToNextMonth} style={styles.navButton}>
            <Icon name="chevron-right" size={24} color={theme.text} />
          </Pressable>
        </View>

        <View style={[styles.statsRow, { backgroundColor: theme.backgroundSecondary }]}>
          <View style={styles.statItem}>
            <ThemedText style={[styles.statValue, { color: theme.primary }]}>{totalKitsToday}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Сегодня</ThemedText>
          </View>
          <View style={[styles.statDivider, { backgroundColor: theme.border }]} />
          <View style={styles.statItem}>
            <ThemedText style={[styles.statValue, { color: "#FF9800" }]}>{monthStats.maxKits}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Макс. за месяц</ThemedText>
          </View>
          <View style={[styles.statDivider, { backgroundColor: theme.border }]} />
          <View style={styles.statItem}>
            <ThemedText style={[styles.statValue, { color: "#4CAF50" }]}>{monthStats.daysWithOrders}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Дней с заказами</ThemedText>
          </View>
        </View>

        <View style={styles.weekdayRow}>
          {WEEKDAY_NAMES.map((name, index) => (
            <View key={index} style={styles.weekdayCell}>
              <ThemedText style={[styles.weekdayText, { color: theme.textSecondary }]}>{name}</ThemedText>
            </View>
          ))}
        </View>

        <View style={styles.calendarGrid}>
          {calendarDays.map((day, index) => {
            const orderCount = day.orders.length;
            const hasOrders = orderCount > 0;
            const loadLevel = orderCount >= 10 ? "high" : orderCount >= 5 ? "medium" : "low";
            
            return (
              <Pressable
                key={index}
                style={[
                  styles.dayCell,
                  { backgroundColor: day.isCurrentMonth ? theme.backgroundSecondary : theme.backgroundDefault },
                  day.isToday && { borderColor: theme.primary, borderWidth: 2 },
                ]}
                onPress={() => handleDayPress(day)}
              >
                <ThemedText
                  style={[
                    styles.dayNumber,
                    { color: day.isCurrentMonth ? theme.text : theme.textSecondary },
                    day.isToday && { color: theme.primary, fontWeight: "700" },
                  ]}
                >
                  {day.date.getDate()}
                </ThemedText>
                <View
                  style={[
                    styles.kitBadge,
                    {
                      backgroundColor: hasOrders
                        ? (loadLevel === "high" ? "#F44336" : loadLevel === "medium" ? "#FF9800" : "#4CAF50")
                        : theme.backgroundTertiary || theme.border,
                    },
                  ]}
                >
                  <ThemedText style={[styles.kitBadgeText, !hasOrders && { color: theme.textSecondary }]}>
                    {day.kitCount}
                  </ThemedText>
                </View>
              </Pressable>
            );
          })}
        </View>

        <View style={styles.legendContainer}>
          <ThemedText style={[styles.legendTitle, { color: theme.textSecondary }]}>Заказов на день:</ThemedText>
          <View style={styles.legendItems}>
            <View style={styles.legendItem}>
              <View style={[styles.legendDot, { backgroundColor: "#4CAF50" }]} />
              <ThemedText style={[styles.legendText, { color: theme.textSecondary }]}>1-4</ThemedText>
            </View>
            <View style={styles.legendItem}>
              <View style={[styles.legendDot, { backgroundColor: "#FF9800" }]} />
              <ThemedText style={[styles.legendText, { color: theme.textSecondary }]}>5-9</ThemedText>
            </View>
            <View style={styles.legendItem}>
              <View style={[styles.legendDot, { backgroundColor: "#F44336" }]} />
              <ThemedText style={[styles.legendText, { color: theme.textSecondary }]}>10+</ThemedText>
            </View>
          </View>
        </View>
      </ScreenScrollView>

      <Modal visible={showOrdersModal} animationType="slide" transparent>
        <View style={styles.modalOverlay}>
          <ThemedView style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>
                {selectedDate ? formatDisplayDate(selectedDate) : ""}
              </ThemedText>
              <Pressable onPress={() => setShowOrdersModal(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <View style={styles.modalStats}>
              <ThemedText style={{ color: theme.textSecondary }}>
                Комплектов: <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>
                  {selectedDate ? getKitCountForDate(selectedDate) : 0}
                </ThemedText>
              </ThemedText>
              <ThemedText style={{ color: theme.textSecondary }}>
                Заказов: <ThemedText style={{ color: theme.text, fontWeight: "600" }}>
                  {selectedOrders.length}
                </ThemedText>
              </ThemedText>
            </View>

            <ScrollView style={styles.ordersList}>
              {selectedOrders.length === 0 ? (
                <View style={styles.emptyOrders}>
                  <Icon name="calendar" size={48} color={theme.textSecondary} />
                  <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                    Нет заказов на эту дату
                  </ThemedText>
                </View>
              ) : (
                selectedOrders.map(order => {
                  const statusConfig = STATUS_CONFIG[order.status];
                  return (
                    <Pressable
                      key={order.id}
                      style={[styles.orderCard, { backgroundColor: theme.backgroundSecondary }]}
                      onPress={() => handleOrderPress(order.id)}
                    >
                      <View style={styles.orderHeader}>
                        <ThemedText style={styles.orderNumber}>#{order.orderNumber}</ThemedText>
                        <View style={[styles.statusBadge, { backgroundColor: statusConfig.color + "20" }]}>
                          <ThemedText style={[styles.statusText, { color: statusConfig.color }]}>
                            {statusConfig.label}
                          </ThemedText>
                        </View>
                      </View>
                      <ThemedText style={{ color: theme.text }}>{getClientName(order.clientId)}</ThemedText>
                      <View style={styles.orderDetails}>
                        <View style={styles.orderDetail}>
                          <Icon name="package" size={14} color={theme.textSecondary} />
                          <ThemedText style={{ color: theme.textSecondary, fontSize: 12 }}>
                            {order.kitCount + (order.spareReceiverCount || 0)} прм.
                          </ThemedText>
                        </View>
                        <View style={styles.orderDetail}>
                          <Icon name="calendar" size={14} color={theme.textSecondary} />
                          <ThemedText style={{ color: theme.textSecondary, fontSize: 12 }}>
                            {new Date(order.startDate).toLocaleDateString("ru-RU", { day: "2-digit", month: "2-digit" })}
                            {" - "}
                            {new Date(order.endDate).toLocaleDateString("ru-RU", { day: "2-digit", month: "2-digit" })}
                          </ThemedText>
                        </View>
                      </View>
                    </Pressable>
                  );
                })
              )}
            </ScrollView>

            <Pressable
              style={[styles.createOrderBtn, { backgroundColor: theme.primary }]}
              onPress={handleCreateOrder}
            >
              <Icon name="plus" size={20} color={theme.buttonText} />
              <ThemedText style={{ color: theme.buttonText, fontWeight: "600" }}>
                Создать заказ
              </ThemedText>
            </Pressable>
          </ThemedView>
        </View>
      </Modal>
    </>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    marginBottom: Spacing.md,
  },
  navButton: {
    padding: Spacing.sm,
  },
  monthTitle: {
    fontSize: 20,
    fontWeight: "700",
  },
  statsRow: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-around",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.md,
  },
  statItem: {
    alignItems: "center",
    flex: 1,
  },
  statValue: {
    fontSize: 24,
    fontWeight: "700",
    lineHeight: 32,
  },
  statLabel: {
    fontSize: 11,
    textAlign: "center",
  },
  statDivider: {
    width: 1,
    height: 32,
  },
  weekdayRow: {
    flexDirection: "row",
    marginBottom: Spacing.xs,
  },
  weekdayCell: {
    flex: 1,
    alignItems: "center",
    paddingVertical: Spacing.xs,
  },
  weekdayText: {
    fontSize: 12,
    fontWeight: "600",
  },
  calendarGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
  },
  dayCell: {
    width: "14.28%",
    aspectRatio: 1,
    alignItems: "center",
    justifyContent: "center",
    borderRadius: BorderRadius.sm,
    marginBottom: 2,
    position: "relative",
  },
  dayNumber: {
    fontSize: 14,
  },
  kitBadge: {
    position: "absolute",
    bottom: 2,
    right: 2,
    minWidth: 16,
    height: 16,
    borderRadius: 8,
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: 4,
  },
  kitBadgeText: {
    color: "#fff",
    fontSize: 10,
    fontWeight: "700",
  },
  legendContainer: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    marginTop: Spacing.md,
    gap: Spacing.md,
  },
  legendTitle: {
    fontSize: 12,
  },
  legendItems: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  legendItem: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
  },
  legendDot: {
    width: 12,
    height: 12,
    borderRadius: 6,
  },
  legendText: {
    fontSize: 12,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
    justifyContent: "flex-end",
  },
  modalContent: {
    borderTopLeftRadius: BorderRadius.lg,
    borderTopRightRadius: BorderRadius.lg,
    padding: Spacing.xl,
    maxHeight: "80%",
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "700",
  },
  modalStats: {
    flexDirection: "row",
    gap: Spacing.xl,
    marginBottom: Spacing.md,
  },
  ordersList: {
    maxHeight: 300,
  },
  emptyOrders: {
    alignItems: "center",
    paddingVertical: Spacing.xl,
    gap: Spacing.sm,
  },
  emptyText: {
    fontSize: 14,
  },
  orderCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    marginBottom: Spacing.sm,
  },
  orderHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.xs,
  },
  orderNumber: {
    fontSize: 16,
    fontWeight: "600",
  },
  statusBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.xs,
  },
  statusText: {
    fontSize: 11,
    fontWeight: "600",
  },
  orderDetails: {
    flexDirection: "row",
    gap: Spacing.md,
    marginTop: Spacing.xs,
  },
  orderDetail: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
  },
  createOrderBtn: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.sm,
    marginTop: Spacing.md,
  },
});
