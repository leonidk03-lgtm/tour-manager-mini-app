import AsyncStorage from '@react-native-async-storage/async-storage';

const CACHE_PREFIX = 'tourmanager_cache_';
const CACHE_TIMESTAMP_KEY = `${CACHE_PREFIX}timestamp`;

export interface CacheData {
  tourTypes: unknown[];
  additionalServices: unknown[];
  excursions: unknown[];
  transactions: unknown[];
  activities: unknown[];
  deletedItems: unknown[];
  radioGuideKits: unknown[];
  radioGuideAssignments: unknown[];
  equipmentLosses: unknown[];
  radioGuidePrice: number;
  dispatchingNotes: unknown[];
}

export async function saveToCache(key: keyof CacheData, data: unknown): Promise<void> {
  try {
    await AsyncStorage.setItem(`${CACHE_PREFIX}${key}`, JSON.stringify(data));
    await AsyncStorage.setItem(CACHE_TIMESTAMP_KEY, new Date().toISOString());
  } catch (error) {
    console.error(`Error saving ${key} to cache:`, error);
  }
}

export async function loadFromCache<T>(key: keyof CacheData): Promise<T | null> {
  try {
    const data = await AsyncStorage.getItem(`${CACHE_PREFIX}${key}`);
    return data ? JSON.parse(data) : null;
  } catch (error) {
    console.error(`Error loading ${key} from cache:`, error);
    return null;
  }
}

export async function loadAllFromCache(): Promise<Partial<CacheData> | null> {
  try {
    const result: Partial<CacheData> = {};
    
    const tourTypes = await loadFromCache<unknown[]>('tourTypes');
    if (tourTypes) result.tourTypes = tourTypes;
    
    const additionalServices = await loadFromCache<unknown[]>('additionalServices');
    if (additionalServices) result.additionalServices = additionalServices;
    
    const excursions = await loadFromCache<unknown[]>('excursions');
    if (excursions) result.excursions = excursions;
    
    const transactions = await loadFromCache<unknown[]>('transactions');
    if (transactions) result.transactions = transactions;
    
    const activities = await loadFromCache<unknown[]>('activities');
    if (activities) result.activities = activities;
    
    const deletedItems = await loadFromCache<unknown[]>('deletedItems');
    if (deletedItems) result.deletedItems = deletedItems;
    
    const radioGuideKits = await loadFromCache<unknown[]>('radioGuideKits');
    if (radioGuideKits) result.radioGuideKits = radioGuideKits;
    
    const radioGuideAssignments = await loadFromCache<unknown[]>('radioGuideAssignments');
    if (radioGuideAssignments) result.radioGuideAssignments = radioGuideAssignments;
    
    const equipmentLosses = await loadFromCache<unknown[]>('equipmentLosses');
    if (equipmentLosses) result.equipmentLosses = equipmentLosses;
    
    const radioGuidePrice = await loadFromCache<number>('radioGuidePrice');
    if (radioGuidePrice !== null) result.radioGuidePrice = radioGuidePrice;
    
    const dispatchingNotes = await loadFromCache<unknown[]>('dispatchingNotes');
    if (dispatchingNotes) result.dispatchingNotes = dispatchingNotes;

    return Object.keys(result).length > 0 ? result : null;
  } catch (error) {
    console.error('Error loading all from cache:', error);
    return null;
  }
}

export async function getCacheTimestamp(): Promise<string | null> {
  try {
    return await AsyncStorage.getItem(CACHE_TIMESTAMP_KEY);
  } catch {
    return null;
  }
}

export async function clearCache(): Promise<void> {
  try {
    const keys = await AsyncStorage.getAllKeys();
    const cacheKeys = keys.filter(key => key.startsWith(CACHE_PREFIX));
    await AsyncStorage.multiRemove(cacheKeys);
  } catch (error) {
    console.error('Error clearing cache:', error);
  }
}

export async function clearUserCache(userId: string): Promise<void> {
  try {
    const userPrefix = `${CACHE_PREFIX}user_${userId}_`;
    const keys = await AsyncStorage.getAllKeys();
    const userKeys = keys.filter(key => key.startsWith(userPrefix));
    await AsyncStorage.multiRemove(userKeys);
  } catch (error) {
    console.error('Error clearing user cache:', error);
  }
}
