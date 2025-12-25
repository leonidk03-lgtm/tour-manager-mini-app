import { useState, useCallback } from "react";
import { View, StyleSheet, Pressable, Switch, RefreshControl, Alert, TextInput } from "react-native";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { Icon } from "@/components/Icon";
import { useTheme } from "@/hooks/useTheme";
import { useData, AppNotification } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";
import { useNotifications } from "@/contexts/NotificationContext";
import { Spacing, BorderRadius } from "@/constants/theme";
import { hapticFeedback } from "@/utils/haptics";

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
              <ThemedView
                style={[
                  styles.settingsGroup,
                  { borderColor: theme.border, borderRadius: BorderRadius.sm },
                ]}
              >
                <View style={styles.settingItem}>
                  <View style={styles.settingLeft}>
                    <Icon name="send" size={20} color={theme.textSecondary} />
                    <ThemedText style={styles.settingText}>Telegram-уведомления</ThemedText>
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
                    <Icon name="clock" size={20} color={theme.textSecondary} />
                    <ThemedText style={styles.settingText}>
                      Напоминание за {telegramSettings?.reminderDaysBefore ?? 2} дн.
                    </ThemedText>
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
              </ThemedView>
            )}
          </View>
        ) : null}

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
});
