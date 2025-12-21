import { useState, useEffect, useMemo } from "react";
import { View, StyleSheet, Pressable, Modal, Platform, ActivityIndicator, Alert, TextInput } from "react-native";
import DateTimePicker from "@react-native-community/datetimepicker";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, DispatchStats, ExcursionWithManagers, DispatchSearchResult } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";
import { hapticFeedback } from "@/utils/haptics";

type Period = "day" | "week" | "month" | "year" | "all" | "custom";
type Tab = "managers" | "excursions" | "search";

const periodLabels: Record<Period, string> = {
  day: "День",
  week: "Неделя",
  month: "Месяц",
  year: "Год",
  all: "Все время",
  custom: "Период",
};

const tabLabels: Record<Tab, string> = {
  managers: "По менеджерам",
  excursions: "По экскурсиям",
  search: "Поиск",
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

function formatDate(dateStr: string) {
  const date = new Date(dateStr);
  return date.toLocaleDateString("ru-RU", { day: "numeric", month: "short", year: "numeric" });
}

export default function DispatchActivityReportScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const { getDispatchStats, getExcursionManagerBreakdown, searchDispatchByPhone, deleteOldDispatchEvents } = useData();
  
  const [activeTab, setActiveTab] = useState<Tab>("managers");
  const [period, setPeriod] = useState<Period>("month");
  const [customFrom, setCustomFrom] = useState<Date>(new Date());
  const [customTo, setCustomTo] = useState<Date>(new Date());
  const [showDatePicker, setShowDatePicker] = useState<"from" | "to" | null>(null);
  
  const [managerStats, setManagerStats] = useState<DispatchStats[]>([]);
  const [excursionData, setExcursionData] = useState<ExcursionWithManagers[]>([]);
  const [expandedExcursions, setExpandedExcursions] = useState<Set<string>>(new Set());
  const [searchResults, setSearchResults] = useState<DispatchSearchResult[]>([]);
  const [searchQuery, setSearchQuery] = useState("");
  
  const [isLoading, setIsLoading] = useState(true);
  const [isSearching, setIsSearching] = useState(false);
  const [isDeleting, setIsDeleting] = useState(false);

  const formatShortDate = (date: Date) => {
    return date.toLocaleDateString("ru-RU", { day: "numeric", month: "short" });
  };

  useEffect(() => {
    if (activeTab !== "search") {
      loadStats();
    }
  }, [period, customFrom, customTo, activeTab]);

  const loadStats = async () => {
    setIsLoading(true);
    try {
      const { startDate, endDate } = getDateRangeForPeriod(period, customFrom, customTo);
      
      if (activeTab === "managers") {
        const data = await getDispatchStats(startDate, endDate);
        setManagerStats(data);
      } else if (activeTab === "excursions") {
        const data = await getExcursionManagerBreakdown(startDate, endDate);
        setExcursionData(data);
      }
    } catch (error) {
      console.error("Failed to load dispatch stats:", error);
      Alert.alert("Ошибка", "Не удалось загрузить статистику");
    } finally {
      setIsLoading(false);
    }
  };

  const handleSearch = async () => {
    if (!searchQuery.trim()) return;
    
    setIsSearching(true);
    try {
      const results = await searchDispatchByPhone(searchQuery.trim());
      setSearchResults(results);
      hapticFeedback.light();
    } catch (error) {
      console.error("Search failed:", error);
      Alert.alert("Ошибка", "Не удалось выполнить поиск");
    } finally {
      setIsSearching(false);
    }
  };

  const toggleExcursion = (key: string) => {
    setExpandedExcursions(prev => {
      const next = new Set(prev);
      if (next.has(key)) {
        next.delete(key);
      } else {
        next.add(key);
      }
      return next;
    });
    hapticFeedback.light();
  };

  const managerTotals = useMemo(() => {
    return managerStats.reduce(
      (acc, s) => ({
        phones: acc.phones + (s.netPhones || 0),
        pax: acc.pax + (s.netPax || 0),
      }),
      { phones: 0, pax: 0 }
    );
  }, [managerStats]);

  const excursionTotals = useMemo(() => {
    return excursionData.reduce(
      (acc, s) => ({
        phones: acc.phones + (s.totalPhones || 0),
        pax: acc.pax + (s.totalPax || 0),
      }),
      { phones: 0, pax: 0 }
    );
  }, [excursionData]);

  const handleDeleteOldData = () => {
    Alert.alert(
      "Очистка данных",
      "Удалить данные статистики старше 1 года? Это действие нельзя отменить.",
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Удалить",
          style: "destructive",
          onPress: async () => {
            setIsDeleting(true);
            try {
              const oneYearAgo = new Date();
              oneYearAgo.setFullYear(oneYearAgo.getFullYear() - 1);
              const beforeDate = oneYearAgo.toISOString();
              
              const deletedCount = await deleteOldDispatchEvents(beforeDate);
              hapticFeedback.success();
              Alert.alert("Готово", `Удалено ${deletedCount} записей`);
              loadStats();
            } catch (error) {
              hapticFeedback.error();
              Alert.alert("Ошибка", "Не удалось удалить данные");
            } finally {
              setIsDeleting(false);
            }
          },
        },
      ]
    );
  };

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
        <View style={styles.tabContainer}>
          {(Object.keys(tabLabels) as Tab[]).map((tab) => (
            <Pressable
              key={tab}
              style={[
                styles.tab,
                {
                  backgroundColor: activeTab === tab ? theme.primary : theme.backgroundSecondary,
                },
              ]}
              onPress={() => {
                setActiveTab(tab);
                hapticFeedback.light();
              }}
            >
              <ThemedText
                style={[
                  styles.tabText,
                  { color: activeTab === tab ? theme.buttonText : theme.text },
                ]}
              >
                {tabLabels[tab]}
              </ThemedText>
            </Pressable>
          ))}
        </View>

        {activeTab !== "search" ? (
          <>
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
          </>
        ) : (
          <View style={styles.searchContainer}>
            <View style={[styles.searchInputContainer, { backgroundColor: theme.backgroundSecondary }]}>
              <Icon name="search" size={20} color={theme.textSecondary} />
              <TextInput
                style={[styles.searchInput, { color: theme.text }]}
                placeholder="Введите номер телефона..."
                placeholderTextColor={theme.textSecondary}
                value={searchQuery}
                onChangeText={setSearchQuery}
                onSubmitEditing={handleSearch}
                keyboardType="phone-pad"
                returnKeyType="search"
              />
              {searchQuery ? (
                <Pressable onPress={() => { setSearchQuery(""); setSearchResults([]); }}>
                  <Icon name="x" size={20} color={theme.textSecondary} />
                </Pressable>
              ) : null}
            </View>
            <Pressable
              style={[styles.searchButton, { backgroundColor: theme.primary }]}
              onPress={handleSearch}
              disabled={isSearching || !searchQuery.trim()}
            >
              {isSearching ? (
                <ActivityIndicator size="small" color={theme.buttonText} />
              ) : (
                <ThemedText style={{ color: theme.buttonText, fontWeight: "600" }}>Найти</ThemedText>
              )}
            </Pressable>
          </View>
        )}

        {isLoading && activeTab !== "search" ? (
          <View style={styles.loadingContainer}>
            <ActivityIndicator size="large" color={theme.primary} />
          </View>
        ) : activeTab === "managers" ? (
          <>
            <View style={[styles.totalCard, { backgroundColor: theme.backgroundSecondary }]}>
              <ThemedText style={styles.totalTitle}>Итого за период</ThemedText>
              <View style={styles.totalRow}>
                <View style={styles.totalItem}>
                  <ThemedText style={[styles.totalValue, { color: theme.primary }]}>
                    {managerTotals.phones}
                  </ThemedText>
                  <ThemedText style={[styles.totalLabel, { color: theme.textSecondary }]}>
                    номеров
                  </ThemedText>
                </View>
                <View style={styles.totalItem}>
                  <ThemedText style={[styles.totalValue, { color: theme.success }]}>
                    {managerTotals.pax}
                  </ThemedText>
                  <ThemedText style={[styles.totalLabel, { color: theme.textSecondary }]}>
                    человек
                  </ThemedText>
                </View>
              </View>
            </View>

            <ThemedText style={styles.sectionTitle}>По менеджерам</ThemedText>

            {managerStats.length === 0 ? (
              <View style={[styles.emptyState, { backgroundColor: theme.backgroundSecondary }]}>
                <Icon name="users" size={48} color={theme.textSecondary} />
                <ThemedText style={{ color: theme.textSecondary, marginTop: Spacing.md }}>
                  Нет данных за выбранный период
                </ThemedText>
              </View>
            ) : (
              <View style={styles.list}>
                {managerStats.map((stat, index) => (
                  <View
                    key={stat.managerId}
                    style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}
                  >
                    <View style={styles.cardHeader}>
                      <View style={[styles.rankBadge, { backgroundColor: theme.primary + "20" }]}>
                        <ThemedText style={[styles.rankText, { color: theme.primary }]}>
                          #{index + 1}
                        </ThemedText>
                      </View>
                      <ThemedText style={styles.cardTitle} numberOfLines={1}>
                        {stat.managerName || "Неизвестный"}
                      </ThemedText>
                    </View>
                    <View style={styles.statsRow}>
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
        ) : activeTab === "excursions" ? (
          <>
            <View style={[styles.totalCard, { backgroundColor: theme.backgroundSecondary }]}>
              <ThemedText style={styles.totalTitle}>Итого за период</ThemedText>
              <View style={styles.totalRow}>
                <View style={styles.totalItem}>
                  <ThemedText style={[styles.totalValue, { color: theme.primary }]}>
                    {excursionTotals.phones}
                  </ThemedText>
                  <ThemedText style={[styles.totalLabel, { color: theme.textSecondary }]}>
                    номеров
                  </ThemedText>
                </View>
                <View style={styles.totalItem}>
                  <ThemedText style={[styles.totalValue, { color: theme.success }]}>
                    {excursionTotals.pax}
                  </ThemedText>
                  <ThemedText style={[styles.totalLabel, { color: theme.textSecondary }]}>
                    человек
                  </ThemedText>
                </View>
                <View style={styles.totalItem}>
                  <ThemedText style={[styles.totalValue, { color: theme.warning }]}>
                    {excursionData.length}
                  </ThemedText>
                  <ThemedText style={[styles.totalLabel, { color: theme.textSecondary }]}>
                    экскурсий
                  </ThemedText>
                </View>
              </View>
            </View>

            <ThemedText style={styles.sectionTitle}>По экскурсиям</ThemedText>

            {excursionData.length === 0 ? (
              <View style={[styles.emptyState, { backgroundColor: theme.backgroundSecondary }]}>
                <Icon name="map" size={48} color={theme.textSecondary} />
                <ThemedText style={{ color: theme.textSecondary, marginTop: Spacing.md }}>
                  Нет данных за выбранный период
                </ThemedText>
              </View>
            ) : (
              <View style={styles.list}>
                {excursionData.map((excursion) => {
                  const key = `${excursion.excursionDate}-${excursion.excursionName}`;
                  const isExpanded = expandedExcursions.has(key);
                  
                  return (
                    <View
                      key={key}
                      style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}
                    >
                      <Pressable onPress={() => toggleExcursion(key)}>
                        <View style={styles.excursionHeader}>
                          <View style={styles.excursionInfo}>
                            <View style={[styles.dateBadge, { backgroundColor: theme.primary + "20" }]}>
                              <ThemedText style={[styles.dateText, { color: theme.primary }]}>
                                {formatDate(excursion.excursionDate)}
                              </ThemedText>
                            </View>
                            <ThemedText style={styles.cardTitle} numberOfLines={2}>
                              {excursion.excursionName || "Без названия"}
                            </ThemedText>
                          </View>
                          <Icon 
                            name={isExpanded ? "chevron-up" : "chevron-down"} 
                            size={20} 
                            color={theme.textSecondary} 
                          />
                        </View>
                        <View style={styles.statsRow}>
                          <View style={styles.statItem}>
                            <ThemedText style={[styles.statValue, { color: theme.primary }]}>
                              {excursion.totalPhones || 0}
                            </ThemedText>
                            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                              номеров
                            </ThemedText>
                          </View>
                          <View style={styles.statItem}>
                            <ThemedText style={[styles.statValue, { color: theme.success }]}>
                              {excursion.totalPax || 0}
                            </ThemedText>
                            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                              человек
                            </ThemedText>
                          </View>
                          <View style={styles.statItem}>
                            <ThemedText style={[styles.statValue, { color: theme.textSecondary }]}>
                              {excursion.managers.length}
                            </ThemedText>
                            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
                              менеджеров
                            </ThemedText>
                          </View>
                        </View>
                      </Pressable>
                      
                      {isExpanded ? (
                        <View style={[styles.managersBreakdown, { borderTopColor: theme.border }]}>
                          {excursion.managers.map((manager, idx) => (
                            <View key={manager.managerId} style={styles.managerRow}>
                              <View style={styles.managerRank}>
                                <ThemedText style={[styles.managerRankText, { color: theme.textSecondary }]}>
                                  {idx + 1}.
                                </ThemedText>
                              </View>
                              <ThemedText style={styles.managerRowName} numberOfLines={1}>
                                {manager.managerName}
                              </ThemedText>
                              <View style={styles.managerRowStats}>
                                <ThemedText style={[styles.managerRowValue, { color: theme.primary }]}>
                                  {manager.netPhones}
                                </ThemedText>
                                <ThemedText style={[styles.managerRowLabel, { color: theme.textSecondary }]}>
                                  ном.
                                </ThemedText>
                                <ThemedText style={[styles.managerRowValue, { color: theme.success }]}>
                                  {manager.netPax}
                                </ThemedText>
                                <ThemedText style={[styles.managerRowLabel, { color: theme.textSecondary }]}>
                                  чел.
                                </ThemedText>
                              </View>
                            </View>
                          ))}
                        </View>
                      ) : null}
                    </View>
                  );
                })}
              </View>
            )}
          </>
        ) : (
          <>
            {searchResults.length === 0 && searchQuery ? (
              <View style={[styles.emptyState, { backgroundColor: theme.backgroundSecondary }]}>
                <Icon name="search" size={48} color={theme.textSecondary} />
                <ThemedText style={{ color: theme.textSecondary, marginTop: Spacing.md }}>
                  Ничего не найдено
                </ThemedText>
              </View>
            ) : searchResults.length === 0 ? (
              <View style={[styles.emptyState, { backgroundColor: theme.backgroundSecondary }]}>
                <Icon name="phone" size={48} color={theme.textSecondary} />
                <ThemedText style={{ color: theme.textSecondary, marginTop: Spacing.md, textAlign: "center" }}>
                  Введите номер телефона{"\n"}для поиска кто обилетил туриста
                </ThemedText>
              </View>
            ) : (
              <>
                <ThemedText style={styles.sectionTitle}>
                  Найдено: {searchResults.length}
                </ThemedText>
                <View style={styles.list}>
                  {searchResults.map((result) => (
                    <View
                      key={result.id}
                      style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}
                    >
                      <View style={styles.cardHeader}>
                        <View style={[styles.dateBadge, { backgroundColor: result.action === 'mark' ? theme.success + "20" : theme.error + "20" }]}>
                          <ThemedText style={[styles.dateText, { color: result.action === 'mark' ? theme.success : theme.error }]}>
                            {result.action === 'mark' ? 'Отмечен' : 'Снят'}
                          </ThemedText>
                        </View>
                        <ThemedText style={[styles.phoneText, { color: theme.primary }]}>
                          {result.phone}
                        </ThemedText>
                      </View>
                      <ThemedText style={styles.cardSubtitle}>
                        {result.excursionName || "Без названия"} - {formatDate(result.excursionDate)}
                      </ThemedText>
                      <View style={styles.actionTimeRow}>
                        <Icon name="clock" size={14} color={theme.textSecondary} />
                        <ThemedText style={[styles.actionTimeText, { color: theme.textSecondary }]}>
                          Действие: {new Date(result.createdAt).toLocaleString("ru-RU", { day: "numeric", month: "short", year: "numeric", hour: "2-digit", minute: "2-digit" })}
                        </ThemedText>
                      </View>
                      <View style={styles.searchResultFooter}>
                        <View style={styles.managerInfo}>
                          <Icon name="user" size={14} color={theme.textSecondary} />
                          <ThemedText style={[styles.managerText, { color: theme.textSecondary }]}>
                            {result.managerName}
                          </ThemedText>
                        </View>
                        <ThemedText style={[styles.paxText, { color: theme.success }]}>
                          {result.paxCount} чел.
                        </ThemedText>
                      </View>
                    </View>
                  ))}
                </View>
              </>
            )}
          </>
        )}

        {activeTab !== "search" ? (
          <Pressable
            style={[styles.deleteButton, { backgroundColor: theme.error + "20" }]}
            onPress={handleDeleteOldData}
            disabled={isDeleting}
          >
            {isDeleting ? (
              <ActivityIndicator size="small" color={theme.error} />
            ) : (
              <>
                <Icon name="trash-2" size={18} color={theme.error} />
                <ThemedText style={[styles.deleteButtonText, { color: theme.error }]}>
                  Очистить данные старше года
                </ThemedText>
              </>
            )}
          </Pressable>
        ) : null}
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
  tabContainer: {
    flexDirection: "row",
    gap: Spacing.xs,
  },
  tab: {
    flex: 1,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
  tabText: {
    fontSize: 13,
    fontWeight: "600",
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
  searchContainer: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  searchInputContainer: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.sm,
    gap: Spacing.sm,
  },
  searchInput: {
    flex: 1,
    paddingVertical: Spacing.md,
    fontSize: 16,
  },
  searchButton: {
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.sm,
    justifyContent: "center",
  },
  loadingContainer: {
    padding: Spacing["2xl"],
    alignItems: "center",
  },
  totalCard: {
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.xl,
    borderRadius: BorderRadius.md,
    gap: Spacing.md,
  },
  totalTitle: {
    fontSize: 16,
    fontWeight: "600",
    textAlign: "center",
  },
  totalRow: {
    flexDirection: "row",
    justifyContent: "space-around",
    paddingTop: Spacing.sm,
  },
  totalItem: {
    alignItems: "center",
    gap: Spacing.xs,
  },
  totalValue: {
    fontSize: 28,
    fontWeight: "700",
    lineHeight: 34,
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
  list: {
    gap: Spacing.md,
  },
  card: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
  },
  cardHeader: {
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
  dateBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 4,
    borderRadius: BorderRadius.xs,
  },
  dateText: {
    fontSize: 12,
    fontWeight: "600",
  },
  cardTitle: {
    fontSize: 15,
    fontWeight: "600",
    flex: 1,
  },
  cardSubtitle: {
    fontSize: 14,
  },
  excursionHeader: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    gap: Spacing.sm,
  },
  excursionInfo: {
    flex: 1,
    gap: Spacing.xs,
  },
  statsRow: {
    flexDirection: "row",
    justifyContent: "space-around",
    paddingTop: Spacing.xs,
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
  managersBreakdown: {
    marginTop: Spacing.md,
    paddingTop: Spacing.md,
    borderTopWidth: 1,
    gap: Spacing.sm,
  },
  managerRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  managerRank: {
    width: 24,
  },
  managerRankText: {
    fontSize: 13,
    fontWeight: "500",
  },
  managerRowName: {
    flex: 1,
    fontSize: 14,
  },
  managerRowStats: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
  },
  managerRowValue: {
    fontSize: 14,
    fontWeight: "600",
  },
  managerRowLabel: {
    fontSize: 12,
    marginRight: Spacing.sm,
  },
  phoneText: {
    fontSize: 15,
    fontWeight: "600",
  },
  actionTimeRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    marginTop: Spacing.xs,
  },
  actionTimeText: {
    fontSize: 12,
  },
  searchResultFooter: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingTop: Spacing.xs,
  },
  managerInfo: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
  },
  managerText: {
    fontSize: 13,
  },
  paxText: {
    fontSize: 14,
    fontWeight: "600",
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
  deleteButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginTop: Spacing.lg,
  },
  deleteButtonText: {
    fontSize: 14,
    fontWeight: "600",
  },
});
