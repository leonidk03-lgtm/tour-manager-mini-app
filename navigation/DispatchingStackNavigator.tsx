import { createNativeStackNavigator } from "@react-navigation/native-stack";
import DispatchingScreen from "@/screens/DispatchingScreen";
import { getCommonScreenOptions } from "./screenOptions";
import { useTheme } from "@/hooks/useTheme";

export type DispatchingStackParamList = {
  Dispatching: undefined;
};

const Stack = createNativeStackNavigator<DispatchingStackParamList>();

export default function DispatchingStackNavigator() {
  const { theme, isDark } = useTheme();
  
  return (
    <Stack.Navigator screenOptions={getCommonScreenOptions({ theme, isDark })}>
      <Stack.Screen
        name="Dispatching"
        component={DispatchingScreen}
        options={{ title: "Отправление" }}
      />
    </Stack.Navigator>
  );
}
