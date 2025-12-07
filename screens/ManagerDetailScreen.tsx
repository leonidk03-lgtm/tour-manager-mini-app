import { useState, useMemo } from "react";
import { View, StyleSheet, Pressable } from "react-native";
import { Feather } from "@expo/vector-icons";
import { useRoute, RouteProp } from "@react-navigation/native";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";
import { calculateExcursionRevenue } from "@/utils/calculations";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";

type PeriodFilter = "day" | "week" | "month" | "all";

const formatDate = (dateString: string) => {
  const date = new Date(dateString);
  return date.toLocaleDateString("ru-RU", { day: "numeric", month: "short" });
};

const formatCurrency = (amount: number) => {
  return new Intl.NumberFormat("ru-RU").format(amount) + " ₽";
};

const getRoleLabel = (role: string): string => {
  switch (role) {
    case "admin": return "Администратор";
    case "manager": return "Менеджер";
    case "radio_dispatcher": return "Диспетчер радиогидов";
    default: return role;
  }
};

export default function ManagerDetailScreen() {
  const { theme } = useTheme();
  const route = useRoute<RouteProp<SettingsStackParamList, "ManagerDetail">>();
  const { manager } = route.params;
  const { excursions, transactions, tourTypes, additionalServices } = useData();
  const [period, setPeriod] = useState<PeriodFilter>("all");

  const filterByPeriod = (date: string) => {
    const itemDate = new Date(date);
    const now = new Date();
    
    switch (period) {
      case "day":
        return itemDate.toDateString() === now.toDateString();
      case "week":
        const weekAgo = new Date(now);
        weekAgo.setDate(weekAgo.getDate() - 7);
        return itemDate >= weekAgo;
      case "month":
        const monthAgo = new Date(now);
        monthAgo.setMonth(monthAgo.getMonth() - 1);
        return itemDate >= monthAgo;
      case "all":
        return true;
      default:
        return true;
    }
  };

  const managerExcursions = useMemo(() => {
    return excursions
      .filter(e => e.managerId === manager.id && filterByPeriod(e.date))
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());
  }, [excursions, manager.id, period]);

  const managerTransactions = useMemo(() => {
    return transactions
      .filter(t => t.managerId === manager.id && filterByPeriod(t.date))
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());
  }, [transactions, manager.id, period]);

  const getExcursionRevenue = (excursion: typeof excursions[0]) => {
    const tourType = tourTypes.find(t => t.id === excursion.tourTypeId);
    if (!tourType) return 0;
    return calculateExcursionRevenue(excursion, tourType, additionalServices);
  };

  const stats = useMemo(() => {
    let totalRevenue = 0;
    let totalExpenses = 0;
    let totalParticipants = 0;

    managerExcursions.forEach(excursion => {
      const tourType = tourTypes.find(t => t.id === excursion.tourTypeId);
      if (tourType) {
        totalRevenue += calculateExcursionRevenue(excursion, tourType, additionalServices);
      }
      excursion.expenses.forEach(exp => {
        totalExpenses += exp.amount;
      });
      totalParticipants += excursion.fullPriceCount + excursion.discountedCount + 
        excursion.freeCount + excursion.tourPackageCount + excursion.byTourCount + excursion.paidCount;
    });

    managerTransactions.forEach(t => {
      if (t.type === "income") {
        totalRevenue += t.amount;
      } else {
        totalExpenses += t.amount;
      }
    });

    return {
      excursionsCount: managerExcursions.length,
      transactionsCount: managerTransactions.length,
      totalRevenue,
      totalExpenses,
      profit: totalRevenue - totalExpenses,
      totalParticipants,
    };
  }, [managerExcursions, managerTransactions, tourTypes, additionalServices]);

  const getTourTypeName = (tourTypeId: string) => {
    const tourType = tourTypes.find(t => t.id === tourTypeId);
    return tourType?.name || "Неизвестная экскурсия";
  };

  const periodLabels: Record<PeriodFilter, string> = {
    day: "День",
    week: "Неделя",
    month: "Месяц",
    all: "Все",
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <ThemedView
          style={[
            styles.profileCard,
            { backgroundColor: theme.backgroundSecondary, borderRadius: BorderRadius.md },
          ]}
        >
          <View
            style={[
              styles.avatar,
              {
                backgroundColor: manager.is_active
                  ? (manager.role === "radio_dispatcher" ? theme.warning : theme.primary)
                  : theme.textSecondary,
              },
            ]}
          >
            <Feather
              name={manager.role === "radio_dispatcher" ? "radio" : "user"}
              size={32}
              color={theme.buttonText}
            />
          </View>
          <ThemedText style={styles.profileName}>{manager.display_name}</ThemedText>
          <ThemedText style={[styles.profileEmail, { color: theme.textSecondary }]}>
            {manager.email}
          </ThemedText>
          <View
            style={[
              styles.roleBadge,
              {
                backgroundColor:
                  manager.role === "radio_dispatcher"
                    ? theme.warning + "30"
                    : theme.primary + "30",
              },
            ]}
          >
            <ThemedText
              style={[
                styles.roleText,
                {
                  color:
                    manager.role === "radio_dispatcher" ? theme.warning : theme.primary,
                },
              ]}
            >
              {getRoleLabel(manager.role)}
            </ThemedText>
          </View>
          <View style={[styles.statusBadge, { backgroundColor: manager.is_active ? theme.success + "30" : theme.error + "30" }]}>
            <View style={[styles.statusDot, { backgroundColor: manager.is_active ? theme.success : theme.error }]} />
            <ThemedText style={{ color: manager.is_active ? theme.success : theme.error, fontSize: 12 }}>
              {manager.is_active ? "Активен" : "Неактивен"}
            </ThemedText>
          </View>
        </ThemedView>

        <View style={styles.periodSelector}>
          {(Object.keys(periodLabels) as PeriodFilter[]).map((p) => (
            <Pressable
              key={p}
              onPress={() => setPeriod(p)}
              style={[
                styles.periodButton,
                {
                  backgroundColor: period === p ? theme.primary : theme.backgroundSecondary,
                  borderColor: period === p ? theme.primary : theme.border,
                },
              ]}
            >
              <ThemedText
                style={{
                  color: period === p ? theme.buttonText : theme.text,
                  fontSize: 13,
                  fontWeight: "500",
                }}
              >
                {periodLabels[p]}
              </ThemedText>
            </Pressable>
          ))}
        </View>

        <View style={styles.statsGrid}>
          <ThemedView style={[styles.statCard, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={[styles.statValue, { color: theme.primary }]}>
              {stats.excursionsCount}
            </ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
              Экскурсий
            </ThemedText>
          </ThemedView>
          <ThemedView style={[styles.statCard, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={[styles.statValue, { color: theme.success }]}>
              {stats.totalParticipants}
            </ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
              Участников
            </ThemedText>
          </ThemedView>
          <ThemedView style={[styles.statCard, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={[styles.statValue, { color: theme.success }]}>
              {formatCurrency(stats.totalRevenue)}
            </ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
              Выручка
            </ThemedText>
          </ThemedView>
          <ThemedView style={[styles.statCard, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={[styles.statValue, { color: stats.profit >= 0 ? theme.success : theme.error }]}>
              {formatCurrency(stats.profit)}
            </ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
              Прибыль
            </ThemedText>
          </ThemedView>
        </View>

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>
            Экскурсии ({managerExcursions.length})
          </ThemedText>
          {managerExcursions.length === 0 ? (
            <ThemedView
              style={[styles.emptyState, { backgroundColor: theme.backgroundSecondary }]}
            >
              <Feather name="calendar" size={32} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                Нет экскурсий за выбранный период
              </ThemedText>
            </ThemedView>
          ) : (
            managerExcursions.slice(0, 10).map((excursion) => (
              <ThemedView
                key={excursion.id}
                style={[
                  styles.itemCard,
                  { backgroundColor: theme.backgroundSecondary, borderColor: theme.border },
                ]}
              >
                <View style={styles.itemHeader}>
                  <ThemedText style={styles.itemTitle}>
                    {getTourTypeName(excursion.tourTypeId)}
                  </ThemedText>
                  <ThemedText style={[styles.itemDate, { color: theme.textSecondary }]}>
                    {formatDate(excursion.date)}
                  </ThemedText>
                </View>
                <View style={styles.itemDetails}>
                  <View style={styles.itemDetail}>
                    <Feather name="users" size={14} color={theme.textSecondary} />
                    <ThemedText style={{ color: theme.textSecondary, fontSize: 13 }}>
                      {excursion.fullPriceCount + excursion.discountedCount + excursion.freeCount + 
                        excursion.tourPackageCount + excursion.byTourCount + excursion.paidCount} чел.
                    </ThemedText>
                  </View>
                  <ThemedText style={[styles.itemAmount, { color: theme.success }]}>
                    {formatCurrency(getExcursionRevenue(excursion))}
                  </ThemedText>
                </View>
              </ThemedView>
            ))
          )}
          {managerExcursions.length > 10 ? (
            <ThemedText style={[styles.moreText, { color: theme.textSecondary }]}>
              ... и ещё {managerExcursions.length - 10}
            </ThemedText>
          ) : null}
        </View>

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>
            Транзакции ({managerTransactions.length})
          </ThemedText>
          {managerTransactions.length === 0 ? (
            <ThemedView
              style={[styles.emptyState, { backgroundColor: theme.backgroundSecondary }]}
            >
              <Feather name="credit-card" size={32} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                Нет транзакций за выбранный период
              </ThemedText>
            </ThemedView>
          ) : (
            managerTransactions.slice(0, 10).map((transaction) => (
              <ThemedView
                key={transaction.id}
                style={[
                  styles.itemCard,
                  { backgroundColor: theme.backgroundSecondary, borderColor: theme.border },
                ]}
              >
                <View style={styles.itemHeader}>
                  <View style={styles.transactionType}>
                    <Feather
                      name={transaction.type === "income" ? "arrow-down-left" : "arrow-up-right"}
                      size={16}
                      color={transaction.type === "income" ? theme.success : theme.error}
                    />
                    <ThemedText style={styles.itemTitle}>
                      {transaction.description || (transaction.type === "income" ? "Доход" : "Расход")}
                    </ThemedText>
                  </View>
                  <ThemedText style={[styles.itemDate, { color: theme.textSecondary }]}>
                    {formatDate(transaction.date)}
                  </ThemedText>
                </View>
                <ThemedText
                  style={[
                    styles.transactionAmount,
                    { color: transaction.type === "income" ? theme.success : theme.error },
                  ]}
                >
                  {transaction.type === "income" ? "+" : "-"}{formatCurrency(transaction.amount)}
                </ThemedText>
              </ThemedView>
            ))
          )}
          {managerTransactions.length > 10 ? (
            <ThemedText style={[styles.moreText, { color: theme.textSecondary }]}>
              ... и ещё {managerTransactions.length - 10}
            </ThemedText>
          ) : null}
        </View>
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing.xl,
  },
  profileCard: {
    padding: Spacing.xl,
    alignItems: "center",
    gap: Spacing.sm,
  },
  avatar: {
    width: 72,
    height: 72,
    borderRadius: 36,
    alignItems: "center",
    justifyContent: "center",
    marginBottom: Spacing.sm,
  },
  profileName: {
    fontSize: 22,
    fontWeight: "700",
  },
  profileEmail: {
    fontSize: 14,
  },
  roleBadge: {
    paddingVertical: Spacing.xs,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.xs,
    marginTop: Spacing.xs,
  },
  roleText: {
    fontSize: 13,
    fontWeight: "500",
  },
  statusBadge: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingVertical: Spacing.xs,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.xs,
    marginTop: Spacing.xs,
  },
  statusDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
  },
  periodSelector: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  periodButton: {
    flex: 1,
    paddingVertical: Spacing.sm,
    alignItems: "center",
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
  statsGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.sm,
  },
  statCard: {
    flex: 1,
    minWidth: "45%",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
  statValue: {
    fontSize: 18,
    fontWeight: "700",
  },
  statLabel: {
    fontSize: 12,
    marginTop: Spacing.xs,
  },
  section: {
    gap: Spacing.md,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  emptyState: {
    padding: Spacing.xl,
    alignItems: "center",
    gap: Spacing.sm,
    borderRadius: BorderRadius.sm,
  },
  emptyText: {
    fontSize: 14,
  },
  itemCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    gap: Spacing.sm,
  },
  itemHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  itemTitle: {
    fontSize: 15,
    fontWeight: "500",
    flex: 1,
  },
  itemDate: {
    fontSize: 13,
  },
  itemDetails: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  itemDetail: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
  },
  itemAmount: {
    fontSize: 15,
    fontWeight: "600",
  },
  transactionType: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    flex: 1,
  },
  transactionAmount: {
    fontSize: 16,
    fontWeight: "600",
  },
  moreText: {
    textAlign: "center",
    fontSize: 13,
  },
});
