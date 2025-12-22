import { CompanySettings } from '@/contexts/CompanySettingsContext';
import { RentalClient, RentalOrder, RentalOrderService } from '@/contexts/RentalContext';
import { formatDate, formatDateLong, formatCurrency, amountToWords, pluralize } from './helpers';

export interface TemplateData {
  company: CompanySettings;
  client: RentalClient;
  order: RentalOrder;
  services?: RentalOrderService[];
  documentNumber: string;
  documentDate: string;
}

interface ItemData {
  index: number;
  name: string;
  quantity: number;
  unit: string;
  price: number;
  sum: number;
}

function getEquipmentDescription(order: RentalOrder): string {
  const parts = [];
  if (order.kitCount > 0) {
    parts.push(`Комплект радиогида - ${order.kitCount} ${pluralize(order.kitCount, 'шт', 'шт', 'шт')}`);
  }
  if (order.spareReceiverCount > 0) {
    parts.push(`Приёмник дополнительный - ${order.spareReceiverCount} шт`);
  }
  if (order.transmitterCount > 0) {
    parts.push(`Передатчик - ${order.transmitterCount} шт`);
  }
  if (order.microphoneCount > 0) {
    parts.push(`Микрофон - ${order.microphoneCount} шт`);
  }
  return parts.join(', ') || 'Оборудование для синхронного перевода';
}

function buildVariables(data: TemplateData): Record<string, string> {
  const { company, client, order, services = [], documentNumber, documentDate } = data;

  const totalEquipment = order.kitCount + order.spareReceiverCount + order.transmitterCount + order.microphoneCount;
  const servicesTotal = services.reduce((sum, s) => sum + s.price * s.quantity, 0);
  const equipmentTotal = totalEquipment > 0 ? order.totalPrice - servicesTotal : 0;

  const clientCompany = client.type === 'company' && client.companyName ? client.companyName : client.name;
  const clientDirector = client.type === 'company' ? (client.ceoName || client.directorName || client.name) : client.name;

  return {
    '{{DOCUMENT_NUMBER}}': documentNumber,
    '{{DOCUMENT_DATE}}': formatDate(documentDate),
    '{{DOCUMENT_DATE_LONG}}': formatDateLong(documentDate),

    '{{ORDER_NUMBER}}': String(order.orderNumber),
    '{{START_DATE}}': formatDate(order.startDate),
    '{{START_DATE_LONG}}': formatDateLong(order.startDate),
    '{{END_DATE}}': formatDate(order.endDate),
    '{{END_DATE_LONG}}': formatDateLong(order.endDate),
    '{{DAYS_COUNT}}': `${order.daysCount} ${pluralize(order.daysCount, 'день', 'дня', 'дней')}`,
    '{{NOTES}}': order.receiverNotes || '',

    '{{CLIENT_NAME}}': client.name,
    '{{CLIENT_COMPANY}}': clientCompany,
    '{{CLIENT_INN}}': client.inn || '',
    '{{CLIENT_KPP}}': client.kpp || '',
    '{{CLIENT_ADDRESS}}': client.legalAddress || '',
    '{{CLIENT_PHONE}}': client.phone || '',
    '{{CLIENT_EMAIL}}': client.email || '',
    '{{CLIENT_DIRECTOR}}': clientDirector,

    '{{COMPANY_NAME}}': company.companyName,
    '{{COMPANY_INN}}': company.inn || '',
    '{{COMPANY_KPP}}': company.kpp || '',
    '{{COMPANY_OGRN}}': company.ogrn || '',
    '{{COMPANY_ADDRESS}}': company.legalAddress || '',
    '{{COMPANY_ACTUAL_ADDRESS}}': company.actualAddress || company.legalAddress || '',
    '{{COMPANY_PHONE}}': company.phone || '',
    '{{COMPANY_EMAIL}}': company.email || '',
    '{{COMPANY_DIRECTOR}}': company.directorName || '',
    '{{COMPANY_DIRECTOR_POSITION}}': company.directorPosition || 'Индивидуальный предприниматель',
    '{{COMPANY_BANK}}': company.bankName || '',
    '{{COMPANY_BIK}}': company.bik || '',
    '{{COMPANY_ACCOUNT}}': company.settlementAccount || '',
    '{{COMPANY_CORR_ACCOUNT}}': company.correspondentAccount || '',

    '{{TOTAL_PRICE}}': formatCurrency(order.totalPrice),
    '{{TOTAL_PRICE_RAW}}': String(order.totalPrice),
    '{{TOTAL_WORDS}}': amountToWords(order.totalPrice),
    '{{EQUIPMENT_TOTAL}}': formatCurrency(equipmentTotal),
    '{{SERVICES_TOTAL}}': formatCurrency(servicesTotal),

    '{{EQUIPMENT_DESCRIPTION}}': getEquipmentDescription(order),
    '{{KIT_COUNT}}': String(order.kitCount),
    '{{RECEIVER_COUNT}}': String(order.spareReceiverCount),
    '{{TRANSMITTER_COUNT}}': String(order.transmitterCount),
    '{{MICROPHONE_COUNT}}': String(order.microphoneCount),
    '{{BAG_NUMBER}}': order.bagNumber || '',
  };
}

