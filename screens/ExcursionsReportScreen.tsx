import { useState, useMemo } from "react";
import { View, StyleSheet, Pressable } from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";

type Period = "day" | "week" | "month" | "year" | "all";

const periodLabels: Record<Period, string> = {
  day: "День",
  week: "Неделя",
  month: "Месяц",
  year: "Год",
  all: "Всё время",
};

export default function ExcursionsReportScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const { excursions, tourTypes, additionalServices } = useData();
  const [period, setPeriod] = useState<Period>("month");

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
  }, [excursions, tourTypes, additionalServices, period]);

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
              onPress={() => setPeriod(p)}
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
                {periodLabels[p]}
              </ThemedText>
            </Pressable>
          ))}
        </View>

        <ThemedView
          style={[styles.summaryCard, { borderColor: theme.border, borderRadius: BorderRadius.sm }]}
        >
          <ThemedText style={styles.sectionTitle}>Общая статистика</ThemedText>

          <View style={styles.statsGrid}>
            <View style={[styles.statItem, { backgroundColor: theme.primary + "20" }]}>
              <Feather name="map" size={24} color={theme.primary} />
              <ThemedText style={styles.statValue}>{stats.totalCount}</ThemedText>
              <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                Экскурсий
              </ThemedText>
            </View>

            <View style={[styles.statItem, { backgroundColor: theme.success + "20" }]}>
              <Feather name="users" size={24} color={theme.success} />
              <ThemedText style={styles.statValue}>{stats.totalParticipants}</ThemedText>
              <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                Участников
              </ThemedText>
            </View>

            <View style={[styles.statItem, { backgroundColor: theme.warning + "20" }]}>
              <Feather name="user" size={24} color={theme.warning} />
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
});
