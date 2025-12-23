import { useState, useMemo, useCallback } from "react";
import { View, StyleSheet, Pressable, Modal, TextInput, Platform } from "react-native";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import DateTimePicker from "@react-native-community/datetimepicker";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenFlatList } from "@/components/ScreenFlatList";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useRental, RentalPayment, RentalPaymentType, RentalPaymentMethod, RentalOrder } from "@/contexts/RentalContext";
import { hapticFeedback } from "@/utils/haptics";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";

type FilterType = 'all' | 'prepayment' | 'final' | 'refund' | 'service_expense';
type PaymentStatusFilter = 'all' | 'paid' | 'partial' | 'unpaid';

const PAYMENT_TYPE_CONFIG: Record<RentalPaymentType, { label: string; color: string }> = {
  prepayment: { label: 'Предоплата', color: '#3B82F6' },
  final: { label: 'Окончательный расчёт', color: '#10B981' },
  refund: { label: 'Возврат', color: '#F59E0B' },
  service_expense: { label: 'Служебный расход', color: '#8B5CF6' },
};

const PAYMENT_METHOD_CONFIG: Record<RentalPaymentMethod, { label: string; icon: string; color: string }> = {
  cash: { label: 'Наличные', icon: 'dollar-sign', color: '#22C55E' },
  card: { label: 'Карта', icon: 'credit-card', color: '#3B82F6' },
  transfer: { label: 'Перевод', icon: 'send', color: '#A855F7' },
};

interface PaymentWithOrder extends RentalPayment {
  order: RentalOrder | undefined;
  clientName: string;
}

