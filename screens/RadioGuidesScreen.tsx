import { useState, useMemo, useEffect, useCallback, useRef } from "react";
import {
  View,
  StyleSheet,
  Pressable,
  Alert,
  TextInput,
  Modal,
  ScrollView,
  Platform,
  LayoutRectangle,
} from "react-native";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { useFocusEffect } from "@react-navigation/native";
import { KeyboardAwareScrollView } from "react-native-keyboard-controller";
import Svg, { Rect, Path } from "react-native-svg";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { PermissionGate } from "@/components/PermissionGate";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, RadioGuideKit, RadioGuideAssignment, BatteryLevel } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";

const BatteryIcon = ({ level, color, size = 24 }: { level: BatteryLevel; color: string; size?: number }) => {
  const segments = level === 'full' ? 3 : level === 'half' ? 2 : 1;
  const width = size;
  const height = size * 0.5;
  
  return (
    <Svg width={width} height={height} viewBox="0 0 24 12">
      <Rect x="0" y="0" width="20" height="12" rx="2" stroke={color} strokeWidth="1.5" fill="none" />
      <Path d="M21 3 L21 9 L23 9 L23 3 Z" fill={color} />
      {segments >= 1 && <Rect x="2" y="2" width="4.5" height="8" rx="1" fill={color} />}
      {segments >= 2 && <Rect x="7.5" y="2" width="4.5" height="8" rx="1" fill={color} />}
      {segments >= 3 && <Rect x="13" y="2" width="4.5" height="8" rx="1" fill={color} />}
    </Svg>
  );
};

interface AllocationGuide {
  id: string;
  name: string;
  assignedTourTypeId: string | null;
  assignedBusId: string | null;
}

interface AllocationBus {
  id: string;
  busNumber: string;
  seats: number;
  assignedTourTypeId: string | null;
  assignedGuideName: string | null;
}

const STORAGE_KEY_BUSES = "@allocation_buses";
const STORAGE_KEY_GUIDES = "@allocation_guides";
const STORAGE_KEY_DATE = "@allocation_date";

type ModalMode = "add" | "edit" | "issue" | "return" | null;

