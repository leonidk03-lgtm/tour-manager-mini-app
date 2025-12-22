import * as Print from 'expo-print';
import * as Sharing from 'expo-sharing';
import * as FileSystem from 'expo-file-system';
import { Platform, Alert } from 'react-native';
import { CompanySettings } from '@/contexts/CompanySettingsContext';
import { RentalClient, RentalOrder, RentalOrderService } from '@/contexts/RentalContext';
import { 
  generateInvoiceHtml, 
  generateActHtml, 
  generateContractHtml, 
  generateWaybillHtml,
  DocumentData 
} from './templates';
import { formatDate } from './helpers';

export type DocumentType = 'invoice' | 'act' | 'contract' | 'waybill';

const DOCUMENT_NAMES: Record<DocumentType, string> = {
  invoice: 'Счёт',
  act: 'Акт',
  contract: 'Договор',
  waybill: 'Накладная',
};

export interface GenerateDocumentParams {
  type: DocumentType;
  company: CompanySettings;
  client: RentalClient;
  order: RentalOrder;
  services?: RentalOrderService[];
  documentNumber: string;
  documentDate?: string;
}

function getHtmlForDocument(params: GenerateDocumentParams): string {
  const data: DocumentData = {
    company: params.company,
    client: params.client,
    order: params.order,
    services: params.services,
    documentNumber: params.documentNumber,
    documentDate: params.documentDate || new Date().toISOString(),
  };

  switch (params.type) {
    case 'invoice':
      return generateInvoiceHtml(data);
    case 'act':
      return generateActHtml(data);
    case 'contract':
      return generateContractHtml(data);
    case 'waybill':
      return generateWaybillHtml(data, 'issue');
    default:
      throw new Error(`Unknown document type: ${params.type}`);
  }
}

function getFileName(type: DocumentType, documentNumber: string, orderNumber: number): string {
  const name = DOCUMENT_NAMES[type];
  const date = formatDate(new Date().toISOString()).replace(/\./g, '-');
  return `${name}_${documentNumber}_Заказ${orderNumber}_${date}.pdf`;
}

export async function generateAndShareDocument(params: GenerateDocumentParams): Promise<boolean> {
  try {
    const html = getHtmlForDocument(params);
    const fileName = getFileName(params.type, params.documentNumber, params.order.orderNumber);

    if (Platform.OS === 'web') {
      const printWindow = window.open('', '_blank');
      if (printWindow) {
        printWindow.document.write(html);
        printWindow.document.close();
        printWindow.print();
      }
      return true;
    }

    const { uri } = await Print.printToFileAsync({
      html,
      width: 595,
      height: 842,
    });

    const isAvailable = await Sharing.isAvailableAsync();
    
    if (isAvailable) {
      const newUri = `${FileSystem.cacheDirectory}${fileName}`;
      await FileSystem.moveAsync({ from: uri, to: newUri });
      await Sharing.shareAsync(newUri, {
        mimeType: 'application/pdf',
        dialogTitle: `Поделиться: ${DOCUMENT_NAMES[params.type]}`,
      });
    } else {
      Alert.alert('Документ создан', `Файл сохранён: ${fileName}`);
    }

    return true;
  } catch (error) {
    console.error('Error generating document:', error);
    Alert.alert('Ошибка', 'Не удалось создать документ');
    return false;
  }
}

export async function printDocument(params: GenerateDocumentParams): Promise<boolean> {
  try {
    const html = getHtmlForDocument(params);
    
    if (Platform.OS === 'web') {
      const printWindow = window.open('', '_blank');
      if (printWindow) {
        printWindow.document.write(html);
        printWindow.document.close();
        printWindow.print();
      }
      return true;
    }

    await Print.printAsync({ html });
    return true;
  } catch (error) {
    console.error('Error printing document:', error);
    Alert.alert('Ошибка', 'Не удалось распечатать документ');
    return false;
  }
}

export function previewDocumentHtml(params: GenerateDocumentParams): string {
  return getHtmlForDocument(params);
}
