import { createContext, useContext, useState, useEffect, ReactNode, useCallback } from 'react';
import { supabase, Profile, UserRole, initSupabaseFromStorage, PermissionKey, ManagerPermissions, DashboardConfig } from '@/lib/supabase';
import { Session, User } from '@supabase/supabase-js';

interface AuthContextType {
  session: Session | null;
  user: User | null;
  profile: Profile | null;
  isLoading: boolean;
  isAdmin: boolean;
  isRadioDispatcher: boolean;
  hasPermission: (key: PermissionKey) => boolean;
  signIn: (email: string, password: string) => Promise<{ error: string | null }>;
  signOut: () => Promise<void>;
  createManager: (email: string, password: string, displayName: string, role?: UserRole) => Promise<{ error: string | null }>;
  updateManagerStatus: (managerId: string, isActive: boolean) => Promise<{ error: string | null }>;
  updateManagerRole: (managerId: string, role: UserRole) => Promise<{ error: string | null }>;
  deleteManager: (managerId: string) => Promise<{ error: string | null }>;
  updateOwnProfile: (data: { password?: string; displayName?: string }) => Promise<{ error: string | null }>;
  sendPasswordReset: (email: string) => Promise<{ error: string | null }>;
  updateManagerDisplayName: (managerId: string, displayName: string) => Promise<{ error: string | null }>;
  updateManagerPermissions: (managerId: string, permissions: ManagerPermissions) => Promise<{ error: string | null }>;
  updateManagerCommissions: (managerId: string, ownerPercent: number, executorPercent: number, servicePercent?: number) => Promise<{ error: string | null }>;
  updateDashboardConfig: (config: DashboardConfig) => Promise<{ error: string | null }>;
  managers: Profile[];
  refreshManagers: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export function AuthProvider({ children }: { children: ReactNode }) {
  const [session, setSession] = useState<Session | null>(null);
  const [user, setUser] = useState<User | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [managers, setManagers] = useState<Profile[]>([]);

  const isAdmin = profile?.role === 'admin';
  const isRadioDispatcher = profile?.role === 'radio_dispatcher';

  const hasPermission = useCallback((key: PermissionKey): boolean => {
    if (isAdmin) return true;
    if (!profile?.permissions) return false;
    return profile.permissions[key] === true;
  }, [profile, isAdmin]);

  useEffect(() => {
    const initAuth = async () => {
      try {
        await initSupabaseFromStorage();
        
        const timeoutPromise = new Promise<never>((_, reject) => 
          setTimeout(() => reject(new Error('Session timeout')), 10000)
        );
        
        const { data: { session } } = await Promise.race([
          supabase.auth.getSession(),
          timeoutPromise
        ]);
        
        setSession(session);
        setUser(session?.user ?? null);
        if (session?.user) {
          fetchProfile(session.user.id);
        } else {
          setIsLoading(false);
        }
      } catch (err) {
        console.error('Auth initialization error:', err);
        setIsLoading(false);
      }
    };

    initAuth();

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      setSession(session);
      setUser(session?.user ?? null);
      if (session?.user) {
        fetchProfile(session.user.id);
      } else {
        setProfile(null);
        setIsLoading(false);
      }
    });

    return () => subscription.unsubscribe();
  }, []);

  // Subscribe to profile changes in realtime (for permissions updates)
  useEffect(() => {
    if (!user) return;

    const channel = supabase
      .channel('profile-changes')
      .on(
        'postgres_changes',
        {
          event: 'UPDATE',
          schema: 'public',
          table: 'profiles',
          filter: `id=eq.${user.id}`,
        },
        (payload) => {
          console.log('[Auth] Profile updated via realtime:', payload.new);
          setProfile(payload.new as Profile);
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [user]);

  const fetchProfile = async (userId: string) => {
    const timeoutPromise = new Promise<never>((_, reject) => 
      setTimeout(() => reject(new Error('Timeout')), 10000)
    );
    
    try {
      const fetchPromise = supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single();

      const { data, error } = await Promise.race([fetchPromise, timeoutPromise]);

      if (error) {
        console.error('Error fetching profile:', error.message || 'Unknown error');
        setProfile(null);
      } else {
        setProfile(data as Profile);
        refreshManagers();
      }
    } catch (err) {
      console.error('Error fetching profile (timeout or network):', err);
      setProfile(null);
    } finally {
      setIsLoading(false);
    }
  };

  const signIn = async (emailOrUsername: string, password: string): Promise<{ error: string | null }> => {
    try {
      const email = emailOrUsername.includes('@') 
        ? emailOrUsername 
        : `${emailOrUsername}@tourmanager.local`;
      
      const { error } = await supabase.auth.signInWithPassword({
        email,
        password,
      });

      if (error) {
        return { error: error.message };
      }

      return { error: null };
    } catch (err) {
      return { error: 'Ошибка подключения' };
    }
  };

  const signOut = async () => {
    await supabase.auth.signOut();
    setProfile(null);
    setManagers([]);
  };

  const createManager = async (
    email: string,
    password: string,
    displayName: string,
    role: UserRole = 'manager'
  ): Promise<{ error: string | null }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может создавать менеджеров' };
    }

    try {
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: {
            display_name: displayName,
            role,
          },
        },
      });

      if (error) {
        console.error('Auth signUp error:', error);
        return { error: error.message };
      }

      if (data.user) {
        const profileData = {
          id: data.user.id,
          email,
          display_name: displayName,
          role,
          is_active: true,
        };
        
        const { error: profileError } = await supabase
          .from('profiles')
          .upsert(profileData);

        if (profileError) {
          console.error('Profile upsert error:', profileError);
          return { error: profileError.message };
        }

        await refreshManagers();
      }

      return { error: null };
    } catch (err) {
      console.error('Create manager exception:', err);
      return { error: 'Ошибка при создании менеджера' };
    }
  };

  const updateManagerStatus = async (
    managerId: string,
    isActive: boolean
  ): Promise<{ error: string | null }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может изменять статус' };
    }

    try {
      const { error } = await supabase
        .from('profiles')
        .update({ is_active: isActive, updated_at: new Date().toISOString() })
        .eq('id', managerId);

      if (error) {
        return { error: error.message };
      }

      await refreshManagers();
      return { error: null };
    } catch (err) {
      return { error: 'Ошибка при обновлении статуса' };
    }
  };

  const updateManagerRole = async (
    managerId: string,
    role: UserRole
  ): Promise<{ error: string | null }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может изменять роль' };
    }

    try {
      const { error } = await supabase
        .from('profiles')
        .update({ role, updated_at: new Date().toISOString() })
        .eq('id', managerId)
        .select();

      if (error) {
        console.error('Update role error:', error);
        return { error: error.message };
      }

      await refreshManagers();
      return { error: null };
    } catch (err) {
      console.error('Update role exception:', err);
      return { error: 'Ошибка при обновлении роли' };
    }
  };

  const deleteManager = async (managerId: string): Promise<{ error: string | null }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может удалять менеджеров' };
    }

    try {
      const { error } = await supabase.rpc('delete_manager_completely', {
        manager_id: managerId
      });

      if (error) {
        return { error: error.message };
      }

      await refreshManagers();
      return { error: null };
    } catch (err) {
      return { error: 'Ошибка при удалении менеджера' };
    }
  };

  const updateOwnProfile = async (data: { password?: string; displayName?: string }): Promise<{ error: string | null }> => {
    if (!user) {
      return { error: 'Пользователь не авторизован' };
    }

    try {
      if (data.password) {
        const { error } = await supabase.auth.updateUser({ password: data.password });
        if (error) {
          return { error: error.message };
        }
      }

      if (data.displayName) {
        const { error } = await supabase
          .from('profiles')
          .update({ display_name: data.displayName, updated_at: new Date().toISOString() })
          .eq('id', user.id);

        if (error) {
          return { error: error.message };
        }
        await fetchProfile(user.id);
      }

      return { error: null };
    } catch (err) {
      return { error: 'Ошибка при обновлении профиля' };
    }
  };

  const sendPasswordReset = async (email: string): Promise<{ error: string | null }> => {
    try {
      const { error } = await supabase.auth.resetPasswordForEmail(email, {
        redirectTo: 'https://tourmanager.app/reset-password',
      });

      if (error) {
        return { error: error.message };
      }

      return { error: null };
    } catch (err) {
      return { error: 'Ошибка при отправке ссылки сброса пароля' };
    }
  };

  const updateManagerDisplayName = async (managerId: string, displayName: string): Promise<{ error: string | null }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может изменять имя менеджера' };
    }

    try {
      const { error } = await supabase
        .from('profiles')
        .update({ display_name: displayName, updated_at: new Date().toISOString() })
        .eq('id', managerId);

      if (error) {
        return { error: error.message };
      }

      await refreshManagers();
      return { error: null };
    } catch (err) {
      return { error: 'Ошибка при обновлении имени' };
    }
  };

  const refreshManagers = async () => {
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('*')
        .order('created_at', { ascending: false });

      if (!error && data) {
        setManagers(data as Profile[]);
      }
    } catch (err) {
      console.error('Error fetching managers:', err);
    }
  };

  const updateManagerPermissions = async (
    managerId: string,
    permissions: ManagerPermissions
  ): Promise<{ error: string | null }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может изменять права доступа' };
    }

    try {
      const { error } = await supabase
        .from('profiles')
        .update({ permissions, updated_at: new Date().toISOString() })
        .eq('id', managerId);

      if (error) {
        return { error: error.message };
      }

      await refreshManagers();
      return { error: null };
    } catch (err) {
      return { error: 'Ошибка при обновлении прав доступа' };
    }
  };

  const updateManagerCommissions = async (
    managerId: string,
    ownerPercent: number,
    executorPercent: number,
    servicePercent?: number
  ): Promise<{ error: string | null }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может изменять комиссии' };
    }

    try {
      const updateData: Record<string, unknown> = {
        owner_commission_percent: ownerPercent,
        executor_commission_percent: executorPercent,
        updated_at: new Date().toISOString()
      };
      if (servicePercent !== undefined) {
        updateData.service_commission_percent = servicePercent;
      }

      const { error } = await supabase
        .from('profiles')
        .update(updateData)
        .eq('id', managerId);

      if (error) {
        return { error: error.message };
      }

      await refreshManagers();
      return { error: null };
    } catch (err) {
      return { error: 'Ошибка при обновлении комиссий' };
    }
  };

  const updateDashboardConfig = async (config: DashboardConfig): Promise<{ error: string | null }> => {
    if (!user) {
      return { error: 'Пользователь не авторизован' };
    }

    try {
      const { error } = await supabase
        .from('profiles')
        .update({ 
          dashboard_config: config,
          updated_at: new Date().toISOString() 
        })
        .eq('id', user.id);

      if (error) {
        return { error: error.message };
      }

      setProfile(prev => prev ? { ...prev, dashboard_config: config } : prev);
      return { error: null };
    } catch (err) {
      return { error: 'Ошибка при сохранении настроек дашборда' };
    }
  };

  return (
    <AuthContext.Provider
      value={{
        session,
        user,
        profile,
        isLoading,
        isAdmin,
        isRadioDispatcher,
        hasPermission,
        signIn,
        signOut,
        createManager,
        updateManagerStatus,
        updateManagerRole,
        deleteManager,
        updateOwnProfile,
        sendPasswordReset,
        updateManagerDisplayName,
        updateManagerPermissions,
        updateManagerCommissions,
        updateDashboardConfig,
        managers,
        refreshManagers,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
}
