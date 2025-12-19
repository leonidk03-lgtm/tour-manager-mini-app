import { useMemo } from "react";
import { View, StyleSheet, Pressable, FlatList } from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";
import { useRental, RentalCommission } from "@/contexts/RentalContext";
import { hapticFeedback } from "@/utils/haptics";
import { useScreenInsets } from "@/hooks/useScreenInsets";

export default function RentalCommissionsScreen() {
  const { theme } = useTheme();
  const insets = useSafeAreaInsets();
  const { paddingTop, paddingBottom, scrollInsetBottom } = useScreenInsets();
  const { profile, isAdmin } = useAuth();
  const { rentalCommissions, getManagerCommissions, markCommissionPaid } = useRental();

  const displayedCommissions = useMemo(() => {
    if (isAdmin) {
      return rentalCommissions;
    }
    return profile ? getManagerCommissions(profile.id) : [];
  }, [isAdmin, profile, rentalCommissions, getManagerCommissions]);

  const pendingCommissions = useMemo(() => {
    return displayedCommissions.filter(c => c.status === "pending");
  }, [displayedCommissions]);

  const paidCommissions = useMemo(() => {
    return displayedCommissions.filter(c => c.status === "paid");
  }, [displayedCommissions]);

  const totalPending = useMemo(() => {
    return pendingCommissions.reduce((sum, c) => sum + c.amount, 0);
  }, [pendingCommissions]);

  const formatDate = (dateStr: string): string => {
    return new Date(dateStr).toLocaleDateString("ru-RU", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
    });
  };

  const handleMarkPaid = async (commission: RentalCommission) => {
    hapticFeedback.medium();
    try {
      await markCommissionPaid(commission.id);
    } catch (error) {
      console.error("Failed to mark commission paid:", error);
    }
  };

  const renderCommission = ({ item }: { item: RentalCommission }) => {
    const roleLabel = item.role === "owner" ? "Владелец клиента" : "Исполнитель";
    const isPending = item.status === "pending";

    return (
      <ThemedView
        style={[
          styles.card,
          {
            borderColor: theme.border,
            borderRadius: BorderRadius.sm,
          },
        ]}
      >
        <View style={styles.cardHeader}>
          <View style={styles.orderInfo}>
            <Icon
              name="hash"
              size={14}
              color={theme.textSecondary}
              style={{ marginRight: 4 }}
            />
            <ThemedText style={[styles.orderNumber, { color: theme.textSecondary }]}>
              {item.orderNumber}
            </ThemedText>
          </View>
          <View
            style={[
              styles.statusBadge,
              { backgroundColor: isPending ? theme.warning : theme.success },
            ]}
          >
            <ThemedText style={[styles.statusText, { color: "#fff" }]}>
              {isPending ? "К выплате" : "Выплачено"}
            </ThemedText>
          </View>
        </View>

        <View style={styles.cardContent}>
          <View style={styles.infoRow}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Получатель:
            </ThemedText>
            <ThemedText style={styles.value}>{item.recipientName}</ThemedText>
          </View>
          <View style={styles.infoRow}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Роль:
            </ThemedText>
            <ThemedText style={styles.value}>{roleLabel}</ThemedText>
          </View>
          <View style={styles.infoRow}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              База расчёта:
            </ThemedText>
            <ThemedText style={styles.value}>{item.basisAmount}₽</ThemedText>
          </View>
          <View style={styles.infoRow}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Процент:
            </ThemedText>
            <ThemedText style={styles.value}>{item.percentage}%</ThemedText>
          </View>
          <View style={styles.infoRow}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Сумма:
            </ThemedText>
            <ThemedText style={[styles.amount, { color: theme.primary }]}>
              {item.amount}₽
            </ThemedText>
          </View>
          <View style={styles.infoRow}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Дата:
            </ThemedText>
            <ThemedText style={styles.value}>{formatDate(item.createdAt)}</ThemedText>
          </View>
          {item.paidAt ? (
            <View style={styles.infoRow}>
              <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                Выплачено:
              </ThemedText>
              <ThemedText style={styles.value}>{formatDate(item.paidAt)}</ThemedText>
            </View>
          ) : null}
        </View>

        {isAdmin && isPending ? (
          <Pressable
            style={({ pressed }) => [
              styles.payButton,
              { backgroundColor: theme.success, opacity: pressed ? 0.7 : 1 },
            ]}
            onPress={() => handleMarkPaid(item)}
          >
            <Icon name="check" size={16} color="#fff" />
            <ThemedText style={styles.payButtonText}>Отметить выплаченной</ThemedText>
          </Pressable>
        ) : null}
      </ThemedView>
    );
  };

  const renderHeader = () => (
    <View style={styles.headerContainer}>
      <ThemedView
        style={[
          styles.summaryCard,
          { borderColor: theme.border, borderRadius: BorderRadius.sm },
        ]}
      >
        <View style={styles.summaryRow}>
          <ThemedText style={[styles.summaryLabel, { color: theme.textSecondary }]}>
            К выплате:
          </ThemedText>
          <ThemedText style={[styles.summaryValue, { color: theme.primary }]}>
            {totalPending}₽
          </ThemedText>
        </View>
        <View style={styles.summaryRow}>
          <ThemedText style={[styles.summaryLabel, { color: theme.textSecondary }]}>
            Ожидающих:
          </ThemedText>
          <ThemedText style={styles.summaryCount}>{pendingCommissions.length}</ThemedText>
        </View>
        <View style={styles.summaryRow}>
          <ThemedText style={[styles.summaryLabel, { color: theme.textSecondary }]}>
            Выплачено:
          </ThemedText>
          <ThemedText style={styles.summaryCount}>{paidCommissions.length}</ThemedText>
        </View>
      </ThemedView>

      {pendingCommissions.length > 0 ? (
        <ThemedText style={styles.sectionTitle}>Ожидающие выплаты</ThemedText>
      ) : null}
    </View>
  );

  const allCommissions = [...pendingCommissions, ...paidCommissions];

  return (
    <View style={[styles.container, { backgroundColor: theme.backgroundRoot }]}>
      <FlatList
        data={allCommissions}
        renderItem={renderCommission}
        keyExtractor={(item) => item.id}
        ListHeaderComponent={renderHeader}
        ListEmptyComponent={
          <View style={styles.emptyContainer}>
            <Icon name="dollar-sign" size={48} color={theme.textSecondary} />
            <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
              Нет комиссий
            </ThemedText>
          </View>
        }
        contentContainerStyle={[
          styles.listContent,
          {
            paddingTop: paddingTop,
            paddingBottom: scrollInsetBottom,
          },
        ]}
        showsVerticalScrollIndicator={false}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  listContent: {
    paddingHorizontal: Spacing.md,
  },
  headerContainer: {
    marginBottom: Spacing.md,
  },
  summaryCard: {
    padding: Spacing.md,
    borderWidth: 1,
    marginBottom: Spacing.md,
  },
  summaryRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.xs,
  },
  summaryLabel: {
    fontSize: 14,
  },
  summaryValue: {
    fontSize: 20,
    fontWeight: "700",
  },
  summaryCount: {
    fontSize: 16,
    fontWeight: "600",
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: Spacing.sm,
  },
  card: {
    borderWidth: 1,
    marginBottom: Spacing.sm,
    overflow: "hidden",
  },
  cardHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.sm,
    borderBottomWidth: 1,
    borderBottomColor: "rgba(255,255,255,0.1)",
  },
  orderInfo: {
    flexDirection: "row",
    alignItems: "center",
  },
  orderNumber: {
    fontSize: 14,
    fontWeight: "500",
  },
  statusBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.xs,
  },
  statusText: {
    fontSize: 12,
    fontWeight: "600",
  },
  cardContent: {
    padding: Spacing.sm,
  },
  infoRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: 4,
  },
  label: {
    fontSize: 13,
  },
  value: {
    fontSize: 14,
    fontWeight: "500",
  },
  amount: {
    fontSize: 16,
    fontWeight: "700",
  },
  payButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.sm,
    gap: 8,
  },
  payButtonText: {
    color: "#fff",
    fontWeight: "600",
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
