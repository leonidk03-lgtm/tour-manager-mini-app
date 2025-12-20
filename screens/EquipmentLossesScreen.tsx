import { useState, useMemo } from "react";
import {
  View,
  StyleSheet,
  Pressable,
  Alert,
  TextInput,
  Modal,
} from "react-native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, EquipmentLoss } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";

type FilterType = "all" | "lost" | "found";

export default function EquipmentLossesScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const {
    equipmentLosses,
    equipmentItems,
    updateEquipmentLoss,
    markLossAsFound,
    deleteEquipmentLoss,
  } = useData();
  
  const getEquipmentName = (itemId: string | null | undefined): string => {
    if (!itemId) return "Оборудование";
    const item = equipmentItems.find(i => i.id === itemId);
    return item?.name || "Оборудование";
  };

  const [filter, setFilter] = useState<FilterType>("lost");
  const [editModalVisible, setEditModalVisible] = useState(false);
  const [foundModalVisible, setFoundModalVisible] = useState(false);
  const [selectedLoss, setSelectedLoss] = useState<EquipmentLoss | null>(null);
  const [editReason, setEditReason] = useState("");
  const [editMissingCount, setEditMissingCount] = useState("");
  const [foundNotes, setFoundNotes] = useState("");

  const filteredLosses = useMemo(() => {
    if (filter === "all") return equipmentLosses;
    return equipmentLosses.filter((l) => l.status === filter);
  }, [equipmentLosses, filter]);

  const stats = useMemo(() => {
    const lostItems = equipmentLosses.filter((l) => l.status === "lost");
    const foundItems = equipmentLosses.filter((l) => l.status === "found");
    const totalLost = lostItems.reduce((sum, l) => sum + l.missingCount, 0);
    const totalFound = foundItems.reduce((sum, l) => sum + l.missingCount, 0);
    return { lostItems: lostItems.length, foundItems: foundItems.length, totalLost, totalFound };
  }, [equipmentLosses]);

  const openEditModal = (loss: EquipmentLoss) => {
    setSelectedLoss(loss);
    setEditReason(loss.reason);
    setEditMissingCount(loss.missingCount.toString());
    setEditModalVisible(true);
  };

  const openFoundModal = (loss: EquipmentLoss) => {
    setSelectedLoss(loss);
    setFoundNotes("");
    setFoundModalVisible(true);
  };

  const handleSaveEdit = async () => {
    if (!selectedLoss) return;

    const count = parseInt(editMissingCount);
    if (isNaN(count) || count <= 0) {
      Alert.alert("Ошибка", "Введите корректное количество");
      return;
    }

    if (!editReason.trim()) {
      Alert.alert("Ошибка", "Укажите причину");
      return;
    }

    try {
      await updateEquipmentLoss(selectedLoss.id, {
        reason: editReason.trim(),
        missingCount: count,
      });
      setEditModalVisible(false);
      setSelectedLoss(null);
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось обновить запись");
    }
  };

  const handleMarkAsFound = async () => {
    if (!selectedLoss) return;

    try {
      await markLossAsFound(selectedLoss.id, foundNotes.trim() || undefined);
      setFoundModalVisible(false);
      setSelectedLoss(null);
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось обновить статус");
    }
  };

  const handleDelete = (loss: EquipmentLoss) => {
    Alert.alert(
      "Удалить запись?",
      "Эта запись будет удалена безвозвратно.",
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Удалить",
          style: "destructive",
          onPress: async () => {
            try {
              await deleteEquipmentLoss(loss.id);
            } catch (err) {
              Alert.alert("Ошибка", "Не удалось удалить запись");
            }
          },
        },
      ]
    );
  };

  const formatDate = (dateStr: string) => {
    return new Date(dateStr).toLocaleDateString("ru-RU", {
      day: "numeric",
      month: "short",
      year: "numeric",
    });
  };

  const renderLossCard = (loss: EquipmentLoss) => {
    const isLost = loss.status === "lost";

    return (
      <ThemedView
        key={loss.id}
        style={[
          styles.card,
          {
            borderColor: isLost ? theme.error : theme.success,
            backgroundColor: isLost ? theme.error + "10" : theme.success + "10",
          },
        ]}
      >
        <View style={styles.cardHeader}>
          <View style={styles.cardTitleRow}>
            <View
              style={[
                styles.bagBadge,
                { backgroundColor: loss.rentalOrderId ? theme.warning : theme.primary },
              ]}
            >
              <ThemedText style={[styles.bagNumber, { color: theme.buttonText }]}>
                {loss.rentalOrderId ? "Аренда" : `Сумка ${loss.bagNumber || "?"}`}
              </ThemedText>
            </View>
            <View
              style={[
                styles.statusBadge,
                { backgroundColor: isLost ? theme.error : theme.success },
              ]}
            >
              <ThemedText style={[styles.statusText, { color: theme.buttonText }]}>
                {isLost ? "Потеряно" : "Найдено"}
              </ThemedText>
            </View>
          </View>
          <ThemedText style={[styles.date, { color: theme.textSecondary }]}>
            {formatDate(loss.createdAt)}
          </ThemedText>
        </View>

        <View style={styles.cardContent}>
          <View style={styles.infoRow}>
            <Icon name="user" size={14} color={theme.textSecondary} />
            <ThemedText style={[styles.infoText, { color: theme.text }]}>
              {loss.guideName}
            </ThemedText>
          </View>
          <View style={styles.infoRow}>
            <Icon name="radio" size={14} color={theme.textSecondary} />
            <ThemedText style={[styles.infoText, { color: theme.text }]}>
              {getEquipmentName(loss.equipmentItemId)}: {loss.missingCount} шт.
            </ThemedText>
          </View>
          <View style={styles.infoRow}>
            <Icon name="file-text" size={14} color={theme.textSecondary} />
            <ThemedText style={[styles.infoText, { color: theme.text }]} numberOfLines={2}>
              {loss.reason}
            </ThemedText>
          </View>
          {loss.foundNotes ? (
            <View style={styles.infoRow}>
              <Icon name="check-circle" size={14} color={theme.success} />
              <ThemedText style={[styles.infoText, { color: theme.success }]} numberOfLines={2}>
                {loss.foundNotes}
              </ThemedText>
            </View>
          ) : null}
          <ThemedText style={[styles.managerText, { color: theme.textSecondary }]}>
            Зафиксировал: {loss.managerName}
          </ThemedText>
        </View>

        <View style={styles.cardActions}>
          {isLost ? (
            <Pressable
              style={[styles.actionButton, { backgroundColor: theme.success }]}
              onPress={() => openFoundModal(loss)}
            >
              <Icon name="check" size={16} color={theme.buttonText} />
              <ThemedText style={[styles.actionButtonText, { color: theme.buttonText }]}>
                Найдено
              </ThemedText>
            </Pressable>
          ) : null}
          <Pressable
            style={[styles.actionButton, { backgroundColor: theme.backgroundTertiary, borderWidth: 1, borderColor: theme.border }]}
            onPress={() => openEditModal(loss)}
          >
            <Icon name="edit-2" size={16} color={theme.text} />
            <ThemedText style={[styles.actionButtonText, { color: theme.text }]}>
              Изменить
            </ThemedText>
          </Pressable>
          {isAdmin ? (
            <Pressable
              style={[styles.actionButton, { backgroundColor: theme.error }]}
              onPress={() => handleDelete(loss)}
            >
              <Icon name="trash-2" size={16} color={theme.buttonText} />
            </Pressable>
          ) : null}
        </View>
      </ThemedView>
    );
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <View style={[styles.statsCard, { backgroundColor: theme.backgroundSecondary, borderColor: theme.border }]}>
          <View style={styles.statItem}>
            <ThemedText style={[styles.statValue, { color: theme.error }]}>
              {stats.totalLost}
            </ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
              Потеряно
            </ThemedText>
          </View>
          <View style={[styles.statDivider, { backgroundColor: theme.border }]} />
          <View style={styles.statItem}>
            <ThemedText style={[styles.statValue, { color: theme.success }]}>
              {stats.totalFound}
            </ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
              Найдено
            </ThemedText>
          </View>
          <View style={[styles.statDivider, { backgroundColor: theme.border }]} />
          <View style={styles.statItem}>
            <ThemedText style={[styles.statValue, { color: theme.warning }]}>
              {stats.totalLost - stats.totalFound}
            </ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
              Не найдено
            </ThemedText>
          </View>
        </View>

        <View style={styles.filterRow}>
          {(["lost", "found", "all"] as FilterType[]).map((f) => (
            <Pressable
              key={f}
              style={[
                styles.filterButton,
                {
                  backgroundColor: filter === f ? theme.primary : theme.backgroundSecondary,
                  borderColor: filter === f ? theme.primary : theme.border,
                },
              ]}
              onPress={() => setFilter(f)}
            >
              <ThemedText
                style={[
                  styles.filterText,
                  { color: filter === f ? theme.buttonText : theme.text },
                ]}
              >
                {f === "lost" ? "Потерянные" : f === "found" ? "Найденные" : "Все"}
              </ThemedText>
            </Pressable>
          ))}
        </View>

        {filteredLosses.length === 0 ? (
          <ThemedView style={[styles.emptyCard, { borderColor: theme.border }]}>
            <Icon name="check-circle" size={48} color={theme.success} />
            <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
              {filter === "lost" ? "Нет потерянного оборудования" : filter === "found" ? "Нет найденного оборудования" : "Нет записей об утерях"}
            </ThemedText>
          </ThemedView>
        ) : (
          filteredLosses.map(renderLossCard)
        )}
      </View>

      <Modal
        visible={editModalVisible}
        animationType="slide"
        transparent
        onRequestClose={() => setEditModalVisible(false)}
      >
        <View style={styles.modalOverlay}>
          <ThemedView style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Редактировать запись</ThemedText>
              <Pressable onPress={() => setEditModalVisible(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <View style={styles.inputGroup}>
              <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                Количество
              </ThemedText>
              <TextInput
                style={[
                  styles.input,
                  { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
                ]}
                value={editMissingCount}
                onChangeText={setEditMissingCount}
                keyboardType="number-pad"
                placeholderTextColor={theme.textSecondary}
              />
            </View>

            <View style={styles.inputGroup}>
              <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                Причина
              </ThemedText>
              <TextInput
                style={[
                  styles.input,
                  styles.multilineInput,
                  { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
                ]}
                value={editReason}
                onChangeText={setEditReason}
                multiline
                numberOfLines={3}
                placeholderTextColor={theme.textSecondary}
              />
            </View>

            <Pressable
              style={[styles.saveButton, { backgroundColor: theme.primary }]}
              onPress={handleSaveEdit}
            >
              <ThemedText style={[styles.saveButtonText, { color: theme.buttonText }]}>
                Сохранить
              </ThemedText>
            </Pressable>
          </ThemedView>
        </View>
      </Modal>

      <Modal
        visible={foundModalVisible}
        animationType="slide"
        transparent
        onRequestClose={() => setFoundModalVisible(false)}
      >
        <View style={styles.modalOverlay}>
          <ThemedView style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Оборудование найдено</ThemedText>
              <Pressable onPress={() => setFoundModalVisible(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <View style={styles.inputGroup}>
              <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                Комментарий (опционально)
              </ThemedText>
              <TextInput
                style={[
                  styles.input,
                  styles.multilineInput,
                  { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
                ]}
                value={foundNotes}
                onChangeText={setFoundNotes}
                multiline
                numberOfLines={3}
                placeholder="Где и как было найдено..."
                placeholderTextColor={theme.textSecondary}
              />
            </View>

            <Pressable
              style={[styles.saveButton, { backgroundColor: theme.success }]}
              onPress={handleMarkAsFound}
            >
              <Icon name="check" size={20} color={theme.buttonText} />
              <ThemedText style={[styles.saveButtonText, { color: theme.buttonText }]}>
                Отметить как найденное
              </ThemedText>
            </Pressable>
          </ThemedView>
        </View>
      </Modal>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    padding: Spacing.lg,
    gap: Spacing.md,
  },
  statsCard: {
    flexDirection: "row",
    padding: Spacing.lg,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
  },
  statItem: {
    flex: 1,
    alignItems: "center",
  },
  statValue: {
    fontSize: 24,
    fontWeight: "700",
  },
  statLabel: {
    fontSize: 12,
    marginTop: 2,
  },
  statDivider: {
    width: 1,
    marginHorizontal: Spacing.md,
  },
  filterRow: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  filterButton: {
    flex: 1,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    alignItems: "center",
  },
  filterText: {
    fontSize: 13,
    fontWeight: "500",
  },
  card: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    gap: Spacing.sm,
  },
  cardHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "flex-start",
  },
  cardTitleRow: {
    flexDirection: "row",
    gap: Spacing.sm,
    alignItems: "center",
  },
  bagBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  bagNumber: {
    fontSize: 13,
    fontWeight: "600",
  },
  statusBadge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  statusText: {
    fontSize: 11,
    fontWeight: "600",
  },
  date: {
    fontSize: 12,
  },
  cardContent: {
    gap: Spacing.xs,
  },
  infoRow: {
    flexDirection: "row",
    alignItems: "flex-start",
    gap: Spacing.sm,
  },
  infoText: {
    fontSize: 14,
    flex: 1,
  },
  managerText: {
    fontSize: 12,
    marginTop: Spacing.xs,
  },
  cardActions: {
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
    fontSize: 13,
    fontWeight: "500",
  },
  emptyCard: {
    padding: Spacing.xl,
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.md,
  },
  emptyText: {
    fontSize: 14,
    textAlign: "center",
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
    justifyContent: "flex-end",
  },
  modalContent: {
    borderTopLeftRadius: BorderRadius.lg,
    borderTopRightRadius: BorderRadius.lg,
    padding: Spacing.lg,
    gap: Spacing.md,
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  inputGroup: {
    gap: Spacing.xs,
  },
  label: {
    fontSize: 14,
  },
  input: {
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    fontSize: 16,
  },
  multilineInput: {
    minHeight: 80,
    textAlignVertical: "top",
  },
  saveButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    gap: Spacing.sm,
    marginTop: Spacing.sm,
  },
  saveButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
});
