import React, { useState } from "react";
import {
  View,
  TextInput,
  StyleSheet,
  Pressable,
  Alert,
  Platform,
} from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "./ThemedText";
import { ScreenKeyboardAwareScrollView } from "./ScreenKeyboardAwareScrollView";
import { useTheme } from "@/hooks/useTheme";
import { useData, TourType, AdditionalService, Excursion, Expense } from "@/contexts/DataContext";
import { Spacing, BorderRadius, Typography } from "@/constants/theme";
import { Picker } from "@react-native-picker/picker";

interface AddExcursionFormProps {
  excursion?: Excursion;
  onSave: (excursion: Excursion) => void;
  onCancel: () => void;
}

export function AddExcursionForm({ excursion, onSave, onCancel }: AddExcursionFormProps) {
  const { theme } = useTheme();
  const { tourTypes, additionalServices } = useData();

  const [selectedTourType, setSelectedTourType] = useState(
    excursion?.tourTypeId || tourTypes.find((t) => t.isEnabled)?.id || ""
  );
  const [date, setDate] = useState(excursion?.date || new Date().toISOString().split("T")[0]);
  const [fullPrice, setFullPrice] = useState(excursion ? excursion.fullPriceCount.toString() : "");
  const [discounted, setDiscounted] = useState(excursion ? excursion.discountedCount.toString() : "");
  const [free, setFree] = useState(excursion ? excursion.freeCount.toString() : "");
  const [tourPackage, setTourPackage] = useState(excursion ? excursion.tourPackageCount.toString() : "");
  
  const [selectedServices, setSelectedServices] = useState<{ serviceId: string; count: number }[]>(
    excursion?.additionalServices || []
  );
  
  const [expenses, setExpenses] = useState<Expense[]>(
    excursion?.expenses || [
      { id: "guide-default", type: "Экскурсовод", amount: 0, description: "" },
      { id: "prepay-default", type: "Предоплата", amount: 0, description: "" },
    ]
  );

  const toggleService = (serviceId: string) => {
    const exists = selectedServices.find((s) => s.serviceId === serviceId);
    if (exists) {
      setSelectedServices((prev) => prev.filter((s) => s.serviceId !== serviceId));
    } else {
      setSelectedServices((prev) => [...prev, { serviceId, count: 1 }]);
    }
  };

  const updateServiceCount = (serviceId: string, count: number) => {
    if (count <= 0) {
      setSelectedServices((prev) => prev.filter((s) => s.serviceId !== serviceId));
    } else {
      setSelectedServices((prev) =>
        prev.map((s) => (s.serviceId === serviceId ? { ...s, count } : s))
      );
    }
  };

  const addExpense = () => {
    const newExpense: Expense = {
      id: Date.now().toString(),
      type: "Экскурсовод",
      amount: 0,
      description: "",
    };
    setExpenses((prev) => [...prev, newExpense]);
  };

  const updateExpense = (id: string, field: keyof Expense, value: string) => {
    setExpenses((prev) =>
      prev.map((e) => (e.id === id ? { ...e, [field]: value } : e))
    );
  };

  const removeExpense = (id: string) => {
    setExpenses((prev) => prev.filter((e) => e.id !== id));
  };

  const handleSave = () => {
    if (!selectedTourType) {
      Alert.alert("Ошибка", "Выберите тип тура");
      return;
    }

    const selectedTour = tourTypes.find((t) => t.id === selectedTourType);
    if (!selectedTour || !selectedTour.isEnabled) {
      Alert.alert("Ошибка", "Выбранный тип тура недоступен");
      return;
    }

    if (!date) {
      Alert.alert("Ошибка", "Укажите дату");
      return;
    }

    const newExcursion: Excursion = {
      id: excursion?.id || Date.now().toString(),
      tourTypeId: selectedTourType,
      date,
      time: excursion?.time || "",
      fullPriceCount: parseInt(fullPrice, 10) || 0,
      discountedCount: parseInt(discounted, 10) || 0,
      freeCount: parseInt(free, 10) || 0,
      tourPackageCount: parseInt(tourPackage, 10) || 0,
      expenses: expenses.map((e) => ({
        ...e,
        amount: typeof e.amount === "string" ? parseInt(e.amount, 10) || 0 : e.amount,
      })),
      additionalServices: selectedServices,
    };

    onSave(newExcursion);
  };

  return (
    <ScreenKeyboardAwareScrollView contentContainerStyle={styles.content}>
      <View style={styles.section}>
        <ThemedText style={styles.label}>Тип тура</ThemedText>
        <View style={[styles.pickerContainer, { borderColor: theme.inputBorder, backgroundColor: theme.backgroundDefault }]}>
          <Picker
            selectedValue={selectedTourType}
            onValueChange={(value: string) => setSelectedTourType(value)}
            style={[styles.picker, { color: theme.text }]}
          >
            {tourTypes.filter((tour) => tour.isEnabled).map((tour) => (
              <Picker.Item key={tour.id} label={tour.name} value={tour.id} />
            ))}
          </Picker>
        </View>
      </View>

      <View style={styles.section}>
        <ThemedText style={styles.label}>Дата</ThemedText>
        <TextInput
          style={[styles.input, { borderColor: theme.inputBorder, color: theme.text, backgroundColor: theme.backgroundDefault }]}
          value={date}
          onChangeText={setDate}
          placeholder="2025-11-23"
          placeholderTextColor={theme.textSecondary}
        />
      </View>

      <View style={styles.section}>
        <ThemedText style={styles.sectionTitle}>Участники</ThemedText>
        {[
          { label: "Полная оплата", value: fullPrice, setter: setFullPrice },
          { label: "Льготная", value: discounted, setter: setDiscounted },
          { label: "Бесплатные", value: free, setter: setFree },
          { label: "По туру", value: tourPackage, setter: setTourPackage },
        ].map((item, index) => (
          <View key={index} style={styles.inputRow}>
            <ThemedText style={styles.inputLabel}>{item.label}</ThemedText>
            <TextInput
              style={[styles.input, styles.numericInput, { borderColor: theme.inputBorder, color: theme.text, backgroundColor: theme.backgroundDefault }]}
              value={item.value}
              onChangeText={item.setter}
              keyboardType="numeric"
              placeholder="0"
              placeholderTextColor={theme.textSecondary}
            />
          </View>
        ))}
      </View>

      <View style={styles.section}>
        <ThemedText style={styles.sectionTitle}>Дополнительные услуги</ThemedText>
        {additionalServices.map((service) => {
          const selected = selectedServices.find((s) => s.serviceId === service.id);
          return (
            <View key={service.id} style={styles.serviceRow}>
              <Pressable
                onPress={() => toggleService(service.id)}
                style={styles.checkboxRow}
              >
                <View
                  style={[
                    styles.checkbox,
                    { borderColor: theme.inputBorder },
                    selected && { backgroundColor: theme.primary },
                  ]}
                >
                  {selected ? <Feather name="check" size={16} color="#fff" /> : null}
                </View>
                <ThemedText style={styles.serviceLabel}>{service.name}</ThemedText>
              </Pressable>
              {selected ? (
                <View style={styles.stepperControls}>
                  <Pressable
                    onPress={() => updateServiceCount(service.id, selected.count - 1)}
                    style={[styles.stepperButton, { backgroundColor: theme.backgroundSecondary }]}
                  >
                    <Feather name="minus" size={16} color={theme.text} />
                  </Pressable>
                  <ThemedText style={styles.serviceCount}>{selected.count}</ThemedText>
                  <Pressable
                    onPress={() => updateServiceCount(service.id, selected.count + 1)}
                    style={[styles.stepperButton, { backgroundColor: theme.backgroundSecondary }]}
                  >
                    <Feather name="plus" size={16} color={theme.text} />
                  </Pressable>
                </View>
              ) : null}
            </View>
          );
        })}
      </View>

      <View style={styles.section}>
        <View style={styles.sectionHeader}>
          <ThemedText style={styles.sectionTitle}>Расходы</ThemedText>
          <Pressable onPress={addExpense} style={[styles.addButton, { backgroundColor: theme.primary }]}>
            <Feather name="plus" size={16} color="#fff" />
            <ThemedText style={styles.addButtonText}>Добавить</ThemedText>
          </Pressable>
        </View>
        {expenses.map((expense) => (
          <View key={expense.id} style={styles.expenseRow}>
            <View style={styles.expenseInputs}>
              <View style={[styles.pickerContainer, { borderColor: theme.inputBorder, backgroundColor: theme.backgroundDefault, flex: 1 }]}>
                <Picker
                  selectedValue={expense.type}
                  onValueChange={(value: string) => updateExpense(expense.id, "type", value)}
                  style={[styles.picker, { color: theme.text }]}
                >
                  <Picker.Item label="Экскурсовод" value="Экскурсовод" />
                  <Picker.Item label="Предоплата" value="Предоплата" />
                  <Picker.Item label="Прочее" value="Прочее" />
                </Picker>
              </View>
              <TextInput
                style={[styles.expenseAmountInput, { borderColor: theme.inputBorder, color: theme.text, backgroundColor: theme.backgroundDefault }]}
                value={expense.amount.toString()}
                onChangeText={(value) => updateExpense(expense.id, "amount", value)}
                keyboardType="numeric"
                placeholder="Сумма"
                placeholderTextColor={theme.textSecondary}
              />
            </View>
            <Pressable onPress={() => removeExpense(expense.id)} style={styles.removeButton}>
              <Feather name="trash-2" size={20} color={theme.error} />
            </Pressable>
          </View>
        ))}
      </View>

      <View style={styles.footer}>
        <Pressable
          onPress={onCancel}
          style={[styles.button, styles.cancelButton, { backgroundColor: theme.backgroundSecondary }]}
        >
          <ThemedText style={[styles.buttonText, { color: theme.text }]}>Отмена</ThemedText>
        </Pressable>
        <Pressable
          onPress={handleSave}
          style={[styles.button, styles.saveButton, { backgroundColor: theme.primary }]}
        >
          <ThemedText style={[styles.buttonText, styles.saveButtonText]}>Сохранить</ThemedText>
        </Pressable>
      </View>
    </ScreenKeyboardAwareScrollView>
  );
}

