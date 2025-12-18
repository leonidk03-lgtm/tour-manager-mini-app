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

export default function ExcursionsReportScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const { excursions, tourTypes, additionalServices } = useData();
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
    const filtered = excursions.filter((e) => filterByPeriod(e.date));

    const tourTypeStats: Record<string, { count: number; participants: number; revenue: number }> = {};
    const serviceStats: Record<string, { count: number; revenue: number }> = {};

    let totalParticipants = 0;
    let totalFullPrice = 0;
    let totalDiscounted = 0;
    let totalFree = 0;
    let totalByTour = 0;
    let totalPaid = 0;

    filtered.forEach((exc) => {
      const tourType = tourTypes.find((t) => t.id === exc.tourTypeId);
      const typeName = tourType?.name || "Неизвестный тип";

      const participants =
        exc.fullPriceCount + exc.discountedCount + exc.freeCount + exc.byTourCount + exc.paidCount;
      totalParticipants += participants;

      totalFullPrice += exc.fullPriceCount;
      totalDiscounted += exc.discountedCount;
      totalFree += exc.freeCount;
      totalByTour += exc.byTourCount;
      totalPaid += exc.paidCount;

      let revenue = 0;
      if (tourType) {
        revenue = exc.fullPriceCount * tourType.fullPrice + exc.discountedCount * tourType.discountedPrice;
      }

      if (!tourTypeStats[typeName]) {
        tourTypeStats[typeName] = { count: 0, participants: 0, revenue: 0 };
      }
      tourTypeStats[typeName].count += 1;
      tourTypeStats[typeName].participants += participants;
      tourTypeStats[typeName].revenue += revenue;

      if (exc.additionalServices) {
        exc.additionalServices.forEach((as) => {
          const service = additionalServices.find((s) => s.id === as.serviceId);
          const serviceName = service?.name || "Неизвестная услуга";

          if (!serviceStats[serviceName]) {
            serviceStats[serviceName] = { count: 0, revenue: 0 };
          }
          serviceStats[serviceName].count += as.count;
          if (service) {
            serviceStats[serviceName].revenue += as.count * service.price;
          }
        });
      }
    });

    const tourTypeList = Object.entries(tourTypeStats)
      .map(([name, data]) => ({ name, ...data }))
      .sort((a, b) => b.count - a.count);

    const serviceList = Object.entries(serviceStats)
      .map(([name, data]) => ({ name, ...data }))
      .sort((a, b) => b.count - a.count);

    return {
      totalCount: filtered.length,
      totalParticipants,
      totalFullPrice,
      totalDiscounted,
      totalFree,
      totalByTour,
      totalPaid,
      tourTypeList,
      serviceList,
      avgParticipants: filtered.length > 0 ? Math.round(totalParticipants / filtered.length) : 0,
    };
  }, [excursions, tourTypes, additionalServices, period, customFrom, customTo]);

  const formatMoney = (amount: number) => {
    return amount.toLocaleString("ru-RU") + " ₽";
  };

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
            />
          )
        ) : null}

        <ThemedView
          style={[styles.summaryCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
        >
          <ThemedText style={styles.sectionTitle}>Общая статистика</ThemedText>

          <View style={styles.statsGrid}>
            <View style={[styles.statItem, { backgroundColor: theme.primary + "20" }]}>
              <Icon name="map" size={24} color={theme.primary} />
              <ThemedText style={styles.statValue}>{stats.totalCount}</ThemedText>
              <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                Экскурсий
              </ThemedText>
            </View>

            <View style={[styles.statItem, { backgroundColor: theme.success + "20" }]}>
              <Icon name="users" size={24} color={theme.success} />
              <ThemedText style={styles.statValue}>{stats.totalParticipants}</ThemedText>
              <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                Участников
              </ThemedText>
            </View>

            <View style={[styles.statItem, { backgroundColor: theme.warning + "20" }]}>
              <Icon name="user" size={24} color={theme.warning} />
              <ThemedText style={styles.statValue}>{stats.avgParticipants}</ThemedText>
              <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                Среднее
              </ThemedText>
            </View>
          </View>
        </ThemedView>

        <ThemedView
          style={[styles.detailCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
        >
          <ThemedText style={styles.sectionTitle}>Распределение участников</ThemedText>

          <View style={styles.participantRow}>
            <ThemedText style={styles.participantLabel}>Полная цена</ThemedText>
            <ThemedText style={styles.participantValue}>{stats.totalFullPrice}</ThemedText>
          </View>
          <View style={[styles.divider, { backgroundColor: theme.border }]} />

          <View style={styles.participantRow}>
            <ThemedText style={styles.participantLabel}>Льготные</ThemedText>
            <ThemedText style={styles.participantValue}>{stats.totalDiscounted}</ThemedText>
          </View>
          <View style={[styles.divider, { backgroundColor: theme.border }]} />

          <View style={styles.participantRow}>
            <ThemedText style={styles.participantLabel}>Бесплатно</ThemedText>
            <ThemedText style={styles.participantValue}>{stats.totalFree}</ThemedText>
          </View>
          <View style={[styles.divider, { backgroundColor: theme.border }]} />

          <View style={styles.participantRow}>
            <ThemedText style={styles.participantLabel}>По туру</ThemedText>
            <ThemedText style={styles.participantValue}>{stats.totalByTour}</ThemedText>
          </View>
          <View style={[styles.divider, { backgroundColor: theme.border }]} />

          <View style={styles.participantRow}>
            <ThemedText style={styles.participantLabel}>Оплатили</ThemedText>
            <ThemedText style={styles.participantValue}>{stats.totalPaid}</ThemedText>
          </View>
        </ThemedView>

        {stats.tourTypeList.length > 0 ? (
          <ThemedView
            style={[styles.detailCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
          >
            <ThemedText style={styles.sectionTitle}>Популярные экскурсии</ThemedText>

            {stats.tourTypeList.slice(0, 10).map((item, index) => (
              <View key={item.name}>
                {index > 0 ? <View style={[styles.divider, { backgroundColor: theme.border }]} /> : null}
                <View style={styles.tourTypeRow}>
                  <View style={styles.tourTypeInfo}>
                    <View style={styles.tourTypeHeader}>
                      <View
                        style={[
                          styles.rankBadge,
                          { backgroundColor: index < 3 ? theme.primary : theme.backgroundSecondary },
                        ]}
                      >
                        <ThemedText
                          style={[
                            styles.rankText,
                            { color: index < 3 ? theme.buttonText : theme.textSecondary },
                          ]}
                        >
                          {index + 1}
                        </ThemedText>
                      </View>
                      <ThemedText style={styles.tourTypeName} numberOfLines={2}>
                        {item.name}
                      </ThemedText>
                    </View>
                    <View style={styles.tourTypeStats}>
                      <ThemedText style={[styles.tourTypeStat, { color: theme.textSecondary }]}>
                        {item.count} экск.
                      </ThemedText>
                      <ThemedText style={[styles.tourTypeStat, { color: theme.textSecondary }]}>
                        {item.participants} чел.
                      </ThemedText>
                    </View>
                  </View>
                  <ThemedText style={[styles.tourTypeRevenue, { color: theme.success }]}>
                    {formatMoney(item.revenue)}
                  </ThemedText>
                </View>
              </View>
            ))}
          </ThemedView>
        ) : null}

        {stats.serviceList.length > 0 ? (
          <ThemedView
            style={[styles.detailCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
          >
            <ThemedText style={styles.sectionTitle}>Дополнительные услуги</ThemedText>

            {stats.serviceList.map((item, index) => (
              <View key={item.name}>
                {index > 0 ? <View style={[styles.divider, { backgroundColor: theme.border }]} /> : null}
                <View style={styles.serviceRow}>
                  <View style={styles.serviceInfo}>
                    <ThemedText style={styles.serviceName}>{item.name}</ThemedText>
                    <ThemedText style={[styles.serviceCount, { color: theme.textSecondary }]}>
                      {item.count} шт.
                    </ThemedText>
                  </View>
                  <ThemedText style={[styles.serviceRevenue, { color: theme.success }]}>
                    {formatMoney(item.revenue)}
                  </ThemedText>
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
  detailCard: {
    padding: Spacing.xl,
    borderWidth: 1,
    gap: Spacing.md,
  },
  participantRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  participantLabel: {
    fontSize: 16,
  },
  participantValue: {
    fontSize: 16,
    fontWeight: "600",
  },
  divider: {
    height: 1,
  },
  tourTypeRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingVertical: Spacing.sm,
  },
  tourTypeInfo: {
    flex: 1,
    gap: Spacing.xs,
    marginRight: Spacing.md,
  },
  tourTypeHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  rankBadge: {
    width: 24,
    height: 24,
    borderRadius: 12,
    alignItems: "center",
    justifyContent: "center",
  },
  rankText: {
    fontSize: 12,
    fontWeight: "600",
  },
  tourTypeName: {
    fontSize: 16,
    fontWeight: "500",
    flex: 1,
  },
  tourTypeStats: {
    flexDirection: "row",
    gap: Spacing.lg,
    marginLeft: 32,
  },
  tourTypeStat: {
    fontSize: 14,
  },
  tourTypeRevenue: {
    fontSize: 16,
    fontWeight: "600",
  },
  serviceRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingVertical: Spacing.sm,
  },
  serviceInfo: {
    flex: 1,
    gap: Spacing.xs,
  },
  serviceName: {
    fontSize: 16,
  },
  serviceCount: {
    fontSize: 14,
  },
  serviceRevenue: {
    fontSize: 16,
    fontWeight: "600",
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
