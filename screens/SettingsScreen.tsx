import { View, StyleSheet, Pressable, Alert } from "react-native";
import { Feather } from "@expo/vector-icons";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";

export default function SettingsScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<SettingsStackParamList>>();
  const { profile, isAdmin, signOut } = useAuth();

  const handleLogout = () => {
    Alert.alert("Выйти из аккаунта?", "Вы уверены, что хотите выйти?", [
      { text: "Отмена", style: "cancel" },
      {
        text: "Выйти",
        style: "destructive",
        onPress: async () => {
          await signOut();
        },
      },
    ]);
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <ThemedView
          style={[
            styles.profileCard,
            {
              borderColor: theme.border,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <View style={styles.avatarContainer}>
            <View
              style={[
                styles.avatar,
                {
                  backgroundColor: theme.primary,
                },
              ]}
            >
              <ThemedText style={[styles.avatarText, { color: theme.buttonText }]}>
                {profile?.display_name?.charAt(0).toUpperCase() || "U"}
              </ThemedText>
            </View>
            <View style={styles.profileInfo}>
              <ThemedText style={styles.profileName}>{profile?.display_name || "Пользователь"}</ThemedText>
              <ThemedView
                style={[
                  styles.roleBadge,
                  {
                    backgroundColor: theme.primary,
                  },
                ]}
              >
                <ThemedText style={[styles.roleText, { color: theme.buttonText }]}>
                  {isAdmin ? "Администратор" : "Менеджер"}
                </ThemedText>
              </ThemedView>
            </View>
          </View>
        </ThemedView>

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>Настройки</ThemedText>
          <ThemedView
            style={[
              styles.settingsGroup,
              {
                borderColor: theme.border,
                borderRadius: BorderRadius.sm,
              },
            ]}
          >
            {isAdmin ? (
              <>
                <Pressable
                  onPress={() => navigation.navigate("TicketPrices")}
                  style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
                >
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Feather name="dollar-sign" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>Цены на билеты</ThemedText>
                    </View>
                    <Feather name="chevron-right" size={20} color={theme.textSecondary} />
                  </View>
                </Pressable>
                <View style={[styles.divider, { backgroundColor: theme.border }]} />
              </>
            ) : null}
            <Pressable
              onPress={() => navigation.navigate("DeletedData")}
              style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
            >
              <View style={styles.settingItem}>
                <View style={styles.settingLeft}>
                  <Feather name="trash" size={20} color={theme.textSecondary} />
                  <ThemedText style={styles.settingText}>Удаленные данные</ThemedText>
                </View>
                <Feather name="chevron-right" size={20} color={theme.textSecondary} />
              </View>
            </Pressable>

            {isAdmin ? (
              <>
                <View style={[styles.divider, { backgroundColor: theme.border }]} />
                <Pressable
                  onPress={() => navigation.navigate("AdminPanel")}
                  style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
                >
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Feather name="users" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>Панель администратора</ThemedText>
                    </View>
                    <Feather name="chevron-right" size={20} color={theme.textSecondary} />
                  </View>
                </Pressable>
              </>
            ) : null}

            <View style={[styles.divider, { backgroundColor: theme.border }]} />
            <Pressable
              onPress={() => navigation.navigate("RadioGuides")}
              style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
            >
              <View style={styles.settingItem}>
                <View style={styles.settingLeft}>
                  <Feather name="radio" size={20} color={theme.textSecondary} />
                  <ThemedText style={styles.settingText}>Радиогиды</ThemedText>
                </View>
                <Feather name="chevron-right" size={20} color={theme.textSecondary} />
              </View>
            </Pressable>
            {isAdmin ? (
              <>
                <View style={[styles.divider, { backgroundColor: theme.border }]} />
                <Pressable
                  onPress={() => navigation.navigate("DatabaseSettings")}
                  style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
                >
                  <View style={styles.settingItem}>
                    <View style={styles.settingLeft}>
                      <Feather name="database" size={20} color={theme.textSecondary} />
                      <ThemedText style={styles.settingText}>База данных</ThemedText>
                    </View>
                    <Feather name="chevron-right" size={20} color={theme.textSecondary} />
                  </View>
                </Pressable>
              </>
            ) : null}
          </ThemedView>
        </View>

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>О приложении</ThemedText>
          <ThemedView
            style={[
              styles.settingsGroup,
              {
                borderColor: theme.border,
                borderRadius: BorderRadius.sm,
              },
            ]}
          >
            <View style={styles.settingItem}>
              <ThemedText style={[styles.settingText, { color: theme.textSecondary }]}>
                Версия
              </ThemedText>
              <ThemedText style={styles.settingText}>1.0.0</ThemedText>
            </View>
          </ThemedView>
        </View>

        <Pressable
          onPress={handleLogout}
          style={({ pressed }) => [
            styles.logoutButton,
            {
              backgroundColor: theme.error,
              opacity: pressed ? 0.7 : 1,
            },
          ]}
        >
          <Feather name="log-out" size={20} color={theme.buttonText} />
          <ThemedText style={[styles.logoutText, { color: theme.buttonText }]}>Выйти</ThemedText>
        </Pressable>
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing["2xl"],
  },
  profileCard: {
    padding: Spacing.xl,
    borderWidth: 1,
  },
  avatarContainer: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.lg,
  },
  avatar: {
    width: 64,
    height: 64,
    borderRadius: 32,
    alignItems: "center",
    justifyContent: "center",
  },
  avatarText: {
    fontSize: 28,
    fontWeight: "700",
  },
  profileInfo: {
    flex: 1,
    gap: Spacing.sm,
  },
  profileName: {
    fontSize: 20,
    fontWeight: "600",
  },
  roleBadge: {
    alignSelf: "flex-start",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.xs,
    borderRadius: BorderRadius.xs,
  },
  roleText: {
    fontSize: 12,
    fontWeight: "500",
  },
  section: {
    gap: Spacing.md,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  settingsGroup: {
    borderWidth: 1,
    overflow: "hidden",
  },
  settingItem: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    padding: Spacing.lg,
  },
  settingLeft: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.md,
  },
  settingText: {
    fontSize: 16,
  },
  divider: {
    height: 1,
    marginLeft: Spacing.lg + 20 + Spacing.md,
  },
  logoutButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.lg,
    borderRadius: BorderRadius.xs,
    gap: Spacing.sm,
  },
  logoutText: {
    fontSize: 16,
    fontWeight: "600",
  },
});
