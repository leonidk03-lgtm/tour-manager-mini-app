import { createContext, useContext, useState, useEffect, useCallback, ReactNode, useRef } from 'react';
import { AppState, AppStateStatus } from 'react-native';
import { supabase } from '@/lib/supabase';
import { useAuth } from '@/contexts/AuthContext';

interface PresenceState {
  oderId: string;
  online_at: string;
  user_id: string;
  display_name: string;
}

interface PresenceContextType {
  onlineUsers: Set<string>;
  lastSeen: Record<string, string>;
  isOnline: (userId: string) => boolean;
  getLastSeen: (userId: string) => string | null;
  getLastSeenText: (userId: string) => string | null;
  onlineCount: number;
  totalCount: number;
}

const PresenceContext = createContext<PresenceContextType | undefined>(undefined);

export function PresenceProvider({ children }: { children: ReactNode }) {
  const { profile, managers } = useAuth();
  const [onlineUsers, setOnlineUsers] = useState<Set<string>>(new Set());
  const [lastSeen, setLastSeen] = useState<Record<string, string>>({});
  const channelRef = useRef<ReturnType<typeof supabase.channel> | null>(null);

  const updateLastSeen = useCallback(async () => {
    if (!profile?.id || !supabase) return;
    
    try {
      await supabase
        .from('profiles')
        .update({ last_seen: new Date().toISOString() })
        .eq('id', profile.id);
    } catch (error) {
      console.error('Error updating last_seen:', error);
    }
  }, [profile?.id]);

  const fetchLastSeenForUsers = useCallback(async () => {
    if (managers.length === 0 || !supabase) return;
    
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('id, last_seen')
        .in('id', managers.map(m => m.id));
      
      if (!error && data) {
        const newLastSeen: Record<string, string> = {};
        data.forEach(item => {
          if (item.last_seen) {
            newLastSeen[item.id] = item.last_seen;
          }
        });
        setLastSeen(newLastSeen);
      }
    } catch (error) {
      console.error('Error fetching last_seen:', error);
    }
  }, [managers]);

  useEffect(() => {
    if (!profile?.id || !supabase) return;

    const channel = supabase.channel('online-users', {
      config: {
        presence: {
          key: profile.id,
        },
      },
    });

    channel
      .on('presence', { event: 'sync' }, () => {
        const state = channel.presenceState();
        const online = new Set<string>();
        
        Object.keys(state).forEach(key => {
          online.add(key);
        });
        
        setOnlineUsers(online);
      })
      .on('presence', { event: 'join' }, ({ key }) => {
        setOnlineUsers(prev => new Set([...prev, key]));
      })
      .on('presence', { event: 'leave' }, ({ key }) => {
        setOnlineUsers(prev => {
          const next = new Set(prev);
          next.delete(key);
          return next;
        });
        fetchLastSeenForUsers();
      })
      .subscribe(async (status) => {
        if (status === 'SUBSCRIBED') {
          await channel.track({
            user_id: profile.id,
            display_name: profile.display_name || '',
            online_at: new Date().toISOString(),
          });
          updateLastSeen();
        }
      });

    channelRef.current = channel;

    return () => {
      if (channelRef.current && supabase) {
        supabase.removeChannel(channelRef.current);
      }
    };
  }, [profile?.id, profile?.display_name, updateLastSeen, fetchLastSeenForUsers]);

  useEffect(() => {
    fetchLastSeenForUsers();
  }, [managers, fetchLastSeenForUsers]);

  useEffect(() => {
    const handleAppStateChange = (nextAppState: AppStateStatus) => {
      if (nextAppState === 'active' && profile?.id && channelRef.current) {
        channelRef.current.track({
          user_id: profile.id,
          display_name: profile.display_name || '',
          online_at: new Date().toISOString(),
        });
      } else if (nextAppState === 'background' || nextAppState === 'inactive') {
        updateLastSeen();
      }
    };

    const subscription = AppState.addEventListener('change', handleAppStateChange);
    return () => subscription.remove();
  }, [profile?.id, profile?.display_name, updateLastSeen]);

  useEffect(() => {
    if (!profile?.id) return;
    
    const interval = setInterval(() => {
      updateLastSeen();
    }, 60000);

    return () => clearInterval(interval);
  }, [profile?.id, updateLastSeen]);

  const isOnline = useCallback((userId: string): boolean => {
    return onlineUsers.has(userId);
  }, [onlineUsers]);

  const getLastSeen = useCallback((userId: string): string | null => {
    return lastSeen[userId] || null;
  }, [lastSeen]);

  const getLastSeenText = useCallback((userId: string): string | null => {
    if (onlineUsers.has(userId)) return null;
    
    const lastSeenTime = lastSeen[userId];
    if (!lastSeenTime) return null;
    
    const now = new Date();
    const seen = new Date(lastSeenTime);
    const diffMs = now.getTime() - seen.getTime();
    const diffMinutes = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMs / 3600000);
    const diffDays = Math.floor(diffMs / 86400000);
    
    if (diffMinutes < 1) return 'только что';
    if (diffMinutes < 60) return `${diffMinutes} мин назад`;
    if (diffHours < 24) return `${diffHours} ч назад`;
    if (diffDays < 7) return `${diffDays} д назад`;
    
    return seen.toLocaleDateString('ru-RU', { day: 'numeric', month: 'short' });
  }, [onlineUsers, lastSeen]);

  const onlineCount = onlineUsers.size;
  const totalCount = managers.length;

  return (
    <PresenceContext.Provider value={{
      onlineUsers,
      lastSeen,
      isOnline,
      getLastSeen,
      getLastSeenText,
      onlineCount,
      totalCount,
    }}>
      {children}
    </PresenceContext.Provider>
  );
}

export function usePresence() {
  const context = useContext(PresenceContext);
  if (context === undefined) {
    throw new Error('usePresence must be used within a PresenceProvider');
  }
  return context;
}
