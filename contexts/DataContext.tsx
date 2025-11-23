import React, { createContext, useContext, useState, ReactNode } from "react";

export interface TourType {
  id: string;
  name: string;
  fullPrice: number;
  discountedPrice: number;
}

export interface AdditionalService {
  id: string;
  name: string;
  price: number;
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
  expenses: Expense[];
  additionalServices: { serviceId: string; count: number }[];
}

export interface Transaction {
  id: string;
  type: "income" | "expense";
  amount: number;
  description: string;
  date: string;
}

export interface Manager {
  id: string;
  name: string;
  email: string;
  isActive: boolean;
}

export interface Activity {
  id: string;
  type: "excursion_added" | "transaction_added" | "excursion_deleted" | "transaction_deleted";
  managerName: string;
  description: string;
  date: string;
  timestamp: string;
}

interface DataContextType {
  tourTypes: TourType[];
  setTourTypes: (types: TourType[]) => void;
  additionalServices: AdditionalService[];
  setAdditionalServices: (services: AdditionalService[]) => void;
  excursions: Excursion[];
  addExcursion: (excursion: Excursion) => void;
  updateExcursion: (id: string, excursion: Excursion) => void;
  deleteExcursion: (id: string) => void;
  transactions: Transaction[];
  addTransaction: (transaction: Transaction) => void;
  deleteTransaction: (id: string) => void;
  managers: Manager[];
  addManager: (manager: Manager) => void;
  updateManager: (id: string, manager: Manager) => void;
  deleteManager: (id: string) => void;
  currentUser: { role: "admin" | "manager"; name: string } | null;
  setCurrentUser: (user: { role: "admin" | "manager"; name: string } | null) => void;
  activities: Activity[];
}

const DataContext = createContext<DataContextType | undefined>(undefined);

const defaultTourTypes: TourType[] = [
  { id: "1", name: "Болгар", fullPrice: 3000, discountedPrice: 2800 },
  { id: "2", name: "Йошкар-Ола", fullPrice: 2900, discountedPrice: 2700 },
  { id: "3", name: "Свияжск", fullPrice: 2100, discountedPrice: 2000 },
  { id: "4", name: "Свияжск + Раифа", fullPrice: 2400, discountedPrice: 2200 },
  { id: "5", name: "Голубые озера", fullPrice: 1200, discountedPrice: 1100 },
  { id: "6", name: "Речка 13:30", fullPrice: 1200, discountedPrice: 1100 },
  { id: "7", name: "Речка 15:30", fullPrice: 1200, discountedPrice: 1100 },
  { id: "8", name: "Речка 17:30", fullPrice: 1200, discountedPrice: 1100 },
  { id: "9", name: "Вечерняя", fullPrice: 1100, discountedPrice: 1000 },
  { id: "10", name: "Вечерняя с колесом", fullPrice: 1500, discountedPrice: 1400 },
];

const defaultServices: AdditionalService[] = [
  { id: "1", name: "Теплоход", price: 400 },
  { id: "2", name: "Колесо обозрения", price: 400 },
];

const mockExcursions: Excursion[] = [
  {
    id: "1",
    tourTypeId: "1",
    date: "2025-11-23",
    time: "09:00",
    fullPriceCount: 28,
    discountedCount: 25,
    freeCount: 1,
    tourPackageCount: 0,
    expenses: [
      { id: "e1", type: "Экскурсовод", amount: 13200, description: "Экскурсовод" },
      { id: "e2", type: "Предоплата", amount: 9900, description: "Предоплата автобуса" },
    ],
    additionalServices: [],
  },
  {
    id: "2",
    tourTypeId: "3",
    date: "2025-11-23",
    time: "10:00",
    fullPriceCount: 20,
    discountedCount: 34,
    freeCount: 0,
    tourPackageCount: 0,
    expenses: [
      { id: "e3", type: "Экскурсовод", amount: 31200, description: "Экскурсовод" },
      { id: "e4", type: "Предоплата", amount: 8200, description: "Предоплата автобуса" },
    ],
    additionalServices: [{ serviceId: "1", count: 54 }],
  },
  {
    id: "3",
    tourTypeId: "5",
    date: "2025-11-23",
    time: "11:00",
    fullPriceCount: 15,
    discountedCount: 30,
    freeCount: 0,
    tourPackageCount: 0,
    expenses: [
      { id: "e5", type: "Экскурсовод", amount: 4900, description: "Экскурсовод" },
      { id: "e6", type: "Предоплата", amount: 2500, description: "Предоплата автобуса" },
    ],
    additionalServices: [],
  },
];

