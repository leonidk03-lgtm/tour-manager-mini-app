import { useState } from "react";
import { View, StyleSheet, Pressable, Modal, TextInput, Alert, Platform } from "react-native";
import { Feather } from "@expo/vector-icons";
import DateTimePicker from "@react-native-community/datetimepicker";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { ScreenKeyboardAwareScrollView } from "@/components/ScreenKeyboardAwareScrollView";
import { StatCard } from "@/components/StatCard";
import { NetworkErrorBanner } from "@/components/NetworkErrorBanner";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, Transaction } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";
import { formatCurrency, calculateAdditionalTransactionsTotal } from "@/utils/calculations";

const parseLocalDate = (dateString: string): Date => {
  const [year, month, day] = dateString.split('-').map(Number);
  return new Date(year, month - 1, day);
};

export default function FinancesScreen() {
  const { theme } = useTheme();
  const { transactions, addTransaction, deleteTransaction } = useData();
  const { isAdmin } = useAuth();
  const [activeTab, setActiveTab] = useState<"expense" | "income">("expense");
  const [selectedDate, setSelectedDate] = useState(new Date().toISOString().split("T")[0]);
  const [showAddModal, setShowAddModal] = useState(false);
  const [formType, setFormType] = useState<"income" | "expense">("expense");
  const [formDescription, setFormDescription] = useState("");
  const [formAmount, setFormAmount] = useState("");
  const [formDate, setFormDate] = useState(new Date().toISOString().split("T")[0]);
  const [showFilterDatePicker, setShowFilterDatePicker] = useState(false);
  const [showFormDatePicker, setShowFormDatePicker] = useState(false);
  const [isSaving, setIsSaving] = useState(false);
  
  const filterDateValue = parseLocalDate(selectedDate);
  const formDateValue = parseLocalDate(formDate);
  
  const handleFilterDateChange = (event: any, date?: Date) => {
    if (Platform.OS === "android") {
      setShowFilterDatePicker(false);
    }
    if (date) {
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, "0");
      const day = String(date.getDate()).padStart(2, "0");
      setSelectedDate(`${year}-${month}-${day}`);
    }
  };
  
  const handleFormDateChange = (event: any, date?: Date) => {
    if (Platform.OS === "android") {
      setShowFormDatePicker(false);
    }
    if (date) {
      const year = date.getFullYear();
      const month = String(date.getMonth() + 1).padStart(2, "0");
      const day = String(date.getDate()).padStart(2, "0");
      setFormDate(`${year}-${month}-${day}`);
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

  const transactionsForSelectedDate = transactions.filter((t) => t.date === selectedDate);
  const totalExpenses = calculateAdditionalTransactionsTotal(transactionsForSelectedDate, "expense");
  const totalIncome = calculateAdditionalTransactionsTotal(transactionsForSelectedDate, "income");

  const filteredTransactions = transactionsForSelectedDate
    .filter((t) => t.type === activeTab)
    .sort((a, b) => b.date.localeCompare(a.date));

  const handleAddTransaction = async () => {
    if (!formDescription || !formAmount || !formDate) {
      Alert.alert("Ошибка", "Заполните все поля");
      return;
    }

    const amount = parseInt(formAmount, 10);
    if (isNaN(amount) || amount <= 0) {
      Alert.alert("Ошибка", "Введите корректную сумму");
      return;
    }

    if (isSaving) return;
    setIsSaving(true);

    try {
      await addTransaction({
        type: formType,
        amount,
        description: formDescription,
        date: formDate,
      });
      setSelectedDate(formDate);
      setShowAddModal(false);
      setFormDescription("");
      setFormAmount("");
      setFormDate(new Date().toISOString().split("T")[0]);
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось сохранить запись");
    } finally {
      setIsSaving(false);
    }
  };

  const handleDeleteTransaction = (id: string) => {
    Alert.alert("Удалить запись?", "Это действие нельзя будет отменить", [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: async () => {
          try {
            await deleteTransaction(id);
          } catch (err) {
            Alert.alert("Ошибка", "Не удалось удалить запись");
          }
        },
      },
    ]);
  };

  return (
    <>
      <ScreenScrollView>
        <NetworkErrorBanner />
        <View style={styles.container}>
          <View style={styles.section}>
            <View style={styles.statsGrid}>
              <StatCard title="Доп. расходы" value={formatCurrency(totalExpenses)} color="error" />
              <StatCard title="Доп. доходы" value={formatCurrency(totalIncome)} color="success" />
            </View>
          </View>

          <View style={styles.section}>
            <Pressable
              onPress={() => setShowFilterDatePicker(true)}
              style={[
                styles.dateFilter,
                {
                  backgroundColor: theme.backgroundSecondary,
                  borderRadius: BorderRadius.xs,
                },
              ]}
            >
              <Feather name="calendar" size={20} color={theme.textSecondary} />
              <ThemedText style={[styles.dateInput, { color: theme.text }]}>
                {formatDisplayDate(selectedDate)}
              </ThemedText>
            </Pressable>
            {showFilterDatePicker ? (
              Platform.OS === "ios" ? (
                <Modal
                  visible={showFilterDatePicker}
                  transparent
                  animationType="fade"
                  onRequestClose={() => setShowFilterDatePicker(false)}
                >
                  <View style={styles.dateModalOverlay}>
                    <Pressable style={styles.dateModalBackdrop} onPress={() => setShowFilterDatePicker(false)} />
                    <ThemedView style={[styles.datePickerModal, { backgroundColor: theme.backgroundDefault }]}>
                      <View style={styles.datePickerHeader}>
                        <ThemedText style={styles.datePickerTitle}>Выберите дату</ThemedText>
                        <Pressable onPress={() => setShowFilterDatePicker(false)}>
                          <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>Готово</ThemedText>
                        </Pressable>
                      </View>
                      <DateTimePicker
                        value={filterDateValue}
                        mode="date"
                        display="spinner"
                        onChange={handleFilterDateChange}
                        locale="ru"
                      />
                    </ThemedView>
                  </View>
                </Modal>
              ) : (
                <DateTimePicker
                  value={filterDateValue}
                  mode="date"
                  display="default"
                  onChange={handleFilterDateChange}
                />
              )
            ) : null}
          </View>

          <View style={styles.section}>
            <View style={styles.tabs}>
              <Pressable
                onPress={() => setActiveTab("expense")}
                style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1, flex: 1 })}
              >
                <ThemedView
                  style={[
                    styles.tab,
                    {
                      backgroundColor:
                        activeTab === "expense" ? theme.primary : theme.backgroundDefault,
                      borderColor: theme.border,
                      borderRadius: BorderRadius.xs,
                    },
                  ]}
                >
                  <ThemedText
                    style={[
                      styles.tabText,
                      {
                        color: activeTab === "expense" ? theme.buttonText : theme.text,
                      },
                    ]}
                  >
                    Расходы
                  </ThemedText>
                </ThemedView>
              </Pressable>
              <Pressable
                onPress={() => setActiveTab("income")}
                style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1, flex: 1 })}
              >
                <ThemedView
                  style={[
                    styles.tab,
                    {
                      backgroundColor:
                        activeTab === "income" ? theme.primary : theme.backgroundDefault,
                      borderColor: theme.border,
                      borderRadius: BorderRadius.xs,
                    },
                  ]}
                >
                  <ThemedText
                    style={[
                      styles.tabText,
                      {
                        color: activeTab === "income" ? theme.buttonText : theme.text,
                      },
                    ]}
                  >
                    Доходы
                  </ThemedText>
                </ThemedView>
              </Pressable>
            </View>
          </View>

          {filteredTransactions.length > 0 ? (
            <View style={styles.section}>
              <View style={styles.transactionsList}>
                {filteredTransactions.map((transaction) => (
                  <ThemedView
                    key={transaction.id}
                    style={[
                      styles.transactionCard,
                      {
                        borderColor: theme.border,
                        borderRadius: BorderRadius.sm,
                      },
                    ]}
                  >
                    <View style={styles.transactionMain}>
                      <View style={styles.transactionInfo}>
                        <ThemedText style={styles.transactionDescription}>
                          {transaction.description}
                        </ThemedText>
                        <ThemedText style={[styles.transactionDate, { color: theme.textSecondary }]}>
                          {new Date(transaction.date).toLocaleDateString("ru-RU")}
                          {isAdmin && transaction.managerName ? ` • ${transaction.managerName}` : ""}
                        </ThemedText>
                      </View>
                      <ThemedText
                        style={[
                          styles.transactionAmount,
                          {
                            color: transaction.type === "income" ? theme.success : theme.error,
                          },
                        ]}
                      >
                        {transaction.type === "income" ? "+" : "-"}
                        {formatCurrency(transaction.amount)}
                      </ThemedText>
                    </View>
                    <Pressable
                      onPress={() => handleDeleteTransaction(transaction.id)}
                      style={({ pressed }) => ({
                        opacity: pressed ? 0.7 : 1,
                        padding: Spacing.sm,
                      })}
                    >
                      <Feather name="trash-2" size={18} color={theme.error} />
                    </Pressable>
                  </ThemedView>
                ))}
              </View>
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
              <Feather name="inbox" size={48} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                Нет записей
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
        onPress={() => {
          setFormType(activeTab);
          setShowAddModal(true);
        }}
      >
        <Feather name="plus" size={24} color={theme.buttonText} />
      </Pressable>

      <Modal visible={showAddModal} animationType="slide" presentationStyle="pageSheet">
        <ThemedView style={[styles.modalContainer, { backgroundColor: theme.backgroundRoot }]}>
          <View style={[styles.modalHeader, { borderBottomColor: theme.border }]}>
            <Pressable
              onPress={() => {
                setShowAddModal(false);
                setFormDescription("");
                setFormAmount("");
                setFormDate(new Date().toISOString().split("T")[0]);
              }}
              style={styles.modalButton}
            >
              <ThemedText style={{ color: theme.primary }}>Отмена</ThemedText>
            </Pressable>
            <ThemedText style={styles.modalTitle}>
              {formType === "expense" ? "Новый расход" : "Новый доход"}
            </ThemedText>
            <Pressable onPress={handleAddTransaction} style={styles.modalButton}>
              <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>Сохранить</ThemedText>
            </Pressable>
          </View>
          <ScreenKeyboardAwareScrollView>
            <View style={styles.modalContent}>
              <View style={styles.formGroup}>
                <ThemedText style={styles.label}>Описание</ThemedText>
                <TextInput
                  style={[
                    styles.input,
                    {
                      borderColor: theme.inputBorder,
                      color: theme.text,
                      backgroundColor: theme.backgroundDefault,
                    },
                  ]}
                  placeholder="Например: Вильдану"
                  placeholderTextColor={theme.textSecondary}
                  value={formDescription}
                  onChangeText={setFormDescription}
                />
              </View>
              <View style={styles.formGroup}>
                <ThemedText style={styles.label}>Сумма (₽)</ThemedText>
                <TextInput
                  style={[
                    styles.input,
                    {
                      borderColor: theme.inputBorder,
                      color: theme.text,
                      backgroundColor: theme.backgroundDefault,
                    },
                  ]}
                  placeholder="0"
                  placeholderTextColor={theme.textSecondary}
                  keyboardType="numeric"
                  value={formAmount}
                  onChangeText={setFormAmount}
                />
              </View>
              <View style={styles.formGroup}>
                <ThemedText style={styles.label}>Дата</ThemedText>
                <Pressable
                  onPress={() => setShowFormDatePicker(true)}
                  style={[
                    styles.dateButton,
                    {
                      borderColor: theme.inputBorder,
                      backgroundColor: theme.backgroundDefault,
                    },
                  ]}
                >
                  <Feather name="calendar" size={20} color={theme.textSecondary} style={{ marginRight: Spacing.sm }} />
                  <ThemedText style={{ color: theme.text, fontSize: 16 }}>
                    {formatDisplayDate(formDate)}
                  </ThemedText>
                </Pressable>
                {showFormDatePicker ? (
                  Platform.OS === "ios" ? (
                    <Modal
                      visible={showFormDatePicker}
                      transparent
                      animationType="fade"
                      onRequestClose={() => setShowFormDatePicker(false)}
                    >
                      <View style={styles.dateModalOverlay}>
                        <Pressable style={styles.dateModalBackdrop} onPress={() => setShowFormDatePicker(false)} />
                        <ThemedView style={[styles.datePickerModal, { backgroundColor: theme.backgroundDefault }]}>
                          <View style={styles.datePickerHeader}>
                            <ThemedText style={styles.datePickerTitle}>Выберите дату</ThemedText>
                            <Pressable onPress={() => setShowFormDatePicker(false)}>
                              <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>Готово</ThemedText>
                            </Pressable>
                          </View>
                          <DateTimePicker
                            value={formDateValue}
                            mode="date"
                            display="spinner"
                            onChange={handleFormDateChange}
                            locale="ru"
                          />
                        </ThemedView>
                      </View>
                    </Modal>
                  ) : (
                    <DateTimePicker
                      value={formDateValue}
                      mode="date"
                      display="default"
                      onChange={handleFormDateChange}
                    />
                  )
                ) : null}
              </View>
            </View>
          </ScreenKeyboardAwareScrollView>
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
  statsGrid: {
    flexDirection: "row",
    gap: Spacing.md,
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
  tabs: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  tab: {
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.lg,
    borderWidth: 1,
    alignItems: "center",
  },
  tabText: {
    fontSize: 14,
    fontWeight: "500",
  },
  transactionsList: {
    gap: Spacing.md,
  },
  transactionCard: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    padding: Spacing.lg,
    borderWidth: 1,
  },
  transactionMain: {
    flex: 1,
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginRight: Spacing.md,
  },
  transactionInfo: {
    flex: 1,
    gap: Spacing.xs,
  },
  transactionDescription: {
    fontSize: 16,
    fontWeight: "500",
  },
  transactionDate: {
    fontSize: 14,
  },
  transactionAmount: {
    fontSize: 16,
    fontWeight: "700",
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
    gap: Spacing.lg,
  },
  formGroup: {
    gap: Spacing.sm,
  },
  label: {
    fontSize: 14,
    fontWeight: "500",
  },
  input: {
    borderWidth: 1,
    borderRadius: BorderRadius.xs,
    padding: Spacing.md,
    fontSize: 16,
  },
  dateButton: {
    flexDirection: "row",
    alignItems: "center",
    borderWidth: 1,
    borderRadius: BorderRadius.xs,
    padding: Spacing.md,
  },
  dateModalOverlay: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  dateModalBackdrop: {
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
  datePickerTitle: {
    fontSize: 17,
    fontWeight: "600",
  },
});
