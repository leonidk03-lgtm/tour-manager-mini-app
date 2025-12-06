import React, { useState } from "react";
import {
  View,
  TextInput,
  StyleSheet,
  Pressable,
  Alert,
  Platform,
  Modal,
  FlatList,
} from "react-native";
import { Feather } from "@expo/vector-icons";
import DateTimePicker from "@react-native-community/datetimepicker";
import { ThemedText } from "./ThemedText";
import { ThemedView } from "./ThemedView";
import { ScreenKeyboardAwareScrollView } from "./ScreenKeyboardAwareScrollView";
import { useTheme } from "@/hooks/useTheme";
import { useData, Excursion, Expense } from "@/contexts/DataContext";
import { Spacing, BorderRadius, Typography } from "@/constants/theme";

interface AddExcursionFormProps {
  excursion?: Excursion;
  onSave: (excursion: Excursion) => void;
  onCancel: () => void;
}

export function AddExcursionForm({ excursion, onSave, onCancel }: AddExcursionFormProps) {
  const { theme } = useTheme();
  const { tourTypes, additionalServices } = useData();

  const enabledTourTypes = tourTypes.filter((t) => t.isEnabled);

  const [selectedTourType, setSelectedTourType] = useState(
    excursion?.tourTypeId || enabledTourTypes[0]?.id || ""
  );
  const [dateValue, setDateValue] = useState(() => {
    if (excursion?.date) {
      return new Date(excursion.date);
    }
    return new Date();
  });
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [showTourTypePicker, setShowTourTypePicker] = useState(false);

  const [totalParticipants, setTotalParticipants] = useState(() => {
    if (excursion) {
      const total = excursion.fullPriceCount + excursion.discountedCount + excursion.freeCount + excursion.tourPackageCount + (excursion.byTourCount || 0) + (excursion.paidCount || 0);
      return total.toString();
    }
    return "";
  });
  const [discounted, setDiscounted] = useState(excursion ? excursion.discountedCount.toString() : "");
  const [free, setFree] = useState(excursion ? excursion.freeCount.toString() : "");
  const [tourPackage, setTourPackage] = useState(excursion ? excursion.tourPackageCount.toString() : "");
  const [byTour, setByTour] = useState(excursion ? (excursion.byTourCount || 0).toString() : "");
  const [paid, setPaid] = useState(excursion ? (excursion.paidCount || 0).toString() : "");
  
  const [selectedServices, setSelectedServices] = useState<{ serviceId: string; count: number }[]>(
    excursion?.additionalServices || []
  );
  
  const [expenses, setExpenses] = useState<Expense[]>(
    excursion?.expenses || [
      { id: "guide-default", type: "Экскурсовод", amount: 0, description: "" },
      { id: "prepay-default", type: "Предоплата", amount: 0, description: "" },
    ]
  );
  const [showExpenseTypePicker, setShowExpenseTypePicker] = useState<string | null>(null);

  const calculateFullPrice = () => {
    const total = parseInt(totalParticipants, 10) || 0;
    const disc = parseInt(discounted, 10) || 0;
    const freeCount = parseInt(free, 10) || 0;
    const tour = parseInt(tourPackage, 10) || 0;
    const byTourCount = parseInt(byTour, 10) || 0;
    const paidCount = parseInt(paid, 10) || 0;
    return Math.max(0, total - disc - freeCount - tour - byTourCount - paidCount);
  };

  const toggleService = (serviceId: string) => {
    const exists = selectedServices.find((s) => s.serviceId === serviceId);
    if (exists) {
      setSelectedServices((prev) => prev.filter((s) => s.serviceId !== serviceId));
    } else {
      setSelectedServices((prev) => [...prev, { serviceId, count: 0 }]);
    }
  };

  const updateServiceCount = (serviceId: string, countStr: string) => {
    const count = countStr === "" ? 0 : parseInt(countStr, 10) || 0;
    setSelectedServices((prev) =>
      prev.map((s) => (s.serviceId === serviceId ? { ...s, count } : s))
    );
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

  const formatDate = (d: Date) => {
    const day = d.getDate().toString().padStart(2, "0");
    const month = (d.getMonth() + 1).toString().padStart(2, "0");
    const year = d.getFullYear();
    return `${day}.${month}.${year}`;
  };

  const handleDateChange = (event: any, selectedDate?: Date) => {
    if (Platform.OS === "android") {
      setShowDatePicker(false);
    }
    if (selectedDate) {
      setDateValue(selectedDate);
    }
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

    const dateString = dateValue.toISOString().split("T")[0];

    const newExcursion: Excursion = {
      id: excursion?.id || Date.now().toString(),
      tourTypeId: selectedTourType,
      date: dateString,
      time: excursion?.time || "",
      fullPriceCount: calculateFullPrice(),
      discountedCount: parseInt(discounted, 10) || 0,
      freeCount: parseInt(free, 10) || 0,
      tourPackageCount: parseInt(tourPackage, 10) || 0,
      byTourCount: parseInt(byTour, 10) || 0,
      paidCount: parseInt(paid, 10) || 0,
      expenses: expenses.map((e) => ({
        ...e,
        amount: typeof e.amount === "string" ? parseInt(e.amount, 10) || 0 : e.amount,
      })),
      additionalServices: selectedServices,
    };

    onSave(newExcursion);
  };

  const selectedTourName = enabledTourTypes.find((t) => t.id === selectedTourType)?.name || "Выберите тур";

  const expenseTypes = ["Экскурсовод", "Предоплата", "Прочее"];

  return (
    <ScreenKeyboardAwareScrollView contentContainerStyle={styles.content}>
      <View style={styles.section}>
        <ThemedText style={styles.label}>Тип тура</ThemedText>
        <Pressable
          onPress={() => setShowTourTypePicker(true)}
          style={[styles.selectButton, { borderColor: theme.inputBorder, backgroundColor: theme.backgroundDefault }]}
        >
          <ThemedText style={styles.selectButtonText}>{selectedTourName}</ThemedText>
          <Feather name="chevron-down" size={20} color={theme.textSecondary} />
        </Pressable>
      </View>

      <Modal
        visible={showTourTypePicker}
        transparent
        animationType="fade"
        onRequestClose={() => setShowTourTypePicker(false)}
      >
        <View style={styles.modalOverlay}>
          <Pressable style={styles.modalBackdrop} onPress={() => setShowTourTypePicker(false)} />
          <ThemedView style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
            <ThemedText style={styles.modalTitle}>Выберите тип тура</ThemedText>
            <FlatList
              data={enabledTourTypes}
              keyExtractor={(item) => item.id}
              style={styles.modalList}
              renderItem={({ item }) => (
                <Pressable
                  onPress={() => {
                    setSelectedTourType(item.id);
                    setShowTourTypePicker(false);
                  }}
                  style={[
                    styles.modalItem,
                    item.id === selectedTourType && { backgroundColor: theme.primary + "20" },
                  ]}
                >
                  <ThemedText style={styles.modalItemText}>{item.name}</ThemedText>
                  {item.id === selectedTourType ? (
                    <Feather name="check" size={20} color={theme.primary} />
                  ) : null}
                </Pressable>
              )}
            />
          </ThemedView>
        </View>
      </Modal>

      <View style={styles.section}>
        <ThemedText style={styles.label}>Дата</ThemedText>
        <Pressable
          onPress={() => setShowDatePicker(true)}
          style={[styles.selectButton, { borderColor: theme.inputBorder, backgroundColor: theme.backgroundDefault }]}
        >
          <Feather name="calendar" size={20} color={theme.textSecondary} style={{ marginRight: Spacing.sm }} />
          <ThemedText style={styles.selectButtonText}>{formatDate(dateValue)}</ThemedText>
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

      <View style={styles.section}>
        <ThemedText style={styles.sectionTitle}>Участники</ThemedText>
        <View style={styles.inputRow}>
          <ThemedText style={styles.inputLabel}>Всего участников</ThemedText>
          <TextInput
            style={[styles.input, styles.numericInput, { borderColor: theme.inputBorder, color: theme.text, backgroundColor: theme.backgroundDefault }]}
            value={totalParticipants}
            onChangeText={setTotalParticipants}
            keyboardType="numeric"
            placeholder="0"
            placeholderTextColor={theme.textSecondary}
          />
        </View>
        <ThemedText style={[styles.subLabel, { color: theme.textSecondary }]}>Из них:</ThemedText>
        {[
          { label: "Льготных", value: discounted, setter: setDiscounted },
          { label: "Бесплатных", value: free, setter: setFree },
          { label: "По туру", value: byTour, setter: setByTour },
          { label: "Оплаченных", value: paid, setter: setPaid },
        ].map((item, index) => (
          <View key={index} style={styles.inputRow}>
            <ThemedText style={[styles.inputLabel, styles.subInputLabel]}>{item.label}</ThemedText>
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
        <View style={[styles.summaryRow, { borderTopColor: theme.inputBorder }]}>
          <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>Полная оплата (авто)</ThemedText>
          <ThemedText style={[styles.summaryValue, { color: theme.primary }]}>{calculateFullPrice()}</ThemedText>
        </View>
      </View>

      {(() => {
        const currentTourType = tourTypes.find((t) => t.id === selectedTourType);
        const applicableIds = currentTourType?.applicableServiceIds || [];
        const availableServices = additionalServices.filter(
          (s) => s.isEnabled && applicableIds.includes(s.id)
        );
        
        if (availableServices.length === 0) return null;
        
        return (
          <View style={styles.section}>
            <ThemedText style={styles.sectionTitle}>Дополнительные услуги</ThemedText>
            {availableServices.map((service) => {
              const selected = selectedServices.find((s) => s.serviceId === service.id);
              const isNegativePrice = service.price < 0;
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
                        selected && { backgroundColor: isNegativePrice ? theme.error : theme.primary },
                      ]}
                    >
                      {selected ? <Feather name="check" size={16} color="#fff" /> : null}
                    </View>
                    <View style={styles.serviceLabelContainer}>
                      <ThemedText style={styles.serviceLabel}>{service.name}</ThemedText>
                      <ThemedText style={[styles.servicePrice, { color: isNegativePrice ? theme.error : theme.success }]}>
                        {isNegativePrice ? service.price : `+${service.price}`} р.
                      </ThemedText>
                    </View>
                  </Pressable>
                  {selected ? (
                    <TextInput
                      style={[styles.serviceCountInput, { borderColor: theme.inputBorder, color: theme.text, backgroundColor: theme.backgroundDefault }]}
                      value={selected.count === 0 ? "" : selected.count.toString()}
                      onChangeText={(text) => updateServiceCount(service.id, text)}
                      keyboardType="numeric"
                      placeholder="Кол-во"
                      placeholderTextColor={theme.textSecondary}
                    />
                  ) : null}
                </View>
              );
            })}
          </View>
        );
      })()}

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
              <Pressable
                onPress={() => setShowExpenseTypePicker(expense.id)}
                style={[styles.expenseTypeButton, { borderColor: theme.inputBorder, backgroundColor: theme.backgroundDefault }]}
              >
                <ThemedText style={styles.expenseTypeText}>{expense.type}</ThemedText>
                <Feather name="chevron-down" size={16} color={theme.textSecondary} />
              </Pressable>
              <TextInput
                style={[styles.expenseAmountInput, { borderColor: theme.inputBorder, color: theme.text, backgroundColor: theme.backgroundDefault }]}
                value={Number(expense.amount) === 0 ? "" : expense.amount.toString()}
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

      <Modal
        visible={showExpenseTypePicker !== null}
        transparent
        animationType="fade"
        onRequestClose={() => setShowExpenseTypePicker(null)}
      >
        <View style={styles.modalOverlay}>
          <Pressable style={styles.modalBackdrop} onPress={() => setShowExpenseTypePicker(null)} />
          <ThemedView style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
            <ThemedText style={styles.modalTitle}>Тип расхода</ThemedText>
            {expenseTypes.map((type) => (
              <Pressable
                key={type}
                onPress={() => {
                  if (showExpenseTypePicker) {
                    updateExpense(showExpenseTypePicker, "type", type);
                  }
                  setShowExpenseTypePicker(null);
                }}
                style={styles.modalItem}
              >
                <ThemedText style={styles.modalItemText}>{type}</ThemedText>
              </Pressable>
            ))}
          </ThemedView>
        </View>
      </Modal>

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
  subLabel: {
    fontSize: Typography.caption.fontSize,
    marginBottom: Spacing.sm,
    marginTop: Spacing.sm,
  },
  selectButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    borderWidth: 1,
    borderRadius: BorderRadius.md,
    paddingHorizontal: Spacing.md,
    height: 48,
  },
  selectButtonText: {
    fontSize: Typography.body.fontSize,
    flex: 1,
  },
  modalOverlay: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    padding: Spacing.xl,
  },
  modalBackdrop: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "rgba(0,0,0,0.5)",
  },
  modalList: {
    maxHeight: 300,
  },
  modalContent: {
    width: "100%",
    maxHeight: 400,
    borderRadius: BorderRadius.lg,
    padding: Spacing.lg,
  },
  modalTitle: {
    fontSize: 17,
    fontWeight: "600",
    marginBottom: Spacing.md,
  },
  modalItem: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.sm,
    borderRadius: BorderRadius.sm,
  },
  modalItemText: {
    fontSize: Typography.body.fontSize,
  },
  datePickerModal: {
    width: "100%",
    borderRadius: BorderRadius.lg,
    padding: Spacing.lg,
  },
  datePickerHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
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
  subInputLabel: {
    paddingLeft: Spacing.md,
  },
  numericInput: {
    width: 100,
    textAlign: "center" as const,
  },
  summaryRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingTop: Spacing.md,
    marginTop: Spacing.sm,
    borderTopWidth: 1,
  },
  summaryValue: {
    fontSize: Typography.body.fontSize,
    fontWeight: "600",
    width: 100,
    textAlign: "center",
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
  serviceLabelContainer: {
    flex: 1,
  },
  serviceLabel: {
    fontSize: Typography.body.fontSize,
  },
  servicePrice: {
    fontSize: Typography.caption.fontSize,
  },
  serviceCountInput: {
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    width: 60,
    height: 40,
    textAlign: "center",
    fontSize: Typography.body.fontSize,
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
  expenseTypeButton: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    borderWidth: 1,
    borderRadius: BorderRadius.md,
    paddingHorizontal: Spacing.md,
    height: 48,
  },
  expenseTypeText: {
    fontSize: Typography.body.fontSize,
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
