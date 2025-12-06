import { useState, useEffect, useRef } from "react";
import { View, StyleSheet, TextInput, Pressable, Platform, Modal, ScrollView } from "react-native";
import { WebView } from "react-native-webview";
import { Feather } from "@expo/vector-icons";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { BlurView } from "expo-blur";
import { KeyboardAwareScrollView } from "react-native-keyboard-controller";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { useTheme } from "@/hooks/useTheme";
import { Spacing, BorderRadius, Typography } from "@/constants/theme";

const DATABASE_URL = "http://turburo-kazan.ru/managers/zapis-na-ekskursiyu.php?arrFilter_ff%5BNAME%5D=&arrFilter_DATE_ACTIVE_FROM_1=&arrFilter_DATE_ACTIVE_FROM_2=&arrFilter_pf%5BTYPE%5D=&arrFilter_pf%5BGOSTINICI%5D=&arrFilter_CREATED_BY=&sort=date_ex&USER_REMEMBER=Y&set_filter=Показать&set_filter=Y";
const NOTES_STORAGE_KEY = "@dispatching_notes";

export default function DispatchingScreen() {
  const { theme } = useTheme();
  const insets = useSafeAreaInsets();
  const [notes, setNotes] = useState("");
  const [showCalculator, setShowCalculator] = useState(false);
  const [calcDisplay, setCalcDisplay] = useState("0");
  const [calcPrevValue, setCalcPrevValue] = useState<number | null>(null);
  const [calcOperation, setCalcOperation] = useState<string | null>(null);
  const [calcWaitingForOperand, setCalcWaitingForOperand] = useState(false);
  const [isKeyboardVisible, setIsKeyboardVisible] = useState(false);
  const saveTimeoutRef = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => {
    loadNotes();
  }, []);

  useEffect(() => {
    if (saveTimeoutRef.current) {
      clearTimeout(saveTimeoutRef.current);
    }
    saveTimeoutRef.current = setTimeout(() => {
      saveNotes(notes);
    }, 500);

    return () => {
      if (saveTimeoutRef.current) {
        clearTimeout(saveTimeoutRef.current);
      }
    };
  }, [notes]);

  const loadNotes = async () => {
    try {
      const savedNotes = await AsyncStorage.getItem(NOTES_STORAGE_KEY);
      if (savedNotes !== null) {
        setNotes(savedNotes);
      }
    } catch (error) {
      console.error("Failed to load notes:", error);
    }
  };

  const saveNotes = async (text: string) => {
    try {
      await AsyncStorage.setItem(NOTES_STORAGE_KEY, text);
    } catch (error) {
      console.error("Failed to save notes:", error);
    }
  };

  const handleCalcDigit = (digit: string) => {
    if (calcWaitingForOperand) {
      setCalcDisplay(digit);
      setCalcWaitingForOperand(false);
    } else {
      setCalcDisplay(calcDisplay === "0" ? digit : calcDisplay + digit);
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

  const NotesContent = () => (
    <View style={[styles.notesContainer, { backgroundColor: theme.backgroundDefault }]}>
      <View style={styles.notesHeader}>
        <Feather name="edit-3" size={18} color={theme.textSecondary} />
        <ThemedText style={[styles.notesTitle, { color: theme.textSecondary }]}>Заметки</ThemedText>
      </View>
      <TextInput
        style={[
          styles.notesInput,
          {
            backgroundColor: theme.backgroundSecondary,
            color: theme.text,
          },
        ]}
        value={notes}
        onChangeText={setNotes}
        onFocus={() => setIsKeyboardVisible(true)}
        onBlur={() => setIsKeyboardVisible(false)}
        placeholder="Введите заметки..."
        placeholderTextColor={theme.textSecondary}
        multiline
        textAlignVertical="top"
      />
    </View>
  );

  return (
    <ThemedView style={[styles.container, { backgroundColor: theme.backgroundRoot }]}>
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

      {Platform.OS === "web" ? (
        <ScrollView 
          style={styles.notesScrollContainer}
          contentContainerStyle={{ paddingBottom: insets.bottom + 100 }}
        >
          <NotesContent />
        </ScrollView>
      ) : (
        <KeyboardAwareScrollView
          style={styles.notesScrollContainer}
          contentContainerStyle={{ paddingBottom: insets.bottom + 100 }}
          keyboardShouldPersistTaps="handled"
        >
          <NotesContent />
        </KeyboardAwareScrollView>
      )}

      {!isKeyboardVisible ? (
        <Pressable
          style={[styles.fab, { bottom: insets.bottom + 90 }]}
          onPress={() => setShowCalculator(true)}
        >
          <BlurView intensity={100} tint="dark" style={styles.fabBlur}>
            <Feather name="percent" size={24} color="#FFFFFF" />
          </BlurView>
        </Pressable>
      ) : null}

      <Modal
        visible={showCalculator}
        transparent
        animationType="fade"
        onRequestClose={() => setShowCalculator(false)}
      >
        <Pressable style={styles.modalBackdrop} onPress={() => setShowCalculator(false)}>
          <Pressable style={[styles.calculatorContainer, { backgroundColor: theme.backgroundDefault }]} onPress={(e) => e.stopPropagation()}>
            <View style={styles.calcHeader}>
              <ThemedText style={styles.calcTitle}>Калькулятор</ThemedText>
              <Pressable onPress={() => setShowCalculator(false)}>
                <Feather name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <View style={[styles.calcDisplay, { backgroundColor: theme.backgroundSecondary }]}>
              <ThemedText style={styles.calcDisplayText} numberOfLines={1} adjustsFontSizeToFit>
                {calcDisplay}
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
  webViewContainer: {
    flex: 1,
    borderBottomWidth: 1,
    borderBottomColor: "rgba(255,255,255,0.1)",
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
  notesScrollContainer: {
    flex: 1,
  },
  notesContainer: {
    flex: 1,
    padding: Spacing.md,
  },
  notesHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: Spacing.sm,
  },
  notesTitle: {
    marginLeft: Spacing.sm,
    ...Typography.bodySecondary,
  },
  notesInput: {
    flex: 1,
    minHeight: 120,
    borderRadius: BorderRadius.md,
    padding: Spacing.md,
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
  modalBackdrop: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.6)",
    justifyContent: "center",
    alignItems: "center",
  },
  calculatorContainer: {
    width: 320,
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
    padding: Spacing.lg,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.md,
    alignItems: "flex-end",
  },
  calcDisplayText: {
    fontSize: 36,
    fontWeight: "600",
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
    borderRadius: BorderRadius.md,
    justifyContent: "center",
    alignItems: "center",
  },
  calcButtonText: {
    fontSize: 24,
    fontWeight: "600",
  },
});
