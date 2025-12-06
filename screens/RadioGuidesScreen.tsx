import { useState } from "react";
import {
  View,
  StyleSheet,
  Pressable,
  Alert,
  TextInput,
  Modal,
} from "react-native";
import { Feather } from "@expo/vector-icons";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenFlatList } from "@/components/ScreenFlatList";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, RadioGuideKit, RadioGuideAssignment } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";

type ModalMode = "add" | "edit" | "issue" | "return" | null;

export default function RadioGuidesScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const {
    radioGuideKits,
    radioGuideAssignments,
    addRadioGuideKit,
    updateRadioGuideKit,
    deleteRadioGuideKit,
    issueRadioGuide,
    returnRadioGuide,
    getActiveAssignment,
  } = useData();

  const [modalMode, setModalMode] = useState<ModalMode>(null);
  const [selectedKit, setSelectedKit] = useState<RadioGuideKit | null>(null);
  const [selectedAssignment, setSelectedAssignment] = useState<RadioGuideAssignment | null>(null);

  const [bagNumber, setBagNumber] = useState("");
  const [receiverCount, setReceiverCount] = useState("");
  const [notes, setNotes] = useState("");
  const [guideName, setGuideName] = useState("");
  const [busNumber, setBusNumber] = useState("");
  const [receiversIssued, setReceiversIssued] = useState("");
  const [receiversReturned, setReceiversReturned] = useState("");
  const [returnNotes, setReturnNotes] = useState("");

  const resetForm = () => {
    setBagNumber("");
    setReceiverCount("");
    setNotes("");
    setGuideName("");
    setBusNumber("");
    setReceiversIssued("");
    setReceiversReturned("");
    setReturnNotes("");
    setSelectedKit(null);
    setSelectedAssignment(null);
  };

  const openAddModal = () => {
    resetForm();
    setModalMode("add");
  };

  const openEditModal = (kit: RadioGuideKit) => {
    setSelectedKit(kit);
    setBagNumber(kit.bagNumber.toString());
    setReceiverCount(kit.receiverCount.toString());
    setNotes(kit.notes || "");
    setModalMode("edit");
  };

  const openIssueModal = (kit: RadioGuideKit) => {
    setSelectedKit(kit);
    setReceiversIssued(kit.receiverCount.toString());
    setModalMode("issue");
  };

  const openReturnModal = (kit: RadioGuideKit) => {
    const assignment = getActiveAssignment(kit.id);
    if (assignment) {
      setSelectedKit(kit);
      setSelectedAssignment(assignment);
      setReceiversReturned(assignment.receiversIssued.toString());
      setModalMode("return");
    }
  };

  const handleSaveKit = async () => {
    const num = parseInt(bagNumber);
    const count = parseInt(receiverCount);

    if (!num || num <= 0) {
      Alert.alert("Ошибка", "Введите номер сумки");
      return;
    }

    if (!count || count <= 0) {
      Alert.alert("Ошибка", "Введите количество приёмников");
      return;
    }

    try {
      if (modalMode === "add") {
        await addRadioGuideKit({
          bagNumber: num,
          receiverCount: count,
          status: "available",
          notes: notes.trim() || null,
        });
      } else if (modalMode === "edit" && selectedKit) {
        await updateRadioGuideKit(selectedKit.id, {
          bagNumber: num,
          receiverCount: count,
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

  const handleReturn = async () => {
    if (!selectedAssignment) return;

    const count = parseInt(receiversReturned);
    if (isNaN(count) || count < 0) {
      Alert.alert("Ошибка", "Введите количество возвращённых приёмников");
      return;
    }

    try {
      await returnRadioGuide(selectedAssignment.id, count, returnNotes.trim() || undefined);
      setModalMode(null);
      resetForm();
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось принять радиогид");
    }
  };

  const getStatusText = (status: RadioGuideKit["status"]) => {
    switch (status) {
      case "available":
        return "Доступна";
      case "issued":
        return "Выдана";
      case "maintenance":
        return "На обслуживании";
    }
  };

  const getStatusColor = (status: RadioGuideKit["status"]) => {
    switch (status) {
      case "available":
        return theme.success;
      case "issued":
        return theme.warning;
      case "maintenance":
        return theme.textSecondary;
    }
  };

  const renderKit = ({ item: kit }: { item: RadioGuideKit }) => {
    const activeAssignment = getActiveAssignment(kit.id);

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
              <ThemedText style={[styles.kitReceivers, { color: theme.textSecondary }]}>
                {kit.receiverCount} приёмников
              </ThemedText>
              <View
                style={[styles.statusBadge, { backgroundColor: getStatusColor(kit.status) + "20" }]}
              >
                <ThemedText style={[styles.statusText, { color: getStatusColor(kit.status) }]}>
                  {getStatusText(kit.status)}
                </ThemedText>
              </View>
            </View>
          </View>
        </View>

        {activeAssignment ? (
          <View style={[styles.assignmentInfo, { backgroundColor: theme.backgroundTertiary }]}>
            <ThemedText style={[styles.assignmentLabel, { color: theme.textSecondary }]}>
              Экскурсовод:
            </ThemedText>
            <ThemedText style={styles.assignmentValue}>{activeAssignment.guideName}</ThemedText>
            {activeAssignment.busNumber ? (
              <>
                <ThemedText style={[styles.assignmentLabel, { color: theme.textSecondary }]}>
                  Автобус:
                </ThemedText>
                <ThemedText style={styles.assignmentValue}>{activeAssignment.busNumber}</ThemedText>
              </>
            ) : null}
            <ThemedText style={[styles.assignmentLabel, { color: theme.textSecondary }]}>
              Выдано:
            </ThemedText>
            <ThemedText style={styles.assignmentValue}>
              {activeAssignment.receiversIssued} шт.
            </ThemedText>
          </View>
        ) : null}

        {kit.notes ? (
          <ThemedText style={[styles.kitNotes, { color: theme.textSecondary }]}>
            {kit.notes}
          </ThemedText>
        ) : null}

        <View style={styles.kitActions}>
          {kit.status === "available" ? (
            <Pressable
              style={[styles.actionButton, { backgroundColor: theme.primary }]}
              onPress={() => openIssueModal(kit)}
            >
              <Feather name="send" size={16} color={theme.buttonText} />
              <ThemedText style={[styles.actionButtonText, { color: theme.buttonText }]}>
                Выдать
              </ThemedText>
            </Pressable>
          ) : kit.status === "issued" ? (
            <Pressable
              style={[styles.actionButton, { backgroundColor: theme.success }]}
              onPress={() => openReturnModal(kit)}
            >
              <Feather name="download" size={16} color={theme.buttonText} />
              <ThemedText style={[styles.actionButtonText, { color: theme.buttonText }]}>
                Принять
              </ThemedText>
            </Pressable>
          ) : null}

          {isAdmin ? (
            <>
              <Pressable
                style={[styles.iconButton, { borderColor: theme.border }]}
                onPress={() => openEditModal(kit)}
              >
                <Feather name="edit-2" size={18} color={theme.primary} />
              </Pressable>
              <Pressable
                style={[styles.iconButton, { borderColor: theme.border }]}
                onPress={() => handleDeleteKit(kit)}
              >
                <Feather name="trash-2" size={18} color={theme.error} />
              </Pressable>
            </>
          ) : null}
        </View>
      </ThemedView>
    );
  };

  const sortedKits = [...radioGuideKits].sort((a, b) => a.bagNumber - b.bagNumber);

  return (
    <>
      <ScreenFlatList
        data={sortedKits}
        renderItem={renderKit}
        keyExtractor={(item) => item.id}
        contentContainerStyle={styles.container}
        ListEmptyComponent={
          <View style={styles.emptyContainer}>
            <Feather name="radio" size={48} color={theme.textSecondary} />
            <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
              Нет сумок с радиогидами
            </ThemedText>
            {isAdmin ? (
              <ThemedText style={[styles.emptyHint, { color: theme.textSecondary }]}>
                Нажмите + чтобы добавить
              </ThemedText>
            ) : null}
          </View>
        }
      />

      {isAdmin ? (
        <Pressable
          style={[styles.fab, { backgroundColor: theme.primary }]}
          onPress={openAddModal}
        >
          <Feather name="plus" size={24} color={theme.buttonText} />
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
                <Feather name="x" size={24} color={theme.text} />
              </Pressable>
            </View>

            {modalMode === "add" || modalMode === "edit" ? (
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
                    Количество приёмников
                  </ThemedText>
                  <TextInput
                    style={[
                      styles.input,
                      { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
                    ]}
                    value={receiverCount}
                    onChangeText={setReceiverCount}
                    placeholder="40"
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
            ) : modalMode === "issue" ? (
              <View style={styles.form}>
                <View style={styles.inputGroup}>
                  <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                    Экскурсовод *
                  </ThemedText>
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
            ) : modalMode === "return" ? (
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

                <View style={styles.inputGroup}>
                  <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
                    Возвращено приёмников *
                  </ThemedText>
                  <TextInput
                    style={[
                      styles.input,
                      { backgroundColor: theme.backgroundSecondary, borderColor: theme.border, color: theme.text },
                    ]}
                    value={receiversReturned}
                    onChangeText={setReceiversReturned}
                    placeholder="40"
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
                    value={returnNotes}
                    onChangeText={setReturnNotes}
                    placeholder="Проблемы, недостачи..."
                    placeholderTextColor={theme.textSecondary}
                    multiline
                    numberOfLines={2}
                  />
                </View>

                <Pressable
                  style={[styles.saveButton, { backgroundColor: theme.success }]}
                  onPress={handleReturn}
                >
                  <ThemedText style={[styles.saveButtonText, { color: theme.buttonText }]}>
                    Принять
                  </ThemedText>
                </Pressable>
              </View>
            ) : null}
          </ThemedView>
        </View>
      </Modal>
    </>
  );
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
});
