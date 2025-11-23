import { View, StyleSheet, Pressable } from "react-native";
import { Feather } from "@expo/vector-icons";
import { GlassView } from "expo-glass-effect";
import { ThemedText } from "@/components/ThemedText";
import { Spacing, BorderRadius } from "@/constants/theme";
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
}

export function ExcursionCard({
  excursion,
  tourTypeName,
  revenue,
  expenses,
  profit,
  onPress,
}: ExcursionCardProps) {
  const { theme, isDark } = useTheme();
  const totalParticipants =
    excursion.fullPriceCount + excursion.discountedCount + excursion.freeCount;

  return (
    <Pressable onPress={onPress} style={({ pressed }) => ({ opacity: pressed ? 0.95 : 1 })}>
      <View
        style={[
          styles.cardWrapper,
          {
            borderRadius: BorderRadius.md,
            shadowColor: theme.glassShadow,
            shadowOffset: { width: 0, height: 2 },
            shadowOpacity: 0.1,
            shadowRadius: 8,
            elevation: 3,
          },
        ]}
      >
        <GlassView
          glassEffectStyle={isDark ? "regular" : "clear"}
          tintColor={isDark ? theme.glassVeil : theme.glassMist}
          style={[
            styles.card,
            {
              borderRadius: BorderRadius.md,
              borderWidth: 1,
              borderColor: theme.glassStroke,
            },
          ]}
        >
        <View style={styles.header}>
          <View style={styles.headerLeft}>
            <ThemedText style={styles.tourName}>{tourTypeName}</ThemedText>
            <ThemedText style={[styles.time, { color: theme.textSecondary }]}>
              {excursion.time}
            </ThemedText>
          </View>
          <Feather name="chevron-right" size={20} color={theme.textSecondary} />
        </View>

        <View style={styles.participants}>
          <View style={styles.participantItem}>
            <Feather name="users" size={16} color={theme.textSecondary} />
            <ThemedText style={[styles.participantText, { color: theme.textSecondary }]}>
              {totalParticipants} чел.
            </ThemedText>
          </View>
          <View style={styles.participantBreakdown}>
            <ThemedText style={[styles.smallText, { color: theme.textSecondary }]}>
              Полная: {excursion.fullPriceCount} • Льготная: {excursion.discountedCount} •
              Бесплатно: {excursion.freeCount}
            </ThemedText>
          </View>
        </View>

        <View style={styles.finances}>
          <View style={styles.financeRow}>
            <ThemedText style={[styles.financeLabel, { color: theme.textSecondary }]}>
              Доход:
            </ThemedText>
            <ThemedText style={styles.financeValue}>{formatCurrency(revenue)}</ThemedText>
          </View>
          <View style={styles.financeRow}>
            <ThemedText style={[styles.financeLabel, { color: theme.textSecondary }]}>
              Расходы:
            </ThemedText>
            <ThemedText style={styles.financeValue}>{formatCurrency(expenses)}</ThemedText>
          </View>
          <View style={[styles.financeRow, styles.profitRow]}>
            <ThemedText style={styles.profitLabel}>Прибыль:</ThemedText>
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
        <View
          style={[
            styles.highlightLine,
            {
              backgroundColor: theme.glassHighlight,
            },
          ]}
        />
      </GlassView>
      </View>
    </Pressable>
  );
}

const styles = StyleSheet.create({
  cardWrapper: {
    overflow: "visible",
  },
  card: {
    padding: Spacing.lg,
    gap: Spacing.md,
    overflow: "hidden",
  },
  highlightLine: {
    position: "absolute",
    top: 0,
    left: 0,
    right: 0,
    height: 1,
    opacity: 0.6,
  },
  header: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  headerLeft: {
    flex: 1,
    gap: Spacing.xs,
  },
  tourName: {
    fontSize: 18,
    fontWeight: "600",
  },
  time: {
    fontSize: 14,
  },
  participants: {
    gap: Spacing.xs,
  },
  participantItem: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
  },
  participantText: {
    fontSize: 14,
  },
  participantBreakdown: {
    marginLeft: Spacing.xl,
  },
  smallText: {
    fontSize: 12,
  },
  finances: {
    gap: Spacing.xs,
  },
  financeRow: {
    flexDirection: "row",
    justifyContent: "space-between",
  },
  financeLabel: {
    fontSize: 14,
  },
  financeValue: {
    fontSize: 14,
    fontWeight: "500",
  },
  profitRow: {
    marginTop: Spacing.xs,
    paddingTop: Spacing.sm,
    borderTopWidth: 1,
    borderTopColor: "#E5E7EB",
  },
  profitLabel: {
    fontSize: 16,
    fontWeight: "600",
  },
  profitValue: {
    fontSize: 16,
    fontWeight: "700",
  },
});
