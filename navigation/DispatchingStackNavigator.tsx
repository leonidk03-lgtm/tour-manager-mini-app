import { createNativeStackNavigator } from "@react-navigation/native-stack";
import DispatchingScreen from "@/screens/DispatchingScreen";
import AllocationScreen from "@/screens/AllocationScreen";
import { getCommonScreenOptions } from "./screenOptions";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";

export type DispatchingStackParamList = {
  Dispatching: undefined;
  Allocation: undefined;
};

const Stack = createNativeStackNavigator<DispatchingStackParamList>();

export default function DispatchingStackNavigator() {
  const { theme, isDark } = useTheme();
  const { hasPermission, isAdmin } = useAuth();
  
  const hasDispatching = isAdmin || hasPermission('dispatching_notes');
  const hasAllocation = isAdmin || hasPermission('allocation');
  
  return (
    <Stack.Navigator 
      screenOptions={getCommonScreenOptions({ theme, isDark })}
      initialRouteName={hasDispatching ? "Dispatching" : (hasAllocation ? "Allocation" : "Dispatching")}
    >
      {hasDispatching ? (
        <Stack.Screen
          name="Dispatching"
          component={DispatchingScreen}
          options={{ title: "Отправление" }}
        />
      ) : null}
      <Stack.Screen
        name="Allocation"
        component={AllocationScreen}
        options={{ title: "Распределение" }}
      />
    </Stack.Navigator>
  );
}
