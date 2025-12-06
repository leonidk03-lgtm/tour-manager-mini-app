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
import { Spacing, BorderRadius, Typography } from "@/constants/theme";

const DATABASE_URL = "http://turburo-kazan.ru/managers/zapis-na-ekskursiyu.php?arrFilter_ff%5BNAME%5D=&arrFilter_DATE_ACTIVE_FROM_1=&arrFilter_DATE_ACTIVE_FROM_2=&arrFilter_pf%5BTYPE%5D=&arrFilter_pf%5BGOSTINICI%5D=&arrFilter_CREATED_BY=&sort=date_ex&USER_REMEMBER=Y&set_filter=Показать&set_filter=Y";
const NOTES_STORAGE_KEY = "@dispatching_notes_list";

interface Note {
  id: string;
  text: string;
  createdAt: string;
}

export default function DispatchingScreen() {
  const { theme } = useTheme();
  const insets = useSafeAreaInsets();
  const [notes, setNotes] = useState<Note[]>([]);
  const [currentNote, setCurrentNote] = useState("");
  const [showNotesList, setShowNotesList] = useState(false);
  const [showFullscreenNote, setShowFullscreenNote] = useState(false);
  const [editingNote, setEditingNote] = useState<Note | null>(null);
  const [showCalculator, setShowCalculator] = useState(false);
  const [calcDisplay, setCalcDisplay] = useState("0");
  const [calcPrevValue, setCalcPrevValue] = useState<number | null>(null);
  const [calcOperation, setCalcOperation] = useState<string | null>(null);
  const [calcWaitingForOperand, setCalcWaitingForOperand] = useState(false);

  useEffect(() => {
    loadNotes();
  }, []);

  const loadNotes = async () => {
    try {
      const savedNotes = await AsyncStorage.getItem(NOTES_STORAGE_KEY);
      if (savedNotes !== null) {
        setNotes(JSON.parse(savedNotes));
      }
    } catch (error) {
      console.error("Failed to load notes:", error);
    }
  };

  const saveNotes = async (notesList: Note[]) => {
    try {
      await AsyncStorage.setItem(NOTES_STORAGE_KEY, JSON.stringify(notesList));
    } catch (error) {
      console.error("Failed to save notes:", error);
    }
  };

  const handleSaveNote = () => {
    if (!currentNote.trim()) {
      Alert.alert("Внимание", "Введите текст заметки");
      return;
    }

    let updatedNotes: Note[];
    if (editingNote) {
      updatedNotes = notes.map((n) =>
        n.id === editingNote.id ? { ...n, text: currentNote.trim() } : n
      );
      setEditingNote(null);
    } else {
      const newNote: Note = {
        id: Date.now().toString(),
        text: currentNote.trim(),
        createdAt: new Date().toLocaleDateString("ru-RU", {
          day: "2-digit",
          month: "2-digit",
          year: "numeric",
          hour: "2-digit",
          minute: "2-digit",
        }),
      };
      updatedNotes = [newNote, ...notes];
    }

    setNotes(updatedNotes);
    saveNotes(updatedNotes);
    setCurrentNote("");
    setShowFullscreenNote(false);
  };

  const handleDeleteNote = (noteId: string) => {
    Alert.alert("Удалить заметку?", "Это действие нельзя отменить", [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: () => {
          const updatedNotes = notes.filter((n) => n.id !== noteId);
          setNotes(updatedNotes);
          saveNotes(updatedNotes);
        },
      },
    ]);
  };

  const handleEditNote = (note: Note) => {
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
    if (calcWaitingForOperand) {
      setCalcDisplay(digit);
      setCalcWaitingForOperand(false);
    } else {
      if (calcDisplay.length < 15) {
        setCalcDisplay(calcDisplay === "0" ? digit : calcDisplay + digit);
      }
    }
  };

  const handleCalcDecimal = () => {
    if (calcWaitingForOperand) {
      setCalcDisplay("0.");
      setCalcWaitingForOperand(false);
    } else if (!calcDisplay.includes(".")) {
      setCalcDisplay(calcDisplay + ".");
    }
  };

  const handleCalcOperation = (op: string) => {
    const currentValue = parseFloat(calcDisplay);
    
    if (calcPrevValue !== null && calcOperation && !calcWaitingForOperand) {
      const result = calculate(calcPrevValue, currentValue, calcOperation);
      setCalcDisplay(String(result));
      setCalcPrevValue(result);
    } else {
      setCalcPrevValue(currentValue);
    }
    
    setCalcOperation(op);
    setCalcWaitingForOperand(true);
  };

  const calculate = (prev: number, current: number, op: string): number => {
    switch (op) {
      case "+": return prev + current;
      case "-": return prev - current;
      case "×": return prev * current;
      case "÷": return current !== 0 ? prev / current : 0;
      default: return current;
    }
  };

  const handleCalcEquals = () => {
    if (calcPrevValue !== null && calcOperation) {
      const currentValue = parseFloat(calcDisplay);
      const result = calculate(calcPrevValue, currentValue, calcOperation);
      setCalcDisplay(String(result));
      setCalcPrevValue(null);
      setCalcOperation(null);
      setCalcWaitingForOperand(true);
    }
  };

  const handleCalcClear = () => {
    setCalcDisplay("0");
    setCalcPrevValue(null);
    setCalcOperation(null);
    setCalcWaitingForOperand(false);
  };

  const CalcButton = ({ label, onPress, style, textStyle }: { label: string; onPress: () => void; style?: any; textStyle?: any }) => (
    <Pressable
      style={[styles.calcButton, { backgroundColor: theme.backgroundSecondary }, style]}
      onPress={onPress}
    >
      <ThemedText style={[styles.calcButtonText, textStyle]}>{label}</ThemedText>
    </Pressable>
  );

  const renderNoteItem = ({ item }: { item: Note }) => (
    <View style={[styles.noteItem, { backgroundColor: theme.backgroundSecondary }]}>
      <Pressable style={styles.noteContent} onPress={() => handleEditNote(item)}>
        <ThemedText style={styles.noteText} numberOfLines={2}>
          {item.text}
        </ThemedText>
        <ThemedText style={[styles.noteDate, { color: theme.textSecondary }]}>
          {item.createdAt}
        </ThemedText>
      </Pressable>
      <Pressable style={styles.noteDeleteButton} onPress={() => handleDeleteNote(item.id)}>
        <Feather name="trash-2" size={18} color={theme.error} />
      </Pressable>
    </View>
  );

  return (
    <ThemedView style={[styles.container, { backgroundColor: theme.backgroundRoot }]}>
      <View style={[styles.notesSection, { backgroundColor: theme.backgroundDefault }]}>
        <View style={styles.notesHeader}>
          <View style={styles.notesHeaderLeft}>
            <Feather name="edit-3" size={18} color={theme.textSecondary} />
            <ThemedText style={[styles.notesTitle, { color: theme.textSecondary }]}>
              {editingNote ? "Редактирование" : "Новая заметка"}
            </ThemedText>
          </View>
          <View style={styles.notesHeaderRight}>
            <Pressable
              style={[styles.headerButton, { backgroundColor: theme.backgroundSecondary }]}
              onPress={() => setShowFullscreenNote(true)}
            >
              <Feather name="maximize-2" size={18} color={theme.text} />
            </Pressable>
            <Pressable
              style={[styles.headerButton, { backgroundColor: theme.backgroundSecondary }]}
              onPress={() => setShowNotesList(true)}
            >
              <Feather name="list" size={18} color={theme.text} />
              {notes.length > 0 ? (
                <View style={[styles.notesBadge, { backgroundColor: theme.primary }]}>
                  <ThemedText style={styles.notesBadgeText}>{notes.length}</ThemedText>
                </View>
              ) : null}
            </Pressable>
          </View>
        </View>
        <TextInput
          style={[
            styles.notesInput,
            {
              backgroundColor: theme.backgroundSecondary,
              color: theme.text,
            },
          ]}
          value={currentNote}
          onChangeText={setCurrentNote}
          placeholder="Введите текст заметки..."
          placeholderTextColor={theme.textSecondary}
          multiline
          textAlignVertical="top"
          blurOnSubmit={false}
        />
        <View style={styles.notesActions}>
          {editingNote ? (
            <Pressable
              style={[styles.cancelButton, { backgroundColor: theme.backgroundSecondary }]}
              onPress={handleCancelEdit}
            >
              <ThemedText style={{ color: theme.text }}>Отмена</ThemedText>
            </Pressable>
          ) : null}
          <Pressable
            style={[styles.saveButton, { backgroundColor: theme.primary }]}
            onPress={handleSaveNote}
          >
            <Feather name="save" size={16} color="#FFFFFF" />
            <ThemedText style={styles.saveButtonText}>
              {editingNote ? "Обновить" : "Сохранить"}
            </ThemedText>
          </Pressable>
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
            source={{ uri: DATABASE_URL }}
            style={styles.webView}
            startInLoadingState={true}
            javaScriptEnabled={true}
            domStorageEnabled={true}
          />
        )}
      </View>

      <Pressable
        style={[styles.fab, { bottom: insets.bottom + 90 }]}
        onPress={() => setShowCalculator(true)}
      >
        <BlurView intensity={100} tint="dark" style={styles.fabBlur}>
          <Feather name="percent" size={24} color="#FFFFFF" />
        </BlurView>
      </Pressable>

      <Modal
        visible={showFullscreenNote}
        animationType="slide"
        onRequestClose={() => setShowFullscreenNote(false)}
      >
        <TouchableWithoutFeedback onPress={dismissKeyboard}>
          <ThemedView style={[styles.fullscreenContainer, { paddingTop: insets.top, paddingBottom: insets.bottom }]}>
            <View style={styles.fullscreenHeader}>
              <Pressable onPress={() => { dismissKeyboard(); setShowFullscreenNote(false); }}>
                <Feather name="x" size={24} color={theme.text} />
              </Pressable>
              <ThemedText style={styles.fullscreenTitle}>
                {editingNote ? "Редактирование" : "Новая заметка"}
              </ThemedText>
              <Pressable onPress={() => { dismissKeyboard(); handleSaveNote(); }}>
                <Feather name="check" size={24} color={theme.primary} />
              </Pressable>
            </View>
            <TextInput
              style={[
                styles.fullscreenInput,
                {
                  backgroundColor: theme.backgroundSecondary,
                  color: theme.text,
                },
              ]}
              value={currentNote}
              onChangeText={setCurrentNote}
              placeholder="Введите текст заметки..."
              placeholderTextColor={theme.textSecondary}
              multiline
              textAlignVertical="top"
            />
            <View style={styles.fullscreenActions}>
              {editingNote ? (
                <Pressable
                  style={[styles.cancelButton, { backgroundColor: theme.backgroundSecondary, flex: 1 }]}
                  onPress={handleCancelEdit}
                >
                  <ThemedText style={{ color: theme.text }}>Отмена</ThemedText>
                </Pressable>
              ) : null}
              <Pressable
                style={[styles.saveButton, { backgroundColor: theme.primary, flex: 1 }]}
                onPress={handleSaveNote}
              >
                <Feather name="save" size={16} color="#FFFFFF" />
                <ThemedText style={styles.saveButtonText}>
                  {editingNote ? "Обновить" : "Сохранить"}
                </ThemedText>
              </Pressable>
            </View>
          </ThemedView>
        </TouchableWithoutFeedback>
      </Modal>

      <Modal
        visible={showNotesList}
        transparent
        animationType="slide"
        onRequestClose={() => setShowNotesList(false)}
      >
        <Pressable style={styles.modalBackdrop} onPress={() => setShowNotesList(false)}>
          <Pressable
            style={[styles.notesListContainer, { backgroundColor: theme.backgroundDefault }]}
            onPress={(e) => e.stopPropagation()}
          >
            <View style={styles.notesListHeader}>
              <ThemedText style={styles.notesListTitle}>Сохраненные заметки</ThemedText>
              <Pressable onPress={() => setShowNotesList(false)}>
                <Feather name="x" size={24} color={theme.text} />
              </Pressable>
            </View>
            {notes.length === 0 ? (
              <View style={styles.emptyNotes}>
                <Feather name="file-text" size={48} color={theme.textSecondary} />
                <ThemedText style={[styles.emptyNotesText, { color: theme.textSecondary }]}>
                  Нет сохраненных заметок
                </ThemedText>
              </View>
            ) : (
              <FlatList
                data={notes}
                renderItem={renderNoteItem}
                keyExtractor={(item) => item.id}
                contentContainerStyle={styles.notesList}
                showsVerticalScrollIndicator={false}
              />
            )}
          </Pressable>
        </Pressable>
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
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  notesSection: {
    height: 280,
    padding: Spacing.md,
    borderBottomWidth: 1,
    borderBottomColor: "rgba(255,255,255,0.1)",
  },
  notesHeader: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    marginBottom: Spacing.sm,
  },
  notesHeaderLeft: {
    flexDirection: "row",
    alignItems: "center",
  },
  notesHeaderRight: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  notesTitle: {
    marginLeft: Spacing.sm,
    ...Typography.bodySecondary,
  },
  headerButton: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
  },
  notesBadge: {
    marginLeft: Spacing.xs,
    paddingHorizontal: 6,
    paddingVertical: 2,
    borderRadius: 10,
    minWidth: 20,
    alignItems: "center",
  },
  notesBadgeText: {
    color: "#FFFFFF",
    fontSize: 12,
    fontWeight: "600",
  },
  notesInput: {
    flex: 1,
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
    ...Typography.body,
  },
  notesActions: {
    flexDirection: "row",
    justifyContent: "flex-end",
    marginTop: Spacing.sm,
    gap: Spacing.sm,
  },
  saveButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    gap: Spacing.xs,
  },
  saveButtonText: {
    color: "#FFFFFF",
    fontWeight: "600",
  },
  cancelButton: {
    alignItems: "center",
    justifyContent: "center",
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
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
    padding: Spacing.xl,
  },
  webFallbackText: {
    marginTop: Spacing.md,
    textAlign: "center",
    ...Typography.body,
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
  fullscreenContainer: {
    flex: 1,
    padding: Spacing.lg,
  },
  fullscreenHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.lg,
  },
  fullscreenTitle: {
    ...Typography.h3,
  },
  fullscreenInput: {
    flex: 1,
    borderRadius: BorderRadius.md,
    padding: Spacing.lg,
    ...Typography.body,
    fontSize: 18,
  },
  fullscreenActions: {
    flexDirection: "row",
    marginTop: Spacing.lg,
    gap: Spacing.md,
  },
  modalBackdrop: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.6)",
    justifyContent: "flex-end",
  },
  calcModalBackdrop: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.6)",
    justifyContent: "center",
    alignItems: "center",
  },
  notesListContainer: {
    height: "70%",
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    padding: Spacing.lg,
  },
  notesListHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.lg,
  },
  notesListTitle: {
    ...Typography.h3,
  },
  notesList: {
    gap: Spacing.sm,
  },
  noteItem: {
    flexDirection: "row",
    alignItems: "center",
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
  },
  noteContent: {
    flex: 1,
  },
  noteText: {
    ...Typography.body,
    marginBottom: Spacing.xs,
  },
  noteDate: {
    ...Typography.caption,
  },
  noteDeleteButton: {
    padding: Spacing.sm,
  },
  emptyNotes: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  emptyNotesText: {
    marginTop: Spacing.md,
    ...Typography.body,
  },
  calculatorContainer: {
    width: 300,
    borderRadius: BorderRadius.xl,
    padding: Spacing.lg,
  },
  calcHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  calcTitle: {
    ...Typography.h3,
  },
  calcDisplay: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.md,
    alignItems: "flex-end",
    minHeight: 70,
    justifyContent: "center",
  },
  calcDisplayText: {
    fontSize: 32,
    fontWeight: "600",
  },
  calcGrid: {
    gap: Spacing.xs,
  },
  calcRow: {
    flexDirection: "row",
    gap: Spacing.xs,
  },
  calcButton: {
    flex: 1,
    aspectRatio: 1,
    borderRadius: BorderRadius.md,
    justifyContent: "center",
    alignItems: "center",
    maxHeight: 60,
  },
  calcButtonText: {
    fontSize: 22,
    fontWeight: "600",
  },
});
