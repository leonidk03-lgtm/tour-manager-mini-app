import { CompanySettings } from '@/contexts/CompanySettingsContext';
import { RentalClient, RentalOrder, RentalOrderService } from '@/contexts/RentalContext';
import { getDocumentStyles, formatDate, formatDateLong, formatCurrency, amountToWords, pluralize } from './helpers';

export interface DocumentData {
  company: CompanySettings;
  client: RentalClient;
  order: RentalOrder;
  services?: RentalOrderService[];
  documentNumber: string;
  documentDate: string;
}

function renderCompanyRequisites(company: CompanySettings): string {
  const parts = [company.companyName];
  if (company.inn) parts.push(`ИНН: ${company.inn}`);
  if (company.kpp) parts.push(`КПП: ${company.kpp}`);
  if (company.ogrn) parts.push(`ОГРН: ${company.ogrn}`);
  if (company.legalAddress) parts.push(`Адрес: ${company.legalAddress}`);
  if (company.phone) parts.push(`Тел.: ${company.phone}`);
  if (company.email) parts.push(`E-mail: ${company.email}`);
  return parts.join('<br>');
}

function renderBankRequisites(company: CompanySettings): string {
  if (!company.bankName) return '';
  const parts = [`Банк: ${company.bankName}`];
  if (company.bik) parts.push(`БИК: ${company.bik}`);
  if (company.correspondentAccount) parts.push(`К/с: ${company.correspondentAccount}`);
  if (company.settlementAccount) parts.push(`Р/с: ${company.settlementAccount}`);
  return parts.join('<br>');
}

function renderClientRequisites(client: RentalClient): string {
  const parts = [];
  if (client.type === 'company' && client.companyName) {
    parts.push(client.companyName);
  } else {
    parts.push(client.name);
  }
  if (client.inn) parts.push(`ИНН: ${client.inn}`);
  if (client.kpp) parts.push(`КПП: ${client.kpp}`);
  if (client.legalAddress) parts.push(`Адрес: ${client.legalAddress}`);
  if (client.phone) parts.push(`Тел.: ${client.phone}`);
  if (client.email) parts.push(`E-mail: ${client.email}`);
  return parts.join('<br>');
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
  return parts.join(', ');
}

export function generateInvoiceHtml(data: DocumentData): string {
  const { company, client, order, services = [], documentNumber, documentDate } = data;

  let itemsHtml = '';
  let itemNum = 1;
  let totalAmount = 0;

  const totalEquipment = order.kitCount + order.spareReceiverCount + order.transmitterCount + order.microphoneCount;
  if (totalEquipment > 0) {
    const equipmentTotal = order.totalPrice - services.reduce((sum, s) => sum + s.price * s.quantity, 0);
    itemsHtml += `
      <tr>
        <td class="text-center">${itemNum++}</td>
        <td>Аренда оборудования для синхронного перевода (${getEquipmentDescription(order)})<br>
        Период: ${formatDate(order.startDate)} - ${formatDate(order.endDate)} (${order.daysCount} ${pluralize(order.daysCount, 'день', 'дня', 'дней')})</td>
        <td class="text-center">1</td>
        <td class="text-right">${formatCurrency(equipmentTotal)}</td>
        <td class="text-right">${formatCurrency(equipmentTotal)}</td>
      </tr>
    `;
    totalAmount += equipmentTotal;
  }

  for (const service of services) {
    const serviceTotal = service.price * service.quantity;
    itemsHtml += `
      <tr>
        <td class="text-center">${itemNum++}</td>
        <td>${service.serviceName}</td>
        <td class="text-center">${service.quantity}</td>
        <td class="text-right">${formatCurrency(service.price)}</td>
        <td class="text-right">${formatCurrency(serviceTotal)}</td>
      </tr>
    `;
    totalAmount += serviceTotal;
  }

  return `
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <title>Счёт ${documentNumber}</title>
      ${getDocumentStyles()}
    </head>
    <body>
      <div class="document">
        <div class="section requisites">
          ${renderCompanyRequisites(company)}
          <div style="margin-top: 5px;">
            ${renderBankRequisites(company)}
          </div>
        </div>

        <div class="divider"></div>

        <div class="header">
          <div class="title">СЧЁТ НА ОПЛАТУ № ${documentNumber}</div>
          <div class="subtitle">от ${formatDateLong(documentDate)}</div>
        </div>

        <div class="section">
          <div class="row">
            <span class="label">Поставщик:</span>
            <span>${company.companyName}</span>
          </div>
          <div class="row">
            <span class="label">Покупатель:</span>
            <span>${client.type === 'company' && client.companyName ? client.companyName : client.name}</span>
          </div>
        </div>

        <table>
          <thead>
            <tr>
              <th class="text-center" style="width: 30px;">№</th>
              <th>Наименование товара/услуги</th>
              <th class="text-center" style="width: 50px;">Кол-во</th>
              <th class="text-right" style="width: 90px;">Цена, ₽</th>
              <th class="text-right" style="width: 90px;">Сумма, ₽</th>
            </tr>
          </thead>
          <tbody>
            ${itemsHtml}
            <tr class="total-row">
              <td colspan="4" class="text-right">ИТОГО:</td>
              <td class="text-right">${formatCurrency(totalAmount)}</td>
            </tr>
          </tbody>
        </table>

        <div class="section">
          <p class="bold">Итого к оплате: ${formatCurrency(totalAmount)} руб.</p>
          <p>(${amountToWords(totalAmount)})</p>
        </div>

        <div class="note">
          Счёт действителен в течение 5 банковских дней.<br>
          НДС не облагается в связи с применением УСН.
        </div>

        <div class="signatures">
          <div class="signature-block">
            <p class="bold">${company.directorPosition || 'Руководитель'}</p>
            <div class="signature-line"></div>
            <p>${company.directorName || ''}</p>
          </div>
        </div>

        <div class="stamp-area">М.П.</div>
      </div>
    </body>
    </html>
  `;
}

