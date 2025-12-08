import { useState, useMemo } from "react";
import { View, StyleSheet, Pressable, TextInput, Modal, Platform, Alert, ScrollView } from "react-native";
import { Icon } from "@/components/Icon";
import DateTimePicker from "@react-native-community/datetimepicker";
import { KeyboardAwareScrollView } from "react-native-keyboard-controller";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { ExcursionCard } from "@/components/ExcursionCard";
import { AddExcursionForm } from "@/components/AddExcursionForm";
import { NetworkErrorBanner } from "@/components/NetworkErrorBanner";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, Excursion, RadioGuideKit } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";
import { hapticFeedback } from "@/utils/haptics";
import {
  calculateExcursionRevenue,
  calculateExcursionExpenses,
  calculateExcursionProfit,
} from "@/utils/calculations";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { ExcursionsStackParamList } from "@/navigation/ExcursionsStackNavigator";

const parseLocalDate = (dateString: string): Date => {
  const [year, month, day] = dateString.split('-').map(Number);
  return new Date(year, month - 1, day);
};

export default function ExcursionsListScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<ExcursionsStackParamList>>();
  const { excursions, tourTypes, additionalServices, addExcursion, radioGuideKits, issueRadioGuide, getExcursionNotes } = useData();
  const { isAdmin } = useAuth();
  const [selectedDate, setSelectedDate] = useState(new Date().toISOString().split("T")[0]);
  const [searchQuery, setSearchQuery] = useState("");
  const [showAddModal, setShowAddModal] = useState(false);
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [expandedGroups, setExpandedGroups] = useState<Set<string>>(new Set());
  const [isSaving, setIsSaving] = useState(false);
  
  const [showRadioGuideModal, setShowRadioGuideModal] = useState(false);
  const [selectedKit, setSelectedKit] = useState<RadioGuideKit | null>(null);
  const [guideName, setGuideName] = useState("");
  const [busNumber, setBusNumber] = useState("");
  const [receiversIssued, setReceiversIssued] = useState("");
  const [pendingExcursionId, setPendingExcursionId] = useState<string | null>(null);
  
  const availableKits = radioGuideKits.filter(kit => kit.status === 'available');
  
  const dateValue = parseLocalDate(selectedDate);
  
  const handleDateChange = (event: any, date?: Date) => {
    if (Platform.OS === "android") {
      setShowDatePicker(false);
    }
    if (date) {
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, "0");
      const day = String(date.getDate()).padStart(2, "0");
      setSelectedDate(`${year}-${month}-${day}`);
      setExpandedGroups(new Set());
    }
  };
  
  const formatDisplayDate = (dateStr: string) => {
    const d = parseLocalDate(dateStr);
    return d.toLocaleDateString("ru-RU", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
    });
  };

  const handleSaveExcursion = async (excursion: Omit<Excursion, 'id' | 'managerId' | 'managerName'>) => {
    if (isSaving) return;
    setIsSaving(true);
    try {
      await addExcursion(excursion);
      setSelectedDate(excursion.date);
      setShowAddModal(false);
      
      const tourType = tourTypes.find(t => t.id === excursion.tourTypeId);
      if (tourType?.hasRadioGuides && availableKits.length > 0) {
        setShowRadioGuideModal(true);
      }
    } catch (err) {
      Alert.alert('Ошибка', 'Не удалось сохранить экскурсию');
    } finally {
      setIsSaving(false);
    }
  };
  
  const resetRadioGuideForm = () => {
    setSelectedKit(null);
    setGuideName("");
    setBusNumber("");
    setReceiversIssued("");
    setPendingExcursionId(null);
  };
  
  const handleIssueRadioGuide = async () => {
    if (!selectedKit) {
      Alert.alert("Ошибка", "Выберите сумку");
      return;
    }
    if (!guideName.trim()) {
      Alert.alert("Ошибка", "Введите имя экскурсовода");
      return;
    }
    const count = parseInt(receiversIssued);
    if (!count || count <= 0) {
      Alert.alert("Ошибка", "Введите количество приёмников");
      return;
    }
    
    try {
      await issueRadioGuide({
        kitId: selectedKit.id,
        excursionId: pendingExcursionId || undefined,
        guideName: guideName.trim(),
        busNumber: busNumber.trim() || undefined,
        receiversIssued: count,
      });
      setShowRadioGuideModal(false);
      resetRadioGuideForm();
      Alert.alert("Успешно", "Радиогид выдан");
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось выдать радиогид");
    }
  };
  
  const handleSkipRadioGuide = () => {
    setShowRadioGuideModal(false);
    resetRadioGuideForm();
  };
  
  const renderRadioGuideFormContent = () => (
    <>
      <ThemedText style={[styles.radioGuideLabel, { color: theme.textSecondary }]}>
        Выберите сумку
      </ThemedText>
      <View style={styles.kitsList}>
        {availableKits.map(kit => (
          <Pressable
            key={kit.id}
            onPress={() => setSelectedKit(kit)}
            style={[
              styles.kitOption,
              {
                backgroundColor: selectedKit?.id === kit.id ? theme.primary + "20" : theme.backgroundSecondary,
                borderColor: selectedKit?.id === kit.id ? theme.primary : theme.border,
              },
            ]}
          >
            <Icon
              name={selectedKit?.id === kit.id ? "check-circle" : "circle"}
              size={20}
              color={selectedKit?.id === kit.id ? theme.primary : theme.textSecondary}
            />
            <ThemedText style={styles.kitOptionText}>Сумка #{kit.bagNumber}</ThemedText>
          </Pressable>
        ))}
        {availableKits.length === 0 ? (
          <ThemedText style={{ color: theme.textSecondary, textAlign: "center", padding: Spacing.lg }}>
            Нет доступных сумок
          </ThemedText>
        ) : null}
      </View>
      
      <View style={styles.radioGuideInputGroup}>
        <ThemedText style={[styles.radioGuideLabel, { color: theme.textSecondary }]}>
          Экскурсовод *
        </ThemedText>
        <TextInput
          style={[
            styles.radioGuideInput,
            { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
          ]}
          value={guideName}
          onChangeText={setGuideName}
          placeholder="Имя экскурсовода"
          placeholderTextColor={theme.textSecondary}
        />
      </View>
      
      <View style={styles.radioGuideInputGroup}>
        <ThemedText style={[styles.radioGuideLabel, { color: theme.textSecondary }]}>
          Номер автобуса (опционально)
        </ThemedText>
        <TextInput
          style={[
            styles.radioGuideInput,
            { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
          ]}
          value={busNumber}
          onChangeText={setBusNumber}
          placeholder="А123БВ"
          placeholderTextColor={theme.textSecondary}
        />
      </View>
      
      <View style={styles.radioGuideInputGroup}>
        <ThemedText style={[styles.radioGuideLabel, { color: theme.textSecondary }]}>
          Количество приёмников *
        </ThemedText>
        <TextInput
          style={[
            styles.radioGuideInput,
            { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
          ]}
          value={receiversIssued}
          onChangeText={setReceiversIssued}
          placeholder="40"
          placeholderTextColor={theme.textSecondary}
          keyboardType="number-pad"
        />
      </View>
    </>
  );
  
  const toggleGroup = (tourTypeId: string) => {
    setExpandedGroups((prev) => {
      const next = new Set(prev);
      if (next.has(tourTypeId)) {
        next.delete(tourTypeId);
      } else {
        next.add(tourTypeId);
      }
      return next;
    });
  };
  
  const filteredExcursions = useMemo(
    () => excursions.filter((exc) => exc.date === selectedDate),
    [excursions, selectedDate]
  );

  const searchedExcursions = searchQuery
    ? filteredExcursions.filter((exc) => {
        const tourType = tourTypes.find((t) => t.id === exc.tourTypeId);
        return tourType?.name.toLowerCase().includes(searchQuery.toLowerCase());
      })
    : filteredExcursions;

  const groupedByTourType = useMemo(() => {
    const groups: Record<string, Excursion[]> = {};
    searchedExcursions.forEach((exc) => {
      if (!groups[exc.tourTypeId]) {
        groups[exc.tourTypeId] = [];
      }
      groups[exc.tourTypeId].push(exc);
    });
    return groups;
  }, [searchedExcursions]);
  
  const getGroupStats = (excursionList: Excursion[]) => {
    let totalRevenue = 0;
    let totalExpenses = 0;
    let totalParticipants = 0;
    
    excursionList.forEach((exc) => {
      const tourType = tourTypes.find((t) => t.id === exc.tourTypeId);
      if (tourType) {
        totalRevenue += calculateExcursionRevenue(exc, tourType, additionalServices);
        totalExpenses += calculateExcursionExpenses(exc);
        totalParticipants += exc.fullPriceCount + exc.discountedCount + exc.freeCount + exc.byTourCount + exc.paidCount;
      }
    });
    
    return { totalRevenue, totalExpenses, totalProfit: totalRevenue - totalExpenses, totalParticipants };
  };

  return (
    <>
      <ScreenScrollView>
        <NetworkErrorBanner />
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
              <Icon name="search" size={20} color={theme.textSecondary} />
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
            <Pressable
              onPress={() => setShowDatePicker(true)}
              style={[
                styles.dateFilter,
                {
                  backgroundColor: theme.backgroundSecondary,
                  borderRadius: BorderRadius.xs,
                },
              ]}
            >
              <Icon name="calendar" size={20} color={theme.textSecondary} />
              <ThemedText style={[styles.dateInput, { color: theme.text }]}>
                {formatDisplayDate(selectedDate)}
              </ThemedText>
            </Pressable>
            {showDatePicker ? (
              Platform.OS === "ios" ? (
                <Modal
                  visible={showDatePicker}
                  transparent
                  animationType="fade"
                  onRequestClose={() => setShowDatePicker(false)}
                >
                  <View style={styles.modalOverlay}>
                    <Pressable style={styles.modalBackdrop} onPress={() => setShowDatePicker(false)} />
                    <ThemedView style={[styles.datePickerModal, { backgroundColor: theme.backgroundDefault }]}>
                      <View style={styles.datePickerHeader}>
                        <ThemedText style={styles.modalTitle}>Выберите дату</ThemedText>
                        <Pressable onPress={() => setShowDatePicker(false)}>
                          <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>Готово</ThemedText>
                        </Pressable>
                      </View>
                      <DateTimePicker
                        value={dateValue}
                        mode="date"
                        display="spinner"
                        onChange={handleDateChange}
                        locale="ru"
                      />
                    </ThemedView>
                  </View>
                </Modal>
              ) : (
                <DateTimePicker
                  value={dateValue}
                  mode="date"
                  display="default"
                  onChange={handleDateChange}
                />
              )
            ) : null}
          </View>

          {Object.keys(groupedByTourType).length > 0 ? (
            <View style={styles.section}>
              {Object.keys(groupedByTourType)
                .sort((a, b) => {
                  const tourTypeA = tourTypes.find((t) => t.id === a);
                  const tourTypeB = tourTypes.find((t) => t.id === b);
                  const articleA = tourTypeA?.articleNumber || '';
                  const articleB = tourTypeB?.articleNumber || '';
                  return articleA.localeCompare(articleB, 'ru', { numeric: true });
                })
                .map((tourTypeId) => {
                const tourType = tourTypes.find((t) => t.id === tourTypeId);
                if (!tourType) return null;
                
                const excursionList = groupedByTourType[tourTypeId];
                const isExpanded = expandedGroups.has(tourTypeId);
                const stats = getGroupStats(excursionList);
                const count = excursionList.length;
                
                return (
                  <View key={tourTypeId} style={styles.tourGroup}>
                    <Pressable
                      onPress={() => toggleGroup(tourTypeId)}
                      style={[
                        styles.groupHeader,
                        {
                          backgroundColor: theme.backgroundSecondary,
                          borderRadius: BorderRadius.sm,
                        },
                      ]}
                    >
                      <View style={styles.groupHeaderContent}>
                        <View style={styles.groupTitleRow}>
                          <ThemedText style={styles.groupTitle}>{tourType.name}</ThemedText>
                          <View style={[styles.countBadge, { backgroundColor: theme.primary }]}>
                            <ThemedText style={styles.countText}>{count}</ThemedText>
                          </View>
                        </View>
                        <View style={styles.groupStats}>
                          <ThemedText style={[styles.groupStatText, { color: theme.textSecondary }]}>
                            {stats.totalParticipants} чел.
                          </ThemedText>
                          {isAdmin ? (
                            <>
                              <ThemedText style={[styles.groupStatText, { color: theme.success }]}>
                                +{stats.totalRevenue.toLocaleString()} р.
                              </ThemedText>
                              <ThemedText style={[styles.groupStatText, { color: stats.totalProfit >= 0 ? theme.success : theme.error }]}>
                                = {stats.totalProfit.toLocaleString()} р.
                              </ThemedText>
                            </>
                          ) : null}
                        </View>
                      </View>
                      <Icon 
                        name={isExpanded ? "chevron-up" : "chevron-down"} 
                        size={24} 
                        color={theme.textSecondary} 
                      />
                    </Pressable>
                    
                    {isExpanded ? (
                      <View style={styles.excursionsList}>
                        {excursionList.map((excursion) => {
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

                          const notes = isAdmin ? getExcursionNotes(excursion.id) : [];
                          return (
                            <ExcursionCard
                              key={excursion.id}
                              excursion={excursion}
                              tourTypeName={tourType.name}
                              revenue={revenue}
                              expenses={expenses}
                              profit={profit}
                              showManagerName={isAdmin}
                              notesCount={isAdmin ? notes.length : 0}
                              onPress={() => {
                                navigation.navigate("ExcursionDetail", {
                                  excursionId: excursion.id,
                                });
                              }}
                            />
                          );
                        })}
                      </View>
                    ) : null}
                  </View>
                );
              })}
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
              <Icon name="calendar" size={48} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                {searchQuery ? "Экскурсии не найдены" : "Нет экскурсий за выбранный период"}
              </ThemedText>
            </ThemedView>
          )}
        </View>
      </ScreenScrollView>

      <View style={styles.fabContainer}>
        <Pressable
          style={({ pressed }) => [
            styles.fabSecondary,
            {
              backgroundColor: theme.backgroundSecondary,
              borderColor: theme.border,
              opacity: pressed ? 0.7 : 1,
            },
          ]}
          onPress={() => {
            hapticFeedback.light();
            navigation.navigate('RadioGuides' as never);
          }}
        >
          <Icon name="radio" size={20} color={theme.primary} />
        </Pressable>
        <Pressable
          style={({ pressed }) => [
            styles.fab,
            {
              backgroundColor: theme.primary,
              opacity: pressed ? 0.7 : 1,
            },
          ]}
          onPress={() => {
            hapticFeedback.medium();
            setShowAddModal(true);
          }}
        >
          <Icon name="plus" size={24} color={theme.buttonText} />
        </Pressable>
      </View>

      <Modal visible={showAddModal} animationType="slide" presentationStyle="pageSheet">
        <ThemedView style={[styles.modalContainer, { backgroundColor: theme.backgroundRoot }]}>
          <View style={[styles.modalHeader, { borderBottomColor: theme.border }]}>
            <ThemedText style={styles.modalTitle}>Новая экскурсия</ThemedText>
          </View>
          <AddExcursionForm
            onSave={handleSaveExcursion}
            onCancel={() => setShowAddModal(false)}
          />
        </ThemedView>
      </Modal>
      
      <Modal visible={showRadioGuideModal} animationType="slide" transparent>
        <View style={styles.radioGuideOverlay}>
          <Pressable style={styles.radioGuideBackdrop} onPress={handleSkipRadioGuide} />
          <ThemedView style={[styles.radioGuideModal, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.radioGuideHeader}>
              <ThemedText style={styles.radioGuideTitle}>Выдать радиогид</ThemedText>
              <Pressable onPress={handleSkipRadioGuide}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>
            
            {Platform.OS === "web" ? (
              <ScrollView style={styles.radioGuideContent} keyboardShouldPersistTaps="handled">
                {renderRadioGuideFormContent()}
              </ScrollView>
            ) : (
              <KeyboardAwareScrollView style={styles.radioGuideContent} keyboardShouldPersistTaps="handled">
                {renderRadioGuideFormContent()}
              </KeyboardAwareScrollView>
            )}
            
            <View style={styles.radioGuideActions}>
              <Pressable
                style={[styles.radioGuideSkipButton, { borderColor: theme.border }]}
                onPress={handleSkipRadioGuide}
              >
                <ThemedText>Пропустить</ThemedText>
              </Pressable>
              <Pressable
                style={[styles.radioGuideSubmitButton, { backgroundColor: theme.primary }]}
                onPress={handleIssueRadioGuide}
              >
                <ThemedText style={{ color: theme.buttonText, fontWeight: "600" }}>Выдать</ThemedText>
              </Pressable>
            </View>
          </ThemedView>
        </View>
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
  dateFilter: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.md,
    gap: Spacing.sm,
  },
  dateInput: {
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
  fabContainer: {
    position: "absolute",
    bottom: 16 + 49 + Spacing.xl,
    right: 16,
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  fabSecondary: {
    width: 44,
    height: 44,
    borderRadius: 22,
    alignItems: "center",
    justifyContent: "center",
    borderWidth: 1,
  },
  fab: {
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
    alignItems: "center",
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.md,
    borderBottomWidth: 1,
  },
  modalTitle: {
    fontSize: 17,
    fontWeight: "600",
  },
  modalOverlay: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  modalBackdrop: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "rgba(0,0,0,0.5)",
  },
  datePickerModal: {
    borderRadius: BorderRadius.md,
    padding: Spacing.lg,
    width: "90%",
    maxWidth: 360,
  },
  datePickerHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  tourGroup: {
    gap: Spacing.sm,
  },
  groupHeader: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.lg,
  },
  groupHeaderContent: {
    flex: 1,
    gap: Spacing.xs,
  },
  groupTitleRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  groupTitle: {
    fontSize: 16,
    fontWeight: "600",
  },
  countBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: 12,
    minWidth: 24,
    alignItems: "center",
  },
  countText: {
    fontSize: 12,
    fontWeight: "600",
    color: "#fff",
  },
  groupStats: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  groupStatText: {
    fontSize: 13,
  },
  radioGuideOverlay: {
    flex: 1,
    justifyContent: "flex-end",
  },
  radioGuideBackdrop: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "rgba(0,0,0,0.5)",
  },
  radioGuideModal: {
    borderTopLeftRadius: BorderRadius.lg,
    borderTopRightRadius: BorderRadius.lg,
    maxHeight: "80%",
  },
  radioGuideHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.lg,
    paddingBottom: Spacing.md,
  },
  radioGuideTitle: {
    fontSize: 20,
    fontWeight: "600",
  },
  radioGuideContent: {
    paddingHorizontal: Spacing.lg,
  },
  radioGuideLabel: {
    fontSize: 14,
    fontWeight: "500",
    marginBottom: Spacing.xs,
    marginTop: Spacing.md,
  },
  kitsList: {
    gap: Spacing.xs,
  },
  kitOption: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    gap: Spacing.sm,
  },
  kitOptionText: {
    fontSize: 15,
  },
  radioGuideInputGroup: {
    marginBottom: Spacing.sm,
  },
  radioGuideInput: {
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    padding: Spacing.md,
    fontSize: 16,
  },
  radioGuideActions: {
    flexDirection: "row",
    gap: Spacing.md,
    padding: Spacing.lg,
    paddingTop: Spacing.xl,
  },
  radioGuideSkipButton: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    borderWidth: 1,
  },
  radioGuideSubmitButton: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
});
