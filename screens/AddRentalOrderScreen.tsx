import { useState, useMemo, useEffect } from "react";
import {
  View,
  StyleSheet,
  Pressable,
  Alert,
  TextInput,
  Modal,
  FlatList,
  Platform,
} from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { useNavigation, useRoute, RouteProp } from "@react-navigation/native";
import DateTimePicker, { DateTimePickerEvent } from "@react-native-community/datetimepicker";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenKeyboardAwareScrollView } from "@/components/ScreenKeyboardAwareScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useRental, RentalClient } from "@/contexts/RentalContext";
import { useAuth } from "@/contexts/AuthContext";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";
import { hapticFeedback } from "@/utils/haptics";

type RouteParams = RouteProp<SettingsStackParamList, "AddRentalOrder">;

export default function AddRentalOrderScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation();
  const route = useRoute<RouteParams>();
  const insets = useSafeAreaInsets();
  const { rentalClients, rentalOrders, addRentalOrder, updateRentalOrder } = useRental();
  const { profile, managers } = useAuth();

  const initialClientId = route.params?.clientId;
  const orderId = route.params?.orderId;
  const existingOrder = orderId ? rentalOrders.find(o => o.id === orderId) : null;
  const isEditMode = !!existingOrder;

  const initialClient = existingOrder 
    ? rentalClients.find(c => c.id === existingOrder.clientId) 
    : initialClientId 
      ? rentalClients.find(c => c.id === initialClientId) 
      : null;

  const [selectedClient, setSelectedClient] = useState<RentalClient | null>(initialClient || null);
  const [showClientPicker, setShowClientPicker] = useState(false);

  useEffect(() => {
    setSelectedClient(prev => {
      if (!prev) return prev;
      const updatedClient = rentalClients.find(c => c.id === prev.id);
      if (updatedClient && (
        updatedClient.assignedManagerId !== prev.assignedManagerId ||
        updatedClient.assignedManagerName !== prev.assignedManagerName
      )) {
        return updatedClient;
      }
      return prev;
    });
  }, [rentalClients]);
  const [clientSearch, setClientSearch] = useState("");

  const [startDate, setStartDate] = useState(existingOrder ? new Date(existingOrder.startDate) : new Date());
  const [endDate, setEndDate] = useState(existingOrder ? new Date(existingOrder.endDate) : new Date());
  const [showStartPicker, setShowStartPicker] = useState(false);
  const [showEndPicker, setShowEndPicker] = useState(false);

  const [kitCount, setKitCount] = useState(existingOrder?.kitCount?.toString() || "");
  const [spareReceiverCount, setSpareReceiverCount] = useState(
    existingOrder ? (existingOrder.spareReceiverCount?.toString() ?? "0") : "0"
  );
  const [transmitterCount, setTransmitterCount] = useState(existingOrder?.transmitterCount?.toString() || "1");
  const [microphoneCount, setMicrophoneCount] = useState(existingOrder?.microphoneCount?.toString() || "1");
  const [bagNumber, setBagNumber] = useState(existingOrder?.bagNumber || "");
  const [isCharged, setIsCharged] = useState(existingOrder?.isCharged || false);
  const [pricePerUnit, setPricePerUnit] = useState(existingOrder?.pricePerUnit?.toString() || selectedClient?.defaultPrice?.toString() || "100");
  const [prepayment, setPrepayment] = useState(existingOrder?.prepayment?.toString() || "0");
  const [receiverNotes, setReceiverNotes] = useState(existingOrder?.receiverNotes || "");

  const daysCount = useMemo(() => {
    const diffTime = endDate.getTime() - startDate.getTime();
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
    return Math.max(1, diffDays);
  }, [startDate, endDate]);

  const totalPrice = useMemo(() => {
    const kits = parseInt(kitCount) || 0;
    const price = parseFloat(pricePerUnit) || 0;
    return kits * price * daysCount;
  }, [kitCount, pricePerUnit, daysCount]);

  const filteredClients = useMemo(() => {
    if (!clientSearch.trim()) return rentalClients.filter(c => c.isActive);
    const query = clientSearch.toLowerCase();
    return rentalClients.filter(c =>
      c.isActive && (
        c.name.toLowerCase().includes(query) ||
        c.phone?.toLowerCase().includes(query)
      )
    );
  }, [rentalClients, clientSearch]);

  const handleSelectClient = (client: RentalClient) => {
    setSelectedClient(client);
    setPricePerUnit(client.defaultPrice?.toString() || "100");
    setShowClientPicker(false);
    setClientSearch("");
    hapticFeedback.selection();
  };

  const handleStartDateChange = (event: DateTimePickerEvent, date?: Date) => {
    if (Platform.OS === "android") setShowStartPicker(false);
    if (date) {
      setStartDate(date);
      if (date > endDate) setEndDate(date);
    }
  };

  const handleEndDateChange = (event: DateTimePickerEvent, date?: Date) => {
    if (Platform.OS === "android") setShowEndPicker(false);
    if (date && date >= startDate) setEndDate(date);
  };

  const formatDate = (date: Date): string => {
    return date.toLocaleDateString("ru-RU", { day: "2-digit", month: "2-digit", year: "numeric" });
  };

  const handleSave = async () => {
    if (!selectedClient) {
      Alert.alert("Ошибка", "Выберите клиента");
      return;
    }

    const kits = parseInt(kitCount) || 0;
    if (kits <= 0) {
      Alert.alert("Ошибка", "Введите количество комплектов");
      return;
    }

    hapticFeedback.selection();

    try {
      if (isEditMode && orderId) {
        await updateRentalOrder(orderId, {
          clientId: selectedClient.id,
          startDate: startDate.toISOString(),
          endDate: endDate.toISOString(),
          daysCount,
          kitCount: kits,
          spareReceiverCount: parseInt(spareReceiverCount) || 0,
          transmitterCount: parseInt(transmitterCount) || 0,
          microphoneCount: parseInt(microphoneCount) || 0,
          bagNumber: bagNumber.trim() || null,
          isCharged,
          pricePerUnit: parseFloat(pricePerUnit) || 100,
          totalPrice,
          prepayment: parseFloat(prepayment) || 0,
          receiverNotes: receiverNotes.trim() || null,
        });
      } else {
        await addRentalOrder({
          clientId: selectedClient.id,
          status: "new",
          startDate: startDate.toISOString(),
          endDate: endDate.toISOString(),
          daysCount,
          kitCount: kits,
          spareReceiverCount: parseInt(spareReceiverCount) || 0,
          transmitterCount: parseInt(transmitterCount) || 0,
          microphoneCount: parseInt(microphoneCount) || 0,
          bagNumber: bagNumber.trim() || null,
          isCharged,
          pricePerUnit: parseFloat(pricePerUnit) || 100,
          totalPrice,
          prepayment: parseFloat(prepayment) || 0,
          receiverNotes: receiverNotes.trim() || null,
          managerId: null,
          managerName: null,
          executorId: profile?.id || null,
          executorName: profile?.display_name || profile?.email || null,
          ownerManagerId: selectedClient.assignedManagerId || null,
          ownerManagerName: selectedClient.assignedManagerName || null,
        });
      }

      hapticFeedback.success();
      navigation.goBack();
    } catch (error) {
      console.error("Error saving order:", error);
      Alert.alert("Ошибка", isEditMode ? "Не удалось обновить заказ" : "Не удалось создать заказ");
    }
  };

  return (
    <ThemedView style={styles.container}>
      <ScreenKeyboardAwareScrollView contentContainerStyle={styles.scrollContent}>
        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            Клиент
          </ThemedText>

          <Pressable
            onPress={() => setShowClientPicker(true)}
            style={[styles.selectButton, { backgroundColor: theme.backgroundSecondary }]}
          >
            {selectedClient ? (
              <View style={styles.selectedClient}>
                <View style={[styles.clientAvatar, { backgroundColor: selectedClient.type === "company" ? theme.primary : theme.secondary }]}>
                  <ThemedText style={styles.avatarText}>
                    {selectedClient.name.slice(0, 2).toUpperCase()}
                  </ThemedText>
                </View>
                <View style={styles.clientInfo}>
                  <ThemedText style={styles.clientName}>{selectedClient.name}</ThemedText>
                  {selectedClient.phone ? (
                    <ThemedText style={[styles.clientPhone, { color: theme.textSecondary }]}>
                      {selectedClient.phone}
                    </ThemedText>
                  ) : null}
                </View>
              </View>
            ) : (
              <ThemedText style={{ color: theme.textSecondary }}>Выберите клиента</ThemedText>
            )}
            <Icon name="chevron-down" size={20} color={theme.textSecondary} />
          </Pressable>
        </View>

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            Период аренды
          </ThemedText>

          <View style={styles.dateRow}>
            <View style={styles.dateColumn}>
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Начало
              </ThemedText>
              <Pressable
                onPress={() => setShowStartPicker(true)}
                style={[styles.dateButton, { backgroundColor: theme.backgroundSecondary }]}
              >
                <Icon name="calendar" size={18} color={theme.textSecondary} />
                <ThemedText>{formatDate(startDate)}</ThemedText>
              </Pressable>
            </View>
            <View style={styles.dateColumn}>
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Окончание
              </ThemedText>
              <Pressable
                onPress={() => setShowEndPicker(true)}
                style={[styles.dateButton, { backgroundColor: theme.backgroundSecondary }]}
              >
                <Icon name="calendar" size={18} color={theme.textSecondary} />
                <ThemedText>{formatDate(endDate)}</ThemedText>
              </Pressable>
            </View>
          </View>

          <View style={[styles.daysInfo, { backgroundColor: theme.primary + "15" }]}>
            <ThemedText style={[styles.daysText, { color: theme.primary }]}>
              {daysCount} {daysCount === 1 ? "день" : daysCount < 5 ? "дня" : "дней"}
            </ThemedText>
          </View>
        </View>

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            Оборудование
          </ThemedText>

          <View style={styles.inputRow}>
            <View style={styles.inputColumn}>
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Комплекты *
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={kitCount}
                onChangeText={setKitCount}
                placeholder="0"
                placeholderTextColor={theme.textSecondary}
                keyboardType="numeric"
              />
            </View>
            <View style={styles.inputColumn}>
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Запасные
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={spareReceiverCount}
                onChangeText={setSpareReceiverCount}
                placeholder="0"
                placeholderTextColor={theme.textSecondary}
                keyboardType="numeric"
              />
            </View>
          </View>

          <View style={styles.inputRow}>
            <View style={styles.inputColumn}>
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Передатчик
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={transmitterCount}
                onChangeText={setTransmitterCount}
                placeholder="1"
                placeholderTextColor={theme.textSecondary}
                keyboardType="numeric"
              />
            </View>
            <View style={styles.inputColumn}>
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Микрофон
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={microphoneCount}
                onChangeText={setMicrophoneCount}
                placeholder="1"
                placeholderTextColor={theme.textSecondary}
                keyboardType="numeric"
              />
            </View>
          </View>

          <View style={styles.inputRow}>
            <View style={[styles.inputColumn, { flex: 2 }]}>
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Номер сумки
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={bagNumber}
                onChangeText={setBagNumber}
                placeholder="Например: 5, 12"
                placeholderTextColor={theme.textSecondary}
              />
            </View>
            <View style={styles.inputColumn}>
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Заряжен
              </ThemedText>
              <Pressable
                onPress={() => setIsCharged(!isCharged)}
                style={[
                  styles.checkButton,
                  { backgroundColor: isCharged ? theme.success + "20" : theme.backgroundSecondary }
                ]}
              >
                <Icon
                  name={isCharged ? "check-circle" : "circle"}
                  size={24}
                  color={isCharged ? theme.success : theme.textSecondary}
                />
              </Pressable>
            </View>
          </View>
        </View>

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            Стоимость
          </ThemedText>

          <View style={styles.inputRow}>
            <View style={styles.inputColumn}>
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Цена за шт./день
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={pricePerUnit}
                onChangeText={setPricePerUnit}
                placeholder="100"
                placeholderTextColor={theme.textSecondary}
                keyboardType="numeric"
              />
            </View>
            <View style={styles.inputColumn}>
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Предоплата
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={prepayment}
                onChangeText={setPrepayment}
                placeholder="0"
                placeholderTextColor={theme.textSecondary}
                keyboardType="numeric"
              />
            </View>
          </View>

          <View style={[styles.totalRow, { backgroundColor: theme.primary + "15" }]}>
            <ThemedText style={[styles.totalLabel, { color: theme.textSecondary }]}>
              Итого:
            </ThemedText>
            <ThemedText style={[styles.totalValue, { color: theme.primary }]}>
              {totalPrice.toLocaleString("ru-RU")}₽
            </ThemedText>
          </View>
        </View>

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            Заметки приёмщика
          </ThemedText>
          <TextInput
            style={[styles.input, styles.textArea, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
            value={receiverNotes}
            onChangeText={setReceiverNotes}
            placeholder="Место встречи, время, контакты..."
            placeholderTextColor={theme.textSecondary}
            multiline
            numberOfLines={3}
          />
        </View>

        <View style={[styles.actions, { paddingBottom: insets.bottom + Spacing.xl }]}>
          <Pressable
            onPress={() => navigation.goBack()}
            style={[styles.cancelBtn, { backgroundColor: theme.backgroundSecondary }]}
          >
            <ThemedText>Отмена</ThemedText>
          </Pressable>
          <Pressable
            onPress={handleSave}
            style={[styles.saveBtn, { backgroundColor: theme.primary }]}
          >
            <ThemedText style={{ color: "#fff", fontWeight: "600" }}>Создать заказ</ThemedText>
          </Pressable>
        </View>
      </ScreenKeyboardAwareScrollView>

      {showStartPicker && (Platform.OS === "ios" ? (
        <Modal visible transparent animationType="slide">
          <View style={[styles.pickerModal, { backgroundColor: "rgba(0,0,0,0.5)" }]}>
            <View style={[styles.pickerContent, { backgroundColor: theme.backgroundDefault }]}>
              <View style={styles.pickerHeader}>
                <ThemedText style={styles.pickerTitle}>Дата начала</ThemedText>
                <Pressable onPress={() => setShowStartPicker(false)}>
                  <ThemedText style={{ color: theme.primary }}>Готово</ThemedText>
                </Pressable>
              </View>
              <DateTimePicker
                value={startDate}
                mode="date"
                display="spinner"
                onChange={handleStartDateChange}
                locale="ru-RU"
              />
            </View>
          </View>
        </Modal>
      ) : (
        <DateTimePicker
          value={startDate}
          mode="date"
          display="default"
          onChange={handleStartDateChange}
        />
      ))}

      {showEndPicker && (Platform.OS === "ios" ? (
        <Modal visible transparent animationType="slide">
          <View style={[styles.pickerModal, { backgroundColor: "rgba(0,0,0,0.5)" }]}>
            <View style={[styles.pickerContent, { backgroundColor: theme.backgroundDefault }]}>
              <View style={styles.pickerHeader}>
                <ThemedText style={styles.pickerTitle}>Дата окончания</ThemedText>
                <Pressable onPress={() => setShowEndPicker(false)}>
                  <ThemedText style={{ color: theme.primary }}>Готово</ThemedText>
                </Pressable>
              </View>
              <DateTimePicker
                value={endDate}
                mode="date"
                display="spinner"
                onChange={handleEndDateChange}
                minimumDate={startDate}
                locale="ru-RU"
              />
            </View>
          </View>
        </Modal>
      ) : (
        <DateTimePicker
          value={endDate}
          mode="date"
          display="default"
          onChange={handleEndDateChange}
          minimumDate={startDate}
        />
      ))}

      <Modal visible={showClientPicker} animationType="slide" transparent>
        <View style={[styles.modalOverlay, { backgroundColor: "rgba(0,0,0,0.5)" }]}>
          <View style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Выберите клиента</ThemedText>
              <Pressable onPress={() => setShowClientPicker(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <View style={[styles.searchBox, { backgroundColor: theme.backgroundSecondary, margin: Spacing.md }]}>
              <Icon name="search" size={20} color={theme.textSecondary} />
              <TextInput
                style={[styles.searchInput, { color: theme.text }]}
                placeholder="Поиск клиентов..."
                placeholderTextColor={theme.textSecondary}
                value={clientSearch}
                onChangeText={setClientSearch}
              />
            </View>

            <FlatList
              data={filteredClients}
              keyExtractor={(item) => item.id}
              contentContainerStyle={{ padding: Spacing.md }}
              renderItem={({ item }) => (
                <Pressable
                  onPress={() => handleSelectClient(item)}
                  style={[
                    styles.clientItem,
                    { backgroundColor: theme.backgroundSecondary },
                    selectedClient?.id === item.id && { borderColor: theme.primary, borderWidth: 2 },
                  ]}
                >
                  <View style={[styles.clientAvatar, { backgroundColor: item.type === "company" ? theme.primary : theme.secondary }]}>
                    <ThemedText style={styles.avatarText}>
                      {item.name.slice(0, 2).toUpperCase()}
                    </ThemedText>
                  </View>
                  <View style={styles.clientInfo}>
                    <ThemedText style={styles.clientName}>{item.name}</ThemedText>
                    {item.phone ? (
                      <ThemedText style={[styles.clientPhone, { color: theme.textSecondary }]}>
                        {item.phone}
                      </ThemedText>
                    ) : null}
                  </View>
                  <ThemedText style={[styles.clientPrice, { color: theme.primary }]}>
                    {item.defaultPrice}₽
                  </ThemedText>
                </Pressable>
              )}
              ListEmptyComponent={
                <View style={styles.emptyContainer}>
                  <ThemedText style={{ color: theme.textSecondary }}>Клиенты не найдены</ThemedText>
                </View>
              }
            />
          </View>
        </View>
      </Modal>
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  scrollContent: {
    padding: Spacing.md,
    gap: Spacing.md,
  },
  card: {
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
  },
  sectionTitle: {
    fontSize: 13,
    fontWeight: "500",
    marginBottom: Spacing.sm,
    textTransform: "uppercase",
  },
  selectButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
  },
  selectedClient: {
    flexDirection: "row",
    alignItems: "center",
    flex: 1,
    gap: Spacing.sm,
  },
  clientAvatar: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: "center",
    alignItems: "center",
  },
  avatarText: {
    color: "#fff",
    fontSize: 14,
    fontWeight: "600",
  },
  clientInfo: {
    flex: 1,
  },
  clientName: {
    fontSize: 15,
    fontWeight: "500",
  },
  clientPhone: {
    fontSize: 13,
    marginTop: 2,
  },
  clientPrice: {
    fontSize: 15,
    fontWeight: "600",
  },
  dateRow: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  dateColumn: {
    flex: 1,
  },
  inputLabel: {
    fontSize: 13,
    marginBottom: Spacing.xs,
  },
  dateButton: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
  },
  daysInfo: {
    marginTop: Spacing.sm,
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
  daysText: {
    fontSize: 15,
    fontWeight: "600",
  },
  inputRow: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginBottom: Spacing.sm,
  },
  inputColumn: {
    flex: 1,
  },
  input: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    fontSize: 16,
  },
  textArea: {
    minHeight: 80,
    textAlignVertical: "top",
  },
  checkButton: {
    height: 44,
    borderRadius: BorderRadius.md,
    justifyContent: "center",
    alignItems: "center",
  },
  totalRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
  },
  totalLabel: {
    fontSize: 15,
  },
  totalValue: {
    fontSize: 20,
    fontWeight: "700",
  },
  actions: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginTop: Spacing.md,
  },
  cancelBtn: {
    flex: 1,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
  saveBtn: {
    flex: 2,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
  pickerModal: {
    flex: 1,
    justifyContent: "flex-end",
  },
  pickerContent: {
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    paddingBottom: 40,
  },
  pickerHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.md,
    borderBottomWidth: 1,
    borderBottomColor: "rgba(0,0,0,0.1)",
  },
  pickerTitle: {
    fontSize: 17,
    fontWeight: "600",
  },
  modalOverlay: {
    flex: 1,
    justifyContent: "flex-end",
  },
  modalContent: {
    maxHeight: "80%",
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.md,
    borderBottomWidth: 1,
    borderBottomColor: "rgba(0,0,0,0.1)",
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  searchBox: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.lg,
    gap: Spacing.sm,
  },
  searchInput: {
    flex: 1,
    fontSize: 16,
    paddingVertical: Spacing.xs,
  },
  clientItem: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.sm,
    gap: Spacing.sm,
  },
  emptyContainer: {
    padding: Spacing.xl,
    alignItems: "center",
  },
});
