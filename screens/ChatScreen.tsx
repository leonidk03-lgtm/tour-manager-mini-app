import { useState, useRef, useCallback, useEffect, useMemo } from "react";
import { View, StyleSheet, TextInput, Pressable, FlatList, Alert, KeyboardAvoidingView, Platform, Modal, ScrollView } from "react-native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { useBottomTabBarHeight } from "@react-navigation/bottom-tabs";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { PermissionGate } from "@/components/PermissionGate";
import { useTheme } from "@/hooks/useTheme";
import { useData, ChatMessage } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";
import { Spacing, BorderRadius, Typography } from "@/constants/theme";
import { hapticFeedback } from "@/utils/haptics";

export default function ChatScreen() {
  const { theme } = useTheme();
  const insets = useSafeAreaInsets();
  const tabBarHeight = useBottomTabBarHeight();
  const { chatMessages, sendChatMessage, clearChatHistory, managers } = useData();
  const { profile, isAdmin, hasPermission } = useAuth();
  const [message, setMessage] = useState("");
  const [isSending, setIsSending] = useState(false);
  const [replyTo, setReplyTo] = useState<ChatMessage | null>(null);
  const [recipient, setRecipient] = useState<{ id: string; name: string } | null>(null);
  const [showRecipientPicker, setShowRecipientPicker] = useState(false);
  const flatListRef = useRef<FlatList>(null);
  
  const canViewAll = isAdmin || hasPermission('chat_view_all');
  
  const activeManagers = useMemo(() => {
    return managers.filter(m => m.isActive && m.id !== profile?.id);
  }, [managers, profile]);
  
  const parseMentions = useCallback((text: string): string[] => {
    const mentionedIds = new Set<string>();
    managers.forEach(m => {
      const namePattern = `@${m.name}`;
      if (text.toLowerCase().includes(namePattern.toLowerCase())) {
        mentionedIds.add(m.id);
      }
    });
    return Array.from(mentionedIds);
  }, [managers]);
  
  const filteredMessages = useMemo(() => {
    if (canViewAll) return chatMessages;
    if (!profile) return [];
    
    const myMessageIds = new Set(
      chatMessages.filter(m => m.senderId === profile.id).map(m => m.id)
    );
    
    return chatMessages.filter(m => 
      m.senderId === profile.id ||
      (m.replyToId && myMessageIds.has(m.replyToId)) ||
      m.recipientId === profile.id ||
      (m.mentions && m.mentions.includes(profile.id))
    );
  }, [chatMessages, profile, canViewAll]);

  const scrollToBottom = useCallback(() => {
    if (flatListRef.current && chatMessages.length > 0) {
      setTimeout(() => {
        flatListRef.current?.scrollToEnd({ animated: true });
      }, 100);
    }
  }, [chatMessages.length]);

  useEffect(() => {
    scrollToBottom();
  }, [chatMessages.length, scrollToBottom]);

  const handleSend = async () => {
    if (!message.trim() || isSending) return;
    
    hapticFeedback.light();
    setIsSending(true);
    try {
      const mentions = parseMentions(message.trim());
      const options: { replyTo?: ChatMessage; recipientId?: string; recipientName?: string; mentions?: string[] } = {};
      if (replyTo) options.replyTo = replyTo;
      if (recipient) {
        options.recipientId = recipient.id;
        options.recipientName = recipient.name;
      }
      if (mentions.length > 0) {
        options.mentions = mentions;
      }
      await sendChatMessage(message.trim(), Object.keys(options).length > 0 ? options : undefined);
      setMessage("");
      setReplyTo(null);
      setRecipient(null);
      scrollToBottom();
    } catch (error) {
      Alert.alert("Ошибка", "Не удалось отправить сообщение");
    } finally {
      setIsSending(false);
    }
  };
  
  const handleReply = (msg: ChatMessage) => {
    hapticFeedback.light();
    setReplyTo(msg);
  };
  
  const cancelReply = () => {
    setReplyTo(null);
  };

  const handleClearHistory = () => {
    Alert.alert(
      "Очистить историю",
      "Вы уверены, что хотите удалить все сообщения чата? Это действие нельзя отменить.",
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Очистить",
          style: "destructive",
          onPress: async () => {
            hapticFeedback.medium();
            try {
              await clearChatHistory();
            } catch (error) {
              Alert.alert("Ошибка", "Не удалось очистить историю");
            }
          },
        },
      ]
    );
  };

  const getSenderName = (item: ChatMessage): string => {
    if (item.senderName) return item.senderName;
    const manager = managers.find(m => m.id === item.senderId);
    return manager?.name || "Неизвестный";
  };

  const formatTime = (dateStr: string): string => {
    const date = new Date(dateStr);
    return date.toLocaleTimeString("ru-RU", { hour: "2-digit", minute: "2-digit" });
  };

  const formatDate = (dateStr: string): string => {
    const date = new Date(dateStr);
    const today = new Date();
    const yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);
    
    if (date.toDateString() === today.toDateString()) {
      return "Сегодня";
    } else if (date.toDateString() === yesterday.toDateString()) {
      return "Вчера";
    }
    return date.toLocaleDateString("ru-RU", { day: "numeric", month: "long" });
  };

  const renderMessage = ({ item, index }: { item: ChatMessage; index: number }) => {
    const isOwn = item.senderId === profile?.id;
    const showDateHeader = index === 0 || 
      formatDate(filteredMessages[index - 1]?.createdAt) !== formatDate(item.createdAt);
    
    return (
      <>
        {showDateHeader ? (
          <View style={styles.dateHeader}>
            <ThemedText type="small" style={[styles.dateHeaderText, { backgroundColor: theme.backgroundSecondary }]}>
              {formatDate(item.createdAt)}
            </ThemedText>
          </View>
        ) : null}
        <Pressable 
          style={[styles.messageBubbleContainer, isOwn ? styles.ownMessage : styles.otherMessage]}
          onLongPress={() => handleReply(item)}
          delayLongPress={300}
        >
          <View
            style={[
              styles.messageBubble,
              isOwn
                ? { backgroundColor: theme.primary }
                : { backgroundColor: theme.backgroundSecondary },
            ]}
          >
            {item.replyToMessage ? (
              <View style={[styles.replyPreview, { borderLeftColor: isOwn ? 'rgba(255,255,255,0.5)' : theme.primary }]}>
                <ThemedText type="small" style={[styles.replyName, isOwn ? { color: 'rgba(255,255,255,0.8)' } : { color: theme.primary }]}>
                  {item.replyToSenderName}
                </ThemedText>
                <ThemedText type="small" style={[styles.replyText, isOwn ? { color: 'rgba(255,255,255,0.7)' } : { color: theme.textSecondary }]} numberOfLines={1}>
                  {item.replyToMessage}
                </ThemedText>
              </View>
            ) : null}
            {!isOwn ? (
              <ThemedText type="small" style={[styles.senderName, { color: theme.primary }]}>
                {getSenderName(item)}
              </ThemedText>
            ) : null}
            <ThemedText
              type="body"
              style={[styles.messageText, isOwn ? { color: "#FFFFFF" } : { color: theme.text }]}
            >
              {item.message}
            </ThemedText>
            <View style={styles.messageFooter}>
              <ThemedText
                type="small"
                style={[styles.messageTime, isOwn ? { color: "rgba(255,255,255,0.7)" } : { color: theme.textSecondary }]}
              >
                {formatTime(item.createdAt)}
              </ThemedText>
              {!isOwn ? (
                <Pressable onPress={() => handleReply(item)} style={styles.replyButton} hitSlop={8}>
                  <Icon name="corner-up-left" size={14} color={theme.textSecondary} />
                </Pressable>
              ) : null}
            </View>
          </View>
        </Pressable>
      </>
    );
  };

  return (
    <PermissionGate permission="chat">
    <ThemedView style={styles.container}>
      <KeyboardAvoidingView
        style={styles.flex}
        behavior={Platform.OS === "ios" ? "padding" : "height"}
        keyboardVerticalOffset={Platform.OS === "ios" ? 90 : 0}
      >
        {isAdmin ? (
          <View style={[styles.adminBar, { backgroundColor: theme.backgroundSecondary }]}>
            <Pressable onPress={handleClearHistory} style={styles.clearButton}>
              <Icon name="trash-2" size={18} color={theme.error} />
              <ThemedText type="small" style={{ color: theme.error, marginLeft: Spacing.xs }}>
                Очистить историю
              </ThemedText>
            </Pressable>
          </View>
        ) : null}
        
        <FlatList
          ref={flatListRef}
          data={filteredMessages}
          keyExtractor={(item) => item.id}
          renderItem={renderMessage}
          contentContainerStyle={[
            styles.messageList,
            { paddingBottom: Spacing.md },
          ]}
          showsVerticalScrollIndicator={false}
          ListEmptyComponent={
            <View style={styles.emptyContainer}>
              <Icon name="message-circle" size={48} color={theme.textSecondary} />
              <ThemedText type="body" style={[styles.emptyText, { color: theme.textSecondary }]}>
                {canViewAll ? "Нет сообщений" : "У вас пока нет сообщений"}
              </ThemedText>
              <ThemedText type="small" style={[styles.emptySubtext, { color: theme.textSecondary }]}>
                Напишите первое сообщение
              </ThemedText>
            </View>
          }
        />

        {recipient ? (
          <View style={[styles.recipientBar, { backgroundColor: theme.backgroundSecondary, borderLeftColor: theme.success }]}>
            <View style={styles.replyBarContent}>
              <ThemedText type="small" style={{ color: theme.success, fontWeight: '600' }}>
                Кому: {recipient.name}
              </ThemedText>
            </View>
            <Pressable onPress={() => setRecipient(null)} style={styles.replyBarClose} hitSlop={8}>
              <Icon name="x" size={18} color={theme.textSecondary} />
            </Pressable>
          </View>
        ) : null}
        
        {replyTo ? (
          <View style={[styles.replyBar, { backgroundColor: theme.backgroundSecondary, borderLeftColor: theme.primary }]}>
            <View style={styles.replyBarContent}>
              <ThemedText type="small" style={{ color: theme.primary, fontWeight: '600' }}>
                {replyTo.senderName}
              </ThemedText>
              <ThemedText type="small" style={{ color: theme.textSecondary }} numberOfLines={1}>
                {replyTo.message}
              </ThemedText>
            </View>
            <Pressable onPress={cancelReply} style={styles.replyBarClose} hitSlop={8}>
              <Icon name="x" size={18} color={theme.textSecondary} />
            </Pressable>
          </View>
        ) : null}
        
        <View style={[styles.inputContainer, { paddingBottom: tabBarHeight + Spacing.lg, backgroundColor: theme.backgroundDefault }]}>
          {canViewAll ? (
            <Pressable 
              onPress={() => setShowRecipientPicker(true)} 
              style={[styles.recipientButton, { backgroundColor: theme.backgroundSecondary }]}
            >
              <Icon name="at-sign" size={20} color={recipient ? theme.success : theme.textSecondary} />
            </Pressable>
          ) : null}
          <TextInput
            style={[
              styles.input,
              {
                backgroundColor: theme.backgroundSecondary,
                color: theme.text,
                borderColor: theme.border,
              },
            ]}
            placeholder="Сообщение..."
            placeholderTextColor={theme.textSecondary}
            value={message}
            onChangeText={setMessage}
            multiline
            maxLength={1000}
          />
          <Pressable
            onPress={handleSend}
            disabled={!message.trim() || isSending}
            style={[
              styles.sendButton,
              {
                backgroundColor: message.trim() && !isSending ? theme.primary : theme.backgroundSecondary,
              },
            ]}
          >
            <Icon
              name="send"
              size={20}
              color={message.trim() && !isSending ? "#FFFFFF" : theme.textSecondary}
            />
          </Pressable>
        </View>
      </KeyboardAvoidingView>
      
      <Modal
        visible={showRecipientPicker}
        transparent
        animationType="fade"
        onRequestClose={() => setShowRecipientPicker(false)}
      >
        <View style={styles.modalOverlay}>
          <ThemedView style={[styles.modalContent, { backgroundColor: theme.backgroundSecondary }]}>
            <View style={styles.modalHeader}>
              <ThemedText style={styles.modalTitle}>Написать менеджеру</ThemedText>
              <Pressable onPress={() => setShowRecipientPicker(false)}>
                <Icon name="x" size={24} color={theme.text} />
              </Pressable>
            </View>
            <ScrollView style={styles.managerList}>
              {activeManagers.map((m) => (
                <Pressable
                  key={m.id}
                  style={[styles.managerItem, { borderBottomColor: theme.border }]}
                  onPress={() => {
                    setRecipient({ id: m.id, name: m.name });
                    setShowRecipientPicker(false);
                    hapticFeedback.light();
                  }}
                >
                  <View style={[styles.managerAvatar, { backgroundColor: theme.primary + '20' }]}>
                    <ThemedText style={{ color: theme.primary, fontWeight: '600' }}>
                      {m.name.charAt(0).toUpperCase()}
                    </ThemedText>
                  </View>
                  <ThemedText style={styles.managerName}>{m.name}</ThemedText>
                </Pressable>
              ))}
              {activeManagers.length === 0 ? (
                <ThemedText style={[styles.emptyText, { color: theme.textSecondary, textAlign: 'center', padding: Spacing.lg }]}>
                  Нет доступных менеджеров
                </ThemedText>
              ) : null}
            </ScrollView>
          </ThemedView>
        </View>
      </Modal>
    </ThemedView>
    </PermissionGate>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  flex: {
    flex: 1,
  },
  adminBar: {
    flexDirection: "row",
    justifyContent: "flex-end",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
  },
  clearButton: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.xs,
  },
  messageList: {
    paddingHorizontal: Spacing.md,
    paddingTop: Spacing.md,
    flexGrow: 1,
  },
  dateHeader: {
    alignItems: "center",
    marginVertical: Spacing.md,
  },
  dateHeaderText: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.full,
    overflow: "hidden",
  },
  messageBubbleContainer: {
    marginVertical: Spacing.xs,
    maxWidth: "80%",
  },
  ownMessage: {
    alignSelf: "flex-end",
  },
  otherMessage: {
    alignSelf: "flex-start",
  },
  messageBubble: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.lg,
  },
  senderName: {
    marginBottom: Spacing.xs,
    fontWeight: "600",
  },
  messageText: {
    lineHeight: Typography.body.lineHeight,
  },
  messageTime: {
    flex: 1,
  },
  messageFooter: {
    flexDirection: "row",
    alignItems: "center",
    marginTop: Spacing.xs,
    gap: Spacing.sm,
  },
  replyButton: {
    padding: 2,
  },
  replyPreview: {
    borderLeftWidth: 2,
    paddingLeft: Spacing.sm,
    marginBottom: Spacing.xs,
  },
  replyName: {
    fontWeight: "600",
  },
  replyText: {},
  replyBar: {
    flexDirection: "row",
    alignItems: "center",
    borderLeftWidth: 3,
    borderRadius: BorderRadius.sm,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    marginHorizontal: Spacing.md,
    marginBottom: Spacing.xs,
  },
  replyBarContent: {
    flex: 1,
    gap: 2,
  },
  replyBarClose: {
    padding: Spacing.xs,
  },
  emptyContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
    paddingTop: 100,
  },
  emptyText: {
    marginTop: Spacing.md,
  },
  emptySubtext: {
    marginTop: Spacing.xs,
  },
  inputContainer: {
    flexDirection: "row",
    alignItems: "flex-end",
    paddingHorizontal: Spacing.md,
    paddingTop: Spacing.sm,
  },
  input: {
    flex: 1,
    minHeight: 40,
    maxHeight: 100,
    borderRadius: BorderRadius.lg,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    marginRight: Spacing.sm,
    fontSize: Typography.body.fontSize,
    borderWidth: 1,
  },
  sendButton: {
    width: 40,
    height: 40,
    borderRadius: BorderRadius.full,
    justifyContent: "center",
    alignItems: "center",
  },
  recipientBar: {
    flexDirection: "row",
    alignItems: "center",
    borderLeftWidth: 3,
    borderRadius: BorderRadius.sm,
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    marginHorizontal: Spacing.md,
    marginBottom: Spacing.xs,
  },
  recipientButton: {
    width: 40,
    height: 40,
    borderRadius: BorderRadius.full,
    justifyContent: "center",
    alignItems: "center",
    marginRight: Spacing.sm,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0,0,0,0.5)",
    justifyContent: "center",
    alignItems: "center",
    padding: Spacing.lg,
  },
  modalContent: {
    width: "100%",
    maxWidth: 400,
    maxHeight: "70%",
    borderRadius: BorderRadius.lg,
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
  managerList: {
    maxHeight: 300,
  },
  managerItem: {
    flexDirection: "row",
    alignItems: "center",
    paddingVertical: Spacing.md,
    borderBottomWidth: 1,
  },
  managerAvatar: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: "center",
    alignItems: "center",
    marginRight: Spacing.md,
  },
  managerName: {
    fontSize: 16,
  },
});
