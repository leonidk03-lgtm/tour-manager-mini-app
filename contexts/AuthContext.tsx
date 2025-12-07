import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { supabase, Profile, UserRole, initSupabaseFromStorage } from '@/lib/supabase';
import { Session, User } from '@supabase/supabase-js';

interface AuthContextType {
  session: Session | null;
  user: User | null;
  profile: Profile | null;
  isLoading: boolean;
  isAdmin: boolean;
  isRadioDispatcher: boolean;
  signIn: (email: string, password: string) => Promise<{ error: string | null }>;
  signOut: () => Promise<void>;
  createManager: (email: string, password: string, displayName: string, role?: UserRole) => Promise<{ error: string | null }>;
  updateManagerStatus: (managerId: string, isActive: boolean) => Promise<{ error: string | null }>;
  updateManagerRole: (managerId: string, role: UserRole) => Promise<{ error: string | null }>;
  deleteManager: (managerId: string) => Promise<{ error: string | null }>;
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

  useEffect(() => {
    const initAuth = async () => {
      await initSupabaseFromStorage();
      
      const { data: { session } } = await supabase.auth.getSession();
      setSession(session);
      setUser(session?.user ?? null);
      if (session?.user) {
        fetchProfile(session.user.id);
      } else {
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

  const fetchProfile = async (userId: string) => {
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single();

      if (error) {
        console.error('Error fetching profile:', error);
        setProfile(null);
      } else {
        setProfile(data as Profile);
        if (data?.role === 'admin') {
          refreshManagers();
        }
      }
    } catch (err) {
      console.error('Error fetching profile:', err);
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
        return { error: error.message };
      }

      if (data.user) {
        const { error: profileError } = await supabase
          .from('profiles')
          .upsert({
            id: data.user.id,
            email,
            display_name: displayName,
            role,
            is_active: true,
          });

        if (profileError) {
          return { error: profileError.message };
        }

        await refreshManagers();
      }

      return { error: null };
    } catch (err) {
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
        .eq('id', managerId);

      if (error) {
        return { error: error.message };
      }

      await refreshManagers();
      return { error: null };
    } catch (err) {
      return { error: 'Ошибка при обновлении роли' };
    }
  };

  const deleteManager = async (managerId: string): Promise<{ error: string | null }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может удалять менеджеров' };
    }

    try {
      const { error } = await supabase
        .from('profiles')
        .update({ is_active: false, updated_at: new Date().toISOString() })
        .eq('id', managerId);

      if (error) {
        return { error: error.message };
      }

      await refreshManagers();
      return { error: null };
    } catch (err) {
      return { error: 'Ошибка при удалении менеджера' };
    }
  };

  const refreshManagers = async () => {
    if (!isAdmin && profile?.role !== 'admin') return;

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

  return (
    <AuthContext.Provider
      value={{
        session,
        user,
        profile,
        isLoading,
        isAdmin,
        isRadioDispatcher,
        signIn,
        signOut,
        createManager,
        updateManagerStatus,
        updateManagerRole,
        deleteManager,
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
