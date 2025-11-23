import { useState } from "react";
import { View, StyleSheet, Pressable, Alert, Switch } from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { TourTypeModal } from "@/components/TourTypeModal";
import { ServiceModal } from "@/components/ServiceModal";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, TourType, AdditionalService } from "@/contexts/DataContext";

export default function TicketPricesScreen() {
  const { theme } = useTheme();
  const {
    tourTypes,
    addTourType,
    updateTourType,
    deleteTourType,
    additionalServices,
    addAdditionalService,
    updateAdditionalService,
    deleteAdditionalService,
  } = useData();

  const [tourModalVisible, setTourModalVisible] = useState(false);
  const [serviceModalVisible, setServiceModalVisible] = useState(false);
  const [editingTour, setEditingTour] = useState<TourType | undefined>();
  const [editingService, setEditingService] = useState<AdditionalService | undefined>();

  const handleAddTour = () => {
    setEditingTour(undefined);
    setTourModalVisible(true);
  };

  const handleEditTour = (tour: TourType) => {
    setEditingTour(tour);
    setTourModalVisible(true);
  };

  const handleSaveTour = (tour: TourType) => {
    if (editingTour) {
      updateTourType(tour.id, tour);
      Alert.alert("Сохранено", "Экскурсия успешно обновлена");
    } else {
      addTourType(tour);
      Alert.alert("Успешно", "Экскурсия добавлена");
    }
  };

  const handleDeleteTour = (id: string) => {
    Alert.alert("Удалить экскурсию?", "Это действие нельзя отменить", [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: () => {
          deleteTourType(id);
          Alert.alert("Удалено", "Экскурсия удалена");
        },
      },
    ]);
  };

  const handleToggleTour = (tour: TourType) => {
    updateTourType(tour.id, { ...tour, isEnabled: !tour.isEnabled });
  };

  const handleAddService = () => {
    setEditingService(undefined);
    setServiceModalVisible(true);
  };

  const handleEditService = (service: AdditionalService) => {
    setEditingService(service);
    setServiceModalVisible(true);
  };

  const handleSaveService = (service: AdditionalService) => {
    if (editingService) {
      updateAdditionalService(service.id, service);
      Alert.alert("Сохранено", "Услуга успешно обновлена");
    } else {
      addAdditionalService(service);
      Alert.alert("Успешно", "Услуга добавлена");
    }
  };

  const handleDeleteService = (id: string) => {
    Alert.alert("Удалить услугу?", "Это действие нельзя отменить", [
      { text: "Отмена", style: "cancel" },
      {
        text: "Удалить",
        style: "destructive",
        onPress: () => {
          deleteAdditionalService(id);
          Alert.alert("Удалено", "Услуга удалена");
        },
      },
    ]);
  };

  const handleToggleService = (service: AdditionalService) => {
    updateAdditionalService(service.id, { ...service, isEnabled: !service.isEnabled });
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <ThemedText style={styles.sectionTitle}>Типы экскурсий</ThemedText>
            <Pressable
              onPress={handleAddTour}
              style={({ pressed }) => [
                styles.addButton,
                { backgroundColor: theme.primary, opacity: pressed ? 0.7 : 1 },
              ]}
            >
              <Feather name="plus" size={20} color="#FFFFFF" />
              <ThemedText style={styles.addButtonText}>Добавить</ThemedText>
            </Pressable>
          </View>

          <View style={styles.list}>
            {tourTypes.map((tourType) => (
              <ThemedView
                key={tourType.id}
                style={[
                  styles.card,
                  {
                    borderColor: theme.border,
                    borderRadius: BorderRadius.sm,
                    opacity: tourType.isEnabled ? 1 : 0.5,
                  },
                ]}
              >
                <View style={styles.cardHeader}>
                  <View style={{ flex: 1 }}>
                    <ThemedText style={styles.cardTitle}>{tourType.name}</ThemedText>
                    <ThemedText style={[styles.articleNumber, { color: theme.textSecondary }]}>
                      {tourType.articleNumber}
                    </ThemedText>
                  </View>
                  <Switch
                    value={tourType.isEnabled}
                    onValueChange={() => handleToggleTour(tourType)}
                    trackColor={{ false: theme.divider, true: theme.primary }}
                    thumbColor={theme.backgroundDefault}
                  />
                </View>

                <View style={styles.pricesRow}>
                  <View style={styles.priceItem}>
                    <ThemedText style={[styles.priceLabel, { color: theme.textSecondary }]}>
                      Полная
                    </ThemedText>
                    <ThemedText style={styles.priceValue}>{tourType.fullPrice} ₽</ThemedText>
                  </View>
                  <View style={styles.priceItem}>
                    <ThemedText style={[styles.priceLabel, { color: theme.textSecondary }]}>
                      Льготная
                    </ThemedText>
                    <ThemedText style={styles.priceValue}>{tourType.discountedPrice} ₽</ThemedText>
                  </View>
                </View>

                <View style={styles.cardActions}>
                  <Pressable
                    onPress={() => handleEditTour(tourType)}
                    style={({ pressed }) => [styles.actionButton, { opacity: pressed ? 0.7 : 1 }]}
                  >
                    <Feather name="edit-2" size={18} color={theme.primary} />
                    <ThemedText style={[styles.actionButtonText, { color: theme.primary }]}>
                      Редактировать
                    </ThemedText>
                  </Pressable>
                  <Pressable
                    onPress={() => handleDeleteTour(tourType.id)}
                    style={({ pressed }) => [styles.actionButton, { opacity: pressed ? 0.7 : 1 }]}
                  >
                    <Feather name="trash-2" size={18} color={theme.error} />
                    <ThemedText style={[styles.actionButtonText, { color: theme.error }]}>
                      Удалить
                    </ThemedText>
                  </Pressable>
                </View>
              </ThemedView>
            ))}
          </View>
        </View>

        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <ThemedText style={styles.sectionTitle}>Дополнительные услуги</ThemedText>
            <Pressable
              onPress={handleAddService}
              style={({ pressed }) => [
                styles.addButton,
                { backgroundColor: theme.primary, opacity: pressed ? 0.7 : 1 },
              ]}
            >
              <Feather name="plus" size={20} color="#FFFFFF" />
              <ThemedText style={styles.addButtonText}>Добавить</ThemedText>
            </Pressable>
          </View>

          <View style={styles.list}>
            {additionalServices.map((service) => (
              <ThemedView
                key={service.id}
                style={[
                  styles.card,
                  {
                    borderColor: theme.border,
                    borderRadius: BorderRadius.sm,
                    opacity: service.isEnabled ? 1 : 0.5,
                  },
                ]}
              >
                <View style={styles.cardHeader}>
                  <View style={{ flex: 1 }}>
                    <ThemedText style={styles.cardTitle}>{service.name}</ThemedText>
                    <ThemedText style={[styles.articleNumber, { color: theme.textSecondary }]}>
                      {service.articleNumber}
                    </ThemedText>
                  </View>
                  <Switch
                    value={service.isEnabled}
                    onValueChange={() => handleToggleService(service)}
                    trackColor={{ false: theme.divider, true: theme.primary }}
                    thumbColor={theme.backgroundDefault}
                  />
                </View>

                <View style={styles.servicePrice}>
                  <ThemedText style={[styles.priceLabel, { color: theme.textSecondary }]}>
                    Цена
                  </ThemedText>
                  <ThemedText style={styles.priceValue}>{service.price} ₽</ThemedText>
                </View>

                <View style={styles.cardActions}>
                  <Pressable
                    onPress={() => handleEditService(service)}
                    style={({ pressed }) => [styles.actionButton, { opacity: pressed ? 0.7 : 1 }]}
                  >
                    <Feather name="edit-2" size={18} color={theme.primary} />
                    <ThemedText style={[styles.actionButtonText, { color: theme.primary }]}>
                      Редактировать
                    </ThemedText>
                  </Pressable>
                  <Pressable
                    onPress={() => handleDeleteService(service.id)}
                    style={({ pressed }) => [styles.actionButton, { opacity: pressed ? 0.7 : 1 }]}
                  >
                    <Feather name="trash-2" size={18} color={theme.error} />
                    <ThemedText style={[styles.actionButtonText, { color: theme.error }]}>
                      Удалить
                    </ThemedText>
                  </Pressable>
                </View>
              </ThemedView>
            ))}
          </View>
        </View>
      </View>

      <TourTypeModal
        visible={tourModalVisible}
        onClose={() => setTourModalVisible(false)}
        onSave={handleSaveTour}
        tourType={editingTour}
      />

      <ServiceModal
        visible={serviceModalVisible}
        onClose={() => setServiceModalVisible(false)}
        onSave={handleSaveService}
        service={editingService}
      />
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing["2xl"],
  },
  section: {
    gap: Spacing.md,
  },
  sectionHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: "600",
  },
  addButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.sm,
  },
  addButtonText: {
    color: "#FFFFFF",
    fontSize: 14,
    fontWeight: "600",
  },
  list: {
    gap: Spacing.md,
  },
  card: {
    padding: Spacing.lg,
    borderWidth: 1,
    gap: Spacing.md,
  },
  cardHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    gap: Spacing.md,
  },
  cardTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  articleNumber: {
    fontSize: 13,
    marginTop: 2,
  },
  pricesRow: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  priceItem: {
    flex: 1,
    gap: Spacing.xs,
  },
  servicePrice: {
    gap: Spacing.xs,
  },
  priceLabel: {
    fontSize: 13,
  },
  priceValue: {
    fontSize: 16,
    fontWeight: "600",
  },
  cardActions: {
    flexDirection: "row",
    gap: Spacing.lg,
    paddingTop: Spacing.sm,
    borderTopWidth: 1,
    borderTopColor: "rgba(255, 255, 255, 0.05)",
  },
  actionButton: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
  },
  actionButtonText: {
    fontSize: 14,
    fontWeight: "500",
  },
});