function buildItemsData(data: TemplateData): ItemData[] {
  const { order, services = [] } = data;
  const items: ItemData[] = [];
  let index = 1;

  const totalEquipment = order.kitCount + order.spareReceiverCount + order.transmitterCount + order.microphoneCount;
  if (totalEquipment > 0) {
    const servicesTotal = services.reduce((sum, s) => sum + s.price * s.quantity, 0);
    const equipmentTotal = order.totalPrice - servicesTotal;
    
    items.push({
      index: index++,
      name: `Аренда оборудования для синхронного перевода (${getEquipmentDescription(order)})\nПериод: ${formatDate(order.startDate)} - ${formatDate(order.endDate)} (${order.daysCount} ${pluralize(order.daysCount, 'день', 'дня', 'дней')})`,
      quantity: 1,
      unit: 'услуга',
      price: equipmentTotal,
      sum: equipmentTotal,
    });
  }

  for (const service of services) {
    items.push({
      index: index++,
      name: service.serviceName,
      quantity: service.quantity,
      unit: 'шт',
      price: service.price,
      sum: service.price * service.quantity,
    });
  }

  return items;
}

function buildEquipmentData(data: TemplateData): ItemData[] {
  const { order } = data;
  const items: ItemData[] = [];
  let index = 1;

  if (order.kitCount > 0) {
    items.push({
      index: index++,
      name: 'Комплект радиогида (приёмники с наушниками)',
      quantity: order.kitCount,
      unit: 'шт',
      price: 0,
      sum: 0,
    });
  }
  if (order.spareReceiverCount > 0) {
    items.push({
      index: index++,
      name: 'Приёмник дополнительный',
      quantity: order.spareReceiverCount,
      unit: 'шт',
      price: 0,
      sum: 0,
    });
  }
  if (order.transmitterCount > 0) {
    items.push({
      index: index++,
      name: 'Передатчик',
      quantity: order.transmitterCount,
      unit: 'шт',
      price: 0,
      sum: 0,
    });
  }
  if (order.microphoneCount > 0) {
    items.push({
      index: index++,
      name: 'Микрофон',
      quantity: order.microphoneCount,
      unit: 'шт',
      price: 0,
      sum: 0,
    });
  }
  if (order.bagNumber) {
    items.push({
      index: index++,
      name: `Сумка № ${order.bagNumber}`,
      quantity: 1,
      unit: 'шт',
      price: 0,
      sum: 0,
    });
  }

  return items;
}

function processRepeatingRows(html: string, data: TemplateData): string {
  const itemsData = buildItemsData(data);
  const equipmentData = buildEquipmentData(data);

  html = html.replace(/<tr[^>]*data-for="ITEMS"[^>]*>([\s\S]*?)<\/tr>/gi, (match, rowContent) => {
    return itemsData.map(item => {
      let row = rowContent;
      row = row.replace(/\{\{INDEX\}\}/g, String(item.index));
      row = row.replace(/\{\{ITEM_NAME\}\}/g, item.name);
      row = row.replace(/\{\{ITEM_QUANTITY\}\}/g, String(item.quantity));
      row = row.replace(/\{\{ITEM_UNIT\}\}/g, item.unit);
      row = row.replace(/\{\{ITEM_PRICE\}\}/g, formatCurrency(item.price));
      row = row.replace(/\{\{ITEM_SUM\}\}/g, formatCurrency(item.sum));
      return `<tr>${row}</tr>`;
    }).join('\n');
  });

  html = html.replace(/<tr[^>]*data-for="EQUIPMENT"[^>]*>([\s\S]*?)<\/tr>/gi, (match, rowContent) => {
    return equipmentData.map(item => {
      let row = rowContent;
      row = row.replace(/\{\{INDEX\}\}/g, String(item.index));
      row = row.replace(/\{\{ITEM_NAME\}\}/g, item.name);
      row = row.replace(/\{\{ITEM_QUANTITY\}\}/g, String(item.quantity));
      row = row.replace(/\{\{ITEM_UNIT\}\}/g, item.unit);
      row = row.replace(/\{\{ITEM_PRICE\}\}/g, formatCurrency(item.price));
      row = row.replace(/\{\{ITEM_SUM\}\}/g, formatCurrency(item.sum));
      return `<tr>${row}</tr>`;
    }).join('\n');
  });

  return html;
}

export function processTemplate(templateHtml: string, data: TemplateData): string {
  const variables = buildVariables(data);
  
  let html = processRepeatingRows(templateHtml, data);
  
  for (const [key, value] of Object.entries(variables)) {
    html = html.replace(new RegExp(key.replace(/[{}]/g, '\\$&'), 'g'), value);
  }

  return html;
}

export function wrapWithDocumentStyles(html: string): string {
  if (html.includes('<!DOCTYPE html>') || html.includes('<html')) {
    return html;
  }

  return `
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Times New Roman', Times, serif; font-size: 12pt; line-height: 1.4; color: #000; padding: 15mm; background: #fff; }
        .document { max-width: 190mm; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; margin: 10px 0; }
        th, td { border: 1px solid #000; padding: 5px 8px; text-align: left; }
        th { background: #f0f0f0; font-weight: bold; }
        .text-right { text-align: right; }
        .text-center { text-align: center; }
        .bold { font-weight: bold; }
      </style>
    </head>
    <body>
      <div class="document">
        ${html}
      </div>
    </body>
    </html>
  `;
}
