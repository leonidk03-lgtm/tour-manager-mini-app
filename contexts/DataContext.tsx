import React, { createContext, useContext, useState, useEffect, ReactNode, useCallback, useRef } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "./AuthContext";
import { saveToCache, loadAllFromCache } from "@/utils/cache";

// Helper function to retry failed requests
async function withRetry<T>(
  fn: () => Promise<T>,
  retries: number = 2,
  delay: number = 1000
): Promise<T> {
  try {
    return await fn();
  } catch (error) {
    if (retries > 0 && error instanceof TypeError && error.message.includes('Network')) {
      await new Promise(resolve => setTimeout(resolve, delay));
      return withRetry(fn, retries - 1, delay * 2);
    }
    throw error;
  }
}

export interface TourType {
  id: string;
  name: string;
  fullPrice: number;
  discountedPrice: number;
  articleNumber: string;
  isEnabled: boolean;
  applicableServiceIds: string[];
  hasRadioGuides: boolean;
}

export interface AdditionalService {
  id: string;
  name: string;
  price: number;
  isEnabled: boolean;
}

export interface Expense {
  id: string;
  type: string;
  amount: number;
  description: string;
}

export interface Excursion {
  id: string;
  tourTypeId: string;
  date: string;
  time: string;
  fullPriceCount: number;
  discountedCount: number;
  freeCount: number;
  tourPackageCount: number;
  byTourCount: number;
  paidCount: number;
  expenses: Expense[];
  additionalServices: { serviceId: string; count: number }[];
  managerId?: string;
  managerName?: string;
}

export interface Transaction {
  id: string;
  type: "income" | "expense";
  amount: number;
  description: string;
  date: string;
  managerId?: string;
  managerName?: string;
}

export interface Manager {
  id: string;
  name: string;
  email: string;
  isActive: boolean;
}

export interface Activity {
  id: string;
  type: "excursion_added" | "transaction_added" | "excursion_deleted" | "transaction_deleted" | "radio_issued" | "radio_returned";
  managerName: string;
  description: string;
  date: string;
  timestamp: string;
}

export interface DeletedItem {
  id: string;
  type: "excursion" | "transaction" | "excursion_note" | "excursion_note_expired" | "dispatching_note" | "radio_guide_kit" | "equipment_loss";
  data: Excursion | Transaction | ExcursionNote | DispatchingNote | RadioGuideKit | EquipmentLoss;
  deletedAt: string;
}

export type RadioGuideKitStatus = 'available' | 'issued' | 'maintenance';

export interface RadioGuideKit {
  id: string;
  bagNumber: number;
  status: RadioGuideKitStatus;
  notes: string | null;
}

export interface RadioGuideAssignment {
  id: string;
  kitId: string;
  excursionId: string | null;
  guideName: string;
  busNumber: string | null;
  receiversIssued: number;
  receiversReturned: number | null;
  issuedAt: string;
  returnedAt: string | null;
  returnNotes: string | null;
  managerId: string;
  managerName: string;
}

export type EquipmentLossStatus = 'lost' | 'found';

export interface DispatchingNote {
  id: string;
  text: string;
  createdAt: string;
  updatedAt: string;
  managerId: string;
  linkedExcursionId?: string | null;
}

export interface ExcursionNote {
  id: string;
  excursionId: string;
  text: string;
  createdAt: string;
  updatedAt: string;
  managerId: string;
  managerName: string;
}

export interface EquipmentLoss {
  id: string;
  assignmentId: string;
  kitId: string;
  guideName: string;
  missingCount: number;
  reason: string;
  status: EquipmentLossStatus;
  foundAt: string | null;
  foundNotes: string | null;
  createdAt: string;
  managerId: string;
  managerName: string;
  bagNumber?: number;
}

export interface ChatMessage {
  id: string;
  senderId: string;
  senderName: string;
  message: string;
  createdAt: string;
}

export type NotificationType = 'chat' | 'excursion' | 'transaction';

export interface AppNotification {
  id: string;
  userId: string;
  type: NotificationType;
  title: string;
  body: string | null;
  data: Record<string, unknown>;
  isRead: boolean;
  createdAt: string;
}

export interface NotificationSettings {
  chatEnabled: boolean;
  excursionsEnabled: boolean;
  transactionsEnabled: boolean;
}

interface DataContextType {
  tourTypes: TourType[];
  addTourType: (tourType: Omit<TourType, 'id'>) => Promise<void>;
  updateTourType: (id: string, tourType: Partial<TourType>) => Promise<void>;
  deleteTourType: (id: string) => Promise<void>;
  additionalServices: AdditionalService[];
  addAdditionalService: (service: Omit<AdditionalService, 'id'>) => Promise<void>;
  updateAdditionalService: (id: string, service: Partial<AdditionalService>) => Promise<void>;
  deleteAdditionalService: (id: string) => Promise<void>;
  excursions: Excursion[];
  addExcursion: (excursion: Omit<Excursion, 'id' | 'managerId' | 'managerName'>) => Promise<void>;
  updateExcursion: (id: string, excursion: Partial<Excursion>) => Promise<void>;
  deleteExcursion: (id: string) => Promise<void>;
  transactions: Transaction[];
  addTransaction: (transaction: Omit<Transaction, 'id' | 'managerId' | 'managerName'>) => Promise<void>;
  deleteTransaction: (id: string) => Promise<void>;
  managers: Manager[];
  currentUser: { role: "admin" | "manager"; name: string; id: string } | null;
  activities: Activity[];
  deletedItems: DeletedItem[];
  restoreDeletedItem: (id: string) => Promise<void>;
  permanentlyDeleteItem: (id: string) => Promise<void>;
  clearDeletedItems: () => Promise<void>;
  radioGuideKits: RadioGuideKit[];
  radioGuideAssignments: RadioGuideAssignment[];
  addRadioGuideKit: (kit: Omit<RadioGuideKit, 'id'>) => Promise<void>;
  updateRadioGuideKit: (id: string, kit: Partial<RadioGuideKit>) => Promise<void>;
  deleteRadioGuideKit: (id: string) => Promise<void>;
  issueRadioGuide: (data: { kitId: string; excursionId?: string; guideName: string; busNumber?: string; receiversIssued: number }) => Promise<void>;
  returnRadioGuide: (assignmentId: string, receiversReturned: number, notes?: string) => Promise<void>;
  getActiveAssignment: (kitId: string) => RadioGuideAssignment | undefined;
  equipmentLosses: EquipmentLoss[];
  addEquipmentLoss: (loss: Omit<EquipmentLoss, 'id' | 'createdAt' | 'foundAt' | 'foundNotes' | 'status' | 'managerId' | 'managerName'>) => Promise<void>;
  updateEquipmentLoss: (id: string, data: { reason?: string; missingCount?: number }) => Promise<void>;
  markLossAsFound: (id: string, notes?: string) => Promise<void>;
  deleteEquipmentLoss: (id: string) => Promise<void>;
  radioGuidePrice: number;
  updateRadioGuidePrice: (price: number) => Promise<void>;
  dispatchingNotes: DispatchingNote[];
  addDispatchingNote: (text: string) => Promise<void>;
  updateDispatchingNote: (id: string, text: string, linkedExcursionId?: string | null) => Promise<void>;
  linkDispatchingNoteToExcursion: (noteId: string, excursionId: string) => Promise<void>;
  deleteDispatchingNote: (id: string) => Promise<void>;
  excursionNotes: ExcursionNote[];
  addExcursionNote: (excursionId: string, text: string) => Promise<void>;
  deleteExcursionNote: (id: string) => Promise<void>;
  getExcursionNotes: (excursionId: string) => ExcursionNote[];
  chatMessages: ChatMessage[];
  sendChatMessage: (message: string) => Promise<void>;
  clearChatHistory: () => Promise<void>;
  notifications: AppNotification[];
  unreadNotificationCount: number;
  notificationSettings: NotificationSettings;
  markNotificationAsRead: (id: string) => Promise<void>;
  markAllNotificationsAsRead: () => Promise<void>;
  updateNotificationSettings: (settings: Partial<NotificationSettings>) => Promise<void>;
  addNotification: (type: NotificationType, title: string, body?: string, data?: Record<string, unknown>) => Promise<void>;
  isLoading: boolean;
  isOffline: boolean;
  networkError: string | null;
  clearNetworkError: () => void;
  refreshData: () => Promise<void>;
  refreshPriceList: () => Promise<void>;
}

