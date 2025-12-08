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
  type: "excursion" | "transaction";
  data: Excursion | Transaction;
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
    if (!isAdmin) return;

    const { data, error } = await supabase
      .from('deleted_items')
      .select('*')
      .order('deleted_at', { ascending: false });

    if (error) throw error;

    setDeletedItems((data || []).map(d => ({
      id: d.id,
      type: d.item_type as "excursion" | "transaction",
      data: d.item_data,
      deletedAt: d.deleted_at,
    })));
  }, [isAdmin]);

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
  }, [user, profile, fetchExcursions, fetchTransactions, fetchActivities, fetchDeletedItems]);

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
      .subscribe((status) => {
        if (status === 'CHANNEL_ERROR') {
          console.error('Supabase Realtime channel error');
          setIsOffline(true);
        } else if (status === 'SUBSCRIBED') {
          setIsOffline(false);
        }
      });

    return () => {
      supabase.removeChannel(channel);
    };
  }, [user, fetchTourTypes, fetchAdditionalServices, fetchRadioGuideKits, fetchRadioGuideAssignments, fetchEquipmentLosses, fetchExcursions, fetchTransactions, fetchActivities, fetchDeletedItems, safeFetch]);

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
    if (!isAdmin) throw new Error('Only admins can restore items');

    try {
      const item = deletedItems.find(i => i.id === id);
      if (!item) throw new Error('Deleted item not found');

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
      const { error } = await supabase
        .from('radio_guide_kits')
        .delete()
        .eq('id', id);

      if (error) throw error;
      await fetchRadioGuideKits();
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
      const { error } = await supabase
        .from('equipment_losses')
        .delete()
        .eq('id', id);

      if (error) throw error;
      await fetchEquipmentLosses();
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
