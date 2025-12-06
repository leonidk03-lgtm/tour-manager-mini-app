import { View, StyleSheet, Pressable, Alert, Modal } from "react-native";
import { Feather } from "@expo/vector-icons";
import { useRoute, useNavigation } from "@react-navigation/native";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { AddExcursionForm } from "@/components/AddExcursionForm";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, Excursion as ExcursionType } from "@/contexts/DataContext";
import {
  calculateExcursionRevenue,
  calculateExcursionExpenses,
  calculateExcursionProfit,
  formatCurrency,
} from "@/utils/calculations";
import { useLayoutEffect, useState } from "react";

const parseLocalDate = (dateString: string): Date => {
  const [year, month, day] = dateString.split('-').map(Number);
  return new Date(year, month - 1, day);
};

export default function ExcursionDetailScreen() {
  const { theme } = useTheme();
  const route = useRoute();
  const navigation = useNavigation();
  const { excursionId } = route.params as { excursionId: string };
  const { excursions, tourTypes, additionalServices, deleteExcursion, updateExcursion } = useData();
  const [showEditModal, setShowEditModal] = useState(false);
  const [editKey, setEditKey] = useState(0);

  const excursion = excursions.find((e) => e.id === excursionId);
  const tourType = tourTypes.find((t) => t.id === excursion?.tourTypeId);

  useLayoutEffect(() => {
    navigation.setOptions({
      headerRight: () => (
        <View style={{ flexDirection: "row", gap: Spacing.xl }}>
          <Pressable onPress={handleEdit} style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1, padding: 4 })}>
            <Feather name="edit" size={22} color={theme.primary} />
          </Pressable>
          <Pressable onPress={handleDelete} style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1, padding: 4 })}>
            <Feather name="trash-2" size={22} color={theme.error} />
          </Pressable>
        </View>
      ),
    });
  }, [navigation]);

  const handleEdit = () => {
    setEditKey((prev) => prev + 1);
    setShowEditModal(true);
  };

  const handleSaveEdit = (updatedExcursion: ExcursionType) => {
    updateExcursion(excursionId, updatedExcursion);
    setShowEditModal(false);
  };

  const handleDelete = () => {
    Alert.alert("Удалить экскурсию?", "Это действие нельзя будет отменить", [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: () => {
          deleteExcursion(excursionId);
          navigation.goBack();
        },
      },
    ]);
  };

  if (!excursion || !tourType) {
    return (
      <View style={styles.container}>
        <ThemedText>Экскурсия не найдена</ThemedText>
      </View>
    );
  }

  const revenue = calculateExcursionRevenue(excursion, tourType, additionalServices);
  const expenses = calculateExcursionExpenses(excursion);
  const profit = calculateExcursionProfit(excursion, tourType, additionalServices);
  const totalParticipants =
    excursion.fullPriceCount + excursion.discountedCount + excursion.freeCount + 
    excursion.tourPackageCount + (excursion.byTourCount || 0) + (excursion.paidCount || 0);

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <ThemedView
          style={[
            styles.card,
            {
              borderColor: theme.border,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <ThemedText style={styles.tourName}>{tourType.name}</ThemedText>
          <View style={styles.info}>
            <View style={styles.infoRow}>
              <Feather name="calendar" size={16} color={theme.textSecondary} />
              <ThemedText style={[styles.infoText, { color: theme.textSecondary }]}>
                {parseLocalDate(excursion.date).toLocaleDateString("ru-RU", {
                  weekday: "long",
                  year: "numeric",
                  month: "long",
                  day: "numeric",
                })}
              </ThemedText>
            </View>
            <View style={styles.infoRow}>
              <Feather name="clock" size={16} color={theme.textSecondary} />
              <ThemedText style={[styles.infoText, { color: theme.textSecondary }]}>
                {excursion.time}
              </ThemedText>
            </View>
          </View>
        </ThemedView>

        <ThemedView
          style={[
            styles.card,
            {
              borderColor: theme.border,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <ThemedText style={styles.sectionTitle}>Участники</ThemedText>
          <View style={styles.participantsTable}>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Всего:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{totalParticipants} чел.</ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Полная оплата:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{excursion.fullPriceCount} чел.</ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Льготная:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{excursion.discountedCount} чел.</ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Бесплатно:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{excursion.freeCount} чел.</ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Турпакет:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{excursion.tourPackageCount} чел.</ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                По туру:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{excursion.byTourCount || 0} чел.</ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Оплаченные:
              </ThemedText>
              <ThemedText style={styles.tableValue}>{excursion.paidCount || 0} чел.</ThemedText>
            </View>
          </View>
        </ThemedView>

        <ThemedView
          style={[
            styles.card,
            {
              borderColor: theme.border,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <ThemedText style={styles.sectionTitle}>Доход</ThemedText>
          <View style={styles.participantsTable}>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Билеты (полная):
              </ThemedText>
              <ThemedText style={styles.tableValue}>
                {formatCurrency(excursion.fullPriceCount * tourType.fullPrice)}
              </ThemedText>
            </View>
            <View style={styles.tableRow}>
              <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                Билеты (льготная):
              </ThemedText>
              <ThemedText style={styles.tableValue}>
                {formatCurrency(excursion.discountedCount * tourType.discountedPrice)}
              </ThemedText>
            </View>
            {excursion.additionalServices.map((service) => {
              const serviceData = additionalServices.find((s) => s.id === service.serviceId);
              if (!serviceData) return null;
              return (
                <View key={service.serviceId} style={styles.tableRow}>
                  <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                    {serviceData.name}:
                  </ThemedText>
                  <ThemedText style={styles.tableValue}>
                    {formatCurrency(serviceData.price * service.count)}
                  </ThemedText>
                </View>
              );
            })}
            <View style={[styles.tableRow, styles.totalRow]}>
              <ThemedText style={styles.totalLabel}>Итого:</ThemedText>
              <ThemedText style={styles.totalValue}>{formatCurrency(revenue)}</ThemedText>
            </View>
          </View>
        </ThemedView>

        <ThemedView
          style={[
            styles.card,
            {
              borderColor: theme.border,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <ThemedText style={styles.sectionTitle}>Расходы</ThemedText>
          <View style={styles.participantsTable}>
            {excursion.expenses.map((expense) => (
              <View key={expense.id} style={styles.tableRow}>
                <ThemedText style={[styles.tableLabel, { color: theme.textSecondary }]}>
                  {expense.type}:
                </ThemedText>
                <ThemedText style={styles.tableValue}>{formatCurrency(expense.amount)}</ThemedText>
              </View>
            ))}
            <View style={[styles.tableRow, styles.totalRow]}>
              <ThemedText style={styles.totalLabel}>Итого:</ThemedText>
              <ThemedText style={styles.totalValue}>{formatCurrency(expenses)}</ThemedText>
            </View>
          </View>
        </ThemedView>

        <ThemedView
          style={[
            styles.profitCard,
            {
              backgroundColor: profit >= 0 ? theme.success : theme.error,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <ThemedText style={[styles.profitLabel, { color: "#FFFFFF" }]}>
            Чистая прибыль
          </ThemedText>
          <ThemedText style={[styles.profitValue, { color: "#FFFFFF" }]}>
            {formatCurrency(profit)}
          </ThemedText>
        </ThemedView>
      </View>

      <Modal visible={showEditModal} animationType="slide" presentationStyle="pageSheet">
        <AddExcursionForm
          key={editKey}
          excursion={excursion}
          onSave={handleSaveEdit}
          onCancel={() => setShowEditModal(false)}
        />
      </Modal>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing.lg,
  },
  card: {
    padding: Spacing.lg,
    borderWidth: 1,
    gap: Spacing.md,
  },
  tourName: {
    fontSize: 24,
    fontWeight: "700",
  },
  info: {
    gap: Spacing.sm,
  },
  infoRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  infoText: {
    fontSize: 14,
    textTransform: "capitalize",
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  participantsTable: {
    gap: Spacing.sm,
  },
  tableRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  tableLabel: {
    fontSize: 14,
  },
  tableValue: {
    fontSize: 14,
    fontWeight: "500",
  },
  totalRow: {
    marginTop: Spacing.sm,
    paddingTop: Spacing.sm,
    borderTopWidth: 1,
    borderTopColor: "#E5E7EB",
  },
  totalLabel: {
    fontSize: 16,
    fontWeight: "600",
  },
  totalValue: {
    fontSize: 16,
    fontWeight: "700",
  },
  profitCard: {
    padding: Spacing.xl,
    alignItems: "center",
    gap: Spacing.sm,
  },
  profitLabel: {
    fontSize: 16,
    fontWeight: "500",
  },
  profitValue: {
    fontSize: 32,
    fontWeight: "700",
  },
});