export function generateActHtml(data: DocumentData): string {
  const { company, client, order, services = [], documentNumber, documentDate } = data;

  let itemsHtml = '';
  let itemNum = 1;
  let totalAmount = 0;

  const totalEquipment = order.kitCount + order.spareReceiverCount + order.transmitterCount + order.microphoneCount;
  if (totalEquipment > 0) {
    const equipmentTotal = order.totalPrice - services.reduce((sum, s) => sum + s.price * s.quantity, 0);
    itemsHtml += `
      <tr>
        <td class="text-center">${itemNum++}</td>
        <td>Услуги по предоставлению оборудования для синхронного перевода в аренду<br>
        Период: ${formatDate(order.startDate)} - ${formatDate(order.endDate)}</td>
        <td class="text-center">1</td>
        <td class="text-right">${formatCurrency(equipmentTotal)}</td>
        <td class="text-right">${formatCurrency(equipmentTotal)}</td>
      </tr>
    `;
    totalAmount += equipmentTotal;
  }

  for (const service of services) {
    const serviceTotal = service.price * service.quantity;
    itemsHtml += `
      <tr>
        <td class="text-center">${itemNum++}</td>
        <td>${service.serviceName}</td>
        <td class="text-center">${service.quantity}</td>
        <td class="text-right">${formatCurrency(service.price)}</td>
        <td class="text-right">${formatCurrency(serviceTotal)}</td>
      </tr>
    `;
    totalAmount += serviceTotal;
  }

  return `
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <title>Акт ${documentNumber}</title>
      ${getDocumentStyles()}
    </head>
    <body>
      <div class="document">
        <div class="header">
          <div class="title">АКТ № ${documentNumber}</div>
          <div class="subtitle">оказанных услуг</div>
          <div class="subtitle">от ${formatDateLong(documentDate)}</div>
        </div>

        <div class="section">
          <p><span class="label">Исполнитель:</span> ${company.companyName}${company.inn ? `, ИНН ${company.inn}` : ''}</p>
          <p><span class="label">Заказчик:</span> ${client.type === 'company' && client.companyName ? client.companyName : client.name}${client.inn ? `, ИНН ${client.inn}` : ''}</p>
        </div>

        <p>Мы, нижеподписавшиеся, составили настоящий акт о том, что Исполнителем были оказаны следующие услуги:</p>

        <table>
          <thead>
            <tr>
              <th class="text-center" style="width: 30px;">№</th>
              <th>Наименование услуги</th>
              <th class="text-center" style="width: 50px;">Кол-во</th>
              <th class="text-right" style="width: 90px;">Цена, ₽</th>
              <th class="text-right" style="width: 90px;">Сумма, ₽</th>
            </tr>
          </thead>
          <tbody>
            ${itemsHtml}
            <tr class="total-row">
              <td colspan="4" class="text-right">ИТОГО:</td>
              <td class="text-right">${formatCurrency(totalAmount)}</td>
            </tr>
          </tbody>
        </table>

        <div class="section">
          <p>Всего оказано услуг на сумму: <span class="bold">${formatCurrency(totalAmount)} руб.</span></p>
          <p>(${amountToWords(totalAmount)})</p>
          <p style="margin-top: 10px;">НДС не облагается в связи с применением УСН.</p>
        </div>

        <p>Вышеперечисленные услуги выполнены полностью и в срок. Заказчик претензий по объёму, качеству и срокам оказания услуг не имеет.</p>

        <div class="signatures">
          <div class="signature-block">
            <p class="bold">ИСПОЛНИТЕЛЬ:</p>
            <p>${company.companyName}</p>
            <div class="signature-line"></div>
            <p>${company.directorName || ''}</p>
            <div class="stamp-area">М.П.</div>
          </div>
          <div class="signature-block">
            <p class="bold">ЗАКАЗЧИК:</p>
            <p>${client.type === 'company' && client.companyName ? client.companyName : client.name}</p>
            <div class="signature-line"></div>
            <p>${client.type === 'company' ? (client.ceoName || client.directorName || '') : client.name}</p>
            <div class="stamp-area">М.П.</div>
          </div>
        </div>
      </div>
    </body>
    </html>
  `;
}

