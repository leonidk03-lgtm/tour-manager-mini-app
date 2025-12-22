-- Document Templates Table for TourManager
-- Run this SQL in your Supabase SQL Editor

CREATE TABLE IF NOT EXISTS document_templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type VARCHAR(50) NOT NULL,
  name VARCHAR(255) NOT NULL,
  html_content TEXT NOT NULL,
  is_default BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_document_templates_type ON document_templates(type);
CREATE INDEX IF NOT EXISTS idx_document_templates_is_default ON document_templates(is_default);

-- Enable RLS
ALTER TABLE document_templates ENABLE ROW LEVEL SECURITY;

-- Policy: All authenticated users can read templates
CREATE POLICY "Allow read access for authenticated users" ON document_templates
  FOR SELECT USING (auth.role() = 'authenticated');

-- Policy: Only admins can insert/update/delete templates (admin check via managers table)
CREATE POLICY "Allow admin write access" ON document_templates
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM managers 
      WHERE managers.user_id = auth.uid() 
      AND managers.role = 'admin'
    )
  );

-- Available template variables documentation:
-- 
-- Common Variables:
--   {{ORDER_NUMBER}} - Order number
--   {{ORDER_DATE}} - Order creation date
--   {{START_DATE}} - Rental start date (short format)
--   {{START_DATE_LONG}} - Rental start date (long format)
--   {{END_DATE}} - Rental end date (short format)
--   {{END_DATE_LONG}} - Rental end date (long format)
--   {{DAYS_COUNT}} - Number of rental days
--   {{DOCUMENT_NUMBER}} - Document number
--   {{DOCUMENT_DATE}} - Document date (short)
--   {{DOCUMENT_DATE_LONG}} - Document date (long format)
--
-- Client Variables:
--   {{CLIENT_NAME}} - Client name
--   {{CLIENT_COMPANY}} - Company name (if legal entity)
--   {{CLIENT_INN}} - Client INN
--   {{CLIENT_KPP}} - Client KPP
--   {{CLIENT_OGRN}} - Client OGRN
--   {{CLIENT_ADDRESS}} - Client legal address
--   {{CLIENT_ACTUAL_ADDRESS}} - Client actual address
--   {{CLIENT_PHONE}} - Client phone
--   {{CLIENT_EMAIL}} - Client email
--   {{CLIENT_DIRECTOR}} - Client director name
--   {{CLIENT_BANK}} - Client bank name
--   {{CLIENT_BIK}} - Client BIK
--   {{CLIENT_ACCOUNT}} - Client bank account
--
-- Company Variables (from company settings):
--   {{COMPANY_NAME}} - Company name
--   {{COMPANY_INN}} - Company INN
--   {{COMPANY_KPP}} - Company KPP
--   {{COMPANY_OGRN}} - Company OGRN
--   {{COMPANY_ADDRESS}} - Company legal address
--   {{COMPANY_ACTUAL_ADDRESS}} - Company actual address
--   {{COMPANY_PHONE}} - Company phone
--   {{COMPANY_EMAIL}} - Company email
--   {{COMPANY_DIRECTOR}} - Director name
--   {{COMPANY_DIRECTOR_POSITION}} - Director position
--   {{COMPANY_BANK}} - Bank name
--   {{COMPANY_BIK}} - BIK
--   {{COMPANY_CORR_ACCOUNT}} - Correspondent account
--   {{COMPANY_ACCOUNT}} - Settlement account
--
-- Price Variables:
--   {{TOTAL_PRICE}} - Total order price (formatted)
--   {{TOTAL_PRICE_RAW}} - Total order price (number)
--   {{TOTAL_WORDS}} - Total price in words
--   {{EQUIPMENT_TOTAL}} - Equipment total (formatted)
--   {{SERVICES_TOTAL}} - Services total (formatted)
--
-- Equipment Variables:
--   {{EQUIPMENT_DESCRIPTION}} - Equipment description text
--   {{KIT_COUNT}} - Number of radio guide kits
--   {{RECEIVER_COUNT}} - Number of spare receivers
--   {{TRANSMITTER_COUNT}} - Number of transmitters
--   {{MICROPHONE_COUNT}} - Number of microphones
--   {{BAG_NUMBER}} - Bag number
--
-- Table Variables (for repeating rows use data-for="ITEMS"):
--   Use with <tr data-for="ITEMS">...</tr>
--   Inside the row:
--     {{INDEX}} - Row number (1, 2, 3...)
--     {{ITEM_NAME}} - Item/service name
--     {{ITEM_QUANTITY}} - Quantity
--     {{ITEM_UNIT}} - Unit of measure
--     {{ITEM_PRICE}} - Price per unit
--     {{ITEM_SUM}} - Total for this item
--
-- Notes:
--   {{NOTES}} - Order notes/comments

