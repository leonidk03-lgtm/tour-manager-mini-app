import { View, StyleSheet, Pressable, Alert, Modal, TextInput, FlatList } from "react-native";
import { Icon } from "@/components/Icon";
import { useRoute, useNavigation } from "@react-navigation/native";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { AddExcursionForm } from "@/components/AddExcursionForm";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, Excursion as ExcursionType, ExcursionNote, DispatchingNote } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";
import {
  calculateExcursionRevenue,
  calculateExcursionExpenses,
  calculateExcursionProfit,
  formatCurrency,
} from "@/utils/calculations";
import { useLayoutEffect, useState, useMemo } from "react";
import { hapticFeedback } from "@/utils/haptics";

const parseLocalDate = (dateString: string): Date => {
  const [year, month, day] = dateString.split('-').map(Number);
  return new Date(year, month - 1, day);
};

export default function ExcursionDetailScreen() {
  const { theme } = useTheme();
  const route = useRoute();
  const navigation = useNavigation();
  const { excursionId } = route.params as { excursionId: string };
  const { excursions, tourTypes, additionalServices, deleteExcursion, updateExcursion, getExcursionNotes, addExcursionNote, deleteExcursionNote, dispatchingNotes } = useData();
  const { isAdmin, profile } = useAuth();
  const [showEditModal, setShowEditModal] = useState(false);
  const [editKey, setEditKey] = useState(0);
  const [isDeleting, setIsDeleting] = useState(false);
  const [noteText, setNoteText] = useState("");
  const [isAddingNote, setIsAddingNote] = useState(false);
  const [showNoteInput, setShowNoteInput] = useState(false);
  const [showNotesPicker, setShowNotesPicker] = useState(false);
  const [expandedNoteId, setExpandedNoteId] = useState<string | null>(null);
  const [fullscreenNote, setFullscreenNote] = useState<ExcursionNote | null>(null);

  const excursion = excursions.find((e) => e.id === excursionId);
  const tourType = tourTypes.find((t) => t.id === excursion?.tourTypeId);
  const excursionNotesData = useMemo(() => getExcursionNotes(excursionId), [excursionId, getExcursionNotes]);

  const isExcursionToday = useMemo(() => {
    if (!excursion) return false;
    const today = new Date();
    const excursionDate = parseLocalDate(excursion.date);
    return (
      today.getFullYear() === excursionDate.getFullYear() &&
      today.getMonth() === excursionDate.getMonth() &&
      today.getDate() === excursionDate.getDate()
    );
  }, [excursion]);

  // Admins can always add notes, managers can add only on excursion day for their own excursions
  const canAddNote = isAdmin || (isExcursionToday && profile?.id === excursion?.managerId);

  const visibleNotes = useMemo(() => {
    if (isAdmin) return excursionNotesData;
    if (!isExcursionToday) return [];
    // Managers see ALL notes for this excursion on excursion day
    return excursionNotesData;
  }, [isAdmin, isExcursionToday, excursionNotesData]);

  const handleAddNote = async () => {
    if (!noteText.trim() || isAddingNote) return;
    setIsAddingNote(true);
    try {
      await addExcursionNote(excursionId, noteText.trim());
      hapticFeedback.success();
      setNoteText("");
      setShowNoteInput(false);
    } catch (err) {
      hapticFeedback.error();
      Alert.alert("Ошибка", "Не удалось добавить заметку");
    } finally {
      setIsAddingNote(false);
    }
  };

  const handleDeleteNote = (noteId: string) => {
    Alert.alert("Удалить заметку?", "Заметка будет перемещена в корзину", [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: async () => {
          try {
            await deleteExcursionNote(noteId);
            hapticFeedback.success();
          } catch (err) {
            hapticFeedback.error();
            Alert.alert("Ошибка", "Не удалось удалить заметку");
          }
        },
      },
    ]);
  };

  const handleSelectDispatchingNote = async (note: DispatchingNote) => {
    setShowNotesPicker(false);
    setIsAddingNote(true);
    try {
      await addExcursionNote(excursionId, note.text);
      hapticFeedback.success();
    } catch (err) {
      hapticFeedback.error();
      Alert.alert("Ошибка", "Не удалось добавить заметку");
    } finally {
      setIsAddingNote(false);
    }
  };

  const toggleNoteExpand = (noteId: string) => {
    setExpandedNoteId(expandedNoteId === noteId ? null : noteId);
  };

  useLayoutEffect(() => {
    navigation.setOptions({
      headerRight: () => (
        <View style={{ flexDirection: "row", gap: Spacing.xl }}>
          <Pressable onPress={handleEdit} style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1, padding: 4 })}>
            <Icon name="edit" size={22} color={theme.primary} />
          </Pressable>
          <Pressable onPress={handleDelete} style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1, padding: 4 })}>
            <Icon name="trash-2" size={22} color={theme.error} />
          </Pressable>
        </View>
      ),
    });
  }, [navigation]);

  const handleEdit = () => {
    setEditKey((prev) => prev + 1);
    setShowEditModal(true);
  };

  const handleSaveEdit = async (updatedExcursion: Partial<ExcursionType>) => {
    try {
      await updateExcursion(excursionId, updatedExcursion);
      setShowEditModal(false);
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось сохранить изменения");
    }
  };

  const handleDelete = () => {
    Alert.alert("Удалить экскурсию?", "Это действие нельзя будет отменить", [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: async () => {
          if (isDeleting) return;
          setIsDeleting(true);
          try {
            await deleteExcursion(excursionId);
            navigation.goBack();
          } catch (err) {
            Alert.alert("Ошибка", "Не удалось удалить экскурсию");
            setIsDeleting(false);
          }
        },
      },
    ]);
  };

  if (!excursion || !tourType) {
    return (
      <View style={styles.container}>
        <ThemedText>Экскурсия не найдена</ThemedText>
      </View>
    );
  }

  const revenue = calculateExcursionRevenue(excursion, tourType, additionalServices);
  const expenses = calculateExcursionExpenses(excursion);
  const profit = calculateExcursionProfit(excursion, tourType, additionalServices);
  const totalParticipants =
    excursion.fullPriceCount + excursion.discountedCount + excursion.freeCount + 
    excursion.byTourCount + excursion.paidCount;

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <ThemedView
          style={[
            styles.card,
            {
              borderColor: theme.border,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <ThemedText style={styles.tourName}>{tourType.name}</ThemedText>
          <View style={styles.info}>
            <View style={styles.infoRow}>
              <Icon name="calendar" size={16} color={theme.textSecondary} />
              <ThemedText style={[styles.infoText, { color: theme.textSecondary }]}>
                {parseLocalDate(excursion.date).toLocaleDateString("ru-RU", {
                  weekday: "long",
                  year: "numeric",
                  month: "long",
                  day: "numeric",
                })}
              </ThemedText>
            </View>
            <View style={styles.infoRow}>
              <Icon name="clock" size={16} color={theme.textSecondary} />
              <ThemedText style={[styles.infoText, { color: theme.textSecondary }]}>
                {excursion.time}
              </ThemedText>
            </View>
            {isAdmin && excursion.managerName ? (
              <View style={styles.infoRow}>
                <Icon name="user" size={16} color={theme.textSecondary} />
                <ThemedText style={[styles.infoText, { color: theme.primary }]}>
                  {excursion.managerName}
                </ThemedText>
              </View>
            ) : null}
          </View>
        </ThemedView>

        <ThemedView
          style={[
            styles.card,
            {
              borderColor: theme.border,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <ThemedText style={styles.sectionTitle}>Участники</ThemedText>
          <View style={styles.participantsTable}>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Всего:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{totalParticipants} чел.</ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Полная оплата:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{excursion.fullPriceCount} чел.</ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Льготная:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{excursion.discountedCount} чел.</ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Бесплатно:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{excursion.freeCount} чел.</ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                По туру:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{excursion.byTourCount || 0} чел.</ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Оплаченные:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{excursion.paidCount || 0} чел.</ThemedText>
            </View>
          </View>
        </ThemedView>

        <ThemedView
          style={[
            styles.card,
            {
              borderColor: theme.border,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <ThemedText style={styles.sectionTitle}>Доход</ThemedText>
          <View style={styles.participantsTable}>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Билеты (полная):
              </ThemedText>
              <ThemedText style={styles.tableValue}>
                {formatCurrency(excursion.fullPriceCount * tourType.fullPrice)}
              </ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Билеты (льготная):
              </ThemedText>
              <ThemedText style={styles.tableValue}>
                {formatCurrency(excursion.discountedCount * tourType.discountedPrice)}
              </ThemedText>
            </View>
            {excursion.additionalServices.map((service) => {
              const serviceData = additionalServices.find((s) => s.id === service.serviceId);
              if (!serviceData) return null;
              return (
                <View key={service.serviceId} style={styles.tableRow}>
                  <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                    {serviceData.name}:
                  </ThemedText>
                  <ThemedText style={styles.tableValue}>
                    {formatCurrency(serviceData.price * service.count)}
                  </ThemedText>
                </View>
              );
            })}
            <View style={[styles.tableRow, styles.totalRow]}>
              <ThemedText style={styles.totalLabel}>Итого:</ThemedText>
              <ThemedText style={styles.totalValue}>{formatCurrency(revenue)}</ThemedText>
            </View>
          </View>
        </ThemedView>

        <ThemedView
          style={[
            styles.card,
            {
              borderColor: theme.border,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <ThemedText style={styles.sectionTitle}>Расходы</ThemedText>
          <View style={styles.participantsTable}>
            {excursion.expenses.map((expense) => (
              <View key={expense.id} style={styles.tableRow}>
                <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                  {expense.type}:
                </ThemedText>
                <ThemedText style={styles.tableValue}>{formatCurrency(expense.amount)}</ThemedText>
              </View>
            ))}
            <View style={[styles.tableRow, styles.totalRow]}>
              <ThemedText style={styles.totalLabel}>Итого:</ThemedText>
              <ThemedText style={styles.totalValue}>{formatCurrency(expenses)}</ThemedText>
            </View>
          </View>
        </ThemedView>

        {isAdmin ? (
          <ThemedView
            style={[
              styles.profitCard,
              {
                backgroundColor: profit >= 0 ? theme.success : theme.error,
                borderRadius: BorderRadius.sm,
              },
            ]}
          >
            <ThemedText style={[styles.profitLabel, { color: "#FFFFFF" }]}>
              Чистая прибыль
            </ThemedText>
            <ThemedText style={[styles.profitValue, { color: "#FFFFFF" }]}>
              {formatCurrency(profit)}
            </ThemedText>
          </ThemedView>
        ) : null}

        {(canAddNote || visibleNotes.length > 0 || isAdmin) ? (
          <ThemedView
            style={[
              styles.card,
              {
                borderColor: theme.border,
                borderRadius: BorderRadius.sm,
              },
            ]}
          >
            <View style={styles.sectionHeader}>
              <ThemedText style={styles.sectionTitle}>Заметки к экскурсии</ThemedText>
              {canAddNote ? (
                <View style={{ flexDirection: "row", gap: Spacing.sm }}>
                  <Pressable
                    onPress={() => {
                      hapticFeedback.selection();
                      setShowNotesPicker(true);
                    }}
                    style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
                  >
                    <Icon name="plus" size={20} color={theme.primary} />
                  </Pressable>
                  <Pressable
                    onPress={() => setShowNoteInput(!showNoteInput)}
                    style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
                  >
                    <Icon name={showNoteInput ? "x" : "edit-3"} size={20} color={theme.primary} />
                  </Pressable>
                </View>
              ) : null}
            </View>

            {showNoteInput ? (
              <View style={styles.noteInputContainer}>
                <TextInput
                  style={[
                    styles.noteInput,
                    {
                      backgroundColor: theme.backgroundSecondary,
                      color: theme.text,
                      borderColor: theme.border,
                    },
                  ]}
                  placeholder="Введите заметку..."
                  placeholderTextColor={theme.textSecondary}
                  value={noteText}
                  onChangeText={setNoteText}
                  multiline
                  maxLength={500}
                />
                <Pressable
                  onPress={handleAddNote}
                  disabled={isAddingNote || !noteText.trim()}
                  style={[
                    styles.addNoteButton,
                    {
                      backgroundColor: noteText.trim() ? theme.primary : theme.border,
                    },
                  ]}
                >
                  <ThemedText style={{ color: "#FFFFFF", fontWeight: "600" }}>
                    {isAddingNote ? "..." : "Добавить"}
                  </ThemedText>
                </Pressable>
              </View>
            ) : null}

            {visibleNotes.length === 0 ? (
              <ThemedText style={{ color: theme.textSecondary, fontSize: 14 }}>
                {isAdmin ? "Заметок пока нет" : isExcursionToday ? "У вас нет заметок к этой экскурсии" : "Заметки доступны только в день экскурсии"}
              </ThemedText>
            ) : (
              <View style={styles.notesList}>
                {visibleNotes.map((note: ExcursionNote) => {
                  const isExpanded = expandedNoteId === note.id;
                  const isLongNote = note.text.length > 100;
                  return (
                    <Pressable
                      key={note.id}
                      onPress={() => {
                        hapticFeedback.selection();
                        setFullscreenNote(note);
                      }}
                      style={[
                        styles.noteItem,
                        { backgroundColor: theme.backgroundSecondary, borderRadius: BorderRadius.sm },
                      ]}
                    >
                      <View style={styles.noteContent}>
                        <ThemedText 
                          style={styles.noteText}
                          numberOfLines={3}
                        >
                          {note.text}
                        </ThemedText>
                        <ThemedText style={{ color: theme.primary, fontSize: 12, marginTop: 4 }}>
                          Нажмите для просмотра
                        </ThemedText>
                        <View style={styles.noteMeta}>
                          {isAdmin && note.managerName ? (
                            <ThemedText style={[styles.noteAuthor, { color: theme.primary }]}>
                              {note.managerName}
                            </ThemedText>
                          ) : null}
                          <ThemedText style={[styles.noteDate, { color: theme.textSecondary }]}>
                            {new Date(note.createdAt).toLocaleString("ru-RU", {
                              day: "2-digit",
                              month: "2-digit",
                              hour: "2-digit",
                              minute: "2-digit",
                            })}
                          </ThemedText>
                        </View>
                      </View>
                      {(note.managerId === profile?.id || isAdmin) ? (
                        <Pressable
                          onPress={() => handleDeleteNote(note.id)}
                          style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1, padding: 4 })}
                        >
                          <Icon name="trash-2" size={16} color={theme.error} />
                        </Pressable>
                      ) : null}
                    </Pressable>
                  );
                })}
              </View>
            )}
          </ThemedView>
        ) : null}
      </View>

      <Modal visible={showEditModal} animationType="slide" presentationStyle="pageSheet">
        <AddExcursionForm
          key={editKey}
          excursion={excursion}
          onSave={handleSaveEdit}
          onCancel={() => setShowEditModal(false)}
        />
      </Modal>

      <Modal
        visible={showNotesPicker}
        transparent
        animationType="slide"
        onRequestClose={() => setShowNotesPicker(false)}
      >
        <Pressable style={styles.modalBackdrop} onPress={() => setShowNotesPicker(false)}>
          <ThemedView style={[styles.notesPickerModal, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.notesPickerHeader}>
              <ThemedText style={styles.notesPickerTitle}>Выберите заметку</ThemedText>
              <Pressable onPress={() => setShowNotesPicker(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>
            {dispatchingNotes.length === 0 ? (
              <View style={styles.emptyNotes}>
                <Icon name="file-text" size={48} color={theme.textSecondary} />
                <ThemedText style={{ color: theme.textSecondary, marginTop: Spacing.md }}>
                  Нет личных заметок
                </ThemedText>
                <ThemedText style={{ color: theme.textSecondary, fontSize: 12, marginTop: Spacing.xs }}>
                  Добавьте заметки на вкладке "Отправление"
                </ThemedText>
              </View>
            ) : (
              <FlatList
                data={dispatchingNotes}
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => (
                  <Pressable
                    style={({ pressed }) => [
                      styles.dispatchingNoteItem,
                      { backgroundColor: pressed ? theme.backgroundTertiary : theme.backgroundSecondary },
                    ]}
                    onPress={() => handleSelectDispatchingNote(item)}
                  >
                    <ThemedText numberOfLines={3} style={styles.dispatchingNoteText}>
                      {item.text}
                    </ThemedText>
                    <ThemedText style={[styles.dispatchingNoteDate, { color: theme.textSecondary }]}>
                      {new Date(item.createdAt).toLocaleDateString("ru-RU", {
                        day: "2-digit",
                        month: "2-digit",
                        hour: "2-digit",
                        minute: "2-digit",
                      })}
                    </ThemedText>
                  </Pressable>
                )}
                ItemSeparatorComponent={() => <View style={{ height: Spacing.sm }} />}
                contentContainerStyle={{ paddingBottom: Spacing.xl }}
              />
            )}
          </ThemedView>
        </Pressable>
      </Modal>

      {/* Fullscreen Note Modal */}
      <Modal
        visible={fullscreenNote !== null}
        transparent
        animationType="fade"
        onRequestClose={() => setFullscreenNote(null)}
      >
        <Pressable 
          style={styles.fullscreenNoteBackdrop} 
          onPress={() => setFullscreenNote(null)}
        >
          <ThemedView style={[styles.fullscreenNoteContainer, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.fullscreenNoteHeader}>
              <ThemedText style={styles.fullscreenNoteTitle}>Заметка</ThemedText>
              <Pressable onPress={() => setFullscreenNote(null)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>
            <View style={styles.fullscreenNoteContent}>
              <ThemedText style={styles.fullscreenNoteText}>
                {fullscreenNote?.text}
              </ThemedText>
              <View style={styles.fullscreenNoteMeta}>
                {isAdmin && fullscreenNote?.managerName ? (
                  <ThemedText style={[styles.noteAuthor, { color: theme.primary }]}>
                    {fullscreenNote.managerName}
                  </ThemedText>
                ) : null}
                {fullscreenNote?.createdAt ? (
                  <ThemedText style={[styles.noteDate, { color: theme.textSecondary }]}>
                    {new Date(fullscreenNote.createdAt).toLocaleString("ru-RU", {
                      day: "2-digit",
                      month: "2-digit",
                      year: "numeric",
                      hour: "2-digit",
                      minute: "2-digit",
                    })}
                  </ThemedText>
                ) : null}
              </View>
            </View>
          </ThemedView>
        </Pressable>
      </Modal>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing.lg,
  },
  card: {
    padding: Spacing.lg,
    borderWidth: 1,
    gap: Spacing.md,
  },
  tourName: {
    fontSize: 24,
    fontWeight: "700",
  },
  info: {
    gap: Spacing.sm,
  },
  infoRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  infoText: {
    fontSize: 14,
    textTransform: "capitalize",
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  participantsTable: {
    gap: Spacing.sm,
  },
  tableRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  tableLabel: {
    fontSize: 14,
  },
  tableValue: {
    fontSize: 14,
    fontWeight: "500",
  },
  totalRow: {
    marginTop: Spacing.sm,
    paddingTop: Spacing.sm,
    borderTopWidth: 1,
    borderTopColor: "#E5E7EB",
  },
  totalLabel: {
    fontSize: 16,
    fontWeight: "600",
  },
  totalValue: {
    fontSize: 16,
    fontWeight: "700",
  },
  profitCard: {
    paddingHorizontal: Spacing.xl,
    paddingVertical: Spacing["2xl"],
    alignItems: "center",
    gap: Spacing.sm,
  },
  profitLabel: {
    fontSize: 16,
    fontWeight: "500",
    lineHeight: 22,
  },
  profitValue: {
    fontSize: 32,
    fontWeight: "700",
    lineHeight: 42,
  },
  sectionHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  noteInputContainer: {
    gap: Spacing.sm,
  },
  noteInput: {
    borderWidth: 1,
    borderRadius: 8,
    padding: Spacing.md,
    minHeight: 120,
    textAlignVertical: "top",
    fontSize: 16,
  },
  addNoteButton: {
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.lg,
    borderRadius: 8,
    alignSelf: "flex-end",
  },
  notesList: {
    gap: Spacing.sm,
  },
  noteItem: {
    flexDirection: "row",
    padding: Spacing.md,
    alignItems: "flex-start",
  },
  noteContent: {
    flex: 1,
    gap: Spacing.xs,
  },
  noteText: {
    fontSize: 14,
    lineHeight: 20,
  },
  noteMeta: {
    flexDirection: "row",
    gap: Spacing.sm,
    alignItems: "center",
  },
  noteAuthor: {
    fontSize: 12,
    fontWeight: "500",
  },
  noteDate: {
    fontSize: 12,
  },
  modalBackdrop: {
    flex: 1,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
    justifyContent: "flex-end",
  },
  notesPickerModal: {
    maxHeight: "70%",
    borderTopLeftRadius: 16,
    borderTopRightRadius: 16,
    padding: Spacing.lg,
  },
  notesPickerHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.lg,
  },
  notesPickerTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  emptyNotes: {
    alignItems: "center",
    paddingVertical: Spacing["2xl"],
  },
  dispatchingNoteItem: {
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
  },
  dispatchingNoteText: {
    fontSize: 14,
    lineHeight: 20,
  },
  dispatchingNoteDate: {
    fontSize: 12,
    marginTop: Spacing.xs,
  },
  fullscreenNoteBackdrop: {
    flex: 1,
    backgroundColor: "rgba(0, 0, 0, 0.7)",
    justifyContent: "center",
    alignItems: "center",
    padding: Spacing.lg,
  },
  fullscreenNoteContainer: {
    width: "100%",
    maxHeight: "80%",
    borderRadius: BorderRadius.lg,
    overflow: "hidden",
  },
  fullscreenNoteHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.lg,
    borderBottomWidth: 1,
    borderBottomColor: "rgba(255, 255, 255, 0.1)",
  },
  fullscreenNoteTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  fullscreenNoteContent: {
    padding: Spacing.lg,
  },
  fullscreenNoteText: {
    fontSize: 16,
    lineHeight: 24,
  },
  fullscreenNoteMeta: {
    flexDirection: "row",
    gap: Spacing.sm,
    alignItems: "center",
    marginTop: Spacing.lg,
    paddingTop: Spacing.md,
    borderTopWidth: 1,
    borderTopColor: "rgba(255, 255, 255, 0.1)",
  },
});
