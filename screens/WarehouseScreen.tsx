import { useState, useMemo } from "react";
import {
  View,
  StyleSheet,
  Pressable,
  Alert,
  TextInput,
  Modal,
  ScrollView,
  Platform,
} from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import DateTimePicker, { DateTimePickerEvent } from "@react-native-community/datetimepicker";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, EquipmentCategory, EquipmentItem, EquipmentMovement } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";

type TabType = "inventory" | "movements" | "categories";
type MovementType = "receipt" | "writeoff" | "repair_out" | "repair_in" | "found" | "adjustment";

const MOVEMENT_LABELS: Record<MovementType, string> = {
  receipt: "Поступление",
  writeoff: "Списание",
  repair_out: "В ремонт",
  repair_in: "Из ремонта",
  found: "Найдено",
  adjustment: "Корректировка",
};

const MOVEMENT_COLORS: Record<MovementType, string> = {
  receipt: "#4CAF50",
  writeoff: "#F44336",
  repair_out: "#FF9800",
  repair_in: "#2196F3",
  found: "#9C27B0",
  adjustment: "#607D8B",
};

export default function WarehouseScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const insets = useSafeAreaInsets();
  const {
    equipmentCategories,
    equipmentItems,
    equipmentMovements,
    addEquipmentCategory,
    updateEquipmentCategory,
    deleteEquipmentCategory,
    addEquipmentItem,
    updateEquipmentItem,
    deleteEquipmentItem,
    addEquipmentMovement,
  } = useData();

  const [activeTab, setActiveTab] = useState<TabType>("inventory");
  const [showCategoryModal, setShowCategoryModal] = useState(false);
  const [showItemModal, setShowItemModal] = useState(false);
  const [showMovementModal, setShowMovementModal] = useState(false);
  const [editingCategory, setEditingCategory] = useState<EquipmentCategory | null>(null);
  const [editingItem, setEditingItem] = useState<EquipmentItem | null>(null);
  const [selectedItem, setSelectedItem] = useState<EquipmentItem | null>(null);
  
  const [categoryName, setCategoryName] = useState("");
  const [categoryType, setCategoryType] = useState<"equipment" | "consumable">("equipment");
  const [categoryUnit, setCategoryUnit] = useState("шт");
  
  const [itemName, setItemName] = useState("");
  const [itemCategoryId, setItemCategoryId] = useState("");
  const [itemQuantity, setItemQuantity] = useState("");
  const [itemMinQuantity, setItemMinQuantity] = useState("");
  
  const [movementType, setMovementType] = useState<MovementType>("receipt");
  const [movementQuantity, setMovementQuantity] = useState("");
  const [movementNote, setMovementNote] = useState("");
  
  const [filterDate, setFilterDate] = useState<Date | null>(null);
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [searchQuery, setSearchQuery] = useState("");

  const getCategoryById = (id: string) => equipmentCategories.find(c => c.id === id);

  const filteredItems = useMemo(() => {
    let items = [...equipmentItems];
    if (searchQuery) {
      const q = searchQuery.toLowerCase();
      items = items.filter(i => 
        i.name.toLowerCase().includes(q) ||
        getCategoryById(i.categoryId)?.name.toLowerCase().includes(q)
      );
    }
    return items.sort((a, b) => a.name.localeCompare(b.name));
  }, [equipmentItems, searchQuery, equipmentCategories]);

  const filteredMovements = useMemo(() => {
    let movements = [...equipmentMovements];
    if (filterDate) {
      const dateStr = filterDate.toISOString().split("T")[0];
      movements = movements.filter(m => m.createdAt.startsWith(dateStr));
    }
    return movements.sort((a, b) => 
      new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime()
    );
  }, [equipmentMovements, filterDate]);

  const lowStockItems = useMemo(() => {
    return equipmentItems.filter(i => i.quantity <= i.minQuantity && i.minQuantity > 0);
  }, [equipmentItems]);

  const categoryStats = useMemo(() => {
    return equipmentCategories.map(cat => {
      const items = equipmentItems.filter(i => i.categoryId === cat.id);
      const totalQuantity = items.reduce((sum, i) => sum + i.quantity, 0);
      const totalInRepair = items.reduce((sum, i) => sum + i.inRepair, 0);
      const totalWrittenOff = items.reduce((sum, i) => sum + i.writtenOff, 0);
      const lowStockCount = items.filter(i => i.quantity <= i.minQuantity && i.minQuantity > 0).length;
      return {
        category: cat,
        itemCount: items.length,
        totalQuantity,
        totalInRepair,
        totalWrittenOff,
        lowStockCount,
      };
    });
  }, [equipmentCategories, equipmentItems]);

  const totalStats = useMemo(() => {
    const totalQuantity = equipmentItems.reduce((sum, i) => sum + i.quantity, 0);
    const totalInRepair = equipmentItems.reduce((sum, i) => sum + i.inRepair, 0);
    const totalWrittenOff = equipmentItems.reduce((sum, i) => sum + i.writtenOff, 0);
    return { totalQuantity, totalInRepair, totalWrittenOff, itemCount: equipmentItems.length };
  }, [equipmentItems]);

  const resetCategoryForm = () => {
    setCategoryName("");
    setCategoryType("equipment");
    setCategoryUnit("шт");
    setEditingCategory(null);
  };

  const resetItemForm = () => {
    setItemName("");
    setItemCategoryId("");
    setItemQuantity("");
    setItemMinQuantity("");
    setEditingItem(null);
  };

  const resetMovementForm = () => {
    setMovementType("receipt");
    setMovementQuantity("");
    setMovementNote("");
    setSelectedItem(null);
  };

  const handleSaveCategory = async () => {
    if (!categoryName.trim()) {
      Alert.alert("Ошибка", "Введите название категории");
      return;
    }

    try {
      if (editingCategory) {
        await updateEquipmentCategory(editingCategory.id, {
          name: categoryName.trim(),
          type: categoryType,
          unit: categoryUnit.trim(),
        });
      } else {
        await addEquipmentCategory({
          name: categoryName.trim(),
          type: categoryType,
          unit: categoryUnit.trim(),
          isActive: true,
        });
      }
      setShowCategoryModal(false);
      resetCategoryForm();
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось сохранить категорию");
    }
  };

  const handleDeleteCategory = (category: EquipmentCategory) => {
    const itemsInCategory = equipmentItems.filter(i => i.categoryId === category.id);
    if (itemsInCategory.length > 0) {
      Alert.alert("Ошибка", "Нельзя удалить категорию с товарами");
      return;
    }

    Alert.alert(
      "Удалить категорию?",
      `Категория "${category.name}" будет удалена`,
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Удалить",
          style: "destructive",
          onPress: async () => {
            try {
              await deleteEquipmentCategory(category.id);
            } catch (err) {
              Alert.alert("Ошибка", "Не удалось удалить категорию");
            }
          },
        },
      ]
    );
  };

  const handleSaveItem = async () => {
    if (!itemName.trim()) {
      Alert.alert("Ошибка", "Введите название");
      return;
    }
    if (!itemCategoryId) {
      Alert.alert("Ошибка", "Выберите категорию");
      return;
    }

    try {
      const quantity = parseInt(itemQuantity) || 0;
      const minQuantity = parseInt(itemMinQuantity) || 0;

      if (editingItem) {
        await updateEquipmentItem(editingItem.id, {
          name: itemName.trim(),
          categoryId: itemCategoryId,
          minQuantity,
        });
      } else {
        await addEquipmentItem({
          name: itemName.trim(),
          categoryId: itemCategoryId,
          quantity,
          inRepair: 0,
          writtenOff: 0,
          minQuantity,
        });
      }
      setShowItemModal(false);
      resetItemForm();
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось сохранить");
    }
  };

  const handleDeleteItem = (item: EquipmentItem) => {
    Alert.alert(
      "Удалить оборудование?",
      `"${item.name}" и вся история движений будут удалены`,
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Удалить",
          style: "destructive",
          onPress: async () => {
            try {
              await deleteEquipmentItem(item.id);
            } catch (err) {
              Alert.alert("Ошибка", "Не удалось удалить");
            }
          },
        },
      ]
    );
  };

  const handleSaveMovement = async () => {
    if (!selectedItem) {
      Alert.alert("Ошибка", "Выберите оборудование");
      return;
    }
    const qty = parseInt(movementQuantity);
    if (!qty || qty <= 0) {
      Alert.alert("Ошибка", "Введите корректное количество");
      return;
    }

    if (movementType === "writeoff" || movementType === "repair_out") {
      if (qty > selectedItem.quantity) {
        Alert.alert("Ошибка", "Недостаточно на складе");
        return;
      }
    }
    if (movementType === "repair_in" && qty > selectedItem.inRepair) {
      Alert.alert("Ошибка", "В ремонте меньше единиц");
      return;
    }

    try {
      await addEquipmentMovement({
        itemId: selectedItem.id,
        type: movementType,
        quantity: qty,
        note: movementNote.trim() || null,
      });
      setShowMovementModal(false);
      resetMovementForm();
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось сохранить движение");
    }
  };

  const openEditCategory = (category: EquipmentCategory) => {
    setEditingCategory(category);
    setCategoryName(category.name);
    setCategoryType(category.type);
    setCategoryUnit(category.unit);
    setShowCategoryModal(true);
  };

  const openEditItem = (item: EquipmentItem) => {
    setEditingItem(item);
    setItemName(item.name);
    setItemCategoryId(item.categoryId);
    setItemQuantity(item.quantity.toString());
    setItemMinQuantity(item.minQuantity.toString());
    setShowItemModal(true);
  };

  const openMovementForItem = (item: EquipmentItem) => {
    setSelectedItem(item);
    setShowMovementModal(true);
  };

  const handleDateChange = (event: DateTimePickerEvent, date?: Date) => {
    if (Platform.OS === "android") {
      setShowDatePicker(false);
    }
    if (event.type === "set" && date) {
      setFilterDate(date);
      if (Platform.OS === "ios") {
        setShowDatePicker(false);
      }
    } else if (event.type === "dismissed") {
      setShowDatePicker(false);
    }
  };

  const getItemById = (id: string) => equipmentItems.find(i => i.id === id);

  const styles = StyleSheet.create({
    container: {
      flex: 1,
      padding: Spacing.md,
    },
    tabContainer: {
      flexDirection: "row",
      marginBottom: Spacing.md,
      gap: Spacing.xs,
    },
    tab: {
      flex: 1,
      paddingVertical: Spacing.sm,
      paddingHorizontal: Spacing.md,
      borderRadius: BorderRadius.md,
      backgroundColor: theme.backgroundSecondary,
      alignItems: "center",
    },
    tabActive: {
      backgroundColor: theme.primary,
    },
    tabText: {
      fontSize: 13,
      color: theme.textSecondary,
    },
    tabTextActive: {
      color: "#FFFFFF",
      fontWeight: "600",
    },
    searchContainer: {
      flexDirection: "row",
      alignItems: "center",
      backgroundColor: theme.backgroundSecondary,
      borderRadius: BorderRadius.md,
      paddingHorizontal: Spacing.sm,
      marginBottom: Spacing.md,
    },
    searchInput: {
      flex: 1,
      paddingVertical: Spacing.sm,
      paddingHorizontal: Spacing.sm,
      color: theme.text,
      fontSize: 15,
    },
    alertBanner: {
      backgroundColor: theme.error + "20",
      padding: Spacing.sm,
      borderRadius: BorderRadius.md,
      marginBottom: Spacing.md,
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.sm,
    },
    card: {
      backgroundColor: theme.backgroundSecondary,
      borderRadius: BorderRadius.md,
      padding: Spacing.md,
      marginBottom: Spacing.sm,
    },
    cardHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.xs,
    },
    cardTitle: {
      fontSize: 16,
      fontWeight: "600",
      color: theme.text,
      flex: 1,
    },
    cardSubtitle: {
      fontSize: 13,
      color: theme.textSecondary,
    },
    badge: {
      paddingHorizontal: Spacing.sm,
      paddingVertical: 2,
      borderRadius: BorderRadius.sm,
    },
    badgeText: {
      fontSize: 12,
      fontWeight: "500",
    },
    statsRow: {
      flexDirection: "row",
      gap: Spacing.md,
      marginTop: Spacing.xs,
    },
    statItem: {
      flexDirection: "row",
      alignItems: "center",
      gap: 4,
    },
    statLabel: {
      fontSize: 12,
      color: theme.textSecondary,
    },
    statValue: {
      fontSize: 14,
      fontWeight: "600",
      color: theme.text,
    },
    actionsRow: {
      flexDirection: "row",
      gap: Spacing.sm,
      marginTop: Spacing.sm,
    },
    actionButton: {
      paddingHorizontal: Spacing.sm,
      paddingVertical: Spacing.xs,
      borderRadius: BorderRadius.sm,
      backgroundColor: theme.backgroundTertiary,
    },
    actionButtonPrimary: {
      backgroundColor: theme.primary,
    },
    fab: {
      position: "absolute",
      bottom: insets.bottom + 80 + Spacing.md,
      right: Spacing.xl,
      width: 56,
      height: 56,
      borderRadius: 28,
      backgroundColor: theme.primary,
      justifyContent: "center",
      alignItems: "center",
      elevation: 4,
      shadowColor: "#000",
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.25,
      shadowRadius: 4,
      zIndex: 100,
    },
    modalOverlay: {
      flex: 1,
      backgroundColor: "rgba(0,0,0,0.5)",
      justifyContent: "flex-end",
    },
    modalContent: {
      backgroundColor: theme.backgroundDefault,
      borderTopLeftRadius: BorderRadius.lg,
      borderTopRightRadius: BorderRadius.lg,
      padding: Spacing.lg,
      maxHeight: "80%",
    },
    modalTitle: {
      fontSize: 18,
      fontWeight: "600",
      color: theme.text,
      marginBottom: Spacing.md,
    },
    inputLabel: {
      fontSize: 14,
      color: theme.textSecondary,
      marginBottom: Spacing.xs,
    },
    input: {
      backgroundColor: theme.backgroundSecondary,
      borderRadius: BorderRadius.md,
      padding: Spacing.md,
      color: theme.text,
      fontSize: 15,
      marginBottom: Spacing.md,
    },
    selectRow: {
      flexDirection: "row",
      gap: Spacing.sm,
      marginBottom: Spacing.md,
    },
    selectOption: {
      flex: 1,
      padding: Spacing.sm,
      borderRadius: BorderRadius.md,
      backgroundColor: theme.backgroundSecondary,
      alignItems: "center",
    },
    selectOptionActive: {
      backgroundColor: theme.primary,
    },
    buttonRow: {
      flexDirection: "row",
      gap: Spacing.md,
      marginTop: Spacing.md,
    },
    button: {
      flex: 1,
      padding: Spacing.md,
      borderRadius: BorderRadius.md,
      alignItems: "center",
    },
    buttonPrimary: {
      backgroundColor: theme.primary,
    },
    buttonSecondary: {
      backgroundColor: theme.backgroundSecondary,
    },
    buttonText: {
      fontSize: 15,
      fontWeight: "600",
    },
    movementItem: {
      backgroundColor: theme.backgroundSecondary,
      borderRadius: BorderRadius.md,
      padding: Spacing.md,
      marginBottom: Spacing.sm,
    },
    movementHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
    },
    movementBadge: {
      paddingHorizontal: Spacing.sm,
      paddingVertical: 2,
      borderRadius: BorderRadius.sm,
    },
    categoryPicker: {
      flexDirection: "row",
      flexWrap: "wrap",
      gap: Spacing.sm,
      marginBottom: Spacing.md,
    },
    categoryOption: {
      paddingHorizontal: Spacing.md,
      paddingVertical: Spacing.sm,
      borderRadius: BorderRadius.md,
      backgroundColor: theme.backgroundSecondary,
    },
    categoryOptionActive: {
      backgroundColor: theme.primary,
    },
    filterRow: {
      flexDirection: "row",
      gap: Spacing.sm,
      marginBottom: Spacing.md,
      alignItems: "center",
    },
    filterButton: {
      flexDirection: "row",
      alignItems: "center",
      gap: Spacing.xs,
      paddingHorizontal: Spacing.sm,
      paddingVertical: Spacing.xs,
      borderRadius: BorderRadius.md,
      backgroundColor: theme.backgroundSecondary,
    },
    emptyText: {
      textAlign: "center",
      color: theme.textSecondary,
      marginTop: Spacing.xl,
    },
    summarySection: {
      marginBottom: Spacing.md,
    },
    summaryTitle: {
      fontSize: 14,
      fontWeight: "600",
      color: theme.textSecondary,
      marginBottom: Spacing.sm,
    },
    summaryGrid: {
      flexDirection: "row",
      flexWrap: "wrap",
      gap: Spacing.sm,
    },
    summaryCard: {
      backgroundColor: theme.backgroundSecondary,
      borderRadius: BorderRadius.md,
      padding: Spacing.sm,
      minWidth: "47%",
      flex: 1,
    },
    summaryCardHeader: {
      flexDirection: "row",
      justifyContent: "space-between",
      alignItems: "center",
      marginBottom: Spacing.xs,
    },
    summaryCardTitle: {
      fontSize: 13,
      fontWeight: "600",
      color: theme.text,
      flex: 1,
    },
    summaryCardValue: {
      fontSize: 18,
      fontWeight: "700",
      color: theme.primary,
    },
    summaryCardStats: {
      flexDirection: "row",
      flexWrap: "wrap",
      gap: Spacing.xs,
    },
    summaryCardStat: {
      fontSize: 11,
      color: theme.textSecondary,
    },
    totalCard: {
      backgroundColor: theme.primary + "15",
      borderRadius: BorderRadius.md,
      padding: Spacing.md,
      marginBottom: Spacing.md,
    },
    totalCardRow: {
      flexDirection: "row",
      justifyContent: "space-around",
    },
    totalCardItem: {
      alignItems: "center",
    },
    totalCardLabel: {
      fontSize: 12,
      color: theme.textSecondary,
    },
    totalCardValue: {
      fontSize: 20,
      fontWeight: "700",
      color: theme.text,
    },
  });

  const renderInventoryTab = () => (
    <View>
      {/* Общая сводка */}
      <View style={styles.totalCard}>
        <View style={styles.totalCardRow}>
          <View style={styles.totalCardItem}>
            <ThemedText style={styles.totalCardValue}>{totalStats.itemCount}</ThemedText>
            <ThemedText style={styles.totalCardLabel}>Позиций</ThemedText>
          </View>
          <View style={styles.totalCardItem}>
            <ThemedText style={styles.totalCardValue}>{totalStats.totalQuantity}</ThemedText>
            <ThemedText style={styles.totalCardLabel}>На складе</ThemedText>
          </View>
          <View style={styles.totalCardItem}>
            <ThemedText style={[styles.totalCardValue, { color: theme.warning }]}>{totalStats.totalInRepair}</ThemedText>
            <ThemedText style={styles.totalCardLabel}>В ремонте</ThemedText>
          </View>
          <View style={styles.totalCardItem}>
            <ThemedText style={[styles.totalCardValue, { color: theme.error }]}>{totalStats.totalWrittenOff}</ThemedText>
            <ThemedText style={styles.totalCardLabel}>Списано</ThemedText>
          </View>
        </View>
      </View>

      {/* Сводка по категориям */}
      {categoryStats.length > 0 && (
        <View style={styles.summarySection}>
          <ThemedText style={styles.summaryTitle}>По категориям</ThemedText>
          <View style={styles.summaryGrid}>
            {categoryStats.map((stat) => (
              <View key={stat.category.id} style={styles.summaryCard}>
                <View style={styles.summaryCardHeader}>
                  <ThemedText style={styles.summaryCardTitle} numberOfLines={1}>
                    {stat.category.name}
                  </ThemedText>
                  <ThemedText style={styles.summaryCardValue}>{stat.totalQuantity}</ThemedText>
                </View>
                <View style={styles.summaryCardStats}>
                  <ThemedText style={styles.summaryCardStat}>
                    {stat.itemCount} поз.
                  </ThemedText>
                  {stat.totalInRepair > 0 ? (
                    <ThemedText style={[styles.summaryCardStat, { color: theme.warning }]}>
                      {stat.totalInRepair} рем.
                    </ThemedText>
                  ) : null}
                  {stat.lowStockCount > 0 ? (
                    <ThemedText style={[styles.summaryCardStat, { color: theme.error }]}>
                      {stat.lowStockCount} мало
                    </ThemedText>
                  ) : null}
                </View>
              </View>
            ))}
          </View>
        </View>
      )}

      <View style={styles.searchContainer}>
        <Icon name="search" size={20} color={theme.textSecondary} />
        <TextInput
          style={styles.searchInput}
          placeholder="Поиск..."
          placeholderTextColor={theme.textSecondary}
          value={searchQuery}
          onChangeText={setSearchQuery}
        />
      </View>

      {lowStockItems.length > 0 && (
        <View style={styles.alertBanner}>
          <Icon name="alert-triangle" size={20} color={theme.error} />
          <ThemedText style={{ color: theme.error, fontSize: 13, flex: 1 }}>
            {lowStockItems.length} позиций с низким остатком
          </ThemedText>
        </View>
      )}

      {filteredItems.length === 0 ? (
        <ThemedText style={styles.emptyText}>
          Нет оборудования. Добавьте первую позицию.
        </ThemedText>
      ) : (
        filteredItems.map((item) => {
          const category = getCategoryById(item.categoryId);
          const isLow = item.quantity <= item.minQuantity && item.minQuantity > 0;
          
          return (
            <View key={item.id} style={styles.card}>
              <View style={styles.cardHeader}>
                <ThemedText style={styles.cardTitle}>{item.name}</ThemedText>
                <View style={[styles.badge, { backgroundColor: isLow ? theme.error + "30" : theme.success + "30" }]}>
                  <ThemedText style={[styles.badgeText, { color: isLow ? theme.error : theme.success }]}>
                    {item.quantity} {category?.unit || "шт"}
                  </ThemedText>
                </View>
              </View>
              
              <ThemedText style={styles.cardSubtitle}>
                {category?.name || "Без категории"}
              </ThemedText>

              <View style={styles.statsRow}>
                {item.inRepair > 0 && (
                  <View style={styles.statItem}>
                    <Icon name="tool" size={14} color={theme.warning} />
                    <ThemedText style={[styles.statLabel, { color: theme.warning }]}>
                      В ремонте: {item.inRepair}
                    </ThemedText>
                  </View>
                )}
                {item.writtenOff > 0 && (
                  <View style={styles.statItem}>
                    <Icon name="trash-2" size={14} color={theme.error} />
                    <ThemedText style={[styles.statLabel, { color: theme.error }]}>
                      Списано: {item.writtenOff}
                    </ThemedText>
                  </View>
                )}
                {item.minQuantity > 0 && (
                  <View style={styles.statItem}>
                    <ThemedText style={styles.statLabel}>
                      Мин: {item.minQuantity}
                    </ThemedText>
                  </View>
                )}
              </View>

              <View style={styles.actionsRow}>
                <Pressable
                  style={[styles.actionButton, styles.actionButtonPrimary]}
                  onPress={() => openMovementForItem(item)}
                >
                  <ThemedText style={{ color: "#FFF", fontSize: 13 }}>Движение</ThemedText>
                </Pressable>
                {isAdmin && (
                  <>
                    <Pressable style={styles.actionButton} onPress={() => openEditItem(item)}>
                      <Icon name="edit-2" size={16} color={theme.text} />
                    </Pressable>
                    <Pressable style={styles.actionButton} onPress={() => handleDeleteItem(item)}>
                      <Icon name="trash-2" size={16} color={theme.error} />
                    </Pressable>
                  </>
                )}
              </View>
            </View>
          );
        })
      )}
      <View style={{ height: 100 }} />
    </View>
  );

  const renderMovementsTab = () => (
    <View>
      <View style={styles.filterRow}>
        <Pressable
          style={styles.filterButton}
          onPress={() => setShowDatePicker(true)}
        >
          <Icon name="calendar" size={16} color={theme.textSecondary} />
          <ThemedText style={{ color: theme.textSecondary, fontSize: 13 }}>
            {filterDate ? filterDate.toLocaleDateString("ru-RU") : "Все даты"}
          </ThemedText>
        </Pressable>
        {filterDate && (
          <Pressable onPress={() => setFilterDate(null)}>
            <Icon name="x" size={18} color={theme.textSecondary} />
          </Pressable>
        )}
      </View>

      {showDatePicker && (
        <DateTimePicker
          value={filterDate || new Date()}
          mode="date"
          display={Platform.OS === "ios" ? "spinner" : "default"}
          onChange={handleDateChange}
        />
      )}

      {filteredMovements.length === 0 ? (
        <ThemedText style={styles.emptyText}>
          Нет движений за выбранный период
        </ThemedText>
      ) : (
        filteredMovements.map((movement) => {
          const item = getItemById(movement.itemId);
          const color = MOVEMENT_COLORS[movement.type];
          
          return (
            <View key={movement.id} style={styles.movementItem}>
              <View style={styles.movementHeader}>
                <View>
                  <ThemedText style={styles.cardTitle}>
                    {item?.name || "Неизвестно"}
                  </ThemedText>
                  <ThemedText style={styles.cardSubtitle}>
                    {new Date(movement.createdAt).toLocaleString("ru-RU", {
                      day: "numeric",
                      month: "short",
                      hour: "2-digit",
                      minute: "2-digit",
                    })}
                  </ThemedText>
                </View>
                <View style={[styles.movementBadge, { backgroundColor: color + "30" }]}>
                  <ThemedText style={[styles.badgeText, { color }]}>
                    {movement.type === "writeoff" || movement.type === "repair_out" ? "-" : "+"}
                    {movement.quantity} {MOVEMENT_LABELS[movement.type]}
                  </ThemedText>
                </View>
              </View>
              
              {movement.note && (
                <ThemedText style={[styles.cardSubtitle, { marginTop: Spacing.xs }]}>
                  {movement.note}
                </ThemedText>
              )}
              
              <ThemedText style={[styles.cardSubtitle, { marginTop: Spacing.xs, fontSize: 11 }]}>
                {movement.managerName}
              </ThemedText>
            </View>
          );
        })
      )}
      <View style={{ height: 100 }} />
    </View>
  );

  const renderCategoriesTab = () => (
    <View>
      {equipmentCategories.length === 0 ? (
        <ThemedText style={styles.emptyText}>
          Нет категорий. Создайте первую категорию.
        </ThemedText>
      ) : (
        equipmentCategories.map((category) => {
          const itemsCount = equipmentItems.filter(i => i.categoryId === category.id).length;
          
          return (
            <View key={category.id} style={styles.card}>
              <View style={styles.cardHeader}>
                <ThemedText style={styles.cardTitle}>{category.name}</ThemedText>
                <View style={[styles.badge, { backgroundColor: theme.primary + "30" }]}>
                  <ThemedText style={[styles.badgeText, { color: theme.primary }]}>
                    {category.type === "equipment" ? "Оборудование" : "Расходники"}
                  </ThemedText>
                </View>
              </View>
              
              <ThemedText style={styles.cardSubtitle}>
                Единица: {category.unit} | Позиций: {itemsCount}
              </ThemedText>

              {isAdmin && (
                <View style={styles.actionsRow}>
                  <Pressable style={styles.actionButton} onPress={() => openEditCategory(category)}>
                    <Icon name="edit-2" size={16} color={theme.text} />
                  </Pressable>
                  <Pressable style={styles.actionButton} onPress={() => handleDeleteCategory(category)}>
                    <Icon name="trash-2" size={16} color={theme.error} />
                  </Pressable>
                </View>
              )}
            </View>
          );
        })
      )}
      <View style={{ height: 100 }} />
    </View>
  );

  return (
    <ThemedView style={{ flex: 1 }}>
      <ScreenScrollView contentContainerStyle={styles.container}>
        <View style={styles.tabContainer}>
          <Pressable
            style={[styles.tab, activeTab === "inventory" && styles.tabActive]}
            onPress={() => setActiveTab("inventory")}
          >
            <ThemedText style={[styles.tabText, activeTab === "inventory" && styles.tabTextActive]}>
              Склад
            </ThemedText>
          </Pressable>
          <Pressable
            style={[styles.tab, activeTab === "movements" && styles.tabActive]}
            onPress={() => setActiveTab("movements")}
          >
            <ThemedText style={[styles.tabText, activeTab === "movements" && styles.tabTextActive]}>
              Движения
            </ThemedText>
          </Pressable>
          <Pressable
            style={[styles.tab, activeTab === "categories" && styles.tabActive]}
            onPress={() => setActiveTab("categories")}
          >
            <ThemedText style={[styles.tabText, activeTab === "categories" && styles.tabTextActive]}>
              Категории
            </ThemedText>
          </Pressable>
        </View>

        {activeTab === "inventory" && renderInventoryTab()}
        {activeTab === "movements" && renderMovementsTab()}
        {activeTab === "categories" && renderCategoriesTab()}
      </ScreenScrollView>

      {(activeTab === "inventory" || activeTab === "categories") && (
        <Pressable
          style={styles.fab}
          onPress={() => {
            if (activeTab === "inventory") {
              resetItemForm();
              setShowItemModal(true);
            } else {
              resetCategoryForm();
              setShowCategoryModal(true);
            }
          }}
        >
          <Icon name="plus" size={24} color="#FFF" />
        </Pressable>
      )}

      <Modal visible={showCategoryModal} transparent animationType="slide">
        <View style={styles.modalOverlay}>
          <View style={styles.modalContent}>
            <ThemedText style={styles.modalTitle}>
              {editingCategory ? "Редактировать категорию" : "Новая категория"}
            </ThemedText>

            <ThemedText style={styles.inputLabel}>Название</ThemedText>
            <TextInput
              style={styles.input}
              value={categoryName}
              onChangeText={setCategoryName}
              placeholder="Название категории"
              placeholderTextColor={theme.textSecondary}
            />

            <ThemedText style={styles.inputLabel}>Тип</ThemedText>
            <View style={styles.selectRow}>
              <Pressable
                style={[styles.selectOption, categoryType === "equipment" && styles.selectOptionActive]}
                onPress={() => setCategoryType("equipment")}
              >
                <ThemedText style={{ color: categoryType === "equipment" ? "#FFF" : theme.text }}>
                  Оборудование
                </ThemedText>
              </Pressable>
              <Pressable
                style={[styles.selectOption, categoryType === "consumable" && styles.selectOptionActive]}
                onPress={() => setCategoryType("consumable")}
              >
                <ThemedText style={{ color: categoryType === "consumable" ? "#FFF" : theme.text }}>
                  Расходники
                </ThemedText>
              </Pressable>
            </View>

            <ThemedText style={styles.inputLabel}>Единица измерения</ThemedText>
            <TextInput
              style={styles.input}
              value={categoryUnit}
              onChangeText={setCategoryUnit}
              placeholder="шт, пара, комплект..."
              placeholderTextColor={theme.textSecondary}
            />

            <View style={styles.buttonRow}>
              <Pressable
                style={[styles.button, styles.buttonSecondary]}
                onPress={() => {
                  setShowCategoryModal(false);
                  resetCategoryForm();
                }}
              >
                <ThemedText style={[styles.buttonText, { color: theme.text }]}>Отмена</ThemedText>
              </Pressable>
              <Pressable style={[styles.button, styles.buttonPrimary]} onPress={handleSaveCategory}>
                <ThemedText style={[styles.buttonText, { color: "#FFF" }]}>Сохранить</ThemedText>
              </Pressable>
            </View>
          </View>
        </View>
      </Modal>

      <Modal visible={showItemModal} transparent animationType="slide">
        <View style={styles.modalOverlay}>
          <View style={styles.modalContent}>
            <ScrollView style={{ flex: 1 }} nestedScrollEnabled={true} showsVerticalScrollIndicator={true} keyboardShouldPersistTaps="handled">
              <ThemedText style={styles.modalTitle}>
                {editingItem ? "Редактировать" : "Новое оборудование"}
              </ThemedText>

              <ThemedText style={styles.inputLabel}>Название</ThemedText>
              <TextInput
                style={styles.input}
                value={itemName}
                onChangeText={setItemName}
                placeholder="Название"
                placeholderTextColor={theme.textSecondary}
              />

              <ThemedText style={styles.inputLabel}>Категория</ThemedText>
              <View style={styles.categoryPicker}>
                {equipmentCategories.map((cat) => (
                  <Pressable
                    key={cat.id}
                    style={[styles.categoryOption, itemCategoryId === cat.id && styles.categoryOptionActive]}
                    onPress={() => setItemCategoryId(cat.id)}
                  >
                    <ThemedText style={{ color: itemCategoryId === cat.id ? "#FFF" : theme.text, fontSize: 13 }}>
                      {cat.name}
                    </ThemedText>
                  </Pressable>
                ))}
              </View>

              {!editingItem && (
                <>
                  <ThemedText style={styles.inputLabel}>Начальное количество</ThemedText>
                  <TextInput
                    style={styles.input}
                    value={itemQuantity}
                    onChangeText={setItemQuantity}
                    placeholder="0"
                    placeholderTextColor={theme.textSecondary}
                    keyboardType="number-pad"
                  />
                </>
              )}

              <ThemedText style={styles.inputLabel}>Минимальный остаток (для уведомлений)</ThemedText>
              <TextInput
                style={styles.input}
                value={itemMinQuantity}
                onChangeText={setItemMinQuantity}
                placeholder="0"
                placeholderTextColor={theme.textSecondary}
                keyboardType="number-pad"
              />

              <View style={styles.buttonRow}>
                <Pressable
                  style={[styles.button, styles.buttonSecondary]}
                  onPress={() => {
                    setShowItemModal(false);
                    resetItemForm();
                  }}
                >
                  <ThemedText style={[styles.buttonText, { color: theme.text }]}>Отмена</ThemedText>
                </Pressable>
                <Pressable style={[styles.button, styles.buttonPrimary]} onPress={handleSaveItem}>
                  <ThemedText style={[styles.buttonText, { color: "#FFF" }]}>Сохранить</ThemedText>
                </Pressable>
              </View>
            </ScrollView>
          </View>
        </View>
      </Modal>

      <Modal visible={showMovementModal} transparent animationType="slide">
        <View style={styles.modalOverlay}>
          <View style={styles.modalContent}>
            <ScrollView style={{ flex: 1 }} nestedScrollEnabled={true} showsVerticalScrollIndicator={true} keyboardShouldPersistTaps="handled">
              <ThemedText style={styles.modalTitle}>
                Движение: {selectedItem?.name}
              </ThemedText>

              <ThemedText style={styles.inputLabel}>Тип операции</ThemedText>
              <View style={styles.categoryPicker}>
                {(Object.keys(MOVEMENT_LABELS) as MovementType[]).map((type) => (
                  <Pressable
                    key={type}
                    style={[
                      styles.categoryOption,
                      movementType === type && { backgroundColor: MOVEMENT_COLORS[type] },
                    ]}
                    onPress={() => setMovementType(type)}
                  >
                    <ThemedText style={{ color: movementType === type ? "#FFF" : theme.text, fontSize: 13 }}>
                      {MOVEMENT_LABELS[type]}
                    </ThemedText>
                  </Pressable>
                ))}
              </View>

              <ThemedText style={styles.inputLabel}>Количество</ThemedText>
              <TextInput
                style={styles.input}
                value={movementQuantity}
                onChangeText={setMovementQuantity}
                placeholder="Количество"
                placeholderTextColor={theme.textSecondary}
                keyboardType="number-pad"
              />

              <ThemedText style={styles.inputLabel}>Примечание (необязательно)</ThemedText>
              <TextInput
                style={[styles.input, { minHeight: 80 }]}
                value={movementNote}
                onChangeText={setMovementNote}
                placeholder="Причина, номер акта и т.д."
                placeholderTextColor={theme.textSecondary}
                multiline
              />

              <View style={styles.buttonRow}>
                <Pressable
                  style={[styles.button, styles.buttonSecondary]}
                  onPress={() => {
                    setShowMovementModal(false);
                    resetMovementForm();
                  }}
                >
                  <ThemedText style={[styles.buttonText, { color: theme.text }]}>Отмена</ThemedText>
                </Pressable>
                <Pressable style={[styles.button, styles.buttonPrimary]} onPress={handleSaveMovement}>
                  <ThemedText style={[styles.buttonText, { color: "#FFF" }]}>Сохранить</ThemedText>
                </Pressable>
              </View>
            </ScrollView>
          </View>
        </View>
      </Modal>
    </ThemedView>
  );
}
