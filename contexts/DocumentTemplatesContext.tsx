import { createContext, useContext, useState, useEffect, ReactNode, useCallback } from 'react';
import { supabase } from '@/lib/supabase';
import { useAuth } from './AuthContext';

export type DocumentTemplateType = 'invoice' | 'act' | 'contract' | 'contract_annual' | 'waybill';

export interface DocumentTemplate {
  id: string;
  type: DocumentTemplateType;
  name: string;
  htmlContent: string;
  isDefault: boolean;
  createdAt: string;
  updatedAt: string;
}

interface DocumentTemplatesContextType {
  templates: DocumentTemplate[];
  isLoading: boolean;
  error: string | null;
  refreshTemplates: () => Promise<void>;
  getTemplatesByType: (type: DocumentTemplateType) => DocumentTemplate[];
  getDefaultTemplate: (type: DocumentTemplateType) => DocumentTemplate | undefined;
  createTemplate: (data: Omit<DocumentTemplate, 'id' | 'createdAt' | 'updatedAt'>) => Promise<{ error: string | null; template?: DocumentTemplate }>;
  updateTemplate: (id: string, data: Partial<Omit<DocumentTemplate, 'id' | 'createdAt' | 'updatedAt'>>) => Promise<{ error: string | null }>;
  deleteTemplate: (id: string) => Promise<{ error: string | null }>;
  setAsDefault: (id: string, type: DocumentTemplateType) => Promise<{ error: string | null }>;
}

const DocumentTemplatesContext = createContext<DocumentTemplatesContextType | undefined>(undefined);

function mapDbToTemplate(data: Record<string, unknown>): DocumentTemplate {
  return {
    id: data.id as string,
    type: data.type as DocumentTemplate['type'],
    name: (data.name as string) || '',
    htmlContent: (data.html_content as string) || '',
    isDefault: (data.is_default as boolean) || false,
    createdAt: (data.created_at as string) || '',
    updatedAt: (data.updated_at as string) || '',
  };
}

