import { useState } from "react";
import { View, StyleSheet, TextInput, Pressable, Alert } from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, TourType, AdditionalService } from "@/contexts/DataContext";

export default function TicketPricesScreen() {
  const { theme } = useTheme();
  const { tourTypes, setTourTypes, additionalServices, setAdditionalServices } = useData();
  const [editingId, setEditingId] = useState<string | null>(null);

  const handleSaveTourType = (id: string, fullPrice: string, discountedPrice: string) => {
    const full = parseInt(fullPrice, 10);
    const discounted = parseInt(discountedPrice, 10);

    if (isNaN(full) || isNaN(discounted) || full <= 0 || discounted <= 0) {
      Alert.alert("Ошибка", "Введите корректные цены");
      return;
    }

    setTourTypes(
      tourTypes.map((t) =>
        t.id === id ? { ...t, fullPrice: full, discountedPrice: discounted } : t
      )
    );
    setEditingId(null);
    Alert.alert("Сохранено", "Цены успешно обновлены");
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <ThemedText style={styles.sectionTitle}>Типы экскурсий</ThemedText>
          </View>
          <View style={styles.pricesList}>
            {tourTypes.map((tourType) => {
              const isEditing = editingId === tourType.id;
              const [fullPrice, setFullPrice] = useState(tourType.fullPrice.toString());
              const [discountedPrice, setDiscountedPrice] = useState(
                tourType.discountedPrice.toString()
              );

              return (
                <ThemedView
                  key={tourType.id}
                  style={[
                    styles.priceCard,
                    {
                      borderColor: theme.border,
                      borderRadius: BorderRadius.sm,
                    },
                  ]}
                >
                  <View style={styles.priceCardHeader}>
                    <ThemedText style={styles.tourTypeName}>{tourType.name}</ThemedText>
                    {!isEditing ? (
                      <Pressable
                        onPress={() => setEditingId(tourType.id)}
                        style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
                      >
                        <Feather name="edit" size={20} color={theme.primary} />
                      </Pressable>
                    ) : (
                      <Pressable
                        onPress={() => handleSaveTourType(tourType.id, fullPrice, discountedPrice)}
                        style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
                      >
                        <Feather name="check" size={20} color={theme.success} />
                      </Pressable>
                    )}
                  </View>
                  <View style={styles.pricesGrid}>
                    <View style={styles.priceItem}>
                      <ThemedText style={[styles.priceLabel, { color: theme.textSecondary }]}>
                        Полная цена
                      </ThemedText>
                      {isEditing ? (
                        <TextInput
                          style={[
                            styles.priceInput,
                            {
                              borderColor: theme.inputBorder,
                              color: theme.text,
                              backgroundColor: theme.backgroundSecondary,
                            },
                          ]}
                          keyboardType="numeric"
                          value={fullPrice}
                          onChangeText={setFullPrice}
                        />
                      ) : (
                        <ThemedText style={styles.priceValue}>{tourType.fullPrice} ₽</ThemedText>
                      )}
                    </View>
                    <View style={styles.priceItem}>
                      <ThemedText style={[styles.priceLabel, { color: theme.textSecondary }]}>
                        Льготная цена
                      </ThemedText>
                      {isEditing ? (
                        <TextInput
                          style={[
                            styles.priceInput,
                            {
                              borderColor: theme.inputBorder,
                              color: theme.text,
                              backgroundColor: theme.backgroundSecondary,
                            },
                          ]}
                          keyboardType="numeric"
                          value={discountedPrice}
                          onChangeText={setDiscountedPrice}
                        />
                      ) : (
                        <ThemedText style={styles.priceValue}>
                          {tourType.discountedPrice} ₽
                        </ThemedText>
                      )}
                    </View>
                  </View>
                </ThemedView>
              );
            })}
          </View>
        </View>

        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <ThemedText style={styles.sectionTitle}>Дополнительные услуги</ThemedText>
          </View>
          <View style={styles.pricesList}>
            {additionalServices.map((service) => (
              <ThemedView
                key={service.id}
                style={[
                  styles.serviceCard,
                  {
                    borderColor: theme.border,
                    borderRadius: BorderRadius.sm,
                  },
                ]}
              >
                <View style={styles.serviceInfo}>
                  <ThemedText style={styles.serviceName}>{service.name}</ThemedText>
                  <ThemedText style={styles.servicePrice}>{service.price} ₽</ThemedText>
                </View>
              </ThemedView>
            ))}
          </View>
        </View>
      </View>
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
  pricesList: {
    gap: Spacing.md,
  },
  priceCard: {
    padding: Spacing.lg,
    borderWidth: 1,
    gap: Spacing.md,
  },
  priceCardHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  tourTypeName: {
    fontSize: 18,
    fontWeight: "600",
  },
  pricesGrid: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  priceItem: {
    flex: 1,
    gap: Spacing.xs,
  },
  priceLabel: {
    fontSize: 14,
  },
  priceValue: {
    fontSize: 16,
    fontWeight: "600",
  },
  priceInput: {
    borderWidth: 1,
    borderRadius: BorderRadius.xs,
    padding: Spacing.sm,
    fontSize: 16,
    fontWeight: "600",
  },
  serviceCard: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    padding: Spacing.lg,
    borderWidth: 1,
  },
  serviceInfo: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    flex: 1,
  },
  serviceName: {
    fontSize: 16,
    fontWeight: "500",
  },
  servicePrice: {
    fontSize: 16,
    fontWeight: "600",
  },
});
