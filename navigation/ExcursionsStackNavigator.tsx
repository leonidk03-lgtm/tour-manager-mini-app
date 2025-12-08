import { createNativeStackNavigator } from "@react-navigation/native-stack";
import ExcursionsListScreen from "@/screens/ExcursionsListScreen";
import ExcursionDetailScreen from "@/screens/ExcursionDetailScreen";
import RadioGuidesScreen from "@/screens/RadioGuidesScreen";
import { getCommonScreenOptions } from "./screenOptions";
import { useTheme } from "@/hooks/useTheme";

export type ExcursionsStackParamList = {
  ExcursionsList: undefined;
  ExcursionDetail: { excursionId: string };
  RadioGuides: undefined;
};

const Stack = createNativeStackNavigator<ExcursionsStackParamList>();

export default function ExcursionsStackNavigator() {
  const { theme, isDark } = useTheme();
  
  return (
    <Stack.Navigator screenOptions={getCommonScreenOptions({ theme, isDark })}>
      <Stack.Screen
        name="ExcursionsList"
        component={ExcursionsListScreen}
        options={{ title: "Экскурсии" }}
      />
      <Stack.Screen
        name="ExcursionDetail"
        component={ExcursionDetailScreen}
        options={{ title: "Детали экскурсии" }}
      />
      <Stack.Screen
        name="RadioGuides"
        component={RadioGuidesScreen}
        options={{ title: "Радиогиды" }}
      />
    </Stack.Navigator>
  );
}