export function DocumentTemplatesProvider({ children }: { children: ReactNode }) {
  const { user, isAdmin } = useAuth();
  const [templates, setTemplates] = useState<DocumentTemplate[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchTemplates = useCallback(async () => {
    if (!user) {
      setTemplates([]);
      setIsLoading(false);
      return;
    }

    try {
      setIsLoading(true);
      if (!supabase) {
        setTemplates([]);
        setError(null);
        return;
      }

      const { data, error: fetchError } = await supabase
        .from('document_templates')
        .select('*')
        .order('type')
        .order('is_default', { ascending: false })
        .order('name');

      if (fetchError) {
        if (fetchError.code === 'PGRST116' || fetchError.code === '42P01') {
          setTemplates([]);
        } else {
          throw fetchError;
        }
      } else {
        setTemplates((data || []).map(mapDbToTemplate));
      }
      setError(null);
    } catch (err) {
      console.error('Error fetching document templates:', err);
      setTemplates([]);
      setError(null);
    } finally {
      setIsLoading(false);
    }
  }, [user]);

  useEffect(() => {
    fetchTemplates();
  }, [fetchTemplates]);

  const getTemplatesByType = useCallback((type: DocumentTemplateType) => {
    return templates.filter(t => t.type === type);
  }, [templates]);

  const getDefaultTemplate = useCallback((type: DocumentTemplateType) => {
    return templates.find(t => t.type === type && t.isDefault) || templates.find(t => t.type === type);
  }, [templates]);

  const createTemplate = async (data: Omit<DocumentTemplate, 'id' | 'createdAt' | 'updatedAt'>): Promise<{ error: string | null; template?: DocumentTemplate }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может создавать шаблоны' };
    }

    try {
      if (!supabase) {
        return { error: 'Подключение к базе данных недоступно' };
      }

      const insertData = {
        type: data.type,
        name: data.name,
        html_content: data.htmlContent,
        is_default: data.isDefault,
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
      };

      const { data: inserted, error: insertError } = await supabase
        .from('document_templates')
        .insert(insertData)
        .select()
        .single();

      if (insertError) throw insertError;

      await fetchTemplates();
      return { error: null, template: mapDbToTemplate(inserted) };
    } catch (err) {
      console.error('Error creating template:', err);
      return { error: 'Ошибка создания шаблона' };
    }
  };

  const updateTemplate = async (id: string, data: Partial<Omit<DocumentTemplate, 'id' | 'createdAt' | 'updatedAt'>>): Promise<{ error: string | null }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может изменять шаблоны' };
    }

    try {
      if (!supabase) {
        return { error: 'Подключение к базе данных недоступно' };
      }

      const updateData: Record<string, unknown> = {
        updated_at: new Date().toISOString(),
      };

      if (data.type !== undefined) updateData.type = data.type;
      if (data.name !== undefined) updateData.name = data.name;
      if (data.htmlContent !== undefined) updateData.html_content = data.htmlContent;
      if (data.isDefault !== undefined) updateData.is_default = data.isDefault;

      const { error: updateError } = await supabase
        .from('document_templates')
        .update(updateData)
        .eq('id', id);

      if (updateError) throw updateError;

      await fetchTemplates();
      return { error: null };
    } catch (err) {
      console.error('Error updating template:', err);
      return { error: 'Ошибка сохранения шаблона' };
    }
  };

  const deleteTemplate = async (id: string): Promise<{ error: string | null }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может удалять шаблоны' };
    }

    try {
      if (!supabase) {
        return { error: 'Подключение к базе данных недоступно' };
      }

      const { error: deleteError } = await supabase
        .from('document_templates')
        .delete()
        .eq('id', id);

      if (deleteError) throw deleteError;

      await fetchTemplates();
      return { error: null };
    } catch (err) {
      console.error('Error deleting template:', err);
      return { error: 'Ошибка удаления шаблона' };
    }
  };

  const setAsDefault = async (id: string, type: DocumentTemplateType): Promise<{ error: string | null }> => {
    if (!isAdmin) {
      return { error: 'Только администратор может изменять шаблоны' };
    }

    try {
      if (!supabase) {
        return { error: 'Подключение к базе данных недоступно' };
      }

      await supabase
        .from('document_templates')
        .update({ is_default: false, updated_at: new Date().toISOString() })
        .eq('type', type);

      const { error: updateError } = await supabase
        .from('document_templates')
        .update({ is_default: true, updated_at: new Date().toISOString() })
        .eq('id', id);

      if (updateError) throw updateError;

      await fetchTemplates();
      return { error: null };
    } catch (err) {
      console.error('Error setting default template:', err);
      return { error: 'Ошибка установки шаблона по умолчанию' };
    }
  };

  return (
    <DocumentTemplatesContext.Provider
      value={{
        templates,
        isLoading,
        error,
        refreshTemplates: fetchTemplates,
        getTemplatesByType,
        getDefaultTemplate,
        createTemplate,
        updateTemplate,
        deleteTemplate,
        setAsDefault,
      }}
    >
      {children}
    </DocumentTemplatesContext.Provider>
  );
}

export function useDocumentTemplates() {
  const context = useContext(DocumentTemplatesContext);
  if (context === undefined) {
    throw new Error('useDocumentTemplates must be used within a DocumentTemplatesProvider');
  }
  return context;
}

export const TEMPLATE_TYPE_LABELS: Record<DocumentTemplateType, string> = {
  invoice: 'Счёт',
  act: 'Акт',
  contract: 'Договор',
  contract_annual: 'Годовой договор',
  waybill: 'Накладная',
};

