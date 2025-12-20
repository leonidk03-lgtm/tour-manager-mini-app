import { useMemo } from "react";
import { View, StyleSheet, Pressable, FlatList } from "react-native";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { useSafeAreaInsets } from "react-native-safe-area-context";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";
import { Profile } from "@/lib/supabase";
import { useRental } from "@/contexts/RentalContext";
import { hapticFeedback } from "@/utils/haptics";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";

interface ManagerWithCommissions {
  manager: Profile;
  pendingAmount: number;
  pendingCount: number;
  totalPaid: number;
}

export default function RentalCommissionsScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation<NavigationProp<SettingsStackParamList>>();
  const insets = useSafeAreaInsets();
  const { isAdmin, profile, managers } = useAuth();
  const { rentalCommissions } = useRental();

  const managersWithCommissions = useMemo(() => {
    const managersList = managers.filter(m => m.role !== "admin");
    
    return managersList.map(manager => {
      const managerCommissions = rentalCommissions.filter(c => c.recipientId === manager.id);
      const pendingCommissions = managerCommissions.filter(c => c.status === "pending");
      const paidCommissions = managerCommissions.filter(c => c.status === "paid");
      
      return {
        manager,
        pendingAmount: pendingCommissions.reduce((sum, c) => sum + c.amount, 0),
        pendingCount: pendingCommissions.length,
        totalPaid: paidCommissions.reduce((sum, c) => sum + c.amount, 0),
      };
    }).sort((a, b) => b.pendingAmount - a.pendingAmount);
  }, [managers, rentalCommissions]);

  const totalPendingAll = useMemo(() => {
    return managersWithCommissions.reduce((sum, m) => sum + m.pendingAmount, 0);
  }, [managersWithCommissions]);

  const handleSelectManager = (item: ManagerWithCommissions) => {
    hapticFeedback.selection();
    navigation.navigate("ManagerCommissions", {
      managerId: item.manager.id,
      managerName: item.manager.display_name || item.manager.email || "Менеджер",
    });
  };

  const renderManager = ({ item }: { item: ManagerWithCommissions }) => {
    const initials = (item.manager.display_name || item.manager.email || "M")
      .slice(0, 2)
      .toUpperCase();

    return (
      <Pressable
        onPress={() => handleSelectManager(item)}
        style={({ pressed }) => [
          styles.managerCard,
          { backgroundColor: theme.backgroundSecondary, opacity: pressed ? 0.7 : 1 },
        ]}
      >
        <View style={[styles.avatar, { backgroundColor: theme.primary }]}>
          <ThemedText style={styles.avatarText}>{initials}</ThemedText>
        </View>
        
        <View style={styles.managerInfo}>
          <ThemedText style={styles.managerName} numberOfLines={1}>
            {item.manager.display_name || item.manager.email}
          </ThemedText>
          <ThemedText style={[styles.managerStats, { color: theme.textSecondary }]}>
            {item.pendingCount > 0 
              ? `${item.pendingCount} начислений к выплате`
              : "Нет начислений"}
          </ThemedText>
        </View>

        <View style={styles.amountContainer}>
          {item.pendingAmount > 0 ? (
            <ThemedText style={[styles.pendingAmount, { color: theme.primary }]}>
              {item.pendingAmount.toLocaleString("ru-RU")}₽
            </ThemedText>
          ) : (
            <ThemedText style={[styles.pendingAmount, { color: theme.textSecondary }]}>
              0₽
            </ThemedText>
          )}
        </View>

        <Icon name="chevron-right" size={20} color={theme.textSecondary} />
      </Pressable>
    );
  };

  const renderHeader = () => (
    <View style={styles.headerContainer}>
      <ThemedView
        style={[
          styles.summaryCard,
          { borderColor: theme.border, borderRadius: BorderRadius.sm },
        ]}
      >
        <ThemedText style={[styles.summaryLabel, { color: theme.textSecondary }]}>
          Всего к выплате
        </ThemedText>
        <ThemedText style={[styles.summaryValue, { color: theme.primary }]}>
          {totalPendingAll.toLocaleString("ru-RU")}₽
        </ThemedText>
      </ThemedView>

      <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
        Менеджеры
      </ThemedText>
    </View>
  );

  if (!isAdmin && profile) {
    navigation.navigate("ManagerCommissions", {
      managerId: profile.id,
      managerName: profile.display_name || profile.email || "Менеджер",
    });
    return null;
  }

  return (
    <View style={[styles.container, { backgroundColor: theme.backgroundRoot }]}>
      <FlatList
        data={managersWithCommissions}
        renderItem={renderManager}
        keyExtractor={(item) => item.manager.id}
        ListHeaderComponent={renderHeader}
        ListEmptyComponent={
          <View style={styles.emptyContainer}>
            <Icon name="users" size={48} color={theme.textSecondary} />
            <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
              Нет менеджеров
            </ThemedText>
          </View>
        }
        contentContainerStyle={[
          styles.listContent,
          { paddingBottom: insets.bottom + Spacing.md },
        ]}
        showsVerticalScrollIndicator={false}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  listContent: {
    paddingHorizontal: Spacing.md,
  },
  headerContainer: {
    marginBottom: Spacing.md,
  },
  summaryCard: {
    padding: Spacing.lg,
    borderWidth: 1,
    marginBottom: Spacing.lg,
    alignItems: "center",
  },
  summaryLabel: {
    fontSize: 14,
    marginBottom: Spacing.xs,
  },
  summaryValue: {
    fontSize: 32,
    lineHeight: 40,
    fontWeight: "700",
  },
  sectionTitle: {
    fontSize: 13,
    fontWeight: "500",
    textTransform: "uppercase",
    marginBottom: Spacing.sm,
  },
  managerCard: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    marginBottom: Spacing.sm,
  },
  avatar: {
    width: 44,
    height: 44,
    borderRadius: 22,
    alignItems: "center",
    justifyContent: "center",
    marginRight: Spacing.md,
  },
  avatarText: {
    color: "#fff",
    fontSize: 16,
    fontWeight: "600",
  },
  managerInfo: {
    flex: 1,
  },
  managerName: {
    fontSize: 16,
    fontWeight: "500",
    marginBottom: 2,
  },
  managerStats: {
    fontSize: 13,
  },
  amountContainer: {
    marginRight: Spacing.sm,
  },
  pendingAmount: {
    fontSize: 16,
    fontWeight: "600",
  },
  emptyContainer: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
    paddingVertical: Spacing["5xl"],
  },
  emptyText: {
    fontSize: 16,
    marginTop: Spacing.md,
  },
});
