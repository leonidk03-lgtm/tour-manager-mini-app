export function formatDate(dateStr: string): string {
  const date = new Date(dateStr);
  return date.toLocaleDateString('ru-RU', {
    day: '2-digit',
    month: '2-digit',
    year: 'numeric'
  });
}

export function formatDateLong(dateStr: string): string {
  const date = new Date(dateStr);
  const months = [
    'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
    'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря'
  ];
  return `${date.getDate()} ${months[date.getMonth()]} ${date.getFullYear()} г.`;
}

export function formatCurrency(amount: number): string {
  return new Intl.NumberFormat('ru-RU', {
    style: 'decimal',
    minimumFractionDigits: 2,
    maximumFractionDigits: 2
  }).format(amount);
}

export function formatCurrencyInt(amount: number): string {
  return new Intl.NumberFormat('ru-RU').format(Math.round(amount));
}

export function numberToWords(num: number): string {
  const ones = ['', 'один', 'два', 'три', 'четыре', 'пять', 'шесть', 'семь', 'восемь', 'девять', 'десять',
    'одиннадцать', 'двенадцать', 'тринадцать', 'четырнадцать', 'пятнадцать', 'шестнадцать',
    'семнадцать', 'восемнадцать', 'девятнадцать'];
  const tens = ['', '', 'двадцать', 'тридцать', 'сорок', 'пятьдесят', 'шестьдесят', 'семьдесят', 'восемьдесят', 'девяносто'];
  const hundreds = ['', 'сто', 'двести', 'триста', 'четыреста', 'пятьсот', 'шестьсот', 'семьсот', 'восемьсот', 'девятьсот'];
  const thousands = ['тысяча', 'тысячи', 'тысяч'];

  if (num === 0) return 'ноль';
  if (num < 0) return 'минус ' + numberToWords(-num);

  let result = '';
  const n = Math.floor(num);

  if (n >= 1000) {
    const t = Math.floor(n / 1000);
    const tMod = t % 10;
    const tMod100 = t % 100;

    if (t < 20) {
      result += (t === 1 ? 'одна' : t === 2 ? 'две' : ones[t]) + ' ';
    } else {
      result += tens[Math.floor(t / 10)] + ' ';
      if (tMod > 0) {
        result += (tMod === 1 ? 'одна' : tMod === 2 ? 'две' : ones[tMod]) + ' ';
      }
    }

    if (tMod100 >= 11 && tMod100 <= 19) {
      result += thousands[2] + ' ';
    } else if (tMod === 1) {
      result += thousands[0] + ' ';
    } else if (tMod >= 2 && tMod <= 4) {
      result += thousands[1] + ' ';
    } else {
      result += thousands[2] + ' ';
    }
  }

  const remainder = n % 1000;
  if (remainder >= 100) {
    result += hundreds[Math.floor(remainder / 100)] + ' ';
  }

  const lastTwo = remainder % 100;
  if (lastTwo >= 20) {
    result += tens[Math.floor(lastTwo / 10)] + ' ';
    if (lastTwo % 10 > 0) {
      result += ones[lastTwo % 10] + ' ';
    }
  } else if (lastTwo > 0) {
    result += ones[lastTwo] + ' ';
  }

  return result.trim();
}

export function amountToWords(amount: number): string {
  const rubles = Math.floor(amount);
  const kopecks = Math.round((amount - rubles) * 100);

  const rubleMod = rubles % 10;
  const rubleMod100 = rubles % 100;
  let rubleWord = 'рублей';
  if (rubleMod100 >= 11 && rubleMod100 <= 19) {
    rubleWord = 'рублей';
  } else if (rubleMod === 1) {
    rubleWord = 'рубль';
  } else if (rubleMod >= 2 && rubleMod <= 4) {
    rubleWord = 'рубля';
  }

  const kopeckMod = kopecks % 10;
  const kopeckMod100 = kopecks % 100;
  let kopeckWord = 'копеек';
  if (kopeckMod100 >= 11 && kopeckMod100 <= 19) {
    kopeckWord = 'копеек';
  } else if (kopeckMod === 1) {
    kopeckWord = 'копейка';
  } else if (kopeckMod >= 2 && kopeckMod <= 4) {
    kopeckWord = 'копейки';
  }

  const rublesText = numberToWords(rubles);
  const capitalizedRubles = rublesText.charAt(0).toUpperCase() + rublesText.slice(1);

  return `${capitalizedRubles} ${rubleWord} ${kopecks.toString().padStart(2, '0')} ${kopeckWord}`;
}

export function pluralize(count: number, one: string, few: string, many: string): string {
  const mod10 = count % 10;
  const mod100 = count % 100;
  
  if (mod100 >= 11 && mod100 <= 19) {
    return many;
  }
  if (mod10 === 1) {
    return one;
  }
  if (mod10 >= 2 && mod10 <= 4) {
    return few;
  }
  return many;
}

export function getDocumentStyles(): string {
  return `
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }
      body {
        font-family: 'Times New Roman', Times, serif;
        font-size: 12pt;
        line-height: 1.4;
        color: #000;
        padding: 15mm;
        background: #fff;
      }
      .document {
        max-width: 190mm;
        margin: 0 auto;
      }
      .header {
        text-align: center;
        margin-bottom: 20px;
      }
      .title {
        font-size: 16pt;
        font-weight: bold;
        margin-bottom: 5px;
      }
      .subtitle {
        font-size: 12pt;
      }
      .section {
        margin-bottom: 15px;
      }
      .section-title {
        font-weight: bold;
        margin-bottom: 5px;
      }
      .row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 3px;
      }
      .label {
        font-weight: bold;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin: 10px 0;
      }
      th, td {
        border: 1px solid #000;
        padding: 5px 8px;
        text-align: left;
      }
      th {
        background: #f0f0f0;
        font-weight: bold;
      }
      .text-right {
        text-align: right;
      }
      .text-center {
        text-align: center;
      }
      .bold {
        font-weight: bold;
      }
      .total-row {
        font-weight: bold;
        background: #f9f9f9;
      }
      .signatures {
        margin-top: 30px;
        display: flex;
        justify-content: space-between;
      }
      .signature-block {
        width: 45%;
      }
      .signature-line {
        border-bottom: 1px solid #000;
        height: 30px;
        margin-top: 10px;
      }
      .requisites {
        font-size: 10pt;
        line-height: 1.3;
      }
      .stamp-area {
        margin-top: 20px;
        text-align: center;
        color: #666;
        font-size: 10pt;
      }
      .divider {
        border-top: 1px solid #000;
        margin: 15px 0;
      }
      .note {
        font-size: 10pt;
        color: #666;
        margin-top: 10px;
      }
      @media print {
        body {
          padding: 0;
        }
        .document {
          max-width: 100%;
        }
      }
    </style>
  `;
}
