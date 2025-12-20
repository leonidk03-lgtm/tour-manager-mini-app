import { createNativeStackNavigator } from "@react-navigation/native-stack";
import SettingsScreen from "@/screens/SettingsScreen";
import TicketPricesScreen from "@/screens/TicketPricesScreen";
import AdminPanelScreen from "@/screens/AdminPanelScreen";
import DeletedDataScreen from "@/screens/DeletedDataScreen";
import DatabaseSettingsScreen from "@/screens/DatabaseSettingsScreen";
import RadioGuidesScreen from "@/screens/RadioGuidesScreen";
import ManagerDetailScreen from "@/screens/ManagerDetailScreen";
import EditProfileScreen from "@/screens/EditProfileScreen";
import EquipmentLossesScreen from "@/screens/EquipmentLossesScreen";
import ReportsScreen from "@/screens/ReportsScreen";
import FinancialReportScreen from "@/screens/FinancialReportScreen";
import ExcursionsReportScreen from "@/screens/ExcursionsReportScreen";
import RadioGuidesReportScreen from "@/screens/RadioGuidesReportScreen";
import ExportDataScreen from "@/screens/ExportDataScreen";
import DailyReportScreen from "@/screens/DailyReportScreen";
import NotificationsScreen from "@/screens/NotificationsScreen";
import WarehouseScreen from "@/screens/WarehouseScreen";
import RentalClientsScreen from "@/screens/RentalClientsScreen";
import RentalOrdersScreen from "@/screens/RentalOrdersScreen";
import AddRentalOrderScreen from "@/screens/AddRentalOrderScreen";
import RentalOrderDetailScreen from "@/screens/RentalOrderDetailScreen";
import RentalClientDetailScreen from "@/screens/RentalClientDetailScreen";
import RentalCommissionsScreen from "@/screens/RentalCommissionsScreen";
import ManagerCommissionsScreen from "@/screens/ManagerCommissionsScreen";
import { getCommonScreenOptions } from "./screenOptions";
import { useTheme } from "@/hooks/useTheme";
import { Profile } from "@/lib/supabase";

export type SettingsStackParamList = {
  Settings: undefined;
  TicketPrices: undefined;
  AdminPanel: undefined;
  DeletedData: undefined;
  DatabaseSettings: undefined;
  RadioGuides: undefined;
  EquipmentLosses: undefined;
  ManagerDetail: { manager: Profile };
  EditProfile: undefined;
  Reports: undefined;
  FinancialReport: undefined;
  ExcursionsReport: undefined;
  RadioGuidesReport: undefined;
  ExportData: undefined;
  DailyReport: undefined;
  Notifications: undefined;
  Warehouse: undefined;
  RentalClients: undefined;
  RentalOrders: undefined;
  RentalClientDetail: { clientId: string };
  RentalOrderDetail: { orderId: string };
  AddRentalOrder: { clientId?: string; orderId?: string } | undefined;
  RentalCommissions: undefined;
  ManagerCommissions: { managerId: string; managerName: string };
};

const Stack = createNativeStackNavigator<SettingsStackParamList>();

export default function SettingsStackNavigator() {
  const { theme, isDark } = useTheme();
  
  return (
    <Stack.Navigator 
      initialRouteName="Settings"
      screenOptions={getCommonScreenOptions({ theme, isDark })}
    >
      <Stack.Screen
        name="Settings"
        component={SettingsScreen}
        options={{ title: "Настройки" }}
      />
      <Stack.Screen
        name="TicketPrices"
        component={TicketPricesScreen}
        options={{ title: "Цены на билеты" }}
      />
      <Stack.Screen
        name="AdminPanel"
        component={AdminPanelScreen}
        options={{ title: "Панель администратора" }}
      />
      <Stack.Screen
        name="ManagerDetail"
        component={ManagerDetailScreen}
        options={{ title: "Сотрудник" }}
      />
      <Stack.Screen
        name="DeletedData"
        component={DeletedDataScreen}
        options={{ title: "Удаленные данные" }}
      />
      <Stack.Screen
        name="DatabaseSettings"
        component={DatabaseSettingsScreen}
        options={{ title: "База данных" }}
      />
      <Stack.Screen
        name="EditProfile"
        component={EditProfileScreen}
        options={{ title: "Редактировать профиль" }}
      />
      <Stack.Screen
        name="EquipmentLosses"
        component={EquipmentLossesScreen}
        options={{ title: "Утери оборудования" }}
      />
      <Stack.Screen
        name="Reports"
        component={ReportsScreen}
        options={{ title: "Отчёты" }}
      />
      <Stack.Screen
        name="FinancialReport"
        component={FinancialReportScreen}
        options={{ title: "Финансовый отчёт" }}
      />
      <Stack.Screen
        name="ExcursionsReport"
        component={ExcursionsReportScreen}
        options={{ title: "Отчёт по экскурсиям" }}
      />
      <Stack.Screen
        name="RadioGuidesReport"
        component={RadioGuidesReportScreen}
        options={{ title: "Отчёт по радиогидам" }}
      />
      <Stack.Screen
        name="ExportData"
        component={ExportDataScreen}
        options={{ title: "Экспорт данных" }}
      />
      <Stack.Screen
        name="DailyReport"
        component={DailyReportScreen}
        options={{ title: "Ежедневный отчёт" }}
      />
      <Stack.Screen
        name="RadioGuides"
        component={RadioGuidesScreen}
        options={{ title: "Радиогиды" }}
      />
      <Stack.Screen
        name="Notifications"
        component={NotificationsScreen}
        options={{ title: "Уведомления" }}
      />
      <Stack.Screen
        name="Warehouse"
        component={WarehouseScreen}
        options={{ title: "Склад" }}
      />
      <Stack.Screen
        name="RentalClients"
        component={RentalClientsScreen}
        options={{ title: "Клиенты" }}
      />
      <Stack.Screen
        name="RentalOrders"
        component={RentalOrdersScreen}
        options={{ title: "Заказы" }}
      />
      <Stack.Screen
        name="AddRentalOrder"
        component={AddRentalOrderScreen}
        options={{ title: "Новый заказ" }}
      />
      <Stack.Screen
        name="RentalOrderDetail"
        component={RentalOrderDetailScreen}
        options={{ title: "Детали заказа" }}
      />
      <Stack.Screen
        name="RentalClientDetail"
        component={RentalClientDetailScreen}
        options={{ title: "Клиент" }}
      />
      <Stack.Screen
        name="RentalCommissions"
        component={RentalCommissionsScreen}
        options={{ title: "Комиссии", headerTransparent: false }}
      />
      <Stack.Screen
        name="ManagerCommissions"
        component={ManagerCommissionsScreen}
        options={({ route }) => ({ title: route.params.managerName, headerTransparent: false })}
      />
    </Stack.Navigator>
  );
}
