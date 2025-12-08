import { useState, useMemo } from "react";
import { View, StyleSheet, Pressable } from "react-native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";

type Period = "day" | "week" | "month" | "year" | "all";

const periodLabels: Record<Period, string> = {
  day: "День",
  week: "Неделя",
  month: "Месяц",
  year: "Год",
  all: "Всё время",
};

export default function FinancialReportScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const { excursions, transactions, tourTypes, additionalServices } = useData();
  const [period, setPeriod] = useState<Period>("month");

  if (!isAdmin) {
    return (
      <ScreenScrollView>
        <View style={styles.container}>
          <ThemedText style={styles.sectionTitle}>Доступ запрещён</ThemedText>
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
      default:
        return true;
    }
  };

  const stats = useMemo(() => {
    const filteredExcursions = excursions.filter((e) => filterByPeriod(e.date));
    const filteredTransactions = transactions.filter((t) => filterByPeriod(t.date));

    let ticketRevenue = 0;
    let servicesRevenue = 0;
    let excursionExpenses = 0;

    filteredExcursions.forEach((exc) => {
      const tourType = tourTypes.find((t) => t.id === exc.tourTypeId);
      if (tourType) {
        ticketRevenue += exc.fullPriceCount * tourType.fullPrice;
        ticketRevenue += exc.discountedCount * tourType.discountedPrice;
      }

      if (exc.additionalServices) {
        exc.additionalServices.forEach((as) => {
          const service = additionalServices.find((s) => s.id === as.serviceId);
          if (service) {
            servicesRevenue += as.count * service.price;
          }
        });
      }

      if (exc.expenses) {
        exc.expenses.forEach((exp) => {
          excursionExpenses += exp.amount;
        });
      }
    });

    const transactionIncome = filteredTransactions
      .filter((t) => t.type === "income")
      .reduce((sum, t) => sum + t.amount, 0);

    const transactionExpenses = filteredTransactions
      .filter((t) => t.type === "expense")
      .reduce((sum, t) => sum + t.amount, 0);

    const totalRevenue = ticketRevenue + servicesRevenue + transactionIncome;
    const totalExpenses = excursionExpenses + transactionExpenses;
    const profit = totalRevenue - totalExpenses;

    return {
      ticketRevenue,
      servicesRevenue,
      transactionIncome,
      totalRevenue,
      excursionExpenses,
      transactionExpenses,
      totalExpenses,
      profit,
      excursionsCount: filteredExcursions.length,
      transactionsCount: filteredTransactions.length,
    };
  }, [excursions, transactions, tourTypes, additionalServices, period]);

  const formatMoney = (amount: number) => {
    return amount.toLocaleString("ru-RU") + " ₽";
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <View style={styles.periodSelector}>
          {(Object.keys(periodLabels) as Period[]).map((p) => (
            <Pressable
              key={p}
              onPress={() => setPeriod(p)}
              style={[
                styles.periodButton,
                {
                  backgroundColor: period === p ? theme.primary : theme.backgroundSecondary,
                  borderRadius: BorderRadius.xs,
                },
              ]}
            >
              <ThemedText
                style={[
                  styles.periodText,
                  { color: period === p ? theme.buttonText : theme.text },
                ]}
              >
                {periodLabels[p]}
              </ThemedText>
            </Pressable>
          ))}
        </View>

        <ThemedView
          style={[styles.summaryCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
        >
          <View style={styles.summaryHeader}>
            <ThemedText style={styles.summaryTitle}>Итоги</ThemedText>
            <ThemedText style={[styles.summarySubtitle, { color: theme.textSecondary }]}>
              {stats.excursionsCount} экскурсий, {stats.transactionsCount} транзакций
            </ThemedText>
          </View>

          <View style={styles.mainStats}>
            <View style={[styles.mainStatItem, { backgroundColor: theme.success + "20" }]}>
              <Icon name="trending-up" size={24} color={theme.success} />
              <ThemedText style={[styles.mainStatLabel, { color: theme.textSecondary }]}>
                Доходы
              </ThemedText>
              <ThemedText style={[styles.mainStatValue, { color: theme.success }]}>
                {formatMoney(stats.totalRevenue)}
              </ThemedText>
            </View>

            <View style={[styles.mainStatItem, { backgroundColor: theme.error + "20" }]}>
              <Icon name="trending-down" size={24} color={theme.error} />
              <ThemedText style={[styles.mainStatLabel, { color: theme.textSecondary }]}>
                Расходы
              </ThemedText>
              <ThemedText style={[styles.mainStatValue, { color: theme.error }]}>
                {formatMoney(stats.totalExpenses)}
              </ThemedText>
            </View>
          </View>

          <View
            style={[
              styles.profitSection,
              {
                backgroundColor: stats.profit >= 0 ? theme.success + "10" : theme.error + "10",
                borderRadius: BorderRadius.sm,
              },
            ]}
          >
            <ThemedText style={styles.profitLabel}>Прибыль</ThemedText>
            <ThemedText
              style={[
                styles.profitValue,
                { color: stats.profit >= 0 ? theme.success : theme.error },
              ]}
            >
              {stats.profit >= 0 ? "+" : ""}
              {formatMoney(stats.profit)}
            </ThemedText>
          </View>
        </ThemedView>

        <ThemedView
          style={[styles.detailCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
        >
          <ThemedText style={styles.detailTitle}>Детализация доходов</ThemedText>

          <View style={styles.detailRow}>
            <View style={styles.detailLeft}>
              <Icon name="credit-card" size={18} color={theme.textSecondary} />
              <ThemedText style={styles.detailLabel}>Билеты</ThemedText>
            </View>
            <ThemedText style={styles.detailValue}>{formatMoney(stats.ticketRevenue)}</ThemedText>
          </View>

          <View style={[styles.divider, { backgroundColor: theme.border }]} />

          <View style={styles.detailRow}>
            <View style={styles.detailLeft}>
              <Icon name="plus-circle" size={18} color={theme.textSecondary} />
              <ThemedText style={styles.detailLabel}>Доп. услуги</ThemedText>
            </View>
            <ThemedText style={styles.detailValue}>{formatMoney(stats.servicesRevenue)}</ThemedText>
          </View>

          <View style={[styles.divider, { backgroundColor: theme.border }]} />

          <View style={styles.detailRow}>
            <View style={styles.detailLeft}>
              <Icon name="arrow-down-circle" size={18} color={theme.textSecondary} />
              <ThemedText style={styles.detailLabel}>Прочие доходы</ThemedText>
            </View>
            <ThemedText style={styles.detailValue}>{formatMoney(stats.transactionIncome)}</ThemedText>
          </View>
        </ThemedView>

        <ThemedView
          style={[styles.detailCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
        >
          <ThemedText style={styles.detailTitle}>Детализация расходов</ThemedText>

          <View style={styles.detailRow}>
            <View style={styles.detailLeft}>
              <Icon name="map" size={18} color={theme.textSecondary} />
              <ThemedText style={styles.detailLabel}>Расходы на экскурсии</ThemedText>
            </View>
            <ThemedText style={styles.detailValue}>{formatMoney(stats.excursionExpenses)}</ThemedText>
          </View>

          <View style={[styles.divider, { backgroundColor: theme.border }]} />

          <View style={styles.detailRow}>
            <View style={styles.detailLeft}>
              <Icon name="arrow-up-circle" size={18} color={theme.textSecondary} />
              <ThemedText style={styles.detailLabel}>Прочие расходы</ThemedText>
            </View>
            <ThemedText style={styles.detailValue}>{formatMoney(stats.transactionExpenses)}</ThemedText>
          </View>
        </ThemedView>
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing.xl,
  },
  periodSelector: {
    flexDirection: "row",
    gap: Spacing.sm,
    flexWrap: "wrap",
  },
  periodButton: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
  },
  periodText: {
    fontSize: 14,
    fontWeight: "500",
  },
  summaryCard: {
    padding: Spacing.xl,
    borderWidth: 1,
    gap: Spacing.lg,
  },
  summaryHeader: {
    gap: Spacing.xs,
  },
  summaryTitle: {
    fontSize: 20,
    fontWeight: "600",
  },
  summarySubtitle: {
    fontSize: 14,
  },
  mainStats: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  mainStatItem: {
    flex: 1,
    padding: Spacing.lg,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    gap: Spacing.sm,
  },
  mainStatLabel: {
    fontSize: 14,
  },
  mainStatValue: {
    fontSize: 18,
    fontWeight: "700",
  },
  profitSection: {
    padding: Spacing.lg,
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  profitLabel: {
    fontSize: 18,
    fontWeight: "600",
  },
  profitValue: {
    fontSize: 22,
    fontWeight: "700",
  },
  detailCard: {
    padding: Spacing.xl,
    borderWidth: 1,
    gap: Spacing.md,
  },
  detailTitle: {
    fontSize: 18,
    fontWeight: "600",
    marginBottom: Spacing.sm,
  },
  detailRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  detailLeft: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
  },
  detailLabel: {
    fontSize: 16,
  },
  detailValue: {
    fontSize: 16,
    fontWeight: "600",
  },
  divider: {
    height: 1,
  },
});
