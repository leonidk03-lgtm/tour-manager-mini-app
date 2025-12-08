import { createNativeStackNavigator } from "@react-navigation/native-stack";
import DashboardScreen from "@/screens/DashboardScreen";
import DailyReportScreen from "@/screens/DailyReportScreen";
import { getCommonScreenOptions } from "./screenOptions";
import { HeaderTitle } from "@/components/HeaderTitle";
import { useTheme } from "@/hooks/useTheme";

export type DashboardStackParamList = {
  Dashboard: undefined;
  DailyReport: undefined;
};

const Stack = createNativeStackNavigator<DashboardStackParamList>();

export default function DashboardStackNavigator() {
  const { theme, isDark } = useTheme();
  
  return (
    <Stack.Navigator screenOptions={getCommonScreenOptions({ theme, isDark })}>
      <Stack.Screen
        name="Dashboard"
        component={DashboardScreen}
        options={{
          headerTitle: () => <HeaderTitle title="TourManager" />,
        }}
      />
      <Stack.Screen
        name="DailyReport"
        component={DailyReportScreen}
        options={{ title: "Ежедневный отчёт" }}
      />
    </Stack.Navigator>
  );
}
