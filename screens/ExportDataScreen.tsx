import { useState } from "react";
import { View, StyleSheet, Pressable, Alert, Platform } from "react-native";
import { Feather } from "@expo/vector-icons";
import * as Sharing from "expo-sharing";
import {
  documentDirectory,
  writeAsStringAsync,
  EncodingType,
} from "expo-file-system/legacy";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";

type ExportType = "excursions" | "transactions" | "radioguides" | "all";

const exportOptions: { id: ExportType; title: string; description: string; icon: keyof typeof Feather.glyphMap }[] = [
  {
    id: "excursions",
    title: "Экскурсии",
    description: "Все экскурсии с участниками и выручкой",
    icon: "map",
  },
  {
    id: "transactions",
    title: "Транзакции",
    description: "Все доходы и расходы",
    icon: "credit-card",
  },
  {
    id: "radioguides",
    title: "Радиогиды",
    description: "Выдачи и возвраты оборудования",
    icon: "radio",
  },
  {
    id: "all",
    title: "Все данные",
    description: "Полный отчёт по всем разделам",
    icon: "database",
  },
];

export default function ExportDataScreen() {
  const { theme } = useTheme();
  const { excursions, transactions, tourTypes, additionalServices, radioGuideKits, radioGuideAssignments, equipmentLosses } = useData();
  const [exporting, setExporting] = useState<ExportType | null>(null);

  const formatDate = (dateStr: string) => {
    const date = new Date(dateStr);
    return date.toLocaleDateString("ru-RU");
  };

  const formatMoney = (amount: number) => {
    return amount.toLocaleString("ru-RU");
  };

  const generateExcursionsCSV = () => {
    const headers = [
      "Дата",
      "Тип экскурсии",
      "Артикул",
      "Полная цена",
      "Льготные",
      "Бесплатно",
      "Турпакет",
      "По туру",
      "Оплатили",
      "Всего участников",
      "Выручка билеты",
      "Выручка услуги",
      "Расходы",
      "Менеджер",
    ];

    const rows = excursions.map((exc) => {
      const tourType = tourTypes.find((t) => t.id === exc.tourTypeId);
      const totalParticipants =
        exc.fullPriceCount + exc.discountedCount + exc.freeCount + exc.tourPackageCount + exc.byTourCount + exc.paidCount;

      let ticketRevenue = 0;
      if (tourType) {
        ticketRevenue = exc.fullPriceCount * tourType.fullPrice + exc.discountedCount * tourType.discountedPrice;
      }

      let servicesRevenue = 0;
      if (exc.additionalServices) {
        exc.additionalServices.forEach((as) => {
          const service = additionalServices.find((s) => s.id === as.serviceId);
          if (service) {
            servicesRevenue += as.count * service.price;
          }
        });
      }

      let expenses = 0;
      if (exc.expenses) {
        expenses = exc.expenses.reduce((sum, e) => sum + e.amount, 0);
      }

      return [
        formatDate(exc.date),
        tourType?.name || "Неизвестно",
        tourType?.articleNumber || "",
        exc.fullPriceCount,
        exc.discountedCount,
        exc.freeCount,
        exc.tourPackageCount,
        exc.byTourCount,
        exc.paidCount,
        totalParticipants,
        formatMoney(ticketRevenue),
        formatMoney(servicesRevenue),
        formatMoney(expenses),
        exc.managerName || "",
      ];
    });

    return [headers, ...rows].map((row) => row.join(";")).join("\n");
  };

  const generateTransactionsCSV = () => {
    const headers = ["Дата", "Тип", "Сумма", "Описание", "Менеджер"];

    const rows = transactions.map((t) => [
      formatDate(t.date),
      t.type === "income" ? "Доход" : "Расход",
      formatMoney(t.amount),
      t.description,
      t.managerName || "",
    ]);

    return [headers, ...rows].map((row) => row.join(";")).join("\n");
  };

  const generateRadioGuidesCSV = () => {
    const headers = [
      "Дата выдачи",
      "Сумка",
      "Гид",
      "Автобус",
      "Выдано приёмников",
      "Возвращено",
      "Дата возврата",
      "Статус",
      "Менеджер",
    ];

    const rows = radioGuideAssignments.map((a) => {
      const kit = radioGuideKits.find((k) => k.id === a.kitId);
      return [
        formatDate(a.issuedAt),
        kit?.bagNumber || "?",
        a.guideName,
        a.busNumber || "",
        a.receiversIssued,
        a.receiversReturned || "",
        a.returnedAt ? formatDate(a.returnedAt) : "",
        a.returnedAt ? "Возвращено" : "Выдано",
        a.managerName || "",
      ];
    });

    return [headers, ...rows].map((row) => row.join(";")).join("\n");
  };

  const generateLossesCSV = () => {
    const headers = ["Дата", "Сумка", "Гид", "Потеряно приёмников", "Причина", "Статус", "Менеджер"];

    const rows = equipmentLosses.map((l) => {
      const kit = radioGuideKits.find((k) => k.id === l.kitId);
      return [
        formatDate(l.createdAt),
        kit?.bagNumber || "?",
        l.guideName,
        l.missingCount,
        l.reason,
        l.status === "lost" ? "Потеряно" : "Найдено",
        l.managerName || "",
      ];
    });

    return [headers, ...rows].map((row) => row.join(";")).join("\n");
  };

  const handleExport = async (type: ExportType) => {
    setExporting(type);

    try {
      let content = "";
      let filename = "";
      const date = new Date().toISOString().split("T")[0];

      switch (type) {
        case "excursions":
          content = generateExcursionsCSV();
          filename = `excursions_${date}.csv`;
          break;
        case "transactions":
          content = generateTransactionsCSV();
          filename = `transactions_${date}.csv`;
          break;
        case "radioguides":
          content = generateRadioGuidesCSV();
          filename = `radioguides_${date}.csv`;
          break;
        case "all":
          content = `ЭКСКУРСИИ\n${generateExcursionsCSV()}\n\nТРАНЗАКЦИИ\n${generateTransactionsCSV()}\n\nРАДИОГИДЫ\n${generateRadioGuidesCSV()}\n\nУТЕРИ ОБОРУДОВАНИЯ\n${generateLossesCSV()}`;
          filename = `full_report_${date}.csv`;
          break;
      }

      if (Platform.OS === "web") {
        const blob = new Blob(["\uFEFF" + content], { type: "text/csv;charset=utf-8" });
        const url = URL.createObjectURL(blob);
        const a = document.createElement("a");
        a.href = url;
        a.download = filename;
        a.click();
        URL.revokeObjectURL(url);
        Alert.alert("Готово", "Файл скачан");
      } else {
        const fileUri = documentDirectory + filename;
        await writeAsStringAsync(fileUri, "\uFEFF" + content, {
          encoding: EncodingType.UTF8,
        });

        const canShare = await Sharing.isAvailableAsync();
        if (canShare) {
          await Sharing.shareAsync(fileUri, {
            mimeType: "text/csv",
            dialogTitle: "Сохранить отчёт",
          });
        } else {
          Alert.alert("Готово", `Файл сохранён: ${filename}`);
        }
      }
    } catch (error) {
      console.error("Export error:", error);
      Alert.alert("Ошибка", "Не удалось экспортировать данные");
    } finally {
      setExporting(null);
    }
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <ThemedText style={[styles.header, { color: theme.textSecondary }]}>
          Выберите данные для экспорта. Файл будет сохранён в формате CSV, который можно открыть в Excel.
        </ThemedText>

        <View style={styles.options}>
          {exportOptions.map((option) => (
            <Pressable
              key={option.id}
              onPress={() => handleExport(option.id)}
              disabled={exporting !== null}
              style={({ pressed }) => ({ opacity: pressed || exporting !== null ? 0.7 : 1 })}
            >
              <ThemedView
                style={[
                  styles.optionCard,
                  {
                    borderColor: theme.border,
                    borderRadius: BorderRadius.sm,
                  },
                ]}
              >
                <View style={styles.optionContent}>
                  <View
                    style={[
                      styles.iconContainer,
                      { backgroundColor: theme.primary + "20" },
                    ]}
                  >
                    <Feather name={option.icon} size={24} color={theme.primary} />
                  </View>
                  <View style={styles.optionText}>
                    <ThemedText style={styles.optionTitle}>{option.title}</ThemedText>
                    <ThemedText style={[styles.optionDescription, { color: theme.textSecondary }]}>
                      {option.description}
                    </ThemedText>
                  </View>
                </View>

                <View
                  style={[
                    styles.exportButton,
                    {
                      backgroundColor: exporting === option.id ? theme.backgroundSecondary : theme.primary,
                    },
                  ]}
                >
                  {exporting === option.id ? (
                    <ThemedText style={[styles.exportButtonText, { color: theme.textSecondary }]}>
                      Экспорт...
                    </ThemedText>
                  ) : (
                    <>
                      <Feather name="download" size={16} color={theme.buttonText} />
                      <ThemedText style={[styles.exportButtonText, { color: theme.buttonText }]}>
                        Скачать
                      </ThemedText>
                    </>
                  )}
                </View>
              </ThemedView>
            </Pressable>
          ))}
        </View>

        <ThemedView
          style={[
            styles.infoCard,
            { backgroundColor: theme.backgroundSecondary, borderRadius: BorderRadius.sm },
          ]}
        >
          <Feather name="info" size={18} color={theme.textSecondary} />
          <ThemedText style={[styles.infoText, { color: theme.textSecondary }]}>
            Файлы CSV можно открыть в Microsoft Excel, Google Sheets или Numbers. Используется кодировка UTF-8 с разделителем ";".
          </ThemedText>
        </ThemedView>
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing.xl,
  },
  header: {
    fontSize: 14,
    lineHeight: 20,
  },
  options: {
    gap: Spacing.md,
  },
  optionCard: {
    padding: Spacing.xl,
    borderWidth: 1,
    gap: Spacing.lg,
  },
  optionContent: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.lg,
  },
  iconContainer: {
    width: 48,
    height: 48,
    borderRadius: BorderRadius.sm,
    alignItems: "center",
    justifyContent: "center",
  },
  optionText: {
    flex: 1,
    gap: Spacing.xs,
  },
  optionTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  optionDescription: {
    fontSize: 14,
  },
  exportButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    paddingVertical: Spacing.md,
    borderRadius: BorderRadius.xs,
  },
  exportButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
  infoCard: {
    flexDirection: "row",
    alignItems: "flex-start",
    gap: Spacing.md,
    padding: Spacing.lg,
  },
  infoText: {
    flex: 1,
    fontSize: 14,
    lineHeight: 20,
  },
});
