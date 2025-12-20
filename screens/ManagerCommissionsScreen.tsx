import { useState, useMemo } from "react";
import { View, StyleSheet, Pressable, SectionList, Alert, Modal, TextInput, KeyboardAvoidingView, Platform } from "react-native";
import { useRoute, RouteProp } from "@react-navigation/native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";
import { useRental, RentalCommission } from "@/contexts/RentalContext";
import { hapticFeedback } from "@/utils/haptics";
import { useScreenInsets } from "@/hooks/useScreenInsets";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";

type RouteParams = RouteProp<SettingsStackParamList, "ManagerCommissions">;

type TabType = "accruals" | "payments";

interface MonthSection {
  title: string;
  monthTotal: number;
  data: RentalCommission[];
}

export default function ManagerCommissionsScreen() {
  const { theme } = useTheme();
  const route = useRoute<RouteParams>();
  const { paddingTop, scrollInsetBottom } = useScreenInsets();
  const { isAdmin } = useAuth();
  const { rentalCommissions, markManagerCommissionsPaid, payManagerCommissions } = useRental();
  const [isPaying, setIsPaying] = useState(false);
  const [showPayModal, setShowPayModal] = useState(false);
  const [payAmount, setPayAmount] = useState("");

  const { managerId, managerName } = route.params;

  const [activeTab, setActiveTab] = useState<TabType>("accruals");

  const managerCommissions = useMemo(() => {
    return rentalCommissions.filter(c => c.recipientId === managerId);
  }, [rentalCommissions, managerId]);

  const pendingCommissions = useMemo(() => {
    return managerCommissions.filter(c => c.status === "pending");
  }, [managerCommissions]);

  const paidCommissions = useMemo(() => {
    return managerCommissions.filter(c => c.status === "paid");
  }, [managerCommissions]);

  const totalBalance = useMemo(() => {
    return pendingCommissions.reduce((sum, c) => sum + c.amount, 0);
  }, [pendingCommissions]);

  const groupByMonth = (commissions: RentalCommission[]): MonthSection[] => {
    const groups: { [key: string]: RentalCommission[] } = {};
    
    commissions.forEach(c => {
      const date = new Date(c.createdAt);
      const monthKey = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}`;
      if (!groups[monthKey]) {
        groups[monthKey] = [];
      }
      groups[monthKey].push(c);
    });

    const sections: MonthSection[] = Object.keys(groups)
      .sort((a, b) => b.localeCompare(a))
      .map(key => {
        const items = groups[key].sort((a, b) => 
          new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
        );
        const monthTotal = items.reduce((sum, c) => sum + c.amount, 0);
        const date = new Date(key + "-01");
        const monthName = date.toLocaleDateString("ru-RU", { month: "long", year: "numeric" });
        return {
          title: monthName.charAt(0).toUpperCase() + monthName.slice(1),
          monthTotal,
          data: items,
        };
      });

    return sections;
  };

  const sections = useMemo(() => {
    const commissions = activeTab === "accruals" ? pendingCommissions : paidCommissions;
    return groupByMonth(commissions);
  }, [activeTab, pendingCommissions, paidCommissions]);

  const formatDateTime = (dateStr: string): string => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU", {
      day: "2-digit",
      month: "2-digit",
      hour: "2-digit",
      minute: "2-digit",
    });
  };

  const formatCurrency = (amount: number) => {
    return amount.toLocaleString("ru-RU", { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + "₽";
  };

  const handleOpenPayModal = () => {
    setPayAmount(totalBalance.toString());
    setShowPayModal(true);
  };

  const handleConfirmPay = async () => {
    const amount = parseFloat(payAmount.replace(",", "."));
    if (isNaN(amount) || amount <= 0) {
      Alert.alert("Ошибка", "Введите корректную сумму");
      return;
    }
    if (amount > totalBalance) {
      Alert.alert("Ошибка", "Сумма не может превышать баланс");
      return;
    }

    hapticFeedback.medium();
    setIsPaying(true);
    setShowPayModal(false);

    try {
      if (amount === totalBalance) {
        await markManagerCommissionsPaid(managerId);
      } else {
        await payManagerCommissions(managerId, amount);
      }
    } catch (error) {
      console.error("Failed to pay commissions:", error);
      Alert.alert("Ошибка", "Не удалось выплатить комиссии");
    } finally {
      setIsPaying(false);
    }
  };

  const renderSectionHeader = ({ section }: { section: MonthSection }) => (
    <View style={[styles.sectionHeader, { backgroundColor: theme.backgroundRoot }]}>
      <ThemedText style={styles.sectionTitle}>{section.title}</ThemedText>
      <ThemedText style={[styles.sectionTotal, { color: theme.primary }]}>
        {formatCurrency(section.monthTotal)}
      </ThemedText>
    </View>
  );

  const renderCommission = ({ item }: { item: RentalCommission }) => {
    const roleLabel = item.role === "owner" ? "Обработка заказа" : "Услуга в заказе";
    
    return (
      <View style={[styles.row, { backgroundColor: theme.backgroundSecondary }]}>
        <View style={styles.rowDate}>
          <ThemedText style={[styles.dateText, { color: theme.textSecondary }]}>
            {formatDateTime(item.createdAt)}
          </ThemedText>
        </View>
        <View style={styles.rowBasis}>
          <ThemedText style={[styles.basisText, { color: theme.primary }]}>
            {roleLabel} #{item.orderNumber}
          </ThemedText>
        </View>
        <View style={styles.rowInfo}>
          <ThemedText style={[styles.infoText, { color: theme.textSecondary }]}>
            Аренда радиооборудования ({item.percentage}%)
          </ThemedText>
        </View>
        <View style={styles.rowAmount}>
          <ThemedText style={styles.amountText}>
            {item.amount.toLocaleString("ru-RU", { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
          </ThemedText>
        </View>
      </View>
    );
  };

  return (
    <View style={[styles.container, { backgroundColor: theme.backgroundRoot }]}>
      <View style={[styles.header, { paddingTop: paddingTop }]}>
        <ThemedText style={styles.balanceLabel}>Баланс</ThemedText>
        <ThemedText style={[styles.balanceValue, { color: theme.text }]}>
          {formatCurrency(totalBalance)}
        </ThemedText>

        {isAdmin && totalBalance > 0 && activeTab === "accruals" ? (
          <Pressable
            onPress={handleOpenPayModal}
            disabled={isPaying}
            style={({ pressed }) => [
              styles.payButton,
              { 
                backgroundColor: theme.success,
                opacity: pressed || isPaying ? 0.7 : 1,
              },
            ]}
          >
            <Icon name="check-circle" size={18} color="#fff" />
            <ThemedText style={styles.payButtonText}>
              {isPaying ? "Выплата..." : "Выплатить"}
            </ThemedText>
          </Pressable>
        ) : null}

        <View style={styles.tabsContainer}>
          <Pressable
            onPress={() => { hapticFeedback.selection(); setActiveTab("accruals"); }}
            style={[
              styles.tab,
              activeTab === "accruals" && { borderBottomColor: theme.primary, borderBottomWidth: 2 },
            ]}
          >
            <ThemedText style={[
              styles.tabText,
              { color: activeTab === "accruals" ? theme.primary : theme.textSecondary },
            ]}>
              Начисления
            </ThemedText>
          </Pressable>
          <Pressable
            onPress={() => { hapticFeedback.selection(); setActiveTab("payments"); }}
            style={[
              styles.tab,
              activeTab === "payments" && { borderBottomColor: theme.primary, borderBottomWidth: 2 },
            ]}
          >
            <ThemedText style={[
              styles.tabText,
              { color: activeTab === "payments" ? theme.primary : theme.textSecondary },
            ]}>
              Выплаты
            </ThemedText>
          </Pressable>
        </View>
      </View>

      <View style={[styles.tableHeader, { backgroundColor: theme.backgroundSecondary }]}>
        <ThemedText style={[styles.columnHeader, styles.colDate, { color: theme.textSecondary }]}>
          Дата
        </ThemedText>
        <ThemedText style={[styles.columnHeader, styles.colBasis, { color: theme.textSecondary }]}>
          Основание
        </ThemedText>
        <ThemedText style={[styles.columnHeader, styles.colInfo, { color: theme.textSecondary }]}>
          Информация
        </ThemedText>
        <ThemedText style={[styles.columnHeader, styles.colAmount, { color: theme.textSecondary }]}>
          Сумма, ₽
        </ThemedText>
      </View>

      <SectionList
        sections={sections}
        renderItem={renderCommission}
        renderSectionHeader={renderSectionHeader}
        keyExtractor={(item) => item.id}
        stickySectionHeadersEnabled
        ListEmptyComponent={
          <View style={styles.emptyContainer}>
            <Icon name="dollar-sign" size={48} color={theme.textSecondary} />
            <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
              {activeTab === "accruals" ? "Нет начислений" : "Нет выплат"}
            </ThemedText>
          </View>
        }
        contentContainerStyle={{ paddingBottom: scrollInsetBottom }}
      />

      <Modal
        visible={showPayModal}
        transparent
        animationType="fade"
        onRequestClose={() => setShowPayModal(false)}
      >
        <KeyboardAvoidingView 
          behavior={Platform.OS === "ios" ? "padding" : "height"}
          style={styles.modalOverlay}
        >
          <Pressable 
            style={styles.modalBackdrop} 
            onPress={() => setShowPayModal(false)} 
          />
          <View style={[styles.modalContent, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={styles.modalTitle}>Выплата комиссии</ThemedText>
            
            <View style={styles.modalBalanceRow}>
              <ThemedText style={[styles.modalLabel, { color: theme.textSecondary }]}>
                Баланс к выплате:
              </ThemedText>
              <ThemedText style={[styles.modalBalanceValue, { color: theme.primary }]}>
                {formatCurrency(totalBalance)}
              </ThemedText>
            </View>

            <ThemedText style={[styles.modalLabel, { color: theme.textSecondary }]}>
              Сумма выплаты:
            </ThemedText>
            <TextInput
              style={[
                styles.modalInput,
                { 
                  backgroundColor: theme.backgroundRoot,
                  color: theme.text,
                  borderColor: theme.border,
                },
              ]}
              value={payAmount}
              onChangeText={setPayAmount}
              keyboardType="numeric"
              placeholder="Введите сумму"
              placeholderTextColor={theme.textSecondary}
              selectTextOnFocus
            />

            <View style={styles.modalButtons}>
              <Pressable
                onPress={() => setShowPayModal(false)}
                style={({ pressed }) => [
                  styles.modalButton,
                  { backgroundColor: theme.backgroundRoot, opacity: pressed ? 0.7 : 1 },
                ]}
              >
                <ThemedText style={styles.modalButtonText}>Отмена</ThemedText>
              </Pressable>
              <Pressable
                onPress={handleConfirmPay}
                style={({ pressed }) => [
                  styles.modalButton,
                  { backgroundColor: theme.success, opacity: pressed ? 0.7 : 1 },
                ]}
              >
                <ThemedText style={[styles.modalButtonText, { color: "#fff" }]}>
                  Выплатить
                </ThemedText>
              </Pressable>
            </View>
          </View>
        </KeyboardAvoidingView>
      </Modal>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  header: {
    paddingHorizontal: Spacing.md,
    paddingBottom: Spacing.sm,
  },
  balanceLabel: {
    fontSize: 14,
    opacity: 0.7,
  },
  balanceValue: {
    fontSize: 28,
    fontWeight: "700",
    marginBottom: Spacing.md,
  },
  payButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.lg,
    borderRadius: BorderRadius.sm,
    marginBottom: Spacing.md,
    gap: Spacing.sm,
  },
  payButtonText: {
    color: "#fff",
    fontSize: 16,
    fontWeight: "600",
  },
  tabsContainer: {
    flexDirection: "row",
    gap: Spacing.lg,
  },
  tab: {
    paddingBottom: Spacing.sm,
  },
  tabText: {
    fontSize: 16,
    fontWeight: "500",
  },
  tableHeader: {
    flexDirection: "row",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
  },
  columnHeader: {
    fontSize: 12,
    fontWeight: "500",
  },
  colDate: {
    width: 80,
  },
  colBasis: {
    flex: 1,
  },
  colInfo: {
    flex: 1.5,
  },
  colAmount: {
    width: 80,
    textAlign: "right",
  },
  sectionHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: "600",
  },
  sectionTotal: {
    fontSize: 16,
    fontWeight: "600",
  },
  row: {
    flexDirection: "row",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderBottomWidth: 1,
    borderBottomColor: "rgba(255,255,255,0.05)",
  },
  rowDate: {
    width: 80,
  },
  dateText: {
    fontSize: 12,
  },
  rowBasis: {
    flex: 1,
  },
  basisText: {
    fontSize: 13,
  },
  rowInfo: {
    flex: 1.5,
  },
  infoText: {
    fontSize: 12,
  },
  rowAmount: {
    width: 80,
    alignItems: "flex-end",
  },
  amountText: {
    fontSize: 14,
    fontWeight: "500",
  },
  emptyContainer: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: Spacing["5xl"],
  },
  emptyText: {
    fontSize: 16,
    marginTop: Spacing.md,
  },
  modalOverlay: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  modalBackdrop: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "rgba(0,0,0,0.6)",
  },
  modalContent: {
    width: "85%",
    maxWidth: 400,
    borderRadius: BorderRadius.md,
    padding: Spacing.lg,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "600",
    marginBottom: Spacing.lg,
    textAlign: "center",
  },
  modalBalanceRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  modalLabel: {
    fontSize: 14,
    marginBottom: Spacing.xs,
  },
  modalBalanceValue: {
    fontSize: 18,
    fontWeight: "700",
  },
  modalInput: {
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    fontSize: 18,
    fontWeight: "600",
    marginBottom: Spacing.lg,
  },
  modalButtons: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  modalButton: {
    flex: 1,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
  modalButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
});
