import { useState, useMemo } from "react";
import { View, StyleSheet, Pressable, TextInput, Alert, Modal, Switch, ScrollView } from "react-native";
import { Icon } from "@/components/Icon";
import { useRoute, RouteProp } from "@react-navigation/native";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData, Activity } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";
import { useRental } from "@/contexts/RentalContext";
import { calculateExcursionRevenue } from "@/utils/calculations";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";
import { PermissionKey, PERMISSION_GROUPS, ManagerPermissions } from "@/lib/supabase";

type PeriodFilter = "day" | "week" | "month" | "all";

const formatDate = (dateString: string) => {
  const date = new Date(dateString);
  return date.toLocaleDateString("ru-RU", { day: "numeric", month: "short" });
};

const formatCurrency = (amount: number) => {
  return new Intl.NumberFormat("ru-RU").format(amount) + " ₽";
};

const getRoleLabel = (role: string): string => {
  switch (role) {
    case "admin": return "Администратор";
    case "manager": return "Менеджер";
    case "radio_dispatcher": return "Диспетчер радиогидов";
    default: return role;
  }
};

export default function ManagerDetailScreen() {
  const { theme } = useTheme();
  const route = useRoute<RouteProp<SettingsStackParamList, "ManagerDetail">>();
  const { manager } = route.params;
  const { excursions, transactions, tourTypes, additionalServices, radioGuideAssignments, radioGuideKits, activities, equipmentLosses } = useData();
  const { rentalOrders } = useRental();
  const { sendPasswordReset, updateManagerDisplayName, updateManagerPermissions, updateManagerCommissions, refreshManagers, isAdmin, managers } = useAuth();
  const [period, setPeriod] = useState<PeriodFilter>("all");
  const [isEditingName, setIsEditingName] = useState(false);
  const [newDisplayName, setNewDisplayName] = useState(manager.display_name);
  const [isSaving, setIsSaving] = useState(false);
  const [currentManager, setCurrentManager] = useState(manager);
  const [showPermissions, setShowPermissions] = useState(false);
  const [showCommissions, setShowCommissions] = useState(false);
  const [ownerCommission, setOwnerCommission] = useState(String(manager.owner_commission_percent ?? 20));
  const [executorCommission, setExecutorCommission] = useState(String(manager.executor_commission_percent ?? 10));

  const latestManager = useMemo(() => {
    return managers.find(m => m.id === manager.id) || currentManager;
  }, [managers, manager.id, currentManager]);

  const permissions = (latestManager.permissions || {}) as ManagerPermissions;

  const handleSendPasswordReset = async () => {
    Alert.alert(
      "Сброс пароля",
      `Отправить ссылку для сброса пароля на ${currentManager.email}?`,
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Отправить",
          onPress: async () => {
            const { error } = await sendPasswordReset(currentManager.email);
            if (error) {
              Alert.alert("Ошибка", error);
            } else {
              Alert.alert("Успешно", "Ссылка для сброса пароля отправлена на email");
            }
          },
        },
      ]
    );
  };

  const handleSaveDisplayName = async () => {
    if (!newDisplayName.trim()) {
      Alert.alert("Ошибка", "Имя не может быть пустым");
      return;
    }
    setIsSaving(true);
    const { error } = await updateManagerDisplayName(currentManager.id, newDisplayName.trim());
    setIsSaving(false);
    if (error) {
      Alert.alert("Ошибка", error);
    } else {
      setCurrentManager({ ...currentManager, display_name: newDisplayName.trim() });
      setIsEditingName(false);
      await refreshManagers();
    }
  };

  const filterByPeriod = (date: string) => {
    const itemDate = new Date(date);
    const now = new Date();
    
    switch (period) {
      case "day":
        return itemDate.toDateString() === now.toDateString();
      case "week":
        const weekAgo = new Date(now);
        weekAgo.setDate(weekAgo.getDate() - 7);
        return itemDate >= weekAgo;
      case "month":
        const monthAgo = new Date(now);
        monthAgo.setMonth(monthAgo.getMonth() - 1);
        return itemDate >= monthAgo;
      case "all":
        return true;
      default:
        return true;
    }
  };

  const managerExcursions = useMemo(() => {
    return excursions
      .filter(e => e.managerId === manager.id && filterByPeriod(e.date))
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());
  }, [excursions, manager.id, period]);

  const managerTransactions = useMemo(() => {
    return transactions
      .filter(t => t.managerId === manager.id && filterByPeriod(t.date))
      .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());
  }, [transactions, manager.id, period]);

  const managerRadioAssignments = useMemo(() => {
    return radioGuideAssignments
      .filter(a => a.managerId === manager.id && filterByPeriod(a.issuedAt))
      .sort((a, b) => new Date(b.issuedAt).getTime() - new Date(a.issuedAt).getTime());
  }, [radioGuideAssignments, manager.id, period]);

  const managerActivities = useMemo(() => {
    return activities
      .filter(a => a.managerName === manager.display_name && filterByPeriod(a.timestamp))
      .sort((a, b) => new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime());
  }, [activities, manager.display_name, period]);

  const managerRentalOrders = useMemo(() => {
    return rentalOrders
      .filter(o => (o.managerId === manager.id || o.executorId === manager.id || o.ownerManagerId === manager.id) && filterByPeriod(o.createdAt))
      .sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());
  }, [rentalOrders, manager.id, period]);

  const managerLosses = useMemo(() => {
    return equipmentLosses
      .filter(l => l.managerId === manager.id && filterByPeriod(l.createdAt))
      .sort((a, b) => new Date(b.createdAt).getTime() - new Date(a.createdAt).getTime());
  }, [equipmentLosses, manager.id, period]);

  const getActivityIcon = (type: Activity['type']): { name: string; color: string } => {
    switch (type) {
      case 'excursion_added': return { name: 'plus-circle', color: theme.success };
      case 'excursion_deleted': return { name: 'trash-2', color: theme.error };
      case 'transaction_added': return { name: 'dollar-sign', color: theme.success };
      case 'transaction_deleted': return { name: 'trash-2', color: theme.error };
      case 'radio_issued': return { name: 'radio', color: theme.primary };
      case 'radio_returned': return { name: 'check-circle', color: theme.success };
      case 'rental_order_created': return { name: 'briefcase', color: theme.primary };
      case 'rental_order_updated': return { name: 'edit', color: theme.warning };
      case 'rental_order_issued': return { name: 'send', color: theme.success };
      case 'rental_order_returned': return { name: 'rotate-ccw', color: theme.warning };
      case 'rental_order_completed': return { name: 'check-square', color: theme.success };
      case 'equipment_loss_registered': return { name: 'alert-triangle', color: theme.error };
      case 'equipment_loss_found': return { name: 'check-circle', color: theme.success };
      default: return { name: 'activity', color: theme.textSecondary };
    }
  };

  const getKitBagNumber = (kitId: string) => {
    const kit = radioGuideKits.find(k => k.id === kitId);
    return kit?.bagNumber || "?";
  };

  const getExcursionRevenue = (excursion: typeof excursions[0]) => {
    const tourType = tourTypes.find(t => t.id === excursion.tourTypeId);
    if (!tourType) return 0;
    return calculateExcursionRevenue(excursion, tourType, additionalServices);
  };

  const stats = useMemo(() => {
    let totalRevenue = 0;
    let totalExpenses = 0;
    let totalParticipants = 0;

    managerExcursions.forEach(excursion => {
      const tourType = tourTypes.find(t => t.id === excursion.tourTypeId);
      if (tourType) {
        totalRevenue += calculateExcursionRevenue(excursion, tourType, additionalServices);
      }
      excursion.expenses.forEach(exp => {
        totalExpenses += exp.amount;
      });
      totalParticipants += excursion.fullPriceCount + excursion.discountedCount + 
        excursion.freeCount + excursion.byTourCount + excursion.paidCount;
    });

    managerTransactions.forEach(t => {
      if (t.type === "income") {
        totalRevenue += t.amount;
      } else {
        totalExpenses += t.amount;
      }
    });

    return {
      excursionsCount: managerExcursions.length,
      transactionsCount: managerTransactions.length,
      totalRevenue,
      totalExpenses,
      profit: totalRevenue - totalExpenses,
      totalParticipants,
    };
  }, [managerExcursions, managerTransactions, tourTypes, additionalServices]);

  const getTourTypeName = (tourTypeId: string) => {
    const tourType = tourTypes.find(t => t.id === tourTypeId);
    return tourType?.name || "Неизвестная экскурсия";
  };

  const periodLabels: Record<PeriodFilter, string> = {
    day: "День",
    week: "Неделя",
    month: "Месяц",
    all: "Все",
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <ThemedView
          style={[
            styles.profileCard,
            { backgroundColor: theme.backgroundSecondary, borderRadius: BorderRadius.md },
          ]}
        >
          <View
            style={[
              styles.avatar,
              {
                backgroundColor: currentManager.is_active
                  ? (currentManager.role === "radio_dispatcher" ? theme.warning : theme.primary)
                  : theme.textSecondary,
              },
            ]}
          >
            <Icon
              name={currentManager.role === "radio_dispatcher" ? "radio" : "user"}
              size={32}
              color={theme.buttonText}
            />
          </View>
          <ThemedText style={styles.profileName}>{currentManager.display_name}</ThemedText>
          <ThemedText style={[styles.profileEmail, { color: theme.textSecondary }]}>
            {currentManager.email}
          </ThemedText>
          <View
            style={[
              styles.roleBadge,
              {
                backgroundColor:
                  currentManager.role === "radio_dispatcher"
                    ? theme.warning + "30"
                    : theme.primary + "30",
              },
            ]}
          >
            <ThemedText
              style={[
                styles.roleText,
                {
                  color:
                    currentManager.role === "radio_dispatcher" ? theme.warning : theme.primary,
                },
              ]}
            >
              {getRoleLabel(currentManager.role)}
            </ThemedText>
          </View>
          <View style={[styles.statusBadge, { backgroundColor: currentManager.is_active ? theme.success + "30" : theme.error + "30" }]}>
            <View style={[styles.statusDot, { backgroundColor: currentManager.is_active ? theme.success : theme.error }]} />
            <ThemedText style={{ color: currentManager.is_active ? theme.success : theme.error, fontSize: 12 }}>
              {currentManager.is_active ? "Активен" : "Неактивен"}
            </ThemedText>
          </View>
        </ThemedView>

        {isAdmin ? (
          <>
            <View style={styles.actionsRow}>
              <Pressable
                style={[styles.actionButton, { backgroundColor: theme.backgroundSecondary }]}
                onPress={() => setIsEditingName(true)}
              >
                <Icon name="edit-2" size={18} color={theme.primary} />
                <ThemedText style={[styles.actionButtonText, { color: theme.primary }]}>
                  Изменить имя
                </ThemedText>
              </Pressable>
              <Pressable
                style={[styles.actionButton, { backgroundColor: theme.backgroundSecondary }]}
                onPress={handleSendPasswordReset}
              >
                <Icon name="key" size={18} color={theme.warning} />
                <ThemedText style={[styles.actionButtonText, { color: theme.warning }]}>
                  Сбросить пароль
                </ThemedText>
              </Pressable>
            </View>
            
            {currentManager.role !== 'admin' ? (
              <>
                <Pressable
                  style={[styles.permissionsButton, { backgroundColor: theme.backgroundSecondary }]}
                  onPress={() => setShowPermissions(true)}
                >
                  <Icon name="shield" size={18} color={theme.primary} />
                  <ThemedText style={[styles.actionButtonText, { color: theme.primary }]}>
                    Права доступа
                  </ThemedText>
                  <Icon name="chevron-right" size={18} color={theme.textSecondary} />
                </Pressable>
                <Pressable
                  style={[styles.permissionsButton, { backgroundColor: theme.backgroundSecondary, marginTop: Spacing.sm }]}
                  onPress={() => {
                    setOwnerCommission(String(latestManager.owner_commission_percent ?? 20));
                    setExecutorCommission(String(latestManager.executor_commission_percent ?? 10));
                    setShowCommissions(true);
                  }}
                >
                  <Icon name="percent" size={18} color={theme.success} />
                  <ThemedText style={[styles.actionButtonText, { color: theme.success }]}>
                    Комиссии
                  </ThemedText>
                  <ThemedText style={{ color: theme.textSecondary, marginLeft: 'auto', marginRight: Spacing.sm }}>
                    {latestManager.owner_commission_percent ?? 20}% / {latestManager.executor_commission_percent ?? 10}%
                  </ThemedText>
                  <Icon name="chevron-right" size={18} color={theme.textSecondary} />
                </Pressable>
              </>
            ) : null}
          </>
        ) : null}

        <Modal
          visible={isEditingName}
          transparent
          animationType="fade"
          onRequestClose={() => setIsEditingName(false)}
        >
          <View style={styles.modalOverlay}>
            <ThemedView style={[styles.modalContent, { backgroundColor: theme.backgroundSecondary }]}>
              <ThemedText style={styles.modalTitle}>Изменить имя</ThemedText>
              <TextInput
                style={[
                  styles.modalInput,
                  { backgroundColor: theme.backgroundTertiary, color: theme.text, borderColor: theme.border },
                ]}
                value={newDisplayName}
                onChangeText={setNewDisplayName}
                placeholder="Имя менеджера"
                placeholderTextColor={theme.textSecondary}
                autoFocus
              />
              <View style={styles.modalButtons}>
                <Pressable
                  style={[styles.modalButton, { backgroundColor: theme.backgroundTertiary }]}
                  onPress={() => {
                    setNewDisplayName(currentManager.display_name);
                    setIsEditingName(false);
                  }}
                >
                  <ThemedText>Отмена</ThemedText>
                </Pressable>
                <Pressable
                  style={[styles.modalButton, { backgroundColor: theme.primary }]}
                  onPress={handleSaveDisplayName}
                  disabled={isSaving}
                >
                  <ThemedText style={{ color: theme.buttonText }}>
                    {isSaving ? "Сохранение..." : "Сохранить"}
                  </ThemedText>
                </Pressable>
              </View>
            </ThemedView>
          </View>
        </Modal>

        <Modal
          visible={showPermissions}
          transparent
          animationType="fade"
          onRequestClose={() => setShowPermissions(false)}
        >
          <View style={styles.modalOverlay}>
            <ThemedView style={[styles.modalContent, { backgroundColor: theme.backgroundSecondary, maxHeight: '80%' }]}>
              <View style={styles.permissionsHeader}>
                <ThemedText style={styles.modalTitle}>Права доступа</ThemedText>
                <Pressable onPress={() => setShowPermissions(false)}>
                  <Icon name="x" size={24} color={theme.text} />
                </Pressable>
              </View>
              <ThemedText style={[styles.permissionsSubtitle, { color: theme.textSecondary }]}>
                {latestManager.display_name}
              </ThemedText>
              
              <ScrollView style={styles.permissionsScroll} showsVerticalScrollIndicator={false}>
                {PERMISSION_GROUPS.map((group) => (
                  <View key={group.key} style={styles.permissionGroup}>
                    <View style={[styles.permissionRow, { borderBottomColor: theme.border }]}>
                      <View style={styles.permissionLabelContainer}>
                        <ThemedText style={styles.permissionLabel}>{group.label}</ThemedText>
                        {group.description ? (
                          <ThemedText style={[styles.permissionDescription, { color: theme.textSecondary }]}>
                            {group.description}
                          </ThemedText>
                        ) : null}
                      </View>
                      <Switch
                        value={permissions[group.key] === true}
                        onValueChange={async (value) => {
                          const newPermissions: ManagerPermissions = { ...permissions, [group.key]: value };
                          if (!value && group.children) {
                            group.children.forEach(child => {
                              newPermissions[child.key] = false;
                            });
                          }
                          const { error } = await updateManagerPermissions(manager.id, newPermissions);
                          if (error) Alert.alert("Ошибка", error);
                        }}
                        trackColor={{ false: theme.border, true: theme.primary + '80' }}
                        thumbColor={permissions[group.key] ? theme.primary : theme.textSecondary}
                      />
                    </View>
                    {group.children && permissions[group.key] ? (
                      <View style={styles.childPermissions}>
                        {group.children.map((child) => (
                          <View key={child.key} style={[styles.permissionRow, styles.childPermissionRow, { borderBottomColor: theme.border }]}>
                            <View style={styles.permissionLabelContainer}>
                              <ThemedText style={styles.childPermissionLabel}>{child.label}</ThemedText>
                              {child.description ? (
                                <ThemedText style={[styles.permissionDescription, { color: theme.textSecondary }]}>
                                  {child.description}
                                </ThemedText>
                              ) : null}
                            </View>
                            <Switch
                              value={permissions[child.key] === true}
                              onValueChange={async (value) => {
                                const newPermissions: ManagerPermissions = { ...permissions, [child.key]: value };
                                const { error } = await updateManagerPermissions(manager.id, newPermissions);
                                if (error) Alert.alert("Ошибка", error);
                              }}
                              trackColor={{ false: theme.border, true: theme.primary + '80' }}
                              thumbColor={permissions[child.key] ? theme.primary : theme.textSecondary}
                            />
                          </View>
                        ))}
                      </View>
                    ) : null}
                  </View>
                ))}
              </ScrollView>
              
              <Pressable
                style={[styles.modalButton, { backgroundColor: theme.primary, marginTop: Spacing.lg }]}
                onPress={() => setShowPermissions(false)}
              >
                <ThemedText style={{ color: theme.buttonText }}>Готово</ThemedText>
              </Pressable>
            </ThemedView>
          </View>
        </Modal>

        <Modal
          visible={showCommissions}
          transparent
          animationType="fade"
          onRequestClose={() => setShowCommissions(false)}
        >
          <View style={styles.modalOverlay}>
            <ThemedView style={[styles.modalContent, { backgroundColor: theme.backgroundSecondary }]}>
              <ThemedText style={styles.modalTitle}>Настройка комиссий</ThemedText>
              <ThemedText style={[styles.permissionsSubtitle, { color: theme.textSecondary, marginBottom: Spacing.md }]}>
                {latestManager.display_name}
              </ThemedText>
              
              <View style={styles.commissionRow}>
                <View style={styles.commissionLabel}>
                  <ThemedText style={styles.permissionLabel}>Владелец клиента</ThemedText>
                  <ThemedText style={[styles.permissionDescription, { color: theme.textSecondary }]}>
                    Комиссия за заказы своих клиентов
                  </ThemedText>
                </View>
                <View style={[styles.commissionInputContainer, { backgroundColor: theme.backgroundTertiary, borderColor: theme.border }]}>
                  <TextInput
                    style={[styles.commissionInput, { color: theme.text }]}
                    value={ownerCommission}
                    onChangeText={setOwnerCommission}
                    keyboardType="numeric"
                    maxLength={3}
                    placeholderTextColor={theme.textSecondary}
                  />
                  <ThemedText style={{ color: theme.textSecondary }}>%</ThemedText>
                </View>
              </View>

              <View style={styles.commissionRow}>
                <View style={styles.commissionLabel}>
                  <ThemedText style={styles.permissionLabel}>Исполнитель</ThemedText>
                  <ThemedText style={[styles.permissionDescription, { color: theme.textSecondary }]}>
                    Комиссия за доставку/выдачу
                  </ThemedText>
                </View>
                <View style={[styles.commissionInputContainer, { backgroundColor: theme.backgroundTertiary, borderColor: theme.border }]}>
                  <TextInput
                    style={[styles.commissionInput, { color: theme.text }]}
                    value={executorCommission}
                    onChangeText={setExecutorCommission}
                    keyboardType="numeric"
                    maxLength={3}
                    placeholderTextColor={theme.textSecondary}
                  />
                  <ThemedText style={{ color: theme.textSecondary }}>%</ThemedText>
                </View>
              </View>

              <View style={styles.modalButtons}>
                <Pressable
                  style={[styles.modalButton, { backgroundColor: theme.backgroundTertiary }]}
                  onPress={() => setShowCommissions(false)}
                >
                  <ThemedText>Отмена</ThemedText>
                </Pressable>
                <Pressable
                  style={[styles.modalButton, { backgroundColor: theme.primary }]}
                  onPress={async () => {
                    const owner = parseInt(ownerCommission, 10);
                    const executor = parseInt(executorCommission, 10);
                    if (isNaN(owner) || isNaN(executor) || owner < 0 || executor < 0 || owner > 100 || executor > 100) {
                      Alert.alert("Ошибка", "Введите корректные проценты (0-100)");
                      return;
                    }
                    setIsSaving(true);
                    try {
                      const { error } = await updateManagerCommissions(latestManager.id, owner, executor);
                      if (error) {
                        Alert.alert("Ошибка", error);
                      } else {
                        setShowCommissions(false);
                        await refreshManagers();
                      }
                    } finally {
                      setIsSaving(false);
                    }
                  }}
                  disabled={isSaving}
                >
                  <ThemedText style={{ color: theme.buttonText }}>
                    {isSaving ? "Сохранение..." : "Сохранить"}
                  </ThemedText>
                </Pressable>
              </View>
            </ThemedView>
          </View>
        </Modal>

        <View style={styles.periodSelector}>
          {(Object.keys(periodLabels) as PeriodFilter[]).map((p) => (
            <Pressable
              key={p}
              onPress={() => setPeriod(p)}
              style={[
                styles.periodButton,
                {
                  backgroundColor: period === p ? theme.primary : theme.backgroundSecondary,
                  borderColor: period === p ? theme.primary : theme.border,
                },
              ]}
            >
              <ThemedText
                style={{
                  color: period === p ? theme.buttonText : theme.text,
                  fontSize: 13,
                  fontWeight: "500",
                }}
              >
                {periodLabels[p]}
              </ThemedText>
            </Pressable>
          ))}
        </View>

        <View style={styles.statsGrid}>
          <ThemedView style={[styles.statCard, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={[styles.statValue, { color: theme.primary }]}>
              {stats.excursionsCount}
            </ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
              Экскурсий
            </ThemedText>
          </ThemedView>
          <ThemedView style={[styles.statCard, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={[styles.statValue, { color: theme.success }]}>
              {stats.totalParticipants}
            </ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
              Участников
            </ThemedText>
          </ThemedView>
          <ThemedView style={[styles.statCard, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={[styles.statValue, { color: theme.success }]}>
              {formatCurrency(stats.totalRevenue)}
            </ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
              Выручка
            </ThemedText>
          </ThemedView>
          <ThemedView style={[styles.statCard, { backgroundColor: theme.backgroundSecondary }]}>
            <ThemedText style={[styles.statValue, { color: stats.profit >= 0 ? theme.success : theme.error }]}>
              {formatCurrency(stats.profit)}
            </ThemedText>
            <ThemedText style={[styles.statLabel, { color: theme.textSecondary }]}>
              Прибыль
            </ThemedText>
          </ThemedView>
        </View>

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>
            Экскурсии ({managerExcursions.length})
          </ThemedText>
          {managerExcursions.length === 0 ? (
            <ThemedView
              style={[styles.emptyState, { backgroundColor: theme.backgroundSecondary }]}
            >
              <Icon name="calendar" size={32} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                Нет экскурсий за выбранный период
              </ThemedText>
            </ThemedView>
          ) : (
            managerExcursions.slice(0, 10).map((excursion) => (
              <ThemedView
                key={excursion.id}
                style={[
                  styles.itemCard,
                  { backgroundColor: theme.backgroundSecondary, borderColor: theme.border },
                ]}
              >
                <View style={styles.itemHeader}>
                  <ThemedText style={styles.itemTitle}>
                    {getTourTypeName(excursion.tourTypeId)}
                  </ThemedText>
                  <ThemedText style={[styles.itemDate, { color: theme.textSecondary }]}>
                    {formatDate(excursion.date)}
                  </ThemedText>
                </View>
                <View style={styles.itemDetails}>
                  <View style={styles.itemDetail}>
                    <Icon name="users" size={14} color={theme.textSecondary} />
                    <ThemedText style={{ color: theme.textSecondary, fontSize: 13 }}>
                      {excursion.fullPriceCount + excursion.discountedCount + excursion.freeCount + 
                        excursion.byTourCount + excursion.paidCount} чел.
                    </ThemedText>
                  </View>
                  <ThemedText style={[styles.itemAmount, { color: theme.success }]}>
                    {formatCurrency(getExcursionRevenue(excursion))}
                  </ThemedText>
                </View>
              </ThemedView>
            ))
          )}
          {managerExcursions.length > 10 ? (
            <ThemedText style={[styles.moreText, { color: theme.textSecondary }]}>
              ... и ещё {managerExcursions.length - 10}
            </ThemedText>
          ) : null}
        </View>

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>
            Транзакции ({managerTransactions.length})
          </ThemedText>
          {managerTransactions.length === 0 ? (
            <ThemedView
              style={[styles.emptyState, { backgroundColor: theme.backgroundSecondary }]}
            >
              <Icon name="credit-card" size={32} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                Нет транзакций за выбранный период
              </ThemedText>
            </ThemedView>
          ) : (
            managerTransactions.slice(0, 10).map((transaction) => (
              <ThemedView
                key={transaction.id}
                style={[
                  styles.itemCard,
                  { backgroundColor: theme.backgroundSecondary, borderColor: theme.border },
                ]}
              >
                <View style={styles.itemHeader}>
                  <View style={styles.transactionType}>
                    <Icon
                      name={transaction.type === "income" ? "arrow-down-left" : "arrow-up-right"}
                      size={16}
                      color={transaction.type === "income" ? theme.success : theme.error}
                    />
                    <ThemedText style={styles.itemTitle}>
                      {transaction.description || (transaction.type === "income" ? "Доход" : "Расход")}
                    </ThemedText>
                  </View>
                  <ThemedText style={[styles.itemDate, { color: theme.textSecondary }]}>
                    {formatDate(transaction.date)}
                  </ThemedText>
                </View>
                <ThemedText
                  style={[
                    styles.transactionAmount,
                    { color: transaction.type === "income" ? theme.success : theme.error },
                  ]}
                >
                  {transaction.type === "income" ? "+" : "-"}{formatCurrency(transaction.amount)}
                </ThemedText>
              </ThemedView>
            ))
          )}
          {managerTransactions.length > 10 ? (
            <ThemedText style={[styles.moreText, { color: theme.textSecondary }]}>
              ... и ещё {managerTransactions.length - 10}
            </ThemedText>
          ) : null}
        </View>

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>
            Радиогиды ({managerRadioAssignments.length})
          </ThemedText>
          {managerRadioAssignments.length === 0 ? (
            <ThemedView
              style={[styles.emptyState, { backgroundColor: theme.backgroundSecondary }]}
            >
              <Icon name="radio" size={32} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                Нет выдач радиогидов за выбранный период
              </ThemedText>
            </ThemedView>
          ) : (
            managerRadioAssignments.slice(0, 10).map((assignment) => (
              <ThemedView
                key={assignment.id}
                style={[
                  styles.itemCard,
                  { backgroundColor: theme.backgroundSecondary, borderColor: theme.border },
                ]}
              >
                <View style={styles.itemHeader}>
                  <View style={styles.transactionType}>
                    <Icon
                      name={assignment.returnedAt ? "check-circle" : "radio"}
                      size={16}
                      color={assignment.returnedAt ? theme.success : theme.primary}
                    />
                    <ThemedText style={styles.itemTitle}>
                      Сумка {getKitBagNumber(assignment.kitId)} — {assignment.guideName}
                    </ThemedText>
                  </View>
                  <ThemedText style={[styles.itemDate, { color: theme.textSecondary }]}>
                    {formatDate(assignment.issuedAt)}
                  </ThemedText>
                </View>
                <View style={styles.itemDetails}>
                  <ThemedText style={{ color: theme.textSecondary, fontSize: 13 }}>
                    Выдано: {assignment.receiversIssued} шт.
                    {assignment.returnedAt
                      ? ` | Возвращено: ${assignment.receiversReturned} шт.`
                      : " | В работе"}
                  </ThemedText>
                </View>
              </ThemedView>
            ))
          )}
          {managerRadioAssignments.length > 10 ? (
            <ThemedText style={[styles.moreText, { color: theme.textSecondary }]}>
              ... и ещё {managerRadioAssignments.length - 10}
            </ThemedText>
          ) : null}
        </View>

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>
            Журнал активности ({managerActivities.length})
          </ThemedText>
          {managerActivities.length === 0 ? (
            <ThemedView
              style={[styles.emptyState, { backgroundColor: theme.backgroundSecondary }]}
            >
              <Icon name="activity" size={32} color={theme.textSecondary} />
              <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
                Нет активности за выбранный период
              </ThemedText>
            </ThemedView>
          ) : (
            managerActivities.slice(0, 15).map((activity) => {
              const iconData = getActivityIcon(activity.type);
              return (
                <ThemedView
                  key={activity.id}
                  style={[
                    styles.itemCard,
                    { backgroundColor: theme.backgroundSecondary, borderColor: theme.border },
                  ]}
                >
                  <View style={styles.itemHeader}>
                    <View style={styles.transactionType}>
                      <Icon
                        name={iconData.name as any}
                        size={16}
                        color={iconData.color}
                      />
                      <ThemedText style={[styles.itemTitle, { flex: 1 }]}>
                        {activity.description}
                      </ThemedText>
                    </View>
                    <ThemedText style={[styles.itemDate, { color: theme.textSecondary }]}>
                      {formatDate(activity.timestamp)}
                    </ThemedText>
                  </View>
                </ThemedView>
              );
            })
          )}
          {managerActivities.length > 15 ? (
            <ThemedText style={[styles.moreText, { color: theme.textSecondary }]}>
              ... и ещё {managerActivities.length - 15}
            </ThemedText>
          ) : null}
        </View>
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing.xl,
  },
  profileCard: {
    padding: Spacing.xl,
    alignItems: "center",
    gap: Spacing.sm,
  },
  avatar: {
    width: 72,
    height: 72,
    borderRadius: 36,
    alignItems: "center",
    justifyContent: "center",
    marginBottom: Spacing.sm,
  },
  profileName: {
    fontSize: 22,
    fontWeight: "700",
  },
  profileEmail: {
    fontSize: 14,
  },
  roleBadge: {
    paddingVertical: Spacing.xs,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.xs,
    marginTop: Spacing.xs,
  },
  roleText: {
    fontSize: 13,
    fontWeight: "500",
  },
  statusBadge: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    paddingVertical: Spacing.xs,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.xs,
    marginTop: Spacing.xs,
  },
  statusDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
  },
  periodSelector: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  periodButton: {
    flex: 1,
    paddingVertical: Spacing.sm,
    alignItems: "center",
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
  statsGrid: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.sm,
  },
  statCard: {
    flex: 1,
    minWidth: "45%",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
  statValue: {
    fontSize: 18,
    fontWeight: "700",
  },
  statLabel: {
    fontSize: 12,
    marginTop: Spacing.xs,
  },
  section: {
    gap: Spacing.md,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  emptyState: {
    padding: Spacing.xl,
    alignItems: "center",
    gap: Spacing.sm,
    borderRadius: BorderRadius.sm,
  },
  emptyText: {
    fontSize: 14,
  },
  itemCard: {
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    gap: Spacing.sm,
  },
  itemHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  itemTitle: {
    fontSize: 15,
    fontWeight: "500",
    flex: 1,
  },
  itemDate: {
    fontSize: 13,
  },
  itemDetails: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  itemDetail: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
  },
  itemAmount: {
    fontSize: 15,
    fontWeight: "600",
  },
  transactionType: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.xs,
    flex: 1,
  },
  transactionAmount: {
    fontSize: 16,
    fontWeight: "600",
  },
  moreText: {
    textAlign: "center",
    fontSize: 13,
  },
  actionsRow: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  actionButton: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.sm,
  },
  actionButtonText: {
    fontSize: 14,
    fontWeight: "500",
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
    justifyContent: "center",
    alignItems: "center",
    padding: Spacing.xl,
  },
  modalContent: {
    width: "100%",
    padding: Spacing.xl,
    borderRadius: BorderRadius.md,
    gap: Spacing.lg,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "600",
    textAlign: "center",
  },
  modalInput: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    fontSize: 16,
  },
  modalButtons: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  modalButton: {
    flex: 1,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
  permissionsButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.sm,
    gap: Spacing.sm,
  },
  permissionsHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  permissionsSubtitle: {
    fontSize: 14,
    marginTop: -Spacing.sm,
  },
  permissionRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingVertical: Spacing.md,
    borderBottomWidth: 1,
  },
  permissionLabel: {
    fontSize: 15,
    fontWeight: "500",
  },
  permissionsScroll: {
    maxHeight: 400,
  },
  permissionGroup: {
    marginBottom: Spacing.xs,
  },
  permissionLabelContainer: {
    flex: 1,
    marginRight: Spacing.md,
  },
  permissionDescription: {
    fontSize: 12,
    marginTop: 2,
  },
  childPermissions: {
    paddingLeft: Spacing.lg,
  },
  childPermissionRow: {
    paddingVertical: Spacing.sm,
  },
  childPermissionLabel: {
    fontSize: 14,
  },
  commissionRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  commissionLabel: {
    flex: 1,
    marginRight: Spacing.md,
  },
  commissionInputContainer: {
    flexDirection: "row",
    alignItems: "center",
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    gap: Spacing.xs,
  },
  commissionInput: {
    width: 40,
    fontSize: 16,
    textAlign: "center",
  },
});
