import React from "react";
import { createBottomTabNavigator } from "@react-navigation/bottom-tabs";
import { Feather } from "@expo/vector-icons";
import { View, StyleSheet, Platform } from "react-native";
import { BlurView } from "expo-blur";
import DashboardStackNavigator from "@/navigation/DashboardStackNavigator";
import ExcursionsStackNavigator from "@/navigation/ExcursionsStackNavigator";
import FinancesStackNavigator from "@/navigation/FinancesStackNavigator";
import SettingsStackNavigator from "@/navigation/SettingsStackNavigator";
import { useTheme } from "@/hooks/useTheme";
import { Spacing, BorderRadius } from "@/constants/theme";

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
