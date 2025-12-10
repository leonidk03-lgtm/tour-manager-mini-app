import { createNativeStackNavigator } from "@react-navigation/native-stack";
import ChatScreen from "@/screens/ChatScreen";
import { getCommonScreenOptions } from "./screenOptions";
import { useTheme } from "@/hooks/useTheme";

export type ChatStackParamList = {
  Chat: undefined;
};

const Stack = createNativeStackNavigator<ChatStackParamList>();

export default function ChatStackNavigator() {
  const { theme, isDark } = useTheme();
  
  return (
    <Stack.Navigator screenOptions={getCommonScreenOptions({ theme, isDark })}>
      <Stack.Screen
        name="Chat"
        component={ChatScreen}
        options={{ title: "Чат" }}
      />
    </Stack.Navigator>
  );
}
