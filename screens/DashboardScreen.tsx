import { useState, useMemo, useCallback } from "react";
import { View, StyleSheet, RefreshControl, Pressable, Modal, Platform, ScrollView } from "react-native";
import { Icon } from "@/components/Icon";
import DateTimePicker from "@react-native-community/datetimepicker";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { NetworkErrorBanner } from "@/components/NetworkErrorBanner";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";
import { useRental } from "@/contexts/RentalContext";
import { useAuth } from "@/contexts/AuthContext";
import { DashboardWidgetKey, DEFAULT_DASHBOARD_CONFIG } from "@/lib/supabase";
import {
  getDateRangeForPeriod,
  filterExcursionsByDateRange,
  calculateTotalRevenue,
  calculateTotalExpenses,
  calculateAdditionalTransactionsTotal,
  calculateExcursionRevenue,
  formatCurrency,
} from "@/utils/calculations";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { MainTabParamList } from "@/navigation/MainTabNavigator";

function KpiCard({ 
  label, 
  value, 
  delta, 
  deltaLabel,
  color,
  icon,
}: { 
  label: string;
  value: string;
  delta?: number;
  deltaLabel?: string;
  color: string;
  icon: string;
}) {
  const { theme } = useTheme();
  const deltaColor = delta !== undefined ? (delta >= 0 ? theme.success : theme.error) : theme.textSecondary;
  const deltaSign = delta !== undefined && delta > 0 ? "+" : "";
  
  return (
    <ThemedView style={[styles.kpiCard, { backgroundColor: theme.backgroundSecondary }]}>
      <View style={styles.kpiHeader}>
        <View style={[styles.kpiIconBg, { backgroundColor: color + '20' }]}>
          <Icon name={icon as any} size={14} color={color} />
        </View>
        <ThemedText style={[styles.kpiLabel, { color: theme.textSecondary }]}>{label}</ThemedText>
      </View>
      <ThemedText style={[styles.kpiValue, { color: theme.text }]} numberOfLines={1}>{value}</ThemedText>
      {delta !== undefined ? (
        <View style={styles.kpiDelta}>
          <Icon name={delta >= 0 ? "trending-up" : "trending-down"} size={12} color={deltaColor} />
          <ThemedText style={[styles.kpiDeltaText, { color: deltaColor }]}>
            {deltaSign}{formatCurrency(delta)}
          </ThemedText>
          {deltaLabel ? (
            <ThemedText style={[styles.kpiDeltaLabel, { color: theme.textSecondary }]}>{deltaLabel}</ThemedText>
          ) : null}
        </View>
      ) : null}
    </ThemedView>
  );
}

function ExcursionCard({ 
  time, 
  tourName, 
  participants, 
  revenue,
  onPress,
}: { 
  time: string;
  tourName: string;
  participants: number;
  revenue: number;
  onPress?: () => void;
}) {
  const { theme } = useTheme();
  
  return (
    <Pressable onPress={onPress} style={({ pressed }) => [{ opacity: pressed ? 0.7 : 1 }]}>
      <ThemedView style={[styles.excursionCard, { backgroundColor: theme.backgroundSecondary }]}>
        <View style={styles.excursionTimeCol}>
          <ThemedText style={[styles.excursionTime, { color: theme.primary }]}>{time}</ThemedText>
        </View>
        <View style={styles.excursionInfo}>
          <ThemedText style={styles.excursionTour} numberOfLines={1}>{tourName}</ThemedText>
          <View style={styles.excursionMeta}>
            <View style={styles.excursionMetaItem}>
              <Icon name="users" size={12} color={theme.textSecondary} />
              <ThemedText style={[styles.excursionMetaText, { color: theme.textSecondary }]}>{participants}</ThemedText>
            </View>
            <View style={styles.excursionMetaItem}>
              <Icon name="dollar-sign" size={12} color={theme.success} />
              <ThemedText style={[styles.excursionMetaText, { color: theme.success }]}>{formatCurrency(revenue)}</ThemedText>
            </View>
          </View>
        </View>
        <Icon name="chevron-right" size={18} color={theme.textSecondary} />
      </ThemedView>
    </Pressable>
  );
}

