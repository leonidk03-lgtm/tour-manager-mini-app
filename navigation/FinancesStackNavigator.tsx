import { createNativeStackNavigator } from "@react-navigation/native-stack";
import FinancesScreen from "@/screens/FinancesScreen";
import { getCommonScreenOptions } from "./screenOptions";
import { useTheme } from "@/hooks/useTheme";

export type FinancesStackParamList = {
  Finances: undefined;
};

const Stack = createNativeStackNavigator<FinancesStackParamList>();

export default function FinancesStackNavigator() {
  const { theme, isDark } = useTheme();
  
  return (
    <Stack.Navigator screenOptions={getCommonScreenOptions({ theme, isDark })}>
      <Stack.Screen
        name="Finances"
        component={FinancesScreen}
        options={{ title: "Финансы" }}
      />
    </Stack.Navigator>
  );
}
