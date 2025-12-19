import { useState, useMemo } from "react";
import {
  View,
  StyleSheet,
  Pressable,
  Alert,
  TextInput,
  Modal,
  FlatList,
  Linking,
  Platform,
} from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenKeyboardAwareScrollView } from "@/components/ScreenKeyboardAwareScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useRental, RentalClient, RentalClientType } from "@/contexts/RentalContext";
import { useAuth } from "@/contexts/AuthContext";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";
import { hapticFeedback } from "@/utils/haptics";

type FilterType = "all" | "individual" | "company" | "inactive";

export default function RentalClientsScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<SettingsStackParamList>>();
  const insets = useSafeAreaInsets();
  const { isAdmin, managers } = useAuth();
  const { rentalClients, addRentalClient, updateRentalClient, deleteRentalClient, getClientOrders } = useRental();

  const [searchQuery, setSearchQuery] = useState("");
  const [activeFilter, setActiveFilter] = useState<FilterType>("all");
  const [showModal, setShowModal] = useState(false);
  const [editingClient, setEditingClient] = useState<RentalClient | null>(null);

  const [formType, setFormType] = useState<RentalClientType>("individual");
  const [formName, setFormName] = useState("");
  const [formPhone, setFormPhone] = useState("");
  const [formEmail, setFormEmail] = useState("");
  const [formDirectorName, setFormDirectorName] = useState("");
  const [formLegalAddress, setFormLegalAddress] = useState("");
  const [formInn, setFormInn] = useState("");
  const [formKpp, setFormKpp] = useState("");
  const [formDefaultPrice, setFormDefaultPrice] = useState("100");
  const [formManagerId, setFormManagerId] = useState<string | null>(null);
  const [formNotes, setFormNotes] = useState("");

  const resetForm = () => {
    setFormType("individual");
    setFormName("");
    setFormPhone("");
    setFormEmail("");
    setFormDirectorName("");
    setFormLegalAddress("");
    setFormInn("");
    setFormKpp("");
    setFormDefaultPrice("100");
    setFormManagerId(null);
    setFormNotes("");
    setEditingClient(null);
  };

  const filteredClients = useMemo(() => {
    let result = [...rentalClients];

    if (activeFilter === "individual") {
      result = result.filter(c => c.type === "individual");
    } else if (activeFilter === "company") {
      result = result.filter(c => c.type === "company");
    } else if (activeFilter === "inactive") {
      result = result.filter(c => !c.isActive);
    } else {
      result = result.filter(c => c.isActive);
    }

    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase();
      result = result.filter(c =>
        c.name.toLowerCase().includes(query) ||
        c.phone?.toLowerCase().includes(query) ||
        c.email?.toLowerCase().includes(query) ||
        c.inn?.toLowerCase().includes(query)
      );
    }

    return result;
  }, [rentalClients, activeFilter, searchQuery]);

  const handleOpenModal = (client?: RentalClient) => {
    if (client) {
      setEditingClient(client);
      setFormType(client.type);
      setFormName(client.name);
      setFormPhone(client.phone || "");
      setFormEmail(client.email || "");
      setFormDirectorName(client.directorName || "");
      setFormLegalAddress(client.legalAddress || "");
      setFormInn(client.inn || "");
      setFormKpp(client.kpp || "");
      setFormDefaultPrice(String(client.defaultPrice || 100));
      setFormManagerId(client.assignedManagerId);
      setFormNotes(client.notes || "");
    } else {
      resetForm();
    }
    setShowModal(true);
  };

  const handleSave = async () => {
    if (!formName.trim()) {
      Alert.alert("Ошибка", "Введите имя клиента");
      return;
    }

    hapticFeedback.selection();

    try {
      const clientData = {
        type: formType,
        name: formName.trim(),
        phone: formPhone.trim() || null,
        email: formEmail.trim() || null,
        directorName: formType === "company" ? formDirectorName.trim() || null : null,
        legalAddress: formType === "company" ? formLegalAddress.trim() || null : null,
        inn: formType === "company" ? formInn.trim() || null : null,
        kpp: formType === "company" ? formKpp.trim() || null : null,
        defaultPrice: parseFloat(formDefaultPrice) || 100,
        assignedManagerId: formManagerId,
        notes: formNotes.trim() || null,
        isActive: true,
      };

      if (editingClient) {
        await updateRentalClient(editingClient.id, clientData);
      } else {
        await addRentalClient(clientData);
      }

      setShowModal(false);
      resetForm();
      hapticFeedback.success();
    } catch (error: any) {
      console.error("Error saving client:", error);
      const errorMessage = error?.message || error?.toString() || "Неизвестная ошибка";
      Alert.alert("Ошибка", `Не удалось сохранить клиента: ${errorMessage}`);
    }
  };

  const handleDelete = (client: RentalClient) => {
    const ordersCount = getClientOrders(client.id).length;
    if (ordersCount > 0) {
      Alert.alert(
        "Невозможно удалить",
        `У клиента есть ${ordersCount} заказов. Вы можете деактивировать клиента.`,
        [
          { text: "Отмена", style: "cancel" },
          {
            text: "Деактивировать",
            onPress: async () => {
              await updateRentalClient(client.id, { isActive: false });
              hapticFeedback.success();
            },
          },
        ]
      );
      return;
    }

    Alert.alert(
      "Удалить клиента",
      `Вы уверены, что хотите удалить "${client.name}"?`,
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Удалить",
          style: "destructive",
          onPress: async () => {
            await deleteRentalClient(client.id);
            hapticFeedback.success();
          },
        },
      ]
    );
  };

  const handleCall = (phone: string) => {
    Linking.openURL(`tel:${phone}`);
  };

  const handleWhatsApp = (phone: string) => {
    const cleanPhone = phone.replace(/\D/g, "");
    Linking.openURL(`whatsapp://send?phone=${cleanPhone}`);
  };

  const handleTelegram = (phone: string) => {
    const cleanPhone = phone.replace(/\D/g, "");
    Linking.openURL(`tg://resolve?phone=${cleanPhone}`);
  };

  const renderClientItem = ({ item }: { item: RentalClient }) => {
    const ordersCount = getClientOrders(item.id).length;
    const manager = managers.find(m => m.id === item.assignedManagerId);

    return (
      <Pressable
        onPress={() => navigation.navigate("RentalClientDetail", { clientId: item.id })}
        onLongPress={() => handleOpenModal(item)}
        style={({ pressed }) => [
          styles.clientCard,
          { backgroundColor: theme.backgroundSecondary, opacity: pressed ? 0.8 : 1 },
        ]}
      >
        <View style={styles.clientHeader}>
          <View style={[styles.clientAvatar, { backgroundColor: item.type === "company" ? theme.primary : theme.secondary }]}>
            <ThemedText style={styles.avatarText}>
              {item.name.slice(0, 2).toUpperCase()}
            </ThemedText>
          </View>
          <View style={styles.clientInfo}>
            <View style={styles.clientNameRow}>
              <ThemedText style={styles.clientName} numberOfLines={1}>
                {item.name}
              </ThemedText>
              {!item.isActive ? (
                <View style={[styles.badge, { backgroundColor: theme.error + "30" }]}>
                  <ThemedText style={[styles.badgeText, { color: theme.error }]}>
                    Неактивен
                  </ThemedText>
                </View>
              ) : null}
            </View>
            <ThemedText style={[styles.clientType, { color: theme.textSecondary }]}>
              {item.type === "company" ? "Компания" : "Физ. лицо"}
              {ordersCount > 0 ? ` • ${ordersCount} заказов` : ""}
            </ThemedText>
          </View>
          <ThemedText style={[styles.clientPrice, { color: theme.primary }]}>
            {item.defaultPrice}₽
          </ThemedText>
        </View>

        {item.phone ? (
          <View style={styles.contactRow}>
            <Icon name="phone" size={14} color={theme.textSecondary} />
            <ThemedText style={[styles.contactText, { color: theme.textSecondary }]}>
              {item.phone}
            </ThemedText>
            <View style={styles.contactActions}>
              <Pressable
                onPress={() => handleCall(item.phone!)}
                style={[styles.contactBtn, { backgroundColor: theme.success + "20" }]}
              >
                <Icon name="phone" size={14} color={theme.success} />
              </Pressable>
              <Pressable
                onPress={() => handleWhatsApp(item.phone!)}
                style={[styles.contactBtn, { backgroundColor: "#25D366" + "20" }]}
              >
                <Icon name="message-circle" size={14} color="#25D366" />
              </Pressable>
              <Pressable
                onPress={() => handleTelegram(item.phone!)}
                style={[styles.contactBtn, { backgroundColor: "#0088cc" + "20" }]}
              >
                <Icon name="send" size={14} color="#0088cc" />
              </Pressable>
            </View>
          </View>
        ) : null}

        {manager ? (
          <View style={styles.managerRow}>
            <Icon name="user" size={14} color={theme.textSecondary} />
            <ThemedText style={[styles.managerText, { color: theme.textSecondary }]}>
              Менеджер: {manager.display_name}
            </ThemedText>
          </View>
        ) : null}
      </Pressable>
    );
  };

  const filters: { key: FilterType; label: string }[] = [
    { key: "all", label: "Все" },
    { key: "individual", label: "Физ. лица" },
    { key: "company", label: "Компании" },
    { key: "inactive", label: "Неактивные" },
  ];

  return (
    <ThemedView style={styles.container}>
      <View style={styles.searchContainer}>
        <View style={[styles.searchBox, { backgroundColor: theme.backgroundSecondary }]}>
          <Icon name="search" size={20} color={theme.textSecondary} />
          <TextInput
            style={[styles.searchInput, { color: theme.text }]}
            placeholder="Поиск клиентов..."
            placeholderTextColor={theme.textSecondary}
            value={searchQuery}
            onChangeText={setSearchQuery}
          />
          {searchQuery ? (
            <Pressable onPress={() => setSearchQuery("")}>
              <Icon name="x" size={20} color={theme.textSecondary} />
            </Pressable>
          ) : null}
        </View>
      </View>

      <View style={styles.filtersContainer}>
        <FlatList
          horizontal
          showsHorizontalScrollIndicator={false}
          data={filters}
          keyExtractor={(item) => item.key}
          contentContainerStyle={styles.filtersList}
          renderItem={({ item }) => (
            <Pressable
              onPress={() => {
                hapticFeedback.selection();
                setActiveFilter(item.key);
              }}
              style={[
                styles.filterChip,
                { backgroundColor: activeFilter === item.key ? theme.primary : theme.backgroundSecondary },
              ]}
            >
              <ThemedText
                style={[
                  styles.filterText,
                  { color: activeFilter === item.key ? "#fff" : theme.text },
                ]}
              >
                {item.label}
              </ThemedText>
            </Pressable>
          )}
        />
      </View>

      <FlatList
        data={filteredClients}
        keyExtractor={(item) => item.id}
        renderItem={renderClientItem}
        contentContainerStyle={[
          styles.listContent,
          { paddingBottom: insets.bottom + 80 },
        ]}
        ListEmptyComponent={
          <View style={styles.emptyContainer}>
            <Icon name="users" size={48} color={theme.textSecondary} />
            <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
              {searchQuery ? "Клиенты не найдены" : "Нет клиентов"}
            </ThemedText>
          </View>
        }
      />

      <Pressable
        onPress={() => handleOpenModal()}
        style={[
          styles.fab,
          { backgroundColor: theme.primary, bottom: insets.bottom + 80 },
        ]}
      >
        <Icon name="plus" size={24} color="#fff" />
      </Pressable>

      <Modal visible={showModal} animationType="slide" transparent>
        <View style={[styles.modalOverlay, { backgroundColor: "rgba(0,0,0,0.5)" }]}>
          <View style={[styles.modalContent, { backgroundColor: theme.backgroundDefault }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>
                {editingClient ? "Редактировать клиента" : "Новый клиент"}
              </ThemedText>
              <Pressable onPress={() => setShowModal(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            <ScreenKeyboardAwareScrollView style={styles.modalScroll}>
              <View style={styles.typeSelector}>
                <Pressable
                  onPress={() => setFormType("individual")}
                  style={[
                    styles.typeBtn,
                    { backgroundColor: formType === "individual" ? theme.primary : theme.backgroundSecondary },
                  ]}
                >
                  <ThemedText style={{ color: formType === "individual" ? "#fff" : theme.text }}>
                    Физ. лицо
                  </ThemedText>
                </Pressable>
                <Pressable
                  onPress={() => setFormType("company")}
                  style={[
                    styles.typeBtn,
                    { backgroundColor: formType === "company" ? theme.primary : theme.backgroundSecondary },
                  ]}
                >
                  <ThemedText style={{ color: formType === "company" ? "#fff" : theme.text }}>
                    Компания
                  </ThemedText>
                </Pressable>
              </View>

              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                {formType === "company" ? "Название компании *" : "Имя *"}
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={formName}
                onChangeText={setFormName}
                placeholder={formType === "company" ? "ООО Рога и Копыта" : "Иван Иванов"}
                placeholderTextColor={theme.textSecondary}
              />

              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Телефон
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={formPhone}
                onChangeText={setFormPhone}
                placeholder="+7 999 123 45 67"
                placeholderTextColor={theme.textSecondary}
                keyboardType="phone-pad"
              />

              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Email
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={formEmail}
                onChangeText={setFormEmail}
                placeholder="email@example.com"
                placeholderTextColor={theme.textSecondary}
                keyboardType="email-address"
                autoCapitalize="none"
              />

              {formType === "company" ? (
                <>
                  <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                    ФИО Директора
                  </ThemedText>
                  <TextInput
                    style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                    value={formDirectorName}
                    onChangeText={setFormDirectorName}
                    placeholder="Иванов Иван Иванович"
                    placeholderTextColor={theme.textSecondary}
                  />

                  <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                    Юридический адрес
                  </ThemedText>
                  <TextInput
                    style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                    value={formLegalAddress}
                    onChangeText={setFormLegalAddress}
                    placeholder="г. Казань, ул. Баумана, д. 1"
                    placeholderTextColor={theme.textSecondary}
                    multiline
                  />

                  <View style={styles.row}>
                    <View style={styles.halfInput}>
                      <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                        ИНН
                      </ThemedText>
                      <TextInput
                        style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                        value={formInn}
                        onChangeText={setFormInn}
                        placeholder="1234567890"
                        placeholderTextColor={theme.textSecondary}
                        keyboardType="numeric"
                      />
                    </View>
                    <View style={styles.halfInput}>
                      <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                        КПП
                      </ThemedText>
                      <TextInput
                        style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                        value={formKpp}
                        onChangeText={setFormKpp}
                        placeholder="123456789"
                        placeholderTextColor={theme.textSecondary}
                        keyboardType="numeric"
                      />
                    </View>
                  </View>
                </>
              ) : null}

              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Цена по умолчанию (за комплект/день)
              </ThemedText>
              <TextInput
                style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={formDefaultPrice}
                onChangeText={setFormDefaultPrice}
                placeholder="100"
                placeholderTextColor={theme.textSecondary}
                keyboardType="numeric"
              />

              <ThemedText style={[styles.inputLabel, { color: theme.textSecondary }]}>
                Заметки
              </ThemedText>
              <TextInput
                style={[styles.input, styles.textArea, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
                value={formNotes}
                onChangeText={setFormNotes}
                placeholder="Дополнительная информация..."
                placeholderTextColor={theme.textSecondary}
                multiline
                numberOfLines={3}
              />

              <View style={styles.modalActions}>
                {editingClient ? (
                  <Pressable
                    onPress={() => handleDelete(editingClient)}
                    style={[styles.deleteBtn, { backgroundColor: theme.error + "20" }]}
                  >
                    <Icon name="trash-2" size={20} color={theme.error} />
                  </Pressable>
                ) : null}
                <Pressable
                  onPress={() => setShowModal(false)}
                  style={[styles.cancelBtn, { backgroundColor: theme.backgroundSecondary }]}
                >
                  <ThemedText>Отмена</ThemedText>
                </Pressable>
                <Pressable
                  onPress={handleSave}
                  style={[styles.saveBtn, { backgroundColor: theme.primary }]}
                >
                  <ThemedText style={{ color: "#fff" }}>Сохранить</ThemedText>
                </Pressable>
              </View>
            </ScreenKeyboardAwareScrollView>
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
  searchContainer: {
    padding: Spacing.md,
    paddingBottom: Spacing.sm,
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
  filtersContainer: {
    marginBottom: Spacing.sm,
  },
  filtersList: {
    paddingHorizontal: Spacing.md,
    gap: Spacing.sm,
  },
  filterChip: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.full,
    marginRight: Spacing.sm,
  },
  filterText: {
    fontSize: 14,
    fontWeight: "500",
  },
  listContent: {
    padding: Spacing.md,
    gap: Spacing.sm,
  },
  clientCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.lg,
    marginBottom: Spacing.sm,
  },
  clientHeader: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
  },
  clientAvatar: {
    width: 44,
    height: 44,
    borderRadius: 22,
    justifyContent: "center",
    alignItems: "center",
  },
  avatarText: {
    color: "#fff",
    fontSize: 16,
    fontWeight: "600",
  },
  clientInfo: {
    flex: 1,
  },
  clientNameRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  clientName: {
    fontSize: 16,
    fontWeight: "600",
    flex: 1,
  },
  badge: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: 2,
    borderRadius: BorderRadius.sm,
  },
  badgeText: {
    fontSize: 11,
    fontWeight: "500",
  },
  clientType: {
    fontSize: 13,
    marginTop: 2,
  },
  clientPrice: {
    fontSize: 16,
    fontWeight: "600",
  },
  contactRow: {
    flexDirection: "row",
    alignItems: "center",
    marginTop: Spacing.sm,
    gap: Spacing.sm,
  },
  contactText: {
    fontSize: 13,
    flex: 1,
  },
  contactActions: {
    flexDirection: "row",
    gap: Spacing.xs,
  },
  contactBtn: {
    width: 28,
    height: 28,
    borderRadius: 14,
    justifyContent: "center",
    alignItems: "center",
  },
  managerRow: {
    flexDirection: "row",
    alignItems: "center",
    marginTop: Spacing.sm,
    gap: Spacing.sm,
  },
  managerText: {
    fontSize: 13,
  },
  emptyContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    paddingTop: 100,
    gap: Spacing.md,
  },
  emptyText: {
    fontSize: 16,
  },
  fab: {
    position: "absolute",
    right: Spacing.lg,
    width: 56,
    height: 56,
    borderRadius: 28,
    justifyContent: "center",
    alignItems: "center",
    elevation: 4,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 4,
  },
  modalOverlay: {
    flex: 1,
    justifyContent: "flex-end",
  },
  modalContent: {
    maxHeight: "90%",
    borderTopLeftRadius: BorderRadius.xl,
    borderTopRightRadius: BorderRadius.xl,
    paddingBottom: 40,
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
  modalScroll: {
    padding: Spacing.md,
  },
  typeSelector: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginBottom: Spacing.lg,
  },
  typeBtn: {
    flex: 1,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
  inputLabel: {
    fontSize: 13,
    marginBottom: Spacing.xs,
    marginTop: Spacing.sm,
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
  row: {
    flexDirection: "row",
    gap: Spacing.md,
  },
  halfInput: {
    flex: 1,
  },
  modalActions: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginTop: Spacing.xl,
  },
  deleteBtn: {
    width: 48,
    height: 48,
    borderRadius: BorderRadius.md,
    justifyContent: "center",
    alignItems: "center",
  },
  cancelBtn: {
    flex: 1,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
  saveBtn: {
    flex: 2,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.md,
    alignItems: "center",
  },
});
