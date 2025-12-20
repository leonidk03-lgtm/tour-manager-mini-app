import { useState, useMemo } from "react";
import { View, StyleSheet, Pressable, FlatList, Alert, Modal, TextInput, KeyboardAvoidingView, Platform } from "react-native";
import { useRoute, RouteProp } from "@react-navigation/native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";
import { useRental } from "@/contexts/RentalContext";
import { hapticFeedback } from "@/utils/haptics";
import { useScreenInsets } from "@/hooks/useScreenInsets";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";

type RouteParams = RouteProp<SettingsStackParamList, "ManagerCommissions">;

interface MonthData {
  key: string;
  monthName: string;
  year: number;
  total: number;
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

  const { managerId } = route.params;

  const managerCommissions = useMemo(() => {
    return rentalCommissions.filter(c => c.recipientId === managerId);
  }, [rentalCommissions, managerId]);

  const pendingCommissions = useMemo(() => {
    return managerCommissions.filter(c => c.status === "pending");
  }, [managerCommissions]);

  const totalBalance = useMemo(() => {
    return pendingCommissions.reduce((sum, c) => sum + c.amount, 0);
  }, [pendingCommissions]);

  const totalPaid = useMemo(() => {
    return managerCommissions
      .filter(c => c.status === "paid")
      .reduce((sum, c) => sum + c.amount, 0);
  }, [managerCommissions]);

  const monthlyData = useMemo(() => {
    const groups: { [key: string]: { total: number; year: number; month: number } } = {};
    
    pendingCommissions.forEach(c => {
      const date = new Date(c.createdAt);
      const year = date.getFullYear();
      const month = date.getMonth();
      const monthKey = `${year}-${String(month + 1).padStart(2, "0")}`;
      
      if (!groups[monthKey]) {
        groups[monthKey] = { total: 0, year, month };
      }
      groups[monthKey].total += c.amount;
    });

    const monthNames = [
      "Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
      "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"
    ];

    const result: MonthData[] = Object.entries(groups)
      .sort((a, b) => b[0].localeCompare(a[0]))
      .map(([key, data]) => ({
        key,
        monthName: monthNames[data.month],
        year: data.year,
        total: data.total,
      }));

    return result;
  }, [pendingCommissions]);

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
      hapticFeedback.success();
    } catch (error) {
      console.error("Failed to pay commissions:", error);
      Alert.alert("Ошибка", "Не удалось выплатить комиссии");
    } finally {
      setIsPaying(false);
    }
  };

  const formatCurrency = (amount: number) => {
    return amount.toLocaleString("ru-RU", { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + "₽";
  };

  const renderMonthItem = ({ item }: { item: MonthData }) => (
    <View style={[styles.monthCard, { backgroundColor: theme.backgroundSecondary }]}>
      <View style={styles.monthInfo}>
        <ThemedText style={styles.monthName}>{item.monthName}</ThemedText>
        <ThemedText style={[styles.monthYear, { color: theme.textSecondary }]}>{item.year}</ThemedText>
      </View>
      <ThemedText style={[styles.monthAmount, { color: theme.primary }]}>
        {formatCurrency(item.total)}
      </ThemedText>
    </View>
  );

  return (
    <View style={[styles.container, { backgroundColor: theme.backgroundRoot }]}>
      <View style={[styles.header, { paddingTop: paddingTop }]}>
        <View style={[styles.balanceCard, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.balanceLabel, { color: theme.textSecondary }]}>
            Начислено комиссии
          </ThemedText>
          <ThemedText style={[styles.balanceValue, { color: theme.text }]}>
            {formatCurrency(totalBalance)}
          </ThemedText>
          
          {totalPaid > 0 ? (
            <ThemedText style={[styles.paidInfo, { color: theme.success }]}>
              Выплачено ранее: {formatCurrency(totalPaid)}
            </ThemedText>
          ) : null}

          {isAdmin && totalBalance > 0 ? (
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
              <Icon name="credit-card" size={18} color="#fff" />
              <ThemedText style={styles.payButtonText}>
                {isPaying ? "Выплата..." : "Сделать выплату"}
              </ThemedText>
            </Pressable>
          ) : null}
        </View>
      </View>

      {monthlyData.length > 0 ? (
        <View style={styles.monthsSection}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            По месяцам
          </ThemedText>
          <FlatList
            data={monthlyData}
            renderItem={renderMonthItem}
            keyExtractor={(item) => item.key}
            contentContainerStyle={{ paddingBottom: scrollInsetBottom }}
            showsVerticalScrollIndicator={false}
          />
        </View>
      ) : (
        <View style={styles.emptyContainer}>
          <Icon name="dollar-sign" size={48} color={theme.textSecondary} />
          <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
            Нет начислений
          </ThemedText>
        </View>
      )}

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
                К выплате:
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
    paddingBottom: Spacing.md,
  },
  balanceCard: {
    borderRadius: BorderRadius.md,
    padding: Spacing.lg,
    alignItems: "center",
  },
  balanceLabel: {
    fontSize: 14,
    marginBottom: Spacing.xs,
  },
  balanceValue: {
    fontSize: 36,
    fontWeight: "700",
  },
  paidInfo: {
    fontSize: 13,
    marginTop: Spacing.sm,
  },
  payButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.xl,
    borderRadius: BorderRadius.sm,
    marginTop: Spacing.lg,
    gap: Spacing.sm,
  },
  payButtonText: {
    color: "#fff",
    fontSize: 16,
    fontWeight: "600",
  },
  monthsSection: {
    flex: 1,
    paddingHorizontal: Spacing.md,
  },
  sectionTitle: {
    fontSize: 14,
    fontWeight: "500",
    marginBottom: Spacing.sm,
    textTransform: "uppercase",
  },
  monthCard: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    marginBottom: Spacing.sm,
  },
  monthInfo: {
    flexDirection: "row",
    alignItems: "baseline",
    gap: Spacing.sm,
  },
  monthName: {
    fontSize: 16,
    fontWeight: "600",
  },
  monthYear: {
    fontSize: 14,
  },
  monthAmount: {
    fontSize: 18,
    fontWeight: "700",
  },
  emptyContainer: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
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