function RentalOrderCard({ 
  clientName, 
  status, 
  kits,
  startDate,
  endDate,
  onPress,
}: { 
  clientName: string;
  status: string;
  kits: number;
  startDate: string;
  endDate: string;
  onPress?: () => void;
}) {
  const { theme } = useTheme();
  
  const statusColors: Record<string, string> = {
    new: theme.warning,
    issued: theme.primary,
    returned: theme.success,
    completed: theme.success,
    cancelled: theme.error,
  };
  
  const statusLabels: Record<string, string> = {
    new: "Новый",
    issued: "Выдан",
    returned: "Возвращён",
    completed: "Завершён",
    cancelled: "Отменён",
  };
  
  const formatDate = (dateStr: string) => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU", { day: "2-digit", month: "2-digit" });
  };
  
  return (
    <Pressable onPress={onPress} style={({ pressed }) => [{ opacity: pressed ? 0.7 : 1 }]}>
      <ThemedView style={[styles.rentalCard, { backgroundColor: theme.backgroundSecondary }]}>
        <View style={styles.rentalCardHeader}>
          <ThemedText style={styles.rentalClientName} numberOfLines={1}>{clientName}</ThemedText>
          <View style={[styles.rentalStatusBadge, { backgroundColor: (statusColors[status] || theme.textSecondary) + '20' }]}>
            <ThemedText style={[styles.rentalStatusText, { color: statusColors[status] || theme.textSecondary }]}>
              {statusLabels[status] || status}
            </ThemedText>
          </View>
        </View>
        <View style={styles.rentalCardMeta}>
          <View style={styles.rentalMetaItem}>
            <Icon name="radio" size={12} color={theme.textSecondary} />
            <ThemedText style={[styles.rentalMetaText, { color: theme.textSecondary }]}>{kits} комп.</ThemedText>
          </View>
          <View style={styles.rentalMetaItem}>
            <Icon name="calendar" size={12} color={theme.textSecondary} />
            <ThemedText style={[styles.rentalMetaText, { color: theme.textSecondary }]}>
              {formatDate(startDate)} - {formatDate(endDate)}
            </ThemedText>
          </View>
        </View>
      </ThemedView>
    </Pressable>
  );
}

function AlertCard({ 
  icon, 
  title, 
  description, 
  color,
  onPress,
}: { 
  icon: string;
  title: string;
  description: string;
  color: string;
  onPress?: () => void;
}) {
  const { theme } = useTheme();
  
  return (
    <Pressable onPress={onPress} style={({ pressed }) => [{ opacity: pressed && onPress ? 0.7 : 1 }]}>
      <ThemedView style={[styles.alertCard, { backgroundColor: color + '15', borderColor: color + '30' }]}>
        <View style={[styles.alertIconBg, { backgroundColor: color + '25' }]}>
          <Icon name={icon as any} size={16} color={color} />
        </View>
        <View style={styles.alertContent}>
          <ThemedText style={[styles.alertTitle, { color }]}>{title}</ThemedText>
          <ThemedText style={[styles.alertDesc, { color: theme.textSecondary }]}>{description}</ThemedText>
        </View>
      </ThemedView>
    </Pressable>
  );
}

function SectionHeader({ title, onSeeAll }: { title: string; onSeeAll?: () => void }) {
  const { theme } = useTheme();
  
  return (
    <View style={styles.sectionHeader}>
      <ThemedText style={styles.sectionTitle}>{title}</ThemedText>
      {onSeeAll ? (
        <Pressable onPress={onSeeAll}>
          <ThemedText style={[styles.seeAllText, { color: theme.primary }]}>Все</ThemedText>
        </Pressable>
      ) : null}
    </View>
  );
}