-- Insert default templates
INSERT INTO document_templates (type, name, html_content, is_default) VALUES
(
  'invoice',
  'Счёт на оплату (стандартный)',
  '<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Счёт {{DOCUMENT_NUMBER}}</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: "Times New Roman", Times, serif; font-size: 12pt; line-height: 1.4; color: #000; padding: 15mm; background: #fff; }
    .document { max-width: 190mm; margin: 0 auto; }
    .header { text-align: center; margin-bottom: 20px; }
    .title { font-size: 16pt; font-weight: bold; margin-bottom: 5px; }
    .subtitle { font-size: 12pt; }
    .section { margin-bottom: 15px; }
    .row { margin-bottom: 3px; }
    .label { font-weight: bold; }
    table { width: 100%; border-collapse: collapse; margin: 10px 0; }
    th, td { border: 1px solid #000; padding: 5px 8px; text-align: left; }
    th { background: #f0f0f0; font-weight: bold; }
    .text-right { text-align: right; }
    .text-center { text-align: center; }
    .bold { font-weight: bold; }
    .total-row { font-weight: bold; background: #f9f9f9; }
    .signatures { margin-top: 30px; display: flex; justify-content: space-between; }
    .signature-block { width: 45%; }
    .signature-line { border-bottom: 1px solid #000; height: 30px; margin-top: 10px; }
    .stamp-area { margin-top: 20px; text-align: center; color: #666; font-size: 10pt; }
    .divider { border-top: 1px solid #000; margin: 15px 0; }
    .note { font-size: 10pt; color: #666; margin-top: 10px; }
    .requisites { font-size: 10pt; line-height: 1.3; }
  </style>
</head>
<body>
  <div class="document">
    <div class="section requisites">
      {{COMPANY_NAME}}<br>
      ИНН: {{COMPANY_INN}}<br>
      {{COMPANY_ADDRESS}}<br>
      Тел: {{COMPANY_PHONE}}
      <div style="margin-top: 5px;">
        Банк: {{COMPANY_BANK}}<br>
        БИК: {{COMPANY_BIK}}<br>
        К/с: {{COMPANY_CORR_ACCOUNT}}<br>
        Р/с: {{COMPANY_ACCOUNT}}
      </div>
    </div>

    <div class="divider"></div>

    <div class="header">
      <div class="title">СЧЁТ НА ОПЛАТУ № {{DOCUMENT_NUMBER}}</div>
      <div class="subtitle">от {{DOCUMENT_DATE_LONG}}</div>
    </div>

    <div class="section">
      <div class="row">
        <span class="label">Поставщик:</span> {{COMPANY_NAME}}
      </div>
      <div class="row">
        <span class="label">Покупатель:</span> {{CLIENT_COMPANY}}
      </div>
    </div>

    <table>
      <thead>
        <tr>
          <th class="text-center" style="width: 30px;">№</th>
          <th>Наименование товара/услуги</th>
          <th class="text-center" style="width: 50px;">Кол-во</th>
          <th class="text-right" style="width: 90px;">Цена, руб.</th>
          <th class="text-right" style="width: 90px;">Сумма, руб.</th>
        </tr>
      </thead>
      <tbody>
        <tr data-for="ITEMS">
          <td class="text-center">{{INDEX}}</td>
          <td>{{ITEM_NAME}}</td>
          <td class="text-center">{{ITEM_QUANTITY}}</td>
          <td class="text-right">{{ITEM_PRICE}}</td>
          <td class="text-right">{{ITEM_SUM}}</td>
        </tr>
        <tr class="total-row">
          <td colspan="4" class="text-right">ИТОГО:</td>
          <td class="text-right">{{TOTAL_PRICE}}</td>
        </tr>
      </tbody>
    </table>

    <div class="section">
      <p class="bold">Итого к оплате: {{TOTAL_PRICE}} руб.</p>
      <p>({{TOTAL_WORDS}})</p>
    </div>

    <div class="note">
      Счёт действителен в течение 5 банковских дней.<br>
      НДС не облагается в связи с применением УСН.
    </div>

    <div class="signatures">
      <div class="signature-block">
        <p class="bold">{{COMPANY_DIRECTOR_POSITION}}</p>
        <div class="signature-line"></div>
        <p>{{COMPANY_DIRECTOR}}</p>
      </div>
    </div>

    <div class="stamp-area">М.П.</div>
  </div>
</body>
</html>',
  true
),
(
  'act',
  'Акт выполненных работ (стандартный)',
  '<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Акт {{DOCUMENT_NUMBER}}</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: "Times New Roman", Times, serif; font-size: 12pt; line-height: 1.4; color: #000; padding: 15mm; background: #fff; }
    .document { max-width: 190mm; margin: 0 auto; }
    .header { text-align: center; margin-bottom: 20px; }
    .title { font-size: 16pt; font-weight: bold; margin-bottom: 5px; }
    .subtitle { font-size: 12pt; }
    .section { margin-bottom: 15px; }
    .label { font-weight: bold; }
    table { width: 100%; border-collapse: collapse; margin: 10px 0; }
    th, td { border: 1px solid #000; padding: 5px 8px; text-align: left; }
    th { background: #f0f0f0; font-weight: bold; }
    .text-right { text-align: right; }
    .text-center { text-align: center; }
    .bold { font-weight: bold; }
    .total-row { font-weight: bold; background: #f9f9f9; }
    .signatures { margin-top: 30px; display: flex; justify-content: space-between; }
    .signature-block { width: 45%; }
    .signature-line { border-bottom: 1px solid #000; height: 30px; margin-top: 10px; }
    .stamp-area { margin-top: 20px; text-align: center; color: #666; font-size: 10pt; }
  </style>
</head>
<body>
  <div class="document">
    <div class="header">
      <div class="title">АКТ № {{DOCUMENT_NUMBER}}</div>
      <div class="subtitle">оказанных услуг</div>
      <div class="subtitle">от {{DOCUMENT_DATE_LONG}}</div>
    </div>

    <div class="section">
      <p><span class="label">Исполнитель:</span> {{COMPANY_NAME}}, ИНН {{COMPANY_INN}}</p>
      <p><span class="label">Заказчик:</span> {{CLIENT_COMPANY}}, ИНН {{CLIENT_INN}}</p>
    </div>

    <p>Мы, нижеподписавшиеся, составили настоящий акт о том, что Исполнителем были оказаны следующие услуги:</p>

    <table>
      <thead>
        <tr>
          <th class="text-center" style="width: 30px;">№</th>
          <th>Наименование услуги</th>
          <th class="text-center" style="width: 50px;">Кол-во</th>
          <th class="text-right" style="width: 90px;">Цена, руб.</th>
          <th class="text-right" style="width: 90px;">Сумма, руб.</th>
        </tr>
      </thead>
      <tbody>
        <tr data-for="ITEMS">
          <td class="text-center">{{INDEX}}</td>
          <td>{{ITEM_NAME}}</td>
          <td class="text-center">{{ITEM_QUANTITY}}</td>
          <td class="text-right">{{ITEM_PRICE}}</td>
          <td class="text-right">{{ITEM_SUM}}</td>
        </tr>
        <tr class="total-row">
          <td colspan="4" class="text-right">ИТОГО:</td>
          <td class="text-right">{{TOTAL_PRICE}}</td>
        </tr>
      </tbody>
    </table>

    <div class="section">
      <p>Всего оказано услуг на сумму: <span class="bold">{{TOTAL_PRICE}} руб.</span></p>
      <p>({{TOTAL_WORDS}})</p>
      <p style="margin-top: 10px;">НДС не облагается в связи с применением УСН.</p>
    </div>

    <p>Вышеперечисленные услуги выполнены полностью и в срок. Заказчик претензий по объёму, качеству и срокам оказания услуг не имеет.</p>

    <div class="signatures">
      <div class="signature-block">
        <p class="bold">ИСПОЛНИТЕЛЬ:</p>
        <p>{{COMPANY_NAME}}</p>
        <div class="signature-line"></div>
        <p>{{COMPANY_DIRECTOR}}</p>
        <div class="stamp-area">М.П.</div>
      </div>
      <div class="signature-block">
        <p class="bold">ЗАКАЗЧИК:</p>
        <p>{{CLIENT_COMPANY}}</p>
        <div class="signature-line"></div>
        <p>{{CLIENT_DIRECTOR}}</p>
        <div class="stamp-area">М.П.</div>
      </div>
    </div>
  </div>
</body>
</html>',
  true
),
(
  'contract',
  'Договор аренды (стандартный)',
  '<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Договор {{DOCUMENT_NUMBER}}</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: "Times New Roman", Times, serif; font-size: 12pt; line-height: 1.4; color: #000; padding: 15mm; background: #fff; }
    .document { max-width: 190mm; margin: 0 auto; }
    .header { text-align: center; margin-bottom: 20px; }
    .title { font-size: 16pt; font-weight: bold; margin-bottom: 5px; }
    .subtitle { font-size: 12pt; }
    .section { margin-bottom: 15px; }
    .bold { font-weight: bold; }
    .signatures { margin-top: 30px; display: flex; justify-content: space-between; }
    .signature-block { width: 45%; }
    .signature-line { border-bottom: 1px solid #000; height: 30px; margin-top: 10px; }
    .requisites { font-size: 10pt; line-height: 1.3; }
    .stamp-area { margin-top: 20px; text-align: center; color: #666; font-size: 10pt; }
    .contract-text { text-align: justify; }
    .contract-text p { margin-bottom: 8px; text-indent: 20px; }
  </style>
</head>
<body>
  <div class="document">
    <div class="header">
      <div class="title">ДОГОВОР АРЕНДЫ ОБОРУДОВАНИЯ</div>
      <div class="subtitle">№ {{DOCUMENT_NUMBER}} от {{DOCUMENT_DATE_LONG}}</div>
    </div>

    <div class="section contract-text">
      <p><strong>{{COMPANY_NAME}}</strong>, в лице {{COMPANY_DIRECTOR_POSITION}} {{COMPANY_DIRECTOR}}, именуемый в дальнейшем «Арендодатель», с одной стороны, и <strong>{{CLIENT_COMPANY}}</strong>, именуемый в дальнейшем «Арендатор», с другой стороны, заключили настоящий договор о нижеследующем:</p>
    </div>

    <div class="section contract-text">
      <p class="bold">1. ПРЕДМЕТ ДОГОВОРА</p>
      <p>1.1. Арендодатель обязуется предоставить Арендатору во временное пользование (аренду) оборудование для синхронного перевода, а Арендатор обязуется принять и оплатить аренду указанного оборудования.</p>
      <p>1.2. Состав оборудования: {{EQUIPMENT_DESCRIPTION}}.</p>
      <p>1.3. Срок аренды: с {{START_DATE_LONG}} по {{END_DATE_LONG}} ({{DAYS_COUNT}} дней).</p>
    </div>

    <div class="section contract-text">
      <p class="bold">2. СТОИМОСТЬ И ПОРЯДОК РАСЧЁТОВ</p>
      <p>2.1. Стоимость аренды составляет {{TOTAL_PRICE}} ({{TOTAL_WORDS}}) рублей.</p>
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
          {{COMPANY_NAME}}<br>
          ИНН: {{COMPANY_INN}}<br>
          {{COMPANY_ADDRESS}}<br>
          Банк: {{COMPANY_BANK}}<br>
          БИК: {{COMPANY_BIK}}<br>
          Р/с: {{COMPANY_ACCOUNT}}
        </div>
        <div class="signature-line"></div>
        <p>{{COMPANY_DIRECTOR}}</p>
        <div class="stamp-area">М.П.</div>
      </div>
      <div class="signature-block">
        <p class="bold">АРЕНДАТОР:</p>
        <div class="requisites">
          {{CLIENT_COMPANY}}<br>
          ИНН: {{CLIENT_INN}}<br>
          {{CLIENT_ADDRESS}}<br>
          Тел: {{CLIENT_PHONE}}
        </div>
        <div class="signature-line"></div>
        <p>{{CLIENT_DIRECTOR}}</p>
        <div class="stamp-area">М.П.</div>
      </div>
    </div>
  </div>
</body>
</html>',
  true
),
(
  'waybill',
  'Накладная (стандартная)',
  '<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Накладная {{DOCUMENT_NUMBER}}</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: "Times New Roman", Times, serif; font-size: 12pt; line-height: 1.4; color: #000; padding: 15mm; background: #fff; }
    .document { max-width: 190mm; margin: 0 auto; }
    .header { text-align: center; margin-bottom: 20px; }
    .title { font-size: 16pt; font-weight: bold; margin-bottom: 5px; }
    .subtitle { font-size: 12pt; }
    .section { margin-bottom: 15px; }
    .label { font-weight: bold; }
    table { width: 100%; border-collapse: collapse; margin: 10px 0; }
    th, td { border: 1px solid #000; padding: 5px 8px; text-align: left; }
    th { background: #f0f0f0; font-weight: bold; }
    .text-center { text-align: center; }
    .signatures { margin-top: 30px; display: flex; justify-content: space-between; }
    .signature-block { width: 45%; }
    .signature-line { border-bottom: 1px solid #000; height: 30px; margin-top: 10px; }
    .bold { font-weight: bold; }
    .note { font-size: 10pt; color: #666; margin-top: 10px; }
  </style>
</head>
<body>
  <div class="document">
    <div class="header">
      <div class="title">НАКЛАДНАЯ НА ВЫДАЧУ</div>
      <div class="subtitle">№ {{DOCUMENT_NUMBER}} от {{DOCUMENT_DATE_LONG}}</div>
    </div>

    <div class="section">
      <p><span class="label">Отправитель:</span> {{COMPANY_NAME}}</p>
      <p><span class="label">Получатель:</span> {{CLIENT_COMPANY}}</p>
      <p><span class="label">Основание:</span> Договор аренды № {{ORDER_NUMBER}}</p>
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
        <tr data-for="EQUIPMENT">
          <td class="text-center">{{INDEX}}</td>
          <td>{{ITEM_NAME}}</td>
          <td class="text-center">{{ITEM_QUANTITY}}</td>
          <td></td>
        </tr>
      </tbody>
    </table>

    <div class="section" style="margin-top: 20px;">
      <p>Оборудование передано в исправном состоянии.</p>
    </div>

    <div class="signatures">
      <div class="signature-block">
        <p class="bold">СДАЛ:</p>
        <div class="signature-line"></div>
        <p>{{COMPANY_DIRECTOR}}</p>
      </div>
      <div class="signature-block">
        <p class="bold">ПРИНЯЛ:</p>
        <div class="signature-line"></div>
        <p>{{CLIENT_DIRECTOR}}</p>
      </div>
    </div>

    <p class="note" style="margin-top: 20px;">Дата: {{DOCUMENT_DATE_LONG}}</p>
  </div>
</body>
</html>',
  true
);
