import React from "react";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { Icon } from "@/components/Icon";
import { View, StyleSheet, Platform } from "react-native";
import { BlurView } from "expo-blur";
import DashboardStackNavigator from "@/navigation/DashboardStackNavigator";
import ExcursionsStackNavigator from "@/navigation/ExcursionsStackNavigator";
import FinancesStackNavigator from "@/navigation/FinancesStackNavigator";
import DispatchingStackNavigator from "@/navigation/DispatchingStackNavigator";
import ChatStackNavigator from "@/navigation/ChatStackNavigator";
import SettingsStackNavigator from "@/navigation/SettingsStackNavigator";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";
import { Spacing, BorderRadius } from "@/constants/theme";

export type MainTabParamList = {
  DashboardTab: undefined;
  ExcursionsTab: undefined;
  FinancesTab: undefined;
  DispatchingTab: undefined;
  ChatTab: undefined;
  SettingsTab: undefined;
};

const Tab = createBottomTabNavigator<MainTabParamList>();

export default function MainTabNavigator() {
  const { theme, isDark } = useTheme();
  const { isAdmin, isRadioDispatcher } = useAuth();

  const getInitialRouteName = () => {
    if (isRadioDispatcher) return "SettingsTab";
    if (isAdmin) return "DashboardTab";
    return "ExcursionsTab";
  };

  return (
    <Tab.Navigator
      initialRouteName={getInitialRouteName()}
      screenOptions={{
        tabBarActiveTintColor: theme.tabIconSelected,
        tabBarInactiveTintColor: theme.tabIconDefault,
        tabBarStyle: {
          position: "absolute",
          backgroundColor: "transparent",
          borderTopWidth: 0,
          elevation: 0,
          height: 70,
          paddingBottom: 8,
          paddingTop: 8,
          marginHorizontal: Spacing.lg,
          marginBottom: Spacing.md,
          borderRadius: BorderRadius.xl,
          overflow: "hidden",
        },
        tabBarBackground: () => (
          <BlurView
            intensity={100}
            tint="dark"
            style={StyleSheet.absoluteFill}
          />
        ),
        tabBarLabelStyle: {
          fontSize: 10,
          marginTop: -2,
          marginBottom: 2,
        },
        tabBarIconStyle: {
          marginTop: 2,
        },
        headerShown: false,
      }}
    >
      {isAdmin ? (
        <Tab.Screen
          name="DashboardTab"
          component={DashboardStackNavigator}
          options={{
            title: "Главная",
            tabBarIcon: ({ color, size }) => (
              <Icon name="pie-chart" size={22} color={color} />
            ),
          }}
        />
      ) : null}
      {!isRadioDispatcher ? (
        <>
          <Tab.Screen
            name="ExcursionsTab"
            component={ExcursionsStackNavigator}
            options={{
              title: "Экскурсии",
              tabBarIcon: ({ color, size }) => (
                <Icon name="map" size={22} color={color} />
              ),
            }}
          />
          <Tab.Screen
            name="FinancesTab"
            component={FinancesStackNavigator}
            options={{
              title: "Финансы",
              tabBarIcon: ({ color, size }) => (
                <Icon name="trending-up" size={22} color={color} />
              ),
            }}
          />
          <Tab.Screen
            name="DispatchingTab"
            component={DispatchingStackNavigator}
            options={{
              title: "Отправление",
              tabBarIcon: ({ color, size }) => (
                <Icon name="send" size={22} color={color} />
              ),
            }}
          />
        </>
      ) : null}
      <Tab.Screen
        name="ChatTab"
        component={ChatStackNavigator}
        options={{
          title: "Чат",
          tabBarIcon: ({ color, size }) => (
            <Icon name="message-circle" size={22} color={color} />
          ),
        }}
      />
      <Tab.Screen
        name="SettingsTab"
        component={SettingsStackNavigator}
        options={{
          title: isRadioDispatcher ? "Радиогиды" : "Настройки",
          tabBarIcon: ({ color, size }) => (
            <Icon name={isRadioDispatcher ? "radio" : "sliders"} size={22} color={color} />
          ),
        }}
      />
    </Tab.Navigator>
  );
}