export function generateContractHtml(data: DocumentData): string {
  const { company, client, order, documentNumber, documentDate } = data;

  return `
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <title>Договор ${documentNumber}</title>
      ${getDocumentStyles()}
      <style>
        .contract-text { text-align: justify; }
        .contract-text p { margin-bottom: 8px; text-indent: 20px; }
        .contract-text ol { margin-left: 20px; margin-bottom: 10px; }
        .contract-text li { margin-bottom: 5px; }
      </style>
    </head>
    <body>
      <div class="document">
        <div class="header">
          <div class="title">ДОГОВОР АРЕНДЫ ОБОРУДОВАНИЯ</div>
          <div class="subtitle">№ ${documentNumber} от ${formatDateLong(documentDate)}</div>
        </div>

        <div class="section contract-text">
          <p><strong>${company.companyName}</strong>, в лице ${company.directorPosition || 'руководителя'} ${company.directorName || '____________'}, именуемый в дальнейшем «Арендодатель», с одной стороны, и <strong>${client.type === 'company' && client.companyName ? client.companyName : client.name}</strong>${client.type === 'company' && (client.ceoName || client.directorName) ? `, в лице ${client.ceoName || client.directorName}` : ''}, именуемый в дальнейшем «Арендатор», с другой стороны, заключили настоящий договор о нижеследующем:</p>
        </div>

        <div class="section contract-text">
          <p class="bold">1. ПРЕДМЕТ ДОГОВОРА</p>
          <p>1.1. Арендодатель обязуется предоставить Арендатору во временное пользование (аренду) оборудование для синхронного перевода, а Арендатор обязуется принять и оплатить аренду указанного оборудования.</p>
          <p>1.2. Состав оборудования: ${getEquipmentDescription(order) || 'согласно спецификации'}.</p>
          <p>1.3. Срок аренды: с ${formatDateLong(order.startDate)} по ${formatDateLong(order.endDate)} (${order.daysCount} ${pluralize(order.daysCount, 'день', 'дня', 'дней')}).</p>
        </div>

        <div class="section contract-text">
          <p class="bold">2. СТОИМОСТЬ И ПОРЯДОК РАСЧЁТОВ</p>
          <p>2.1. Стоимость аренды составляет ${formatCurrency(order.totalPrice)} (${amountToWords(order.totalPrice)}) рублей.</p>
          <p>2.2. НДС не облагается в связи с применением Арендодателем упрощённой системы налогообложения.</p>
          <p>2.3. Оплата производится путём перечисления денежных средств на расчётный счёт Арендодателя или наличными денежными средствами.</p>
        </div>

        <div class="section contract-text">
          <p class="bold">3. ПРАВА И ОБЯЗАННОСТИ СТОРОН</p>
          <p>3.1. Арендодатель обязуется:</p>
          <p style="margin-left: 20px;">- предоставить оборудование в исправном состоянии;</p>
          <p style="margin-left: 20px;">- провести инструктаж по использованию оборудования.</p>
          <p>3.2. Арендатор обязуется:</p>
          <p style="margin-left: 20px;">- использовать оборудование по назначению;</p>
          <p style="margin-left: 20px;">- обеспечить сохранность оборудования;</p>
          <p style="margin-left: 20px;">- вернуть оборудование в исправном состоянии.</p>
        </div>

        <div class="section contract-text">
          <p class="bold">4. ОТВЕТСТВЕННОСТЬ СТОРОН</p>
          <p>4.1. В случае утраты или повреждения оборудования Арендатор возмещает его стоимость.</p>
          <p>4.2. За просрочку возврата оборудования Арендатор уплачивает стоимость аренды за каждый день просрочки.</p>
        </div>

        <div class="section contract-text">
          <p class="bold">5. СРОК ДЕЙСТВИЯ ДОГОВОРА</p>
          <p>5.1. Договор вступает в силу с момента подписания и действует до полного исполнения сторонами своих обязательств.</p>
        </div>

        <div class="section contract-text">
          <p class="bold">6. РЕКВИЗИТЫ И ПОДПИСИ СТОРОН</p>
        </div>

        <div class="signatures">
          <div class="signature-block">
            <p class="bold">АРЕНДОДАТЕЛЬ:</p>
            <div class="requisites">
              ${renderCompanyRequisites(company)}
              <div style="margin-top: 5px;">
                ${renderBankRequisites(company)}
              </div>
            </div>
            <div class="signature-line"></div>
            <p>${company.directorName || ''}</p>
            <div class="stamp-area">М.П.</div>
          </div>
          <div class="signature-block">
            <p class="bold">АРЕНДАТОР:</p>
            <div class="requisites">
              ${renderClientRequisites(client)}
            </div>
            <div class="signature-line"></div>
            <p>${client.type === 'company' ? (client.ceoName || client.directorName || '') : client.name}</p>
            <div class="stamp-area">М.П.</div>
          </div>
        </div>
      </div>
    </body>
    </html>
  `;
}

