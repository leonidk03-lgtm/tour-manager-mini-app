import React from "react";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { Feather } from "@expo/vector-icons";
import { View, StyleSheet } from "react-native";
import DashboardStackNavigator from "@/navigation/DashboardStackNavigator";
import ExcursionsStackNavigator from "@/navigation/ExcursionsStackNavigator";
import FinancesStackNavigator from "@/navigation/FinancesStackNavigator";
import SettingsStackNavigator from "@/navigation/SettingsStackNavigator";
import { useTheme } from "@/hooks/useTheme";
import { Spacing } from "@/constants/theme";

export type MainTabParamList = {
  DashboardTab: undefined;
  ExcursionsTab: undefined;
  FinancesTab: undefined;
  SettingsTab: undefined;
};

const Tab = createBottomTabNavigator<MainTabParamList>();

export default function MainTabNavigator() {
  const { theme, isDark } = useTheme();

  return (
    <Tab.Navigator
      initialRouteName="DashboardTab"
      screenOptions={{
        tabBarActiveTintColor: theme.tabIconSelected,
        tabBarInactiveTintColor: theme.tabIconDefault,
        tabBarStyle: {
          backgroundColor: theme.backgroundDefault,
          borderTopWidth: 1,
          borderTopColor: theme.divider,
          elevation: 0,
          height: 50,
          paddingBottom: 0,
          paddingTop: 0,
        },
        tabBarLabelStyle: {
          fontSize: 10,
          marginTop: -4,
          marginBottom: 4,
        },
        tabBarIconStyle: {
          marginTop: 4,
        },
        headerShown: false,
      }}
    >
      <Tab.Screen
        name="DashboardTab"
        component={DashboardStackNavigator}
        options={{
          title: "Главная",
          tabBarIcon: ({ color, size }) => (
            <Feather name="pie-chart" size={22} color={color} />
          ),
        }}
      />
      <Tab.Screen
        name="ExcursionsTab"
        component={ExcursionsStackNavigator}
        options={{
          title: "Экскурсии",
          tabBarIcon: ({ color, size }) => (
            <Feather name="map" size={22} color={color} />
          ),
        }}
      />
      <Tab.Screen
        name="FinancesTab"
        component={FinancesStackNavigator}
        options={{
          title: "Финансы",
          tabBarIcon: ({ color, size }) => (
            <Feather name="trending-up" size={22} color={color} />
          ),
        }}
      />
      <Tab.Screen
        name="SettingsTab"
        component={SettingsStackNavigator}
        options={{
          title: "Настройки",
          tabBarIcon: ({ color, size }) => (
            <Feather name="sliders" size={22} color={color} />
          ),
        }}
      />
    </Tab.Navigator>
  );
}
