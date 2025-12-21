import { useState, useEffect, useMemo } from "react";
import { View, StyleSheet, Pressable, Modal, Platform, ActivityIndicator } from "react-native";
import DateTimePicker from "@react-native-community/datetimepicker";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, DispatchStats } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";

type Period = "day" | "week" | "month" | "year" | "all" | "custom";

const periodLabels: Record<Period, string> = {
  day: "День",
  week: "Неделя",
  month: "Месяц",
  year: "Год",
  all: "Все время",
  custom: "Период",
};

function getDateRangeForPeriod(period: Period, customFrom: Date, customTo: Date): { startDate: string; endDate: string } {
  const now = new Date();
  let startDate: Date;
  let endDate = new Date(now);

  switch (period) {
    case "day":
      startDate = new Date(now);
      startDate.setHours(0, 0, 0, 0);
      break;
    case "week":
      startDate = new Date(now);
      startDate.setDate(now.getDate() - 7);
      break;
    case "month":
      startDate = new Date(now);
      startDate.setMonth(now.getMonth() - 1);
      break;
    case "year":
      startDate = new Date(now);
      startDate.setFullYear(now.getFullYear() - 1);
      break;
    case "custom":
      startDate = new Date(customFrom);
      endDate = new Date(customTo);
      break;
    default:
      startDate = new Date(2020, 0, 1);
      break;
  }

  return {
    startDate: startDate.toISOString().split("T")[0],
    endDate: endDate.toISOString().split("T")[0],
  };
}

