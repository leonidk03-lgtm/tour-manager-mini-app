import { useState, useMemo } from "react";
import { View, StyleSheet, Pressable, SectionList, Alert } from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
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
  const { rentalCommissions, markCommissionPaid } = useRental();

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

  const handleMarkPaid = async (commission: RentalCommission) => {
    Alert.alert(
      "Подтверждение",
      `Отметить комиссию ${commission.amount}₽ как выплаченную?`,
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Выплатить",
          onPress: async () => {
            hapticFeedback.medium();
            try {
              await markCommissionPaid(commission.id);
            } catch (error) {
              console.error("Failed to mark commission paid:", error);
            }
          },
        },
      ]
    );
  };

  const renderSectionHeader = ({ section }: { section: MonthSection }) => (
    <View style={[styles.sectionHeader, { backgroundColor: theme.backgroundRoot }]}>
      <ThemedText style={styles.sectionTitle}>{section.title}</ThemedText>
      <ThemedText style={[styles.sectionTotal, { color: theme.primary }]}>
        {section.monthTotal.toLocaleString("ru-RU", { minimumFractionDigits: 2, maximumFractionDigits: 2 })}₽
      </ThemedText>
    </View>
  );

  const renderCommission = ({ item }: { item: RentalCommission }) => {
    const roleLabel = item.role === "owner" ? "Обработка заказа" : "Услуга в заказе";
    
    return (
      <Pressable
        onPress={() => isAdmin && activeTab === "accruals" ? handleMarkPaid(item) : null}
        style={({ pressed }) => [
          styles.row,
          { 
            backgroundColor: theme.backgroundSecondary,
            opacity: pressed && isAdmin && activeTab === "accruals" ? 0.7 : 1,
          },
        ]}
      >
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
      </Pressable>
    );
  };

  return (
    <View style={[styles.container, { backgroundColor: theme.backgroundRoot }]}>
      <View style={[styles.header, { paddingTop: paddingTop }]}>
        <ThemedText style={styles.balanceLabel}>Баланс</ThemedText>
        <ThemedText style={[styles.balanceValue, { color: theme.text }]}>
          {totalBalance.toLocaleString("ru-RU", { minimumFractionDigits: 2, maximumFractionDigits: 2 })}₽
        </ThemedText>

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
});