export default function RentalPaymentsScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<SettingsStackParamList>>();
  const { rentalPayments, rentalOrders, rentalClients, getOrderPayments } = useRental();

  const [typeFilter, setTypeFilter] = useState<FilterType>('all');
  const [statusFilter, setStatusFilter] = useState<PaymentStatusFilter>('all');
  const [showFilters, setShowFilters] = useState(false);
  const [startDate, setStartDate] = useState<Date | null>(null);
  const [endDate, setEndDate] = useState<Date | null>(null);
  const [activePicker, setActivePicker] = useState<'start' | 'end' | null>(null);
  const [draftDate, setDraftDate] = useState<Date>(new Date());
  const [searchQuery, setSearchQuery] = useState('');

  const paymentsWithOrders = useMemo((): PaymentWithOrder[] => {
    return rentalPayments.map(payment => {
      const order = rentalOrders.find(o => o.id === payment.orderId);
      const client = order ? rentalClients.find(c => c.id === order.clientId) : null;
      return {
        ...payment,
        order,
        clientName: order?.clientName || client?.name || 'Неизвестный клиент',
      };
    }).sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());
  }, [rentalPayments, rentalOrders, rentalClients]);

  const ordersWithPaymentStatus = useMemo(() => {
    return rentalOrders.map(order => {
      const payments = getOrderPayments(order.id);
      const totalPaid = payments
        .filter(p => p.type !== 'refund' && p.type !== 'service_expense')
        .reduce((sum, p) => sum + p.amount, 0);
      const refunds = payments
        .filter(p => p.type === 'refund')
        .reduce((sum, p) => sum + p.amount, 0);
      const netPaid = totalPaid - refunds;
      const remaining = order.totalPrice - netPaid;
      
      let paymentStatus: 'paid' | 'partial' | 'unpaid';
      if (remaining <= 0) {
        paymentStatus = 'paid';
      } else if (netPaid > 0) {
        paymentStatus = 'partial';
      } else {
        paymentStatus = 'unpaid';
      }
      
      return { ...order, paymentStatus, totalPaid: netPaid, remaining };
    });
  }, [rentalOrders, getOrderPayments]);

  const filteredPayments = useMemo(() => {
    let result = paymentsWithOrders;

    if (typeFilter !== 'all') {
      result = result.filter(p => p.type === typeFilter);
    }

    if (statusFilter !== 'all') {
      const ordersWithStatus = ordersWithPaymentStatus.filter(o => o.paymentStatus === statusFilter);
      const orderIds = new Set(ordersWithStatus.map(o => o.id));
      result = result.filter(p => orderIds.has(p.orderId));
    }

    if (startDate) {
      const start = new Date(startDate);
      start.setHours(0, 0, 0, 0);
      result = result.filter(p => new Date(p.createdAt) >= start);
    }

    if (endDate) {
      const end = new Date(endDate);
      end.setHours(23, 59, 59, 999);
      result = result.filter(p => new Date(p.createdAt) <= end);
    }

    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase().trim();
      result = result.filter(p => 
        p.clientName.toLowerCase().includes(query) ||
        p.order?.orderNumber?.toString().includes(query) ||
        p.notes?.toLowerCase().includes(query)
      );
    }

    return result;
  }, [paymentsWithOrders, typeFilter, statusFilter, startDate, endDate, searchQuery, ordersWithPaymentStatus]);

  const statistics = useMemo(() => {
    const allPayments = filteredPayments;
    
    const prepayments = allPayments
      .filter(p => p.type === 'prepayment')
      .reduce((sum, p) => sum + Math.abs(p.amount), 0);
    
    const finals = allPayments
      .filter(p => p.type === 'final')
      .reduce((sum, p) => sum + Math.abs(p.amount), 0);
    
    const refunds = allPayments
      .filter(p => p.type === 'refund')
      .reduce((sum, p) => sum + Math.abs(p.amount), 0);
    
    const expenses = allPayments
      .filter(p => p.type === 'service_expense')
      .reduce((sum, p) => sum + Math.abs(p.amount), 0);
    
    const total = prepayments + finals - refunds - expenses;

    const filteredOrderIds = new Set(allPayments.map(p => p.orderId).filter(Boolean));
    const relevantOrders = ordersWithPaymentStatus.filter(o => filteredOrderIds.has(o.id));
    const unpaidOrders = relevantOrders.filter(o => o.remaining > 0);
    const totalDebt = unpaidOrders.reduce((sum, o) => sum + Math.max(0, o.remaining), 0);

    const incomePayments = allPayments.filter(p => p.type === 'prepayment' || p.type === 'final');
    const byCash = incomePayments.filter(p => p.method === 'cash').reduce((sum, p) => sum + Math.abs(p.amount), 0);
    const byCard = incomePayments.filter(p => p.method === 'card').reduce((sum, p) => sum + Math.abs(p.amount), 0);
    const byTransfer = incomePayments.filter(p => p.method === 'transfer').reduce((sum, p) => sum + Math.abs(p.amount), 0);

    return { prepayments, finals, refunds, expenses, total, totalDebt, unpaidCount: unpaidOrders.length, byCash, byCard, byTransfer };
  }, [filteredPayments, ordersWithPaymentStatus]);

  const formatDate = (dateStr: string): string => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU", { day: "2-digit", month: "2-digit", year: "2-digit" });
  };

  const formatDateTime = (dateStr: string): string => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU", { day: "2-digit", month: "2-digit", hour: "2-digit", minute: "2-digit" });
  };

  const handlePaymentPress = useCallback((payment: PaymentWithOrder) => {
    if (payment.order) {
      hapticFeedback.selection();
      navigation.navigate("RentalOrderDetail", { orderId: payment.orderId });
    }
  }, [navigation]);

  const clearFilters = () => {
    setTypeFilter('all');
    setStatusFilter('all');
    setStartDate(null);
    setEndDate(null);
    setSearchQuery('');
  };

  const hasActiveFilters = typeFilter !== 'all' || statusFilter !== 'all' || startDate || endDate || searchQuery.trim();

  const renderPayment = ({ item }: { item: PaymentWithOrder }) => {
    const config = PAYMENT_TYPE_CONFIG[item.type];
    
    return (
      <Pressable
        onPress={() => handlePaymentPress(item)}
        style={({ pressed }) => [
          styles.paymentCard,
          { backgroundColor: theme.backgroundSecondary, opacity: pressed ? 0.7 : 1 },
        ]}
      >
        <View style={styles.paymentHeader}>
          <View style={[styles.typeBadge, { backgroundColor: config.color + '20' }]}>
            <ThemedText style={[styles.typeBadgeText, { color: config.color }]}>
              {config.label}
            </ThemedText>
          </View>
          <ThemedText style={[styles.paymentDate, { color: theme.textSecondary }]}>
            {formatDateTime(item.createdAt)}
          </ThemedText>
        </View>

        <View style={styles.paymentContent}>
          <View style={styles.paymentInfo}>
            <ThemedText style={styles.clientName} numberOfLines={1}>
              {item.clientName}
            </ThemedText>
            {item.order ? (
              <ThemedText style={[styles.orderNumber, { color: theme.textSecondary }]}>
                Заказ #{item.order.orderNumber}
              </ThemedText>
            ) : null}
            {item.notes ? (
              <ThemedText style={[styles.paymentNotes, { color: theme.textSecondary }]} numberOfLines={1}>
                {item.notes}
              </ThemedText>
            ) : null}
          </View>
          
          <ThemedText style={[
            styles.paymentAmount,
            { color: (item.type === 'refund' || item.type === 'service_expense') ? theme.error : theme.success }
          ]}>
            {(item.type === 'refund' || item.type === 'service_expense') ? '-' : '+'}{Math.abs(item.amount).toLocaleString("ru-RU")}₽
          </ThemedText>
        </View>

        {item.managerName ? (
          <ThemedText style={[styles.managerName, { color: theme.textTertiary }]}>
            {item.managerName}
          </ThemedText>
        ) : null}
      </Pressable>
    );
  };

  const renderHeader = () => (
    <View style={styles.headerContainer}>
      <View style={styles.searchContainer}>
        <View style={[styles.searchInput, { backgroundColor: theme.backgroundSecondary, borderColor: theme.border }]}>
          <Icon name="search" size={16} color={theme.textSecondary} />
          <TextInput
            style={[styles.searchTextInput, { color: theme.text }]}
            placeholder="Поиск по клиенту или заказу..."
            placeholderTextColor={theme.textSecondary}
            value={searchQuery}
            onChangeText={setSearchQuery}
          />
          {searchQuery ? (
            <Pressable onPress={() => setSearchQuery('')}>
              <Icon name="x" size={16} color={theme.textSecondary} />
            </Pressable>
          ) : null}
        </View>
        <Pressable
          style={[
            styles.filterButton,
            { 
              backgroundColor: hasActiveFilters ? theme.primary : theme.backgroundSecondary,
              borderColor: theme.border,
            },
          ]}
          onPress={() => setShowFilters(true)}
        >
          <Icon name="filter" size={16} color={hasActiveFilters ? theme.buttonText : theme.text} />
        </Pressable>
      </View>

      <View style={styles.statsGrid}>
        <View style={[styles.statCard, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Доход</ThemedText>
          <ThemedText style={[styles.statValue, { color: theme.success }]}>
            {statistics.total.toLocaleString("ru-RU")}₽
          </ThemedText>
        </View>
        <View style={[styles.statCard, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>Задолженность</ThemedText>
          <ThemedText style={[styles.statValue, { color: statistics.totalDebt > 0 ? theme.error : theme.textSecondary }]}>
            {statistics.totalDebt.toLocaleString("ru-RU")}₽
          </ThemedText>
        </View>
      </View>

      <View style={styles.statsRow}>
        <View style={[styles.miniStat, { backgroundColor: PAYMENT_TYPE_CONFIG.prepayment.color + '15' }]}>
          <ThemedText style={[styles.miniStatLabel, { color: PAYMENT_TYPE_CONFIG.prepayment.color }]}>
            Предоплаты
          </ThemedText>
          <ThemedText style={[styles.miniStatValue, { color: PAYMENT_TYPE_CONFIG.prepayment.color }]}>
            {statistics.prepayments.toLocaleString("ru-RU")}₽
          </ThemedText>
        </View>
        <View style={[styles.miniStat, { backgroundColor: PAYMENT_TYPE_CONFIG.final.color + '15' }]}>
          <ThemedText style={[styles.miniStatLabel, { color: PAYMENT_TYPE_CONFIG.final.color }]}>
            Расчёты
          </ThemedText>
          <ThemedText style={[styles.miniStatValue, { color: PAYMENT_TYPE_CONFIG.final.color }]}>
            {statistics.finals.toLocaleString("ru-RU")}₽
          </ThemedText>
        </View>
        <View style={[styles.miniStat, { backgroundColor: PAYMENT_TYPE_CONFIG.refund.color + '15' }]}>
          <ThemedText style={[styles.miniStatLabel, { color: PAYMENT_TYPE_CONFIG.refund.color }]}>
            Возвраты
          </ThemedText>
          <ThemedText style={[styles.miniStatValue, { color: PAYMENT_TYPE_CONFIG.refund.color }]}>
            {statistics.refunds.toLocaleString("ru-RU")}₽
          </ThemedText>
        </View>
      </View>

      <ThemedText style={[styles.sectionSubtitle, { color: theme.textSecondary }]}>
        По способу оплаты
      </ThemedText>
      <View style={styles.statsRow}>
        <View style={[styles.miniStat, { backgroundColor: PAYMENT_METHOD_CONFIG.cash.color + '15' }]}>
          <Icon name="dollar-sign" size={14} color={PAYMENT_METHOD_CONFIG.cash.color} />
          <ThemedText style={[styles.miniStatLabel, { color: PAYMENT_METHOD_CONFIG.cash.color }]}>
            Наличные
          </ThemedText>
          <ThemedText style={[styles.miniStatValue, { color: PAYMENT_METHOD_CONFIG.cash.color }]}>
            {statistics.byCash.toLocaleString("ru-RU")}₽
          </ThemedText>
        </View>
        <View style={[styles.miniStat, { backgroundColor: PAYMENT_METHOD_CONFIG.card.color + '15' }]}>
          <Icon name="credit-card" size={14} color={PAYMENT_METHOD_CONFIG.card.color} />
          <ThemedText style={[styles.miniStatLabel, { color: PAYMENT_METHOD_CONFIG.card.color }]}>
            Карта
          </ThemedText>
          <ThemedText style={[styles.miniStatValue, { color: PAYMENT_METHOD_CONFIG.card.color }]}>
            {statistics.byCard.toLocaleString("ru-RU")}₽
          </ThemedText>
        </View>
        <View style={[styles.miniStat, { backgroundColor: PAYMENT_METHOD_CONFIG.transfer.color + '15' }]}>
          <Icon name="send" size={14} color={PAYMENT_METHOD_CONFIG.transfer.color} />
          <ThemedText style={[styles.miniStatLabel, { color: PAYMENT_METHOD_CONFIG.transfer.color }]}>
            Перевод
          </ThemedText>
          <ThemedText style={[styles.miniStatValue, { color: PAYMENT_METHOD_CONFIG.transfer.color }]}>
            {statistics.byTransfer.toLocaleString("ru-RU")}₽
          </ThemedText>
        </View>
      </View>

      {statistics.unpaidCount > 0 ? (
        <Pressable
          style={[styles.debtAlert, { backgroundColor: theme.error + '15', borderColor: theme.error }]}
          onPress={() => setStatusFilter(statusFilter === 'partial' ? 'all' : 'partial')}
        >
          <Icon name="alert-circle" size={20} color={theme.error} />
          <ThemedText style={[styles.debtAlertText, { color: theme.error }]}>
            {statistics.unpaidCount} заказов с неполной оплатой
          </ThemedText>
          <Icon name="chevron-right" size={16} color={theme.error} />
        </Pressable>
      ) : null}

      <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
        История платежей ({filteredPayments.length})
      </ThemedText>
    </View>
  );

  return (
    <>
      <ScreenFlatList
        data={filteredPayments}
        renderItem={renderPayment}
        keyExtractor={(item) => item.id}
        ListHeaderComponent={renderHeader}
        ListEmptyComponent={
          <View style={styles.emptyContainer}>
            <Icon name="credit-card" size={48} color={theme.textSecondary} />
            <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
              {hasActiveFilters ? 'Нет платежей по фильтру' : 'Нет платежей'}
            </ThemedText>
            {hasActiveFilters ? (
              <Pressable style={[styles.clearButton, { backgroundColor: theme.primary }]} onPress={clearFilters}>
                <ThemedText style={[styles.clearButtonText, { color: theme.buttonText }]}>
                  Сбросить фильтры
                </ThemedText>
              </Pressable>
            ) : null}
          </View>
        }
        contentContainerStyle={styles.listContainer}
        showsVerticalScrollIndicator={false}
      />

      <Modal
        visible={showFilters}
        animationType="slide"
        transparent
        onRequestClose={() => setShowFilters(false)}
      >
        <View style={styles.modalOverlay}>
          <ThemedView style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Фильтры</ThemedText>
              <Pressable onPress={() => setShowFilters(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <View style={styles.filterSection}>
              <ThemedText style={[styles.filterLabel, { color: theme.textSecondary }]}>
                Тип платежа
              </ThemedText>
              <View style={styles.filterOptions}>
                {(['all', 'prepayment', 'final', 'refund', 'service_expense'] as FilterType[]).map(type => (
                  <Pressable
                    key={type}
                    style={[
                      styles.filterOption,
                      { 
                        backgroundColor: typeFilter === type ? theme.primary : theme.backgroundSecondary,
                        borderColor: theme.border,
                      },
                    ]}
                    onPress={() => setTypeFilter(type)}
                  >
                    <ThemedText style={[
                      styles.filterOptionText,
                      { color: typeFilter === type ? theme.buttonText : theme.text }
                    ]}>
                      {type === 'all' ? 'Все' : PAYMENT_TYPE_CONFIG[type].label}
                    </ThemedText>
                  </Pressable>
                ))}
              </View>
            </View>

            <View style={styles.filterSection}>
              <ThemedText style={[styles.filterLabel, { color: theme.textSecondary }]}>
                Статус оплаты заказа
              </ThemedText>
              <View style={styles.filterOptions}>
                {[
                  { key: 'all', label: 'Все' },
                  { key: 'paid', label: 'Оплачен' },
                  { key: 'partial', label: 'Частично' },
                  { key: 'unpaid', label: 'Не оплачен' },
                ].map(item => (
                  <Pressable
                    key={item.key}
                    style={[
                      styles.filterOption,
                      { 
                        backgroundColor: statusFilter === item.key ? theme.primary : theme.backgroundSecondary,
                        borderColor: theme.border,
                      },
                    ]}
                    onPress={() => setStatusFilter(item.key as PaymentStatusFilter)}
                  >
                    <ThemedText style={[
                      styles.filterOptionText,
                      { color: statusFilter === item.key ? theme.buttonText : theme.text }
                    ]}>
                      {item.label}
                    </ThemedText>
                  </Pressable>
                ))}
              </View>
            </View>

            <View style={styles.filterSection}>
              <ThemedText style={[styles.filterLabel, { color: theme.textSecondary }]}>
                Период
              </ThemedText>
              {activePicker ? (
                <View style={styles.inlineDatePickerContainer}>
                  <ThemedText style={[styles.filterLabel, { color: theme.primary, marginBottom: Spacing.sm }]}>
                    {activePicker === 'start' ? 'Выберите начальную дату:' : 'Выберите конечную дату:'}
                  </ThemedText>
                  <DateTimePicker
                    value={draftDate}
                    mode="date"
                    display="spinner"
                    onChange={(event, date) => {
                      if (date) setDraftDate(date);
                    }}
                    themeVariant="light"
                  />
                  <View style={styles.datePickerActions}>
                    <Pressable
                      style={[styles.datePickerBtn, { backgroundColor: theme.backgroundSecondary }]}
                      onPress={() => setActivePicker(null)}
                    >
                      <ThemedText style={{ color: theme.text }}>Отмена</ThemedText>
                    </Pressable>
                    <Pressable
                      style={[styles.datePickerBtn, { backgroundColor: theme.primary }]}
                      onPress={() => {
                        if (activePicker === 'start') {
                          setStartDate(draftDate);
                        } else {
                          setEndDate(draftDate);
                        }
                        setActivePicker(null);
                      }}
                    >
                      <ThemedText style={{ color: theme.buttonText }}>Выбрать</ThemedText>
                    </Pressable>
                  </View>
                </View>
              ) : Platform.OS === 'web' ? (
                <View style={styles.webDatePickerContainer}>
                  <View style={styles.webDatePickerRow}>
                    <ThemedText style={{ color: theme.textSecondary, marginRight: Spacing.sm }}>С:</ThemedText>
                    <DateTimePicker
                      value={startDate || new Date()}
                      mode="date"
                      display="default"
                      onChange={(event, date) => {
                        if (date) setStartDate(date);
                      }}
                      themeVariant="light"
                    />
                    {startDate ? (
                      <Pressable onPress={() => setStartDate(null)} style={{ marginLeft: Spacing.sm }}>
                        <Icon name="x-circle" size={20} color={theme.textSecondary} />
                      </Pressable>
                    ) : null}
                  </View>
                  <View style={[styles.webDatePickerRow, { marginTop: Spacing.sm }]}>
                    <ThemedText style={{ color: theme.textSecondary, marginRight: Spacing.sm }}>По:</ThemedText>
                    <DateTimePicker
                      value={endDate || new Date()}
                      mode="date"
                      display="default"
                      onChange={(event, date) => {
                        if (date) setEndDate(date);
                      }}
                      themeVariant="light"
                    />
                    {endDate ? (
                      <Pressable onPress={() => setEndDate(null)} style={{ marginLeft: Spacing.sm }}>
                        <Icon name="x-circle" size={20} color={theme.textSecondary} />
                      </Pressable>
                    ) : null}
                  </View>
                </View>
              ) : (
                <View style={styles.dateRow}>
                  <Pressable
                    style={[styles.dateButton, { backgroundColor: theme.backgroundSecondary, borderColor: theme.border }]}
                    onPress={() => {
                      setDraftDate(startDate || new Date());
                      setActivePicker('start');
                    }}
                  >
                    <Icon name="calendar" size={16} color={theme.textSecondary} />
                    <ThemedText style={{ color: startDate ? theme.text : theme.textSecondary }}>
                      {startDate ? formatDate(startDate.toISOString()) : 'С'}
                    </ThemedText>
                  </Pressable>
                  <ThemedText style={{ color: theme.textSecondary }}>—</ThemedText>
                  <Pressable
                    style={[styles.dateButton, { backgroundColor: theme.backgroundSecondary, borderColor: theme.border }]}
                    onPress={() => {
                      setDraftDate(endDate || new Date());
                      setActivePicker('end');
                    }}
                  >
                    <Icon name="calendar" size={16} color={theme.textSecondary} />
                    <ThemedText style={{ color: endDate ? theme.text : theme.textSecondary }}>
                      {endDate ? formatDate(endDate.toISOString()) : 'По'}
                    </ThemedText>
                  </Pressable>
                </View>
              )}
            </View>

            <View style={styles.modalActions}>
              <Pressable
                style={[styles.modalButton, { backgroundColor: theme.backgroundSecondary }]}
                onPress={clearFilters}
              >
                <ThemedText style={{ color: theme.text }}>Сбросить</ThemedText>
              </Pressable>
              <Pressable
                style={[styles.modalButton, { backgroundColor: theme.primary }]}
                onPress={() => setShowFilters(false)}
              >
                <ThemedText style={{ color: theme.buttonText }}>Применить</ThemedText>
              </Pressable>
            </View>
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
  listContainer: {
    gap: Spacing.xs,
  },
  headerContainer: {
    marginBottom: Spacing.md,
  },
  searchContainer: {
    flexDirection: 'row',
    gap: Spacing.sm,
    marginBottom: Spacing.md,
  },
  searchInput: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    gap: Spacing.sm,
  },
  searchTextInput: {
    flex: 1,
    fontSize: 16,
    paddingVertical: 0,
  },
  filterButton: {
    width: 44,
    height: 44,
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
  statsGrid: {
    flexDirection: 'row',
    gap: Spacing.sm,
    marginBottom: Spacing.sm,
  },
  statCard: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: 'center',
  },
  statLabel: {
    fontSize: 14,
    marginBottom: Spacing.xs,
  },
  statValue: {
    fontSize: 20,
    fontWeight: '700',
  },
  statsRow: {
    flexDirection: 'row',
    gap: Spacing.xs,
    marginBottom: Spacing.md,
  },
  miniStat: {
    flex: 1,
    padding: Spacing.sm,
    borderRadius: BorderRadius.sm,
    alignItems: 'center',
  },
  miniStatLabel: {
    fontSize: 12,
    marginBottom: 2,
  },
  miniStatValue: {
    fontSize: 14,
    fontWeight: '600',
  },
  sectionSubtitle: {
    fontSize: 13,
    marginBottom: Spacing.xs,
  },
  debtAlert: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    gap: Spacing.sm,
    marginBottom: Spacing.md,
  },
  debtAlertText: {
    flex: 1,
    fontSize: 14,
    fontWeight: '500',
  },
  sectionTitle: {
    fontSize: 14,
    fontWeight: '600',
    marginBottom: Spacing.sm,
  },
  paymentCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    marginBottom: Spacing.sm,
  },
  paymentHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: Spacing.sm,
  },
  typeBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.xs,
  },
  typeBadgeText: {
    fontSize: 12,
    fontWeight: '600',
  },
  paymentDate: {
    fontSize: 12,
  },
  paymentContent: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  paymentInfo: {
    flex: 1,
    marginRight: Spacing.md,
  },
  clientName: {
    fontSize: 16,
    fontWeight: '600',
    marginBottom: 2,
  },
  orderNumber: {
    fontSize: 14,
  },
  paymentNotes: {
    fontSize: 12,
    marginTop: 2,
  },
  paymentAmount: {
    fontSize: 18,
    fontWeight: '700',
  },
  managerName: {
    fontSize: 12,
    marginTop: Spacing.sm,
  },
  emptyContainer: {
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: Spacing["2xl"],
    gap: Spacing.md,
  },
  emptyText: {
    fontSize: 16,
  },
  clearButton: {
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
  },
  clearButtonText: {
    fontSize: 14,
    fontWeight: '600',
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.5)',
    justifyContent: 'flex-end',
  },
  modalContent: {
    borderTopLeftRadius: BorderRadius.lg,
    borderTopRightRadius: BorderRadius.lg,
    padding: Spacing.lg,
    maxHeight: '80%',
  },
  modalHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: Spacing.lg,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: '700',
  },
  filterSection: {
    marginBottom: Spacing.lg,
  },
  filterLabel: {
    fontSize: 14,
    fontWeight: '600',
    marginBottom: Spacing.sm,
  },
  filterOptions: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: Spacing.sm,
  },
  filterOption: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
  filterOptionText: {
    fontSize: 14,
  },
  dateRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.sm,
  },
  dateButton: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.sm,
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
  modalActions: {
    flexDirection: 'row',
    gap: Spacing.md,
    marginTop: Spacing.lg,
  },
  modalButton: {
    flex: 1,
    alignItems: 'center',
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.sm,
  },
  webDatePickerContainer: {
    gap: Spacing.xs,
  },
  webDatePickerRow: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  inlineDatePickerContainer: {
    alignItems: 'center',
    paddingVertical: Spacing.md,
  },
  datePickerActions: {
    flexDirection: 'row',
    gap: Spacing.md,
    marginTop: Spacing.lg,
  },
  datePickerBtn: {
    flex: 1,
    alignItems: 'center',
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.lg,
    borderRadius: BorderRadius.sm,
  },
});
