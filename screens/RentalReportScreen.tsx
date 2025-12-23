import { useState, useMemo } from "react";
import { View, StyleSheet, Pressable, Platform } from "react-native";
import DateTimePicker from "@react-native-community/datetimepicker";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useRental } from "@/contexts/RentalContext";
import { useAuth } from "@/contexts/AuthContext";
import { useData } from "@/contexts/DataContext";

type Period = "day" | "week" | "month" | "year" | "all" | "custom";

const periodLabels: Record<Period, string> = {
  day: "День",
  week: "Неделя",
  month: "Месяц",
  year: "Год",
  all: "Всё время",
  custom: "Период",
};

export default function RentalReportScreen() {
  const { theme } = useTheme();
  const { isAdmin, managers } = useAuth();
  const { rentalOrders, rentalClients, rentalPayments, rentalCommissions } = useRental();
  const { equipmentLosses } = useData();
  const [period, setPeriod] = useState<Period>("month");
  const [customFrom, setCustomFrom] = useState<Date>(new Date());
  const [customTo, setCustomTo] = useState<Date>(new Date());
  const [showDatePicker, setShowDatePicker] = useState<"from" | "to" | null>(null);

  const formatShortDate = (date: Date) => {
    return date.toLocaleDateString("ru-RU", { day: "numeric", month: "short" });
  };

  if (!isAdmin) {
    return (
      <ScreenScrollView>
        <View style={{ gap: Spacing.lg }}>
          <ThemedText style={{ fontSize: 16, fontWeight: "600" }}>Доступ запрещён</ThemedText>
          <ThemedText style={{ textAlign: "center", color: theme.textSecondary }}>
            Этот раздел доступен только администраторам
          </ThemedText>
        </View>
      </ScreenScrollView>
    );
  }

  const filterByPeriod = (date: string) => {
    const itemDate = new Date(date);
    const now = new Date();

    switch (period) {
      case "day":
        return itemDate.toDateString() === now.toDateString();
      case "week":
        const weekAgo = new Date(now);
        weekAgo.setDate(now.getDate() - 7);
        return itemDate >= weekAgo;
      case "month":
        const monthAgo = new Date(now);
        monthAgo.setMonth(now.getMonth() - 1);
        return itemDate >= monthAgo;
      case "year":
        const yearAgo = new Date(now);
        yearAgo.setFullYear(now.getFullYear() - 1);
        return itemDate >= yearAgo;
      case "custom":
        const fromDate = new Date(customFrom);
        fromDate.setHours(0, 0, 0, 0);
        const toDate = new Date(customTo);
        toDate.setHours(23, 59, 59, 999);
        return itemDate >= fromDate && itemDate <= toDate;
      default:
        return true;
    }
  };

  const stats = useMemo(() => {
    const filteredOrders = rentalOrders.filter((o) => filterByPeriod(o.createdAt));
    const filteredPayments = rentalPayments.filter((p) => filterByPeriod(p.createdAt));
    const filteredCommissions = rentalCommissions.filter((c) => filterByPeriod(c.createdAt));
    const filteredLosses = equipmentLosses.filter((l) => l.rentalOrderId && filterByPeriod(l.createdAt));

    const totalOrders = filteredOrders.length;
    const newOrders = filteredOrders.filter(o => o.status === "new").length;
    const issuedOrders = filteredOrders.filter(o => o.status === "issued").length;
    const returnedOrders = filteredOrders.filter(o => o.status === "returned").length;
    const completedOrders = filteredOrders.filter(o => o.status === "completed").length;
    const cancelledOrders = filteredOrders.filter(o => o.status === "cancelled").length;

    const totalRevenue = filteredPayments
      .filter(p => p.type !== "refund" && p.type !== "service_expense")
      .reduce((sum, p) => sum + p.amount, 0);
    
    const totalRefunds = filteredPayments
      .filter(p => p.type === "refund")
      .reduce((sum, p) => sum + p.amount, 0);

    const serviceExpenses = filteredPayments
      .filter(p => p.type === "service_expense")
      .reduce((sum, p) => sum + p.amount, 0);

    const paidCommissionsAmount = filteredCommissions.filter(c => c.status === "paid").reduce((sum, c) => sum + c.amount, 0);
    const pendingCommissionsAmount = filteredCommissions.filter(c => c.status === "pending").reduce((sum, c) => sum + c.amount, 0);

    const totalExpenses = serviceExpenses + paidCommissionsAmount;

    const netRevenue = totalRevenue - totalRefunds - totalExpenses;

    const totalReceivers = filteredOrders.reduce((sum, o) => sum + (o.kitCount || 0) + (o.spareReceiverCount || 0), 0);
    const totalTransmitters = filteredOrders.reduce((sum, o) => sum + (o.transmitterCount || 0), 0);

    const pendingCommissions = pendingCommissionsAmount;
    const paidCommissions = paidCommissionsAmount;

    const lostCount = filteredLosses.filter(l => l.status === "lost").reduce((sum, l) => sum + l.missingCount, 0);
    const foundCount = filteredLosses.filter(l => l.status === "found").reduce((sum, l) => sum + l.missingCount, 0);

    const managerStats = managers.map(manager => {
      const ownerOrders = filteredOrders.filter(o => o.ownerManagerId === manager.id);
      const executorOrders = filteredOrders.filter(o => o.executorId === manager.id);
      const managerCommissions = filteredCommissions.filter(c => c.recipientId === manager.id);
      const totalCommission = managerCommissions.reduce((sum, c) => sum + c.amount, 0);
      return {
        manager,
        ownerOrdersCount: ownerOrders.length,
        executorOrdersCount: executorOrders.length,
        totalCommission,
      };
    }).filter(ms => ms.ownerOrdersCount > 0 || ms.executorOrdersCount > 0);

    const clientStats = rentalClients.map(client => {
      const clientOrders = filteredOrders.filter(o => o.clientId === client.id);
      const clientRevenue = clientOrders.reduce((sum, o) => sum + o.totalPrice, 0);
      return { client, ordersCount: clientOrders.length, revenue: clientRevenue };
    }).filter(cs => cs.ordersCount > 0).sort((a, b) => b.revenue - a.revenue).slice(0, 5);

    return {
      totalOrders,
      newOrders,
      issuedOrders,
      returnedOrders,
      completedOrders,
      cancelledOrders,
      totalRevenue,
      totalRefunds,
      totalExpenses,
      netRevenue,
      totalReceivers,
      totalTransmitters,
      pendingCommissions,
      paidCommissions,
      lostCount,
      foundCount,
      managerStats,
      clientStats,
    };
  }, [rentalOrders, rentalPayments, rentalCommissions, equipmentLosses, managers, rentalClients, period, customFrom, customTo]);

  const handleDateChange = (event: any, selectedDate?: Date) => {
    if (Platform.OS === "android") {
      setShowDatePicker(null);
    }
    if (selectedDate) {
      if (showDatePicker === "from") {
        setCustomFrom(selectedDate);
      } else {
        setCustomTo(selectedDate);
      }
    }
  };

  const formatCurrency = (amount: number) => {
    return amount.toLocaleString("ru-RU") + " р.";
  };

  const styles = createStyles(theme);

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <View style={styles.periodSelector}>
          {(Object.keys(periodLabels) as Period[]).map((p) => (
            <Pressable
              key={p}
              style={[styles.periodButton, period === p && { backgroundColor: theme.primary }]}
              onPress={() => setPeriod(p)}
            >
              <ThemedText style={[styles.periodButtonText, period === p && { color: theme.buttonText }]}>
                {periodLabels[p]}
              </ThemedText>
            </Pressable>
          ))}
        </View>

        {period === "custom" ? (
          <View style={styles.customDateRow}>
            <Pressable style={styles.dateButton} onPress={() => setShowDatePicker("from")}>
              <Icon name="calendar" size={16} color={theme.primary} />
              <ThemedText>{formatShortDate(customFrom)}</ThemedText>
            </Pressable>
            <ThemedText style={{ color: theme.textSecondary }}>—</ThemedText>
            <Pressable style={styles.dateButton} onPress={() => setShowDatePicker("to")}>
              <Icon name="calendar" size={16} color={theme.primary} />
              <ThemedText>{formatShortDate(customTo)}</ThemedText>
            </Pressable>
          </View>
        ) : null}

        {showDatePicker ? (
          <DateTimePicker
            value={showDatePicker === "from" ? customFrom : customTo}
            mode="date"
            display={Platform.OS === "ios" ? "spinner" : "default"}
            onChange={handleDateChange}
            themeVariant="light"
            locale="ru"
          />
        ) : null}

        <ThemedText style={styles.sectionTitle}>Заказы</ThemedText>
        <View style={styles.statsGrid}>
          <ThemedView style={styles.statCard}>
            <ThemedText style={styles.statValue}>{stats.totalOrders}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Всего</ThemedText>
          </ThemedView>
          <ThemedView style={styles.statCard}>
            <ThemedText style={[styles.statValue, { color: "#2196F3" }]}>{stats.newOrders}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Новых</ThemedText>
          </ThemedView>
          <ThemedView style={styles.statCard}>
            <ThemedText style={[styles.statValue, { color: "#4CAF50" }]}>{stats.issuedOrders}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Выдано</ThemedText>
          </ThemedView>
          <ThemedView style={styles.statCard}>
            <ThemedText style={[styles.statValue, { color: "#9C27B0" }]}>{stats.completedOrders}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Завершено</ThemedText>
          </ThemedView>
        </View>

        <ThemedText style={styles.sectionTitle}>Финансы</ThemedText>
        <ThemedView style={styles.financeCard}>
          <View style={styles.financeRow}>
            <ThemedText style={{ color: theme.textSecondary }}>Выручка</ThemedText>
            <ThemedText style={[styles.financeValue, { color: theme.success }]}>{formatCurrency(stats.totalRevenue)}</ThemedText>
          </View>
          <View style={styles.financeRow}>
            <ThemedText style={{ color: theme.textSecondary }}>Возвраты</ThemedText>
            <ThemedText style={[styles.financeValue, { color: theme.error }]}>-{formatCurrency(stats.totalRefunds)}</ThemedText>
          </View>
          <View style={styles.financeRow}>
            <ThemedText style={{ color: theme.textSecondary }}>Расходы</ThemedText>
            <ThemedText style={[styles.financeValue, { color: theme.warning }]}>-{formatCurrency(stats.totalExpenses)}</ThemedText>
          </View>
          <View style={[styles.financeRow, styles.financeTotal]}>
            <ThemedText style={styles.financeTotalLabel}>Чистая выручка</ThemedText>
            <ThemedText style={[styles.financeTotalValue, { color: stats.netRevenue >= 0 ? theme.success : theme.error }]}>
              {formatCurrency(stats.netRevenue)}
            </ThemedText>
          </View>
        </ThemedView>

        <ThemedText style={styles.sectionTitle}>Оборудование</ThemedText>
        <View style={styles.statsRow}>
          <ThemedView style={styles.equipmentCard}>
            <Icon name="radio" size={20} color={theme.primary} />
            <ThemedText style={styles.equipmentValue}>{stats.totalReceivers}</ThemedText>
            <ThemedText style={[styles.equipmentLabel, { color: theme.textSecondary }]}>Приёмников</ThemedText>
          </ThemedView>
          <ThemedView style={styles.equipmentCard}>
            <Icon name="mic" size={20} color={theme.primary} />
            <ThemedText style={styles.equipmentValue}>{stats.totalTransmitters}</ThemedText>
            <ThemedText style={[styles.equipmentLabel, { color: theme.textSecondary }]}>Передатчиков</ThemedText>
          </ThemedView>
        </View>

        <ThemedText style={styles.sectionTitle}>Утери по аренде</ThemedText>
        <View style={styles.statsRow}>
          <ThemedView style={[styles.lossCard, { borderLeftColor: theme.error }]}>
            <ThemedText style={[styles.lossValue, { color: theme.error }]}>{stats.lostCount}</ThemedText>
            <ThemedText style={[styles.lossLabel, { color: theme.textSecondary }]}>Потеряно</ThemedText>
          </ThemedView>
          <ThemedView style={[styles.lossCard, { borderLeftColor: theme.success }]}>
            <ThemedText style={[styles.lossValue, { color: theme.success }]}>{stats.foundCount}</ThemedText>
            <ThemedText style={[styles.lossLabel, { color: theme.textSecondary }]}>Найдено</ThemedText>
          </ThemedView>
        </View>

        <ThemedText style={styles.sectionTitle}>Комиссии</ThemedText>
        <View style={styles.statsRow}>
          <ThemedView style={styles.commissionCard}>
            <ThemedText style={[styles.commissionValue, { color: theme.warning }]}>{formatCurrency(stats.pendingCommissions)}</ThemedText>
            <ThemedText style={[styles.commissionLabel, { color: theme.textSecondary }]}>К выплате</ThemedText>
          </ThemedView>
          <ThemedView style={styles.commissionCard}>
            <ThemedText style={[styles.commissionValue, { color: theme.success }]}>{formatCurrency(stats.paidCommissions)}</ThemedText>
            <ThemedText style={[styles.commissionLabel, { color: theme.textSecondary }]}>Выплачено</ThemedText>
          </ThemedView>
        </View>

        {stats.managerStats.length > 0 ? (
          <>
            <ThemedText style={styles.sectionTitle}>По менеджерам</ThemedText>
            {stats.managerStats.map((ms) => (
              <ThemedView key={ms.manager.id} style={styles.managerCard}>
                <ThemedText style={styles.managerName}>{ms.manager.display_name}</ThemedText>
                <View style={styles.managerStats}>
                  <View style={styles.managerStat}>
                    <ThemedText style={styles.managerStatValue}>{ms.ownerOrdersCount}</ThemedText>
                    <ThemedText style={[styles.managerStatLabel, { color: theme.textSecondary }]}>владелец</ThemedText>
                  </View>
                  <View style={styles.managerStat}>
                    <ThemedText style={styles.managerStatValue}>{ms.executorOrdersCount}</ThemedText>
                    <ThemedText style={[styles.managerStatLabel, { color: theme.textSecondary }]}>исполнитель</ThemedText>
                  </View>
                  <View style={styles.managerStat}>
                    <ThemedText style={[styles.managerStatValue, { color: theme.success }]}>{formatCurrency(ms.totalCommission)}</ThemedText>
                    <ThemedText style={[styles.managerStatLabel, { color: theme.textSecondary }]}>комиссия</ThemedText>
                  </View>
                </View>
              </ThemedView>
            ))}
          </>
        ) : null}

        {stats.clientStats.length > 0 ? (
          <>
            <ThemedText style={styles.sectionTitle}>Топ клиентов</ThemedText>
            {stats.clientStats.map((cs, index) => (
              <ThemedView key={cs.client.id} style={styles.clientCard}>
                <View style={styles.clientRank}>
                  <ThemedText style={[styles.rankNumber, { color: theme.primary }]}>{index + 1}</ThemedText>
                </View>
                <View style={styles.clientInfo}>
                  <ThemedText style={styles.clientName}>{cs.client.name}</ThemedText>
                  <ThemedText style={[styles.clientOrders, { color: theme.textSecondary }]}>{cs.ordersCount} заказов</ThemedText>
                </View>
                <ThemedText style={[styles.clientRevenue, { color: theme.success }]}>{formatCurrency(cs.revenue)}</ThemedText>
              </ThemedView>
            ))}
          </>
        ) : null}

        <View style={{ height: 40 }} />
      </View>
    </ScreenScrollView>
  );
}

