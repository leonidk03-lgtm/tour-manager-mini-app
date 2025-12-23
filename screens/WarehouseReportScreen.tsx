import { useState, useMemo } from "react";
import { View, StyleSheet, Pressable, Platform } from "react-native";
import DateTimePicker from "@react-native-community/datetimepicker";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";

type Period = "day" | "week" | "month" | "year" | "all" | "custom";

const periodLabels: Record<Period, string> = {
  day: "День",
  week: "Неделя",
  month: "Месяц",
  year: "Год",
  all: "Всё время",
  custom: "Период",
};

export default function WarehouseReportScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const { equipmentCategories, equipmentItems, equipmentMovements, equipmentLosses } = useData();
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
    const filteredMovements = equipmentMovements.filter((m) => filterByPeriod(m.createdAt));
    const filteredLosses = equipmentLosses.filter((l) => filterByPeriod(l.createdAt));

    const receipts = filteredMovements.filter(m => m.type === "receipt");
    const writeoffs = filteredMovements.filter(m => m.type === "writeoff");
    const repairs = filteredMovements.filter(m => m.type === "repair_out" || m.type === "repair_in");
    const losses = filteredMovements.filter(m => m.type === "loss");

    const totalReceived = receipts.reduce((sum, m) => sum + m.quantity, 0);
    const totalWrittenOff = writeoffs.reduce((sum, m) => sum + m.quantity, 0);
    const totalRepairOut = filteredMovements.filter(m => m.type === "repair_out").reduce((sum, m) => sum + m.quantity, 0);
    const totalRepairIn = filteredMovements.filter(m => m.type === "repair_in").reduce((sum, m) => sum + m.quantity, 0);
    const totalLost = losses.reduce((sum, m) => sum + m.quantity, 0);

    const lostItems = filteredLosses.filter(l => l.status === "lost");
    const foundItems = filteredLosses.filter(l => l.status === "found");
    const totalLostCount = lostItems.reduce((sum, l) => sum + l.missingCount, 0);
    const totalFoundCount = foundItems.reduce((sum, l) => sum + l.missingCount, 0);

    const categoryStats = equipmentCategories.map(cat => {
      const items = equipmentItems.filter(i => i.categoryId === cat.id);
      const totalQuantity = items.reduce((sum, i) => sum + i.quantity, 0);
      const totalInRepair = items.reduce((sum, i) => sum + i.inRepair, 0);
      const totalCatWrittenOff = items.reduce((sum, i) => sum + i.writtenOff, 0);
      const lowStockCount = items.filter(i => i.quantity <= i.minQuantity && i.minQuantity > 0).length;
      return { category: cat, totalQuantity, totalInRepair, totalWrittenOff: totalCatWrittenOff, lowStockCount, itemCount: items.length };
    });

    const lowStockItems = equipmentItems.filter(i => i.quantity <= i.minQuantity && i.minQuantity > 0);

    return {
      totalReceived,
      totalWrittenOff,
      totalRepairOut,
      totalRepairIn,
      totalLost,
      totalLostCount,
      totalFoundCount,
      movementsCount: filteredMovements.length,
      categoryStats,
      lowStockItems,
    };
  }, [equipmentMovements, equipmentLosses, equipmentCategories, equipmentItems, period, customFrom, customTo]);

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

        <ThemedText style={styles.sectionTitle}>Движения за период</ThemedText>
        <View style={styles.statsGrid}>
          <ThemedView style={styles.statCard}>
            <Icon name="plus-circle" size={24} color={theme.success} />
            <ThemedText style={styles.statValue}>{stats.totalReceived}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Поступило</ThemedText>
          </ThemedView>
          <ThemedView style={styles.statCard}>
            <Icon name="minus-circle" size={24} color={theme.warning} />
            <ThemedText style={styles.statValue}>{stats.totalWrittenOff}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Списано</ThemedText>
          </ThemedView>
          <ThemedView style={styles.statCard}>
            <Icon name="tool" size={24} color={theme.primary} />
            <ThemedText style={styles.statValue}>{stats.totalRepairOut}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>В ремонт</ThemedText>
          </ThemedView>
          <ThemedView style={styles.statCard}>
            <Icon name="check-circle" size={24} color={theme.success} />
            <ThemedText style={styles.statValue}>{stats.totalRepairIn}</ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Из ремонта</ThemedText>
          </ThemedView>
        </View>

        <ThemedText style={styles.sectionTitle}>Утери за период</ThemedText>
        <View style={styles.statsRow}>
          <ThemedView style={[styles.statCardWide, { borderLeftColor: theme.error }]}>
            <View style={styles.statCardContent}>
              <Icon name="alert-triangle" size={20} color={theme.error} />
              <View>
                <ThemedText style={styles.statValue}>{stats.totalLostCount}</ThemedText>
                <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Потеряно</ThemedText>
              </View>
            </View>
          </ThemedView>
          <ThemedView style={[styles.statCardWide, { borderLeftColor: theme.success }]}>
            <View style={styles.statCardContent}>
              <Icon name="check" size={20} color={theme.success} />
              <View>
                <ThemedText style={styles.statValue}>{stats.totalFoundCount}</ThemedText>
                <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Найдено</ThemedText>
              </View>
            </View>
          </ThemedView>
        </View>

        <ThemedText style={styles.sectionTitle}>Остатки по категориям</ThemedText>
        {stats.categoryStats.map((cs) => (
          <ThemedView key={cs.category.id} style={styles.categoryCard}>
            <View style={styles.categoryHeader}>
              <ThemedText style={styles.categoryName}>{cs.category.name}</ThemedText>
              {cs.lowStockCount > 0 ? (
                <View style={[styles.badge, { backgroundColor: theme.error + "20" }]}>
                  <ThemedText style={{ color: theme.error, fontSize: 12 }}>
                    {cs.lowStockCount} мало
                  </ThemedText>
                </View>
              ) : null}
            </View>
            <View style={styles.categoryStats}>
              <View style={styles.categoryStat}>
                <ThemedText style={[styles.categoryStatValue, { color: theme.success }]}>{cs.totalQuantity}</ThemedText>
                <ThemedText style={[styles.categoryStatLabel, { color: theme.textSecondary }]}>В наличии</ThemedText>
              </View>
              <View style={styles.categoryStat}>
                <ThemedText style={[styles.categoryStatValue, { color: theme.warning }]}>{cs.totalInRepair}</ThemedText>
                <ThemedText style={[styles.categoryStatLabel, { color: theme.textSecondary }]}>В ремонте</ThemedText>
              </View>
              <View style={styles.categoryStat}>
                <ThemedText style={[styles.categoryStatValue, { color: theme.textSecondary }]}>{cs.totalWrittenOff}</ThemedText>
                <ThemedText style={[styles.categoryStatLabel, { color: theme.textSecondary }]}>Списано</ThemedText>
              </View>
            </View>
          </ThemedView>
        ))}

        {stats.lowStockItems.length > 0 ? (
          <>
            <ThemedText style={styles.sectionTitle}>Требуется пополнение</ThemedText>
            {stats.lowStockItems.map((item) => {
              const category = equipmentCategories.find(c => c.id === item.categoryId);
              return (
                <ThemedView key={item.id} style={[styles.lowStockCard, { borderLeftColor: theme.error }]}>
                  <View>
                    <ThemedText style={styles.lowStockName}>{item.name}</ThemedText>
                    <ThemedText style={[styles.lowStockCategory, { color: theme.textSecondary }]}>
                      {category?.name || "Категория"}
                    </ThemedText>
                  </View>
                  <View style={styles.lowStockQuantity}>
                    <ThemedText style={[styles.lowStockValue, { color: theme.error }]}>{item.quantity}</ThemedText>
                    <ThemedText style={[styles.lowStockMin, { color: theme.textSecondary }]}>мин: {item.minQuantity}</ThemedText>
                  </View>
                </ThemedView>
              );
            })}
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
  statCardWide: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    borderLeftWidth: 3,
    backgroundColor: theme.backgroundSecondary,
  },
  statCardContent: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
  },
  categoryCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
    backgroundColor: theme.backgroundSecondary,
  },
  categoryHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  categoryName: {
    fontSize: 15,
    fontWeight: "600",
  },
  badge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  categoryStats: {
    flexDirection: "row",
    gap: Spacing.lg,
  },
  categoryStat: {
    alignItems: "center",
  },
  categoryStatValue: {
    fontSize: 18,
    fontWeight: "600",
  },
  categoryStatLabel: {
    fontSize: 11,
  },
  lowStockCard: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    borderLeftWidth: 3,
    backgroundColor: theme.backgroundSecondary,
  },
  lowStockName: {
    fontSize: 14,
    fontWeight: "500",
  },
  lowStockCategory: {
    fontSize: 12,
  },
  lowStockQuantity: {
    alignItems: "flex-end",
  },
  lowStockValue: {
    fontSize: 18,
    fontWeight: "700",
  },
  lowStockMin: {
    fontSize: 11,
  },
});
