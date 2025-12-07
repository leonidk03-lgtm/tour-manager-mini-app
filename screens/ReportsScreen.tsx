import { View, StyleSheet, Pressable } from "react-native";
import { Feather } from "@expo/vector-icons";
import { useNavigation, NavigationProp } from "@react-navigation/native";
import { SettingsStackParamList } from "@/navigation/SettingsStackNavigator";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";

type ReportItem = {
  id: string;
  title: string;
  description: string;
  icon: keyof typeof Feather.glyphMap;
  screen: keyof SettingsStackParamList;
};

const reportItems: ReportItem[] = [
  {
    id: "daily",
    title: "Ежедневный отчёт",
    description: "Отчёт за день для копирования",
    icon: "clipboard",
    screen: "DailyReport",
  },
  {
    id: "financial",
    title: "Финансовый отчёт",
    description: "Доходы, расходы и прибыль за период",
    icon: "dollar-sign",
    screen: "FinancialReport",
  },
  {
    id: "excursions",
    title: "Отчёт по экскурсиям",
    description: "Популярные типы и статистика участников",
    icon: "map",
    screen: "ExcursionsReport",
  },
  {
    id: "radioguides",
    title: "Отчёт по радиогидам",
    description: "Выдачи, возвраты и потери оборудования",
    icon: "radio",
    screen: "RadioGuidesReport",
  },
  {
    id: "export",
    title: "Экспорт данных",
    description: "Скачать отчёт в файл",
    icon: "download",
    screen: "ExportData",
  },
];

export default function ReportsScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const navigation = useNavigation<NavigationProp<SettingsStackParamList>>();

  if (!isAdmin) {
    return (
      <ScreenScrollView>
        <View style={styles.container}>
          <ThemedText style={styles.header}>Доступ запрещён</ThemedText>
          <ThemedText style={{ textAlign: "center", color: theme.textSecondary }}>
            Этот раздел доступен только администраторам
          </ThemedText>
        </View>
      </ScreenScrollView>
    );
  }

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <ThemedText style={styles.header}>Выберите тип отчёта</ThemedText>

        <View style={styles.grid}>
          {reportItems.map((item) => (
            <Pressable
              key={item.id}
              onPress={() => navigation.navigate(item.screen as any)}
              style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1 })}
            >
              <ThemedView
                style={[
                  styles.card,
                  {
                    borderColor: theme.border,
                    borderRadius: BorderRadius.sm,
                  },
                ]}
              >
                <View
                  style={[
                    styles.iconContainer,
                    { backgroundColor: theme.primary + "20" },
                  ]}
                >
                  <Feather name={item.icon} size={28} color={theme.primary} />
                </View>
                <ThemedText style={styles.cardTitle}>{item.title}</ThemedText>
                <ThemedText
                  style={[styles.cardDescription, { color: theme.textSecondary }]}
                >
                  {item.description}
                </ThemedText>
              </ThemedView>
            </Pressable>
          ))}
        </View>
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing.xl,
  },
  header: {
    fontSize: 16,
    fontWeight: "500",
  },
  grid: {
    gap: Spacing.md,
  },
  card: {
    padding: Spacing.xl,
    borderWidth: 1,
    gap: Spacing.sm,
  },
  iconContainer: {
    width: 56,
    height: 56,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    justifyContent: "center",
    marginBottom: Spacing.sm,
  },
  cardTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  cardDescription: {
    fontSize: 14,
  },
});
