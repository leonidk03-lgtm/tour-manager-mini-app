import { useState, useCallback } from "react";
import { View, StyleSheet, Pressable, Alert, Switch, RefreshControl, TextInput, ScrollView } from "react-native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useRental, RentalService } from "@/contexts/RentalContext";
import { useData } from "@/contexts/DataContext";
import { Modal, Platform, KeyboardAvoidingView } from "react-native";

export default function RentalServicesScreen() {
  const { theme } = useTheme();
  const {
    rentalServices,
    addRentalService,
    updateRentalService,
    deleteRentalService,
    refreshData,
  } = useRental();
  const { equipmentItems, equipmentCategories } = useData();

  const [refreshing, setRefreshing] = useState(false);
  const [modalVisible, setModalVisible] = useState(false);
  const [editingService, setEditingService] = useState<RentalService | null>(null);
  const [serviceName, setServiceName] = useState("");
  const [servicePrice, setServicePrice] = useState("");
  const [serviceCommission, setServiceCommission] = useState("10");
  const [writeoffItemId, setWriteoffItemId] = useState<string | null>(null);
  const [itemPickerVisible, setItemPickerVisible] = useState(false);

  const consumableItems = equipmentItems.filter(item => {
    const category = equipmentCategories.find(c => c.id === item.categoryId);
    return category?.type === 'consumables';
  });

  const getItemName = (itemId: string | null) => {
    if (!itemId) return null;
    return equipmentItems.find(i => i.id === itemId)?.name || null;
  };

  const onRefresh = useCallback(async () => {
    setRefreshing(true);
    await refreshData();
    setRefreshing(false);
  }, [refreshData]);

  const handleAddService = () => {
    setEditingService(null);
    setServiceName("");
    setServicePrice("");
    setServiceCommission("10");
    setWriteoffItemId(null);
    setModalVisible(true);
  };

  const handleEditService = (service: RentalService) => {
    setEditingService(service);
    setServiceName(service.name);
    setServicePrice(service.price.toString());
    setServiceCommission(service.commissionPercent.toString());
    setWriteoffItemId(service.writeoffItemId);
    setModalVisible(true);
  };

  const handleSaveService = async () => {
    const name = serviceName.trim();
    const price = parseInt(servicePrice, 10) || 0;
    const commissionPercent = parseInt(serviceCommission, 10) || 10;

    if (!name) {
      Alert.alert("Ошибка", "Введите название услуги");
      return;
    }

    if (price <= 0) {
      Alert.alert("Ошибка", "Введите корректную цену");
      return;
    }

    if (commissionPercent < 0 || commissionPercent > 100) {
      Alert.alert("Ошибка", "Комиссия должна быть от 0 до 100%");
      return;
    }

    try {
      if (editingService) {
        await updateRentalService(editingService.id, { name, price, commissionPercent, writeoffItemId });
        Alert.alert("Сохранено", "Услуга успешно обновлена");
      } else {
        await addRentalService({ name, price, commissionPercent, isActive: true, writeoffItemId });
        Alert.alert("Успешно", "Услуга добавлена");
      }
      setModalVisible(false);
    } catch (error: unknown) {
      console.error("Error saving service:", error);
      const message = error instanceof Error ? error.message : "Не удалось сохранить услугу";
      Alert.alert("Ошибка", message);
    }
  };

  const handleDeleteService = (service: RentalService) => {
    Alert.alert("Удалить услугу?", `Вы уверены, что хотите удалить "${service.name}"?`, [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: async () => {
          try {
            await deleteRentalService(service.id);
            Alert.alert("Удалено", "Услуга удалена");
          } catch (error) {
            Alert.alert("Ошибка", "Не удалось удалить услугу");
          }
        },
      },
    ]);
  };

  const handleToggleService = async (service: RentalService) => {
    try {
      await updateRentalService(service.id, { isActive: !service.isActive });
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось изменить статус");
    }
  };

  return (
    <ScreenScrollView
      refreshControl={
        <RefreshControl
          refreshing={refreshing}
          onRefresh={onRefresh}
          tintColor={theme.primary}
          colors={[theme.primary]}
        />
      }
    >
      <View style={styles.container}>
        <View style={styles.sectionHeader}>
          <ThemedText style={styles.sectionTitle}>Дополнительные услуги</ThemedText>
          <Pressable
            onPress={handleAddService}
            style={({ pressed }) => [
              styles.addButton,
              { backgroundColor: theme.primary, opacity: pressed ? 0.7 : 1 },
            ]}
          >
            <Icon name="plus" size={20} color="#FFFFFF" />
            <ThemedText style={styles.addButtonText}>Добавить</ThemedText>
          </Pressable>
        </View>

        <ThemedText style={[styles.description, { color: theme.textSecondary }]}>
          Здесь можно настроить дополнительные услуги для заказов аренды (доставка, дополнительные наушники и т.д.)
        </ThemedText>

        <View style={styles.list}>
          {rentalServices.length === 0 ? (
            <ThemedView style={[styles.emptyCard, { borderColor: theme.border }]}>
              <Icon name="package" size={48} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                Нет добавленных услуг
              </ThemedText>
              <ThemedText style={[styles.emptyHint, { color: theme.textTertiary }]}>
                Нажмите "Добавить" чтобы создать первую услугу
              </ThemedText>
            </ThemedView>
          ) : (
            rentalServices.map((service) => (
              <ThemedView
                key={service.id}
                style={[
                  styles.card,
                  {
                    borderColor: theme.border,
                    borderRadius: BorderRadius.sm,
                    opacity: service.isActive ? 1 : 0.5,
                  },
                ]}
              >
                <View style={styles.cardHeader}>
                  <View style={{ flex: 1 }}>
                    <ThemedText style={styles.cardTitle}>{service.name}</ThemedText>
                    <View style={{ flexDirection: "row", alignItems: "center", gap: Spacing.md }}>
                      <ThemedText style={[styles.cardPrice, { color: theme.success }]}>
                        {service.price.toLocaleString("ru-RU")} р.
                      </ThemedText>
                      <ThemedText style={[styles.cardCommission, { color: theme.primary }]}>
                        {service.commissionPercent}%
                      </ThemedText>
                    </View>
                    {service.writeoffItemId ? (
                      <View style={[styles.writeoffBadge, { backgroundColor: theme.warning + "20" }]}>
                        <Icon name="package" size={12} color={theme.warning} />
                        <ThemedText style={[styles.writeoffText, { color: theme.warning }]}>
                          Списание: {getItemName(service.writeoffItemId)}
                        </ThemedText>
                      </View>
                    ) : null}
                  </View>
                  <Switch
                    value={service.isActive}
                    onValueChange={() => handleToggleService(service)}
                    trackColor={{ false: theme.divider, true: theme.primary }}
                    thumbColor={theme.backgroundDefault}
                  />
                </View>

                <View style={styles.cardActions}>
                  <Pressable
                    onPress={() => handleEditService(service)}
                    style={({ pressed }) => [
                      styles.actionButton,
                      { backgroundColor: theme.backgroundSecondary, opacity: pressed ? 0.7 : 1 },
                    ]}
                  >
                    <Icon name="edit-2" size={16} color={theme.primary} />
                    <ThemedText style={[styles.actionText, { color: theme.primary }]}>
                      Изменить
                    </ThemedText>
                  </Pressable>
                  <Pressable
                    onPress={() => handleDeleteService(service)}
                    style={({ pressed }) => [
                      styles.actionButton,
                      { backgroundColor: theme.backgroundSecondary, opacity: pressed ? 0.7 : 1 },
                    ]}
                  >
                    <Icon name="trash-2" size={16} color={theme.error} />
                    <ThemedText style={[styles.actionText, { color: theme.error }]}>
                      Удалить
                    </ThemedText>
                  </Pressable>
                </View>
              </ThemedView>
            ))
          )}
        </View>
      </View>

      <Modal
        visible={modalVisible}
        transparent
        animationType="fade"
        onRequestClose={() => setModalVisible(false)}
      >
        <KeyboardAvoidingView
          behavior={Platform.OS === "ios" ? "padding" : "height"}
          style={styles.modalOverlay}
        >
          <View style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>
                {editingService ? "Редактировать услугу" : "Новая услуга"}
              </ThemedText>
              <Pressable onPress={() => setModalVisible(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <View style={styles.modalBody}>
              <View style={styles.inputGroup}>
                <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                  Название
                </ThemedText>
                <TextInput
                  style={[
                    styles.input,
                    {
                      backgroundColor: theme.backgroundSecondary,
                      color: theme.text,
                      borderColor: theme.border,
                    },
                  ]}
                  value={serviceName}
                  onChangeText={setServiceName}
                  placeholder="Например: Доставка"
                  placeholderTextColor={theme.textTertiary}
                />
              </View>

              <View style={styles.inputGroup}>
                <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                  Цена (р.)
                </ThemedText>
                <TextInput
                  style={[
                    styles.input,
                    {
                      backgroundColor: theme.backgroundSecondary,
                      color: theme.text,
                      borderColor: theme.border,
                    },
                  ]}
                  value={servicePrice}
                  onChangeText={setServicePrice}
                  placeholder="500"
                  placeholderTextColor={theme.textTertiary}
                  keyboardType="numeric"
                />
              </View>

              <View style={styles.inputGroup}>
                <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                  Комиссия исполнителю (%)
                </ThemedText>
                <TextInput
                  style={[
                    styles.input,
                    {
                      backgroundColor: theme.backgroundSecondary,
                      color: theme.text,
                      borderColor: theme.border,
                    },
                  ]}
                  value={serviceCommission}
                  onChangeText={setServiceCommission}
                  placeholder="10"
                  placeholderTextColor={theme.textTertiary}
                  keyboardType="numeric"
                />
              </View>

              <View style={styles.inputGroup}>
                <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                  Списание со склада
                </ThemedText>
                <Pressable
                  onPress={() => setItemPickerVisible(true)}
                  style={[
                    styles.pickerButton,
                    {
                      backgroundColor: theme.backgroundSecondary,
                      borderColor: theme.border,
                    },
                  ]}
                >
                  <ThemedText style={{ color: writeoffItemId ? theme.text : theme.textTertiary }}>
                    {writeoffItemId ? getItemName(writeoffItemId) : "Не выбрано"}
                  </ThemedText>
                  <Icon name="chevron-down" size={20} color={theme.textSecondary} />
                </Pressable>
                <ThemedText style={[styles.inputHint, { color: theme.textTertiary }]}>
                  При продаже услуги товар автоматически спишется со склада
                </ThemedText>
              </View>
            </View>

            <View style={styles.modalActions}>
              <Pressable
                onPress={() => setModalVisible(false)}
                style={({ pressed }) => [
                  styles.modalButton,
                  { backgroundColor: theme.backgroundSecondary, opacity: pressed ? 0.7 : 1 },
                ]}
              >
                <ThemedText style={{ color: theme.text }}>Отмена</ThemedText>
              </Pressable>
              <Pressable
                onPress={handleSaveService}
                style={({ pressed }) => [
                  styles.modalButton,
                  { backgroundColor: theme.primary, opacity: pressed ? 0.7 : 1 },
                ]}
              >
                <ThemedText style={{ color: "#FFFFFF" }}>Сохранить</ThemedText>
              </Pressable>
            </View>
          </View>
        </KeyboardAvoidingView>
      </Modal>

      <Modal
        visible={itemPickerVisible}
        transparent
        animationType="slide"
        onRequestClose={() => setItemPickerVisible(false)}
      >
        <View style={styles.pickerOverlay}>
          <View style={[styles.pickerContent, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.pickerHeader}>
              <ThemedText style={styles.pickerTitle}>Выберите товар</ThemedText>
              <Pressable onPress={() => setItemPickerVisible(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>
            <ScrollView style={styles.pickerList}>
              <Pressable
                onPress={() => {
                  setWriteoffItemId(null);
                  setItemPickerVisible(false);
                }}
                style={[
                  styles.pickerItem,
                  {
                    backgroundColor: !writeoffItemId ? theme.primary + "20" : "transparent",
                  },
                ]}
              >
                <ThemedText style={{ color: theme.textSecondary }}>Не списывать</ThemedText>
                {!writeoffItemId ? <Icon name="check" size={20} color={theme.primary} /> : null}
              </Pressable>
              {consumableItems.map((item) => (
                <Pressable
                  key={item.id}
                  onPress={() => {
                    setWriteoffItemId(item.id);
                    setItemPickerVisible(false);
                  }}
                  style={[
                    styles.pickerItem,
                    {
                      backgroundColor: writeoffItemId === item.id ? theme.primary + "20" : "transparent",
                    },
                  ]}
                >
                  <View>
                    <ThemedText>{item.name}</ThemedText>
                    <ThemedText style={[styles.itemQuantity, { color: theme.textSecondary }]}>
                      На складе: {item.quantity} шт.
                    </ThemedText>
                  </View>
                  {writeoffItemId === item.id ? <Icon name="check" size={20} color={theme.primary} /> : null}
                </Pressable>
              ))}
              {consumableItems.length === 0 ? (
                <View style={styles.emptyPicker}>
                  <ThemedText style={{ color: theme.textSecondary, textAlign: "center" }}>
                    Нет расходных материалов на складе.{"\n"}Добавьте их в разделе "Склад"
                  </ThemedText>
                </View>
              ) : null}
            </ScrollView>
          </View>
        </View>
      </Modal>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    padding: Spacing.md,
  },
  sectionHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.sm,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: "600",
  },
  description: {
    fontSize: 14,
    marginBottom: Spacing.lg,
    lineHeight: 20,
  },
  addButton: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
    gap: Spacing.xs,
  },
  addButtonText: {
    color: "#FFFFFF",
    fontWeight: "500",
    fontSize: 14,
  },
  list: {
    gap: Spacing.md,
  },
  card: {
    borderWidth: 1,
    padding: Spacing.md,
  },
  cardHeader: {
    flexDirection: "row",
    alignItems: "flex-start",
    gap: Spacing.md,
  },
  cardTitle: {
    fontSize: 16,
    fontWeight: "500",
    marginBottom: Spacing.xs,
  },
  cardPrice: {
    fontSize: 18,
    fontWeight: "600",
  },
  cardCommission: {
    fontSize: 14,
    fontWeight: "500",
  },
  writeoffBadge: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
    marginTop: Spacing.xs,
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.xs,
    alignSelf: "flex-start",
  },
  writeoffText: {
    fontSize: 12,
    fontWeight: "500",
  },
  cardActions: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginTop: Spacing.md,
    paddingTop: Spacing.md,
    borderTopWidth: StyleSheet.hairlineWidth,
    borderTopColor: "rgba(255,255,255,0.1)",
  },
  actionButton: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
    gap: Spacing.xs,
  },
  actionText: {
    fontSize: 14,
    fontWeight: "500",
  },
  emptyCard: {
    borderWidth: 1,
    borderStyle: "dashed",
    borderRadius: BorderRadius.sm,
    padding: Spacing.xl,
    alignItems: "center",
    justifyContent: "center",
  },
  emptyText: {
    fontSize: 16,
    marginTop: Spacing.md,
  },
  emptyHint: {
    fontSize: 14,
    marginTop: Spacing.xs,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
    justifyContent: "center",
    padding: Spacing.lg,
  },
  modalContent: {
    borderRadius: BorderRadius.md,
    maxHeight: "90%",
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.md,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: "rgba(255,255,255,0.1)",
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  modalBody: {
    padding: Spacing.md,
    gap: Spacing.md,
  },
  inputGroup: {
    gap: Spacing.xs,
  },
  inputLabel: {
    fontSize: 14,
    fontWeight: "500",
  },
  input: {
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    padding: Spacing.md,
    fontSize: 16,
  },
  inputHint: {
    fontSize: 12,
    marginTop: 2,
  },
  pickerButton: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    padding: Spacing.md,
  },
  modalActions: {
    flexDirection: "row",
    gap: Spacing.md,
    padding: Spacing.md,
    borderTopWidth: StyleSheet.hairlineWidth,
    borderTopColor: "rgba(255,255,255,0.1)",
  },
  modalButton: {
    flex: 1,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
  pickerOverlay: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
    justifyContent: "flex-end",
  },
  pickerContent: {
    borderTopLeftRadius: BorderRadius.lg,
    borderTopRightRadius: BorderRadius.lg,
    maxHeight: "70%",
  },
  pickerHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.md,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: "rgba(255,255,255,0.1)",
  },
  pickerTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  pickerList: {
    padding: Spacing.md,
  },
  pickerItem: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    marginBottom: Spacing.xs,
  },
  itemQuantity: {
    fontSize: 12,
    marginTop: 2,
  },
  emptyPicker: {
    padding: Spacing.xl,
  },
});