export default function RadioGuidesScreen() {
  const { theme } = useTheme();
  const { isAdmin, isRadioDispatcher, signOut, profile, hasPermission } = useAuth();
  const {
    radioGuideKits,
    radioGuideAssignments,
    addRadioGuideKit,
    updateRadioGuideKit,
    deleteRadioGuideKit,
    issueRadioGuide,
    returnRadioGuide,
    getActiveAssignment,
    addEquipmentLoss,
    excursions,
    tourTypes,
  } = useData();
  
  const getExcursionInfo = (excursionId: string | null | undefined) => {
    if (!excursionId) return null;
    const excursion = excursions.find(e => e.id === excursionId);
    if (!excursion) return null;
    const tourType = tourTypes.find(t => t.id === excursion.tourTypeId);
    const date = new Date(excursion.date).toLocaleDateString("ru-RU", { day: "numeric", month: "short" });
    const time = excursion.time;
    return {
      name: tourType?.name || "Экскурсия",
      dateTime: `${date}, ${time}`,
    };
  };

  const getBatteryInfo = (level: BatteryLevel) => {
    switch (level) {
      case 'full':
        return { color: theme.success, label: 'Полный заряд' };
      case 'half':
        return { color: theme.warning, label: 'Средний заряд' };
      case 'low':
        return { color: theme.error, label: 'Низкий заряд' };
      default:
        return { color: theme.success, label: 'Полный заряд' };
    }
  };

  const handleBatteryChange = async (kit: RadioGuideKit, newLevel: BatteryLevel) => {
    try {
      await updateRadioGuideKit(kit.id, { batteryLevel: newLevel });
      setBatteryPickerKit(null);
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось обновить уровень заряда");
    }
  };

  const [batteryPickerKit, setBatteryPickerKit] = useState<RadioGuideKit | null>(null);
  const [batteryDropdownPosition, setBatteryDropdownPosition] = useState<{ top: number; right: number } | null>(null);
  const [modalMode, setModalMode] = useState<ModalMode>(null);
  const [selectedKit, setSelectedKit] = useState<RadioGuideKit | null>(null);
  const [selectedAssignment, setSelectedAssignment] = useState<RadioGuideAssignment | null>(null);

  const [bagNumber, setBagNumber] = useState("");
  const [notes, setNotes] = useState("");
  const [guideName, setGuideName] = useState("");
  const [busNumber, setBusNumber] = useState("");
  const [receiversIssued, setReceiversIssued] = useState("");
  const [missingCount, setMissingCount] = useState("");
  const [lossReason, setLossReason] = useState("");
  const [showShortageForm, setShowShortageForm] = useState(false);
  const [selectedExcursionId, setSelectedExcursionId] = useState<string | null>(null);
  
  const [selectedDate, setSelectedDate] = useState(() => new Date().toISOString().split("T")[0]);
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [activeFilter, setActiveFilter] = useState<"all" | "issued" | "overdue" | "available">("all");
  const [sortByBattery, setSortByBattery] = useState(false);
  
  // Allocation data integration
  const [allocationBuses, setAllocationBuses] = useState<AllocationBus[]>([]);
  const [allocationGuides, setAllocationGuides] = useState<AllocationGuide[]>([]);
  const [showGuidePicker, setShowGuidePicker] = useState(false);
  
  // Load allocation data from AsyncStorage on every screen focus
  useFocusEffect(
    useCallback(() => {
      const loadAllocationData = async () => {
        try {
          const today = new Date().toISOString().split("T")[0];
          const savedDate = await AsyncStorage.getItem(STORAGE_KEY_DATE);
          
          console.log("[RadioGuides] Loading allocation data, today:", today, "savedDate:", savedDate);
          
          if (savedDate === today) {
            const savedBuses = await AsyncStorage.getItem(STORAGE_KEY_BUSES);
            const savedGuides = await AsyncStorage.getItem(STORAGE_KEY_GUIDES);
            
            console.log("[RadioGuides] Buses:", savedBuses?.length, "Guides:", savedGuides?.length);
            
            if (savedBuses) {
              const buses = JSON.parse(savedBuses);
              console.log("[RadioGuides] Parsed buses:", buses.length);
              setAllocationBuses(buses);
            }
            if (savedGuides) {
              const guides = JSON.parse(savedGuides);
              console.log("[RadioGuides] Parsed guides:", guides.length, "assigned:", guides.filter((g: AllocationGuide) => g.assignedTourTypeId).length);
              setAllocationGuides(guides);
            }
          } else {
            console.log("[RadioGuides] Date mismatch or no saved date");
            setAllocationBuses([]);
            setAllocationGuides([]);
          }
        } catch (error) {
          console.error("Error loading allocation data:", error);
        }
      };
      
      loadAllocationData();
    }, [])
  );
  
  // Get guides with their assigned buses from allocation
  // Exclude guides who already have active radio guide assignments
  const allocatedGuides = useMemo(() => {
    console.log("[RadioGuides] Computing allocatedGuides, allocationGuides:", allocationGuides.length);
    
    // Get names of guides with active assignments (not returned yet)
    const activeGuideNames = new Set(
      radioGuideAssignments
        .filter(a => !a.returnedAt)
        .map(a => a.guideName.toLowerCase().trim())
    );
    
    const result = allocationGuides
      .filter(g => g.assignedTourTypeId) // Only assigned guides
      .filter(g => !activeGuideNames.has(g.name.toLowerCase().trim())) // Exclude already issued
      .map(guide => {
        // Find the bus this guide is assigned to
        const bus = allocationBuses.find(b => 
          b.assignedGuideName === guide.name || b.id === guide.assignedBusId
        );
        const tourType = tourTypes.find(t => t.id === guide.assignedTourTypeId);
        return {
          ...guide,
          busNumber: bus?.busNumber || null,
          tourName: tourType?.name || null,
        };
      });
    console.log("[RadioGuides] allocatedGuides result:", result.length);
    return result;
  }, [allocationGuides, allocationBuses, tourTypes, radioGuideAssignments]);

  const todayExcursions = useMemo(() => {
    return excursions
      .filter(e => e.date === selectedDate)
      .map(e => {
        const tourType = tourTypes.find(t => t.id === e.tourTypeId);
        return { ...e, tourTypeName: tourType?.name || "Экскурсия" };
      })
      .sort((a, b) => a.time.localeCompare(b.time));
  }, [excursions, tourTypes, selectedDate]);
  
  const today = new Date().toISOString().split("T")[0];
  
  const { issuedKits, overdueKits, availableKits } = useMemo(() => {
    const issued: Array<{ kit: RadioGuideKit; assignment: RadioGuideAssignment; isOverdue: boolean }> = [];
    const overdue: Array<{ kit: RadioGuideKit; assignment: RadioGuideAssignment }> = [];
    const available: RadioGuideKit[] = [];
    
    const batteryOrder: Record<BatteryLevel, number> = { low: 0, half: 1, full: 2 };
    
    radioGuideKits.forEach(kit => {
      const activeAssignment = getActiveAssignment(kit.id);
      if (activeAssignment) {
        const issuedDate = activeAssignment.issuedAt.split("T")[0];
        const isOverdue = issuedDate < today;
        
        if (isOverdue) {
          overdue.push({ kit, assignment: activeAssignment });
        }
        issued.push({ kit, assignment: activeAssignment, isOverdue });
      } else if (kit.status === "available") {
        available.push(kit);
      }
    });
    
    issued.sort((a, b) => a.kit.bagNumber - b.kit.bagNumber);
    overdue.sort((a, b) => a.kit.bagNumber - b.kit.bagNumber);
    
    if (sortByBattery) {
      available.sort((a, b) => {
        const batteryDiff = batteryOrder[b.batteryLevel] - batteryOrder[a.batteryLevel];
        if (batteryDiff !== 0) return batteryDiff;
        return a.bagNumber - b.bagNumber;
      });
    } else {
      available.sort((a, b) => a.bagNumber - b.bagNumber);
    }
    
    return { issuedKits: issued, overdueKits: overdue, availableKits: available };
  }, [radioGuideKits, getActiveAssignment, today, sortByBattery]);
  
  const formatDate = (dateStr: string) => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU", { weekday: "short", day: "numeric", month: "short" });
  };
  
  const changeDate = (days: number) => {
    const date = new Date(selectedDate);
    date.setDate(date.getDate() + days);
    setSelectedDate(date.toISOString().split("T")[0]);
  };

  const resetForm = () => {
    setBagNumber("");
    setNotes("");
    setGuideName("");
    setBusNumber("");
    setReceiversIssued("");
    setMissingCount("");
    setLossReason("");
    setSelectedKit(null);
    setSelectedAssignment(null);
    setShowShortageForm(false);
    setSelectedExcursionId(null);
    setShowGuidePicker(false);
  };

  const openAddModal = () => {
    resetForm();
    setModalMode("add");
  };

  const openEditModal = (kit: RadioGuideKit) => {
    setSelectedKit(kit);
    setBagNumber(kit.bagNumber.toString());
    setNotes(kit.notes || "");
    setModalMode("edit");
  };

  const openIssueModal = (kit: RadioGuideKit) => {
    setSelectedKit(kit);
    setReceiversIssued("");
    setModalMode("issue");
  };

  const openReturnModal = (kit: RadioGuideKit) => {
    const assignment = getActiveAssignment(kit.id);
    if (assignment) {
      setSelectedKit(kit);
      setSelectedAssignment(assignment);
      setMissingCount("");
      setLossReason("");
      setModalMode("return");
    }
  };

  const handleSaveKit = async () => {
    const num = parseInt(bagNumber);

    if (!num || num <= 0) {
      Alert.alert("Ошибка", "Введите номер сумки");
      return;
    }

    try {
      if (modalMode === "add") {
        await addRadioGuideKit({
          bagNumber: num,
          status: "available",
          notes: notes.trim() || null,
        });
      } else if (modalMode === "edit" && selectedKit) {
        await updateRadioGuideKit(selectedKit.id, {
          bagNumber: num,
          notes: notes.trim() || null,
        });
      }
      setModalMode(null);
      resetForm();
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось сохранить");
    }
  };

  const handleDeleteKit = (kit: RadioGuideKit) => {
    if (kit.status === "issued") {
      Alert.alert("Ошибка", "Нельзя удалить выданную сумку");
      return;
    }

    Alert.alert("Удалить сумку?", `Сумка #${kit.bagNumber} будет удалена`, [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: async () => {
          try {
            await deleteRadioGuideKit(kit.id);
          } catch (err) {
            Alert.alert("Ошибка", "Не удалось удалить");
          }
        },
      },
    ]);
  };

  const handleIssue = async () => {
    if (!selectedKit) return;

    if (!guideName.trim()) {
      Alert.alert("Ошибка", "Введите имя экскурсовода");
      return;
    }

    const count = parseInt(receiversIssued);
    if (!count || count <= 0) {
      Alert.alert("Ошибка", "Введите количество приёмников");
      return;
    }

    try {
      await issueRadioGuide({
        kitId: selectedKit.id,
        excursionId: selectedExcursionId || undefined,
        guideName: guideName.trim(),
        busNumber: busNumber.trim() || undefined,
        receiversIssued: count,
      });
      setModalMode(null);
      resetForm();
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось выдать радиогид");
    }
  };

  const handleReturnAllOk = async () => {
    if (!selectedAssignment) return;

    try {
      await returnRadioGuide(selectedAssignment.id, selectedAssignment.receiversIssued);
      setModalMode(null);
      resetForm();
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось принять радиогид");
    }
  };

  const handleReturnWithShortage = async () => {
    if (!selectedAssignment || !selectedKit) return;

    const missing = parseInt(missingCount);
    if (isNaN(missing) || missing < 0) {
      Alert.alert("Ошибка", "Введите количество недостающих приёмников");
      return;
    }

    if (missing > selectedAssignment.receiversIssued) {
      Alert.alert("Ошибка", "Количество недостающих не может превышать выданное");
      return;
    }

    if (!lossReason.trim()) {
      Alert.alert("Ошибка", "Укажите причину недостачи");
      return;
    }

    const returned = selectedAssignment.receiversIssued - missing;

    try {
      await returnRadioGuide(selectedAssignment.id, returned, lossReason.trim());
      
      // Try to record the loss, but don't fail if it doesn't work
      try {
        await addEquipmentLoss({
          assignmentId: selectedAssignment.id,
          kitId: selectedKit.id,
          guideName: selectedAssignment.guideName,
          missingCount: missing,
          reason: lossReason.trim(),
        });
      } catch (lossErr) {
        console.warn("Could not record equipment loss:", lossErr);
        Alert.alert(
          "Внимание",
          "Радиогид принят, но запись о потере не сохранена. Обратитесь к администратору.",
          [{ text: "OK" }]
        );
      }
      
      setModalMode(null);
      resetForm();
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось принять радиогид");
    }
  };

  const renderIssuedKit = (item: { kit: RadioGuideKit; assignment: RadioGuideAssignment; isOverdue: boolean }) => {
    const { kit, assignment, isOverdue } = item;
    const excInfo = getExcursionInfo(assignment.excursionId);
    const issuedDate = new Date(assignment.issuedAt).toLocaleDateString("ru-RU", { day: "numeric", month: "short" });
    
    return (
      <ThemedView
        style={[
          styles.kitCard,
          { 
            backgroundColor: isOverdue ? theme.error + "10" : theme.backgroundSecondary, 
            borderColor: isOverdue ? theme.error : theme.border 
          },
        ]}
      >
        <View style={styles.kitHeader}>
          <View style={styles.kitInfo}>
            <View style={styles.kitTitleRow}>
              <ThemedText style={styles.kitNumber}>Сумка #{kit.bagNumber}</ThemedText>
              {isOverdue ? (
                <View style={[styles.overdueBadge, { backgroundColor: theme.error }]}>
                  <ThemedText style={styles.overdueBadgeText}>Просрочена</ThemedText>
                </View>
              ) : null}
            </View>
          </View>
        </View>
        
        <View style={[styles.assignmentInfo, { backgroundColor: theme.backgroundTertiary }]}>
          <ThemedText style={[styles.assignmentLabel, { color: theme.textSecondary }]}>
            Экскурсия:
          </ThemedText>
          {excInfo ? (
            <ThemedText style={[styles.assignmentValue, { color: theme.primary }]}>
              {excInfo.name} ({excInfo.dateTime})
            </ThemedText>
          ) : (
            <ThemedText style={[styles.assignmentValue, { color: theme.textSecondary, fontStyle: "italic" }]}>
              Не указана
            </ThemedText>
          )}
          <ThemedText style={[styles.assignmentLabel, { color: theme.textSecondary }]}>
            Экскурсовод:
          </ThemedText>
          <ThemedText style={styles.assignmentValue}>{assignment.guideName}</ThemedText>
          {assignment.busNumber ? (
            <>
              <ThemedText style={[styles.assignmentLabel, { color: theme.textSecondary }]}>
                Автобус:
              </ThemedText>
              <ThemedText style={styles.assignmentValue}>{assignment.busNumber}</ThemedText>
            </>
          ) : null}
          <ThemedText style={[styles.assignmentLabel, { color: theme.textSecondary }]}>
            Выдано:
          </ThemedText>
          <ThemedText style={styles.assignmentValue}>
            {assignment.receiversIssued} шт. ({issuedDate})
          </ThemedText>
        </View>
        
        <View style={styles.kitActions}>
          <Pressable
            style={[styles.actionButton, { backgroundColor: theme.success }]}
            onPress={() => openReturnModal(kit)}
          >
            <Icon name="download" size={16} color={theme.buttonText} />
            <ThemedText style={[styles.actionButtonText, { color: theme.buttonText }]}>
              Принять
            </ThemedText>
          </Pressable>
        </View>
      </ThemedView>
    );
  };
  
  const renderAvailableKit = (kit: RadioGuideKit) => {
    const batteryInfo = getBatteryInfo(kit.batteryLevel);
    
    return (
      <ThemedView
        style={[
          styles.kitCard,
          { backgroundColor: theme.backgroundSecondary, borderColor: theme.border },
        ]}
      >
        <View style={styles.kitHeader}>
          <View style={styles.kitInfo}>
            <ThemedText style={styles.kitNumber}>Сумка #{kit.bagNumber}</ThemedText>
            <View style={styles.kitMeta}>
              <View style={[styles.statusBadge, { backgroundColor: theme.success + "20" }]}>
                <ThemedText style={[styles.statusText, { color: theme.success }]}>
                  Доступна
                </ThemedText>
              </View>
            </View>
          </View>
          <View>
            <Pressable
              style={[
                styles.batteryIndicator,
                { 
                  backgroundColor: batteryInfo.color + "20",
                  borderColor: batteryInfo.color,
                },
              ]}
              onPress={(e) => {
                (e.target as any).measure?.((x: number, y: number, width: number, height: number, pageX: number, pageY: number) => {
                  setBatteryDropdownPosition({ top: pageY + height + 4, right: 16 });
                  setBatteryPickerKit(kit);
                });
                if (Platform.OS === 'web') {
                  setBatteryDropdownPosition({ top: 0, right: 0 });
                  setBatteryPickerKit(kit);
                }
              }}
            >
              <BatteryIcon level={kit.batteryLevel} color={batteryInfo.color} size={28} />
              <Icon name="chevron-down" size={14} color={batteryInfo.color} />
            </Pressable>
            
            {batteryPickerKit?.id === kit.id ? (
              <View style={[styles.batteryDropdown, { backgroundColor: theme.backgroundDefault, borderColor: theme.border }]}>
                {(['full', 'half', 'low'] as BatteryLevel[]).map((level) => {
                  const info = getBatteryInfo(level);
                  const isSelected = kit.batteryLevel === level;
                  return (
                    <Pressable
                      key={level}
                      style={[
                        styles.batteryDropdownItem,
                        isSelected && { backgroundColor: info.color + "20" },
                      ]}
                      onPress={() => handleBatteryChange(kit, level)}
                    >
                      <BatteryIcon level={level} color={info.color} size={24} />
                      <ThemedText style={[styles.batteryDropdownText, { color: isSelected ? info.color : theme.text }]}>
                        {info.label}
                      </ThemedText>
                      {isSelected ? <Icon name="check" size={16} color={info.color} /> : null}
                    </Pressable>
                  );
                })}
              </View>
            ) : null}
          </View>
        </View>
        
        {kit.notes ? (
          <ThemedText style={[styles.kitNotes, { color: theme.textSecondary }]}>
            {kit.notes}
          </ThemedText>
        ) : null}
        
        <View style={styles.kitActions}>
          <Pressable
            style={[styles.actionButton, { backgroundColor: theme.primary }]}
            onPress={() => openIssueModal(kit)}
          >
            <Icon name="send" size={16} color={theme.buttonText} />
            <ThemedText style={[styles.actionButtonText, { color: theme.buttonText }]}>
              Выдать
            </ThemedText>
          </Pressable>
          
          {hasPermission('radio_guides_edit') ? (
            <>
              <Pressable
                style={[styles.iconButton, { borderColor: theme.border }]}
                onPress={() => openEditModal(kit)}
              >
                <Icon name="edit-2" size={18} color={theme.primary} />
              </Pressable>
              <Pressable
                style={[styles.iconButton, { borderColor: theme.border }]}
                onPress={() => handleDeleteKit(kit)}
              >
                <Icon name="trash-2" size={18} color={theme.error} />
              </Pressable>
            </>
          ) : null}
        </View>
      </ThemedView>
    );
  };

  const todayIssuedKits = issuedKits.filter(k => !k.isOverdue);

  return (
    <PermissionGate permission="radio_guides">
    <>
      <ScreenScrollView onTouchStart={() => batteryPickerKit && setBatteryPickerKit(null)}>
        <View style={styles.container}>
          <View style={styles.statsRow}>
            <Pressable 
              style={[
                styles.statCard, 
                { 
                  backgroundColor: activeFilter === "issued" ? theme.warning : theme.warning + "20",
                  borderWidth: activeFilter === "issued" ? 0 : 0,
                }
              ]}
              onPress={() => setActiveFilter(activeFilter === "issued" ? "all" : "issued")}
            >
              <ThemedText style={[styles.statNumber, { color: activeFilter === "issued" ? "#fff" : theme.warning }]}>
                {todayIssuedKits.length}
              </ThemedText>
              <ThemedText style={[styles.statLabel, { color: activeFilter === "issued" ? "#fff" : theme.textSecondary }]}>
                На выдаче
              </ThemedText>
            </Pressable>
            <Pressable 
              style={[
                styles.statCard, 
                { backgroundColor: activeFilter === "overdue" ? theme.error : theme.error + "20" }
              ]}
              onPress={() => setActiveFilter(activeFilter === "overdue" ? "all" : "overdue")}
            >
              <ThemedText style={[styles.statNumber, { color: activeFilter === "overdue" ? "#fff" : theme.error }]}>
                {overdueKits.length}
              </ThemedText>
              <ThemedText style={[styles.statLabel, { color: activeFilter === "overdue" ? "#fff" : theme.textSecondary }]}>
                Просрочено
              </ThemedText>
            </Pressable>
            <Pressable 
              style={[
                styles.statCard, 
                { backgroundColor: activeFilter === "available" ? theme.success : theme.success + "20" }
              ]}
              onPress={() => setActiveFilter(activeFilter === "available" ? "all" : "available")}
            >
              <ThemedText style={[styles.statNumber, { color: activeFilter === "available" ? "#fff" : theme.success }]}>
                {availableKits.length}
              </ThemedText>
              <ThemedText style={[styles.statLabel, { color: activeFilter === "available" ? "#fff" : theme.textSecondary }]}>
                Доступно
              </ThemedText>
            </Pressable>
          </View>
          
          {(activeFilter === "all" || activeFilter === "overdue") && overdueKits.length > 0 ? (
            <View style={styles.section}>
              <View style={styles.sectionHeader}>
                <Icon name="alert-triangle" size={18} color={theme.error} />
                <ThemedText style={[styles.sectionTitle, { color: theme.error }]}>
                  Просроченные ({overdueKits.length})
                </ThemedText>
              </View>
              <View style={styles.kitsList}>
                {overdueKits.map(item => (
                  <View key={item.kit.id}>
                    {renderIssuedKit({ ...item, isOverdue: true })}
                  </View>
                ))}
              </View>
            </View>
          ) : null}
          
          {(activeFilter === "all" || activeFilter === "issued") && todayIssuedKits.length > 0 ? (
            <View style={styles.section}>
              <View style={styles.sectionHeader}>
                <Icon name="clock" size={18} color={theme.warning} />
                <ThemedText style={[styles.sectionTitle, { color: theme.text }]}>
                  На выдаче сегодня ({todayIssuedKits.length})
                </ThemedText>
              </View>
              <View style={styles.kitsList}>
                {todayIssuedKits.map(item => (
                  <View key={item.kit.id}>
                    {renderIssuedKit(item)}
                  </View>
                ))}
              </View>
            </View>
          ) : null}
          
          {(activeFilter === "all" || activeFilter === "available") ? (
            <View style={styles.section}>
              <View style={styles.sectionHeaderRow}>
                <View style={styles.sectionHeader}>
                  <Icon name="check-circle" size={18} color={theme.success} />
                  <ThemedText style={[styles.sectionTitle, { color: theme.text }]}>
                    Доступные ({availableKits.length})
                  </ThemedText>
                </View>
                <Pressable
                  style={[
                    styles.sortButton,
                    { 
                      backgroundColor: sortByBattery ? theme.primary + "20" : "transparent",
                      borderColor: sortByBattery ? theme.primary : theme.border,
                    },
                  ]}
                  onPress={() => setSortByBattery(!sortByBattery)}
                >
                  <Icon name="zap" size={14} color={sortByBattery ? theme.primary : theme.textSecondary} />
                  <ThemedText style={{ fontSize: 12, color: sortByBattery ? theme.primary : theme.textSecondary }}>
                    {sortByBattery ? "По заряду" : "По номеру"}
                  </ThemedText>
                </Pressable>
              </View>
              {availableKits.length > 0 ? (
                <View style={styles.kitsList}>
                  {availableKits.map(kit => (
                    <View key={kit.id}>
                      {renderAvailableKit(kit)}
                    </View>
                  ))}
                </View>
              ) : (
                <View style={styles.emptySection}>
                  <ThemedText style={{ color: theme.textSecondary }}>
                    Все сумки выданы
                  </ThemedText>
                </View>
              )}
            </View>
          ) : null}
          
          {activeFilter !== "all" && (
            <Pressable 
              style={[styles.showAllButton, { borderColor: theme.border }]}
              onPress={() => setActiveFilter("all")}
            >
              <ThemedText style={{ color: theme.primary }}>Показать все</ThemedText>
            </Pressable>
          )}
          
          {isRadioDispatcher ? (
            <View style={[styles.dispatcherFooter, { borderTopColor: theme.border }]}>
              <View style={styles.dispatcherInfo}>
                <Icon name="user" size={18} color={theme.textSecondary} />
                <ThemedText style={{ color: theme.textSecondary }}>
                  {profile?.display_name || "Диспетчер"}
                </ThemedText>
              </View>
              <Pressable
                style={[styles.logoutButton, { borderColor: theme.error }]}
                onPress={() => {
                  Alert.alert(
                    "Выход",
                    "Вы уверены, что хотите выйти?",
                    [
                      { text: "Отмена", style: "cancel" },
                      { text: "Выйти", style: "destructive", onPress: signOut },
                    ]
                  );
                }}
              >
                <Icon name="log-out" size={16} color={theme.error} />
                <ThemedText style={{ color: theme.error }}>Выйти</ThemedText>
              </Pressable>
            </View>
          ) : null}
        </View>
      </ScreenScrollView>

      {hasPermission('radio_guides_add') ? (
        <Pressable
          style={[styles.fab, { backgroundColor: theme.primary }]}
          onPress={openAddModal}
        >
          <Icon name="plus" size={24} color={theme.buttonText} />
        </Pressable>
      ) : null}

      <Modal
        visible={modalMode !== null}
        animationType="slide"
        transparent
        onRequestClose={() => setModalMode(null)}
      >
        <View style={styles.modalOverlay}>
          <ThemedView
            style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}
          >
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>
                {modalMode === "add"
                  ? "Добавить сумку"
                  : modalMode === "edit"
                  ? "Редактировать сумку"
                  : modalMode === "issue"
                  ? "Выдать радиогид"
                  : "Принять радиогид"}
              </ThemedText>
              <Pressable onPress={() => setModalMode(null)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            {Platform.OS === "web" ? (
              <ScrollView
                style={styles.formScroll}
                contentContainerStyle={styles.formScrollContent}
                keyboardShouldPersistTaps="handled"
              >
                {renderFormContent()}
              </ScrollView>
            ) : (
              <KeyboardAwareScrollView
                style={styles.formScroll}
                contentContainerStyle={styles.formScrollContent}
                keyboardShouldPersistTaps="handled"
              >
                {renderFormContent()}
              </KeyboardAwareScrollView>
            )}
          </ThemedView>
        </View>
      </Modal>
    </>
    </PermissionGate>
  );

  function renderFormContent() {
    if (modalMode === "add" || modalMode === "edit") {
      return (
        <View style={styles.form}>
          <View style={styles.inputGroup}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Номер сумки
            </ThemedText>
            <TextInput
              style={[
                styles.input,
                { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
              ]}
              value={bagNumber}
              onChangeText={setBagNumber}
              placeholder="1"
              placeholderTextColor={theme.textSecondary}
              keyboardType="number-pad"
            />
          </View>

          <View style={styles.inputGroup}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Заметки (опционально)
            </ThemedText>
            <TextInput
              style={[
                styles.input,
                styles.multilineInput,
                { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
              ]}
              value={notes}
              onChangeText={setNotes}
              placeholder="Заметки о состоянии..."
              placeholderTextColor={theme.textSecondary}
              multiline
              numberOfLines={2}
            />
          </View>

          <Pressable
            style={[styles.saveButton, { backgroundColor: theme.primary }]}
            onPress={handleSaveKit}
          >
            <ThemedText style={[styles.saveButtonText, { color: theme.buttonText }]}>
              Сохранить
            </ThemedText>
          </Pressable>
        </View>
      );
    }

    if (modalMode === "issue") {
      // Show guide picker list
      if (showGuidePicker) {
        // Get selected excursion to filter guides
        const selectedExcursion = selectedExcursionId 
          ? todayExcursions.find(e => e.id === selectedExcursionId) 
          : null;
        
        // Filter guides by exact tour name match from allocation
        const filteredGuides = selectedExcursion && selectedExcursion.tourTypeName
          ? allocatedGuides.filter(guide => {
              if (!guide.tourName) return false;
              // Strict match: tour names must be exactly the same
              return guide.tourName.toLowerCase() === selectedExcursion.tourTypeName.toLowerCase();
            })
          : allocatedGuides;

        return (
          <View style={styles.form}>
            <View style={styles.guidePickerHeader}>
              <Pressable 
                onPress={() => setShowGuidePicker(false)}
                style={[styles.backButton, { backgroundColor: theme.backgroundSecondary }]}
              >
                <Icon name="arrow-left" size={18} color={theme.text} />
                <ThemedText style={{ marginLeft: Spacing.xs }}>Назад</ThemedText>
              </Pressable>
              <ThemedText style={styles.guidePickerTitle}>Выбрать гида</ThemedText>
            </View>
            {selectedExcursion ? (
              <ThemedText style={{ color: theme.textSecondary, fontSize: 12, marginBottom: Spacing.sm }}>
                Гиды для: {selectedExcursion.tourTypeName}
              </ThemedText>
            ) : null}
            {allocatedGuides.length === 0 ? (
              <ThemedText style={{ color: theme.textSecondary, textAlign: "center", padding: Spacing.xl }}>
                Нет данных распределения на сегодня
              </ThemedText>
            ) : filteredGuides.length === 0 ? (
              <ThemedText style={{ color: theme.textSecondary, textAlign: "center", padding: Spacing.xl }}>
                Нет гидов для этой экскурсии
              </ThemedText>
            ) : (
              filteredGuides.map((guide) => (
                <Pressable
                  key={guide.id}
                  onPress={() => {
                    setGuideName(guide.name);
                    if (guide.busNumber) {
                      setBusNumber(guide.busNumber);
                    }
                    // Auto-fill receivers count from selected excursion participants
                    const selectedExc = selectedExcursionId 
                      ? todayExcursions.find(e => e.id === selectedExcursionId) 
                      : null;
                    if (selectedExc) {
                      const totalParticipants = 
                        (selectedExc.fullPriceCount || 0) + 
                        (selectedExc.discountedCount || 0) + 
                        (selectedExc.freeCount || 0) + 
                        (selectedExc.tourPackageCount || 0) + 
                        (selectedExc.byTourCount || 0) + 
                        (selectedExc.paidCount || 0);
                      if (totalParticipants > 0) {
                        // Round up to nearest 5, and add 5 if already divisible by 5
                        const roundedUp = totalParticipants % 5 === 0 
                          ? totalParticipants + 5 
                          : Math.ceil(totalParticipants / 5) * 5;
                        setReceiversIssued(roundedUp.toString());
                      }
                    }
                    setShowGuidePicker(false);
                  }}
                  style={[
                    styles.guidePickerItem,
                    { backgroundColor: theme.backgroundSecondary, borderColor: theme.border },
                  ]}
                >
                  <View style={styles.guidePickerInfo}>
                    <ThemedText style={styles.guidePickerName}>{guide.name}</ThemedText>
                    {guide.tourName ? (
                      <ThemedText style={[styles.guidePickerTour, { color: theme.textSecondary }]}>
                        {guide.tourName}
                      </ThemedText>
                    ) : null}
                  </View>
                  {guide.busNumber ? (
                    <View style={[styles.guidePickerBus, { backgroundColor: theme.primary + "20" }]}>
                      <Icon name="truck" size={12} color={theme.primary} />
                      <ThemedText style={[styles.guidePickerBusText, { color: theme.primary }]}>
                        {guide.busNumber}
                      </ThemedText>
                    </View>
                  ) : null}
                </Pressable>
              ))
            )}
          </View>
        );
      }

      return (
        <View style={styles.form}>
          <View style={styles.inputGroup}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Экскурсия (опционально)
            </ThemedText>
            <View style={styles.excursionsList}>
              <Pressable
                onPress={() => setSelectedExcursionId(null)}
                style={[
                  styles.excursionOption,
                  {
                    backgroundColor: !selectedExcursionId ? theme.primary + "20" : theme.backgroundSecondary,
                    borderColor: !selectedExcursionId ? theme.primary : theme.border,
                  },
                ]}
              >
                <Icon
                  name={!selectedExcursionId ? "check-circle" : "circle"}
                  size={18}
                  color={!selectedExcursionId ? theme.primary : theme.textSecondary}
                />
                <ThemedText style={[styles.excursionOptionText, { color: theme.textSecondary, fontStyle: "italic" }]}>
                  Без экскурсии
                </ThemedText>
              </Pressable>
              {todayExcursions.map(exc => (
                <Pressable
                  key={exc.id}
                  onPress={() => setSelectedExcursionId(exc.id)}
                  style={[
                    styles.excursionOption,
                    {
                      backgroundColor: selectedExcursionId === exc.id ? theme.primary + "20" : theme.backgroundSecondary,
                      borderColor: selectedExcursionId === exc.id ? theme.primary : theme.border,
                    },
                  ]}
                >
                  <Icon
                    name={selectedExcursionId === exc.id ? "check-circle" : "circle"}
                    size={18}
                    color={selectedExcursionId === exc.id ? theme.primary : theme.textSecondary}
                  />
                  <View style={styles.excursionOptionContent}>
                    <ThemedText style={styles.excursionOptionText}>{exc.tourTypeName}</ThemedText>
                    <ThemedText style={[styles.excursionOptionTime, { color: theme.textSecondary }]}>
                      {exc.time}
                    </ThemedText>
                  </View>
                </Pressable>
              ))}
              {todayExcursions.length === 0 ? (
                <ThemedText style={{ color: theme.textSecondary, padding: Spacing.sm, fontStyle: "italic" }}>
                  Нет экскурсий на сегодня
                </ThemedText>
              ) : null}
            </View>
          </View>

          <View style={styles.inputGroup}>
            <View style={styles.labelRow}>
              <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                Экскурсовод *
              </ThemedText>
              {allocatedGuides.length > 0 ? (
                <Pressable
                  onPress={() => {
                    console.log("[RadioGuides] Opening picker, guides:", allocatedGuides.length, allocatedGuides.map(g => g.name));
                    setShowGuidePicker(true);
                  }}
                  style={[styles.pickFromAllocation, { backgroundColor: theme.primary + "20", borderColor: theme.primary }]}
                >
                  <Icon name="users" size={14} color={theme.primary} />
                  <ThemedText style={[styles.pickFromAllocationText, { color: theme.primary }]}>
                    Из распред.
                  </ThemedText>
                </Pressable>
              ) : null}
            </View>
            <TextInput
              style={[
                styles.input,
                { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
              ]}
              value={guideName}
              onChangeText={setGuideName}
              placeholder="Имя экскурсовода"
              placeholderTextColor={theme.textSecondary}
            />
          </View>

          <View style={styles.inputGroup}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Номер автобуса (опционально)
            </ThemedText>
            <TextInput
              style={[
                styles.input,
                { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
              ]}
              value={busNumber}
              onChangeText={setBusNumber}
              placeholder="А123БВ"
              placeholderTextColor={theme.textSecondary}
            />
          </View>

          <View style={styles.inputGroup}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Количество приёмников *
            </ThemedText>
            <TextInput
              style={[
                styles.input,
                { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
              ]}
              value={receiversIssued}
              onChangeText={setReceiversIssued}
              placeholder="40"
              placeholderTextColor={theme.textSecondary}
              keyboardType="number-pad"
            />
          </View>

          <Pressable
            style={[styles.saveButton, { backgroundColor: theme.primary }]}
            onPress={handleIssue}
          >
            <ThemedText style={[styles.saveButtonText, { color: theme.buttonText }]}>
              Выдать
            </ThemedText>
          </Pressable>
        </View>
      );
    }

    if (modalMode === "return") {
      return (
        <View style={styles.form}>
          {selectedAssignment ? (
            <View style={[styles.returnInfo, { backgroundColor: theme.backgroundSecondary }]}>
              <ThemedText style={[styles.returnInfoText, { color: theme.textSecondary }]}>
                Экскурсовод: {selectedAssignment.guideName}
              </ThemedText>
              <ThemedText style={[styles.returnInfoText, { color: theme.textSecondary }]}>
                Выдано приёмников: {selectedAssignment.receiversIssued}
              </ThemedText>
            </View>
          ) : null}

          {!showShortageForm ? (
            <View style={styles.returnButtons}>
              <Pressable
                style={[styles.returnButton, { backgroundColor: theme.success }]}
                onPress={handleReturnAllOk}
              >
                <Icon name="check-circle" size={20} color={theme.buttonText} />
                <ThemedText style={[styles.returnButtonText, { color: theme.buttonText }]}>
                  Всё на месте
                </ThemedText>
              </Pressable>

              <Pressable
                style={[styles.returnButton, { backgroundColor: theme.warning }]}
                onPress={() => setShowShortageForm(true)}
              >
                <Icon name="alert-circle" size={20} color={theme.buttonText} />
                <ThemedText style={[styles.returnButtonText, { color: theme.buttonText }]}>
                  Не хватает
                </ThemedText>
              </Pressable>
            </View>
          ) : (
            <>
              <View style={styles.inputGroup}>
                <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                  Сколько не хватает? *
                </ThemedText>
                <TextInput
                  style={[
                    styles.input,
                    { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
                  ]}
                  value={missingCount}
                  onChangeText={setMissingCount}
                  placeholder={`Макс: ${selectedAssignment?.receiversIssued || 0}`}
                  placeholderTextColor={theme.textSecondary}
                  keyboardType="number-pad"
                  autoFocus
                />
              </View>

              <View style={styles.inputGroup}>
                <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                  Причина недостачи *
                </ThemedText>
                <TextInput
                  style={[
                    styles.input,
                    styles.multilineInput,
                    { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
                  ]}
                  value={lossReason}
                  onChangeText={setLossReason}
                  placeholder="Опишите причину..."
                  placeholderTextColor={theme.textSecondary}
                  multiline
                  numberOfLines={2}
                />
              </View>

              <View style={styles.returnButtons}>
                <Pressable
                  style={[styles.returnButton, { backgroundColor: theme.backgroundTertiary, borderWidth: 1, borderColor: theme.border }]}
                  onPress={() => setShowShortageForm(false)}
                >
                  <ThemedText style={[styles.returnButtonText, { color: theme.text }]}>
                    Назад
                  </ThemedText>
                </Pressable>

                <Pressable
                  style={[styles.returnButton, { backgroundColor: theme.primary }]}
                  onPress={handleReturnWithShortage}
                >
                  <ThemedText style={[styles.returnButtonText, { color: theme.buttonText }]}>
                    Подтвердить
                  </ThemedText>
                </Pressable>
              </View>
            </>
          )}
        </View>
      );
    }

    return null;
  }
}

const styles = StyleSheet.create({
  container: {
    padding: Spacing.lg,
    gap: Spacing.md,
  },
  kitCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    gap: Spacing.sm,
  },
  kitHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "flex-start",
    zIndex: 10,
  },
  kitInfo: {
    flex: 1,
  },
  kitNumber: {
    fontSize: 18,
    fontWeight: "600",
  },
  kitMeta: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    marginTop: Spacing.xs,
  },
  kitReceivers: {
    fontSize: 14,
  },
  statusBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  statusText: {
    fontSize: 12,
    fontWeight: "500",
  },
  assignmentInfo: {
    padding: Spacing.sm,
    borderRadius: BorderRadius.sm,
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.xs,
  },
  assignmentLabel: {
    fontSize: 13,
  },
  assignmentValue: {
    fontSize: 13,
    fontWeight: "500",
    marginRight: Spacing.md,
  },
  kitNotes: {
    fontSize: 13,
    fontStyle: "italic",
  },
  kitActions: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginTop: Spacing.xs,
  },
  actionButton: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
    gap: Spacing.xs,
  },
  actionButtonText: {
    fontSize: 14,
    fontWeight: "500",
  },
  iconButton: {
    padding: Spacing.sm,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
  batteryIndicator: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
  batteryDropdown: {
    position: "absolute",
    top: "100%",
    right: 0,
    marginTop: 4,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    padding: Spacing.xs,
    zIndex: 1000,
    minWidth: 160,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 4,
    elevation: 5,
  },
  batteryDropdownItem: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.sm,
    borderRadius: BorderRadius.xs,
  },
  batteryDropdownText: {
    flex: 1,
    fontSize: 14,
  },
  emptyContainer: {
    alignItems: "center",
    paddingVertical: Spacing["2xl"],
    gap: Spacing.md,
  },
  emptyText: {
    fontSize: 16,
  },
  emptyHint: {
    fontSize: 14,
  },
  fab: {
    position: "absolute",
    right: Spacing.lg,
    bottom: Spacing.lg + 80,
    width: 56,
    height: 56,
    borderRadius: 28,
    alignItems: "center",
    justifyContent: "center",
    elevation: 4,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 4,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
    justifyContent: "flex-end",
  },
  modalBackdrop: {
    ...StyleSheet.absoluteFillObject,
  },
  modal: {
    borderTopLeftRadius: BorderRadius.lg,
    borderTopRightRadius: BorderRadius.lg,
    padding: Spacing.lg,
    paddingBottom: Spacing.xl,
  },
  modalContent: {
    borderTopLeftRadius: BorderRadius.lg,
    borderTopRightRadius: BorderRadius.lg,
    padding: Spacing.lg,
    maxHeight: "80%",
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.lg,
  },
  modalTitle: {
    fontSize: 20,
    fontWeight: "600",
  },
  formScroll: {
    flexGrow: 0,
  },
  formScrollContent: {
    paddingBottom: Spacing.lg,
  },
  form: {
    gap: Spacing.md,
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
  multilineInput: {
    minHeight: 60,
    textAlignVertical: "top",
  },
  saveButton: {
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    marginTop: Spacing.sm,
  },
  saveButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
  returnInfo: {
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    gap: Spacing.xs,
  },
  returnInfoText: {
    fontSize: 14,
  },
  returnButtons: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  returnButton: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    gap: Spacing.sm,
  },
  returnButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
  excursionsList: {
    gap: Spacing.xs,
  },
  excursionOption: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.sm,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    gap: Spacing.sm,
  },
  excursionOptionContent: {
    flex: 1,
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  excursionOptionText: {
    fontSize: 14,
  },
  excursionOptionTime: {
    fontSize: 13,
  },
  statsRow: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  statCard: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    alignItems: "center",
    gap: Spacing.xs,
  },
  statNumber: {
    fontSize: 24,
    fontWeight: "700",
  },
  statLabel: {
    fontSize: 12,
  },
  section: {
    gap: Spacing.sm,
  },
  sectionHeaderRow: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
  },
  sectionHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    paddingVertical: Spacing.xs,
  },
  sortButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: "600",
  },
  kitsList: {
    gap: Spacing.sm,
  },
  kitTitleRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  overdueBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  overdueBadgeText: {
    fontSize: 11,
    fontWeight: "600",
    color: "#fff",
  },
  emptySection: {
    padding: Spacing.lg,
    alignItems: "center",
  },
  showAllButton: {
    padding: Spacing.md,
    alignItems: "center",
    marginTop: Spacing.md,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
  },
  dispatcherFooter: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginTop: Spacing.xl,
    paddingTop: Spacing.lg,
    borderTopWidth: 1,
  },
  dispatcherInfo: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  logoutButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
  },
  labelRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.xs,
  },
  pickFromAllocation: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingHorizontal: Spacing.sm,
    paddingVertical: 4,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
  pickFromAllocationText: {
    fontSize: 12,
    fontWeight: "500",
  },
  guidePickerHeader: {
    flexDirection: "row",
    alignItems: "center",
    marginBottom: Spacing.md,
    gap: Spacing.md,
  },
  backButton: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.sm,
    borderRadius: BorderRadius.md,
  },
  guidePickerTitle: {
    fontSize: 16,
    fontWeight: "600",
  },
  guidePickerItem: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    marginBottom: Spacing.sm,
  },
  guidePickerInfo: {
    flex: 1,
  },
  guidePickerName: {
    fontSize: 15,
    fontWeight: "500",
  },
  guidePickerTour: {
    fontSize: 12,
    marginTop: 2,
  },
  guidePickerBus: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingHorizontal: Spacing.sm,
    paddingVertical: 4,
    borderRadius: BorderRadius.sm,
  },
  guidePickerBusText: {
    fontSize: 12,
    fontWeight: "600",
  },
});
