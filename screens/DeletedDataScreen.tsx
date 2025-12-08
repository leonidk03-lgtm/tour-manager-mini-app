import { View, StyleSheet, Pressable, Alert } from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, Excursion, Transaction, ExcursionNote, DispatchingNote, RadioGuideKit, EquipmentLoss } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";

export default function DeletedDataScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const { deletedItems, restoreDeletedItem, permanentlyDeleteItem, clearDeletedItems, tourTypes } = useData();

  const handleRestore = (id: string) => {
    Alert.alert("Восстановить?", "Данные будут возвращены в основной список", [
      { text: "Отмена", style: "cancel" },
      { text: "Восстановить", onPress: () => restoreDeletedItem(id) },
    ]);
  };

  const handlePermanentDelete = (id: string) => {
    Alert.alert("Удалить навсегда?", "Это действие нельзя отменить", [
      { text: "Отмена", style: "cancel" },
      { text: "Удалить", style: "destructive", onPress: () => permanentlyDeleteItem(id) },
    ]);
  };

  const handleClearAll = () => {
    if (deletedItems.length === 0) return;
    Alert.alert("Очистить корзину?", "Все удаленные данные будут потеряны навсегда", [
      { text: "Отмена", style: "cancel" },
      { text: "Очистить", style: "destructive", onPress: () => clearDeletedItems() },
    ]);
  };

  const formatDate = (isoString: string) => {
    const date = new Date(isoString);
    return date.toLocaleDateString("ru-RU", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
      hour: "2-digit",
      minute: "2-digit",
    });
  };

  const getItemTitle = (item: typeof deletedItems[0]) => {
    if (item.type === "excursion") {
      const excursion = item.data as Excursion;
      const tourType = tourTypes.find((t) => t.id === excursion.tourTypeId);
      return tourType?.name || "Экскурсия";
    } else if (item.type === "transaction") {
      const transaction = item.data as Transaction;
      return transaction.description;
    } else if (item.type === "excursion_note" || item.type === "excursion_note_expired") {
      const note = item.data as ExcursionNote;
      return note.text.length > 50 ? note.text.substring(0, 50) + "..." : note.text;
    } else if (item.type === "dispatching_note") {
      const note = item.data as DispatchingNote;
      return note.text.length > 50 ? note.text.substring(0, 50) + "..." : note.text;
    } else if (item.type === "radio_guide_kit") {
      const kit = item.data as RadioGuideKit;
      return `Сумка #${kit.bagNumber}`;
    } else if (item.type === "equipment_loss") {
      const loss = item.data as EquipmentLoss;
      return `Утеря: ${loss.missingCount} шт.`;
    }
    return "Неизвестный элемент";
  };

  const getItemSubtitle = (item: typeof deletedItems[0]) => {
    if (item.type === "excursion") {
      const excursion = item.data as Excursion;
      return `Экскурсия от ${excursion.date}`;
    } else if (item.type === "transaction") {
      const transaction = item.data as Transaction;
      return `${transaction.type === "income" ? "Доход" : "Расход"}: ${transaction.amount} р.`;
    } else if (item.type === "excursion_note" || item.type === "excursion_note_expired") {
      const note = item.data as ExcursionNote;
      return `Заметка к экскурсии от ${note.managerName || "неизвестно"}`;
    } else if (item.type === "dispatching_note") {
      return "Личная заметка";
    } else if (item.type === "radio_guide_kit") {
      const kit = item.data as RadioGuideKit;
      return `Статус: ${kit.status === "available" ? "Доступна" : kit.status === "issued" ? "Выдана" : "На обслуживании"}`;
    } else if (item.type === "equipment_loss") {
      const loss = item.data as EquipmentLoss;
      return `Гид: ${loss.guideName}, причина: ${loss.reason}`;
    }
    return "";
  };

  const getTypeBadge = (type: string) => {
    switch (type) {
      case "excursion": return { label: "Экскурсия", color: theme.primary };
      case "transaction": return { label: "Транзакция", color: theme.warning };
      case "excursion_note": return { label: "Заметка к экскурсии", color: theme.success };
      case "excursion_note_expired": return { label: "Заметка (истекла)", color: theme.textSecondary };
      case "dispatching_note": return { label: "Личная заметка", color: theme.secondary };
      case "radio_guide_kit": return { label: "Сумка радиогида", color: theme.primary };
      case "equipment_loss": return { label: "Утеря оборудования", color: theme.error };
      default: return { label: "Другое", color: theme.textSecondary };
    }
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        {isAdmin && deletedItems.length > 0 ? (
          <Pressable
            onPress={handleClearAll}
            style={[styles.clearButton, { backgroundColor: theme.error }]}
          >
            <Feather name="trash-2" size={18} color="#FFFFFF" />
            <ThemedText style={[styles.clearButtonText, { color: "#FFFFFF" }]}>
              Очистить всё
            </ThemedText>
          </Pressable>
        ) : null}

        {deletedItems.length === 0 ? (
          <ThemedView
            style={[
              styles.emptyCard,
              { borderColor: theme.border, borderRadius: BorderRadius.sm },
            ]}
          >
            <Feather name="trash" size={48} color={theme.textSecondary} />
            <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
              Корзина пуста
            </ThemedText>
          </ThemedView>
        ) : (
          deletedItems.map((item) => (
            <ThemedView
              key={item.id}
              style={[
                styles.itemCard,
                { borderColor: theme.border, borderRadius: BorderRadius.sm },
              ]}
            >
              <View style={styles.itemHeader}>
                <View style={styles.itemInfo}>
                  <View
                    style={[
                      styles.typeBadge,
                      { backgroundColor: getTypeBadge(item.type).color + "20" },
                    ]}
                  >
                    <ThemedText
                      style={[
                        styles.typeBadgeText,
                        { color: getTypeBadge(item.type).color },
                      ]}
                    >
                      {getTypeBadge(item.type).label}
                    </ThemedText>
                  </View>
                  <ThemedText style={styles.itemTitle}>{getItemTitle(item)}</ThemedText>
                  <ThemedText style={[styles.itemSubtitle, { color: theme.textSecondary }]}>
                    {getItemSubtitle(item)}
                  </ThemedText>
                  <ThemedText style={[styles.deletedAt, { color: theme.textSecondary }]}>
                    Удалено: {formatDate(item.deletedAt)}
                  </ThemedText>
                </View>
              </View>
              <View style={styles.itemActions}>
                <Pressable
                  onPress={() => handleRestore(item.id)}
                  style={[styles.actionButton, { backgroundColor: theme.success }]}
                >
                  <Feather name="rotate-ccw" size={16} color="#FFFFFF" />
                  <ThemedText style={[styles.actionButtonText, { color: "#FFFFFF" }]}>
                    Восстановить
                  </ThemedText>
                </Pressable>
                {isAdmin ? (
                  <Pressable
                    onPress={() => handlePermanentDelete(item.id)}
                    style={[styles.actionButton, { backgroundColor: theme.error }]}
                  >
                    <Feather name="x" size={16} color="#FFFFFF" />
                    <ThemedText style={[styles.actionButtonText, { color: "#FFFFFF" }]}>
                      Удалить
                    </ThemedText>
                  </Pressable>
                ) : null}
              </View>
            </ThemedView>
          ))
        )}
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing.lg,
  },
  clearButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    gap: Spacing.sm,
  },
  clearButtonText: {
    fontSize: 14,
    fontWeight: "600",
  },
  emptyCard: {
    padding: Spacing["3xl"],
    borderWidth: 1,
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.md,
  },
  emptyText: {
    fontSize: 16,
  },
  itemCard: {
    padding: Spacing.lg,
    borderWidth: 1,
    gap: Spacing.md,
  },
  itemHeader: {
    flexDirection: "row",
    alignItems: "flex-start",
    justifyContent: "space-between",
  },
  itemInfo: {
    flex: 1,
    gap: Spacing.xs,
  },
  typeBadge: {
    alignSelf: "flex-start",
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.xs,
    marginBottom: Spacing.xs,
  },
  typeBadgeText: {
    fontSize: 11,
    fontWeight: "600",
  },
  itemTitle: {
    fontSize: 16,
    fontWeight: "600",
  },
  itemSubtitle: {
    fontSize: 14,
  },
  deletedAt: {
    fontSize: 12,
    marginTop: Spacing.xs,
  },
  itemActions: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  actionButton: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.sm,
    borderRadius: BorderRadius.sm,
    gap: Spacing.xs,
  },
  actionButtonText: {
    fontSize: 13,
    fontWeight: "500",
  },
});
