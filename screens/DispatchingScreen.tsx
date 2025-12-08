import { useState, useEffect, useRef } from "react";
import { View, StyleSheet, TextInput, Pressable, Platform, Modal, FlatList, Alert, Keyboard, TouchableWithoutFeedback } from "react-native";
import { WebView } from "react-native-webview";
import { Feather } from "@expo/vector-icons";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { BlurView } from "expo-blur";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { useTheme } from "@/hooks/useTheme";
import { useData, DispatchingNote } from "@/contexts/DataContext";
import { Spacing, BorderRadius, Typography } from "@/constants/theme";
import { hapticFeedback } from "@/utils/haptics";

const DEFAULT_DATABASE_URL = "http://turburo-kazan.ru/managers/zapis-na-ekskursiyu.php?arrFilter_ff%5BNAME%5D=&arrFilter_DATE_ACTIVE_FROM_1=&arrFilter_DATE_ACTIVE_FROM_2=&arrFilter_pf%5BTYPE%5D=&arrFilter_pf%5BGOSTINICI%5D=&arrFilter_CREATED_BY=&sort=date_ex&USER_REMEMBER=Y&set_filter=Показать&set_filter=Y";
export const DISPATCH_URL_KEY = "@dispatch_webview_url";

export default function DispatchingScreen() {
  const { theme } = useTheme();
  const insets = useSafeAreaInsets();
  const { dispatchingNotes, addDispatchingNote, updateDispatchingNote, deleteDispatchingNote } = useData();
  const [currentNote, setCurrentNote] = useState("");
  const [showNotesList, setShowNotesList] = useState(false);
  const [showFullscreenNote, setShowFullscreenNote] = useState(false);
  const [editingNote, setEditingNote] = useState<DispatchingNote | null>(null);
  const [showCalculator, setShowCalculator] = useState(false);
  const [calcDisplay, setCalcDisplay] = useState("0");
  const [calcPrevValue, setCalcPrevValue] = useState<number | null>(null);
  const [calcOperation, setCalcOperation] = useState<string | null>(null);
  const [calcWaitingForOperand, setCalcWaitingForOperand] = useState(false);
  const [webViewUrl, setWebViewUrl] = useState(DEFAULT_DATABASE_URL);
  const [isSaving, setIsSaving] = useState(false);

  useEffect(() => {
    loadWebViewUrl();
  }, []);

  const loadWebViewUrl = async () => {
    try {
      const savedUrl = await AsyncStorage.getItem(DISPATCH_URL_KEY);
      if (savedUrl !== null) {
        setWebViewUrl(savedUrl);
      }
    } catch (error) {
      console.error("Failed to load webview URL:", error);
    }
  };

  const formatNoteDate = (dateStr: string) => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
      hour: "2-digit",
      minute: "2-digit",
    });
  };

  const handleSaveNote = async () => {
    if (!currentNote.trim()) {
      Alert.alert("Внимание", "Введите текст заметки");
      return;
    }

    if (isSaving) return;
    setIsSaving(true);

    try {
      if (editingNote) {
        await updateDispatchingNote(editingNote.id, currentNote.trim());
        setEditingNote(null);
      } else {
        await addDispatchingNote(currentNote.trim());
      }
      hapticFeedback.success();
      setCurrentNote("");
      setShowFullscreenNote(false);
    } catch (err) {
      hapticFeedback.error();
      Alert.alert("Ошибка", "Не удалось сохранить заметку");
    } finally {
      setIsSaving(false);
    }
  };

  const handleDeleteNote = (noteId: string) => {
    Alert.alert("Удалить заметку?", "Это действие нельзя отменить", [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: async () => {
          try {
            await deleteDispatchingNote(noteId);
            hapticFeedback.success();
          } catch (err) {
            hapticFeedback.error();
            Alert.alert("Ошибка", "Не удалось удалить заметку");
          }
        },
      },
    ]);
  };

  const handleEditNote = (note: DispatchingNote) => {
    setEditingNote(note);
    setCurrentNote(note.text);
    setShowNotesList(false);
  };

  const handleCancelEdit = () => {
    setEditingNote(null);
    setCurrentNote("");
    setShowFullscreenNote(false);
  };

  const dismissKeyboard = () => {
    Keyboard.dismiss();
  };

  const formatCalcDisplay = (value: string): string => {
    const num = parseFloat(value);
    if (isNaN(num)) return value;
    if (Number.isInteger(num) && value.length > 12) {
      return num.toExponential(6);
    }
    if (value.length > 15) {
      return num.toPrecision(10);
    }
    return value;
  };

  const handleCalcDigit = (digit: string) => {
    hapticFeedback.light();
    if (calcWaitingForOperand) {
      setCalcDisplay(digit);
      setCalcWaitingForOperand(false);
    } else {
      setCalcDisplay(calcDisplay === "0" ? digit : calcDisplay + digit);
    }
  };

  const handleCalcDecimal = () => {
    hapticFeedback.light();
    if (calcWaitingForOperand) {
      setCalcDisplay("0.");
      setCalcWaitingForOperand(false);
    } else if (!calcDisplay.includes(".")) {
      setCalcDisplay(calcDisplay + ".");
    }
  };

  const handleCalcOperation = (op: string) => {
    hapticFeedback.light();
    const current = parseFloat(calcDisplay);
    
    if (calcPrevValue !== null && !calcWaitingForOperand) {
      const result = calculate(calcPrevValue, current, calcOperation!);
      setCalcDisplay(String(result));
      setCalcPrevValue(result);
    } else {
      setCalcPrevValue(current);
    }
    
    setCalcOperation(op);
    setCalcWaitingForOperand(true);
  };

  const calculate = (a: number, b: number, op: string): number => {
    switch (op) {
      case "+": return a + b;
      case "-": return a - b;
      case "×": return a * b;
      case "÷": return b !== 0 ? a / b : 0;
      default: return b;
    }
  };

  const handleCalcEquals = () => {
    hapticFeedback.medium();
    if (calcPrevValue === null || calcOperation === null) return;
    
    const current = parseFloat(calcDisplay);
    const result = calculate(calcPrevValue, current, calcOperation);
    setCalcDisplay(String(result));
    setCalcPrevValue(null);
    setCalcOperation(null);
    setCalcWaitingForOperand(true);
  };

  const handleCalcClear = () => {
    hapticFeedback.light();
    setCalcDisplay("0");
    setCalcPrevValue(null);
    setCalcOperation(null);
    setCalcWaitingForOperand(false);
  };

  const CalcButton = ({ label, onPress, style, textStyle }: { label: string; onPress: () => void; style?: object; textStyle?: object }) => (
    <Pressable
      style={({ pressed }) => [
        styles.calcButton,
        { backgroundColor: theme.backgroundSecondary },
        style,
        pressed && { opacity: 0.7 },
      ]}
      onPress={onPress}
    >
      <ThemedText style={[styles.calcButtonText, textStyle]}>{label}</ThemedText>
    </Pressable>
  );

  return (
    <View style={[styles.container, { backgroundColor: theme.backgroundRoot }]}>
      <View style={[styles.notesContainer, { paddingTop: insets.top + 60 }]}>
        <View style={styles.notesHeader}>
          <ThemedText style={styles.notesTitle}>Заметки</ThemedText>
          <View style={styles.notesActions}>
            {dispatchingNotes.length > 0 ? (
              <Pressable
                style={({ pressed }) => [
                  styles.notesHeaderButton,
                  { backgroundColor: theme.backgroundSecondary, opacity: pressed ? 0.7 : 1 },
                ]}
                onPress={() => {
                  hapticFeedback.selection();
                  setShowNotesList(true);
                }}
              >
                <Feather name="list" size={16} color={theme.text} />
                <ThemedText style={styles.notesHeaderButtonText}>
                  {dispatchingNotes.length}
                </ThemedText>
              </Pressable>
            ) : null}
            <Pressable
              style={({ pressed }) => [
                styles.notesHeaderButton,
                { backgroundColor: theme.primary, opacity: pressed ? 0.7 : 1 },
              ]}
              onPress={() => {
                hapticFeedback.medium();
                setShowFullscreenNote(true);
              }}
            >
              <Feather name="plus" size={16} color={theme.buttonText} />
            </Pressable>
          </View>
        </View>

        {editingNote ? (
          <View style={styles.editingIndicator}>
            <ThemedText style={[styles.editingText, { color: theme.primary }]}>
              Редактирование заметки
            </ThemedText>
            <Pressable onPress={handleCancelEdit}>
              <Feather name="x" size={18} color={theme.error} />
            </Pressable>
          </View>
        ) : null}

        <View style={[styles.noteInputContainer, { backgroundColor: theme.backgroundSecondary }]}>
          <TextInput
            style={[styles.noteInput, { color: theme.text }]}
            placeholder="Быстрая заметка..."
            placeholderTextColor={theme.textSecondary}
            value={currentNote}
            onChangeText={setCurrentNote}
            multiline
            numberOfLines={2}
          />
          {currentNote.trim() ? (
            <Pressable
              style={[styles.sendButton, { backgroundColor: theme.primary }]}
              onPress={handleSaveNote}
              disabled={isSaving}
            >
              <Feather name={editingNote ? "check" : "send"} size={16} color={theme.buttonText} />
            </Pressable>
          ) : null}
        </View>
      </View>

      <View style={styles.webViewContainer}>
        {Platform.OS === "web" ? (
          <View style={[styles.webFallback, { backgroundColor: theme.backgroundDefault }]}>
            <Feather name="globe" size={48} color={theme.textSecondary} />
            <ThemedText style={[styles.webFallbackText, { color: theme.textSecondary }]}>
              Откройте приложение в Expo Go для доступа к браузеру
            </ThemedText>
          </View>
        ) : (
          <WebView
            source={{ uri: webViewUrl }}
            style={styles.webView}
            startInLoadingState={true}
            javaScriptEnabled={true}
            domStorageEnabled={true}
          />
        )}
      </View>

      <Pressable
        style={[styles.fab, { bottom: insets.bottom + 90 }]}
        onPress={() => {
          hapticFeedback.light();
          setShowCalculator(true);
        }}
      >
        <BlurView intensity={100} tint="dark" style={styles.fabBlur}>
          <Feather name="percent" size={24} color="#FFFFFF" />
        </BlurView>
      </Pressable>

      <Modal
        visible={showNotesList}
        transparent
        animationType="slide"
        onRequestClose={() => setShowNotesList(false)}
      >
        <Pressable style={styles.modalBackdrop} onPress={() => setShowNotesList(false)}>
          <TouchableWithoutFeedback>
            <ThemedView style={[styles.notesListModal, { backgroundColor: theme.backgroundDefault }]}>
              <View style={styles.notesListHeader}>
                <ThemedText style={styles.notesListTitle}>Все заметки</ThemedText>
                <Pressable onPress={() => setShowNotesList(false)}>
                  <Feather name="x" size={24} color={theme.text} />
                </Pressable>
              </View>

              <FlatList
                data={dispatchingNotes}
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => (
                  <View style={[styles.noteItem, { borderBottomColor: theme.border }]}>
                    <View style={styles.noteContent}>
                      <ThemedText style={styles.noteText} numberOfLines={3}>
                        {item.text}
                      </ThemedText>
                      <ThemedText style={[styles.noteDate, { color: theme.textSecondary }]}>
                        {formatNoteDate(item.createdAt)}
                      </ThemedText>
                    </View>
                    <View style={styles.noteActions}>
                      <Pressable
                        style={styles.noteActionButton}
                        onPress={() => {
                          hapticFeedback.selection();
                          handleEditNote(item);
                        }}
                      >
                        <Feather name="edit-2" size={18} color={theme.primary} />
                      </Pressable>
                      <Pressable
                        style={styles.noteActionButton}
                        onPress={() => {
                          hapticFeedback.light();
                          handleDeleteNote(item.id);
                        }}
                      >
                        <Feather name="trash-2" size={18} color={theme.error} />
                      </Pressable>
                    </View>
                  </View>
                )}
                ListEmptyComponent={
                  <View style={styles.emptyNotes}>
                    <Feather name="file-text" size={48} color={theme.textSecondary} />
                    <ThemedText style={[styles.emptyNotesText, { color: theme.textSecondary }]}>
                      Нет заметок
                    </ThemedText>
                  </View>
                }
              />
            </ThemedView>
          </TouchableWithoutFeedback>
        </Pressable>
      </Modal>

      <Modal
        visible={showFullscreenNote}
        animationType="slide"
        presentationStyle="pageSheet"
        onRequestClose={handleCancelEdit}
      >
        <ThemedView style={[styles.fullscreenNoteContainer, { backgroundColor: theme.backgroundRoot }]}>
          <View style={[styles.fullscreenNoteHeader, { borderBottomColor: theme.border }]}>
            <Pressable onPress={handleCancelEdit}>
              <ThemedText style={{ color: theme.primary }}>Отмена</ThemedText>
            </Pressable>
            <ThemedText style={styles.fullscreenNoteTitle}>
              {editingNote ? "Редактировать" : "Новая заметка"}
            </ThemedText>
            <Pressable onPress={handleSaveNote} disabled={isSaving}>
              <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>
                {isSaving ? "..." : "Сохранить"}
              </ThemedText>
            </Pressable>
          </View>
          <TextInput
            style={[styles.fullscreenNoteInput, { color: theme.text }]}
            placeholder="Введите заметку..."
            placeholderTextColor={theme.textSecondary}
            value={currentNote}
            onChangeText={setCurrentNote}
            multiline
            autoFocus
          />
        </ThemedView>
      </Modal>

      <Modal
        visible={showCalculator}
        transparent
        animationType="fade"
        onRequestClose={() => setShowCalculator(false)}
      >
        <Pressable style={styles.calcModalBackdrop} onPress={() => setShowCalculator(false)}>
          <Pressable style={[styles.calculatorContainer, { backgroundColor: theme.backgroundDefault }]} onPress={(e) => e.stopPropagation()}>
            <View style={styles.calcHeader}>
              <ThemedText style={styles.calcTitle}>Калькулятор</ThemedText>
              <Pressable onPress={() => setShowCalculator(false)}>
                <Feather name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <View style={[styles.calcDisplay, { backgroundColor: theme.backgroundSecondary }]}>
              <ThemedText style={styles.calcDisplayText} numberOfLines={1} adjustsFontSizeToFit minimumFontScale={0.5}>
                {formatCalcDisplay(calcDisplay)}
              </ThemedText>
            </View>

            <View style={styles.calcGrid}>
              <View style={styles.calcRow}>
                <CalcButton label="C" onPress={handleCalcClear} style={{ backgroundColor: theme.error }} textStyle={{ color: "#FFFFFF" }} />
                <CalcButton label="÷" onPress={() => handleCalcOperation("÷")} style={{ backgroundColor: theme.primary }} textStyle={{ color: "#FFFFFF" }} />
                <CalcButton label="×" onPress={() => handleCalcOperation("×")} style={{ backgroundColor: theme.primary }} textStyle={{ color: "#FFFFFF" }} />
                <CalcButton label="-" onPress={() => handleCalcOperation("-")} style={{ backgroundColor: theme.primary }} textStyle={{ color: "#FFFFFF" }} />
              </View>
              <View style={styles.calcRow}>
                <CalcButton label="7" onPress={() => handleCalcDigit("7")} />
                <CalcButton label="8" onPress={() => handleCalcDigit("8")} />
                <CalcButton label="9" onPress={() => handleCalcDigit("9")} />
                <CalcButton label="+" onPress={() => handleCalcOperation("+")} style={{ backgroundColor: theme.primary }} textStyle={{ color: "#FFFFFF" }} />
              </View>
              <View style={styles.calcRow}>
                <CalcButton label="4" onPress={() => handleCalcDigit("4")} />
                <CalcButton label="5" onPress={() => handleCalcDigit("5")} />
                <CalcButton label="6" onPress={() => handleCalcDigit("6")} />
                <CalcButton label="=" onPress={handleCalcEquals} style={{ backgroundColor: theme.success }} textStyle={{ color: "#FFFFFF" }} />
              </View>
              <View style={styles.calcRow}>
                <CalcButton label="1" onPress={() => handleCalcDigit("1")} />
                <CalcButton label="2" onPress={() => handleCalcDigit("2")} />
                <CalcButton label="3" onPress={() => handleCalcDigit("3")} />
                <CalcButton label="." onPress={handleCalcDecimal} />
              </View>
              <View style={styles.calcRow}>
                <CalcButton label="0" onPress={() => handleCalcDigit("0")} style={{ flex: 2 }} />
                <View style={{ flex: 2 }} />
              </View>
            </View>
          </Pressable>
        </Pressable>
      </Modal>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  notesContainer: {
    paddingHorizontal: Spacing.md,
    paddingBottom: Spacing.md,
    gap: Spacing.sm,
  },
  notesHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  notesTitle: {
    fontSize: Typography.h3.fontSize,
    fontWeight: "600",
  },
  notesActions: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  notesHeaderButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
  },
  notesHeaderButtonText: {
    fontSize: 14,
    fontWeight: "500",
  },
  editingIndicator: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingHorizontal: Spacing.sm,
  },
  editingText: {
    fontSize: 13,
    fontWeight: "500",
  },
  noteInputContainer: {
    flexDirection: "row",
    alignItems: "flex-end",
    borderRadius: BorderRadius.md,
    padding: Spacing.sm,
    gap: Spacing.sm,
  },
  noteInput: {
    flex: 1,
    fontSize: 15,
    maxHeight: 80,
    paddingVertical: Spacing.xs,
  },
  sendButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    justifyContent: "center",
    alignItems: "center",
  },
  webViewContainer: {
    flex: 1,
  },
  webView: {
    flex: 1,
  },
  webFallback: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    gap: Spacing.md,
    padding: Spacing.xl,
  },
  webFallbackText: {
    textAlign: "center",
    fontSize: 15,
  },
  fab: {
    position: "absolute",
    right: Spacing.lg,
    width: 56,
    height: 56,
    borderRadius: 28,
    overflow: "hidden",
  },
  fabBlur: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  modalBackdrop: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
    justifyContent: "flex-end",
  },
  notesListModal: {
    maxHeight: "70%",
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    paddingBottom: Spacing.xl,
  },
  notesListHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.lg,
    borderBottomWidth: 1,
    borderBottomColor: "rgba(255,255,255,0.1)",
  },
  notesListTitle: {
    fontSize: Typography.h3.fontSize,
    fontWeight: "600",
  },
  noteItem: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.lg,
    borderBottomWidth: 1,
  },
  noteContent: {
    flex: 1,
    gap: Spacing.xs,
  },
  noteText: {
    fontSize: 15,
  },
  noteDate: {
    fontSize: 12,
  },
  noteActions: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  noteActionButton: {
    padding: Spacing.sm,
  },
  emptyNotes: {
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: Spacing["2xl"],
    gap: Spacing.md,
  },
  emptyNotesText: {
    fontSize: 15,
  },
  fullscreenNoteContainer: {
    flex: 1,
  },
  fullscreenNoteHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.lg,
    borderBottomWidth: 1,
  },
  fullscreenNoteTitle: {
    fontSize: Typography.h3.fontSize,
    fontWeight: "600",
  },
  fullscreenNoteInput: {
    flex: 1,
    fontSize: 16,
    padding: Spacing.lg,
    textAlignVertical: "top",
  },
  calcModalBackdrop: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
    justifyContent: "center",
    alignItems: "center",
  },
  calculatorContainer: {
    width: "85%",
    maxWidth: 320,
    borderRadius: BorderRadius.lg,
    padding: Spacing.lg,
  },
  calcHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  calcTitle: {
    fontSize: Typography.h3.fontSize,
    fontWeight: "600",
  },
  calcDisplay: {
    padding: Spacing.lg,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.md,
    alignItems: "flex-end",
  },
  calcDisplayText: {
    fontSize: 32,
    fontWeight: "500",
  },
  calcGrid: {
    gap: Spacing.sm,
  },
  calcRow: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  calcButton: {
    flex: 1,
    aspectRatio: 1,
    justifyContent: "center",
    alignItems: "center",
    borderRadius: BorderRadius.md,
  },
  calcButtonText: {
    fontSize: 22,
    fontWeight: "500",
  },
});
