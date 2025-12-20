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
  KeyboardAvoidingView,
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
import { useRental, RentalClient, RentalService } from "@/contexts/RentalContext";
import { useAuth } from "@/contexts/AuthContext";
import { useData, RadioGuideKit } from "@/contexts/DataContext";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";
import { hapticFeedback } from "@/utils/haptics";

type RouteParams = RouteProp<SettingsStackParamList, "AddRentalOrder">;

export default function AddRentalOrderScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation();
  const route = useRoute<RouteParams>();
  const insets = useSafeAreaInsets();
  const { rentalClients, rentalOrders, rentalServices, getOrderServices, addRentalOrder, updateRentalOrder, isLoading: isRentalLoading } = useRental();
  const { profile, managers } = useAuth();
  const { radioGuideKits, radioGuideAssignments, isLoading: isDataLoading } = useData();

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
    existingOrder ? (existingOrder.spareReceiverCount?.toString() ?? "0") : "1"
  );
  const [spareReceiverAutoSet, setSpareReceiverAutoSet] = useState(!existingOrder);
  const [transmitterCount, setTransmitterCount] = useState(existingOrder?.transmitterCount?.toString() || "1");
  const [microphoneCount, setMicrophoneCount] = useState(existingOrder?.microphoneCount?.toString() || "1");
  const [selectedBags, setSelectedBags] = useState<RadioGuideKit[]>([]);
  const [showBagPicker, setShowBagPicker] = useState(false);
  const [bagSearchQuery, setBagSearchQuery] = useState("");
  const [bagsInitialized, setBagsInitialized] = useState(false);
  const [unmatchedBagNumbers, setUnmatchedBagNumbers] = useState<number[]>([]);

  useEffect(() => {
    if (bagsInitialized) return;
    
    const dataReady = !isDataLoading && !isRentalLoading;
    if (!dataReady) return;
    
    if (orderId) {
      if (!existingOrder) return;
      
      if (existingOrder.bagNumber) {
        const bagNumbers = existingOrder.bagNumber.split(',').map(s => parseInt(s.trim())).filter(n => !isNaN(n));
        const foundBags = radioGuideKits.filter(k => bagNumbers.includes(k.bagNumber));
        const foundBagNumbers = foundBags.map(b => b.bagNumber);
        const unmatched = bagNumbers.filter(n => !foundBagNumbers.includes(n));
        setSelectedBags(foundBags);
        setUnmatchedBagNumbers(unmatched);
      }
    }
    setBagsInitialized(true);
  }, [radioGuideKits, existingOrder, bagsInitialized, isDataLoading, isRentalLoading, orderId]);
  const [pricePerUnit, setPricePerUnit] = useState(existingOrder?.pricePerUnit?.toString() || selectedClient?.defaultPrice?.toString() || "100");
  const [prepayment, setPrepayment] = useState(existingOrder?.prepayment?.toString() || "0");
  const [receiverNotes, setReceiverNotes] = useState(existingOrder?.receiverNotes || "");

  const existingOrderServices = orderId ? getOrderServices(orderId) : [];
  const [selectedServices, setSelectedServices] = useState<{ [serviceId: string]: number }>(() => {
    const initial: { [serviceId: string]: number } = {};
    existingOrderServices.forEach(os => {
      initial[os.serviceId] = os.quantity;
    });
    return initial;
  });

  const [oneTimeServices, setOneTimeServices] = useState<{ name: string; price: number }[]>([]);
  const [newOneTimeName, setNewOneTimeName] = useState("");
  const [newOneTimePrice, setNewOneTimePrice] = useState("");

  const activeServices = useMemo(() => {
    return rentalServices.filter(s => s.isActive);
  }, [rentalServices]);

  // Filter available bags: exclude rented and overdue
  const availableBagsForRental = useMemo(() => {
    const today = new Date().toISOString().split("T")[0];
    
    // Get bag numbers in active rentals (excluding current order being edited)
    const rentalBagNumbers = new Set<number>();
    rentalOrders.filter(o => o.status === "issued" && o.id !== orderId).forEach(order => {
      if (order.bagNumber) {
        order.bagNumber.split(",").forEach(bagStr => {
          const bagNum = parseInt(bagStr.trim());
          if (!isNaN(bagNum)) rentalBagNumbers.add(bagNum);
        });
      }
    });
    
    // Get kit IDs with overdue assignments
    const overdueKitIds = new Set<string>();
    radioGuideAssignments.filter(a => a.returnedAt === null).forEach(a => {
      const issuedDate = a.issuedAt.split("T")[0];
      if (issuedDate < today) overdueKitIds.add(a.kitId);
    });
    
    return radioGuideKits.filter(kit => 
      kit.status === 'available' && 
      !rentalBagNumbers.has(kit.bagNumber) &&
      !overdueKitIds.has(kit.id) &&
      !selectedBags.find(b => b.id === kit.id)
    );
  }, [radioGuideKits, rentalOrders, radioGuideAssignments, selectedBags, orderId]);

  const servicesTotal = useMemo(() => {
    let total = 0;
    Object.entries(selectedServices).forEach(([serviceId, quantity]) => {
      const service = rentalServices.find(s => s.id === serviceId);
      if (service && quantity > 0) {
        total += service.price * quantity;
      }
    });
    oneTimeServices.forEach(s => {
      total += s.price;
    });
    return total;
  }, [selectedServices, rentalServices, oneTimeServices]);

  const handleAddOneTimeService = () => {
    const name = newOneTimeName.trim();
    const price = parseInt(newOneTimePrice, 10) || 0;
    if (!name) {
      Alert.alert("Ошибка", "Введите название услуги");
      return;
    }
    if (price <= 0) {
      Alert.alert("Ошибка", "Введите корректную цену");
      return;
    }
    setOneTimeServices(prev => [...prev, { name, price }]);
    setNewOneTimeName("");
    setNewOneTimePrice("");
    hapticFeedback.selection();
  };

  const handleRemoveOneTimeService = (index: number) => {
    setOneTimeServices(prev => prev.filter((_, i) => i !== index));
    hapticFeedback.selection();
  };

  const handleServiceQuantityInput = (serviceId: string, value: string) => {
    const qty = parseInt(value, 10) || 0;
    setSelectedServices(prev => {
      if (qty <= 0) {
        const { [serviceId]: _, ...rest } = prev;
        return rest;
      }
      return { ...prev, [serviceId]: qty };
    });
  };

  const daysCount = useMemo(() => {
    const diffTime = endDate.getTime() - startDate.getTime();
    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
    return Math.max(1, diffDays);
  }, [startDate, endDate]);

  useEffect(() => {
    if (spareReceiverAutoSet) {
      setSpareReceiverCount(daysCount >= 2 ? "2" : "1");
    }
  }, [daysCount, spareReceiverAutoSet]);

  const handleSpareReceiverChange = (value: string) => {
    setSpareReceiverCount(value);
    setSpareReceiverAutoSet(false);
  };

  const equipmentPrice = useMemo(() => {
    const kits = parseInt(kitCount) || 0;
    const price = parseFloat(pricePerUnit) || 0;
    return kits * price * daysCount;
  }, [kitCount, pricePerUnit, daysCount]);

  const totalPrice = useMemo(() => {
    return equipmentPrice + servicesTotal;
  }, [equipmentPrice, servicesTotal]);

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

    const servicesToSave = Object.entries(selectedServices)
      .filter(([_, qty]) => qty > 0)
      .map(([serviceId, quantity]) => ({ serviceId, quantity }));

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
          bagNumber: [...selectedBags.map(b => b.bagNumber), ...unmatchedBagNumbers].length > 0 
            ? [...selectedBags.map(b => b.bagNumber), ...unmatchedBagNumbers].join(', ') 
            : null,
          isCharged: selectedBags.length > 0 && selectedBags.every(b => b.batteryLevel === 'full'),
          pricePerUnit: parseFloat(pricePerUnit) || 100,
          totalPrice,
          prepayment: parseFloat(prepayment) || 0,
          receiverNotes: receiverNotes.trim() || null,
        }, servicesToSave);
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
          bagNumber: [...selectedBags.map(b => b.bagNumber), ...unmatchedBagNumbers].length > 0 
            ? [...selectedBags.map(b => b.bagNumber), ...unmatchedBagNumbers].join(', ') 
            : null,
          isCharged: selectedBags.length > 0 && selectedBags.every(b => b.batteryLevel === 'full'),
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
        }, servicesToSave);
      }

      hapticFeedback.success();
      navigation.goBack();
    } catch (error: unknown) {
      console.error("Error saving order:", error);
      let errorMessage = "Неизвестная ошибка";
      if (error instanceof Error) {
        errorMessage = error.message;
      } else if (error && typeof error === "object" && "message" in error) {
        errorMessage = String((error as { message: unknown }).message);
      } else if (error && typeof error === "object" && "details" in error) {
        errorMessage = String((error as { details: unknown }).details);
      } else if (typeof error === "string") {
        errorMessage = error;
      }
      Alert.alert("Ошибка", `${isEditMode ? "Не удалось обновить заказ" : "Не удалось создать заказ"}: ${errorMessage}`);
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
                onChangeText={handleSpareReceiverChange}
                placeholder="1"
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

          <View style={styles.bagSection}>
            <View style={styles.bagHeader}>
              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Сумки с оборудованием
              </ThemedText>
              <Pressable
                onPress={() => setShowBagPicker(true)}
                style={[styles.addBagButton, { backgroundColor: theme.primary + "20" }]}
              >
                <Icon name="plus" size={16} color={theme.primary} />
                <ThemedText style={[styles.addBagText, { color: theme.primary }]}>
                  Добавить
                </ThemedText>
              </Pressable>
            </View>
            {selectedBags.length > 0 || unmatchedBagNumbers.length > 0 ? (
              <View style={styles.selectedBagsContainer}>
                {selectedBags.map((bag) => {
                  const batteryColor = bag.batteryLevel === 'full' ? theme.success : 
                    bag.batteryLevel === 'half' ? theme.warning : theme.error;
                  const batteryIcon = bag.batteryLevel === 'full' ? 'battery' : 
                    bag.batteryLevel === 'half' ? 'battery' : 'battery';
                  return (
                    <View key={bag.id} style={[styles.selectedBagChip, { backgroundColor: theme.backgroundTertiary }]}>
                      <ThemedText style={styles.bagChipText}>
                        Сумка {bag.bagNumber}
                      </ThemedText>
                      <View style={styles.batteryIndicator}>
                        <Icon name={batteryIcon} size={14} color={batteryColor} />
                        <ThemedText style={[styles.batteryText, { color: batteryColor }]}>
                          {bag.batteryLevel === 'full' ? '100%' : bag.batteryLevel === 'half' ? '50%' : 'Низкий'}
                        </ThemedText>
                      </View>
                      <Pressable
                        onPress={() => {
                          setSelectedBags(prev => prev.filter(b => b.id !== bag.id));
                          hapticFeedback.selection();
                        }}
                        hitSlop={8}
                      >
                        <Icon name="x" size={16} color={theme.textSecondary} />
                      </Pressable>
                    </View>
                  );
                })}
                {unmatchedBagNumbers.map((bagNum) => (
                  <View key={`unmatched-${bagNum}`} style={[styles.selectedBagChip, { backgroundColor: theme.warning + "30" }]}>
                    <ThemedText style={styles.bagChipText}>
                      Сумка {bagNum}
                    </ThemedText>
                    <ThemedText style={[styles.batteryText, { color: theme.warning }]}>
                      (не найдена)
                    </ThemedText>
                    <Pressable
                      onPress={() => {
                        setUnmatchedBagNumbers(prev => prev.filter(n => n !== bagNum));
                        hapticFeedback.selection();
                      }}
                      hitSlop={8}
                    >
                      <Icon name="x" size={16} color={theme.textSecondary} />
                    </Pressable>
                  </View>
                ))}
              </View>
            ) : (
              <ThemedText style={[styles.noBagsText, { color: theme.textSecondary }]}>
                Сумки не выбраны
              </ThemedText>
            )}
          </View>
        </View>

        {activeServices.length > 0 ? (
          <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
              Дополнительные услуги
            </ThemedText>

            {activeServices.map((service) => {
              const qty = selectedServices[service.id] || 0;
              return (
                <View key={service.id} style={styles.serviceRow}>
                  <View style={styles.serviceInfo}>
                    <ThemedText style={styles.serviceName}>{service.name}</ThemedText>
                    <ThemedText style={[styles.servicePrice, { color: theme.success }]}>
                      {service.price.toLocaleString("ru-RU")} р.
                    </ThemedText>
                  </View>
                  <TextInput
                    style={[styles.serviceQtyInput, { backgroundColor: theme.backgroundTertiary, color: theme.text, borderColor: theme.border }]}
                    value={qty > 0 ? qty.toString() : ""}
                    onChangeText={(value) => handleServiceQuantityInput(service.id, value)}
                    placeholder="0"
                    placeholderTextColor={theme.textSecondary}
                    keyboardType="numeric"
                  />
                </View>
              );
            })}

          </View>
        ) : null}

        <View style={[styles.card, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
            Разовые услуги (без комиссии)
          </ThemedText>

          {oneTimeServices.map((service, index) => (
            <View key={index} style={styles.serviceRow}>
              <View style={styles.serviceInfo}>
                <ThemedText style={styles.serviceName}>{service.name}</ThemedText>
                <ThemedText style={[styles.servicePrice, { color: theme.success }]}>
                  {service.price.toLocaleString("ru-RU")} р.
                </ThemedText>
              </View>
              <Pressable
                onPress={() => handleRemoveOneTimeService(index)}
                style={[styles.removeBtn, { backgroundColor: theme.error + "20" }]}
              >
                <Icon name="x" size={16} color={theme.error} />
              </Pressable>
            </View>
          ))}

          <View style={styles.addOneTimeRow}>
            <TextInput
              style={[styles.oneTimeNameInput, { backgroundColor: theme.backgroundTertiary, color: theme.text, borderColor: theme.border }]}
              value={newOneTimeName}
              onChangeText={setNewOneTimeName}
              placeholder="Название"
              placeholderTextColor={theme.textSecondary}
            />
            <TextInput
              style={[styles.oneTimePriceInput, { backgroundColor: theme.backgroundTertiary, color: theme.text, borderColor: theme.border }]}
              value={newOneTimePrice}
              onChangeText={setNewOneTimePrice}
              placeholder="Цена"
              placeholderTextColor={theme.textSecondary}
              keyboardType="numeric"
            />
            <Pressable
              onPress={handleAddOneTimeService}
              style={[styles.addOneTimeBtn, { backgroundColor: theme.primary }]}
            >
              <Icon name="plus" size={18} color="#FFFFFF" />
            </Pressable>
          </View>

          {servicesTotal > 0 ? (
            <View style={[styles.serviceSubtotal, { borderTopColor: theme.border }]}>
              <ThemedText style={{ color: theme.textSecondary }}>Услуги:</ThemedText>
              <ThemedText style={{ color: theme.success, fontWeight: "600" }}>
                +{servicesTotal.toLocaleString("ru-RU")}₽
              </ThemedText>
            </View>
          ) : null}
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

      <Modal visible={showBagPicker} animationType="slide" transparent>
        <KeyboardAvoidingView 
          behavior={Platform.OS === "ios" ? "padding" : "height"}
          style={{ flex: 1 }}
        >
          <View style={[styles.modalOverlay, { backgroundColor: "rgba(0,0,0,0.5)" }]}>
            <View style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
              <View style={styles.modalHeader}>
                <ThemedText style={styles.modalTitle}>Выберите сумку</ThemedText>
                <Pressable onPress={() => { setShowBagPicker(false); setBagSearchQuery(""); }}>
                  <Icon name="x" size={24} color={theme.text} />
                </Pressable>
              </View>

              <View style={[styles.bagSearchBox, { backgroundColor: theme.backgroundSecondary }]}>
                <Icon name="search" size={18} color={theme.textSecondary} />
                <TextInput
                  style={[styles.bagSearchInput, { color: theme.text }]}
                  value={bagSearchQuery}
                  onChangeText={setBagSearchQuery}
                  placeholder="Поиск по номеру сумки..."
                  placeholderTextColor={theme.textSecondary}
                  keyboardType="number-pad"
                />
                {bagSearchQuery ? (
                  <Pressable onPress={() => setBagSearchQuery("")}>
                    <Icon name="x" size={18} color={theme.textSecondary} />
                  </Pressable>
                ) : null}
              </View>

              <FlatList
              data={bagSearchQuery.trim() ? availableBagsForRental.filter(k => k.bagNumber.toString().includes(bagSearchQuery.trim())) : availableBagsForRental}
              keyExtractor={(item) => item.id}
              contentContainerStyle={{ padding: Spacing.md }}
              renderItem={({ item }) => {
                const batteryColor = item.batteryLevel === 'full' ? theme.success : 
                  item.batteryLevel === 'half' ? theme.warning : theme.error;
                return (
                  <Pressable
                    onPress={() => {
                      setSelectedBags(prev => [...prev, item]);
                      setShowBagPicker(false);
                      hapticFeedback.selection();
                    }}
                    style={[styles.bagItem, { backgroundColor: theme.backgroundSecondary }]}
                  >
                    <View style={[styles.bagIcon, { backgroundColor: theme.primary + "20" }]}>
                      <Icon name="briefcase" size={20} color={theme.primary} />
                    </View>
                    <View style={styles.bagInfo}>
                      <ThemedText style={styles.bagName}>Сумка {item.bagNumber}</ThemedText>
                      <View style={styles.bagDetails}>
                        <View style={styles.batteryRow}>
                          <Icon name="battery" size={14} color={batteryColor} />
                          <ThemedText style={[styles.batteryLabel, { color: batteryColor }]}>
                            {item.batteryLevel === 'full' ? 'Полный заряд' : 
                              item.batteryLevel === 'half' ? 'Средний заряд' : 'Низкий заряд'}
                          </ThemedText>
                        </View>
                      </View>
                    </View>
                    <Icon name="plus-circle" size={24} color={theme.primary} />
                  </Pressable>
                );
              }}
              ListEmptyComponent={
                <View style={styles.emptyContainer}>
                  <Icon name="briefcase" size={48} color={theme.textSecondary} style={{ opacity: 0.5, marginBottom: Spacing.md }} />
                  <ThemedText style={{ color: theme.textSecondary, textAlign: 'center' }}>
                    Нет доступных сумок
                  </ThemedText>
                </View>
              }
              />
            </View>
          </View>
        </KeyboardAvoidingView>
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
  serviceRow: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingVertical: Spacing.sm,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: "rgba(255,255,255,0.1)",
  },
  serviceInfo: {
    flex: 1,
  },
  serviceName: {
    fontSize: 15,
    fontWeight: "500",
  },
  servicePrice: {
    fontSize: 13,
    marginTop: 2,
  },
  quantityControls: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  qtyButton: {
    width: 32,
    height: 32,
    borderRadius: 16,
    justifyContent: "center",
    alignItems: "center",
  },
  qtyText: {
    fontSize: 16,
    fontWeight: "600",
    minWidth: 24,
    textAlign: "center",
  },
  serviceSubtotal: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingTop: Spacing.md,
    marginTop: Spacing.sm,
    borderTopWidth: StyleSheet.hairlineWidth,
  },
  serviceQtyInput: {
    width: 60,
    height: 36,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    textAlign: "center",
    fontSize: 14,
  },
  removeBtn: {
    width: 32,
    height: 32,
    borderRadius: 16,
    justifyContent: "center",
    alignItems: "center",
  },
  addOneTimeRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    marginTop: Spacing.sm,
  },
  oneTimeNameInput: {
    flex: 1,
    height: 40,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    paddingHorizontal: Spacing.sm,
    fontSize: 14,
  },
  oneTimePriceInput: {
    width: 80,
    height: 40,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    paddingHorizontal: Spacing.sm,
    fontSize: 14,
    textAlign: "center",
  },
  addOneTimeBtn: {
    width: 40,
    height: 40,
    borderRadius: BorderRadius.sm,
    justifyContent: "center",
    alignItems: "center",
  },
  bagSection: {
    marginTop: Spacing.sm,
  },
  bagHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.sm,
  },
  addBagButton: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.sm,
    gap: 4,
  },
  addBagText: {
    fontSize: 13,
    fontWeight: "500",
  },
  selectedBagsContainer: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.sm,
  },
  selectedBagChip: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.md,
    gap: Spacing.xs,
  },
  bagChipText: {
    fontSize: 14,
    fontWeight: "500",
  },
  batteryIndicator: {
    flexDirection: "row",
    alignItems: "center",
    gap: 2,
  },
  batteryText: {
    fontSize: 12,
  },
  noBagsText: {
    fontSize: 14,
    fontStyle: "italic",
  },
  bagItem: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.sm,
    gap: Spacing.sm,
  },
  bagIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: "center",
    alignItems: "center",
  },
  bagInfo: {
    flex: 1,
  },
  bagName: {
    fontSize: 16,
    fontWeight: "500",
  },
  bagDetails: {
    marginTop: 2,
  },
  batteryRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: 4,
  },
  batteryLabel: {
    fontSize: 13,
  },
  bagSearchBox: {
    flexDirection: "row",
    alignItems: "center",
    marginHorizontal: Spacing.md,
    marginBottom: Spacing.sm,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
  },
  bagSearchInput: {
    flex: 1,
    fontSize: 15,
    paddingVertical: Spacing.xs,
  },
});
