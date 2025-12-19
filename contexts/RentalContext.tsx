import React, { createContext, useContext, useState, useEffect, ReactNode, useCallback } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "./AuthContext";

export type RentalClientType = 'individual' | 'company';

export interface RentalClient {
  id: string;
  type: RentalClientType;
  name: string;
  phone: string | null;
  email: string | null;
  directorName: string | null;
  legalAddress: string | null;
  inn: string | null;
  kpp: string | null;
  defaultPrice: number;
  assignedManagerId: string | null;
  assignedManagerName?: string;
  notes: string | null;
  isActive: boolean;
  createdAt: string;
  updatedAt: string;
}

export type RentalOrderStatus = 'new' | 'issued' | 'returned' | 'completed' | 'cancelled';

export interface RentalOrder {
  id: string;
  orderNumber: number;
  clientId: string;
  clientName?: string;
  clientPhone?: string;
  status: RentalOrderStatus;
  startDate: string;
  endDate: string;
  daysCount: number;
  kitCount: number;
  transmitterCount: number;
  microphoneCount: number;
  bagNumber: string | null;
  isCharged: boolean;
  pricePerUnit: number;
  totalPrice: number;
  prepayment: number;
  receiverNotes: string | null;
  managerId: string | null;
  managerName: string | null;
  executorId: string | null;
  executorName: string | null;
  createdAt: string;
  updatedAt: string;
}

export type RentalPaymentType = 'prepayment' | 'refund' | 'service_expense' | 'final';

export interface RentalPayment {
  id: string;
  orderId: string;
  type: RentalPaymentType;
  amount: number;
  managerId: string | null;
  managerName: string | null;
  notes: string | null;
  createdAt: string;
}

export interface RentalOrderHistory {
  id: string;
  orderId: string;
  action: string;
  managerId: string | null;
  managerName: string | null;
  createdAt: string;
}

export type CommissionRole = 'owner' | 'executor';

export interface RentalCommission {
  id: string;
  orderId: string;
  orderNumber: number;
  recipientId: string;
  recipientName: string;
  role: CommissionRole;
  amount: number;
  basisAmount: number;
  percentage: number;
  status: 'pending' | 'paid';
  paidAt: string | null;
  createdAt: string;
}

interface RentalContextType {
  rentalClients: RentalClient[];
  rentalOrders: RentalOrder[];
  rentalPayments: RentalPayment[];
  rentalOrderHistory: RentalOrderHistory[];
  rentalCommissions: RentalCommission[];
  isLoading: boolean;
  addRentalClient: (client: Omit<RentalClient, 'id' | 'createdAt' | 'updatedAt'>) => Promise<string>;
  updateRentalClient: (id: string, client: Partial<RentalClient>) => Promise<void>;
  deleteRentalClient: (id: string) => Promise<void>;
  addRentalOrder: (order: Omit<RentalOrder, 'id' | 'orderNumber' | 'createdAt' | 'updatedAt'>) => Promise<string>;
  updateRentalOrder: (id: string, order: Partial<RentalOrder>) => Promise<void>;
  deleteRentalOrder: (id: string) => Promise<void>;
  updateOrderStatus: (id: string, status: RentalOrderStatus) => Promise<void>;
  addRentalPayment: (payment: Omit<RentalPayment, 'id' | 'createdAt' | 'managerId' | 'managerName'>) => Promise<void>;
  deleteRentalPayment: (id: string) => Promise<void>;
  getOrderPayments: (orderId: string) => RentalPayment[];
  getOrderHistory: (orderId: string) => RentalOrderHistory[];
  getClientOrders: (clientId: string) => RentalOrder[];
  getManagerCommissions: (managerId: string) => RentalCommission[];
  markCommissionPaid: (commissionId: string) => Promise<void>;
  refreshData: () => Promise<void>;
}

const RentalContext = createContext<RentalContextType | undefined>(undefined);

