import { useState, useEffect } from "react";
import { View, Modal, StyleSheet, TextInput, Pressable, Alert, Switch, KeyboardAvoidingView, Platform, ScrollView } from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { AdditionalService, useData } from "@/contexts/DataContext";

interface ServiceModalProps {
  visible: boolean;
  onClose: () => void;
  onSave: (service: AdditionalService) => void;
  service?: AdditionalService;
}

export function ServiceModal({ visible, onClose, onSave, service }: ServiceModalProps) {
  const { theme } = useTheme();
  const [name, setName] = useState("");
  const [price, setPrice] = useState("");
  const [isEnabled, setIsEnabled] = useState(true);

  useEffect(() => {
    if (visible) {
      setName(service?.name || "");
      setPrice(service?.price.toString() || "");
      setIsEnabled(service?.isEnabled ?? true);
    }
  }, [visible, service]);

  const handleSave = () => {
    if (!name.trim()) {
      Alert.alert("Ошибка", "Введите название услуги");
      return;
    }

    const priceValue = parseInt(price, 10);

    if (!price.trim() || isNaN(priceValue)) {
      Alert.alert("Ошибка", "Введите корректную цену (целое число)");
      return;
    }

    if (priceValue === 0) {
      Alert.alert("Ошибка", "Цена не может быть равна нулю");
      return;
    }

    const newService: AdditionalService = {
      id: service?.id || Date.now().toString(),
      name: name.trim(),
      price: priceValue,
      isEnabled,
    };

    onSave(newService);
    onClose();
  };

  const handleClose = () => {
    onClose();
  };

  return (
    <Modal visible={visible} animationType="slide" transparent onRequestClose={handleClose}>
      <View style={styles.overlay}>
        <KeyboardAvoidingView 
          style={styles.modalWrapper}
          behavior={Platform.OS === "ios" ? "padding" : "height"}
        >
          <ThemedView style={[styles.modal, { backgroundColor: theme.backgroundDefault }]}>
          <View style={styles.header}>
            <ThemedText style={styles.title}>
              {service ? "Редактировать услугу" : "Новая услуга"}
            </ThemedText>
            <Pressable onPress={handleClose} style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}>
              <Feather name="x" size={24} color={theme.text} />
            </Pressable>
          </View>

          <ScrollView style={styles.scrollContent} contentContainerStyle={styles.content} keyboardShouldPersistTaps="handled">
            <View style={styles.inputGroup}>
              <ThemedText style={[styles.label, { color: theme.textSecondary }]}>Название</ThemedText>
              <TextInput
                style={[
                  styles.input,
                  {
                    borderColor: theme.inputBorder,
                    color: theme.text,
                    backgroundColor: theme.backgroundSecondary,
                  },
                ]}
                value={name}
                onChangeText={setName}
                placeholder="Например: Теплоход"
                placeholderTextColor={theme.textSecondary}
              />
            </View>

            <View style={styles.inputGroup}>
              <ThemedText style={[styles.label, { color: theme.textSecondary }]}>Цена</ThemedText>
              <ThemedText style={[styles.priceHint, { color: theme.textSecondary }]}>
                Положительная = клиент платит, отрицательная = мы платим
              </ThemedText>
              <TextInput
                style={[
                  styles.input,
                  {
                    borderColor: theme.inputBorder,
                    color: theme.text,
                    backgroundColor: theme.backgroundSecondary,
                  },
                ]}
                value={price}
                onChangeText={setPrice}
                keyboardType="numbers-and-punctuation"
                placeholder="400 или -400"
                placeholderTextColor={theme.textSecondary}
              />
            </View>

            <View style={styles.switchRow}>
              <View style={{ flex: 1 }}>
                <ThemedText style={styles.switchLabel}>Включена</ThemedText>
                <ThemedText style={[styles.switchDescription, { color: theme.textSecondary }]}>
                  Отключите для сезонных услуг
                </ThemedText>
              </View>
              <Switch
                value={isEnabled}
                onValueChange={setIsEnabled}
                trackColor={{ false: theme.divider, true: theme.primary }}
                thumbColor={theme.backgroundDefault}
              />
            </View>
          </ScrollView>

          <View style={styles.actions}>
            <Pressable
              style={[styles.button, styles.cancelButton, { borderColor: theme.border }]}
              onPress={handleClose}
            >
              <ThemedText style={styles.cancelButtonText}>Отмена</ThemedText>
            </Pressable>
            <Pressable
              style={[styles.button, styles.saveButton, { backgroundColor: theme.primary }]}
              onPress={handleSave}
            >
              <ThemedText style={styles.saveButtonText}>
                {service ? "Сохранить" : "Добавить"}
              </ThemedText>
            </Pressable>
          </View>
          </ThemedView>
        </KeyboardAvoidingView>
      </View>
    </Modal>
  );
}

const styles = StyleSheet.create({
  overlay: {
    flex: 1,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
    justifyContent: "flex-end",
  },
  modalWrapper: {
    maxHeight: "90%",
  },
  modal: {
    borderTopLeftRadius: BorderRadius.lg,
    borderTopRightRadius: BorderRadius.lg,
    paddingBottom: Spacing["2xl"],
    maxHeight: "90%",
  },
  header: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.lg,
    paddingBottom: Spacing.md,
  },
  title: {
    fontSize: 20,
    fontWeight: "600",
  },
  scrollContent: {
    flex: 1,
  },
  content: {
    paddingHorizontal: Spacing.lg,
    gap: Spacing.lg,
    paddingBottom: Spacing.lg,
  },
  inputGroup: {
    gap: Spacing.xs,
  },
  label: {
    fontSize: 14,
    fontWeight: "500",
  },
  priceHint: {
    fontSize: 12,
    marginBottom: Spacing.xs,
  },
  input: {
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    padding: Spacing.md,
    fontSize: 16,
  },
  switchRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingVertical: Spacing.sm,
  },
  switchLabel: {
    fontSize: 16,
    fontWeight: "500",
  },
  switchDescription: {
    fontSize: 13,
    marginTop: 2,
  },
  actions: {
    flexDirection: "row",
    gap: Spacing.md,
    paddingHorizontal: Spacing.lg,
    paddingTop: Spacing.xl,
  },
  button: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
  cancelButton: {
    borderWidth: 1,
  },
  cancelButtonText: {
    fontSize: 16,
    fontWeight: "500",
  },
  saveButton: {},
  saveButtonText: {
    fontSize: 16,
    fontWeight: "600",
    color: "#FFFFFF",
  },
});