const mockTransactions: Transaction[] = [
  {
    id: "t1",
    type: "expense",
    amount: 1500,
    description: "Вильдану",
    date: "2025-11-23",
  },
  {
    id: "t2",
    type: "expense",
    amount: 4300,
    description: "Эдику",
    date: "2025-11-23",
  },
  {
    id: "t3",
    type: "income",
    amount: 5000,
    description: "Поступление от партнера",
    date: "2025-11-23",
  },
];

export function DataProvider({ children }: { children: ReactNode }) {
  const [tourTypes, setTourTypes] = useState<TourType[]>(defaultTourTypes);
  const [additionalServices, setAdditionalServices] = useState<AdditionalService[]>(defaultServices);
  const [excursions, setExcursions] = useState<Excursion[]>(mockExcursions);
  const [transactions, setTransactions] = useState<Transaction[]>(mockTransactions);
  const [managers, setManagers] = useState<Manager[]>([
    { id: "1", name: "Иван Петров", email: "ivan@example.com", isActive: true },
    { id: "2", name: "Мария Сидорова", email: "maria@example.com", isActive: true },
  ]);
  const [currentUser, setCurrentUser] = useState<{ role: "admin" | "manager"; name: string } | null>({
    role: "admin",
    name: "Администратор",
  });
  const [activities, setActivities] = useState<Activity[]>([]);

  const addExcursion = (excursion: Excursion) => {
    setExcursions((prev) => [...prev, excursion]);
    if (currentUser) {
      const tourType = tourTypes.find((t) => t.id === excursion.tourTypeId);
      const activity: Activity = {
        id: Date.now().toString() + "_excursion",
        type: "excursion_added",
        managerName: currentUser.name,
        description: `добавил экскурсию ${tourType?.name || ""}`,
        date: excursion.date,
        timestamp: new Date().toISOString(),
      };
      setActivities((prev) => [activity, ...prev]);
    }
  };

  const updateExcursion = (id: string, excursion: Excursion) => {
    setExcursions((prev) => prev.map((e) => (e.id === id ? excursion : e)));
  };

  const deleteExcursion = (id: string) => {
    const excursion = excursions.find((e) => e.id === id);
    setExcursions((prev) => prev.filter((e) => e.id !== id));
    if (currentUser && excursion) {
      const tourType = tourTypes.find((t) => t.id === excursion.tourTypeId);
      const activity: Activity = {
        id: Date.now().toString() + "_excursion_del",
        type: "excursion_deleted",
        managerName: currentUser.name,
        description: `удалил экскурсию ${tourType?.name || ""}`,
        date: excursion.date,
        timestamp: new Date().toISOString(),
      };
      setActivities((prev) => [activity, ...prev]);
    }
  };

  const addTransaction = (transaction: Transaction) => {
    setTransactions((prev) => [...prev, transaction]);
    if (currentUser) {
      const typeText = transaction.type === "income" ? "доход" : "расход";
      const activity: Activity = {
        id: Date.now().toString() + "_transaction",
        type: "transaction_added",
        managerName: currentUser.name,
        description: `добавил ${typeText} "${transaction.description}"`,
        date: transaction.date,
        timestamp: new Date().toISOString(),
      };
      setActivities((prev) => [activity, ...prev]);
    }
  };

  const deleteTransaction = (id: string) => {
    const transaction = transactions.find((t) => t.id === id);
    setTransactions((prev) => prev.filter((t) => t.id !== id));
    if (currentUser && transaction) {
      const typeText = transaction.type === "income" ? "доход" : "расход";
      const activity: Activity = {
        id: Date.now().toString() + "_transaction_del",
        type: "transaction_deleted",
        managerName: currentUser.name,
        description: `удалил ${typeText} "${transaction.description}"`,
        date: transaction.date,
        timestamp: new Date().toISOString(),
      };
      setActivities((prev) => [activity, ...prev]);
    }
  };

  const addManager = (manager: Manager) => {
    setManagers((prev) => [...prev, manager]);
  };

  const updateManager = (id: string, manager: Manager) => {
    setManagers((prev) => prev.map((m) => (m.id === id ? manager : m)));
  };

  const deleteManager = (id: string) => {
    setManagers((prev) => prev.filter((m) => m.id !== id));
  };

  return (
    <DataContext.Provider
      value={{
        tourTypes,
        setTourTypes,
        additionalServices,
        setAdditionalServices,
        excursions,
        addExcursion,
        updateExcursion,
        deleteExcursion,
        transactions,
        addTransaction,
        deleteTransaction,
        managers,
        addManager,
        updateManager,
        deleteManager,
        currentUser,
        setCurrentUser,
        activities,
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
