import React, { createContext, useContext, useState, useEffect, useCallback } from 'react';
import { supabase } from '@/lib/supabase';

export interface TelegramContact {
  id: string;
  phone: string;
  telegramChatId: number | null;
  telegramUsername: string | null;
  contactName: string | null;
  contactType: 'client' | 'guide' | 'manager';
  isVerified: boolean;
  notificationsEnabled: boolean;
  createdAt: string;
  updatedAt: string;
}

export interface NotificationLog {
  id: string;
  recipientPhone: string | null;
  telegramChatId: number | null;
  notificationType: string;
  recipientType: string;
  rentalOrderId: string | null;
  equipmentBlockIndex: number | null;
  messageText: string | null;
  status: 'pending' | 'sent' | 'failed' | 'delivered' | 'read';
  errorMessage: string | null;
  telegramMessageId: number | null;
  sentAt: string | null;
  createdAt: string;
}

export interface NotificationSettings {
  id: string;
  telegramBotToken: string | null;
  defaultMessageTemplates: Record<string, string>;
  reminderDaysBefore: number;
  notificationsEnabled: boolean;
}

export interface SendNotificationParams {
  recipientPhone?: string;
  telegramChatId?: number;
  notificationType: 'order_issued' | 'order_returned' | 'bag_issued' | 'reminder' | 'order_cancelled';
  recipientType: 'client' | 'guide' | 'manager';
  rentalOrderId?: string;
  equipmentBlockIndex?: number;
  messageText: string;
}

interface NotificationContextType {
  telegramContacts: TelegramContact[];
  notificationLogs: NotificationLog[];
  notificationSettings: NotificationSettings | null;
  isLoading: boolean;
  tablesAvailable: boolean;
  initError: string | null;
  addTelegramContact: (contact: Omit<TelegramContact, 'id' | 'createdAt' | 'updatedAt'>) => Promise<string>;
  updateTelegramContact: (id: string, updates: Partial<TelegramContact>) => Promise<void>;
  deleteTelegramContact: (id: string) => Promise<void>;
  getContactByPhone: (phone: string) => TelegramContact | undefined;
  sendNotification: (params: SendNotificationParams) => Promise<boolean>;
  updateNotificationSettings: (settings: Partial<NotificationSettings>) => Promise<void>;
  refreshData: () => Promise<void>;
}

const NotificationContext = createContext<NotificationContextType | undefined>(undefined);

const snakeToCamel = (str: string): string => {
  return str.replace(/_([a-z])/g, (_, letter) => letter.toUpperCase());
};

const camelToSnake = (str: string): string => {
  return str.replace(/[A-Z]/g, (letter) => `_${letter.toLowerCase()}`);
};

const transformContactFromDB = (row: any): TelegramContact => ({
  id: row.id,
  phone: row.phone,
  telegramChatId: row.telegram_chat_id,
  telegramUsername: row.telegram_username,
  contactName: row.contact_name,
  contactType: row.contact_type || 'client',
  isVerified: row.is_verified || false,
  notificationsEnabled: row.notifications_enabled !== false,
  createdAt: row.created_at,
  updatedAt: row.updated_at,
});

const transformLogFromDB = (row: any): NotificationLog => ({
  id: row.id,
  recipientPhone: row.recipient_phone,
  telegramChatId: row.telegram_chat_id,
  notificationType: row.notification_type,
  recipientType: row.recipient_type,
  rentalOrderId: row.rental_order_id,
  equipmentBlockIndex: row.equipment_block_index,
  messageText: row.message_text,
  status: row.status || 'pending',
  errorMessage: row.error_message,
  telegramMessageId: row.telegram_message_id,
  sentAt: row.sent_at,
  createdAt: row.created_at,
});

const transformSettingsFromDB = (row: any): NotificationSettings => ({
  id: row.id,
  telegramBotToken: row.telegram_bot_token,
  defaultMessageTemplates: row.default_message_templates || {},
  reminderDaysBefore: row.reminder_days_before || 2,
  notificationsEnabled: row.notifications_enabled !== false,
});