export function RentalProvider({ children }: { children: ReactNode }) {
  const { user, profile } = useAuth();
  
  const [rentalClients, setRentalClients] = useState<RentalClient[]>([]);
  const [rentalOrders, setRentalOrders] = useState<RentalOrder[]>([]);
  const [rentalPayments, setRentalPayments] = useState<RentalPayment[]>([]);
  const [rentalOrderHistory, setRentalOrderHistory] = useState<RentalOrderHistory[]>([]);
  const [rentalCommissions, setRentalCommissions] = useState<RentalCommission[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  const fetchRentalClients = useCallback(async () => {
    if (!user) return;
    try {
      const { data, error } = await supabase
        .from('rental_clients')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;

      setRentalClients((data || []).map(c => ({
        id: c.id,
        type: c.type as RentalClientType,
        name: c.name,
        phone: c.phone,
        email: c.email,
        directorName: c.director_name,
        legalAddress: c.legal_address,
        inn: c.inn,
        kpp: c.kpp,
        defaultPrice: c.default_price || 100,
        assignedManagerId: c.assigned_manager_id,
        notes: c.notes,
        isActive: c.is_active,
        createdAt: c.created_at,
        updatedAt: c.updated_at,
      })));
    } catch (error) {
      console.error('Error fetching rental clients:', error);
    }
  }, [user]);

  const fetchRentalOrders = useCallback(async () => {
    if (!user) return;
    try {
      const { data, error } = await supabase
        .from('rental_orders')
        .select(`
          *,
          rental_clients!inner(name, phone)
        `)
        .order('created_at', { ascending: false });

      if (error) throw error;

      setRentalOrders((data || []).map(o => ({
        id: o.id,
        orderNumber: o.order_number,
        clientId: o.client_id,
        clientName: o.rental_clients?.name,
        clientPhone: o.rental_clients?.phone,
        status: o.status as RentalOrderStatus,
        startDate: o.start_date,
        endDate: o.end_date,
        daysCount: o.days_count,
        kitCount: o.kit_count,
        transmitterCount: o.transmitter_count,
        microphoneCount: o.microphone_count,
        bagNumber: o.bag_number,
        isCharged: o.is_charged,
        pricePerUnit: o.price_per_unit,
        totalPrice: o.total_price,
        prepayment: o.prepayment || 0,
        receiverNotes: o.receiver_notes,
        managerId: o.manager_id,
        managerName: o.manager_name,
        executorId: o.executor_id,
        executorName: o.executor_name,
        createdAt: o.created_at,
        updatedAt: o.updated_at,
      })));
    } catch (error) {
      console.error('Error fetching rental orders:', error);
    }
  }, [user]);

  const fetchRentalPayments = useCallback(async () => {
    if (!user) return;
    try {
      const { data, error } = await supabase
        .from('rental_payments')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;

      setRentalPayments((data || []).map(p => ({
        id: p.id,
        orderId: p.order_id,
        type: p.type as RentalPaymentType,
        amount: p.amount,
        managerId: p.manager_id,
        managerName: p.manager_name,
        notes: p.notes,
        createdAt: p.created_at,
      })));
    } catch (error) {
      console.error('Error fetching rental payments:', error);
    }
  }, [user]);

  const fetchRentalOrderHistory = useCallback(async () => {
    if (!user) return;
    try {
      const { data, error } = await supabase
        .from('rental_order_history')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) throw error;

      setRentalOrderHistory((data || []).map(h => ({
        id: h.id,
        orderId: h.order_id,
        action: h.action,
        managerId: h.manager_id,
        managerName: h.manager_name,
        createdAt: h.created_at,
      })));
    } catch (error) {
      console.error('Error fetching rental order history:', error);
    }
  }, [user]);

  const fetchRentalCommissions = useCallback(async () => {
    if (!user) return;
    try {
      const { data, error } = await supabase
        .from('rental_commissions')
        .select('*')
        .order('created_at', { ascending: false });

      if (error) {
        console.log('Commissions table may not exist yet:', error.message);
        return;
      }

      setRentalCommissions((data || []).map(c => ({
        id: c.id,
        orderId: c.order_id,
        orderNumber: c.order_number,
        recipientId: c.recipient_id,
        recipientName: c.recipient_name,
        role: c.role as CommissionRole,
        amount: c.amount,
        basisAmount: c.basis_amount,
        percentage: c.percentage,
        status: c.status,
        paidAt: c.paid_at,
        createdAt: c.created_at,
      })));
    } catch (error) {
      console.error('Error fetching rental commissions:', error);
    }
  }, [user]);

  const refreshData = useCallback(async () => {
    setIsLoading(true);
    await Promise.all([
      fetchRentalClients(),
      fetchRentalOrders(),
      fetchRentalPayments(),
      fetchRentalOrderHistory(),
      fetchRentalCommissions(),
    ]);
    setIsLoading(false);
  }, [fetchRentalClients, fetchRentalOrders, fetchRentalPayments, fetchRentalOrderHistory, fetchRentalCommissions]);

  useEffect(() => {
    if (user) {
      refreshData();
    }
  }, [user, refreshData]);

  useEffect(() => {
    if (!user) return;

    const clientsSubscription = supabase
      .channel('rental_clients_changes')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'rental_clients' }, () => {
        fetchRentalClients();
      })
      .subscribe();

    const ordersSubscription = supabase
      .channel('rental_orders_changes')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'rental_orders' }, () => {
        fetchRentalOrders();
      })
      .subscribe();

    const paymentsSubscription = supabase
      .channel('rental_payments_changes')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'rental_payments' }, () => {
        fetchRentalPayments();
      })
      .subscribe();

    const historySubscription = supabase
      .channel('rental_order_history_changes')
      .on('postgres_changes', { event: '*', schema: 'public', table: 'rental_order_history' }, () => {
        fetchRentalOrderHistory();
      })
      .subscribe();

    return () => {
      supabase.removeChannel(clientsSubscription);
      supabase.removeChannel(ordersSubscription);
      supabase.removeChannel(paymentsSubscription);
      supabase.removeChannel(historySubscription);
    };
  }, [user, fetchRentalClients, fetchRentalOrders, fetchRentalPayments, fetchRentalOrderHistory]);

  const addRentalClient = async (client: Omit<RentalClient, 'id' | 'createdAt' | 'updatedAt'>): Promise<string> => {
    const { data, error } = await supabase
      .from('rental_clients')
      .insert({
        type: client.type,
        name: client.name,
        phone: client.phone,
        email: client.email,
        director_name: client.directorName,
        legal_address: client.legalAddress,
        inn: client.inn,
        kpp: client.kpp,
        default_price: client.defaultPrice,
        assigned_manager_id: client.assignedManagerId,
        notes: client.notes,
        is_active: client.isActive,
      })
      .select()
      .single();

    if (error) throw error;
    await fetchRentalClients();
    return data.id;
  };

  const updateRentalClient = async (id: string, client: Partial<RentalClient>) => {
    const updateData: Record<string, unknown> = {};
    if (client.type !== undefined) updateData.type = client.type;
    if (client.name !== undefined) updateData.name = client.name;
    if (client.phone !== undefined) updateData.phone = client.phone;
    if (client.email !== undefined) updateData.email = client.email;
    if (client.directorName !== undefined) updateData.director_name = client.directorName;
    if (client.legalAddress !== undefined) updateData.legal_address = client.legalAddress;
    if (client.inn !== undefined) updateData.inn = client.inn;
    if (client.kpp !== undefined) updateData.kpp = client.kpp;
    if (client.defaultPrice !== undefined) updateData.default_price = client.defaultPrice;
    if (client.assignedManagerId !== undefined) updateData.assigned_manager_id = client.assignedManagerId;
    if (client.notes !== undefined) updateData.notes = client.notes;
    if (client.isActive !== undefined) updateData.is_active = client.isActive;

    const { error } = await supabase
      .from('rental_clients')
      .update(updateData)
      .eq('id', id);

    if (error) throw error;
    await fetchRentalClients();
  };

  const deleteRentalClient = async (id: string) => {
    const { error } = await supabase
      .from('rental_clients')
      .delete()
      .eq('id', id);

    if (error) throw error;
    await fetchRentalClients();
  };

  const addOrderHistory = async (orderId: string, action: string) => {
    const managerId = profile?.id || null;
    const managerName = profile?.display_name || profile?.email || 'Система';
    
    await supabase.from('rental_order_history').insert({
      order_id: orderId,
      action,
      manager_id: managerId,
      manager_name: managerName,
    });
    await fetchRentalOrderHistory();
  };

  const addRentalOrder = async (order: Omit<RentalOrder, 'id' | 'orderNumber' | 'createdAt' | 'updatedAt'>): Promise<string> => {
    const { data, error } = await supabase
      .from('rental_orders')
      .insert({
        client_id: order.clientId,
        status: order.status,
        start_date: order.startDate,
        end_date: order.endDate,
        days_count: order.daysCount,
        kit_count: order.kitCount,
        transmitter_count: order.transmitterCount,
        microphone_count: order.microphoneCount,
        bag_number: order.bagNumber,
        is_charged: order.isCharged,
        price_per_unit: order.pricePerUnit,
        total_price: order.totalPrice,
        prepayment: order.prepayment,
        receiver_notes: order.receiverNotes,
        manager_id: profile?.id || null,
        manager_name: profile?.display_name || profile?.email || null,
        executor_id: order.executorId,
        executor_name: order.executorName,
      })
      .select()
      .single();

    if (error) throw error;

    await addOrderHistory(data.id, 'Заказ создан');
    await fetchRentalOrders();
    return data.id;
  };

  const updateRentalOrder = async (id: string, order: Partial<RentalOrder>) => {
    const updateData: Record<string, unknown> = {};
    if (order.clientId !== undefined) updateData.client_id = order.clientId;
    if (order.status !== undefined) updateData.status = order.status;
    if (order.startDate !== undefined) updateData.start_date = order.startDate;
    if (order.endDate !== undefined) updateData.end_date = order.endDate;
    if (order.daysCount !== undefined) updateData.days_count = order.daysCount;
    if (order.kitCount !== undefined) updateData.kit_count = order.kitCount;
    if (order.transmitterCount !== undefined) updateData.transmitter_count = order.transmitterCount;
    if (order.microphoneCount !== undefined) updateData.microphone_count = order.microphoneCount;
    if (order.bagNumber !== undefined) updateData.bag_number = order.bagNumber;
    if (order.isCharged !== undefined) updateData.is_charged = order.isCharged;
    if (order.pricePerUnit !== undefined) updateData.price_per_unit = order.pricePerUnit;
    if (order.totalPrice !== undefined) updateData.total_price = order.totalPrice;
    if (order.prepayment !== undefined) updateData.prepayment = order.prepayment;
    if (order.receiverNotes !== undefined) updateData.receiver_notes = order.receiverNotes;
    if (order.executorId !== undefined) updateData.executor_id = order.executorId;
    if (order.executorName !== undefined) updateData.executor_name = order.executorName;

    const { error } = await supabase
      .from('rental_orders')
      .update(updateData)
      .eq('id', id);

    if (error) throw error;
    await addOrderHistory(id, 'Заказ обновлён');
    await fetchRentalOrders();
  };

  const deleteRentalOrder = async (id: string) => {
    const { error } = await supabase
      .from('rental_orders')
      .delete()
      .eq('id', id);

    if (error) throw error;
    await fetchRentalOrders();
  };

  const updateOrderStatus = async (id: string, status: RentalOrderStatus) => {
    const statusLabels: Record<RentalOrderStatus, string> = {
      new: 'Новый',
      issued: 'Выдан',
      returned: 'Возвращён',
      completed: 'Завершён',
      cancelled: 'Отменён',
    };

    const { error } = await supabase
      .from('rental_orders')
      .update({ status })
      .eq('id', id);

    if (error) throw error;
    await addOrderHistory(id, `Статус изменён на "${statusLabels[status]}"`);
    await fetchRentalOrders();
  };

  const addRentalPayment = async (payment: Omit<RentalPayment, 'id' | 'createdAt' | 'managerId' | 'managerName'>) => {
    const { error } = await supabase
      .from('rental_payments')
      .insert({
        order_id: payment.orderId,
        type: payment.type,
        amount: payment.amount,
        notes: payment.notes,
        manager_id: profile?.id || null,
        manager_name: profile?.display_name || profile?.email || null,
      });

    if (error) throw error;

    const paymentLabels: Record<RentalPaymentType, string> = {
      prepayment: 'Предоплата',
      refund: 'Возврат',
      service_expense: 'Служебный расход',
      final: 'Окончательный расчёт',
    };

    await addOrderHistory(payment.orderId, `${paymentLabels[payment.type]}: ${payment.amount}₽`);
    await fetchRentalPayments();
    await fetchRentalOrders();
  };

  const deleteRentalPayment = async (id: string) => {
    const { error } = await supabase
      .from('rental_payments')
      .delete()
      .eq('id', id);

    if (error) throw error;
    await fetchRentalPayments();
  };

  const getOrderPayments = (orderId: string): RentalPayment[] => {
    return rentalPayments.filter(p => p.orderId === orderId);
  };

  const getOrderHistory = (orderId: string): RentalOrderHistory[] => {
    return rentalOrderHistory.filter(h => h.orderId === orderId);
  };

  const getClientOrders = (clientId: string): RentalOrder[] => {
    return rentalOrders.filter(o => o.clientId === clientId);
  };

  const getManagerCommissions = (managerId: string): RentalCommission[] => {
    return rentalCommissions.filter(c => c.recipientId === managerId);
  };

  const markCommissionPaid = async (commissionId: string) => {
    const { error } = await supabase
      .from('rental_commissions')
      .update({ status: 'paid', paid_at: new Date().toISOString() })
      .eq('id', commissionId);

    if (error) throw error;
    await fetchRentalCommissions();
  };

  const createCommissionsForOrder = async (orderId: string, totalPrice: number) => {
    const order = rentalOrders.find(o => o.id === orderId);
    if (!order) return;

    const client = rentalClients.find(c => c.id === order.clientId);
    if (!client || !client.assignedManagerId) return;

    const ownerId = client.assignedManagerId;
    const executorId = order.executorId;

    const { data: profiles } = await supabase
      .from('profiles')
      .select('id, display_name, owner_commission_percent, executor_commission_percent')
      .in('id', [ownerId, executorId].filter(Boolean) as string[]);

    if (!profiles || profiles.length === 0) return;

    const ownerProfile = profiles.find(p => p.id === ownerId);
    const executorProfile = executorId ? profiles.find(p => p.id === executorId) : null;

    const ownerPercent = ownerProfile?.owner_commission_percent ?? 20;
    const executorPercent = executorProfile?.executor_commission_percent ?? 10;

    const commissionsToInsert: any[] = [];

    if (ownerProfile) {
      commissionsToInsert.push({
        order_id: orderId,
        order_number: order.orderNumber,
        recipient_id: ownerId,
        recipient_name: ownerProfile.display_name || 'Менеджер',
        role: 'owner',
        amount: Math.round((totalPrice * ownerPercent) / 100),
        basis_amount: totalPrice,
        percentage: ownerPercent,
        status: 'pending',
      });
    }

    if (executorId && executorProfile && executorId !== ownerId) {
      commissionsToInsert.push({
        order_id: orderId,
        order_number: order.orderNumber,
        recipient_id: executorId,
        recipient_name: executorProfile.display_name || 'Исполнитель',
        role: 'executor',
        amount: Math.round((totalPrice * executorPercent) / 100),
        basis_amount: totalPrice,
        percentage: executorPercent,
        status: 'pending',
      });
    }

    if (executorId && executorId === ownerId && ownerProfile) {
      const combinedPercent = ownerPercent + executorPercent;
      commissionsToInsert.length = 0;
      commissionsToInsert.push({
        order_id: orderId,
        order_number: order.orderNumber,
        recipient_id: ownerId,
        recipient_name: ownerProfile.display_name || 'Менеджер',
        role: 'owner',
        amount: Math.round((totalPrice * combinedPercent) / 100),
        basis_amount: totalPrice,
        percentage: combinedPercent,
        status: 'pending',
      });
    }

    if (commissionsToInsert.length > 0) {
      const { error } = await supabase
        .from('rental_commissions')
        .insert(commissionsToInsert);

      if (error) {
        console.error('Error creating commissions:', error);
      } else {
        await addOrderHistory(orderId, `Начислены комиссии: ${commissionsToInsert.map(c => `${c.recipient_name} ${c.amount}₽`).join(', ')}`);
        await fetchRentalCommissions();
      }
    }
  };

  const addRentalPaymentWithCommissions = async (payment: Omit<RentalPayment, 'id' | 'createdAt' | 'managerId' | 'managerName'>) => {
    await addRentalPayment(payment);

    if (payment.type === 'final') {
      const order = rentalOrders.find(o => o.id === payment.orderId);
      if (order) {
        await createCommissionsForOrder(payment.orderId, order.totalPrice);
      }
    }
  };

  return (
    <RentalContext.Provider
      value={{
        rentalClients,
        rentalOrders,
        rentalPayments,
        rentalOrderHistory,
        rentalCommissions,
        isLoading,
        addRentalClient,
        updateRentalClient,
        deleteRentalClient,
        addRentalOrder,
        updateRentalOrder,
        deleteRentalOrder,
        updateOrderStatus,
        addRentalPayment: addRentalPaymentWithCommissions,
        deleteRentalPayment,
        getOrderPayments,
        getOrderHistory,
        getClientOrders,
        getManagerCommissions,
        markCommissionPaid,
        refreshData,
      }}
    >
      {children}
    </RentalContext.Provider>
  );
}

export function useRental() {
  const context = useContext(RentalContext);
  if (!context) {
    throw new Error("useRental must be used within a RentalProvider");
  }
  return context;
}