export default function DashboardScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<MainTabParamList>>();
  const { excursions, tourTypes, additionalServices, transactions, radioGuideKits, radioGuideAssignments, equipmentItems, equipmentLosses, refreshData } = useData();
  const { rentalOrders, rentalClients, rentalPayments, refreshData: refreshRentalData } = useRental();
  const { isAdmin, hasPermission, profile } = useAuth();
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

  const dashboardConfig = useMemo(() => {
    return profile?.dashboard_config || DEFAULT_DASHBOARD_CONFIG;
  }, [profile?.dashboard_config]);

  const isWidgetVisible = useCallback((key: DashboardWidgetKey): boolean => {
    const widget = dashboardConfig.widgets.find(w => w.key === key);
    if (!widget) return true;
    if (key === 'rental_section' && !hasAnyRentalAccess) return false;
    return widget.visible;
  }, [dashboardConfig.widgets, hasAnyRentalAccess]);

  const sortedWidgets = useMemo(() => {
    return [...dashboardConfig.widgets].sort((a, b) => a.order - b.order);
  }, [dashboardConfig.widgets]);
  
  const handleDateChange = (event: any, date?: Date) => {
    if (Platform.OS === "android") {
      setShowDatePicker(false);
    }
    if (date) {
      setReferenceDate(date);
    }
  };
  
  const formatDisplayDate = (date: Date) => {
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const compareDate = new Date(date);
    compareDate.setHours(0, 0, 0, 0);
    
    if (compareDate.getTime() === today.getTime()) {
      return "Сегодня";
    }
    
    const yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);
    if (compareDate.getTime() === yesterday.getTime()) {
      return "Вчера";
    }
    
    return date.toLocaleDateString("ru-RU", {
      day: "numeric",
      month: "long",
    });
  };

  const onRefresh = async () => {
    setRefreshing(true);
    try {
      await Promise.all([refreshData(), refreshRentalData()]);
    } finally {
      setRefreshing(false);
    }
  };

  const todayStats = useMemo(() => {
    const { startDate, endDate } = getDateRangeForPeriod("day", referenceDate);
    const filtered = filterExcursionsByDateRange(excursions, startDate, endDate);
    const filteredTx = transactions.filter((t) => t.date >= startDate && t.date <= endDate);
    
    const revenue = calculateTotalRevenue(filtered, tourTypes, additionalServices);
    const excursionExpenses = calculateTotalExpenses(filtered);
    const additionalIncome = calculateAdditionalTransactionsTotal(filteredTx, "income");
    const additionalExpenses = calculateAdditionalTransactionsTotal(filteredTx, "expense");
    
    const totalRevenue = revenue + additionalIncome;
    const totalExpenses = excursionExpenses + additionalExpenses;
    const profit = totalRevenue - totalExpenses;
    
    const participants = filtered.reduce((sum, exc) => {
      return sum + exc.fullPriceCount + exc.discountedCount + exc.freeCount + 
        exc.byTourCount + exc.paidCount;
    }, 0);
    
    return {
      revenue: totalRevenue,
      expenses: totalExpenses,
      profit,
      excursions: filtered.length,
      participants,
    };
  }, [excursions, transactions, tourTypes, additionalServices, referenceDate]);

  const yesterdayStats = useMemo(() => {
    const yesterday = new Date(referenceDate);
    yesterday.setDate(yesterday.getDate() - 1);
    const { startDate, endDate } = getDateRangeForPeriod("day", yesterday);
    const filtered = filterExcursionsByDateRange(excursions, startDate, endDate);
    const filteredTx = transactions.filter((t) => t.date >= startDate && t.date <= endDate);
    
    const revenue = calculateTotalRevenue(filtered, tourTypes, additionalServices);
    const excursionExpenses = calculateTotalExpenses(filtered);
    const additionalIncome = calculateAdditionalTransactionsTotal(filteredTx, "income");
    const additionalExpenses = calculateAdditionalTransactionsTotal(filteredTx, "expense");
    
    const totalRevenue = revenue + additionalIncome;
    const totalExpenses = excursionExpenses + additionalExpenses;
    const profit = totalRevenue - totalExpenses;
    
    return { revenue: totalRevenue, expenses: totalExpenses, profit };
  }, [excursions, transactions, tourTypes, additionalServices, referenceDate]);

  const weekStats = useMemo(() => {
    const { startDate, endDate } = getDateRangeForPeriod("week", referenceDate);
    const filtered = filterExcursionsByDateRange(excursions, startDate, endDate);
    const filteredTx = transactions.filter((t) => t.date >= startDate && t.date <= endDate);
    
    const revenue = calculateTotalRevenue(filtered, tourTypes, additionalServices);
    const excursionExpenses = calculateTotalExpenses(filtered);
    const additionalIncome = calculateAdditionalTransactionsTotal(filteredTx, "income");
    const additionalExpenses = calculateAdditionalTransactionsTotal(filteredTx, "expense");
    
    return {
      revenue: revenue + additionalIncome,
      expenses: excursionExpenses + additionalExpenses,
      profit: revenue + additionalIncome - excursionExpenses - additionalExpenses,
      excursions: filtered.length,
    };
  }, [excursions, transactions, tourTypes, additionalServices, referenceDate]);

  const monthStats = useMemo(() => {
    const { startDate, endDate } = getDateRangeForPeriod("month", referenceDate);
    const filtered = filterExcursionsByDateRange(excursions, startDate, endDate);
    const filteredTx = transactions.filter((t) => t.date >= startDate && t.date <= endDate);
    
    const revenue = calculateTotalRevenue(filtered, tourTypes, additionalServices);
    const excursionExpenses = calculateTotalExpenses(filtered);
    const additionalIncome = calculateAdditionalTransactionsTotal(filteredTx, "income");
    const additionalExpenses = calculateAdditionalTransactionsTotal(filteredTx, "expense");
    
    return {
      revenue: revenue + additionalIncome,
      expenses: excursionExpenses + additionalExpenses,
      profit: revenue + additionalIncome - excursionExpenses - additionalExpenses,
      excursions: filtered.length,
    };
  }, [excursions, transactions, tourTypes, additionalServices, referenceDate]);

  const todayExcursions = useMemo(() => {
    const { startDate, endDate } = getDateRangeForPeriod("day", referenceDate);
    return filterExcursionsByDateRange(excursions, startDate, endDate)
      .sort((a, b) => a.time.localeCompare(b.time))
      .slice(0, 5);
  }, [excursions, referenceDate]);

  const activeRentalOrders = useMemo(() => {
    return rentalOrders
      .filter(order => order.status === 'new' || order.status === 'issued')
      .sort((a, b) => new Date(a.startDate).getTime() - new Date(b.startDate).getTime())
      .slice(0, 4);
  }, [rentalOrders]);

  const rentalStats = useMemo(() => {
    const tomorrow = new Date(referenceDate);
    tomorrow.setDate(tomorrow.getDate() + 1);
    const { startDate: tomorrowDateStr } = getDateRangeForPeriod("day", tomorrow);
    
    const tomorrowOrders = rentalOrders.filter(order => {
      if (order.status !== 'new') return false;
      const orderDateStr = order.startDate.includes('T') ? order.startDate.split('T')[0] : order.startDate;
      return orderDateStr === tomorrowDateStr;
    });
    
    const activeCount = rentalOrders.filter(order => 
      order.status === 'new' || order.status === 'issued'
    ).length;

    const { startDate: todayDateStr } = getDateRangeForPeriod("day", referenceDate);
    
    const todayPayments = rentalPayments.filter(payment => {
      const paymentDateStr = payment.createdAt.split('T')[0];
      return paymentDateStr === todayDateStr;
    });
    
    const todayPaymentsTotal = todayPayments.reduce((sum, payment) => sum + payment.amount, 0);
    
    return { active: activeCount, tomorrowOrders: tomorrowOrders.length, todayPaymentsTotal };
  }, [rentalOrders, rentalPayments, referenceDate]);

  const alerts = useMemo(() => {
    const alertsList: { icon: string; title: string; description: string; color: string; key: string; route: string }[] = [];
    
    if (hasAnyRentalAccess) {
      const overdueReturns = rentalOrders.filter(order => {
        if (order.status !== 'issued') return false;
        const endDate = new Date(order.endDate);
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        return endDate < today;
      });
      
      if (overdueReturns.length > 0) {
        alertsList.push({
          key: 'overdue',
          icon: 'alert-circle',
          title: `Просрочено: ${overdueReturns.length}`,
          description: 'Заказов аренды не возвращено вовремя',
          color: theme.error,
          route: 'RentalOrders',
        });
      }
    }
    
    const lowBatteryKits = radioGuideKits.filter(kit => kit.batteryLevel === 'low' && kit.status === 'available');
    if (lowBatteryKits.length > 0) {
      alertsList.push({
        key: 'battery',
        icon: 'battery',
        title: `Низкий заряд: ${lowBatteryKits.length}`,
        description: 'Комплектов радиогидов требуют зарядки',
        color: theme.warning,
        route: 'RadioGuides',
      });
    }
    
    const lowStockItems = equipmentItems.filter(item => item.quantity <= item.minQuantity);
    if (lowStockItems.length > 0) {
      alertsList.push({
        key: 'stock',
        icon: 'package',
        title: `Низкий запас: ${lowStockItems.length}`,
        description: 'Позиций на складе требуют пополнения',
        color: theme.warning,
        route: 'Warehouse',
      });
    }
    
    return alertsList;
  }, [rentalOrders, radioGuideKits, equipmentItems, theme, hasAnyRentalAccess]);

  const radioGuidesStats = useMemo(() => {
    const activeAssignments = radioGuideAssignments.filter(a => !a.returnedAt);
    const onExcursions = activeAssignments.reduce((sum, a) => sum + a.receiversIssued, 0);
    
    const activeRentals = rentalOrders.filter(order => order.status === 'issued');
    const onRentals = activeRentals.reduce((sum, order) => {
      return sum + order.kitCount + order.spareReceiverCount;
    }, 0);
    
    const totalInUse = onExcursions + onRentals;
    
    const { startDate: todayStart, endDate: todayEnd } = getDateRangeForPeriod("day", new Date());
    const todayLosses = equipmentLosses.filter(loss => {
      const lossDate = loss.createdAt.split('T')[0];
      return lossDate >= todayStart && lossDate <= todayEnd;
    });
    const lostCount = todayLosses.reduce((sum, loss) => sum + loss.missingCount, 0);
    
    return { onExcursions, onRentals, totalInUse, lostCount };
  }, [radioGuideAssignments, rentalOrders, equipmentLosses]);

  const getTourName = (tourTypeId: string) => {
    const tour = tourTypes.find(t => t.id === tourTypeId);
    return tour?.name || "Неизвестный тур";
  };

  const getParticipants = (exc: typeof excursions[0]) => {
    return exc.fullPriceCount + exc.discountedCount + exc.freeCount + exc.byTourCount + exc.paidCount;
  };

  const getExcursionRevenue = (exc: typeof excursions[0]) => {
    const tour = tourTypes.find(t => t.id === exc.tourTypeId);
    if (!tour) return 0;
    return calculateExcursionRevenue(exc, tour, additionalServices);
  };

  const getClientName = (clientId: string) => {
    const client = rentalClients.find(c => c.id === clientId);
    return client?.name || "Неизвестный клиент";
  };

  return (
    <ScreenScrollView
      refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
    >
      <NetworkErrorBanner />
      <View style={styles.container}>
        <View style={styles.dateRow}>
          <Pressable
            onPress={() => setShowDatePicker(true)}
            style={[styles.dateButton, { backgroundColor: theme.backgroundSecondary }]}
          >
            <Icon name="calendar" size={18} color={theme.primary} />
            <ThemedText style={[styles.dateText, { color: theme.text }]}>
              {formatDisplayDate(referenceDate)}
            </ThemedText>
            <Icon name="chevron-down" size={16} color={theme.textSecondary} />
          </Pressable>
          <Pressable
            onPress={() => navigation.navigate('DailyReport' as never)}
            style={[styles.reportButton, { backgroundColor: theme.primary }]}
          >
            <Icon name="clipboard" size={18} color={theme.buttonText} />
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

        {sortedWidgets.map(widget => {
          if (!isWidgetVisible(widget.key)) return null;

          switch (widget.key) {
            case 'kpi_cards':
              return (
                <ScrollView key={widget.key} horizontal showsHorizontalScrollIndicator={false} style={styles.kpiScroll} contentContainerStyle={styles.kpiContainer}>
                  <KpiCard 
                    label="Прибыль" 
                    value={formatCurrency(todayStats.profit)} 
                    delta={todayStats.profit - yesterdayStats.profit}
                    deltaLabel="vs вчера"
                    color={todayStats.profit >= 0 ? theme.success : theme.error}
                    icon="trending-up"
                  />
                  <KpiCard 
                    label="Доход" 
                    value={formatCurrency(todayStats.revenue)} 
                    delta={todayStats.revenue - yesterdayStats.revenue}
                    color={theme.primary}
                    icon="dollar-sign"
                  />
                  <KpiCard 
                    label="Расходы" 
                    value={formatCurrency(todayStats.expenses)} 
                    delta={todayStats.expenses - yesterdayStats.expenses}
                    color={theme.error}
                    icon="credit-card"
                  />
                  <KpiCard 
                    label="Человек" 
                    value={String(todayStats.participants)} 
                    color={theme.primary}
                    icon="users"
                  />
                </ScrollView>
              );

            case 'period_summary':
              return (
                <ThemedView key={widget.key} style={[styles.periodSummary, { backgroundColor: theme.backgroundSecondary }]}>
                  <View style={styles.periodRow}>
                    <View style={styles.periodItem}>
                      <ThemedText style={[styles.periodLabel, { color: theme.textSecondary }]}>Неделя</ThemedText>
                      <ThemedText style={[styles.periodValue, { color: weekStats.profit >= 0 ? theme.success : theme.error }]}>
                        {formatCurrency(weekStats.profit)}
                      </ThemedText>
                      <ThemedText style={[styles.periodSubtext, { color: theme.textSecondary }]}>
                        {weekStats.excursions} экс.
                      </ThemedText>
                    </View>
                    <View style={[styles.periodDivider, { backgroundColor: theme.border }]} />
                    <View style={styles.periodItem}>
                      <ThemedText style={[styles.periodLabel, { color: theme.textSecondary }]}>Месяц</ThemedText>
                      <ThemedText style={[styles.periodValue, { color: monthStats.profit >= 0 ? theme.success : theme.error }]}>
                        {formatCurrency(monthStats.profit)}
                      </ThemedText>
                      <ThemedText style={[styles.periodSubtext, { color: theme.textSecondary }]}>
                        {monthStats.excursions} экс.
                      </ThemedText>
                    </View>
                  </View>
                </ThemedView>
              );

            case 'alerts':
              if (alerts.length === 0) return null;
              return (
                <View key={widget.key} style={styles.section}>
                  <SectionHeader title="Оповещения" />
                  {alerts.map(alert => (
                    <AlertCard 
                      key={alert.key} 
                      icon={alert.icon}
                      title={alert.title}
                      description={alert.description}
                      color={alert.color}
                      onPress={() => navigation.navigate('SettingsTab' as never, { screen: alert.route } as never)}
                    />
                  ))}
                </View>
              );

            case 'radio_guides_stats':
              return (
                <View key={widget.key} style={styles.section}>
                  <SectionHeader 
                    title="Радиогиды" 
                    onSeeAll={() => navigation.navigate('SettingsTab' as never, { screen: 'RadioGuides' } as never)} 
                  />
                  <View style={styles.radioGuidesStatsRow}>
                    <View style={[styles.radioGuideStat, { backgroundColor: theme.backgroundSecondary }]}>
                      <Icon name="briefcase" size={20} color={theme.primary} />
                      <ThemedText style={styles.radioGuideStatValue}>{radioGuidesStats.onExcursions}</ThemedText>
                      <ThemedText style={[styles.radioGuideStatLabel, { color: theme.textSecondary }]}>Экскурсии</ThemedText>
                    </View>
                    <View style={[styles.radioGuideStat, { backgroundColor: theme.backgroundSecondary }]}>
                      <Icon name="truck" size={20} color={theme.success} />
                      <ThemedText style={styles.radioGuideStatValue}>{radioGuidesStats.onRentals}</ThemedText>
                      <ThemedText style={[styles.radioGuideStatLabel, { color: theme.textSecondary }]}>Аренда</ThemedText>
                    </View>
                    <View style={[styles.radioGuideStat, { backgroundColor: theme.backgroundSecondary }]}>
                      <Icon name="radio" size={20} color={theme.warning} />
                      <ThemedText style={styles.radioGuideStatValue}>{radioGuidesStats.totalInUse}</ThemedText>
                      <ThemedText style={[styles.radioGuideStatLabel, { color: theme.textSecondary }]}>Всего</ThemedText>
                    </View>
                    <Pressable 
                      style={[styles.radioGuideStat, { backgroundColor: theme.backgroundSecondary }]}
                      onPress={() => navigation.navigate('SettingsTab' as never, { screen: 'EquipmentLosses' } as never)}
                    >
                      <Icon name="alert-triangle" size={20} color={theme.error} />
                      <ThemedText style={[styles.radioGuideStatValue, { color: radioGuidesStats.lostCount > 0 ? theme.error : theme.text }]}>
                        {radioGuidesStats.lostCount}
                      </ThemedText>
                      <ThemedText style={[styles.radioGuideStatLabel, { color: theme.textSecondary }]}>Утеряно</ThemedText>
                    </Pressable>
                  </View>
                </View>
              );

            case 'today_excursions':
              return (
                <View key={widget.key} style={styles.section}>
                  <SectionHeader 
                    title={`Экскурсии (${todayStats.excursions})`} 
                    onSeeAll={() => navigation.navigate('ExcursionsTab' as never)} 
                  />
                  {todayExcursions.length > 0 ? (
                    todayExcursions.map(exc => (
                      <ExcursionCard
                        key={exc.id}
                        time={exc.time}
                        tourName={getTourName(exc.tourTypeId)}
                        participants={getParticipants(exc)}
                        revenue={getExcursionRevenue(exc)}
                        onPress={() => navigation.navigate('ExcursionsTab' as never, { screen: 'ExcursionDetail', params: { excursionId: exc.id } } as never)}
                      />
                    ))
                  ) : (
                    <ThemedView style={[styles.emptyCard, { backgroundColor: theme.backgroundSecondary }]}>
                      <Icon name="calendar" size={24} color={theme.textSecondary} />
                      <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                        Нет экскурсий на эту дату
                      </ThemedText>
                    </ThemedView>
                  )}
                </View>
              );

            case 'rental_section':
              return (
                <View key={widget.key} style={styles.section}>
                  <SectionHeader 
                    title={`Аренда (${rentalStats.active} активных)`} 
                    onSeeAll={() => navigation.navigate('SettingsTab' as never, { screen: 'RentalOrders' } as never)} 
                  />
                  
                  <View style={styles.rentalKpiRow}>
                    <ThemedView style={[styles.rentalKpiCard, { backgroundColor: theme.backgroundSecondary }]}>
                      <Icon name="file-text" size={18} color={theme.primary} />
                      <ThemedText style={[styles.rentalKpiValue, { color: theme.text }]}>{rentalStats.tomorrowOrders}</ThemedText>
                      <ThemedText style={[styles.rentalKpiLabel, { color: theme.textSecondary }]}>Завтра</ThemedText>
                    </ThemedView>
                    <ThemedView style={[styles.rentalKpiCard, { backgroundColor: theme.backgroundSecondary }]}>
                      <Icon name="dollar-sign" size={18} color={theme.success} />
                      <ThemedText style={[styles.rentalKpiValue, { color: theme.success }]}>{formatCurrency(rentalStats.todayPaymentsTotal)}</ThemedText>
                      <ThemedText style={[styles.rentalKpiLabel, { color: theme.textSecondary }]}>Доход</ThemedText>
                    </ThemedView>
                  </View>
                </View>
              );

            default:
              return null;
          }
        })}
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing.xl,
  },
  dateRow: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  dateButton: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.sm,
    gap: Spacing.sm,
  },
  dateText: {
    flex: 1,
    fontSize: 16,
    fontWeight: "500",
  },
  reportButton: {
    width: 48,
    height: 48,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    justifyContent: "center",
  },
  kpiScroll: {
    marginHorizontal: -Spacing.lg,
  },
  kpiContainer: {
    paddingHorizontal: Spacing.lg,
    gap: Spacing.sm,
  },
  kpiCard: {
    width: 140,
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    gap: Spacing.xs,
  },
  kpiHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
  },
  kpiIconBg: {
    width: 22,
    height: 22,
    borderRadius: 6,
    alignItems: "center",
    justifyContent: "center",
  },
  kpiLabel: {
    fontSize: 11,
    fontWeight: "500",
  },
  kpiValue: {
    fontSize: 18,
    fontWeight: "700",
  },
  kpiDelta: {
    flexDirection: "row",
    alignItems: "center",
    gap: 3,
  },
  kpiDeltaText: {
    fontSize: 11,
    fontWeight: "500",
  },
  kpiDeltaLabel: {
    fontSize: 10,
  },
  periodSummary: {
    padding: Spacing.lg,
    borderRadius: BorderRadius.sm,
  },
  periodRow: {
    flexDirection: "row",
    alignItems: "center",
  },
  periodItem: {
    flex: 1,
    alignItems: "center",
    gap: Spacing.xs,
  },
  periodDivider: {
    width: 1,
    height: 50,
  },
  periodLabel: {
    fontSize: 12,
    fontWeight: "500",
  },
  periodValue: {
    fontSize: 20,
    fontWeight: "700",
  },
  periodSubtext: {
    fontSize: 11,
  },
  section: {
    gap: Spacing.sm,
  },
  sectionHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.xs,
  },
  sectionTitle: {
    fontSize: 17,
    fontWeight: "600",
  },
  seeAllText: {
    fontSize: 14,
    fontWeight: "500",
  },
  excursionCard: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    gap: Spacing.md,
  },
  excursionTimeCol: {
    width: 50,
  },
  excursionTime: {
    fontSize: 15,
    fontWeight: "600",
  },
  excursionInfo: {
    flex: 1,
    gap: Spacing.xs,
  },
  excursionTour: {
    fontSize: 15,
    fontWeight: "500",
  },
  excursionMeta: {
    flexDirection: "row",
    gap: Spacing.lg,
  },
  excursionMetaItem: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
  },
  excursionMetaText: {
    fontSize: 12,
  },
  rentalCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    gap: Spacing.sm,
  },
  rentalCardHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  rentalClientName: {
    flex: 1,
    fontSize: 15,
    fontWeight: "500",
  },
  rentalStatusBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 3,
    borderRadius: BorderRadius.xs,
  },
  rentalStatusText: {
    fontSize: 11,
    fontWeight: "600",
  },
  rentalCardMeta: {
    flexDirection: "row",
    gap: Spacing.lg,
  },
  rentalMetaItem: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
  },
  rentalMetaText: {
    fontSize: 12,
  },
  rentalKpiRow: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  rentalKpiCard: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    gap: Spacing.xs,
  },
  rentalKpiValue: {
    fontSize: 18,
    fontWeight: "700",
  },
  rentalKpiLabel: {
    fontSize: 11,
  },
  alertCard: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    gap: Spacing.md,
  },
  alertIconBg: {
    width: 32,
    height: 32,
    borderRadius: 8,
    alignItems: "center",
    justifyContent: "center",
  },
  alertContent: {
    flex: 1,
    gap: 2,
  },
  alertTitle: {
    fontSize: 14,
    fontWeight: "600",
  },
  alertDesc: {
    fontSize: 12,
  },
  emptyCard: {
    padding: Spacing.xl,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    gap: Spacing.sm,
  },
  emptyText: {
    fontSize: 14,
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
  radioGuidesStatsRow: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  radioGuideStat: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    gap: Spacing.xs,
  },
  radioGuideStatValue: {
    fontSize: 18,
    fontWeight: "700",
  },
  radioGuideStatLabel: {
    fontSize: 10,
    textAlign: "center",
  },
});