export function NotificationProvider({ children }: { children: React.ReactNode }) {
  const [telegramContacts, setTelegramContacts] = useState<TelegramContact[]>([]);
  const [notificationLogs, setNotificationLogs] = useState<NotificationLog[]>([]);
  const [notificationSettings, setNotificationSettings] = useState<NotificationSettings | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [tablesAvailable, setTablesAvailable] = useState(true);
  const [initError, setInitError] = useState<string | null>(null);

  const fetchTelegramContacts = useCallback(async (): Promise<boolean> => {
    if (!supabase) return false;
    const { data, error } = await supabase
      .from('telegram_contacts')
      .select('*')
      .order('created_at', { ascending: false });

    if (error) {
      console.error('Error fetching telegram contacts:', error);
      if (error.code === 'PGRST205') {
        return false; // Table not in schema cache
      }
      return true; // Other error, table might exist
    }

    setTelegramContacts((data || []).map(transformContactFromDB));
    return true;
  }, []);

  const fetchNotificationLogs = useCallback(async (): Promise<boolean> => {
    if (!supabase) return false;
    const { data, error } = await supabase
      .from('notification_logs')
      .select('*')
      .order('created_at', { ascending: false })
      .limit(100);

    if (error) {
      console.error('Error fetching notification logs:', error);
      if (error.code === 'PGRST205') {
        return false;
      }
      return true;
    }

    setNotificationLogs((data || []).map(transformLogFromDB));
    return true;
  }, []);

  const fetchNotificationSettings = useCallback(async () => {
    if (!supabase) return;
    const { data, error } = await supabase
      .from('notification_settings')
      .select('*')
      .single();

    if (error && error.code !== 'PGRST116') {
      console.error('Error fetching notification settings:', error);
      return;
    }

    if (data) {
      setNotificationSettings(transformSettingsFromDB(data));
    }
  }, []);

  const refreshData = useCallback(async () => {
    setIsLoading(true);
    setInitError(null);
    
    const [contactsAvailable, logsAvailable] = await Promise.all([
      fetchTelegramContacts(),
      fetchNotificationLogs(),
      fetchNotificationSettings(),
    ]);
    
    const available = contactsAvailable !== false && logsAvailable !== false;
    setTablesAvailable(available);
    
    if (!available) {
      setInitError('Таблицы уведомлений недоступны. Выполните обновление схемы Supabase.');
      console.warn('Notification tables not available in Supabase schema cache. Run schema refresh.');
    }
    
    setIsLoading(false);
  }, [fetchTelegramContacts, fetchNotificationLogs, fetchNotificationSettings]);

  useEffect(() => {
    refreshData();
  }, [refreshData]);

  const addTelegramContact = async (contact: Omit<TelegramContact, 'id' | 'createdAt' | 'updatedAt'>): Promise<string> => {
    if (!supabase) throw new Error('Supabase not initialized');
    const { data, error } = await supabase
      .from('telegram_contacts')
      .insert({
        phone: contact.phone,
        telegram_chat_id: contact.telegramChatId,
        telegram_username: contact.telegramUsername,
        contact_name: contact.contactName,
        contact_type: contact.contactType,
        is_verified: contact.isVerified,
        notifications_enabled: contact.notificationsEnabled,
      })
      .select()
      .single();

    if (error) throw error;
    await fetchTelegramContacts();
    return data.id;
  };

  const updateTelegramContact = async (id: string, updates: Partial<TelegramContact>): Promise<void> => {
    if (!supabase) throw new Error('Supabase not initialized');
    const dbUpdates: any = {};
    if (updates.phone !== undefined) dbUpdates.phone = updates.phone;
    if (updates.telegramChatId !== undefined) dbUpdates.telegram_chat_id = updates.telegramChatId;
    if (updates.telegramUsername !== undefined) dbUpdates.telegram_username = updates.telegramUsername;
    if (updates.contactName !== undefined) dbUpdates.contact_name = updates.contactName;
    if (updates.contactType !== undefined) dbUpdates.contact_type = updates.contactType;
    if (updates.isVerified !== undefined) dbUpdates.is_verified = updates.isVerified;
    if (updates.notificationsEnabled !== undefined) dbUpdates.notifications_enabled = updates.notificationsEnabled;
    dbUpdates.updated_at = new Date().toISOString();

    const { error } = await supabase
      .from('telegram_contacts')
      .update(dbUpdates)
      .eq('id', id);

    if (error) throw error;
    await fetchTelegramContacts();
  };

  const deleteTelegramContact = async (id: string): Promise<void> => {
    if (!supabase) throw new Error('Supabase not initialized');
    const { error } = await supabase
      .from('telegram_contacts')
      .delete()
      .eq('id', id);

    if (error) throw error;
    await fetchTelegramContacts();
  };

  const getContactByPhone = (phone: string): TelegramContact | undefined => {
    const normalized = phone.replace(/\D/g, '');
    return telegramContacts.find(c => c.phone.replace(/\D/g, '') === normalized);
  };

  const sendNotification = async (params: SendNotificationParams): Promise<boolean> => {
    if (!notificationSettings?.notificationsEnabled) {
      console.log('[Notifications] Notifications are disabled');
      return false;
    }

    const logEntry = {
      recipient_phone: params.recipientPhone || null,
      telegram_chat_id: params.telegramChatId || null,
      notification_type: params.notificationType,
      recipient_type: params.recipientType,
      rental_order_id: params.rentalOrderId || null,
      equipment_block_index: params.equipmentBlockIndex || null,
      message_text: params.messageText,
      status: 'pending',
    };

    if (!supabase) return false;
    const { data: logData, error: logError } = await supabase
      .from('notification_logs')
      .insert(logEntry)
      .select()
      .single();

    if (logError) {
      console.error('Error creating notification log:', logError);
      return false;
    }

    // TODO: Call Supabase Edge Function to send Telegram message
    console.log('[Notifications] Would send notification:', params.messageText);
    
    // For now, just mark as sent (simulation)
    const { error: updateError } = await supabase
      .from('notification_logs')
      .update({ 
        status: 'sent',
        sent_at: new Date().toISOString()
      })
      .eq('id', logData.id);

    if (updateError) {
      console.error('Error updating notification log:', updateError);
    }

    await fetchNotificationLogs();
    return true;
  };

  const updateNotificationSettings = async (settings: Partial<NotificationSettings>): Promise<void> => {
    if (!supabase) throw new Error('Supabase not initialized');
    const dbUpdates: any = {};
    if (settings.telegramBotToken !== undefined) dbUpdates.telegram_bot_token = settings.telegramBotToken;
    if (settings.defaultMessageTemplates !== undefined) dbUpdates.default_message_templates = settings.defaultMessageTemplates;
    if (settings.reminderDaysBefore !== undefined) dbUpdates.reminder_days_before = settings.reminderDaysBefore;
    if (settings.notificationsEnabled !== undefined) dbUpdates.notifications_enabled = settings.notificationsEnabled;
    dbUpdates.updated_at = new Date().toISOString();

    const settingsId = notificationSettings?.id || '00000000-0000-0000-0000-000000000001';

    const { error } = await supabase
      .from('notification_settings')
      .update(dbUpdates)
      .eq('id', settingsId);

    if (error) throw error;
    await fetchNotificationSettings();
  };

  return (
    <NotificationContext.Provider
      value={{
        telegramContacts,
        notificationLogs,
        notificationSettings,
        isLoading,
        tablesAvailable,
        initError,
        addTelegramContact,
        updateTelegramContact,
        deleteTelegramContact,
        getContactByPhone,
        sendNotification,
        updateNotificationSettings,
        refreshData,
      }}
    >
      {children}
    </NotificationContext.Provider>
  );
}

export function useNotifications() {
  const context = useContext(NotificationContext);
  if (!context) {
    throw new Error('useNotifications must be used within a NotificationProvider');
  }
  return context;
}
