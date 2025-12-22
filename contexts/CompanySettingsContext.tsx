import { createContext, useContext, useState, useEffect, ReactNode, useCallback } from 'react';
import { supabase } from '@/lib/supabase';
import { useAuth } from './AuthContext';

export interface CompanySettings {
  id: string;
  companyName: string;
  inn: string;
  kpp: string;
  ogrn: string;
  legalAddress: string;
  actualAddress: string;
  bankName: string;
  bik: string;
  correspondentAccount: string;
  settlementAccount: string;
  directorName: string;
  directorPosition: string;
  phone: string;
  email: string;
  documentPrefix: string;
  nextInvoiceNumber: number;
  nextActNumber: number;
  nextContractNumber: number;
  nextWaybillNumber: number;
}

interface CompanySettingsContextType {
  settings: CompanySettings | null;
  isLoading: boolean;
  error: string | null;
  refreshSettings: () => Promise<void>;
  updateSettings: (data: Partial<CompanySettings>) => Promise<{ error: string | null }>;
  getNextDocumentNumber: (type: 'invoice' | 'act' | 'contract' | 'waybill') => Promise<{ number: number; prefix: string } | null>;
}

const CompanySettingsContext = createContext<CompanySettingsContextType | undefined>(undefined);

function mapDbToSettings(data: Record<string, unknown>): CompanySettings {
  return {
    id: data.id as string,
    companyName: (data.company_name as string) || '',
    inn: (data.inn as string) || '',
    kpp: (data.kpp as string) || '',
    ogrn: (data.ogrn as string) || '',
    legalAddress: (data.legal_address as string) || '',
    actualAddress: (data.actual_address as string) || '',
    bankName: (data.bank_name as string) || '',
    bik: (data.bik as string) || '',
    correspondentAccount: (data.correspondent_account as string) || '',
    settlementAccount: (data.settlement_account as string) || '',
    directorName: (data.director_name as string) || '',
    directorPosition: (data.director_position as string) || 'Индивидуальный предприниматель',
    phone: (data.phone as string) || '',
    email: (data.email as string) || '',
    documentPrefix: (data.document_prefix as string) || 'Р',
    nextInvoiceNumber: (data.next_invoice_number as number) || 1,
    nextActNumber: (data.next_act_number as number) || 1,
    nextContractNumber: (data.next_contract_number as number) || 1,
    nextWaybillNumber: (data.next_waybill_number as number) || 1,
  };
}

export function CompanySettingsProvider({ children }: { children: ReactNode }) {
  const { user, isAdmin } = useAuth();
  const [settings, setSettings] = useState<CompanySettings | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchSettings = useCallback(async () => {
    if (!user) {
      setSettings(null);
      setIsLoading(false);
      return;
    }

    try {
      setIsLoading(true);
      if (!supabase) {
        setSettings(null);
        setError(null);
        return;
      }
      
      const { data, error: fetchError } = await supabase
        .from('company_settings')
        .select('*')
        .limit(1)
        .single();

      if (fetchError) {
        if (fetchError.code === 'PGRST116' || fetchError.code === 'PGRST205') {
          setSettings(null);
        } else {
          throw fetchError;
        }
      } else {
        setSettings(mapDbToSettings(data));
      }
      setError(null);
    } catch (err) {
      console.error('Error fetching company settings:', err);
      setSettings(null);
      setError(null);
    } finally {
      setIsLoading(false);
    }
  }, [user]);

  useEffect(() => {
    fetchSettings();
  }, [fetchSettings]);

  const updateSettings = async (data: Partial<CompanySettings>): Promise<{ error: string | null }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может изменять настройки' };
    }

    try {
      const updateData: Record<string, unknown> = {};
      
      if (data.companyName !== undefined) updateData.company_name = data.companyName;
      if (data.inn !== undefined) updateData.inn = data.inn;
      if (data.kpp !== undefined) updateData.kpp = data.kpp;
      if (data.ogrn !== undefined) updateData.ogrn = data.ogrn;
      if (data.legalAddress !== undefined) updateData.legal_address = data.legalAddress;
      if (data.actualAddress !== undefined) updateData.actual_address = data.actualAddress;
      if (data.bankName !== undefined) updateData.bank_name = data.bankName;
      if (data.bik !== undefined) updateData.bik = data.bik;
      if (data.correspondentAccount !== undefined) updateData.correspondent_account = data.correspondentAccount;
      if (data.settlementAccount !== undefined) updateData.settlement_account = data.settlementAccount;
      if (data.directorName !== undefined) updateData.director_name = data.directorName;
      if (data.directorPosition !== undefined) updateData.director_position = data.directorPosition;
      if (data.phone !== undefined) updateData.phone = data.phone;
      if (data.email !== undefined) updateData.email = data.email;
      if (data.documentPrefix !== undefined) updateData.document_prefix = data.documentPrefix;
      
      updateData.updated_at = new Date().toISOString();

      if (!supabase) {
        return { error: 'Подключение к базе данных недоступно' };
      }
      
      if (settings?.id) {
        const { error: updateError } = await supabase
          .from('company_settings')
          .update(updateData)
          .eq('id', settings.id);

        if (updateError) throw updateError;
      } else {
        const { error: insertError } = await supabase
          .from('company_settings')
          .insert(updateData);

        if (insertError) throw insertError;
      }

      await fetchSettings();
      return { error: null };
    } catch (err) {
      console.error('Error updating company settings:', err);
      return { error: 'Ошибка сохранения настроек' };
    }
  };

  const getNextDocumentNumber = async (type: 'invoice' | 'act' | 'contract' | 'waybill'): Promise<{ number: number; prefix: string } | null> => {
    if (!settings?.id) return null;

    const columnMap = {
      invoice: 'next_invoice_number',
      act: 'next_act_number',
      contract: 'next_contract_number',
      waybill: 'next_waybill_number',
    };

    const column = columnMap[type];
    const currentNumber = type === 'invoice' ? settings.nextInvoiceNumber :
                         type === 'act' ? settings.nextActNumber :
                         type === 'contract' ? settings.nextContractNumber :
                         settings.nextWaybillNumber;

    try {
      if (!supabase) return null;
      
      const { error: updateError } = await supabase
        .from('company_settings')
        .update({ [column]: currentNumber + 1, updated_at: new Date().toISOString() })
        .eq('id', settings.id);

      if (updateError) throw updateError;

      await fetchSettings();
      
      return { number: currentNumber, prefix: settings.documentPrefix };
    } catch (err) {
      console.error('Error getting next document number:', err);
      return null;
    }
  };

  return (
    <CompanySettingsContext.Provider
      value={{
        settings,
        isLoading,
        error,
        refreshSettings: fetchSettings,
        updateSettings,
        getNextDocumentNumber,
      }}
    >
      {children}
    </CompanySettingsContext.Provider>
  );
}

export function useCompanySettings() {
  const context = useContext(CompanySettingsContext);
  if (context === undefined) {
    throw new Error('useCompanySettings must be used within a CompanySettingsProvider');
  }
  return context;
}
