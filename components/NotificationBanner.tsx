import { useState, useEffect, useRef } from "react";
import { View, StyleSheet, Pressable, Animated } from "react-native";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { useNavigation } from "@react-navigation/native";
import { ThemedText } from "@/components/ThemedText";
import { Icon } from "@/components/Icon";
import { useTheme } from "@/hooks/useTheme";
import { useData, AppNotification } from "@/contexts/DataContext";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useSafeAreaInsets } from "react-native-safe-area-context";

const SHOWN_NOTIFICATIONS_KEY = "shown_notification_ids";

export function NotificationBanner() {
  const { theme } = useTheme();
  const insets = useSafeAreaInsets();
  const navigation = useNavigation<any>();
  const { notifications, markNotificationAsRead } = useData();
  const [visibleNotification, setVisibleNotification] = useState<AppNotification | null>(null);
  const [shownIds, setShownIds] = useState<Set<string>>(new Set());
  const slideAnim = useRef(new Animated.Value(-100)).current;
  const isInitialized = useRef(false);

  useEffect(() => {
    AsyncStorage.getItem(SHOWN_NOTIFICATIONS_KEY).then(data => {
      if (data) {
        try {
          const ids = JSON.parse(data) as string[];
          setShownIds(new Set(ids));
        } catch {}
      }
      isInitialized.current = true;
    });
  }, []);

  const saveShownId = async (id: string) => {
    const newShownIds = new Set(shownIds);
    newShownIds.add(id);
    const idsArray = Array.from(newShownIds).slice(-100);
    setShownIds(new Set(idsArray));
    await AsyncStorage.setItem(SHOWN_NOTIFICATIONS_KEY, JSON.stringify(idsArray));
  };

  useEffect(() => {
    if (!isInitialized.current) return;
    
    const unreadNotifications = notifications.filter(n => !n.isRead && !shownIds.has(n.id));
    if (unreadNotifications.length > 0) {
      const latestUnread = unreadNotifications[0];
      saveShownId(latestUnread.id);
      setVisibleNotification(latestUnread);
      
      Animated.spring(slideAnim, {
        toValue: 0,
        useNativeDriver: true,
        tension: 50,
        friction: 8,
      }).start();

      const timer = setTimeout(() => {
        hideBanner();
      }, 4000);

      return () => clearTimeout(timer);
    }
  }, [notifications, shownIds]);

  const hideBanner = () => {
    Animated.timing(slideAnim, {
      toValue: -150,
      duration: 200,
      useNativeDriver: true,
    }).start(() => {
      setVisibleNotification(null);
    });
  };

  const handlePress = async () => {
    if (visibleNotification) {
      await markNotificationAsRead(visibleNotification.id);
      hideBanner();
      if (visibleNotification.type === 'chat') {
        navigation.navigate('SettingsTab', { screen: 'Chat' });
      }
    }
  };

  const handleDismiss = () => {
    hideBanner();
  };

  const getIcon = (type: string) => {
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

  if (!visibleNotification) return null;

  return (
    <Animated.View
      style={[
        styles.container,
        {
          top: insets.top + Spacing.sm,
          backgroundColor: theme.backgroundSecondary,
          borderColor: theme.border,
          transform: [{ translateY: slideAnim }],
        },
      ]}
    >
      <Pressable onPress={handlePress} style={styles.content}>
        <View style={[styles.iconContainer, { backgroundColor: theme.primary }]}>
          <Icon name={getIcon(visibleNotification.type)} size={18} color="#FFFFFF" />
        </View>
        <View style={styles.textContainer}>
          <ThemedText style={styles.title} numberOfLines={1}>
            {visibleNotification.title}
          </ThemedText>
          {visibleNotification.body ? (
            <ThemedText type="small" style={{ color: theme.textSecondary }} numberOfLines={2}>
              {visibleNotification.body}
            </ThemedText>
          ) : null}
        </View>
        <Pressable onPress={handleDismiss} style={styles.closeButton}>
          <Icon name="x" size={18} color={theme.textSecondary} />
        </Pressable>
      </Pressable>
    </Animated.View>
  );
}

const styles = StyleSheet.create({
  container: {
    position: "absolute",
    left: Spacing.md,
    right: Spacing.md,
    borderRadius: BorderRadius.lg,
    borderWidth: 1,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 8,
    zIndex: 1000,
  },
  content: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
  },
  iconContainer: {
    width: 36,
    height: 36,
    borderRadius: BorderRadius.full,
    justifyContent: "center",
    alignItems: "center",
  },
  textContainer: {
    flex: 1,
    marginLeft: Spacing.sm,
    marginRight: Spacing.sm,
  },
  title: {
    fontWeight: "600",
    marginBottom: 2,
  },
  closeButton: {
    padding: Spacing.xs,
  },
});
