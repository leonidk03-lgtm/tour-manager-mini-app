import { useState, useCallback } from "react";
import { View, StyleSheet, Pressable, Switch, RefreshControl, Alert, TextInput, Modal } from "react-native";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { Icon } from "@/components/Icon";
import { useTheme } from "@/hooks/useTheme";
import { useData, AppNotification } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";
import { useNotifications, NotificationType, NotificationTypePreference, DEFAULT_NOTIFICATION_PREFERENCES } from "@/contexts/NotificationContext";
import { Spacing, BorderRadius } from "@/constants/theme";
import { hapticFeedback } from "@/utils/haptics";

const NOTIFICATION_TYPE_LABELS: Record<NotificationType, { title: string; description: string; icon: string }> = {
  order_issued: { title: "Заказ выдан", description: "При выдаче заказа клиенту", icon: "package" },
  order_returned: { title: "Заказ возвращён", description: "При возврате оборудования", icon: "check-circle" },
  bag_issued: { title: "Блок выдан гиду", description: "При выдаче сумки/блока гиду", icon: "briefcase" },
  reminder: { title: "Напоминание", description: "За N дней до начала аренды", icon: "clock" },
  order_cancelled: { title: "Заказ отменён", description: "При отмене заказа", icon: "x-circle" },
  status_change: { title: "Смена статуса", description: "При изменении статуса заказа", icon: "refresh-cw" },
  equipment_issued: { title: "Оборудование выдано", description: "При выдаче оборудования", icon: "tool" },
};

const RECIPIENT_LABELS: Record<string, string> = {
  client: "Клиент",
  guide: "Гид",
  manager: "Менеджер",
};

