import { useState, useMemo } from "react";
import { View, StyleSheet, Pressable, Modal, Platform } from "react-native";
import DateTimePicker from "@react-native-community/datetimepicker";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";

type Period = "day" | "week" | "month" | "year" | "all" | "custom";

const periodLabels: Record<Period, string> = {
  day: "День",
  week: "Неделя",
  month: "Месяц",
  year: "Год",
  all: "Всё время",
  custom: "Период",
};

export default function RadioGuidesReportScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const { radioGuideKits, radioGuideAssignments, equipmentLosses } = useData();
  const [period, setPeriod] = useState<Period>("month");
  const [customFrom, setCustomFrom] = useState<Date>(new Date());
  const [customTo, setCustomTo] = useState<Date>(new Date());
  const [showDatePicker, setShowDatePicker] = useState<"from" | "to" | null>(null);

  const formatShortDate = (date: Date) => {
    return date.toLocaleDateString("ru-RU", { day: "numeric", month: "short" });
  };

  if (!isAdmin) {
    return (
      <ScreenScrollView>
        <View style={styles.container}>
          <ThemedText style={styles.sectionTitle}>Доступ запрещён</ThemedText>
          <ThemedText style={{ textAlign: "center", color: theme.textSecondary }}>
            Этот раздел доступен только администраторам
          </ThemedText>
        </View>
      </ScreenScrollView>
    );
  }

  const filterByPeriod = (date: string) => {
    const itemDate = new Date(date);
    const now = new Date();

    switch (period) {
      case "day":
        return itemDate.toDateString() === now.toDateString();
      case "week":
        const weekAgo = new Date(now);
        weekAgo.setDate(now.getDate() - 7);
        return itemDate >= weekAgo;
      case "month":
        const monthAgo = new Date(now);
        monthAgo.setMonth(now.getMonth() - 1);
        return itemDate >= monthAgo;
      case "year":
        const yearAgo = new Date(now);
        yearAgo.setFullYear(now.getFullYear() - 1);
        return itemDate >= yearAgo;
      case "custom":
        const fromDate = new Date(customFrom);
        fromDate.setHours(0, 0, 0, 0);
        const toDate = new Date(customTo);
        toDate.setHours(23, 59, 59, 999);
        return itemDate >= fromDate && itemDate <= toDate;
      default:
        return true;
    }
  };

  const stats = useMemo(() => {
    const filteredAssignments = radioGuideAssignments.filter((a) =>
      filterByPeriod(a.issuedAt)
    );
    const filteredLosses = equipmentLosses.filter((l) =>
      filterByPeriod(l.createdAt)
    );

    const totalKits = radioGuideKits.length;
    const availableKits = radioGuideKits.filter((k) => k.status === "available").length;
    const issuedKits = radioGuideKits.filter((k) => k.status === "issued").length;
    const maintenanceKits = radioGuideKits.filter((k) => k.status === "maintenance").length;

    const totalReceivers = radioGuideAssignments.reduce((sum, a) => sum + a.receiversIssued, 0);

    const totalIssues = filteredAssignments.length;
    const totalReturns = filteredAssignments.filter((a) => a.returnedAt).length;
    const pending = filteredAssignments.filter((a) => !a.returnedAt).length;

    const receiversIssued = filteredAssignments.reduce((sum, a) => sum + a.receiversIssued, 0);
    const receiversReturned = filteredAssignments
      .filter((a) => a.returnedAt)
      .reduce((sum, a) => sum + (a.receiversReturned || 0), 0);

    const lostCount = filteredLosses.filter((l) => l.status === "lost").length;
    const foundCount = filteredLosses.filter((l) => l.status === "found").length;
    const totalLostReceivers = filteredLosses
      .filter((l) => l.status === "lost")
      .reduce((sum, l) => sum + l.missingCount, 0);

    const guideStats: Record<string, { issues: number; returns: number; receivers: number }> = {};
    filteredAssignments.forEach((a) => {
      if (!guideStats[a.guideName]) {
        guideStats[a.guideName] = { issues: 0, returns: 0, receivers: 0 };
      }
      guideStats[a.guideName].issues += 1;
      if (a.returnedAt) {
        guideStats[a.guideName].returns += 1;
      }
      guideStats[a.guideName].receivers += a.receiversIssued;
    });

    const guideList = Object.entries(guideStats)
      .map(([name, data]) => ({ name, ...data }))
      .sort((a, b) => b.issues - a.issues);

    const kitStats: Record<string, { bagNumber: number; issues: number; receivers: number }> = {};
    filteredAssignments.forEach((a) => {
      const kit = radioGuideKits.find((k) => k.id === a.kitId);
      if (kit) {
        const key = kit.id;
        if (!kitStats[key]) {
          kitStats[key] = { bagNumber: kit.bagNumber, issues: 0, receivers: 0 };
        }
        kitStats[key].issues += 1;
        kitStats[key].receivers += a.receiversIssued;
      }
    });

    const kitList = Object.entries(kitStats)
      .map(([id, data]) => ({ id, ...data }))
      .sort((a, b) => b.issues - a.issues);

    return {
      totalKits,
      availableKits,
      issuedKits,
      maintenanceKits,
      totalReceivers,
      totalIssues,
      totalReturns,
      pending,
      receiversIssued,
      receiversReturned,
      lostCount,
      foundCount,
      totalLostReceivers,
      guideList,
      kitList,
    };
  }, [radioGuideKits, radioGuideAssignments, equipmentLosses, period, customFrom, customTo]);

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <View style={styles.periodSelector}>
          {(Object.keys(periodLabels) as Period[]).map((p) => (
            <Pressable
              key={p}
              onPress={() => {
                setPeriod(p);
                if (p === "custom") {
                  setShowDatePicker("from");
                }
              }}
              style={[
                styles.periodButton,
                {
                  backgroundColor: period === p ? theme.primary : theme.backgroundSecondary,
                  borderRadius: BorderRadius.xs,
                },
              ]}
            >
              <ThemedText
                style={[
                  styles.periodText,
                  { color: period === p ? theme.buttonText : theme.text },
                ]}
              >
                {p === "custom" && period === "custom" 
                  ? `${formatShortDate(customFrom)} - ${formatShortDate(customTo)}`
                  : periodLabels[p]}
              </ThemedText>
            </Pressable>
          ))}
        </View>

        {period === "custom" ? (
          <View style={[styles.customDateRow, { backgroundColor: theme.backgroundSecondary, borderRadius: BorderRadius.xs }]}>
            <Pressable 
              style={[styles.datePickButton, { borderColor: theme.border }]}
              onPress={() => setShowDatePicker("from")}
            >
              <Icon name="calendar" size={16} color={theme.textSecondary} />
              <ThemedText style={{ color: theme.text }}>{formatShortDate(customFrom)}</ThemedText>
            </Pressable>
            <ThemedText style={{ color: theme.textSecondary }}>—</ThemedText>
            <Pressable 
              style={[styles.datePickButton, { borderColor: theme.border }]}
              onPress={() => setShowDatePicker("to")}
            >
              <Icon name="calendar" size={16} color={theme.textSecondary} />
              <ThemedText style={{ color: theme.text }}>{formatShortDate(customTo)}</ThemedText>
            </Pressable>
          </View>
        ) : null}

        {showDatePicker ? (
          Platform.OS === "ios" ? (
            <Modal visible={!!showDatePicker} transparent animationType="fade">
              <View style={styles.dateModalOverlay}>
                <Pressable style={styles.dateModalBackdrop} onPress={() => setShowDatePicker(null)} />
                <ThemedView style={[styles.datePickerModal, { backgroundColor: theme.backgroundDefault }]}>
                  <View style={styles.datePickerHeader}>
                    <ThemedText style={styles.datePickerTitle}>
                      {showDatePicker === "from" ? "Дата начала" : "Дата окончания"}
                    </ThemedText>
                    <Pressable onPress={() => {
                      if (showDatePicker === "from") {
                        setShowDatePicker("to");
                      } else {
                        setShowDatePicker(null);
                      }
                    }}>
                      <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>
                        {showDatePicker === "from" ? "Далее" : "Готово"}
                      </ThemedText>
                    </Pressable>
                  </View>
                  <DateTimePicker
                    value={showDatePicker === "from" ? customFrom : customTo}
                    mode="date"
                    display="spinner"
                    onChange={(e, date) => {
                      if (date) {
                        if (showDatePicker === "from") {
                          setCustomFrom(date);
                        } else {
                          setCustomTo(date);
                        }
                      }
                    }}
                    locale="ru"
                    themeVariant="light"
                  />
                </ThemedView>
              </View>
            </Modal>
          ) : (
            <DateTimePicker
              value={showDatePicker === "from" ? customFrom : customTo}
              mode="date"
              display="default"
              onChange={(e, date) => {
                if (date) {
                  if (showDatePicker === "from") {
                    setCustomFrom(date);
                    setShowDatePicker("to");
                  } else {
                    setCustomTo(date);
                    setShowDatePicker(null);
                  }
                } else {
                  setShowDatePicker(null);
                }
              }}
              themeVariant="light"
              locale="ru"
            />
          )
        ) : null}

        <ThemedView
          style={[styles.summaryCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
        >
          <ThemedText style={styles.sectionTitle}>Состояние оборудования</ThemedText>

          <View style={styles.statsGrid}>
            <View style={[styles.statItem, { backgroundColor: theme.primary + "20" }]}>
              <Icon name="package" size={24} color={theme.primary} />
              <ThemedText style={styles.statValue}>{stats.totalKits}</ThemedText>
              <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                Всего сумок
              </ThemedText>
            </View>

            <View style={[styles.statItem, { backgroundColor: theme.success + "20" }]}>
              <Icon name="check-circle" size={24} color={theme.success} />
              <ThemedText style={styles.statValue}>{stats.availableKits}</ThemedText>
              <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                Доступно
              </ThemedText>
            </View>

            <View style={[styles.statItem, { backgroundColor: theme.warning + "20" }]}>
              <Icon name="send" size={24} color={theme.warning} />
              <ThemedText style={styles.statValue}>{stats.issuedKits}</ThemedText>
              <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                Выдано
              </ThemedText>
            </View>
          </View>

          <View style={[styles.infoRow, { backgroundColor: theme.backgroundSecondary, borderRadius: BorderRadius.xs }]}>
            <Icon name="radio" size={18} color={theme.textSecondary} />
            <ThemedText style={[styles.infoText, { color: theme.textSecondary }]}>
              Всего приёмников: {stats.totalReceivers}
            </ThemedText>
          </View>
        </ThemedView>

        <ThemedView
          style={[styles.detailCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
        >
          <ThemedText style={styles.sectionTitle}>Активность за период</ThemedText>

          <View style={styles.activityGrid}>
            <View style={[styles.activityItem, { borderColor: theme.border }]}>
              <Icon name="upload" size={20} color={theme.success} />
              <ThemedText style={styles.activityValue}>{stats.totalIssues}</ThemedText>
              <ThemedText style={[styles.activityLabel, { color: theme.textSecondary }]}>
                Выдач
              </ThemedText>
            </View>

            <View style={[styles.activityItem, { borderColor: theme.border }]}>
              <Icon name="download" size={20} color={theme.primary} />
              <ThemedText style={styles.activityValue}>{stats.totalReturns}</ThemedText>
              <ThemedText style={[styles.activityLabel, { color: theme.textSecondary }]}>
                Возвратов
              </ThemedText>
            </View>

            <View style={[styles.activityItem, { borderColor: theme.border }]}>
              <Icon name="refresh-cw" size={20} color={theme.warning} />
              <ThemedText style={styles.activityValue}>{stats.pending}</ThemedText>
              <ThemedText style={[styles.activityLabel, { color: theme.textSecondary }]}>
                Не возвр.
              </ThemedText>
            </View>
          </View>

          <View style={[styles.divider, { backgroundColor: theme.border }]} />

          <View style={styles.receiversRow}>
            <View style={styles.receiversInfo}>
              <ThemedText style={styles.receiversLabel}>Выдано приёмников</ThemedText>
              <ThemedText style={styles.receiversValue}>{stats.receiversIssued}</ThemedText>
            </View>
            <View style={styles.receiversInfo}>
              <ThemedText style={styles.receiversLabel}>Возвращено</ThemedText>
              <ThemedText style={styles.receiversValue}>{stats.receiversReturned}</ThemedText>
            </View>
          </View>
        </ThemedView>

        <ThemedView
          style={[styles.detailCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
        >
          <ThemedText style={styles.sectionTitle}>Потери оборудования</ThemedText>

          <View style={styles.lossesGrid}>
            <View style={[styles.lossItem, { backgroundColor: theme.error + "20" }]}>
              <Icon name="alert-triangle" size={24} color={theme.error} />
              <ThemedText style={styles.lossValue}>{stats.lostCount}</ThemedText>
              <ThemedText style={[styles.lossLabel, { color: theme.textSecondary }]}>
                Случаев потерь
              </ThemedText>
            </View>

            <View style={[styles.lossItem, { backgroundColor: theme.success + "20" }]}>
              <Icon name="check-circle" size={24} color={theme.success} />
              <ThemedText style={styles.lossValue}>{stats.foundCount}</ThemedText>
              <ThemedText style={[styles.lossLabel, { color: theme.textSecondary }]}>
                Найдено
              </ThemedText>
            </View>
          </View>

          {stats.totalLostReceivers > 0 ? (
            <View
              style={[
                styles.lostAlert,
                { backgroundColor: theme.error + "10", borderRadius: BorderRadius.xs },
              ]}
            >
              <Icon name="alert-circle" size={18} color={theme.error} />
              <ThemedText style={[styles.lostAlertText, { color: theme.error }]}>
                Потеряно приёмников: {stats.totalLostReceivers}
              </ThemedText>
            </View>
          ) : null}
        </ThemedView>

        {stats.guideList.length > 0 ? (
          <ThemedView
            style={[styles.detailCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
          >
            <ThemedText style={styles.sectionTitle}>Топ гидов по выдачам</ThemedText>

            {stats.guideList.slice(0, 10).map((item, index) => (
              <View key={item.name}>
                {index > 0 ? <View style={[styles.divider, { backgroundColor: theme.border }]} /> : null}
                <View style={styles.guideRow}>
                  <View style={styles.guideInfo}>
                    <ThemedText style={styles.guideName}>{item.name}</ThemedText>
                    <ThemedText style={[styles.guideStat, { color: theme.textSecondary }]}>
                      {item.issues} выдач, {item.receivers} приёмников
                    </ThemedText>
                  </View>
                  <View
                    style={[
                      styles.guideReturnBadge,
                      {
                        backgroundColor:
                          item.returns === item.issues
                            ? theme.success + "20"
                            : theme.warning + "20",
                      },
                    ]}
                  >
                    <ThemedText
                      style={[
                        styles.guideReturnText,
                        {
                          color:
                            item.returns === item.issues ? theme.success : theme.warning,
                        },
                      ]}
                    >
                      {item.returns}/{item.issues}
                    </ThemedText>
                  </View>
                </View>
              </View>
            ))}
          </ThemedView>
        ) : null}

        {stats.kitList.length > 0 ? (
          <ThemedView
            style={[styles.detailCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
          >
            <ThemedText style={styles.sectionTitle}>Самые используемые сумки</ThemedText>

            {stats.kitList.slice(0, 10).map((item, index) => (
              <View key={item.id}>
                {index > 0 ? <View style={[styles.divider, { backgroundColor: theme.border }]} /> : null}
                <View style={styles.kitRow}>
                  <View
                    style={[
                      styles.kitBadge,
                      { backgroundColor: theme.primary + "20" },
                    ]}
                  >
                    <ThemedText style={[styles.kitBadgeText, { color: theme.primary }]}>
                      {item.bagNumber}
                    </ThemedText>
                  </View>
                  <View style={styles.kitInfo}>
                    <ThemedText style={styles.kitStat}>
                      {item.issues} выдач
                    </ThemedText>
                    <ThemedText style={[styles.kitStat, { color: theme.textSecondary }]}>
                      {item.receivers} приёмников
                    </ThemedText>
                  </View>
                </View>
              </View>
            ))}
          </ThemedView>
        ) : null}
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing.xl,
  },
  periodSelector: {
    flexDirection: "row",
    gap: Spacing.sm,
    flexWrap: "wrap",
  },
  periodButton: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
  },
  periodText: {
    fontSize: 14,
    fontWeight: "500",
  },
  summaryCard: {
    padding: Spacing.xl,
    borderWidth: 1,
    gap: Spacing.lg,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  statsGrid: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  statItem: {
    flex: 1,
    padding: Spacing.lg,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    gap: Spacing.xs,
  },
  statValue: {
    fontSize: 24,
    fontWeight: "700",
  },
  statLabel: {
    fontSize: 12,
    textAlign: "center",
  },
  infoRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    padding: Spacing.md,
  },
  infoText: {
    fontSize: 14,
  },
  detailCard: {
    padding: Spacing.xl,
    borderWidth: 1,
    gap: Spacing.md,
  },
  activityGrid: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  activityItem: {
    flex: 1,
    alignItems: "center",
    gap: Spacing.xs,
    padding: Spacing.md,
    borderWidth: 1,
    borderRadius: BorderRadius.xs,
  },
  activityValue: {
    fontSize: 20,
    fontWeight: "700",
  },
  activityLabel: {
    fontSize: 12,
  },
  divider: {
    height: 1,
  },
  receiversRow: {
    flexDirection: "row",
    justifyContent: "space-around",
  },
  receiversInfo: {
    alignItems: "center",
    gap: Spacing.xs,
  },
  receiversLabel: {
    fontSize: 14,
  },
  receiversValue: {
    fontSize: 20,
    fontWeight: "600",
  },
  lossesGrid: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  lossItem: {
    flex: 1,
    padding: Spacing.lg,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    gap: Spacing.xs,
  },
  lossValue: {
    fontSize: 24,
    fontWeight: "700",
  },
  lossLabel: {
    fontSize: 12,
    textAlign: "center",
  },
  lostAlert: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    padding: Spacing.md,
  },
  lostAlertText: {
    fontSize: 14,
    fontWeight: "500",
  },
  guideRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingVertical: Spacing.sm,
  },
  guideInfo: {
    flex: 1,
    gap: Spacing.xs,
  },
  guideName: {
    fontSize: 16,
    fontWeight: "500",
  },
  guideStat: {
    fontSize: 14,
  },
  guideReturnBadge: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.xs,
  },
  guideReturnText: {
    fontSize: 14,
    fontWeight: "600",
  },
  kitRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
    paddingVertical: Spacing.sm,
  },
  kitBadge: {
    width: 40,
    height: 40,
    borderRadius: BorderRadius.xs,
    alignItems: "center",
    justifyContent: "center",
  },
  kitBadgeText: {
    fontSize: 16,
    fontWeight: "700",
  },
  kitInfo: {
    flex: 1,
    flexDirection: "row",
    justifyContent: "space-between",
  },
  kitStat: {
    fontSize: 14,
  },
  customDateRow: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.md,
    padding: Spacing.md,
  },
  datePickButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderWidth: 1,
    borderRadius: BorderRadius.xs,
  },
  dateModalOverlay: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  dateModalBackdrop: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "rgba(0,0,0,0.5)",
  },
  datePickerModal: {
    borderRadius: BorderRadius.md,
    padding: Spacing.lg,
    width: "90%",
    maxWidth: 400,
  },
  datePickerHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  datePickerTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
});
