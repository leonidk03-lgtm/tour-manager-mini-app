import { createNativeStackNavigator } from "@react-navigation/native-stack";
import SettingsScreen from "@/screens/SettingsScreen";
import TicketPricesScreen from "@/screens/TicketPricesScreen";
import AdminPanelScreen from "@/screens/AdminPanelScreen";
import DeletedDataScreen from "@/screens/DeletedDataScreen";
import { getCommonScreenOptions } from "./screenOptions";
import { useTheme } from "@/hooks/useTheme";

export type SettingsStackParamList = {
  Settings: undefined;
  TicketPrices: undefined;
  AdminPanel: undefined;
  DeletedData: undefined;
};

const Stack = createNativeStackNavigator<SettingsStackParamList>();

export default function SettingsStackNavigator() {
  const { theme, isDark } = useTheme();
  
  return (
    <Stack.Navigator screenOptions={getCommonScreenOptions({ theme, isDark })}>
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
        name="DeletedData"
        component={DeletedDataScreen}
        options={{ title: "Удаленные данные" }}
      />
    </Stack.Navigator>
  );
}
