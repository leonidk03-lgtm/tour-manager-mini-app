import { Excursion, TourType, AdditionalService, Transaction } from "@/contexts/DataContext";

export function calculateExcursionRevenue(
  excursion: Excursion,
  tourType: TourType,
  additionalServices: AdditionalService[]
): number {
  const ticketRevenue =
    excursion.fullPriceCount * tourType.fullPrice +
    excursion.discountedCount * tourType.discountedPrice;

  const servicesRevenue = excursion.additionalServices.reduce((sum, service) => {
    const serviceData = additionalServices.find((s) => s.id === service.serviceId);
    return sum + (serviceData ? serviceData.price * service.count : 0);
  }, 0);

  return ticketRevenue + servicesRevenue;
}

export function calculateExcursionExpenses(excursion: Excursion): number {
  return excursion.expenses.reduce((sum, expense) => sum + expense.amount, 0);
}

export function calculateExcursionProfit(
  excursion: Excursion,
  tourType: TourType,
  additionalServices: AdditionalService[]
): number {
  const revenue = calculateExcursionRevenue(excursion, tourType, additionalServices);
  const expenses = calculateExcursionExpenses(excursion);
  return revenue - expenses;
}

export function formatCurrency(amount: number): string {
  return amount.toLocaleString("ru-RU") + " р.";
}

export function filterExcursionsByDateRange(
  excursions: Excursion[],
  startDate: string,
  endDate: string
): Excursion[] {
  return excursions.filter((exc) => exc.date >= startDate && exc.date <= endDate);
}

function formatLocalDate(date: Date): string {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
}

export function getDateRangeForPeriod(period: "day" | "week" | "month", referenceDate: Date): {
  startDate: string;
  endDate: string;
} {
  const date = new Date(referenceDate);
  date.setHours(0, 0, 0, 0);

  if (period === "day") {
    const dateStr = formatLocalDate(date);
    return { startDate: dateStr, endDate: dateStr };
  }

  if (period === "week") {
    const dayOfWeek = date.getDay();
    const diff = dayOfWeek === 0 ? -6 : 1 - dayOfWeek;
    const monday = new Date(date);
    monday.setDate(date.getDate() + diff);
    const sunday = new Date(monday);
    sunday.setDate(monday.getDate() + 6);
    return {
      startDate: formatLocalDate(monday),
      endDate: formatLocalDate(sunday),
    };
  }

  const firstDay = new Date(date.getFullYear(), date.getMonth(), 1);
  const lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
  return {
    startDate: formatLocalDate(firstDay),
    endDate: formatLocalDate(lastDay),
  };
}

export function calculateTotalRevenue(
  excursions: Excursion[],
  tourTypes: TourType[],
  additionalServices: AdditionalService[]
): number {
  return excursions.reduce((sum, exc) => {
    const tourType = tourTypes.find((t) => t.id === exc.tourTypeId);
    if (!tourType) return sum;
    return sum + calculateExcursionRevenue(exc, tourType, additionalServices);
  }, 0);
}

export function calculateTotalExpenses(excursions: Excursion[]): number {
  return excursions.reduce((sum, exc) => sum + calculateExcursionExpenses(exc), 0);
}

export function calculateAdditionalTransactionsTotal(
  transactions: Transaction[],
  type: "income" | "expense"
): number {
  return transactions
    .filter((t) => t.type === type)
    .reduce((sum, t) => sum + t.amount, 0);
}