const DataContext = createContext<DataContextType | undefined>(undefined);

export function DataProvider({ children }: { children: ReactNode }) {
  const { user, profile, isAdmin, managers: authManagers } = useAuth();
  
  const [tourTypes, setTourTypes] = useState<TourType[]>([]);
  const [additionalServices, setAdditionalServices] = useState<AdditionalService[]>([]);
  const [excursions, setExcursions] = useState<Excursion[]>([]);
  const [transactions, setTransactions] = useState<Transaction[]>([]);
  const [activities, setActivities] = useState<Activity[]>([]);
  const [deletedItems, setDeletedItems] = useState<DeletedItem[]>([]);
  const [radioGuideKits, setRadioGuideKits] = useState<RadioGuideKit[]>([]);
  const [radioGuideAssignments, setRadioGuideAssignments] = useState<RadioGuideAssignment[]>([]);
  const [equipmentLosses, setEquipmentLosses] = useState<EquipmentLoss[]>([]);
  const [radioGuidePrice, setRadioGuidePrice] = useState<number>(80);
  const [dispatchingNotes, setDispatchingNotes] = useState<DispatchingNote[]>([]);
  const [excursionNotes, setExcursionNotes] = useState<ExcursionNote[]>([]);
  const [chatMessages, setChatMessages] = useState<ChatMessage[]>([]);
  const [notifications, setNotifications] = useState<AppNotification[]>([]);
  const [notificationSettings, setNotificationSettings] = useState<NotificationSettings>({
    chatEnabled: true,
    excursionsEnabled: true,
    transactionsEnabled: true,
  });
  const [isLoading, setIsLoading] = useState(true);
  const [networkError, setNetworkError] = useState<string | null>(null);
  const [isOffline, setIsOffline] = useState(false);
  const cacheLoadedRef = useRef(false);

  const clearNetworkError = useCallback(() => {
    setNetworkError(null);
  }, []);

  // Centralized fetch wrapper that manages offline state and clears errors on success
  const safeFetch = useCallback(async <T,>(fetchFn: () => Promise<T>): Promise<T | null> => {
    try {
      const result = await fetchFn();
      setIsOffline(false);
      setNetworkError(null);
      return result;
    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : '';
      if (errorMessage.includes('Network') || errorMessage.includes('fetch') || errorMessage.includes('Failed to fetch')) {
        setIsOffline(true);
      }
      console.error('Fetch error:', err);
      return null;
    }
  }, []);

  // Load cached data on app start
  useEffect(() => {
    if (cacheLoadedRef.current) return;
    cacheLoadedRef.current = true;

    loadAllFromCache().then((cached) => {
      if (cached) {
        if (cached.tourTypes) setTourTypes(cached.tourTypes as TourType[]);
        if (cached.additionalServices) setAdditionalServices(cached.additionalServices as AdditionalService[]);
        if (cached.excursions) setExcursions(cached.excursions as Excursion[]);
        if (cached.transactions) setTransactions(cached.transactions as Transaction[]);
        if (cached.activities) setActivities(cached.activities as Activity[]);
        if (cached.deletedItems) setDeletedItems(cached.deletedItems as DeletedItem[]);
        if (cached.radioGuideKits) setRadioGuideKits(cached.radioGuideKits as RadioGuideKit[]);
        if (cached.radioGuideAssignments) setRadioGuideAssignments(cached.radioGuideAssignments as RadioGuideAssignment[]);
        if (cached.equipmentLosses) setEquipmentLosses(cached.equipmentLosses as EquipmentLoss[]);
        if (cached.radioGuidePrice) setRadioGuidePrice(cached.radioGuidePrice as number);
        if (cached.dispatchingNotes) setDispatchingNotes(cached.dispatchingNotes as DispatchingNote[]);
        if (cached.excursionNotes) setExcursionNotes(cached.excursionNotes as ExcursionNote[]);
      }
    });
  }, []);

  // Track if initial load is complete to avoid caching on first mount
  const initialLoadDoneRef = useRef(false);
  
  // Mark initial load complete when loading finishes
  useEffect(() => {
    if (!isLoading && !initialLoadDoneRef.current) {
      initialLoadDoneRef.current = true;
    }
  }, [isLoading]);

  // Save data to cache when it changes (after initial load)
  useEffect(() => {
    if (initialLoadDoneRef.current) saveToCache('tourTypes', tourTypes);
  }, [tourTypes]);

  useEffect(() => {
    if (initialLoadDoneRef.current) saveToCache('additionalServices', additionalServices);
  }, [additionalServices]);

  useEffect(() => {
    if (initialLoadDoneRef.current) saveToCache('excursions', excursions);
  }, [excursions]);

  useEffect(() => {
    if (initialLoadDoneRef.current) saveToCache('transactions', transactions);
  }, [transactions]);

  useEffect(() => {
    if (initialLoadDoneRef.current) saveToCache('activities', activities);
  }, [activities]);

  useEffect(() => {
    if (initialLoadDoneRef.current) saveToCache('deletedItems', deletedItems);
  }, [deletedItems]);

  useEffect(() => {
    if (initialLoadDoneRef.current) saveToCache('radioGuideKits', radioGuideKits);
  }, [radioGuideKits]);

  useEffect(() => {
    if (initialLoadDoneRef.current) saveToCache('radioGuideAssignments', radioGuideAssignments);
  }, [radioGuideAssignments]);

  useEffect(() => {
    if (initialLoadDoneRef.current) saveToCache('equipmentLosses', equipmentLosses);
  }, [equipmentLosses]);

  useEffect(() => {
    if (initialLoadDoneRef.current) saveToCache('radioGuidePrice', radioGuidePrice);
  }, [radioGuidePrice]);

  const currentUser = profile ? {
    role: profile.role as "admin" | "manager",
    name: profile.display_name,
    id: profile.id,
  } : null;

  const managers: Manager[] = authManagers.map(m => ({
    id: m.id,
    name: m.display_name,
    email: m.email,
    isActive: m.is_active,
  }));

  const fetchTourTypes = useCallback(async (): Promise<void> => {
    const { data, error } = await supabase
      .from('tour_types')
      .select('*')
      .order('article_number');

    if (error) throw error;

    setTourTypes((data || []).map(t => ({
      id: t.id,
      name: t.name,
      fullPrice: Number(t.full_price),
      discountedPrice: Number(t.discounted_price),
      articleNumber: t.article_number || '',
      isEnabled: t.is_enabled,
      applicableServiceIds: t.applicable_service_ids || [],
      hasRadioGuides: t.has_radio_guides ?? false,
    })));
  }, []);

  const fetchAdditionalServices = useCallback(async (): Promise<void> => {
    const { data, error } = await supabase
      .from('additional_services')
      .select('*')
      .order('name');

    if (error) throw error;

    setAdditionalServices((data || []).map(s => ({
      id: s.id,
      name: s.name,
      price: Number(s.price),
      isEnabled: s.is_enabled,
    })));
  }, []);

  const fetchExcursions = useCallback(async (): Promise<void> => {
    if (!user) return;

    const { data, error } = await supabase
      .from('excursions')
      .select(`
        *,
        profiles:manager_id (display_name)
      `)
      .order('event_date', { ascending: false });

    if (error) throw error;

    const mappedExcursions = (data || []).map(e => ({
      id: e.id,
      tourTypeId: e.tour_type_id || '',
      date: e.event_date,
      time: e.event_time || '',
      fullPriceCount: e.full_price_count || 0,
      discountedCount: e.discounted_count || 0,
      freeCount: e.free_count || 0,
      tourPackageCount: e.tour_package_count || 0,
      byTourCount: e.by_tour_count || 0,
      paidCount: e.paid_count || 0,
      expenses: e.expenses || [],
      additionalServices: e.additional_services || [],
      managerId: e.manager_id,
      managerName: e.profiles?.display_name || '',
    }));
    setExcursions(mappedExcursions);
  }, [user]);

  const fetchTransactions = useCallback(async (): Promise<void> => {
    if (!user) return;

    const { data, error } = await supabase
      .from('transactions')
      .select(`
        *,
        profiles:manager_id (display_name)
      `)
      .order('event_date', { ascending: false });

    if (error) throw error;

    setTransactions((data || []).map(t => ({
      id: t.id,
      type: t.type as "income" | "expense",
      amount: Number(t.amount),
      description: t.description || '',
      date: t.event_date,
      managerId: t.manager_id,
      managerName: t.profiles?.display_name || '',
    })));
  }, [user]);

  const fetchActivities = useCallback(async (): Promise<void> => {
    if (!user) return;

    const { data, error } = await supabase
      .from('activities')
      .select('*')
      .order('timestamp', { ascending: false })
      .limit(100);

    if (error) throw error;

    setActivities((data || []).map(a => ({
      id: a.id,
      type: a.type,
      managerName: a.manager_name,
      description: a.description,
      date: a.timestamp?.split('T')[0] || '',
      timestamp: a.timestamp,
    })));
  }, [user]);

  const fetchDeletedItems = useCallback(async (): Promise<void> => {
    if (!user) return;

    let query = supabase
      .from('deleted_items')
      .select('*')
      .order('deleted_at', { ascending: false });

    if (!isAdmin) {
      query = query.eq('deleted_by', user.id);
    }

    const { data, error } = await query;

    if (error) throw error;

    setDeletedItems((data || []).map(d => ({
      id: d.id,
      type: d.item_type as "excursion" | "transaction" | "excursion_note" | "excursion_note_expired" | "dispatching_note" | "radio_guide_kit" | "equipment_loss",
      data: d.item_data,
      deletedAt: d.deleted_at,
    })));
  }, [user, isAdmin]);

  const fetchRadioGuideKits = useCallback(async (): Promise<void> => {
    const { data, error } = await supabase
      .from('radio_guide_kits')
      .select('*')
      .order('bag_number');

    if (error) throw error;

    setRadioGuideKits((data || []).map(k => ({
      id: k.id,
      bagNumber: k.bag_number,
      status: k.status as RadioGuideKitStatus,
      notes: k.notes,
    })));
  }, []);

  const fetchRadioGuideAssignments = useCallback(async (): Promise<void> => {
    const { data, error } = await supabase
      .from('radio_guide_assignments')
      .select('*')
      .order('issued_at', { ascending: false });

    if (error) throw error;

    setRadioGuideAssignments((data || []).map(a => ({
      id: a.id,
      kitId: a.kit_id,
      excursionId: a.excursion_id,
      guideName: a.guide_name,
      busNumber: a.bus_number,
      receiversIssued: a.receivers_issued,
      receiversReturned: a.receivers_returned,
      issuedAt: a.issued_at,
      returnedAt: a.returned_at,
      returnNotes: a.return_notes,
      managerId: a.manager_id,
      managerName: a.manager_name,
    })));
  }, []);

  const fetchEquipmentLosses = useCallback(async (): Promise<void> => {
    const { data, error } = await supabase
      .from('equipment_losses')
      .select('*, radio_guide_kits(bag_number)')
      .order('created_at', { ascending: false });

    if (error) {
      if (error.code === 'PGRST205') {
        return;
      }
      throw error;
    }

    setEquipmentLosses((data || []).map(l => ({
      id: l.id,
      assignmentId: l.assignment_id,
      kitId: l.kit_id,
      guideName: l.guide_name,
      missingCount: l.missing_count,
      reason: l.reason,
      status: l.status as EquipmentLossStatus,
      foundAt: l.found_at,
      foundNotes: l.found_notes,
      createdAt: l.created_at,
      managerId: l.manager_id,
      managerName: l.manager_name,
      bagNumber: l.radio_guide_kits?.bag_number,
    })));
  }, []);

  const fetchSettings = useCallback(async (): Promise<void> => {
    const { data, error } = await supabase
      .from('app_settings')
      .select('*')
      .eq('key', 'radio_guide_price')
      .single();

    if (error) {
      if (error.code === 'PGRST116' || error.code === 'PGRST205') {
        return;
      }
      throw error;
    }

    if (data) {
      setRadioGuidePrice(Number(data.value) || 80);
    }
  }, []);

  const updateRadioGuidePrice = async (price: number) => {
    try {
      const { error } = await supabase
        .from('app_settings')
        .upsert({ 
          key: 'radio_guide_price', 
          value: String(price),
          updated_at: new Date().toISOString()
        });

      if (error) throw error;
      setRadioGuidePrice(price);
    } catch (err) {
      console.error('Error updating radio guide price:', err);
      throw err;
    }
  };

  const fetchDispatchingNotes = useCallback(async (): Promise<void> => {
    if (!user) return;
    
    try {
      const { data, error } = await supabase
        .from('dispatching_notes')
        .select('*')
        .eq('manager_id', user.id)
        .order('created_at', { ascending: false });

      if (error) {
        if (error.code === 'PGRST205' || error.code === '42P01') {
          return;
        }
        throw error;
      }

      const serverNotes = (data || []).map(n => ({
        id: n.id,
        text: n.text,
        createdAt: n.created_at,
        updatedAt: n.updated_at,
        managerId: n.manager_id,
        linkedExcursionId: n.linked_excursion_id || null,
      }));
      
      setDispatchingNotes(prev => {
        const localOnlyNotes = prev.filter(n => n.id.startsWith('local_'));
        
        for (const localNote of localOnlyNotes) {
          (async () => {
            try {
              const { data: syncedData } = await supabase
                .from('dispatching_notes')
                .insert({
                  manager_id: user.id,
                  text: localNote.text,
                })
                .select()
                .single();
              if (syncedData) {
                setDispatchingNotes(current => {
                  const synced = current.map(n => n.id === localNote.id ? {
                    id: syncedData.id,
                    text: syncedData.text,
                    createdAt: syncedData.created_at,
                    updatedAt: syncedData.updated_at,
                    managerId: syncedData.manager_id,
                  } : n);
                  saveToCache('dispatchingNotes', synced);
                  return synced;
                });
              }
            } catch {
            }
          })();
        }
        
        const merged = [...localOnlyNotes, ...serverNotes];
        saveToCache('dispatchingNotes', merged);
        return merged;
      });
    } catch (err) {
      console.warn('Failed to fetch notes from server, using cache');
    }
  }, [user]);

  const addDispatchingNote = async (text: string) => {
    if (!user) throw new Error('Not authenticated');
    
    const tempId = `local_${Date.now()}`;
    const now = new Date().toISOString();
    const optimisticNote: DispatchingNote = {
      id: tempId,
      text,
      createdAt: now,
      updatedAt: now,
      managerId: user.id,
    };
    
    setDispatchingNotes(prev => {
      const updated = [optimisticNote, ...prev];
      saveToCache('dispatchingNotes', updated);
      return updated;
    });
    
    try {
      const { data, error } = await supabase
        .from('dispatching_notes')
        .insert({
          manager_id: user.id,
          text,
        })
        .select()
        .single();

      if (error) throw error;

      const serverNote: DispatchingNote = {
        id: data.id,
        text: data.text,
        createdAt: data.created_at,
        updatedAt: data.updated_at,
        managerId: data.manager_id,
      };

      setDispatchingNotes(prev => {
        const updated = prev.map(n => n.id === tempId ? serverNote : n);
        saveToCache('dispatchingNotes', updated);
        return updated;
      });
    } catch (err) {
      console.warn('Note saved locally, will sync when online');
    }
  };

  const updateDispatchingNote = async (id: string, text: string, linkedExcursionId?: string | null) => {
    const now = new Date().toISOString();
    
    setDispatchingNotes(prev => {
      const updated = prev.map(n => n.id === id ? { ...n, text, updatedAt: now, ...(linkedExcursionId !== undefined && { linkedExcursionId }) } : n);
      saveToCache('dispatchingNotes', updated);
      return updated;
    });
    
    if (!id.startsWith('local_')) {
      try {
        const updateData: Record<string, unknown> = { text, updated_at: now };
        if (linkedExcursionId !== undefined) {
          updateData.linked_excursion_id = linkedExcursionId;
        }
        const { error } = await supabase
          .from('dispatching_notes')
          .update(updateData)
          .eq('id', id);

        if (error) throw error;
      } catch (err) {
        console.warn('Note updated locally, will sync when online');
      }
    }
  };

  const linkDispatchingNoteToExcursion = async (noteId: string, excursionId: string) => {
    const now = new Date().toISOString();
    
    setDispatchingNotes(prev => {
      const updated = prev.map(n => n.id === noteId ? { ...n, linkedExcursionId: excursionId, updatedAt: now } : n);
      saveToCache('dispatchingNotes', updated);
      return updated;
    });
    
    if (!noteId.startsWith('local_')) {
      try {
        const { error } = await supabase
          .from('dispatching_notes')
          .update({ linked_excursion_id: excursionId, updated_at: now })
          .eq('id', noteId);

        if (error) throw error;
      } catch (err) {
        console.warn('Link saved locally, will sync when online');
      }
    }
  };

  const deleteDispatchingNote = async (id: string) => {
    const note = dispatchingNotes.find(n => n.id === id);
    
    setDispatchingNotes(prev => {
      const updated = prev.filter(n => n.id !== id);
      saveToCache('dispatchingNotes', updated);
      return updated;
    });
    
    if (!id.startsWith('local_') && note) {
      try {
        const { error: insertError } = await supabase.from('deleted_items').insert({
          item_type: 'dispatching_note',
          item_data: note,
          deleted_at: new Date().toISOString(),
          deleted_by: user?.id,
        });

        if (insertError) {
          console.error('Error inserting dispatching note into deleted_items:', insertError);
        }

        const { error } = await supabase
          .from('dispatching_notes')
          .delete()
          .eq('id', id);

        if (error) throw error;
        
        await fetchDeletedItems();
      } catch (err) {
        console.warn('Note deleted locally, will sync when online');
      }
    }
  };

  const fetchExcursionNotes = useCallback(async (): Promise<void> => {
    if (!user) return;
    
    try {
      const { data, error } = await supabase
        .from('excursion_notes')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) {
        if (error.code === 'PGRST205' || error.code === '42P01') {
          return;
        }
        throw error;
      }

      const notes = (data || []).map(n => ({
        id: n.id,
        excursionId: n.excursion_id,
        text: n.text,
        createdAt: n.created_at,
        updatedAt: n.updated_at,
        managerId: n.manager_id,
        managerName: n.manager_name,
      }));
      
      // Auto-delete notes older than 14 days
      const fourteenDaysAgo = new Date();
      fourteenDaysAgo.setDate(fourteenDaysAgo.getDate() - 14);
      
      const expiredNotes = notes.filter(n => new Date(n.createdAt) < fourteenDaysAgo);
      const activeNotes = notes.filter(n => new Date(n.createdAt) >= fourteenDaysAgo);
      
      // Move expired notes to deleted_items and delete from excursion_notes
      for (const note of expiredNotes) {
        try {
          await supabase.from('deleted_items').insert({
            item_type: 'excursion_note_expired',
            item_data: note,
            deleted_at: new Date().toISOString(),
          });
          await supabase.from('excursion_notes').delete().eq('id', note.id);
        } catch (delErr) {
          console.warn('Failed to auto-delete expired note:', delErr);
        }
      }
      
      setExcursionNotes(activeNotes);
      saveToCache('excursionNotes', activeNotes);
    } catch (err) {
      console.warn('Failed to fetch excursion notes from server');
    }
  }, [user]);

  const addExcursionNote = async (excursionId: string, text: string) => {
    if (!user || !profile) throw new Error('Not authenticated');
    
    try {
      const { data, error } = await supabase
        .from('excursion_notes')
        .insert({
          excursion_id: excursionId,
          manager_id: user.id,
          manager_name: profile.display_name,
          text,
        })
        .select()
        .single();

      if (error) throw error;

      const newNote: ExcursionNote = {
        id: data.id,
        excursionId: data.excursion_id,
        text: data.text,
        createdAt: data.created_at,
        updatedAt: data.updated_at,
        managerId: data.manager_id,
        managerName: data.manager_name,
      };

      setExcursionNotes(prev => {
        const updated = [newNote, ...prev];
        saveToCache('excursionNotes', updated);
        return updated;
      });
    } catch (err) {
      console.error('Error adding excursion note:', err);
      throw err;
    }
  };

  const deleteExcursionNote = async (id: string) => {
    const note = excursionNotes.find(n => n.id === id);
    if (!note) return;

    setExcursionNotes(prev => {
      const updated = prev.filter(n => n.id !== id);
      saveToCache('excursionNotes', updated);
      return updated;
    });

    try {
      await supabase.from('deleted_items').insert({
        item_type: 'excursion_note',
        item_data: note,
        deleted_at: new Date().toISOString(),
      });

      const { error } = await supabase
        .from('excursion_notes')
        .delete()
        .eq('id', id);

      if (error) throw error;
    } catch (err) {
      console.error('Error deleting excursion note:', err);
    }
  };

  const getExcursionNotes = useCallback((excursionId: string): ExcursionNote[] => {
    return excursionNotes.filter(n => n.excursionId === excursionId);
  }, [excursionNotes]);

  const fetchChatMessages = useCallback(async (): Promise<void> => {
    if (!user) return;
    
    try {
      const { data, error } = await supabase
        .from('chat_messages')
        .select('*')
        .order('created_at', { ascending: true });

      if (error) {
        if (error.code === 'PGRST205' || error.code === '42P01') {
          return;
        }
        throw error;
      }

      const messages: ChatMessage[] = (data || []).map(m => ({
        id: m.id,
        senderId: m.sender_id,
        senderName: m.sender_name,
        message: m.message,
        createdAt: m.created_at,
      }));
      
      setChatMessages(messages);
    } catch (err) {
      console.warn('Failed to fetch chat messages from server');
    }
  }, [user]);

  const sendChatMessage = async (message: string) => {
    if (!user || !profile) throw new Error('Not authenticated');
    
    try {
      const { error } = await supabase
        .from('chat_messages')
        .insert({
          sender_id: user.id,
          sender_name: profile.display_name,
          message,
        });

      if (error) throw error;
    } catch (err) {
      console.error('Error sending chat message:', err);
      throw err;
    }
  };

  const clearChatHistory = async () => {
    try {
      const { error } = await supabase
        .from('chat_messages')
        .delete()
        .neq('id', '00000000-0000-0000-0000-000000000000'); // Delete all

      if (error) throw error;
      
      setChatMessages([]);
    } catch (err) {
      console.error('Error clearing chat history:', err);
      throw err;
    }
  };

  const fetchNotifications = useCallback(async (): Promise<void> => {
    if (!user) return;
    
    try {
      const { data, error } = await supabase
        .from('notifications')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', { ascending: false })
        .limit(100);

      if (error) {
        if (error.code === 'PGRST205' || error.code === '42P01') {
          return;
        }
        throw error;
      }

      const notifs: AppNotification[] = (data || []).map(n => ({
        id: n.id,
        userId: n.user_id,
        type: n.type as NotificationType,
        title: n.title,
        body: n.body,
        data: n.data || {},
        isRead: n.is_read,
        createdAt: n.created_at,
      }));
      
      setNotifications(notifs);
    } catch (err) {
      console.warn('Failed to fetch notifications from server');
    }
  }, [user]);

  const fetchNotificationSettings = useCallback(async (): Promise<void> => {
    if (!user) return;
    
    try {
      const { data, error } = await supabase
        .from('notification_settings')
        .select('*')
        .eq('user_id', user.id)
        .single();

      if (error) {
        if (error.code === 'PGRST116') {
          // No settings found, use defaults
          return;
        }
        if (error.code === 'PGRST205' || error.code === '42P01') {
          return;
        }
        throw error;
      }

      if (data) {
        setNotificationSettings({
          chatEnabled: data.chat_enabled ?? true,
          excursionsEnabled: data.excursions_enabled ?? true,
          transactionsEnabled: data.transactions_enabled ?? true,
        });
      }
    } catch (err) {
      console.warn('Failed to fetch notification settings');
    }
  }, [user]);

  const markNotificationAsRead = async (id: string) => {
    try {
      const { error } = await supabase
        .from('notifications')
        .update({ is_read: true })
        .eq('id', id);

      if (error) throw error;
      
      setNotifications(prev => prev.map(n => 
        n.id === id ? { ...n, isRead: true } : n
      ));
    } catch (err) {
      console.error('Error marking notification as read:', err);
      throw err;
    }
  };

  const markAllNotificationsAsRead = async () => {
    if (!user) return;
    
    try {
      const { error } = await supabase
        .from('notifications')
        .update({ is_read: true })
        .eq('user_id', user.id)
        .eq('is_read', false);

      if (error) throw error;
      
      setNotifications(prev => prev.map(n => ({ ...n, isRead: true })));
    } catch (err) {
      console.error('Error marking all notifications as read:', err);
      throw err;
    }
  };

  const updateNotificationSettings = async (settings: Partial<NotificationSettings>) => {
    if (!user) return;
    
    try {
      const updateData: Record<string, unknown> = { user_id: user.id };
      if (settings.chatEnabled !== undefined) updateData.chat_enabled = settings.chatEnabled;
      if (settings.excursionsEnabled !== undefined) updateData.excursions_enabled = settings.excursionsEnabled;
      if (settings.transactionsEnabled !== undefined) updateData.transactions_enabled = settings.transactionsEnabled;
      updateData.updated_at = new Date().toISOString();

      const { error } = await supabase
        .from('notification_settings')
        .upsert(updateData, { onConflict: 'user_id' });

      if (error) throw error;
      
      setNotificationSettings(prev => ({ ...prev, ...settings }));
    } catch (err) {
      console.error('Error updating notification settings:', err);
      throw err;
    }
  };

  const addNotification = async (
    type: NotificationType,
    title: string,
    body?: string,
    data?: Record<string, unknown>
  ) => {
    if (!user) return;
    
    try {
      const { error } = await supabase
        .from('notifications')
        .insert({
          user_id: user.id,
          type,
          title,
          body: body || null,
          data: data || {},
        });

      if (error) throw error;
    } catch (err) {
      console.error('Error adding notification:', err);
    }
  };

  const unreadNotificationCount = notifications.filter(n => !n.isRead).length;

  const refreshData = useCallback(async () => {
    setIsLoading(true);
    try {
      const results = await Promise.allSettled([
        fetchTourTypes(),
        fetchAdditionalServices(),
        fetchExcursions(),
        fetchTransactions(),
        fetchActivities(),
        fetchDeletedItems(),
        fetchRadioGuideKits(),
        fetchRadioGuideAssignments(),
        fetchEquipmentLosses(),
        fetchDispatchingNotes(),
        fetchExcursionNotes(),
        fetchChatMessages(),
      ]);
      
      const hasErrors = results.some(r => r.status === 'rejected');
      if (hasErrors) {
        const errors = results.filter(r => r.status === 'rejected');
        console.error('Some data failed to load:', errors);
        setNetworkError('Некоторые данные не удалось загрузить. Потяните вниз для обновления.');
        setIsOffline(true);
      } else {
        setNetworkError(null);
        setIsOffline(false);
      }
    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'Неизвестная ошибка';
      if (errorMessage.includes('Network') || errorMessage.includes('fetch')) {
        setNetworkError('Нет подключения к интернету. Проверьте соединение и попробуйте снова.');
        setIsOffline(true);
      } else {
        setNetworkError('Ошибка загрузки данных. Попробуйте позже.');
      }
      console.error('Error refreshing data:', err);
    } finally {
      setIsLoading(false);
    }
  }, [fetchTourTypes, fetchAdditionalServices, fetchExcursions, fetchTransactions, fetchActivities, fetchDeletedItems, fetchRadioGuideKits, fetchRadioGuideAssignments, fetchEquipmentLosses]);

  // Load shared data (price list, radio kits, settings) when user is authenticated
  useEffect(() => {
    if (user) {
      Promise.all([
        fetchTourTypes(),
        fetchAdditionalServices(),
        fetchRadioGuideKits(),
        fetchRadioGuideAssignments(),
        fetchEquipmentLosses(),
        fetchSettings(),
      ]).then(() => {
        setIsOffline(false);
        setNetworkError(null);
      }).catch(() => {
        setIsOffline(true);
      });
    }
  }, [user, fetchTourTypes, fetchAdditionalServices, fetchRadioGuideKits, fetchRadioGuideAssignments, fetchEquipmentLosses, fetchSettings]);

  // Load user-specific data when profile is available
  useEffect(() => {
    if (user && profile) {
      Promise.all([
        fetchExcursions(),
        fetchTransactions(),
        fetchActivities(),
        fetchDeletedItems(),
        fetchDispatchingNotes(),
        fetchExcursionNotes(),
        fetchChatMessages(),
        fetchNotifications(),
        fetchNotificationSettings(),
      ]).then(() => {
        setIsOffline(false);
        setNetworkError(null);
      }).catch(() => {
        setIsOffline(true);
      }).finally(() => setIsLoading(false));
    } else if (user && !profile) {
      // User authenticated but no profile yet - still loading
      setIsLoading(true);
    } else {
      setIsLoading(false);
    }
  }, [user, profile, fetchExcursions, fetchTransactions, fetchActivities, fetchDeletedItems, fetchDispatchingNotes, fetchExcursionNotes, fetchChatMessages, fetchNotifications, fetchNotificationSettings]);

  // Supabase Realtime subscriptions for live data sync
  useEffect(() => {
    if (!user) return;

    const channel = supabase.channel('db-changes')
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'tour_types' },
        () => safeFetch(fetchTourTypes)
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'additional_services' },
        () => safeFetch(fetchAdditionalServices)
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'excursions' },
        () => safeFetch(fetchExcursions)
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'transactions' },
        () => safeFetch(fetchTransactions)
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'activities' },
        () => safeFetch(fetchActivities)
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'deleted_items' },
        () => safeFetch(fetchDeletedItems)
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'radio_guide_kits' },
        () => safeFetch(fetchRadioGuideKits)
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'radio_guide_assignments' },
        () => safeFetch(fetchRadioGuideAssignments)
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'equipment_losses' },
        () => safeFetch(fetchEquipmentLosses)
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'dispatching_notes' },
        () => safeFetch(fetchDispatchingNotes)
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'excursion_notes' },
        () => safeFetch(fetchExcursionNotes)
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'chat_messages' },
        () => safeFetch(fetchChatMessages)
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'notifications' },
        () => safeFetch(fetchNotifications)
      )
      .subscribe((status) => {
        if (status === 'CHANNEL_ERROR') {
          console.warn('Supabase Realtime channel error - will retry');
          setIsOffline(true);
          // Auto-retry after 5 seconds
          setTimeout(() => {
            channel.subscribe();
          }, 5000);
        } else if (status === 'SUBSCRIBED') {
          setIsOffline(false);
        } else if (status === 'TIMED_OUT') {
          console.warn('Supabase Realtime timed out - will retry');
          setIsOffline(true);
          setTimeout(() => {
            channel.subscribe();
          }, 3000);
        }
      });

    return () => {
      supabase.removeChannel(channel);
    };
  }, [user, fetchTourTypes, fetchAdditionalServices, fetchRadioGuideKits, fetchRadioGuideAssignments, fetchEquipmentLosses, fetchExcursions, fetchTransactions, fetchActivities, fetchDeletedItems, fetchDispatchingNotes, fetchExcursionNotes, fetchChatMessages, fetchNotifications, safeFetch]);

  const refreshPriceList = useCallback(async () => {
    await Promise.all([fetchTourTypes(), fetchAdditionalServices()]);
  }, [fetchTourTypes, fetchAdditionalServices]);

  const addTourType = async (tourType: Omit<TourType, 'id'>) => {
    try {
      const { error } = await supabase
        .from('tour_types')
        .insert({
          name: tourType.name,
          full_price: tourType.fullPrice,
          discounted_price: tourType.discountedPrice,
          article_number: tourType.articleNumber,
          is_enabled: tourType.isEnabled,
          has_radio_guides: tourType.hasRadioGuides,
          applicable_service_ids: tourType.applicableServiceIds,
        });

      if (error) throw error;
      await fetchTourTypes();
    } catch (err) {
      console.error('Error adding tour type:', err);
      throw err;
    }
  };

  const updateTourType = async (id: string, tourType: Partial<TourType>) => {
    try {
      const updateData: Record<string, unknown> = {};
      if (tourType.name !== undefined) updateData.name = tourType.name;
      if (tourType.fullPrice !== undefined) updateData.full_price = tourType.fullPrice;
      if (tourType.discountedPrice !== undefined) updateData.discounted_price = tourType.discountedPrice;
      if (tourType.articleNumber !== undefined) updateData.article_number = tourType.articleNumber;
      if (tourType.isEnabled !== undefined) updateData.is_enabled = tourType.isEnabled;
      if (tourType.hasRadioGuides !== undefined) updateData.has_radio_guides = tourType.hasRadioGuides;
      if (tourType.applicableServiceIds !== undefined) updateData.applicable_service_ids = tourType.applicableServiceIds;

      const { error } = await supabase
        .from('tour_types')
        .update(updateData)
        .eq('id', id);

      if (error) throw error;
      await fetchTourTypes();
    } catch (err) {
      console.error('Error updating tour type:', err);
      throw err;
    }
  };

  const deleteTourType = async (id: string) => {
    try {
      const { error } = await supabase
        .from('tour_types')
        .delete()
        .eq('id', id);

      if (error) throw error;
      await fetchTourTypes();
    } catch (err) {
      console.error('Error deleting tour type:', err);
      throw err;
    }
  };

  const addAdditionalService = async (service: Omit<AdditionalService, 'id'>) => {
    try {
      const { error } = await supabase
        .from('additional_services')
        .insert({
          name: service.name,
          price: service.price,
          is_enabled: service.isEnabled,
        });

      if (error) throw error;
      await fetchAdditionalServices();
    } catch (err) {
      console.error('Error adding additional service:', err);
      throw err;
    }
  };

  const updateAdditionalService = async (id: string, service: Partial<AdditionalService>) => {
    try {
      const updateData: Record<string, unknown> = {};
      if (service.name !== undefined) updateData.name = service.name;
      if (service.price !== undefined) updateData.price = service.price;
      if (service.isEnabled !== undefined) updateData.is_enabled = service.isEnabled;
      
      const { error } = await supabase
        .from('additional_services')
        .update(updateData)
        .eq('id', id)
        .select();
      
      if (error) throw error;
      await fetchAdditionalServices();
    } catch (err) {
      console.error('Error updating additional service:', err);
      throw err;
    }
  };

  const deleteAdditionalService = async (id: string) => {
    try {
      const { error } = await supabase
        .from('additional_services')
        .delete()
        .eq('id', id);

      if (error) throw error;
      await fetchAdditionalServices();
    } catch (err) {
      console.error('Error deleting additional service:', err);
      throw err;
    }
  };

  const addExcursion = async (excursion: Omit<Excursion, 'id' | 'managerId' | 'managerName'>) => {
    if (!user || !profile) throw new Error('User not authenticated');

    try {
      const { data: excursionData, error } = await supabase
        .from('excursions')
        .insert({
          tour_type_id: excursion.tourTypeId,
          event_date: excursion.date,
          event_time: excursion.time,
          full_price_count: excursion.fullPriceCount,
          discounted_count: excursion.discountedCount,
          free_count: excursion.freeCount,
          by_tour_count: excursion.byTourCount,
          paid_count: excursion.paidCount,
          expenses: excursion.expenses,
          additional_services: excursion.additionalServices,
          manager_id: user.id,
        })
        .select()
        .single();

      if (error) throw error;

      const tourType = tourTypes.find(t => t.id === excursion.tourTypeId);
      await supabase.from('activities').insert({
        manager_id: user.id,
        manager_name: profile.display_name,
        type: 'excursion_added',
        description: `добавил экскурсию ${tourType?.name || ''}`,
        target_id: excursionData.id,
      });

      await fetchExcursions();
      await fetchActivities();
    } catch (err) {
      console.error('Error adding excursion:', err);
      throw err;
    }
  };

  const updateExcursion = async (id: string, excursion: Partial<Excursion>) => {
    try {
      const updateData: Record<string, unknown> = {};
      if (excursion.tourTypeId !== undefined) updateData.tour_type_id = excursion.tourTypeId;
      if (excursion.date !== undefined) updateData.event_date = excursion.date;
      if (excursion.time !== undefined) updateData.event_time = excursion.time;
      if (excursion.fullPriceCount !== undefined) updateData.full_price_count = excursion.fullPriceCount;
      if (excursion.discountedCount !== undefined) updateData.discounted_count = excursion.discountedCount;
      if (excursion.freeCount !== undefined) updateData.free_count = excursion.freeCount;
      if (excursion.byTourCount !== undefined) updateData.by_tour_count = excursion.byTourCount;
      if (excursion.paidCount !== undefined) updateData.paid_count = excursion.paidCount;
      if (excursion.expenses !== undefined) updateData.expenses = excursion.expenses;
      if (excursion.additionalServices !== undefined) updateData.additional_services = excursion.additionalServices;

      const { data, error } = await supabase
        .from('excursions')
        .update(updateData)
        .eq('id', id)
        .select('additional_services');

      if (error) throw error;
      
      await fetchExcursions();
    } catch (err) {
      console.error('Error updating excursion:', err);
      throw err;
    }
  };

  const deleteExcursion = async (id: string) => {
    if (!user || !profile) throw new Error('User not authenticated');

    try {
      const excursion = excursions.find(e => e.id === id);
      if (!excursion) throw new Error('Excursion not found');

      await supabase.from('deleted_items').insert({
        item_type: 'excursion',
        item_data: excursion,
        deleted_by: user.id,
      });

      const { error } = await supabase
        .from('excursions')
        .delete()
        .eq('id', id);

      if (error) throw error;

      const tourType = tourTypes.find(t => t.id === excursion.tourTypeId);
      await supabase.from('activities').insert({
        manager_id: user.id,
        manager_name: profile.display_name,
        type: 'excursion_deleted',
        description: `удалил экскурсию ${tourType?.name || ''}`,
        target_id: id,
      });

      await fetchExcursions();
      await fetchActivities();
      await fetchDeletedItems();
    } catch (err) {
      console.error('Error deleting excursion:', err);
      throw err;
    }
  };

  const addTransaction = async (transaction: Omit<Transaction, 'id' | 'managerId' | 'managerName'>) => {
    if (!user || !profile) throw new Error('User not authenticated');

    try {
      const { data: transactionData, error } = await supabase
        .from('transactions')
        .insert({
          type: transaction.type,
          amount: transaction.amount,
          description: transaction.description,
          event_date: transaction.date,
          manager_id: user.id,
        })
        .select()
        .single();

      if (error) throw error;

      const typeText = transaction.type === 'income' ? 'доход' : 'расход';
      await supabase.from('activities').insert({
        manager_id: user.id,
        manager_name: profile.display_name,
        type: 'transaction_added',
        description: `добавил ${typeText} "${transaction.description}"`,
        target_id: transactionData.id,
      });

      await fetchTransactions();
      await fetchActivities();
    } catch (err) {
      console.error('Error adding transaction:', err);
      throw err;
    }
  };

  const deleteTransaction = async (id: string) => {
    if (!user || !profile) throw new Error('User not authenticated');

    try {
      const transaction = transactions.find(t => t.id === id);
      if (!transaction) throw new Error('Transaction not found');

      await supabase.from('deleted_items').insert({
        item_type: 'transaction',
        item_data: transaction,
        deleted_by: user.id,
      });

      const { error } = await supabase
        .from('transactions')
        .delete()
        .eq('id', id);

      if (error) throw error;

      const typeText = transaction.type === 'income' ? 'доход' : 'расход';
      await supabase.from('activities').insert({
        manager_id: user.id,
        manager_name: profile.display_name,
        type: 'transaction_deleted',
        description: `удалил ${typeText} "${transaction.description}"`,
        target_id: id,
      });

      await fetchTransactions();
      await fetchActivities();
      await fetchDeletedItems();
    } catch (err) {
      console.error('Error deleting transaction:', err);
      throw err;
    }
  };

  const restoreDeletedItem = async (id: string) => {
    try {
      const item = deletedItems.find(i => i.id === id);
      if (!item) throw new Error('Deleted item not found');

      const isNoteType = item.type === 'dispatching_note' || item.type === 'excursion_note' || item.type === 'excursion_note_expired';
      if (!isAdmin && !isNoteType) {
        throw new Error('Only admins can restore excursions and transactions');
      }

      if (item.type === 'excursion') {
        const excursion = item.data as Excursion;
        await supabase.from('excursions').insert({
          id: excursion.id,
          tour_type_id: excursion.tourTypeId,
          event_date: excursion.date,
          event_time: excursion.time,
          full_price_count: excursion.fullPriceCount,
          discounted_count: excursion.discountedCount,
          free_count: excursion.freeCount,
          by_tour_count: excursion.byTourCount || 0,
          paid_count: excursion.paidCount || 0,
          expenses: excursion.expenses,
          additional_services: excursion.additionalServices,
          manager_id: excursion.managerId,
        });
      } else if (item.type === 'transaction') {
        const transaction = item.data as Transaction;
        await supabase.from('transactions').insert({
          id: transaction.id,
          type: transaction.type,
          amount: transaction.amount,
          description: transaction.description,
          event_date: transaction.date,
          manager_id: transaction.managerId,
        });
      } else if (item.type === 'excursion_note' || item.type === 'excursion_note_expired') {
        const note = item.data as ExcursionNote;
        await supabase.from('excursion_notes').insert({
          id: note.id,
          excursion_id: note.excursionId,
          text: note.text,
          manager_id: note.managerId,
          manager_name: note.managerName,
          created_at: note.createdAt,
          updated_at: note.updatedAt,
        });
      } else if (item.type === 'dispatching_note') {
        const note = item.data as DispatchingNote;
        await supabase.from('dispatching_notes').insert({
          id: note.id,
          text: note.text,
          manager_id: note.managerId,
          created_at: note.createdAt,
          updated_at: note.updatedAt,
          linked_excursion_id: note.linkedExcursionId,
        });
      } else if (item.type === 'radio_guide_kit') {
        const kit = item.data as RadioGuideKit;
        await supabase.from('radio_guide_kits').insert({
          id: kit.id,
          bag_number: kit.bagNumber,
          status: kit.status,
          notes: kit.notes,
        });
      } else if (item.type === 'equipment_loss') {
        const loss = item.data as EquipmentLoss;
        await supabase.from('equipment_losses').insert({
          id: loss.id,
          kit_id: loss.kitId,
          assignment_id: loss.assignmentId,
          guide_name: loss.guideName,
          missing_count: loss.missingCount,
          reason: loss.reason,
          status: loss.status,
          found_at: loss.foundAt,
          found_notes: loss.foundNotes,
          created_at: loss.createdAt,
          manager_id: loss.managerId,
          manager_name: loss.managerName,
        });
      }

      await supabase.from('deleted_items').delete().eq('id', id);
      
      await refreshData();
    } catch (err) {
      console.error('Error restoring deleted item:', err);
      throw err;
    }
  };

  const permanentlyDeleteItem = async (id: string) => {
    if (!isAdmin) throw new Error('Only admins can permanently delete items');

    try {
      const { error } = await supabase
        .from('deleted_items')
        .delete()
        .eq('id', id);

      if (error) throw error;
      await fetchDeletedItems();
    } catch (err) {
      console.error('Error permanently deleting item:', err);
      throw err;
    }
  };

  const clearDeletedItems = async () => {
    if (!isAdmin) throw new Error('Only admins can clear deleted items');

    try {
      const { error } = await supabase
        .from('deleted_items')
        .delete()
        .neq('id', '00000000-0000-0000-0000-000000000000');

      if (error) throw error;
      setDeletedItems([]);
    } catch (err) {
      console.error('Error clearing deleted items:', err);
      throw err;
    }
  };

  const addRadioGuideKit = async (kit: Omit<RadioGuideKit, 'id'>) => {
    try {
      const { error } = await supabase
        .from('radio_guide_kits')
        .insert({
          bag_number: kit.bagNumber,
          status: kit.status,
          notes: kit.notes,
        });

      if (error) throw error;
      await fetchRadioGuideKits();
    } catch (err) {
      console.error('Error adding radio guide kit:', err);
      throw err;
    }
  };

  const updateRadioGuideKit = async (id: string, kit: Partial<RadioGuideKit>) => {
    try {
      const updateData: Record<string, unknown> = {};
      if (kit.bagNumber !== undefined) updateData.bag_number = kit.bagNumber;
      if (kit.status !== undefined) updateData.status = kit.status;
      if (kit.notes !== undefined) updateData.notes = kit.notes;

      const { error } = await supabase
        .from('radio_guide_kits')
        .update(updateData)
        .eq('id', id);

      if (error) throw error;
      await fetchRadioGuideKits();
    } catch (err) {
      console.error('Error updating radio guide kit:', err);
      throw err;
    }
  };

  const deleteRadioGuideKit = async (id: string) => {
    try {
      const kit = radioGuideKits.find(k => k.id === id);
      if (!kit) throw new Error('Kit not found');

      const { error: insertError } = await supabase.from('deleted_items').insert({
        item_type: 'radio_guide_kit',
        item_data: kit,
        deleted_at: new Date().toISOString(),
        deleted_by: user?.id,
      });

      if (insertError) {
        console.error('Error inserting into deleted_items:', insertError);
        throw insertError;
      }

      const { error } = await supabase
        .from('radio_guide_kits')
        .delete()
        .eq('id', id);

      if (error) throw error;
      await fetchRadioGuideKits();
      await fetchDeletedItems();
    } catch (err) {
      console.error('Error deleting radio guide kit:', err);
      throw err;
    }
  };

  const issueRadioGuide = async (data: { 
    kitId: string; 
    excursionId?: string; 
    guideName: string; 
    busNumber?: string; 
    receiversIssued: number 
  }) => {
    if (!user || !profile) throw new Error('User not authenticated');

    try {
      const { error: assignmentError } = await supabase
        .from('radio_guide_assignments')
        .insert({
          kit_id: data.kitId,
          excursion_id: data.excursionId || null,
          guide_name: data.guideName,
          bus_number: data.busNumber || null,
          receivers_issued: data.receiversIssued,
          issued_at: new Date().toISOString(),
          manager_id: user.id,
          manager_name: profile.display_name,
        });

      if (assignmentError) throw assignmentError;

      const { error: kitError } = await supabase
        .from('radio_guide_kits')
        .update({ status: 'issued' })
        .eq('id', data.kitId);

      if (kitError) throw kitError;

      const kit = radioGuideKits.find(k => k.id === data.kitId);
      const { error: activityError } = await supabase.from('activities').insert({
        manager_id: user.id,
        manager_name: profile.display_name,
        type: 'radio_issued',
        description: `выдал радиогид (сумка ${kit?.bagNumber || '?'}) гиду ${data.guideName}`,
        target_id: data.kitId,
        timestamp: new Date().toISOString(),
      });
      if (activityError) {
        console.error('Error creating radio_issued activity:', activityError);
      }

      await Promise.all([fetchRadioGuideKits(), fetchRadioGuideAssignments(), fetchActivities()]);
    } catch (err) {
      console.error('Error issuing radio guide:', err);
      throw err;
    }
  };

  const returnRadioGuide = async (assignmentId: string, receiversReturned: number, notes?: string) => {
    try {
      const assignment = radioGuideAssignments.find(a => a.id === assignmentId);
      if (!assignment) throw new Error('Assignment not found');

      const { error: assignmentError } = await supabase
        .from('radio_guide_assignments')
        .update({
          receivers_returned: receiversReturned,
          returned_at: new Date().toISOString(),
          return_notes: notes || null,
        })
        .eq('id', assignmentId);

      if (assignmentError) throw assignmentError;

      const { error: kitError } = await supabase
        .from('radio_guide_kits')
        .update({ status: 'available' })
        .eq('id', assignment.kitId);

      if (kitError) throw kitError;

      const kit = radioGuideKits.find(k => k.id === assignment.kitId);
      if (user && profile) {
        const { error: activityError } = await supabase.from('activities').insert({
          manager_id: user.id,
          manager_name: profile.display_name,
          type: 'radio_returned',
          description: `принял радиогид (сумка ${kit?.bagNumber || '?'}) от ${assignment.guideName}`,
          target_id: assignmentId,
          timestamp: new Date().toISOString(),
        });
        if (activityError) {
          console.error('Error creating radio_returned activity:', activityError);
        }
      }

      await Promise.all([fetchRadioGuideKits(), fetchRadioGuideAssignments(), fetchActivities()]);
    } catch (err) {
      console.error('Error returning radio guide:', err);
      throw err;
    }
  };

  const getActiveAssignment = (kitId: string): RadioGuideAssignment | undefined => {
    return radioGuideAssignments.find(a => a.kitId === kitId && !a.returnedAt);
  };

  const addEquipmentLoss = async (loss: Omit<EquipmentLoss, 'id' | 'createdAt' | 'foundAt' | 'foundNotes' | 'status' | 'managerId' | 'managerName'>) => {
    if (!currentUser) throw new Error('No user');

    try {
      const { error } = await supabase.from('equipment_losses').insert({
        assignment_id: loss.assignmentId,
        kit_id: loss.kitId,
        guide_name: loss.guideName,
        missing_count: loss.missingCount,
        reason: loss.reason,
        status: 'lost',
        manager_id: currentUser.id,
        manager_name: currentUser.name,
      });

      if (error) throw error;
      await fetchEquipmentLosses();
    } catch (err) {
      console.error('Error adding equipment loss:', err);
      throw err;
    }
  };

  const updateEquipmentLoss = async (id: string, data: { reason?: string; missingCount?: number }) => {
    try {
      const updateData: Record<string, unknown> = {};
      if (data.reason !== undefined) updateData.reason = data.reason;
      if (data.missingCount !== undefined) updateData.missing_count = data.missingCount;

      const { error } = await supabase
        .from('equipment_losses')
        .update(updateData)
        .eq('id', id);

      if (error) throw error;
      await fetchEquipmentLosses();
    } catch (err) {
      console.error('Error updating equipment loss:', err);
      throw err;
    }
  };

  const markLossAsFound = async (id: string, notes?: string) => {
    try {
      const { error } = await supabase
        .from('equipment_losses')
        .update({
          status: 'found',
          found_at: new Date().toISOString(),
          found_notes: notes || null,
        })
        .eq('id', id);

      if (error) throw error;
      await fetchEquipmentLosses();
    } catch (err) {
      console.error('Error marking loss as found:', err);
      throw err;
    }
  };

  const deleteEquipmentLoss = async (id: string) => {
    try {
      const loss = equipmentLosses.find(l => l.id === id);
      if (!loss) throw new Error('Loss record not found');

      const { error: insertError } = await supabase.from('deleted_items').insert({
        item_type: 'equipment_loss',
        item_data: loss,
        deleted_at: new Date().toISOString(),
        deleted_by: user?.id,
      });

      if (insertError) {
        console.error('Error inserting into deleted_items:', insertError);
        throw insertError;
      }

      const { error } = await supabase
        .from('equipment_losses')
        .delete()
        .eq('id', id);

      if (error) throw error;
      await fetchEquipmentLosses();
      await fetchDeletedItems();
    } catch (err) {
      console.error('Error deleting equipment loss:', err);
      throw err;
    }
  };

  return (
    <DataContext.Provider
      value={{
        tourTypes,
        addTourType,
        updateTourType,
        deleteTourType,
        additionalServices,
        addAdditionalService,
        updateAdditionalService,
        deleteAdditionalService,
        excursions,
        addExcursion,
        updateExcursion,
        deleteExcursion,
        transactions,
        addTransaction,
        deleteTransaction,
        managers,
        currentUser,
        activities,
        deletedItems,
        restoreDeletedItem,
        permanentlyDeleteItem,
        clearDeletedItems,
        radioGuideKits,
        radioGuideAssignments,
        addRadioGuideKit,
        updateRadioGuideKit,
        deleteRadioGuideKit,
        issueRadioGuide,
        returnRadioGuide,
        getActiveAssignment,
        equipmentLosses,
        addEquipmentLoss,
        updateEquipmentLoss,
        markLossAsFound,
        deleteEquipmentLoss,
        radioGuidePrice,
        updateRadioGuidePrice,
        dispatchingNotes,
        addDispatchingNote,
        updateDispatchingNote,
        linkDispatchingNoteToExcursion,
        deleteDispatchingNote,
        excursionNotes,
        addExcursionNote,
        deleteExcursionNote,
        getExcursionNotes,
        chatMessages,
        sendChatMessage,
        clearChatHistory,
        notifications,
        unreadNotificationCount,
        notificationSettings,
        markNotificationAsRead,
        markAllNotificationsAsRead,
        updateNotificationSettings,
        addNotification,
        isLoading,
        isOffline,
        networkError,
        clearNetworkError,
        refreshData,
        refreshPriceList,
      }}
    >
      {children}
    </DataContext.Provider>
  );
}

export function useData() {
  const context = useContext(DataContext);
  if (!context) {
    throw new Error("useData must be used within a DataProvider");
  }
  return context;
}