export default function NotificationsScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const {
    notifications,
    unreadNotificationCount,
    notificationSettings,
    markNotificationAsRead,
    markAllNotificationsAsRead,
    updateNotificationSettings,
  } = useData();
  const {
    notificationSettings: telegramSettings,
    tablesAvailable: telegramTablesAvailable,
    initError: telegramInitError,
    telegramContacts,
    updateNotificationSettings: updateTelegramSettings,
    refreshData: refreshTelegramData,
  } = useNotifications();

  const [refreshing, setRefreshing] = useState(false);
  const [showTelegramTokenInput, setShowTelegramTokenInput] = useState(false);
  const [telegramBotToken, setTelegramBotToken] = useState("");
  const [expandedTypes, setExpandedTypes] = useState<Set<NotificationType>>(new Set());
  const [editingTemplate, setEditingTemplate] = useState<NotificationType | null>(null);
  const [templateText, setTemplateText] = useState("");
  const [showBotUsernameInput, setShowBotUsernameInput] = useState(false);
  const [botUsernameInput, setBotUsernameInput] = useState("");

  const toggleExpanded = (type: NotificationType) => {
    setExpandedTypes(prev => {
      const next = new Set(prev);
      if (next.has(type)) {
        next.delete(type);
      } else {
        next.add(type);
      }
      return next;
    });
  };

  const getPreference = (type: NotificationType): NotificationTypePreference => {
    return telegramSettings?.preferences?.[type] || DEFAULT_NOTIFICATION_PREFERENCES[type];
  };

  const updateTypePreference = async (type: NotificationType, updates: Partial<NotificationTypePreference>) => {
    const currentPrefs = telegramSettings?.preferences || DEFAULT_NOTIFICATION_PREFERENCES;
    const currentTypePref = currentPrefs[type];
    const newTypePref = { ...currentTypePref, ...updates };
    const newPrefs = { ...currentPrefs, [type]: newTypePref };
    
    try {
      await updateTelegramSettings({ preferences: newPrefs });
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось сохранить настройки");
    }
  };

  const updateRecipient = async (type: NotificationType, recipient: 'client' | 'guide' | 'manager', enabled: boolean) => {
    const currentPref = getPreference(type);
    const newRecipients = { ...currentPref.recipients, [recipient]: enabled };
    await updateTypePreference(type, { recipients: newRecipients });
  };

  const saveTemplate = async () => {
    if (!editingTemplate) return;
    hapticFeedback.selection();
    await updateTypePreference(editingTemplate, { template: templateText });
    setEditingTemplate(null);
  };

  const onRefresh = useCallback(async () => {
    setRefreshing(true);
    setTimeout(() => setRefreshing(false), 500);
  }, []);

  const handleMarkAllAsRead = async () => {
    hapticFeedback.light();
    await markAllNotificationsAsRead();
  };

  const handleToggleSetting = async (key: 'chatEnabled' | 'excursionsEnabled' | 'transactionsEnabled', value: boolean) => {
    hapticFeedback.selection();
    await updateNotificationSettings({ [key]: value });
  };

  const formatTime = (dateString: string) => {
    const date = new Date(dateString);
    const now = new Date();
    const diffMs = now.getTime() - date.getTime();
    const diffMins = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMs / 3600000);
    const diffDays = Math.floor(diffMs / 86400000);

    if (diffMins < 1) return "только что";
    if (diffMins < 60) return `${diffMins} мин. назад`;
    if (diffHours < 24) return `${diffHours} ч. назад`;
    if (diffDays < 7) return `${diffDays} дн. назад`;
    return date.toLocaleDateString("ru-RU");
  };

  const getNotificationIcon = (type: string) => {
    switch (type) {
      case 'chat':
        return 'message-circle';
      case 'excursion':
        return 'map';
      case 'transaction':
        return 'trending-up';
      default:
        return 'bell';
    }
  };

  const handleNotificationPress = async (notification: AppNotification) => {
    if (!notification.isRead) {
      hapticFeedback.light();
      await markNotificationAsRead(notification.id);
    }
  };

  return (
    <ScreenScrollView
      refreshControl={
        <RefreshControl
          refreshing={refreshing}
          onRefresh={onRefresh}
          tintColor={theme.primary}
        />
      }
    >
      <View style={styles.container}>
        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>Настройки уведомлений</ThemedText>
          <ThemedView
            style={[
              styles.settingsGroup,
              { borderColor: theme.border, borderRadius: BorderRadius.sm },
            ]}
          >
            <View style={styles.settingItem}>
              <View style={styles.settingLeft}>
                <Icon name="message-circle" size={20} color={theme.textSecondary} />
                <ThemedText style={styles.settingText}>Сообщения чата</ThemedText>
              </View>
              <Switch
                value={notificationSettings.chatEnabled}
                onValueChange={(value) => handleToggleSetting('chatEnabled', value)}
                trackColor={{ false: theme.border, true: theme.primary }}
                thumbColor="#FFFFFF"
              />
            </View>
            {isAdmin ? (
              <>
                <View style={[styles.divider, { backgroundColor: theme.border }]} />
                <View style={styles.settingItem}>
                  <View style={styles.settingLeft}>
                    <Icon name="map" size={20} color={theme.textSecondary} />
                    <ThemedText style={styles.settingText}>Новые экскурсии</ThemedText>
                  </View>
                  <Switch
                    value={notificationSettings.excursionsEnabled}
                    onValueChange={(value) => handleToggleSetting('excursionsEnabled', value)}
                    trackColor={{ false: theme.border, true: theme.primary }}
                    thumbColor="#FFFFFF"
                  />
                </View>
                <View style={[styles.divider, { backgroundColor: theme.border }]} />
                <View style={styles.settingItem}>
                  <View style={styles.settingLeft}>
                    <Icon name="trending-up" size={20} color={theme.textSecondary} />
                    <ThemedText style={styles.settingText}>Новые транзакции</ThemedText>
                  </View>
                  <Switch
                    value={notificationSettings.transactionsEnabled}
                    onValueChange={(value) => handleToggleSetting('transactionsEnabled', value)}
                    trackColor={{ false: theme.border, true: theme.primary }}
                    thumbColor="#FFFFFF"
                  />
                </View>
              </>
            ) : null}
          </ThemedView>
        </View>

        {isAdmin ? (
          <View style={styles.section}>
            <ThemedText style={styles.sectionTitle}>Telegram-уведомления</ThemedText>
            {!telegramTablesAvailable ? (
              <ThemedView
                style={[
                  styles.warningCard,
                  { borderColor: "#FF9800", backgroundColor: "rgba(255,152,0,0.1)", borderRadius: BorderRadius.sm },
                ]}
              >
                <Icon name="alert-triangle" size={20} color="#FF9800" />
                <ThemedText style={[styles.warningText, { color: "#FF9800" }]}>
                  {telegramInitError || "Таблицы уведомлений недоступны. Проверьте настройки Supabase."}
                </ThemedText>
              </ThemedView>
            ) : (
              <>
                <ThemedView
                  style={[
                    styles.settingsGroup,
                    { borderColor: theme.border, borderRadius: BorderRadius.sm, marginBottom: Spacing.md },
                  ]}
                >
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Icon name="send" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>Telegram включён</ThemedText>
                    </View>
                    <Switch
                      value={telegramSettings?.notificationsEnabled ?? false}
                      onValueChange={async (value) => {
                        hapticFeedback.selection();
                        try {
                          await updateTelegramSettings({ notificationsEnabled: value });
                        } catch (error) {
                          Alert.alert("Ошибка", "Не удалось обновить настройки");
                        }
                      }}
                      trackColor={{ false: theme.border, true: theme.primary }}
                      thumbColor="#FFFFFF"
                    />
                  </View>
                  <View style={[styles.divider, { backgroundColor: theme.border }]} />
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Icon name="key" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>
                        Bot Token: {telegramSettings?.telegramBotToken ? "Настроен" : "Не настроен"}
                      </ThemedText>
                    </View>
                    <Pressable
                      onPress={() => setShowTelegramTokenInput(!showTelegramTokenInput)}
                      style={({ pressed }) => [pressed && { opacity: 0.7 }]}
                    >
                      <Icon name={showTelegramTokenInput ? "chevron-up" : "chevron-down"} size={20} color={theme.textSecondary} />
                    </Pressable>
                  </View>
                  {showTelegramTokenInput ? (
                    <View style={styles.tokenInputContainer}>
                      <TextInput
                        style={[
                          styles.tokenInput,
                          { color: theme.text, borderColor: theme.border, backgroundColor: theme.backgroundSecondary },
                        ]}
                        placeholder="Введите Telegram Bot Token"
                        placeholderTextColor={theme.textSecondary}
                        value={telegramBotToken}
                        onChangeText={setTelegramBotToken}
                        secureTextEntry
                      />
                      <Pressable
                        style={[styles.saveTokenButton, { backgroundColor: theme.primary }]}
                        onPress={async () => {
                          if (!telegramBotToken.trim()) {
                            Alert.alert("Ошибка", "Введите токен");
                            return;
                          }
                          hapticFeedback.selection();
                          try {
                            await updateTelegramSettings({ telegramBotToken: telegramBotToken.trim() });
                            setTelegramBotToken("");
                            setShowTelegramTokenInput(false);
                            Alert.alert("Успех", "Токен сохранён");
                          } catch (error) {
                            Alert.alert("Ошибка", "Не удалось сохранить токен");
                          }
                        }}
                      >
                        <ThemedText style={{ color: "#FFFFFF" }}>Сохранить</ThemedText>
                      </Pressable>
                    </View>
                  ) : null}
                  <View style={[styles.divider, { backgroundColor: theme.border }]} />
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Icon name="at-sign" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>
                        Имя бота: {telegramSettings?.telegramBotUsername ? `@${telegramSettings.telegramBotUsername}` : "Не настроено"}
                      </ThemedText>
                    </View>
                    <Pressable
                      onPress={() => {
                        setBotUsernameInput(telegramSettings?.telegramBotUsername || "");
                        setShowBotUsernameInput(true);
                      }}
                      style={({ pressed }) => [pressed && { opacity: 0.7 }]}
                    >
                      <Icon name="edit-2" size={18} color={theme.primary} />
                    </Pressable>
                  </View>
                  {showBotUsernameInput ? (
                    <View style={styles.tokenInputContainer}>
                      <TextInput
                        style={[
                          styles.tokenInput,
                          { color: theme.text, borderColor: theme.border, backgroundColor: theme.backgroundSecondary },
                        ]}
                        placeholder="Введите имя бота без @"
                        placeholderTextColor={theme.textSecondary}
                        value={botUsernameInput}
                        onChangeText={(text) => setBotUsernameInput(text.replace("@", ""))}
                        autoCapitalize="none"
                        autoCorrect={false}
                      />
                      <Pressable
                        style={[styles.saveTokenButton, { backgroundColor: theme.primary }]}
                        onPress={async () => {
                          if (!botUsernameInput.trim()) {
                            Alert.alert("Ошибка", "Введите имя бота");
                            return;
                          }
                          hapticFeedback.selection();
                          try {
                            await updateTelegramSettings({ telegramBotUsername: botUsernameInput.trim() });
                            setBotUsernameInput("");
                            setShowBotUsernameInput(false);
                            Alert.alert("Успех", "Имя бота сохранено");
                          } catch (error) {
                            Alert.alert("Ошибка", "Не удалось сохранить");
                          }
                        }}
                      >
                        <ThemedText style={{ color: "#FFFFFF" }}>Сохранить</ThemedText>
                      </Pressable>
                    </View>
                  ) : null}
                  <View style={[styles.divider, { backgroundColor: theme.border }]} />
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Icon name="clock" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>
                        Напоминание за {telegramSettings?.reminderDaysBefore ?? 2} дн.
                      </ThemedText>
                    </View>
                    <View style={styles.stepperContainer}>
                      <Pressable
                        style={[styles.stepperButton, { backgroundColor: theme.backgroundSecondary }]}
                        onPress={async () => {
                          const current = telegramSettings?.reminderDaysBefore ?? 2;
                          if (current > 1) {
                            hapticFeedback.selection();
                            try {
                              await updateTelegramSettings({ reminderDaysBefore: current - 1 });
                            } catch (error) {
                              Alert.alert("Ошибка", "Не удалось обновить");
                            }
                          }
                        }}
                      >
                        <Icon name="minus" size={16} color={theme.text} />
                      </Pressable>
                      <Pressable
                        style={[styles.stepperButton, { backgroundColor: theme.backgroundSecondary }]}
                        onPress={async () => {
                          const current = telegramSettings?.reminderDaysBefore ?? 2;
                          if (current < 14) {
                            hapticFeedback.selection();
                            try {
                              await updateTelegramSettings({ reminderDaysBefore: current + 1 });
                            } catch (error) {
                              Alert.alert("Ошибка", "Не удалось обновить");
                            }
                          }
                        }}
                      >
                        <Icon name="plus" size={16} color={theme.text} />
                      </Pressable>
                    </View>
                  </View>
                  <View style={[styles.divider, { backgroundColor: theme.border }]} />
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Icon name="clock" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>
                        Время: {telegramSettings?.reminderTime ?? '12:00'}
                      </ThemedText>
                    </View>
                    <View style={styles.timePickerRow}>
                      {['09:00', '10:00', '12:00', '14:00', '18:00'].map((time) => (
                        <Pressable
                          key={time}
                          style={[
                            styles.timeChip,
                            { 
                              backgroundColor: (telegramSettings?.reminderTime ?? '12:00') === time ? theme.primary : theme.backgroundSecondary,
                              borderColor: (telegramSettings?.reminderTime ?? '12:00') === time ? theme.primary : theme.border,
                            },
                          ]}
                          onPress={async () => {
                            hapticFeedback.selection();
                            try {
                              await updateTelegramSettings({ reminderTime: time });
                            } catch (error) {
                              Alert.alert("Ошибка", "Не удалось обновить время");
                            }
                          }}
                        >
                          <ThemedText style={{ color: (telegramSettings?.reminderTime ?? '12:00') === time ? "#FFFFFF" : theme.text, fontSize: 12 }}>
                            {time}
                          </ThemedText>
                        </Pressable>
                      ))}
                    </View>
                  </View>
                  <View style={[styles.divider, { backgroundColor: theme.border }]} />
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Icon name="users" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>
                        Telegram-контактов: {telegramContacts.length}
                      </ThemedText>
                    </View>
                  </View>
                </ThemedView>

                <ThemedText style={[styles.sectionTitle, { marginTop: Spacing.md }]}>Типы уведомлений</ThemedText>
                {(Object.keys(NOTIFICATION_TYPE_LABELS) as NotificationType[]).map((type) => {
                  const label = NOTIFICATION_TYPE_LABELS[type];
                  const pref = getPreference(type);
                  const isExpanded = expandedTypes.has(type);
                  
                  return (
                    <ThemedView
                      key={type}
                      style={[
                        styles.notificationTypeCard,
                        { borderColor: theme.border, borderRadius: BorderRadius.sm },
                      ]}
                    >
                      <Pressable
                        style={styles.notificationTypeHeader}
                        onPress={() => {
                          hapticFeedback.selection();
                          toggleExpanded(type);
                        }}
                      >
                        <View style={styles.notificationTypeLeft}>
                          <View style={[styles.typeIconContainer, { backgroundColor: pref.enabled ? theme.primary : theme.border }]}>
                            <Icon name={label.icon as any} size={16} color={pref.enabled ? "#FFFFFF" : theme.textSecondary} />
                          </View>
                          <View>
                            <ThemedText style={styles.notificationTypeTitle}>{label.title}</ThemedText>
                            <ThemedText style={[styles.notificationTypeDesc, { color: theme.textSecondary }]}>{label.description}</ThemedText>
                          </View>
                        </View>
                        <View style={styles.notificationTypeRight}>
                          <Switch
                            value={pref.enabled}
                            onValueChange={async (value) => {
                              hapticFeedback.selection();
                              await updateTypePreference(type, { enabled: value });
                            }}
                            trackColor={{ false: theme.border, true: theme.primary }}
                            thumbColor="#FFFFFF"
                          />
                          <Icon name={isExpanded ? "chevron-up" : "chevron-down"} size={20} color={theme.textSecondary} />
                        </View>
                      </Pressable>
                      
                      {isExpanded ? (
                        <View style={styles.notificationTypeExpanded}>
                          <View style={[styles.divider, { backgroundColor: theme.border }]} />
                          <ThemedText style={[styles.recipientsLabel, { color: theme.textSecondary }]}>Получатели:</ThemedText>
                          <View style={styles.recipientsRow}>
                            {(['client', 'guide', 'manager'] as const).map((recipient) => (
                              <Pressable
                                key={recipient}
                                style={[
                                  styles.recipientChip,
                                  { 
                                    backgroundColor: pref.recipients[recipient] ? theme.primary : theme.backgroundSecondary,
                                    borderColor: pref.recipients[recipient] ? theme.primary : theme.border,
                                  },
                                ]}
                                onPress={async () => {
                                  hapticFeedback.selection();
                                  await updateRecipient(type, recipient, !pref.recipients[recipient]);
                                }}
                              >
                                <ThemedText style={{ color: pref.recipients[recipient] ? "#FFFFFF" : theme.text, fontSize: 13 }}>
                                  {RECIPIENT_LABELS[recipient]}
                                </ThemedText>
                              </Pressable>
                            ))}
                          </View>
                          <View style={[styles.divider, { backgroundColor: theme.border, marginTop: Spacing.sm }]} />
                          <Pressable
                            style={styles.templateButton}
                            onPress={() => {
                              setTemplateText(pref.template);
                              setEditingTemplate(type);
                            }}
                          >
                            <Icon name="edit-2" size={16} color={theme.primary} />
                            <ThemedText style={{ color: theme.primary, marginLeft: Spacing.xs }}>Редактировать шаблон</ThemedText>
                          </Pressable>
                          <ThemedText style={[styles.templatePreview, { color: theme.textSecondary }]} numberOfLines={2}>
                            {pref.template}
                          </ThemedText>
                        </View>
                      ) : null}
                    </ThemedView>
                  );
                })}
              </>
            )}
          </View>
        ) : null}

        <Modal
          visible={editingTemplate !== null}
          animationType="slide"
          transparent
          onRequestClose={() => setEditingTemplate(null)}
        >
          <View style={styles.modalOverlay}>
            <ThemedView style={[styles.modalContent, { borderRadius: BorderRadius.md }]}>
              <View style={styles.modalHeader}>
                <ThemedText style={styles.modalTitle}>
                  Шаблон: {editingTemplate ? NOTIFICATION_TYPE_LABELS[editingTemplate].title : ""}
                </ThemedText>
                <Pressable onPress={() => setEditingTemplate(null)}>
                  <Icon name="x" size={24} color={theme.text} />
                </Pressable>
              </View>
              <ThemedText style={[styles.placeholderHint, { color: theme.textSecondary }]}>
                Нажмите на переменную, чтобы вставить:
              </ThemedText>
              <View style={styles.variablesRow}>
                {[
                  { key: '{orderNumber}', label: 'Номер заказа' },
                  { key: '{startDate}', label: 'Дата начала' },
                  { key: '{endDate}', label: 'Дата конца' },
                  { key: '{equipmentSummary}', label: 'Оборудование' },
                  { key: '{guideName}', label: 'Имя гида' },
                  { key: '{bagNumber}', label: 'Номер сумки' },
                  { key: '{blockIndex}', label: 'Номер блока' },
                  { key: '{newStatus}', label: 'Новый статус' },
                ].map((variable) => (
                  <Pressable
                    key={variable.key}
                    style={[styles.variableChip, { backgroundColor: theme.primary + '20', borderColor: theme.primary }]}
                    onPress={() => {
                      hapticFeedback.selection();
                      setTemplateText(prev => prev + ' ' + variable.key);
                    }}
                  >
                    <ThemedText style={{ color: theme.primary, fontSize: 12 }}>{variable.label}</ThemedText>
                  </Pressable>
                ))}
              </View>
              <TextInput
                style={[
                  styles.templateInput,
                  { color: theme.text, borderColor: theme.border, backgroundColor: theme.backgroundSecondary },
                ]}
                placeholder="Введите шаблон сообщения"
                placeholderTextColor={theme.textSecondary}
                value={templateText}
                onChangeText={setTemplateText}
                multiline
                numberOfLines={4}
              />
              <View style={styles.modalButtons}>
                <Pressable
                  style={[styles.modalButton, { backgroundColor: theme.backgroundSecondary }]}
                  onPress={() => setEditingTemplate(null)}
                >
                  <ThemedText>Отмена</ThemedText>
                </Pressable>
                <Pressable
                  style={[styles.modalButton, { backgroundColor: theme.primary }]}
                  onPress={saveTemplate}
                >
                  <ThemedText style={{ color: "#FFFFFF" }}>Сохранить</ThemedText>
                </Pressable>
              </View>
            </ThemedView>
          </View>
        </Modal>

        <View style={styles.section}>
          <View style={styles.sectionHeader}>
            <ThemedText style={styles.sectionTitle}>Уведомления</ThemedText>
            {unreadNotificationCount > 0 ? (
              <Pressable onPress={handleMarkAllAsRead}>
                <ThemedText style={{ color: theme.primary }}>Прочитать все</ThemedText>
              </Pressable>
            ) : null}
          </View>
          
          {notifications.length === 0 ? (
            <ThemedView
              style={[
                styles.emptyState,
                { borderColor: theme.border, borderRadius: BorderRadius.sm },
              ]}
            >
              <Icon name="bell-off" size={48} color={theme.textSecondary} />
              <ThemedText style={{ color: theme.textSecondary, marginTop: Spacing.md }}>
                Нет уведомлений
              </ThemedText>
            </ThemedView>
          ) : (
            <ThemedView
              style={[
                styles.notificationsList,
                { borderColor: theme.border, borderRadius: BorderRadius.sm },
              ]}
            >
              {notifications.slice(0, 50).map((notification, index) => (
                <Pressable
                  key={notification.id}
                  onPress={() => handleNotificationPress(notification)}
                  style={({ pressed }) => [
                    styles.notificationItem,
                    !notification.isRead && { backgroundColor: theme.backgroundSecondary },
                    pressed && { opacity: 0.7 },
                  ]}
                >
                  <View
                    style={[
                      styles.notificationIcon,
                      { backgroundColor: notification.isRead ? theme.border : theme.primary },
                    ]}
                  >
                    <Icon
                      name={getNotificationIcon(notification.type)}
                      size={16}
                      color={notification.isRead ? theme.textSecondary : "#FFFFFF"}
                    />
                  </View>
                  <View style={styles.notificationContent}>
                    <View style={styles.notificationHeader}>
                      <ThemedText
                        style={[
                          styles.notificationTitle,
                          !notification.isRead && { fontWeight: "700" },
                        ]}
                        numberOfLines={1}
                      >
                        {notification.title}
                      </ThemedText>
                      <ThemedText style={[styles.notificationTime, { color: theme.textSecondary }]}>
                        {formatTime(notification.createdAt)}
                      </ThemedText>
                    </View>
                    {notification.body ? (
                      <ThemedText
                        style={[styles.notificationBody, { color: theme.textSecondary }]}
                        numberOfLines={2}
                      >
                        {notification.body}
                      </ThemedText>
                    ) : null}
                  </View>
                  {!notification.isRead ? (
                    <View style={[styles.unreadDot, { backgroundColor: theme.primary }]} />
                  ) : null}
                </Pressable>
              ))}
            </ThemedView>
          )}
        </View>
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    padding: Spacing.lg,
  },
  section: {
    marginBottom: Spacing.xl,
  },
  sectionHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.sm,
  },
  sectionTitle: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: Spacing.sm,
  },
  settingsGroup: {
    borderWidth: 1,
    overflow: "hidden",
  },
  settingItem: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.md,
  },
  settingLeft: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
    flex: 1,
  },
  settingText: {
    fontSize: 15,
  },
  divider: {
    height: 1,
    marginHorizontal: Spacing.md,
  },
  emptyState: {
    borderWidth: 1,
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: Spacing["2xl"],
  },
  notificationsList: {
    borderWidth: 1,
    overflow: "hidden",
  },
  notificationItem: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.md,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: "rgba(255,255,255,0.1)",
  },
  notificationIcon: {
    width: 32,
    height: 32,
    borderRadius: BorderRadius.full,
    justifyContent: "center",
    alignItems: "center",
    marginRight: Spacing.sm,
  },
  notificationContent: {
    flex: 1,
  },
  notificationHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
  },
  notificationTitle: {
    fontSize: 14,
    flex: 1,
  },
  notificationTime: {
    fontSize: 12,
    marginLeft: Spacing.sm,
  },
  notificationBody: {
    fontSize: 13,
    marginTop: 2,
  },
  unreadDot: {
    width: 8,
    height: 8,
    borderRadius: BorderRadius.full,
    marginLeft: Spacing.sm,
  },
  warningCard: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderWidth: 1,
    gap: Spacing.sm,
  },
  warningText: {
    fontSize: 13,
    flex: 1,
  },
  tokenInputContainer: {
    padding: Spacing.md,
    gap: Spacing.sm,
  },
  tokenInput: {
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    padding: Spacing.md,
    fontSize: 14,
  },
  saveTokenButton: {
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
  stepperContainer: {
    flexDirection: "row",
    gap: Spacing.xs,
  },
  stepperButton: {
    width: 32,
    height: 32,
    borderRadius: BorderRadius.sm,
    justifyContent: "center",
    alignItems: "center",
  },
  notificationTypeCard: {
    borderWidth: 1,
    marginBottom: Spacing.sm,
    overflow: "hidden",
  },
  notificationTypeHeader: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    padding: Spacing.md,
  },
  notificationTypeLeft: {
    flexDirection: "row",
    alignItems: "center",
    flex: 1,
    gap: Spacing.sm,
  },
  typeIconContainer: {
    width: 32,
    height: 32,
    borderRadius: BorderRadius.full,
    justifyContent: "center",
    alignItems: "center",
  },
  notificationTypeTitle: {
    fontSize: 14,
    fontWeight: "600",
  },
  notificationTypeDesc: {
    fontSize: 12,
    marginTop: 2,
  },
  notificationTypeRight: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  notificationTypeExpanded: {
    paddingHorizontal: Spacing.md,
    paddingBottom: Spacing.md,
  },
  recipientsLabel: {
    fontSize: 12,
    marginTop: Spacing.sm,
    marginBottom: Spacing.xs,
  },
  recipientsRow: {
    flexDirection: "row",
    gap: Spacing.xs,
  },
  recipientChip: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.full,
    borderWidth: 1,
  },
  templateButton: {
    flexDirection: "row",
    alignItems: "center",
    marginTop: Spacing.sm,
  },
  templatePreview: {
    fontSize: 12,
    marginTop: Spacing.xs,
    fontStyle: "italic",
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
    justifyContent: "center",
    padding: Spacing.lg,
  },
  modalContent: {
    padding: Spacing.lg,
  },
  modalHeader: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginBottom: Spacing.md,
  },
  modalTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  placeholderHint: {
    fontSize: 11,
    marginBottom: Spacing.sm,
  },
  templateInput: {
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    padding: Spacing.md,
    fontSize: 14,
    minHeight: 100,
    textAlignVertical: "top",
  },
  modalButtons: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginTop: Spacing.md,
  },
  modalButton: {
    flex: 1,
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
  },
  timePickerRow: {
    flexDirection: "row",
    gap: Spacing.xs,
    flexWrap: "wrap",
  },
  timeChip: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
  variablesRow: {
    flexDirection: "row",
    flexWrap: "wrap",
    gap: Spacing.xs,
    marginBottom: Spacing.md,
  },
  variableChip: {
    paddingHorizontal: Spacing.sm,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
});