export default function DispatchActivityReportScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const { getDispatchStats, managers } = useData();
  const [period, setPeriod] = useState<Period>("month");
  const [customFrom, setCustomFrom] = useState<Date>(new Date());
  const [customTo, setCustomTo] = useState<Date>(new Date());
  const [showDatePicker, setShowDatePicker] = useState<"from" | "to" | null>(null);
  const [stats, setStats] = useState<DispatchStats[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  const formatShortDate = (date: Date) => {
    return date.toLocaleDateString("ru-RU", { day: "numeric", month: "short" });
  };

  useEffect(() => {
    loadStats();
  }, [period, customFrom, customTo]);

  const loadStats = async () => {
    setIsLoading(true);
    try {
      const { startDate, endDate } = getDateRangeForPeriod(period, customFrom, customTo);
      const data = await getDispatchStats(startDate, endDate);
      setStats(data);
    } catch (error) {
      console.error("Failed to load dispatch stats:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const totals = useMemo(() => {
    return stats.reduce(
      (acc, s) => ({
        phones: acc.phones + (s.netPhones || 0),
        pax: acc.pax + (s.netPax || 0),
      }),
      { phones: 0, pax: 0 }
    );
  }, [stats]);

  if (!isAdmin) {
    return (
      <ScreenScrollView>
        <View style={styles.container}>
          <ThemedText style={styles.sectionTitle}>Доступ запрещен</ThemedText>
          <ThemedText style={{ textAlign: "center", color: theme.textSecondary }}>
            Этот раздел доступен только администраторам
          </ThemedText>
        </View>
      </ScreenScrollView>
    );
  }

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <View style={styles.periodSelector}>
          {(Object.keys(periodLabels) as Period[]).map((p) => (
            <Pressable
              key={p}
              style={[
                styles.periodButton,
                {
                  backgroundColor: period === p ? theme.primary : theme.backgroundSecondary,
                },
              ]}
              onPress={() => setPeriod(p)}
            >
              <ThemedText
                style={[
                  styles.periodButtonText,
                  { color: period === p ? theme.buttonText : theme.text },
                ]}
              >
                {periodLabels[p]}
              </ThemedText>
            </Pressable>
          ))}
        </View>

        {period === "custom" ? (
          <View style={styles.customDateRow}>
            <Pressable
              style={[styles.dateButton, { backgroundColor: theme.backgroundSecondary }]}
              onPress={() => setShowDatePicker("from")}
            >
              <Icon name="calendar" size={16} color={theme.textSecondary} />
              <ThemedText>{formatShortDate(customFrom)}</ThemedText>
            </Pressable>
            <ThemedText style={{ color: theme.textSecondary }}>—</ThemedText>
            <Pressable
              style={[styles.dateButton, { backgroundColor: theme.backgroundSecondary }]}
              onPress={() => setShowDatePicker("to")}
            >
              <Icon name="calendar" size={16} color={theme.textSecondary} />
              <ThemedText>{formatShortDate(customTo)}</ThemedText>
            </Pressable>
          </View>
        ) : null}

        {isLoading ? (
          <View style={styles.loadingContainer}>
            <ActivityIndicator size="large" color={theme.primary} />
          </View>
        ) : (
          <>
            <View style={[styles.totalCard, { backgroundColor: theme.backgroundSecondary }]}>
              <ThemedText style={styles.totalTitle}>Итого за период</ThemedText>
              <View style={styles.totalRow}>
                <View style={styles.totalItem}>
                  <ThemedText style={[styles.totalValue, { color: theme.primary }]}>
                    {totals.phones}
                  </ThemedText>
                  <ThemedText style={[styles.totalLabel, { color: theme.textSecondary }]}>
                    номеров
                  </ThemedText>
                </View>
                <View style={styles.totalItem}>
                  <ThemedText style={[styles.totalValue, { color: theme.success }]}>
                    {totals.pax}
                  </ThemedText>
                  <ThemedText style={[styles.totalLabel, { color: theme.textSecondary }]}>
                    человек
                  </ThemedText>
                </View>
              </View>
            </View>

            <ThemedText style={styles.sectionTitle}>По менеджерам</ThemedText>

            {stats.length === 0 ? (
              <View style={[styles.emptyState, { backgroundColor: theme.backgroundSecondary }]}>
                <Icon name="users" size={48} color={theme.textSecondary} />
                <ThemedText style={{ color: theme.textSecondary, marginTop: Spacing.md }}>
                  Нет данных за выбранный период
                </ThemedText>
              </View>
            ) : (
              <View style={styles.managersList}>
                {stats.map((stat, index) => (
                  <View
                    key={stat.managerId}
                    style={[
                      styles.managerCard,
                      { backgroundColor: theme.backgroundSecondary },
                    ]}
                  >
                    <View style={styles.managerHeader}>
                      <View style={[styles.rankBadge, { backgroundColor: theme.primary + "20" }]}>
                        <ThemedText style={[styles.rankText, { color: theme.primary }]}>
                          #{index + 1}
                        </ThemedText>
                      </View>
                      <ThemedText style={styles.managerName} numberOfLines={1}>
                        {stat.managerName || "Неизвестный"}
                      </ThemedText>
                    </View>
                    <View style={styles.managerStats}>
                      <View style={styles.statItem}>
                        <ThemedText style={[styles.statValue, { color: theme.primary }]}>
                          {stat.netPhones || 0}
                        </ThemedText>
                        <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                          номеров
                        </ThemedText>
                      </View>
                      <View style={styles.statItem}>
                        <ThemedText style={[styles.statValue, { color: theme.success }]}>
                          {stat.netPax || 0}
                        </ThemedText>
                        <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                          человек
                        </ThemedText>
                      </View>
                      <View style={styles.statItem}>
                        <ThemedText style={[styles.statValue, { color: theme.textSecondary }]}>
                          {stat.markCount || 0}
                        </ThemedText>
                        <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                          отметок
                        </ThemedText>
                      </View>
                    </View>
                  </View>
                ))}
              </View>
            )}
          </>
        )}
      </View>

      {Platform.OS !== "web" && showDatePicker ? (
        <Modal transparent animationType="fade" visible={!!showDatePicker}>
          <Pressable
            style={styles.datePickerBackdrop}
            onPress={() => setShowDatePicker(null)}
          >
            <View style={[styles.datePickerContainer, { backgroundColor: theme.backgroundDefault }]}>
              <DateTimePicker
                value={showDatePicker === "from" ? customFrom : customTo}
                mode="date"
                display="spinner"
                onChange={(_, date) => {
                  if (date) {
                    if (showDatePicker === "from") {
                      setCustomFrom(date);
                    } else {
                      setCustomTo(date);
                    }
                  }
                }}
                textColor={theme.text}
              />
              <Pressable
                style={[styles.datePickerDone, { backgroundColor: theme.primary }]}
                onPress={() => setShowDatePicker(null)}
              >
                <ThemedText style={{ color: theme.buttonText, fontWeight: "600" }}>
                  Готово
                </ThemedText>
              </Pressable>
            </View>
          </Pressable>
        </Modal>
      ) : null}
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    padding: Spacing.lg,
    gap: Spacing.lg,
  },
  periodSelector: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.xs,
  },
  periodButton: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
  },
  periodButtonText: {
    fontSize: 13,
    fontWeight: "500",
  },
  customDateRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  dateButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
  },
  loadingContainer: {
    padding: Spacing["2xl"],
    alignItems: "center",
  },
  totalCard: {
    padding: Spacing.lg,
    borderRadius: BorderRadius.md,
    gap: Spacing.md,
  },
  totalTitle: {
    fontSize: 16,
    fontWeight: "600",
  },
  totalRow: {
    flexDirection: "row",
    justifyContent: "space-around",
  },
  totalItem: {
    alignItems: "center",
    gap: Spacing.xs,
  },
  totalValue: {
    fontSize: 32,
    fontWeight: "700",
  },
  totalLabel: {
    fontSize: 14,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  emptyState: {
    padding: Spacing["2xl"],
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
  managersList: {
    gap: Spacing.md,
  },
  managerCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.md,
  },
  managerHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  rankBadge: {
    width: 28,
    height: 28,
    borderRadius: 14,
    alignItems: "center",
    justifyContent: "center",
  },
  rankText: {
    fontSize: 12,
    fontWeight: "700",
  },
  managerName: {
    fontSize: 15,
    fontWeight: "600",
    flex: 1,
  },
  managerStats: {
    flexDirection: "row",
    justifyContent: "space-around",
  },
  statItem: {
    alignItems: "center",
    gap: 2,
  },
  statValue: {
    fontSize: 20,
    fontWeight: "700",
  },
  statLabel: {
    fontSize: 12,
  },
  datePickerBackdrop: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
    justifyContent: "center",
    alignItems: "center",
  },
  datePickerContainer: {
    borderRadius: BorderRadius.lg,
    padding: Spacing.lg,
    width: "90%",
    maxWidth: 350,
  },
  datePickerDone: {
    marginTop: Spacing.md,
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
});
