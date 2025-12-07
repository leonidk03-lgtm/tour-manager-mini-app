import { createNativeStackNavigator } from "@react-navigation/native-stack";
import SettingsScreen from "@/screens/SettingsScreen";
import TicketPricesScreen from "@/screens/TicketPricesScreen";
import AdminPanelScreen from "@/screens/AdminPanelScreen";
import DeletedDataScreen from "@/screens/DeletedDataScreen";
import DatabaseSettingsScreen from "@/screens/DatabaseSettingsScreen";
import RadioGuidesScreen from "@/screens/RadioGuidesScreen";
import ManagerDetailScreen from "@/screens/ManagerDetailScreen";
import { getCommonScreenOptions } from "./screenOptions";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";
import { Profile } from "@/lib/supabase";

export type SettingsStackParamList = {
  Settings: undefined;
  TicketPrices: undefined;
  AdminPanel: undefined;
  DeletedData: undefined;
  DatabaseSettings: undefined;
  RadioGuides: undefined;
  ManagerDetail: { manager: Profile };
};

const Stack = createNativeStackNavigator<SettingsStackParamList>();

export default function SettingsStackNavigator() {
  const { theme, isDark } = useTheme();
  const { isRadioDispatcher } = useAuth();
  
  return (
    <Stack.Navigator 
      initialRouteName={isRadioDispatcher ? "RadioGuides" : "Settings"}
      screenOptions={getCommonScreenOptions({ theme, isDark })}
    >
      {!isRadioDispatcher ? (
        <>
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
        </>
      ) : null}
      <Stack.Screen
        name="RadioGuides"
        component={RadioGuidesScreen}
        options={{ title: "Радиогиды" }}
      />
    </Stack.Navigator>
  );
}
