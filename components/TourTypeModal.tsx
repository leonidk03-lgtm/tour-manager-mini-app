import { useState, useEffect, useRef } from "react";
import { View, Modal, StyleSheet, TextInput, Pressable, Alert, Switch, KeyboardAvoidingView, Platform, ScrollView } from "react-native";
import { Icon } from "@/components/Icon";
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
  const { tourTypes, additionalServices } = useData();
  const [name, setName] = useState("");
  const [articleNumber, setArticleNumber] = useState("");
  const [fullPrice, setFullPrice] = useState("");
  const [discountedPrice, setDiscountedPrice] = useState("");
  const [isEnabled, setIsEnabled] = useState(true);
  const [hasRadioGuides, setHasRadioGuides] = useState(false);
  const [selectedServiceIds, setSelectedServiceIds] = useState<string[]>([]);

  const articleRef = useRef<TextInput>(null);
  const fullPriceRef = useRef<TextInput>(null);
  const discountedPriceRef = useRef<TextInput>(null);

  useEffect(() => {
    if (visible) {
      setName(tourType?.name || "");
      setArticleNumber(tourType?.articleNumber || "");
      setFullPrice(tourType?.fullPrice.toString() || "");
      setDiscountedPrice(tourType?.discountedPrice.toString() || "");
      setIsEnabled(tourType?.isEnabled ?? true);
      setHasRadioGuides(tourType?.hasRadioGuides ?? false);
      setSelectedServiceIds(tourType?.applicableServiceIds || []);
    }
  }, [visible, tourType]);

  const toggleService = (serviceId: string) => {
    setSelectedServiceIds((prev) =>
      prev.includes(serviceId) ? prev.filter((id) => id !== serviceId) : [...prev, serviceId]
    );
  };

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
      applicableServiceIds: selectedServiceIds,
      hasRadioGuides,
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
        <Pressable style={styles.backdrop} onPress={handleClose} />
        <ThemedView style={[styles.modal, { backgroundColor: theme.backgroundDefault }]}>
          <View style={styles.header}>
            <ThemedText style={styles.title}>
              {tourType ? "Редактировать экскурсию" : "Новая экскурсия"}
            </ThemedText>
            <Pressable onPress={handleClose} style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}>
              <Icon name="x" size={24} color={theme.text} />
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
                placeholder="Например: Болгар"
                placeholderTextColor={theme.textSecondary}
                returnKeyType="next"
                blurOnSubmit={false}
                onSubmitEditing={() => articleRef.current?.focus()}
              />
            </View>

            <View style={styles.inputGroup}>
              <ThemedText style={[styles.label, { color: theme.textSecondary }]}>Артикул</ThemedText>
              <TextInput
                ref={articleRef}
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
                returnKeyType="next"
                blurOnSubmit={false}
                onSubmitEditing={() => fullPriceRef.current?.focus()}
              />
            </View>

            <View style={styles.row}>
              <View style={[styles.inputGroup, { flex: 1 }]}>
                <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                  Полная цена
                </ThemedText>
                <TextInput
                  ref={fullPriceRef}
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
                  returnKeyType="next"
                  blurOnSubmit={false}
                  onSubmitEditing={() => discountedPriceRef.current?.focus()}
                />
              </View>

              <View style={[styles.inputGroup, { flex: 1 }]}>
                <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                  Льготная цена
                </ThemedText>
                <TextInput
                  ref={discountedPriceRef}
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
                  returnKeyType="done"
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

            <View style={styles.switchRow}>
              <View style={{ flex: 1 }}>
                <ThemedText style={styles.switchLabel}>Радиогиды</ThemedText>
                <ThemedText style={[styles.switchDescription, { color: theme.textSecondary }]}>
                  Включите для экскурсий с радиогидами
                </ThemedText>
              </View>
              <Switch
                value={hasRadioGuides}
                onValueChange={setHasRadioGuides}
                trackColor={{ false: theme.divider, true: theme.primary }}
                thumbColor={theme.backgroundDefault}
              />
            </View>

            {additionalServices.length > 0 ? (
              <View style={styles.servicesSection}>
                <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                  Доступные услуги
                </ThemedText>
                <View style={styles.servicesList}>
                  {additionalServices.map((service) => {
                    const isSelected = selectedServiceIds.includes(service.id);
                    return (
                      <Pressable
                        key={service.id}
                        onPress={() => toggleService(service.id)}
                        style={[
                          styles.serviceItem,
                          {
                            backgroundColor: isSelected ? theme.primary + "20" : theme.backgroundSecondary,
                            borderColor: isSelected ? theme.primary : theme.border,
                          },
                        ]}
                      >
                        <Feather
                          name={isSelected ? "check-square" : "square"}
                          size={20}
                          color={isSelected ? theme.primary : theme.textSecondary}
                        />
                        <ThemedText style={styles.serviceName}>{service.name}</ThemedText>
                        <ThemedText style={[styles.servicePrice, { color: theme.textSecondary }]}>
                          {service.price} р.
                        </ThemedText>
                      </Pressable>
                    );
                  })}
                </View>
              </View>
            ) : null}
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
    justifyContent: "flex-end",
  },
  backdrop: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
  },
  modalContainer: {
    maxHeight: "90%",
  },
  modal: {
    borderTopLeftRadius: BorderRadius.lg,
    borderTopRightRadius: BorderRadius.lg,
    paddingBottom: Spacing["2xl"],
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
    flexGrow: 0,
    flexShrink: 1,
    maxHeight: 400,
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
  servicesSection: {
    gap: Spacing.sm,
  },
  servicesList: {
    gap: Spacing.xs,
  },
  serviceItem: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    gap: Spacing.sm,
  },
  serviceName: {
    flex: 1,
    fontSize: 15,
  },
  servicePrice: {
    fontSize: 14,
  },
});
