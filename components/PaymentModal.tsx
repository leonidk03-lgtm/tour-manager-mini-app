import { useState } from "react";
import {
  View,
  StyleSheet,
  Modal,
  Pressable,
  TextInput,
  KeyboardAvoidingView,
  Platform,
  ScrollView,
} from "react-native";
import { ThemedText } from "@/components/ThemedText";
import { Icon } from "@/components/Icon";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { hapticFeedback } from "@/utils/haptics";

type PaymentMethod = "cash" | "card" | "transfer";

interface PaymentModalProps {
  visible: boolean;
  onClose: () => void;
  onSubmit: (data: { amount: number; method: PaymentMethod; notes: string }) => Promise<void>;
  orderTotal: number;
  totalPaid: number;
  clientName: string;
  orderNumber: number;
}

const PAYMENT_METHODS: { key: PaymentMethod; label: string; icon: string }[] = [
  { key: "cash", label: "Наличные", icon: "dollar-sign" },
  { key: "card", label: "Карта", icon: "credit-card" },
  { key: "transfer", label: "Перевод", icon: "send" },
];

export function PaymentModal({
  visible,
  onClose,
  onSubmit,
  orderTotal,
  totalPaid,
  clientName,
  orderNumber,
}: PaymentModalProps) {
  const { theme } = useTheme();
  const remainingAmount = orderTotal - totalPaid;

  const [amount, setAmount] = useState(remainingAmount.toString());
  const [method, setMethod] = useState<PaymentMethod>("cash");
  const [notes, setNotes] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async () => {
    const numAmount = parseFloat(amount) || 0;
    if (numAmount <= 0) {
      hapticFeedback.error();
      return;
    }

    setIsSubmitting(true);
    try {
      await onSubmit({ amount: numAmount, method, notes });
      hapticFeedback.success();
      setAmount(remainingAmount.toString());
      setMethod("cash");
      setNotes("");
    } catch (error) {
      hapticFeedback.error();
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleClose = () => {
    setAmount(remainingAmount.toString());
    setMethod("cash");
    setNotes("");
    onClose();
  };

  return (
    <Modal
      visible={visible}
      transparent
      animationType="slide"
      onRequestClose={handleClose}
    >
      <KeyboardAvoidingView
        behavior={Platform.OS === "ios" ? "padding" : "height"}
        style={styles.modalOverlay}
      >
        <Pressable style={styles.backdrop} onPress={handleClose} />
        <View style={[styles.modalContent, { backgroundColor: theme.backgroundSecondary }]}>
          <View style={styles.header}>
            <ThemedText style={styles.title}>Оплата заказа #{orderNumber}</ThemedText>
            <Pressable onPress={handleClose} hitSlop={8}>
              <Icon name="x" size={24} color={theme.textSecondary} />
            </Pressable>
          </View>

          <ScrollView style={styles.scrollContent} showsVerticalScrollIndicator={false}>
            <View style={[styles.infoCard, { backgroundColor: theme.backgroundDefault }]}>
              <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>
                Клиент
              </ThemedText>
              <ThemedText style={styles.infoValue}>{clientName}</ThemedText>
            </View>

            <View style={styles.amountsRow}>
              <View style={[styles.amountCard, { backgroundColor: theme.backgroundDefault }]}>
                <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>
                  Итого
                </ThemedText>
                <ThemedText style={styles.amountValue}>
                  {orderTotal.toLocaleString("ru-RU")} ₽
                </ThemedText>
              </View>
              <View style={[styles.amountCard, { backgroundColor: theme.backgroundDefault }]}>
                <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>
                  Оплачено
                </ThemedText>
                <ThemedText style={[styles.amountValue, { color: theme.success }]}>
                  {totalPaid.toLocaleString("ru-RU")} ₽
                </ThemedText>
              </View>
              <View style={[styles.amountCard, { backgroundColor: theme.backgroundDefault }]}>
                <ThemedText style={[styles.infoLabel, { color: theme.textSecondary }]}>
                  Остаток
                </ThemedText>
                <ThemedText style={[styles.amountValue, { color: theme.primary }]}>
                  {remainingAmount.toLocaleString("ru-RU")} ₽
                </ThemedText>
              </View>
            </View>

            <View style={styles.inputGroup}>
              <ThemedText style={styles.inputLabel}>Сумма оплаты</ThemedText>
              <TextInput
                style={[
                  styles.input,
                  { backgroundColor: theme.backgroundDefault, color: theme.text },
                ]}
                value={amount}
                onChangeText={setAmount}
                keyboardType="numeric"
                placeholder="0"
                placeholderTextColor={theme.textSecondary}
              />
            </View>

            <View style={styles.inputGroup}>
              <ThemedText style={styles.inputLabel}>Способ оплаты</ThemedText>
              <View style={styles.methodsRow}>
                {PAYMENT_METHODS.map((m) => (
                  <Pressable
                    key={m.key}
                    onPress={() => {
                      hapticFeedback.selection();
                      setMethod(m.key);
                    }}
                    style={[
                      styles.methodButton,
                      {
                        backgroundColor:
                          method === m.key ? theme.primary : theme.backgroundDefault,
                      },
                    ]}
                  >
                    <Icon
                      name={m.icon as any}
                      size={20}
                      color={method === m.key ? "#FFFFFF" : theme.textSecondary}
                    />
                    <ThemedText
                      style={[
                        styles.methodLabel,
                        { color: method === m.key ? "#FFFFFF" : theme.text },
                      ]}
                    >
                      {m.label}
                    </ThemedText>
                  </Pressable>
                ))}
              </View>
            </View>

            <View style={styles.inputGroup}>
              <ThemedText style={styles.inputLabel}>Примечание (опционально)</ThemedText>
              <TextInput
                style={[
                  styles.input,
                  styles.multilineInput,
                  { backgroundColor: theme.backgroundDefault, color: theme.text },
                ]}
                value={notes}
                onChangeText={setNotes}
                placeholder="Комментарий к оплате..."
                placeholderTextColor={theme.textSecondary}
                multiline
                numberOfLines={3}
              />
            </View>
          </ScrollView>

          <View style={styles.footer}>
            <Pressable
              onPress={handleClose}
              style={[styles.cancelButton, { backgroundColor: theme.backgroundDefault }]}
            >
              <ThemedText style={styles.cancelButtonText}>Отмена</ThemedText>
            </Pressable>
            <Pressable
              onPress={handleSubmit}
              disabled={isSubmitting}
              style={[
                styles.submitButton,
                { backgroundColor: theme.success, opacity: isSubmitting ? 0.7 : 1 },
              ]}
            >
              <Icon name="check" size={20} color="#FFFFFF" />
              <ThemedText style={styles.submitButtonText}>
                {isSubmitting ? "Сохранение..." : "Подтвердить оплату"}
              </ThemedText>
            </Pressable>
          </View>
        </View>
      </KeyboardAvoidingView>
    </Modal>
  );
}

const styles = StyleSheet.create({
  modalOverlay: {
    flex: 1,
    justifyContent: "flex-end",
  },
  backdrop: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
  },
  modalContent: {
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    maxHeight: "85%",
  },
  header: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingHorizontal: Spacing.lg,
    paddingVertical: Spacing.md,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: "rgba(255,255,255,0.1)",
  },
  title: {
    fontSize: 18,
    fontWeight: "700",
  },
  scrollContent: {
    paddingHorizontal: Spacing.lg,
    paddingTop: Spacing.md,
  },
  infoCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.md,
  },
  infoLabel: {
    fontSize: 13,
    marginBottom: 4,
  },
  infoValue: {
    fontSize: 16,
    fontWeight: "600",
  },
  amountsRow: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginBottom: Spacing.lg,
  },
  amountCard: {
    flex: 1,
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
  amountValue: {
    fontSize: 15,
    fontWeight: "700",
  },
  inputGroup: {
    marginBottom: Spacing.md,
  },
  inputLabel: {
    fontSize: 14,
    fontWeight: "600",
    marginBottom: Spacing.xs,
  },
  input: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    fontSize: 16,
  },
  multilineInput: {
    minHeight: 80,
    textAlignVertical: "top",
  },
  methodsRow: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  methodButton: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.xs,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
  },
  methodLabel: {
    fontSize: 14,
    fontWeight: "600",
  },
  footer: {
    flexDirection: "row",
    gap: Spacing.sm,
    padding: Spacing.lg,
    paddingBottom: Spacing.xl,
  },
  cancelButton: {
    flex: 1,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
  cancelButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
  submitButton: {
    flex: 2,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.xs,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.md,
  },
  submitButtonText: {
    fontSize: 16,
    fontWeight: "600",
    color: "#FFFFFF",
  },
});
