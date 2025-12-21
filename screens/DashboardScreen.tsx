import { useState, useMemo, useCallback } from "react";
import { View, StyleSheet, RefreshControl, Pressable, Modal, Platform } from "react-native";
import { Icon } from "@/components/Icon";
import DateTimePicker from "@react-native-community/datetimepicker";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { StatCard } from "@/components/StatCard";
import { NetworkErrorBanner } from "@/components/NetworkErrorBanner";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";
import { useRental } from "@/contexts/RentalContext";
import { useAuth } from "@/contexts/AuthContext";
import {
  getDateRangeForPeriod,
  filterExcursionsByDateRange,
  calculateTotalRevenue,
  calculateTotalExpenses,
  calculateAdditionalTransactionsTotal,
  formatCurrency,
} from "@/utils/calculations";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { MainTabParamList } from "@/navigation/MainTabNavigator";

interface PeriodStats {
  revenue: number;
  excursionExpenses: number;
  additionalIncome: number;
  additionalExpenses: number;
  profit: number;
  excursions: number;
  participants: number;
}

interface RentalPeriodStats {
  orders: number;
  revenue: number;
  activeOrders: number;
}

function PeriodWidget({ 
  title, 
  iconColor,
  stats,
}: { 
  title: string; 
  iconColor: string;
  stats: PeriodStats;
}) {
  const { theme } = useTheme();
  
  return (
    <ThemedView style={[styles.periodWidget, { backgroundColor: theme.backgroundSecondary }]}>
      <View style={styles.periodHeader}>
        <View style={[styles.periodIconBg, { backgroundColor: iconColor + '20' }]}>
          <Icon name="calendar" size={16} color={iconColor} />
        </View>
        <ThemedText style={styles.periodTitle}>{title}</ThemedText>
      </View>
      
      <View style={styles.periodStatsRow}>
        <View style={styles.periodStatMain}>
          <ThemedText style={[styles.periodStatValue, { color: stats.profit >= 0 ? theme.success : theme.error }]}>
            {formatCurrency(stats.profit)}
          </ThemedText>
          <ThemedText style={[styles.periodStatLabel, { color: theme.textSecondary }]}>Прибыль</ThemedText>
        </View>
        
        <View style={styles.periodStatsDivider} />
        
        <View style={styles.periodStatSecondary}>
          <View style={styles.periodStatItem}>
            <ThemedText style={[styles.periodStatSmallValue, { color: theme.text }]}>{stats.excursions}</ThemedText>
            <ThemedText style={[styles.periodStatSmallLabel, { color: theme.textSecondary }]}>Экскурсий</ThemedText>
          </View>
          <View style={styles.periodStatItem}>
            <ThemedText style={[styles.periodStatSmallValue, { color: theme.text }]}>{stats.participants}</ThemedText>
            <ThemedText style={[styles.periodStatSmallLabel, { color: theme.textSecondary }]}>Человек</ThemedText>
          </View>
        </View>
      </View>
    </ThemedView>
  );
}