export const TEMPLATE_VARIABLES = [
  { category: 'Документ', variables: [
    { key: '{{DOCUMENT_NUMBER}}', label: 'Номер документа' },
    { key: '{{DOCUMENT_DATE}}', label: 'Дата документа' },
    { key: '{{DOCUMENT_DATE_LONG}}', label: 'Дата документа (полная)' },
  ]},
  { category: 'Заказ', variables: [
    { key: '{{ORDER_NUMBER}}', label: 'Номер заказа' },
    { key: '{{START_DATE}}', label: 'Дата начала' },
    { key: '{{START_DATE_LONG}}', label: 'Дата начала (полная)' },
    { key: '{{END_DATE}}', label: 'Дата окончания' },
    { key: '{{END_DATE_LONG}}', label: 'Дата окончания (полная)' },
    { key: '{{DAYS_COUNT}}', label: 'Количество дней' },
    { key: '{{NOTES}}', label: 'Примечания' },
  ]},
  { category: 'Клиент', variables: [
    { key: '{{CLIENT_NAME}}', label: 'Имя клиента' },
    { key: '{{CLIENT_COMPANY}}', label: 'Компания клиента' },
    { key: '{{CLIENT_INN}}', label: 'ИНН клиента' },
    { key: '{{CLIENT_KPP}}', label: 'КПП клиента' },
    { key: '{{CLIENT_ADDRESS}}', label: 'Адрес клиента' },
    { key: '{{CLIENT_PHONE}}', label: 'Телефон клиента' },
    { key: '{{CLIENT_EMAIL}}', label: 'Email клиента' },
    { key: '{{CLIENT_DIRECTOR}}', label: 'Директор клиента' },
  ]},
  { category: 'Компания', variables: [
    { key: '{{COMPANY_NAME}}', label: 'Название компании' },
    { key: '{{COMPANY_INN}}', label: 'ИНН компании' },
    { key: '{{COMPANY_KPP}}', label: 'КПП компании' },
    { key: '{{COMPANY_ADDRESS}}', label: 'Адрес компании' },
    { key: '{{COMPANY_PHONE}}', label: 'Телефон компании' },
    { key: '{{COMPANY_EMAIL}}', label: 'Email компании' },
    { key: '{{COMPANY_DIRECTOR}}', label: 'Директор' },
    { key: '{{COMPANY_DIRECTOR_POSITION}}', label: 'Должность директора' },
    { key: '{{COMPANY_BANK}}', label: 'Банк' },
    { key: '{{COMPANY_BIK}}', label: 'БИК' },
    { key: '{{COMPANY_ACCOUNT}}', label: 'Расчётный счёт' },
    { key: '{{COMPANY_CORR_ACCOUNT}}', label: 'Корр. счёт' },
  ]},
  { category: 'Суммы', variables: [
    { key: '{{TOTAL_PRICE}}', label: 'Итого' },
    { key: '{{TOTAL_WORDS}}', label: 'Итого прописью' },
    { key: '{{EQUIPMENT_TOTAL}}', label: 'Итого оборудование' },
  ]},
  { category: 'Оборудование', variables: [
    { key: '{{EQUIPMENT_DESCRIPTION}}', label: 'Описание оборудования' },
    { key: '{{KIT_COUNT}}', label: 'Количество комплектов' },
    { key: '{{RECEIVER_COUNT}}', label: 'Количество приёмников' },
    { key: '{{TRANSMITTER_COUNT}}', label: 'Количество передатчиков' },
    { key: '{{MICROPHONE_COUNT}}', label: 'Количество микрофонов' },
  ]},
  { category: 'Таблицы', variables: [
    { key: 'data-for="ITEMS"', label: 'Цикл по позициям (атрибут для <tr>)' },
    { key: 'data-for="EQUIPMENT"', label: 'Цикл по оборудованию (атрибут для <tr>)' },
    { key: '{{INDEX}}', label: 'Номер строки (внутри цикла)' },
    { key: '{{ITEM_NAME}}', label: 'Название позиции' },
    { key: '{{ITEM_QUANTITY}}', label: 'Количество' },
    { key: '{{ITEM_PRICE}}', label: 'Цена' },
    { key: '{{ITEM_SUM}}', label: 'Сумма' },
  ]},
];
