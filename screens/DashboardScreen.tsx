import { useState, useMemo, useCallback } from "react";
import { View, StyleSheet, RefreshControl, Pressable, Modal, Platform } from "react-native";
import { Icon } from "@/components/Icon";
import DateTimePicker from "@react-native-community/datetimepicker";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { StatCard } from "@/components/StatCard";
import { PeriodSelector } from "@/components/PeriodSelector";
import { NetworkErrorBanner } from "@/components/NetworkErrorBanner";
import { Spacing, BorderRadius } from "@/constants/theme";
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
  const { excursions, tourTypes, additionalServices, transactions, activities } = useData();
  const [selectedPeriod, setSelectedPeriod] = useState<"day" | "week" | "month">("day");
  const [referenceDate, setReferenceDate] = useState(new Date());
  const [refreshing, setRefreshing] = useState(false);
  const [showDatePicker, setShowDatePicker] = useState(false);
  
  const handleDateChange = (event: any, date?: Date) => {
    if (Platform.OS === "android") {
      setShowDatePicker(false);
    }
    if (date) {
      setReferenceDate(date);
    }
  };
  
  const formatDisplayDate = (date: Date) => {
    return date.toLocaleDateString("ru-RU", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
    });
  };

  const onRefresh = () => {
    setRefreshing(true);
    setTimeout(() => setRefreshing(false), 1000);
  };

  const { startDate, endDate } = useMemo(
    () => getDateRangeForPeriod(selectedPeriod, referenceDate),
    [selectedPeriod, referenceDate]
  );
  
  const filteredExcursions = useMemo(
    () => filterExcursionsByDateRange(excursions, startDate, endDate),
    [excursions, startDate, endDate]
  );

  const filteredTransactions = useMemo(
    () => transactions.filter((t) => t.date >= startDate && t.date <= endDate),
    [transactions, startDate, endDate]
  );

  const { totalRevenue, totalExpenses, additionalIncome, additionalExpenses, netProfit, totalParticipants } = useMemo(() => {
    const revenue = calculateTotalRevenue(filteredExcursions, tourTypes, additionalServices);
    const expenses = calculateTotalExpenses(filteredExcursions);
    const income = calculateAdditionalTransactionsTotal(filteredTransactions, "income");
    const expensesTx = calculateAdditionalTransactionsTotal(filteredTransactions, "expense");
    const profit = revenue - expenses + income - expensesTx;
    const participants = filteredExcursions.reduce((sum, exc) => {
      return sum + exc.fullPriceCount + exc.discountedCount + exc.freeCount + 
        exc.byTourCount + exc.paidCount;
    }, 0);
    
    return {
      totalRevenue: revenue,
      totalExpenses: expenses,
      additionalIncome: income,
      additionalExpenses: expensesTx,
      netProfit: profit,
      totalParticipants: participants,
    };
  }, [filteredExcursions, tourTypes, additionalServices, filteredTransactions]);

  const recentActivities = useMemo(() => activities.slice(0, 10), [activities]);

  return (
    <ScreenScrollView
      refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
    >
      <NetworkErrorBanner />
      <View style={styles.container}>
        <View style={styles.section}>
          <PeriodSelector selectedPeriod={selectedPeriod} onPeriodChange={setSelectedPeriod} />
          <View style={styles.dateRow}>
            <Pressable
              onPress={() => setShowDatePicker(true)}
              style={[
                styles.dateFilter,
                {
                  backgroundColor: theme.backgroundSecondary,
                  borderRadius: BorderRadius.xs,
                  flex: 1,
                },
              ]}
            >
              <Icon name="calendar" size={20} color={theme.textSecondary} />
              <ThemedText style={[styles.dateText, { color: theme.text }]}>
                {formatDisplayDate(referenceDate)}
              </ThemedText>
            </Pressable>
            <Pressable
              onPress={() => {
                navigation.getParent()?.navigate('SettingsTab', { screen: 'DailyReport' });
              }}
              style={[
                styles.dailyReportButton,
                {
                  backgroundColor: theme.primary,
                  borderRadius: BorderRadius.xs,
                },
              ]}
            >
              <Icon name="clipboard" size={20} color={theme.buttonText} />
            </Pressable>
          </View>
          {showDatePicker ? (
            Platform.OS === "ios" ? (
              <Modal
                visible={showDatePicker}
                transparent
                animationType="fade"
                onRequestClose={() => setShowDatePicker(false)}
              >
                <View style={styles.modalOverlay}>
                  <Pressable style={styles.modalBackdrop} onPress={() => setShowDatePicker(false)} />
                  <ThemedView style={[styles.datePickerModal, { backgroundColor: theme.backgroundDefault }]}>
                    <View style={styles.datePickerHeader}>
                      <ThemedText style={styles.modalTitle}>Выберите дату</ThemedText>
                      <Pressable onPress={() => setShowDatePicker(false)}>
                        <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>Готово</ThemedText>
                      </Pressable>
                    </View>
                    <DateTimePicker
                      value={referenceDate}
                      mode="date"
                      display="spinner"
                      onChange={handleDateChange}
                      locale="ru"
                    />
                  </ThemedView>
                </View>
              </Modal>
            ) : (
              <DateTimePicker
                value={referenceDate}
                mode="date"
                display="default"
                onChange={handleDateChange}
              />
            )
          ) : null}
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
              <Icon name="users" size={20} color={theme.primary} />
              <View style={styles.quickStatText}>
                <ThemedText style={[styles.quickStatValue, { color: theme.text }]}>
                  {totalParticipants}
                </ThemedText>
                <ThemedText style={[styles.quickStatLabel, { color: theme.textSecondary }]}>
                  Человек
                </ThemedText>
              </View>
            </ThemedView>
            <ThemedView style={[styles.quickStatItem, { borderColor: theme.border }]}>
              <Icon name="list" size={20} color={theme.primary} />
              <View style={styles.quickStatText}>
                <ThemedText style={[styles.quickStatValue, { color: theme.text }]}>
                  {filteredExcursions.length}
                </ThemedText>
                <ThemedText style={[styles.quickStatLabel, { color: theme.textSecondary }]}>
                  Экскурсий
                </ThemedText>
              </View>
            </ThemedView>
          </View>
        </View>

        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <ThemedText style={styles.sectionTitle}>Действия менеджеров</ThemedText>
          </View>
          {recentActivities.length > 0 ? (
            <View style={styles.activitiesList}>
              {recentActivities.map((activity) => (
                <ThemedView
                  key={activity.id}
                  style={[
                    styles.activityCard,
                    {
                      backgroundColor: theme.backgroundSecondary,
                      borderRadius: BorderRadius.sm,
                    },
                  ]}
                >
                  <View style={styles.activityIcon}>
                    <Icon
                      name={
                        activity.type === "excursion_added"
                          ? "plus-circle"
                          : activity.type === "excursion_deleted"
                          ? "minus-circle"
                          : activity.type === "transaction_added"
                          ? "dollar-sign"
                          : activity.type === "transaction_deleted"
                          ? "x-circle"
                          : activity.type === "radio_issued"
                          ? "radio"
                          : activity.type === "radio_returned"
                          ? "check-circle"
                          : "activity"
                      }
                      size={20}
                      color={
                        activity.type.includes("added") || activity.type === "radio_returned"
                          ? theme.success
                          : activity.type === "radio_issued"
                          ? theme.primary
                          : theme.error
                      }
                    />
                  </View>
                  <View style={styles.activityContent}>
                    <ThemedText style={styles.activityText}>
                      <ThemedText style={[styles.activityManager, { color: theme.primary }]}>
                        {activity.managerName}
                      </ThemedText>
                      {" "}
                      {activity.description}
                    </ThemedText>
                    <ThemedText style={[styles.activityDate, { color: theme.textSecondary }]}>
                      {new Date(activity.timestamp).toLocaleString("ru-RU", {
                        day: "2-digit",
                        month: "2-digit",
                        year: "numeric",
                        hour: "2-digit",
                        minute: "2-digit",
                      })}
                    </ThemedText>
                  </View>
                </ThemedView>
              ))}
            </View>
          ) : (
            <ThemedView
              style={[styles.emptyState, { borderColor: theme.border, backgroundColor: theme.backgroundSecondary }]}
            >
              <Icon name="activity" size={48} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                Нет действий
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
  activitiesList: {
    gap: Spacing.sm,
  },
  activityCard: {
    flexDirection: "row",
    padding: Spacing.lg,
    gap: Spacing.md,
    alignItems: "flex-start",
  },
  activityIcon: {
    marginTop: Spacing.xs,
  },
  activityContent: {
    flex: 1,
    gap: Spacing.xs,
  },
  activityText: {
    fontSize: 15,
    lineHeight: 20,
  },
  activityManager: {
    fontWeight: "600",
  },
  activityDate: {
    fontSize: 13,
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
  dateRow: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  dateFilter: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.md,
    gap: Spacing.sm,
  },
  dateText: {
    flex: 1,
    fontSize: 16,
  },
  dailyReportButton: {
    width: 48,
    height: 48,
    alignItems: "center",
    justifyContent: "center",
  },
  modalOverlay: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  modalBackdrop: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "rgba(0,0,0,0.5)",
  },
  datePickerModal: {
    borderRadius: BorderRadius.md,
    padding: Spacing.lg,
    width: "90%",
    maxWidth: 360,
  },
  datePickerHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  modalTitle: {
    fontSize: 17,
    fontWeight: "600",
  },
});
