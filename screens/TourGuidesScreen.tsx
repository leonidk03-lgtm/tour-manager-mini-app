import { useState, useMemo } from "react";
import {
  View,
  StyleSheet,
  Pressable,
  Alert,
  TextInput,
  Modal,
  Linking,
  Platform,
} from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenFlatList } from "@/components/ScreenFlatList";
import { ScreenKeyboardAwareScrollView } from "@/components/ScreenKeyboardAwareScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, TourGuide } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";
import { hapticFeedback } from "@/utils/haptics";

export default function TourGuidesScreen() {
  const { theme } = useTheme();
  const insets = useSafeAreaInsets();
  const { isAdmin } = useAuth();
  const { tourGuides, addTourGuide, updateTourGuide, deleteTourGuide } = useData();

  const [searchQuery, setSearchQuery] = useState("");
  const [showModal, setShowModal] = useState(false);
  const [editingGuide, setEditingGuide] = useState<TourGuide | null>(null);

  const [formName, setFormName] = useState("");
  const [formPhone, setFormPhone] = useState("");
  const [formEmail, setFormEmail] = useState("");
  const [formNotes, setFormNotes] = useState("");

  const resetForm = () => {
    setFormName("");
    setFormPhone("");
    setFormEmail("");
    setFormNotes("");
    setEditingGuide(null);
  };

  const filteredGuides = useMemo(() => {
    let result = tourGuides.filter(g => g.isActive);

    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase().trim();
      result = result.filter(g =>
        g.name.toLowerCase().includes(query) ||
        (g.phone && g.phone.includes(query))
      );
    }

    return result.sort((a, b) => a.name.localeCompare(b.name));
  }, [tourGuides, searchQuery]);

  const handleOpenModal = (guide?: TourGuide) => {
    if (guide) {
      setEditingGuide(guide);
      setFormName(guide.name);
      setFormPhone(guide.phone || "");
      setFormEmail(guide.email || "");
      setFormNotes(guide.notes || "");
    } else {
      resetForm();
    }
    setShowModal(true);
  };

  const handleSave = async () => {
    if (!formName.trim()) {
      Alert.alert("Ошибка", "Введите имя гида");
      return;
    }

    hapticFeedback.selection();

    try {
      const guideData = {
        name: formName.trim(),
        phone: formPhone.trim() || null,
        email: formEmail.trim() || null,
        notes: formNotes.trim() || null,
        isActive: true,
      };

      if (editingGuide) {
        await updateTourGuide(editingGuide.id, guideData);
      } else {
        await addTourGuide(guideData);
      }

      setShowModal(false);
      resetForm();
      hapticFeedback.success();
    } catch (error: any) {
      console.error("Error saving tour guide:", error);
      Alert.alert("Ошибка", "Не удалось сохранить гида");
    }
  };

  const handleDelete = (guide: TourGuide) => {
    Alert.alert(
      "Удалить гида?",
      `Вы уверены, что хотите удалить "${guide.name}"?`,
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Удалить",
          style: "destructive",
          onPress: async () => {
            try {
              await deleteTourGuide(guide.id);
              hapticFeedback.success();
            } catch (error) {
              Alert.alert("Ошибка", "Не удалось удалить гида");
            }
          },
        },
      ]
    );
  };

  const handleCallGuide = (phone: string) => {
    const phoneUrl = Platform.OS === "ios" ? `tel:${phone}` : `tel:${phone}`;
    Linking.openURL(phoneUrl).catch(() => {
      Alert.alert("Ошибка", "Не удалось открыть телефон");
    });
  };

  const renderGuideItem = ({ item }: { item: TourGuide }) => (
    <Pressable
      style={[styles.guideCard, { backgroundColor: theme.backgroundSecondary }]}
      onPress={() => handleOpenModal(item)}
      onLongPress={() => handleDelete(item)}
    >
      <View style={styles.guideInfo}>
        <ThemedText style={styles.guideName}>{item.name}</ThemedText>
        {item.phone ? (
          <Pressable 
            style={styles.phoneRow}
            onPress={() => handleCallGuide(item.phone!)}
          >
            <Icon name="phone" size={14} color={theme.primary} />
            <ThemedText style={[styles.guidePhone, { color: theme.primary }]}>
              {item.phone}
            </ThemedText>
          </Pressable>
        ) : null}
        {item.email ? (
          <View style={styles.emailRow}>
            <Icon name="mail" size={14} color={theme.textSecondary} />
            <ThemedText style={[styles.guideEmail, { color: theme.textSecondary }]}>
              {item.email}
            </ThemedText>
          </View>
        ) : null}
        {item.notes ? (
          <ThemedText style={[styles.guideNotes, { color: theme.textSecondary }]} numberOfLines={2}>
            {item.notes}
          </ThemedText>
        ) : null}
      </View>
      <Icon name="chevron-right" size={20} color={theme.textSecondary} />
    </Pressable>
  );

  return (
    <ThemedView style={styles.container}>
      <View style={[styles.searchContainer, { backgroundColor: theme.backgroundSecondary }]}>
        <Icon name="search" size={20} color={theme.textSecondary} />
        <TextInput
          style={[styles.searchInput, { color: theme.text }]}
          placeholder="Поиск по имени или телефону..."
          placeholderTextColor={theme.textSecondary}
          value={searchQuery}
          onChangeText={setSearchQuery}
          autoCapitalize="none"
          autoCorrect={false}
        />
        {searchQuery ? (
          <Pressable onPress={() => setSearchQuery("")}>
            <Icon name="x" size={20} color={theme.textSecondary} />
          </Pressable>
        ) : null}
      </View>

      <ScreenFlatList
        data={filteredGuides}
        keyExtractor={(item) => item.id}
        renderItem={renderGuideItem}
        contentContainerStyle={styles.listContent}
        ListEmptyComponent={
          <View style={styles.emptyContainer}>
            <Icon name="users" size={48} color={theme.textSecondary} />
            <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
              {searchQuery ? "Гиды не найдены" : "Список гидов пуст"}
            </ThemedText>
            <ThemedText style={[styles.emptyHint, { color: theme.textSecondary }]}>
              {searchQuery ? "Попробуйте изменить поиск" : "Добавьте первого гида"}
            </ThemedText>
          </View>
        }
      />

      {isAdmin ? (
        <Pressable
          style={[
            styles.fab,
            { backgroundColor: theme.primary, bottom: insets.bottom + 16 },
          ]}
          onPress={() => handleOpenModal()}
        >
          <Icon name="plus" size={24} color="#fff" />
        </Pressable>
      ) : null}

      <Modal
        visible={showModal}
        animationType="slide"
        presentationStyle="pageSheet"
        onRequestClose={() => setShowModal(false)}
      >
        <ThemedView style={styles.modalContainer}>
          <View style={styles.modalHeader}>
            <Pressable onPress={() => setShowModal(false)}>
              <ThemedText style={{ color: theme.primary }}>Отмена</ThemedText>
            </Pressable>
            <ThemedText style={styles.modalTitle}>
              {editingGuide ? "Редактировать" : "Новый гид"}
            </ThemedText>
            <Pressable onPress={handleSave}>
              <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>
                Сохранить
              </ThemedText>
            </Pressable>
          </View>

          <ScreenKeyboardAwareScrollView contentContainerStyle={styles.modalContent}>
            <View style={styles.formGroup}>
              <ThemedText style={styles.formLabel}>Имя *</ThemedText>
              <TextInput
                style={[
                  styles.formInput,
                  { backgroundColor: theme.backgroundSecondary, color: theme.text },
                ]}
                value={formName}
                onChangeText={setFormName}
                placeholder="Введите имя гида"
                placeholderTextColor={theme.textSecondary}
              />
            </View>

            <View style={styles.formGroup}>
              <ThemedText style={styles.formLabel}>Телефон</ThemedText>
              <TextInput
                style={[
                  styles.formInput,
                  { backgroundColor: theme.backgroundSecondary, color: theme.text },
                ]}
                value={formPhone}
                onChangeText={setFormPhone}
                placeholder="+7 (999) 123-45-67"
                placeholderTextColor={theme.textSecondary}
                keyboardType="phone-pad"
              />
            </View>

            <View style={styles.formGroup}>
              <ThemedText style={styles.formLabel}>Email</ThemedText>
              <TextInput
                style={[
                  styles.formInput,
                  { backgroundColor: theme.backgroundSecondary, color: theme.text },
                ]}
                value={formEmail}
                onChangeText={setFormEmail}
                placeholder="email@example.com"
                placeholderTextColor={theme.textSecondary}
                keyboardType="email-address"
                autoCapitalize="none"
              />
            </View>

            <View style={styles.formGroup}>
              <ThemedText style={styles.formLabel}>Заметки</ThemedText>
              <TextInput
                style={[
                  styles.formInput,
                  styles.textArea,
                  { backgroundColor: theme.backgroundSecondary, color: theme.text },
                ]}
                value={formNotes}
                onChangeText={setFormNotes}
                placeholder="Дополнительная информация..."
                placeholderTextColor={theme.textSecondary}
                multiline
                numberOfLines={4}
              />
            </View>
          </ScreenKeyboardAwareScrollView>
        </ThemedView>
      </Modal>
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  searchContainer: {
    flexDirection: "row",
    alignItems: "center",
    margin: Spacing.md,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
  },
  searchInput: {
    flex: 1,
    fontSize: 16,
    paddingVertical: Spacing.xs,
  },
  listContent: {
    paddingHorizontal: Spacing.md,
    paddingBottom: 100,
  },
  guideCard: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.sm,
  },
  guideInfo: {
    flex: 1,
    gap: Spacing.xs,
  },
  guideName: {
    fontSize: 16,
    fontWeight: "600",
  },
  phoneRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
  },
  guidePhone: {
    fontSize: 14,
  },
  emailRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
  },
  guideEmail: {
    fontSize: 14,
  },
  guideNotes: {
    fontSize: 13,
    marginTop: Spacing.xs,
  },
  emptyContainer: {
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: Spacing["2xl"],
    gap: Spacing.md,
  },
  emptyText: {
    fontSize: 16,
    fontWeight: "500",
  },
  emptyHint: {
    fontSize: 14,
  },
  fab: {
    position: "absolute",
    right: 16,
    width: 56,
    height: 56,
    borderRadius: 28,
    alignItems: "center",
    justifyContent: "center",
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 4,
    elevation: 5,
  },
  modalContainer: {
    flex: 1,
  },
  modalHeader: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.md,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: "rgba(150,150,150,0.3)",
  },
  modalTitle: {
    fontSize: 17,
    fontWeight: "600",
  },
  modalContent: {
    padding: Spacing.md,
  },
  formGroup: {
    marginBottom: Spacing.lg,
  },
  formLabel: {
    fontSize: 14,
    fontWeight: "500",
    marginBottom: Spacing.xs,
  },
  formInput: {
    fontSize: 16,
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
  },
  textArea: {
    minHeight: 100,
    textAlignVertical: "top",
  },
});
