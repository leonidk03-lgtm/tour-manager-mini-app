import { useState } from "react";
import { View, StyleSheet, RefreshControl } from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { StatCard } from "@/components/StatCard";
import { PeriodSelector } from "@/components/PeriodSelector";
import { ExcursionCard } from "@/components/ExcursionCard";
import { Spacing } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";
import {
  getDateRangeForPeriod,
  filterExcursionsByDateRange,
  calculateTotalRevenue,
  calculateTotalExpenses,
  calculateExcursionRevenue,
  calculateExcursionExpenses,
  calculateExcursionProfit,
  calculateAdditionalTransactionsTotal,
  formatCurrency,
} from "@/utils/calculations";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { MainTabParamList } from "@/navigation/MainTabNavigator";

export default function DashboardScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<MainTabParamList>>();
  const { excursions, tourTypes, additionalServices, transactions } = useData();
  const [selectedPeriod, setSelectedPeriod] = useState<"day" | "week" | "month">("day");
  const [referenceDate] = useState(new Date());
  const [refreshing, setRefreshing] = useState(false);

  const onRefresh = () => {
    setRefreshing(true);
    setTimeout(() => setRefreshing(false), 1000);
  };

  const { startDate, endDate } = getDateRangeForPeriod(selectedPeriod, referenceDate);
  const filteredExcursions = filterExcursionsByDateRange(excursions, startDate, endDate);

  const totalRevenue = calculateTotalRevenue(filteredExcursions, tourTypes, additionalServices);
  const totalExpenses = calculateTotalExpenses(filteredExcursions);
  const additionalIncome = calculateAdditionalTransactionsTotal(
    transactions.filter((t) => t.date >= startDate && t.date <= endDate),
    "income"
  );
  const additionalExpenses = calculateAdditionalTransactionsTotal(
    transactions.filter((t) => t.date >= startDate && t.date <= endDate),
    "expense"
  );
  const netProfit = totalRevenue - totalExpenses + additionalIncome - additionalExpenses;

  const recentExcursions = filteredExcursions.slice(0, 5);

  return (
    <ScreenScrollView
      refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
    >
      <View style={styles.container}>
        <View style={styles.section}>
          <PeriodSelector selectedPeriod={selectedPeriod} onPeriodChange={setSelectedPeriod} />
        </View>

        <View style={styles.section}>
          <View style={styles.statsGrid}>
            <StatCard title="Доход" value={formatCurrency(totalRevenue)} color="default" />
            <StatCard title="Расходы" value={formatCurrency(totalExpenses)} color="default" />
          </View>
          <StatCard
            title="Чистая прибыль"
            value={formatCurrency(netProfit)}
            color={netProfit >= 0 ? "success" : "error"}
          />
        </View>

        <View style={styles.section}>
          <View style={styles.quickStats}>
            <ThemedView style={[styles.quickStatItem, { borderColor: theme.border }]}>
              <Feather name="list" size={20} color={theme.primary} />
              <View style={styles.quickStatText}>
                <ThemedText style={[styles.quickStatValue, { color: theme.text }]}>
                  {filteredExcursions.length}
                </ThemedText>
                <ThemedText style={[styles.quickStatLabel, { color: theme.textSecondary }]}>
                  Экскурсий
                </ThemedText>
              </View>
            </ThemedView>
            <ThemedView style={[styles.quickStatItem, { borderColor: theme.border }]}>
              <Feather name="trending-up" size={20} color={theme.success} />
              <View style={styles.quickStatText}>
                <ThemedText style={[styles.quickStatValue, { color: theme.text }]}>
                  {filteredExcursions.length > 0
                    ? formatCurrency(Math.round(netProfit / filteredExcursions.length))
                    : "0 ₽"}
                </ThemedText>
                <ThemedText style={[styles.quickStatLabel, { color: theme.textSecondary }]}>
                  Средняя прибыль
                </ThemedText>
              </View>
            </ThemedView>
          </View>
        </View>

        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <ThemedText style={styles.sectionTitle}>Последние экскурсии</ThemedText>
          </View>
          {recentExcursions.length > 0 ? (
            <View style={styles.excursionsList}>
              {recentExcursions.map((excursion) => {
                const tourType = tourTypes.find((t) => t.id === excursion.tourTypeId);
                if (!tourType) return null;
                const revenue = calculateExcursionRevenue(excursion, tourType, additionalServices);
                const expenses = calculateExcursionExpenses(excursion);
                const profit = calculateExcursionProfit(excursion, tourType, additionalServices);

                return (
                  <ExcursionCard
                    key={excursion.id}
                    excursion={excursion}
                    tourTypeName={tourType.name}
                    revenue={revenue}
                    expenses={expenses}
                    profit={profit}
                    onPress={() => {
                      (navigation as any).navigate("ExcursionsTab", {
                        screen: "ExcursionDetail",
                        params: { excursionId: excursion.id },
                      });
                    }}
                  />
                );
              })}
            </View>
          ) : (
            <ThemedView
              style={[styles.emptyState, { borderColor: theme.border, backgroundColor: theme.backgroundSecondary }]}
            >
              <Feather name="calendar" size={48} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                Нет экскурсий за выбранный период
              </ThemedText>
            </ThemedView>
          )}
        </View>
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing["2xl"],
  },
  section: {
    gap: Spacing.md,
  },
  statsGrid: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  quickStats: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  quickStatItem: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.lg,
    borderWidth: 1,
    borderRadius: 12,
    gap: Spacing.md,
  },
  quickStatText: {
    gap: Spacing.xs,
  },
  quickStatValue: {
    fontSize: 18,
    fontWeight: "600",
  },
  quickStatLabel: {
    fontSize: 12,
  },
  sectionHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: "600",
  },
  excursionsList: {
    gap: Spacing.md,
  },
  emptyState: {
    padding: Spacing["3xl"],
    alignItems: "center",
    gap: Spacing.lg,
    borderWidth: 1,
    borderRadius: 12,
  },
  emptyText: {
    fontSize: 16,
    textAlign: "center",
  },
});
