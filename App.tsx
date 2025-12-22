import React from "react";
import { StyleSheet } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { GestureHandlerRootView } from "react-native-gesture-handler";
import { KeyboardProvider } from "react-native-keyboard-controller";
import { SafeAreaProvider } from "react-native-safe-area-context";
import { StatusBar } from "expo-status-bar";

import RootNavigator from "@/navigation/RootNavigator";
import { ErrorBoundary } from "@/components/ErrorBoundary";
import { NotificationBanner } from "@/components/NotificationBanner";
import { DataProvider } from "@/contexts/DataContext";
import { AuthProvider } from "@/contexts/AuthContext";
import { RentalProvider } from "@/contexts/RentalContext";
import { CompanySettingsProvider } from "@/contexts/CompanySettingsContext";
import { DocumentTemplatesProvider } from "@/contexts/DocumentTemplatesContext";

export default function App() {
  return (
    <ErrorBoundary>
      <SafeAreaProvider>
        <GestureHandlerRootView style={styles.root}>
          <KeyboardProvider>
            <AuthProvider>
              <DataProvider>
                <RentalProvider>
                  <CompanySettingsProvider>
                    <DocumentTemplatesProvider>
                      <NavigationContainer>
                        <RootNavigator />
                        <NotificationBanner />
                      </NavigationContainer>
                    </DocumentTemplatesProvider>
                  </CompanySettingsProvider>
                </RentalProvider>
              </DataProvider>
            </AuthProvider>
            <StatusBar style="auto" />
          </KeyboardProvider>
        </GestureHandlerRootView>
      </SafeAreaProvider>
    </ErrorBoundary>
  );
}

const styles = StyleSheet.create({
  root: {
    flex: 1,
  },
});