export default function DashboardScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<MainTabParamList>>();
  const { excursions, tourTypes, additionalServices, transactions } = useData();
  const { rentalOrders } = useRental();
  const { isAdmin, hasPermission } = useAuth();
  const [referenceDate, setReferenceDate] = useState(new Date());
  const [refreshing, setRefreshing] = useState(false);
  const [showDatePicker, setShowDatePicker] = useState(false);
  
  const hasAnyRentalAccess = isAdmin || 
    hasPermission('rental') || 
    hasPermission('rental_clients') ||
    hasPermission('rental_orders') || 
    hasPermission('rental_payments') || 
    hasPermission('rental_commissions') ||
    hasPermission('rental_calendar');
  
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

  const calculatePeriodStats = useCallback((period: "day" | "week" | "month"): PeriodStats => {
    const { startDate, endDate } = getDateRangeForPeriod(period, referenceDate);
    const filtered = filterExcursionsByDateRange(excursions, startDate, endDate);
    const filteredTx = transactions.filter((t) => t.date >= startDate && t.date <= endDate);
    
    const revenue = calculateTotalRevenue(filtered, tourTypes, additionalServices);
    const excursionExpenses = calculateTotalExpenses(filtered);
    const additionalIncome = calculateAdditionalTransactionsTotal(filteredTx, "income");
    const additionalExpenses = calculateAdditionalTransactionsTotal(filteredTx, "expense");
    
    const profit = revenue - excursionExpenses + additionalIncome - additionalExpenses;
    
    const participants = filtered.reduce((sum, exc) => {
      return sum + exc.fullPriceCount + exc.discountedCount + exc.freeCount + 
        exc.byTourCount + exc.paidCount;
    }, 0);
    
    return {
      revenue,
      excursionExpenses,
      additionalIncome,
      additionalExpenses,
      profit,
      excursions: filtered.length,
      participants,
    };
  }, [excursions, transactions, tourTypes, additionalServices, referenceDate]);

  const calculateRentalStats = useCallback((period: "day" | "week" | "month"): RentalPeriodStats => {
    const { startDate, endDate } = getDateRangeForPeriod(period, referenceDate);
    const startDateObj = new Date(startDate);
    const endDateObj = new Date(endDate);
    
    const filteredOrders = rentalOrders.filter(order => {
      const orderDate = new Date(order.startDate);
      return orderDate >= startDateObj && orderDate <= endDateObj;
    });
    
    const revenue = filteredOrders.reduce((sum, order) => sum + (order.totalPrice || 0), 0);
    const activeOrders = rentalOrders.filter(order => 
      order.status === 'new' || order.status === 'issued'
    ).length;
    
    return {
      orders: filteredOrders.length,
      revenue,
      activeOrders,
    };
  }, [rentalOrders, referenceDate]);

  const todayStats = useMemo(() => calculatePeriodStats("day"), [calculatePeriodStats]);
  const weekStats = useMemo(() => calculatePeriodStats("week"), [calculatePeriodStats]);
  const monthStats = useMemo(() => calculatePeriodStats("month"), [calculatePeriodStats]);
  
  const todayRental = useMemo(() => calculateRentalStats("day"), [calculateRentalStats]);
  const weekRental = useMemo(() => calculateRentalStats("week"), [calculateRentalStats]);
  const monthRental = useMemo(() => calculateRentalStats("month"), [calculateRentalStats]);

  return (
    <ScreenScrollView
      refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
    >
      <NetworkErrorBanner />
      <View style={styles.container}>
        <View style={styles.section}>
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
                navigation.navigate('DailyReport' as never);
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
          <ThemedText style={styles.sectionTitle}>Сегодня</ThemedText>
          <View style={styles.statsGrid}>
            <StatCard title="Доход" value={formatCurrency(todayStats.revenue)} color="default" />
            <StatCard title="Расходы" value={formatCurrency(todayStats.excursionExpenses + todayStats.additionalExpenses)} color="default" />
          </View>
          <StatCard
            title="Чистая прибыль"
            value={formatCurrency(todayStats.profit)}
            color={todayStats.profit >= 0 ? "success" : "error"}
          />
          <View style={styles.quickStats}>
            <ThemedView style={[styles.quickStatItem, { borderColor: theme.border }]}>
              <Icon name="users" size={20} color={theme.primary} />
              <View style={styles.quickStatText}>
                <ThemedText style={[styles.quickStatValue, { color: theme.text }]}>
                  {todayStats.participants}
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
                  {todayStats.excursions}
                </ThemedText>
                <ThemedText style={[styles.quickStatLabel, { color: theme.textSecondary }]}>
                  Экскурсий
                </ThemedText>
              </View>
            </ThemedView>
          </View>
        </View>

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>Период</ThemedText>
          <PeriodWidget title="Неделя" iconColor={theme.primary} stats={weekStats} />
          <PeriodWidget title="Месяц" iconColor={theme.warning} stats={monthStats} />
        </View>

        {hasAnyRentalAccess ? (
          <View style={styles.section}>
            <ThemedText style={styles.sectionTitle}>Аренда</ThemedText>
            
            <ThemedView style={[styles.rentalActiveCard, { backgroundColor: theme.backgroundSecondary }]}>
              <View style={styles.rentalActiveHeader}>
                <Icon name="radio" size={20} color={theme.warning} />
                <ThemedText style={styles.rentalActiveLabel}>Активные заказы</ThemedText>
              </View>
              <ThemedText style={[styles.rentalActiveValue, { color: theme.primary }]}>
                {todayRental.activeOrders}
              </ThemedText>
            </ThemedView>
            
            <ThemedView style={[styles.rentalStatsCard, { backgroundColor: theme.backgroundSecondary }]}>
              <View style={styles.rentalStatsHeader}>
                <Icon name="file-text" size={18} color={theme.primary} />
                <ThemedText style={styles.rentalStatsTitle}>Заказов</ThemedText>
              </View>
              <View style={styles.rentalStatsPeriods}>
                <View style={styles.rentalStatsPeriod}>
                  <ThemedText style={[styles.rentalStatsPeriodValue, { color: theme.text }]}>{todayRental.orders}</ThemedText>
                  <ThemedText style={[styles.rentalStatsPeriodLabel, { color: theme.textSecondary }]}>День</ThemedText>
                </View>
                <View style={[styles.rentalStatsDivider, { backgroundColor: theme.border }]} />
                <View style={styles.rentalStatsPeriod}>
                  <ThemedText style={[styles.rentalStatsPeriodValue, { color: theme.text }]}>{weekRental.orders}</ThemedText>
                  <ThemedText style={[styles.rentalStatsPeriodLabel, { color: theme.textSecondary }]}>Неделя</ThemedText>
                </View>
                <View style={[styles.rentalStatsDivider, { backgroundColor: theme.border }]} />
                <View style={styles.rentalStatsPeriod}>
                  <ThemedText style={[styles.rentalStatsPeriodValue, { color: theme.text }]}>{monthRental.orders}</ThemedText>
                  <ThemedText style={[styles.rentalStatsPeriodLabel, { color: theme.textSecondary }]}>Месяц</ThemedText>
                </View>
              </View>
            </ThemedView>
            
            <ThemedView style={[styles.rentalStatsCard, { backgroundColor: theme.backgroundSecondary }]}>
              <View style={styles.rentalStatsHeader}>
                <Icon name="dollar-sign" size={18} color={theme.success} />
                <ThemedText style={styles.rentalStatsTitle}>Доход</ThemedText>
              </View>
              <View style={styles.rentalStatsPeriods}>
                <View style={styles.rentalStatsPeriod}>
                  <ThemedText style={[styles.rentalStatsPeriodValue, { color: theme.success }]}>{formatCurrency(todayRental.revenue)}</ThemedText>
                  <ThemedText style={[styles.rentalStatsPeriodLabel, { color: theme.textSecondary }]}>День</ThemedText>
                </View>
                <View style={[styles.rentalStatsDivider, { backgroundColor: theme.border }]} />
                <View style={styles.rentalStatsPeriod}>
                  <ThemedText style={[styles.rentalStatsPeriodValue, { color: theme.success }]}>{formatCurrency(weekRental.revenue)}</ThemedText>
                  <ThemedText style={[styles.rentalStatsPeriodLabel, { color: theme.textSecondary }]}>Неделя</ThemedText>
                </View>
                <View style={[styles.rentalStatsDivider, { backgroundColor: theme.border }]} />
                <View style={styles.rentalStatsPeriod}>
                  <ThemedText style={[styles.rentalStatsPeriodValue, { color: theme.success }]}>{formatCurrency(monthRental.revenue)}</ThemedText>
                  <ThemedText style={[styles.rentalStatsPeriodLabel, { color: theme.textSecondary }]}>Месяц</ThemedText>
                </View>
              </View>
            </ThemedView>
          </View>
        ) : null}
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
  sectionTitle: {
    fontSize: 20,
    fontWeight: "600",
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
    borderRadius: BorderRadius.sm,
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
  periodWidget: {
    padding: Spacing.lg,
    borderRadius: BorderRadius.sm,
    gap: Spacing.md,
  },
  periodHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  periodIconBg: {
    width: 28,
    height: 28,
    borderRadius: 6,
    alignItems: "center",
    justifyContent: "center",
  },
  periodTitle: {
    fontSize: 16,
    fontWeight: "600",
  },
  periodStatsRow: {
    flexDirection: "row",
    alignItems: "center",
  },
  periodStatMain: {
    flex: 1,
    gap: Spacing.xs,
  },
  periodStatValue: {
    fontSize: 24,
    fontWeight: "700",
  },
  periodStatLabel: {
    fontSize: 12,
  },
  periodStatsDivider: {
    width: 1,
    height: 40,
    backgroundColor: "rgba(128,128,128,0.3)",
    marginHorizontal: Spacing.lg,
  },
  periodStatSecondary: {
    flexDirection: "row",
    gap: Spacing.xl,
  },
  periodStatItem: {
    alignItems: "center",
    gap: Spacing.xs,
  },
  periodStatSmallValue: {
    fontSize: 18,
    fontWeight: "600",
  },
  periodStatSmallLabel: {
    fontSize: 11,
  },
  rentalActiveCard: {
    padding: Spacing.lg,
    borderRadius: BorderRadius.sm,
    gap: Spacing.sm,
  },
  rentalActiveHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  rentalActiveLabel: {
    fontSize: 14,
    fontWeight: "500",
  },
  rentalActiveValue: {
    fontSize: 36,
    fontWeight: "700",
  },
  rentalStatsCard: {
    padding: Spacing.lg,
    borderRadius: BorderRadius.sm,
    gap: Spacing.md,
  },
  rentalStatsHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  rentalStatsTitle: {
    fontSize: 14,
    fontWeight: "500",
  },
  rentalStatsPeriods: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  rentalStatsPeriod: {
    flex: 1,
    alignItems: "center",
    gap: Spacing.xs,
  },
  rentalStatsPeriodValue: {
    fontSize: 16,
    fontWeight: "600",
  },
  rentalStatsPeriodLabel: {
    fontSize: 11,
  },
  rentalStatsDivider: {
    width: 1,
    height: 30,
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
