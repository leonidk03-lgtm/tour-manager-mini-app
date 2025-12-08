import React, { memo } from "react";
import { View, StyleSheet, Pressable } from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { Spacing } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { Excursion } from "@/contexts/DataContext";
import { formatCurrency } from "@/utils/calculations";

interface ExcursionCardProps {
  excursion: Excursion;
  tourTypeName: string;
  revenue: number;
  expenses: number;
  profit: number;
  onPress: () => void;
  showManagerName?: boolean;
  notesCount?: number;
}

export const ExcursionCard = memo(function ExcursionCard({
  excursion,
  tourTypeName,
  revenue,
  expenses,
  profit,
  onPress,
  showManagerName = false,
  notesCount = 0,
}: ExcursionCardProps) {
  const { theme } = useTheme();
  const totalParticipants =
    excursion.fullPriceCount + excursion.discountedCount + excursion.freeCount + excursion.byTourCount + excursion.paidCount;

  return (
    <Pressable
      onPress={onPress}
      style={({ pressed }) => [
        styles.card,
        {
          backgroundColor: pressed ? theme.backgroundSecondary : "transparent",
          borderBottomWidth: 1,
          borderBottomColor: theme.divider,
        },
      ]}
    >
      <View style={styles.header}>
        <View style={styles.headerLeft}>
          <ThemedText style={styles.tourName}>{tourTypeName}</ThemedText>
          <View style={styles.subHeader}>
            <ThemedText style={[styles.time, { color: theme.textSecondary }]}>
              {excursion.time}
            </ThemedText>
            {showManagerName && excursion.managerName ? (
              <ThemedText style={[styles.managerName, { color: theme.primary }]}>
                {excursion.managerName}
              </ThemedText>
            ) : null}
            {notesCount > 0 ? (
              <View style={[styles.notesBadge, { backgroundColor: theme.primary }]}>
                <Feather name="message-square" size={10} color="#FFFFFF" />
                <ThemedText style={styles.notesBadgeText}>{notesCount}</ThemedText>
              </View>
            ) : null}
          </View>
        </View>
        <Feather name="chevron-right" size={20} color={theme.textSecondary} />
      </View>

      <View style={styles.participants}>
        <ThemedText style={[styles.participantText, { color: theme.textSecondary }]}>
          {totalParticipants} чел. • Полная: {excursion.fullPriceCount} • Льготная:{" "}
          {excursion.discountedCount} • Бесплатно: {excursion.freeCount}
        </ThemedText>
      </View>

      <View style={styles.finances}>
        <View style={styles.financeRow}>
          <ThemedText style={[styles.financeLabel, { color: theme.textSecondary }]}>
            Доход
          </ThemedText>
          <ThemedText style={[styles.financeValue, { color: theme.text }]}>
            {formatCurrency(revenue)}
          </ThemedText>
        </View>
        <View style={styles.financeRow}>
          <ThemedText style={[styles.financeLabel, { color: theme.textSecondary }]}>
            Расходы
          </ThemedText>
          <ThemedText style={[styles.financeValue, { color: theme.text }]}>
            {formatCurrency(expenses)}
          </ThemedText>
        </View>
        <View
          style={[
            styles.financeRow,
            styles.profitRow,
            { borderTopColor: theme.divider },
          ]}
        >
          <ThemedText style={[styles.profitLabel, { color: theme.text }]}>Прибыль</ThemedText>
          <ThemedText
            style={[
              styles.profitValue,
              {
                color: profit >= 0 ? theme.success : theme.error,
              },
            ]}
          >
            {formatCurrency(profit)}
          </ThemedText>
        </View>
      </View>
    </Pressable>
  );
});

const styles = StyleSheet.create({
  card: {
    padding: Spacing.lg,
    gap: Spacing.md,
  },
  header: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "flex-start",
  },
  headerLeft: {
    flex: 1,
    gap: Spacing.xs,
  },
  tourName: {
    fontSize: 17,
    fontWeight: "600",
  },
  subHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  time: {
    fontSize: 15,
  },
  managerName: {
    fontSize: 13,
    fontWeight: "500",
  },
  participants: {
    marginTop: -Spacing.xs,
  },
  participantText: {
    fontSize: 13,
    lineHeight: 18,
  },
  finances: {
    gap: Spacing.xs,
    marginTop: Spacing.xs,
  },
  financeRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  financeLabel: {
    fontSize: 15,
  },
  financeValue: {
    fontSize: 15,
    fontWeight: "500",
  },
  profitRow: {
    marginTop: Spacing.xs,
    paddingTop: Spacing.sm,
    borderTopWidth: 1,
  },
  profitLabel: {
    fontSize: 15,
    fontWeight: "600",
  },
  profitValue: {
    fontSize: 17,
    fontWeight: "700",
  },
  notesBadge: {
    flexDirection: "row",
    alignItems: "center",
    gap: 3,
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: 10,
  },
  notesBadgeText: {
    color: "#FFFFFF",
    fontSize: 11,
    fontWeight: "600",
  },
});
