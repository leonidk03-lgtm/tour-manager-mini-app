import { useState, useEffect } from "react";
import { View, Modal, StyleSheet, TextInput, Pressable, Alert, Switch } from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { TourType, useData } from "@/contexts/DataContext";

interface TourTypeModalProps {
  visible: boolean;
  onClose: () => void;
  onSave: (tourType: TourType) => void;
  tourType?: TourType;
}

export function TourTypeModal({ visible, onClose, onSave, tourType }: TourTypeModalProps) {
  const { theme } = useTheme();
  const { tourTypes } = useData();
  const [name, setName] = useState("");
  const [articleNumber, setArticleNumber] = useState("");
  const [fullPrice, setFullPrice] = useState("");
  const [discountedPrice, setDiscountedPrice] = useState("");
  const [isEnabled, setIsEnabled] = useState(true);

  useEffect(() => {
    if (visible) {
      setName(tourType?.name || "");
      setArticleNumber(tourType?.articleNumber || "");
      setFullPrice(tourType?.fullPrice.toString() || "");
      setDiscountedPrice(tourType?.discountedPrice.toString() || "");
      setIsEnabled(tourType?.isEnabled ?? true);
    }
  }, [visible, tourType]);

  const handleSave = () => {
    if (!name.trim()) {
      Alert.alert("Ошибка", "Введите название экскурсии");
      return;
    }
    if (!articleNumber.trim()) {
      Alert.alert("Ошибка", "Введите артикул");
      return;
    }

    const isDuplicateArticle = tourTypes.some(
      (t) => t.articleNumber === articleNumber.trim() && t.id !== tourType?.id
    );
    if (isDuplicateArticle) {
      Alert.alert("Ошибка", "Экскурсия с таким артикулом уже существует");
      return;
    }

    const full = parseInt(fullPrice, 10);
    const discounted = parseInt(discountedPrice, 10);

    if (!fullPrice.trim() || !discountedPrice.trim() || isNaN(full) || isNaN(discounted) || full <= 0 || discounted <= 0) {
      Alert.alert("Ошибка", "Введите корректные цены (целые числа больше 0)");
      return;
    }

    const newTourType: TourType = {
      id: tourType?.id || Date.now().toString(),
      name: name.trim(),
      articleNumber: articleNumber.trim(),
      fullPrice: full,
      discountedPrice: discounted,
      isEnabled,
    };

    onSave(newTourType);
    onClose();
  };

  const handleClose = () => {
    onClose();
  };

  return (
    <Modal visible={visible} animationType="slide" transparent onRequestClose={handleClose}>
      <View style={styles.overlay}>
        <ThemedView style={[styles.modal, { backgroundColor: theme.backgroundDefault }]}>
          <View style={styles.header}>
            <ThemedText style={styles.title}>
              {tourType ? "Редактировать экскурсию" : "Новая экскурсия"}
            </ThemedText>
            <Pressable onPress={handleClose} style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}>
              <Feather name="x" size={24} color={theme.text} />
            </Pressable>
          </View>

          <View style={styles.content}>
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
                placeholder="Например: Болгар"
                placeholderTextColor={theme.textSecondary}
              />
            </View>

            <View style={styles.inputGroup}>
              <ThemedText style={[styles.label, { color: theme.textSecondary }]}>Артикул</ThemedText>
              <TextInput
                style={[
                  styles.input,
                  {
                    borderColor: theme.inputBorder,
                    color: theme.text,
                    backgroundColor: theme.backgroundSecondary,
                  },
                ]}
                value={articleNumber}
                onChangeText={setArticleNumber}
                placeholder="Например: EXC-001"
                placeholderTextColor={theme.textSecondary}
              />
            </View>

            <View style={styles.row}>
              <View style={[styles.inputGroup, { flex: 1 }]}>
                <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                  Полная цена
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
                  value={fullPrice}
                  onChangeText={setFullPrice}
                  keyboardType="numeric"
                  placeholder="3000"
                  placeholderTextColor={theme.textSecondary}
                />
              </View>

              <View style={[styles.inputGroup, { flex: 1 }]}>
                <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                  Льготная цена
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
                  value={discountedPrice}
                  onChangeText={setDiscountedPrice}
                  keyboardType="numeric"
                  placeholder="2800"
                  placeholderTextColor={theme.textSecondary}
                />
              </View>
            </View>

            <View style={styles.switchRow}>
              <View style={{ flex: 1 }}>
                <ThemedText style={styles.switchLabel}>Включена</ThemedText>
                <ThemedText style={[styles.switchDescription, { color: theme.textSecondary }]}>
                  Отключите для сезонных экскурсий
                </ThemedText>
              </View>
              <Switch
                value={isEnabled}
                onValueChange={setIsEnabled}
                trackColor={{ false: theme.divider, true: theme.primary }}
                thumbColor={theme.backgroundDefault}
              />
            </View>
          </View>

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
                {tourType ? "Сохранить" : "Добавить"}
              </ThemedText>
            </Pressable>
          </View>
        </ThemedView>
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
  content: {
    paddingHorizontal: Spacing.lg,
    gap: Spacing.lg,
  },
  inputGroup: {
    gap: Spacing.xs,
  },
  label: {
    fontSize: 14,
    fontWeight: "500",
  },
  input: {
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    padding: Spacing.md,
    fontSize: 16,
  },
  row: {
    flexDirection: "row",
    gap: Spacing.md,
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