const createStyles = (theme: any) => StyleSheet.create({
  container: {
    gap: Spacing.lg,
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginTop: Spacing.md,
  },
  periodSelector: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.xs,
  },
  periodButton: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    backgroundColor: theme.backgroundSecondary,
  },
  periodButtonText: {
    fontSize: 13,
  },
  customDateRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
  },
  dateButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    backgroundColor: theme.backgroundSecondary,
  },
  statsGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.md,
  },
  statCard: {
    flex: 1,
    minWidth: "45%",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    alignItems: "center",
    gap: Spacing.xs,
    backgroundColor: theme.backgroundSecondary,
  },
  statValue: {
    fontSize: 24,
    fontWeight: "700",
  },
  statLabel: {
    fontSize: 12,
  },
  statsRow: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  financeCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
    backgroundColor: theme.backgroundSecondary,
  },
  financeRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  financeValue: {
    fontSize: 16,
    fontWeight: "600",
  },
  financeTotal: {
    marginTop: Spacing.sm,
    paddingTop: Spacing.sm,
    borderTopWidth: 1,
    borderTopColor: theme.border,
  },
  financeTotalLabel: {
    fontWeight: "600",
  },
  financeTotalValue: {
    fontSize: 18,
    fontWeight: "700",
  },
  equipmentCard: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    alignItems: "center",
    gap: Spacing.xs,
    backgroundColor: theme.backgroundSecondary,
  },
  equipmentValue: {
    fontSize: 20,
    fontWeight: "700",
  },
  equipmentLabel: {
    fontSize: 11,
  },
  lossCard: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    borderLeftWidth: 3,
    alignItems: "center",
    backgroundColor: theme.backgroundSecondary,
  },
  lossValue: {
    fontSize: 20,
    fontWeight: "700",
  },
  lossLabel: {
    fontSize: 11,
  },
  commissionCard: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    alignItems: "center",
    gap: Spacing.xs,
    backgroundColor: theme.backgroundSecondary,
  },
  commissionValue: {
    fontSize: 16,
    fontWeight: "600",
  },
  commissionLabel: {
    fontSize: 11,
  },
  managerCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
    backgroundColor: theme.backgroundSecondary,
  },
  managerName: {
    fontSize: 15,
    fontWeight: "600",
  },
  managerStats: {
    flexDirection: "row",
    gap: Spacing.lg,
  },
  managerStat: {
    alignItems: "center",
  },
  managerStatValue: {
    fontSize: 16,
    fontWeight: "600",
  },
  managerStatLabel: {
    fontSize: 10,
  },
  clientCard: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.md,
    backgroundColor: theme.backgroundSecondary,
  },
  clientRank: {
    width: 28,
    height: 28,
    borderRadius: 14,
    backgroundColor: theme.primary + "20",
    alignItems: "center",
    justifyContent: "center",
  },
  rankNumber: {
    fontSize: 14,
    fontWeight: "700",
  },
  clientInfo: {
    flex: 1,
  },
  clientName: {
    fontSize: 14,
    fontWeight: "500",
  },
  clientOrders: {
    fontSize: 12,
  },
  clientRevenue: {
    fontSize: 14,
    fontWeight: "600",
  },
});