const styles = StyleSheet.create({
  content: {
    padding: Spacing.lg,
    paddingBottom: Spacing["5xl"],
  },
  section: {
    marginBottom: Spacing.xl,
  },
  sectionTitle: {
    fontSize: 17,
    fontWeight: "600",
    marginBottom: Spacing.md,
  },
  sectionHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  label: {
    fontSize: Typography.body.fontSize,
    fontWeight: "500",
    marginBottom: Spacing.sm,
  },
  pickerContainer: {
    borderWidth: 1,
    borderRadius: BorderRadius.md,
    overflow: "hidden",
  },
  picker: {
    height: 48,
  },
  row: {
    flexDirection: "row",
    gap: Spacing.md,
    marginBottom: Spacing.lg,
  },
  halfWidth: {
    flex: 1,
  },
  input: {
    borderWidth: 1,
    borderRadius: BorderRadius.md,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    fontSize: Typography.body.fontSize,
    height: 48,
  },
  inputRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  inputLabel: {
    fontSize: Typography.body.fontSize,
    fontWeight: "500",
    flex: 1,
  },
  numericInput: {
    width: 100,
    textAlign: "center" as const,
  },
  stepperRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  stepperLabel: {
    fontSize: Typography.body.fontSize,
    flex: 1,
  },
  stepperControls: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  stepperButton: {
    width: 36,
    height: 36,
    borderRadius: BorderRadius.sm,
    justifyContent: "center",
    alignItems: "center",
  },
  stepperInput: {
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    width: 60,
    height: 36,
    fontSize: Typography.body.fontSize,
  },
  serviceRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  checkboxRow: {
    flexDirection: "row",
    alignItems: "center",
    flex: 1,
  },
  checkbox: {
    width: 24,
    height: 24,
    borderWidth: 2,
    borderRadius: BorderRadius.xs,
    justifyContent: "center",
    alignItems: "center",
    marginRight: Spacing.md,
  },
  serviceLabel: {
    fontSize: Typography.body.fontSize,
  },
  serviceCount: {
    fontSize: Typography.body.fontSize,
    fontWeight: "600",
    minWidth: 30,
    textAlign: "center",
  },
  addButton: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    gap: Spacing.xs,
  },
  addButtonText: {
    color: "#fff",
    fontSize: Typography.small.fontSize,
    fontWeight: "600",
  },
  expenseRow: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: Spacing.md,
    gap: Spacing.sm,
  },
  expenseInputs: {
    flex: 1,
    flexDirection: "row",
    gap: Spacing.sm,
  },
  expenseAmountInput: {
    borderWidth: 1,
    borderRadius: BorderRadius.md,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    fontSize: Typography.body.fontSize,
    height: 48,
    width: 100,
  },
  removeButton: {
    padding: Spacing.sm,
  },
  footer: {
    flexDirection: "row",
    gap: Spacing.md,
    marginTop: Spacing.xl,
  },
  button: {
    flex: 1,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.md,
    justifyContent: "center",
    alignItems: "center",
  },
  cancelButton: {},
  saveButton: {},
  buttonText: {
    fontSize: Typography.body.fontSize,
    fontWeight: "600",
  },
  saveButtonText: {
    color: "#fff",
  },
});