export function generateWaybillHtml(data: DocumentData, type: 'issue' | 'return' = 'issue'): string {
  const { company, client, order, documentNumber, documentDate } = data;

  const items: { name: string; count: number }[] = [];
  if (order.kitCount > 0) {
    items.push({ name: 'Комплект радиогида (приёмники с наушниками)', count: order.kitCount });
  }
  if (order.spareReceiverCount > 0) {
    items.push({ name: 'Приёмник дополнительный', count: order.spareReceiverCount });
  }
  if (order.transmitterCount > 0) {
    items.push({ name: 'Передатчик', count: order.transmitterCount });
  }
  if (order.microphoneCount > 0) {
    items.push({ name: 'Микрофон', count: order.microphoneCount });
  }
  if (order.bagNumber) {
    items.push({ name: `Сумка № ${order.bagNumber}`, count: 1 });
  }

  let itemsHtml = items.map((item, idx) => `
    <tr>
      <td class="text-center">${idx + 1}</td>
      <td>${item.name}</td>
      <td class="text-center">${item.count}</td>
      <td></td>
    </tr>
  `).join('');

  const title = type === 'issue' ? 'НАКЛАДНАЯ НА ВЫДАЧУ' : 'НАКЛАДНАЯ НА ВОЗВРАТ';
  const actionText = type === 'issue' 
    ? 'Оборудование передано в аренду по договору' 
    : 'Оборудование возвращено из аренды по договору';

  return `
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="UTF-8">
      <title>Накладная ${documentNumber}</title>
      ${getDocumentStyles()}
    </head>
    <body>
      <div class="document">
        <div class="header">
          <div class="title">${title}</div>
          <div class="subtitle">№ ${documentNumber} от ${formatDateLong(documentDate)}</div>
        </div>

        <div class="section">
          <p><span class="label">Отправитель:</span> ${type === 'issue' ? company.companyName : (client.type === 'company' && client.companyName ? client.companyName : client.name)}</p>
          <p><span class="label">Получатель:</span> ${type === 'issue' ? (client.type === 'company' && client.companyName ? client.companyName : client.name) : company.companyName}</p>
          <p><span class="label">Основание:</span> ${actionText} № ${order.orderNumber}</p>
        </div>

        <table>
          <thead>
            <tr>
              <th class="text-center" style="width: 30px;">№</th>
              <th>Наименование</th>
              <th class="text-center" style="width: 80px;">Количество</th>
              <th class="text-center" style="width: 120px;">Примечание</th>
            </tr>
          </thead>
          <tbody>
            ${itemsHtml}
          </tbody>
        </table>

        <div class="section" style="margin-top: 20px;">
          <p>Оборудование ${type === 'issue' ? 'передано' : 'принято'} в ${type === 'issue' ? 'исправном' : '____________'} состоянии.</p>
          ${order.receiverNotes ? `<p><span class="label">Примечания:</span> ${order.receiverNotes}</p>` : ''}
        </div>

        <div class="signatures">
          <div class="signature-block">
            <p class="bold">${type === 'issue' ? 'СДАЛ:' : 'ПРИНЯЛ:'}</p>
            <div class="signature-line"></div>
            <p>${type === 'issue' ? (company.directorName || '') : (client.type === 'company' ? (client.ceoName || client.directorName || client.name) : client.name)}</p>
          </div>
          <div class="signature-block">
            <p class="bold">${type === 'issue' ? 'ПРИНЯЛ:' : 'СДАЛ:'}</p>
            <div class="signature-line"></div>
            <p>${type === 'issue' ? (client.type === 'company' ? (client.ceoName || client.directorName || client.name) : client.name) : (company.directorName || '')}</p>
          </div>
        </div>

        <p class="note" style="margin-top: 20px;">Дата: ${formatDateLong(documentDate)}</p>
      </div>
    </body>
    </html>
  `;
}
