import { useState } from "react";
import { View, StyleSheet, Pressable, TextInput, Modal } from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { ExcursionCard } from "@/components/ExcursionCard";
import { PeriodSelector } from "@/components/PeriodSelector";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";
import {
  getDateRangeForPeriod,
  filterExcursionsByDateRange,
  calculateExcursionRevenue,
  calculateExcursionExpenses,
  calculateExcursionProfit,
} from "@/utils/calculations";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { ExcursionsStackParamList } from "@/navigation/ExcursionsStackNavigator";

export default function ExcursionsListScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<ExcursionsStackParamList>>();
  const { excursions, tourTypes, additionalServices } = useData();
  const [selectedPeriod, setSelectedPeriod] = useState<"day" | "week" | "month">("day");
  const [referenceDate] = useState(new Date());
  const [searchQuery, setSearchQuery] = useState("");
  const [showAddModal, setShowAddModal] = useState(false);

  const { startDate, endDate } = getDateRangeForPeriod(selectedPeriod, referenceDate);
  const filteredExcursions = filterExcursionsByDateRange(excursions, startDate, endDate);

  const searchedExcursions = searchQuery
    ? filteredExcursions.filter((exc) => {
        const tourType = tourTypes.find((t) => t.id === exc.tourTypeId);
        return tourType?.name.toLowerCase().includes(searchQuery.toLowerCase());
      })
    : filteredExcursions;

  const groupedByDate = searchedExcursions.reduce((groups, exc) => {
    const date = exc.date;
    if (!groups[date]) {
      groups[date] = [];
    }
    groups[date].push(exc);
    return groups;
  }, {} as Record<string, typeof searchedExcursions>);

  return (
    <>
      <ScreenScrollView>
        <View style={styles.container}>
          <View style={styles.section}>
            <ThemedView
              style={[
                styles.searchBar,
                {
                  backgroundColor: theme.backgroundSecondary,
                  borderRadius: BorderRadius.xs,
                },
              ]}
            >
              <Feather name="search" size={20} color={theme.textSecondary} />
              <TextInput
                style={[
                  styles.searchInput,
                  {
                    color: theme.text,
                  },
                ]}
                placeholder="Поиск по названию..."
                placeholderTextColor={theme.textSecondary}
                value={searchQuery}
                onChangeText={setSearchQuery}
              />
            </ThemedView>
          </View>

          <View style={styles.section}>
            <PeriodSelector selectedPeriod={selectedPeriod} onPeriodChange={setSelectedPeriod} />
          </View>

          {Object.keys(groupedByDate).length > 0 ? (
            <View style={styles.section}>
              {Object.keys(groupedByDate)
                .sort()
                .reverse()
                .map((date) => (
                  <View key={date} style={styles.dateGroup}>
                    <ThemedView
                      style={[
                        styles.dateHeader,
                        {
                          backgroundColor: theme.backgroundSecondary,
                          borderRadius: BorderRadius.xs,
                        },
                      ]}
                    >
                      <ThemedText style={styles.dateText}>
                        {new Date(date).toLocaleDateString("ru-RU", {
                          weekday: "long",
                          year: "numeric",
                          month: "long",
                          day: "numeric",
                        })}
                      </ThemedText>
                    </ThemedView>
                    <View style={styles.excursionsList}>
                      {groupedByDate[date].map((excursion) => {
                        const tourType = tourTypes.find((t) => t.id === excursion.tourTypeId);
                        if (!tourType) return null;
                        const revenue = calculateExcursionRevenue(
                          excursion,
                          tourType,
                          additionalServices
                        );
                        const expenses = calculateExcursionExpenses(excursion);
                        const profit = calculateExcursionProfit(
                          excursion,
                          tourType,
                          additionalServices
                        );

                        return (
                          <ExcursionCard
                            key={excursion.id}
                            excursion={excursion}
                            tourTypeName={tourType.name}
                            revenue={revenue}
                            expenses={expenses}
                            profit={profit}
                            onPress={() => {
                              navigation.navigate("ExcursionDetail", {
                                excursionId: excursion.id,
                              });
                            }}
                          />
                        );
                      })}
                    </View>
                  </View>
                ))}
            </View>
          ) : (
            <ThemedView
              style={[
                styles.emptyState,
                {
                  borderColor: theme.border,
                  backgroundColor: theme.backgroundSecondary,
                  borderRadius: BorderRadius.sm,
                },
              ]}
            >
              <Feather name="calendar" size={48} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                {searchQuery ? "Экскурсии не найдены" : "Нет экскурсий за выбранный период"}
              </ThemedText>
            </ThemedView>
          )}
        </View>
      </ScreenScrollView>

      <Pressable
        style={({ pressed }) => [
          styles.fab,
          {
            backgroundColor: theme.primary,
            opacity: pressed ? 0.7 : 1,
          },
        ]}
        onPress={() => setShowAddModal(true)}
      >
        <Feather name="plus" size={24} color={theme.buttonText} />
      </Pressable>

      <Modal visible={showAddModal} animationType="slide" presentationStyle="pageSheet">
        <ThemedView style={[styles.modalContainer, { backgroundColor: theme.backgroundRoot }]}>
          <View style={[styles.modalHeader, { borderBottomColor: theme.border }]}>
            <Pressable onPress={() => setShowAddModal(false)} style={styles.modalButton}>
              <ThemedText style={{ color: theme.primary }}>Отмена</ThemedText>
            </Pressable>
            <ThemedText style={styles.modalTitle}>Новая экскурсия</ThemedText>
            <Pressable onPress={() => setShowAddModal(false)} style={styles.modalButton}>
              <ThemedText style={{ color: theme.primary }}>Сохранить</ThemedText>
            </Pressable>
          </View>
          <ScreenScrollView>
            <View style={styles.modalContent}>
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                Форма добавления экскурсии будет здесь
              </ThemedText>
            </View>
          </ScreenScrollView>
        </ThemedView>
      </Modal>
    </>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing["2xl"],
  },
  section: {
    gap: Spacing.md,
  },
  searchBar: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.md,
    gap: Spacing.sm,
  },
  searchInput: {
    flex: 1,
    fontSize: 16,
  },
  dateGroup: {
    gap: Spacing.md,
  },
  dateHeader: {
    padding: Spacing.md,
  },
  dateText: {
    fontSize: 16,
    fontWeight: "600",
    textTransform: "capitalize",
  },
  excursionsList: {
    gap: Spacing.md,
  },
  emptyState: {
    padding: Spacing["3xl"],
    alignItems: "center",
    gap: Spacing.lg,
    borderWidth: 1,
  },
  emptyText: {
    fontSize: 16,
    textAlign: "center",
  },
  fab: {
    position: "absolute",
    bottom: 16 + 49 + Spacing.xl,
    right: 16,
    width: 56,
    height: 56,
    borderRadius: 28,
    alignItems: "center",
    justifyContent: "center",
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 2,
    elevation: 4,
  },
  modalContainer: {
    flex: 1,
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.md,
    borderBottomWidth: 1,
  },
  modalButton: {
    minWidth: 70,
  },
  modalTitle: {
    fontSize: 17,
    fontWeight: "600",
  },
  modalContent: {
    padding: Spacing.lg,
  },
});
