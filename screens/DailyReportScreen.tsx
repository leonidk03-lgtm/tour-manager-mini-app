import { useState, useMemo, useEffect, useCallback } from "react";
import { View, StyleSheet, Pressable, TextInput, Alert, Platform, ActivityIndicator } from "react-native";
import { Feather } from "@expo/vector-icons";
import * as Clipboard from "expo-clipboard";
import AsyncStorage from "@react-native-async-storage/async-storage";
import DateTimePicker from "@react-native-community/datetimepicker";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";

export default function DailyReportScreen() {
  const { theme } = useTheme();
  const { isAdmin } = useAuth();
  const { excursions, transactions, tourTypes, additionalServices, radioGuidePrice } = useData();

  const [selectedDate, setSelectedDate] = useState(new Date());
  const [tempDate, setTempDate] = useState(new Date());
  const [showDatePicker, setShowDatePicker] = useState(false);

  const [bankDeposit, setBankDeposit] = useState("");
  const [safeDeposit, setSafeDeposit] = useState("");
  const [cashAmount, setCashAmount] = useState("");
  const [incomeField, setIncomeField] = useState("");
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [hasExistingReport, setHasExistingReport] = useState(false);

  const getStorageKey = (dateStr: string) => `daily_report_${dateStr}`;

  const loadReportData = useCallback(async (date: Date) => {
    const dateStr = date.toISOString().split("T")[0];
    const key = getStorageKey(dateStr);
    console.log("Loading report for date:", dateStr, "key:", key);
    setLoading(true);
    try {
      const stored = await AsyncStorage.getItem(key);
      console.log("Stored data:", stored);
      if (stored) {
        const data = JSON.parse(stored);
        setBankDeposit(data.bankDeposit || "");
        setSafeDeposit(data.safeDeposit || "");
        setCashAmount(data.cashAmount || "");
        setIncomeField(data.incomeField || "");
        setHasExistingReport(true);
        console.log("Loaded existing report data");
      } else {
        setBankDeposit("");
        setSafeDeposit("");
        setCashAmount("");
        setIncomeField("");
        setHasExistingReport(false);
        console.log("No existing report found");
      }
    } catch (err) {
      console.error("Error loading report:", err);
    } finally {
      setLoading(false);
    }
  }, []);

  const saveReportData = async () => {
    const dateStr = selectedDate.toISOString().split("T")[0];
    const key = getStorageKey(dateStr);
    console.log("Saving report for date:", dateStr, "key:", key);
    setSaving(true);
    try {
      const reportData = {
        bankDeposit,
        safeDeposit,
        cashAmount,
        incomeField,
        updatedAt: new Date().toISOString(),
      };
      console.log("Report data to save:", reportData);

      await AsyncStorage.setItem(key, JSON.stringify(reportData));
      setHasExistingReport(true);
      console.log("Report saved successfully");
      Alert.alert("Сохранено", "Данные отчёта сохранены");
    } catch (err) {
      console.error("Error saving report:", err);
      Alert.alert("Ошибка", "Не удалось сохранить данные");
    } finally {
      setSaving(false);
    }
  };

  const selectedDateStr = selectedDate.toISOString().split("T")[0];
  
  useEffect(() => {
    loadReportData(selectedDate);
  }, [selectedDateStr, loadReportData]);

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

  const formatDateDisplay = (date: Date) => {
    return date.toLocaleDateString("ru-RU", {
      day: "2-digit",
      month: "2-digit",
      year: "numeric",
    });
  };

  const formatMoney = (amount: number) => {
    return amount.toLocaleString("ru-RU");
  };

  const reportData = useMemo(() => {
    const dateStr = selectedDate.toISOString().split("T")[0];

    const dayExcursions = excursions.filter((e) => e.date === dateStr);
    const dayTransactions = transactions.filter((t) => t.date === dateStr);

    const grouped: Record<string, typeof dayExcursions> = {};
    dayExcursions.forEach((exc) => {
      const tourType = tourTypes.find((t) => t.id === exc.tourTypeId);
      const name = tourType?.name || "Неизвестный тип";
      if (!grouped[name]) grouped[name] = [];
      grouped[name].push(exc);
    });

    let totalRevenue = 0;
    let totalExpenses = 0;
    let radioGuideParticipants = 0;

    const tourTypeReports: {
      name: string;
      buses: { total: number; discounted: number }[];
      freeCount: number;
      byTourCount: number;
      paidCount: number;
      services: { name: string; count: number }[];
      guideExpenses: number[];
      prepaymentTotal: number;
    }[] = [];

    Object.entries(grouped).forEach(([typeName, excs]) => {
      const tourType = tourTypes.find((t) => t.name === typeName);
      const buses: { total: number; discounted: number }[] = [];
      let freeCount = 0;
      let byTourCount = 0;
      let paidCount = 0;
      const servicesMap: Record<string, number> = {};
      const guideExpenses: number[] = [];
      let prepaymentTotal = 0;

      excs.forEach((exc) => {
        const total = exc.fullPriceCount + exc.discountedCount + exc.freeCount + exc.tourPackageCount + exc.byTourCount + exc.paidCount;
        buses.push({ total, discounted: exc.discountedCount });

        freeCount += exc.freeCount;
        byTourCount += exc.byTourCount;
        paidCount += exc.paidCount;

        exc.additionalServices.forEach((svc) => {
          const service = additionalServices.find((s) => s.id === svc.serviceId);
          if (service && svc.count > 0) {
            servicesMap[service.name] = (servicesMap[service.name] || 0) + svc.count;
          }
        });

        let guideExp = 0;
        exc.expenses.forEach((exp) => {
          if (exp.type === "Экскурсовод") {
            guideExp += exp.amount;
          } else if (exp.type === "Предоплата") {
            prepaymentTotal += exp.amount;
          }
          totalExpenses += exp.amount;
        });
        if (guideExp > 0) guideExpenses.push(guideExp);

        const ticketRevenue =
          exc.fullPriceCount * (tourType?.fullPrice || 0) +
          exc.discountedCount * (tourType?.discountedPrice || 0);
        totalRevenue += ticketRevenue;

        exc.additionalServices.forEach((svc) => {
          const service = additionalServices.find((s) => s.id === svc.serviceId);
          if (service) {
            totalRevenue += svc.count * service.price;
          }
        });

        if (tourType?.hasRadioGuides) {
          radioGuideParticipants += total;
        }
      });

      const services = Object.entries(servicesMap).map(([name, count]) => ({ name, count }));

      tourTypeReports.push({
        name: typeName,
        buses,
        freeCount,
        byTourCount,
        paidCount,
        services,
        guideExpenses,
        prepaymentTotal,
      });
    });

    const additionalExpenses = dayTransactions
      .filter((t) => t.type === "expense")
      .map((t) => ({ description: t.description, amount: t.amount }));

    const additionalIncome = dayTransactions
      .filter((t) => t.type === "income")
      .map((t) => ({ description: t.description, amount: t.amount }));

    additionalExpenses.forEach((e) => (totalExpenses += e.amount));
    additionalIncome.forEach((i) => (totalRevenue += i.amount));

    const radioGuideTotal = radioGuideParticipants * radioGuidePrice;
    const profit = totalRevenue - totalExpenses;

    return {
      tourTypeReports,
      additionalExpenses,
      additionalIncome,
      radioGuideParticipants,
      radioGuideTotal,
      profit,
    };
  }, [selectedDate, excursions, transactions, tourTypes, additionalServices, radioGuidePrice]);

  const generateReportText = () => {
    const lines: string[] = [];

    lines.push(`📅 Отчет за ${formatDateDisplay(selectedDate)}`);
    lines.push("");

    reportData.tourTypeReports.forEach((report) => {
      lines.push(report.name);

      const busesStr = report.buses.map((b) => `${b.total}, ${b.discounted}`).join("; ");
      lines.push(busesStr);

      if (report.freeCount > 0) {
        lines.push(`${report.freeCount} бесплатно`);
      }
      if (report.byTourCount > 0) {
        lines.push(`${report.byTourCount} по туру`);
      }
      if (report.paidCount > 0) {
        lines.push(`${report.paidCount} оплаченных`);
      }

      report.services.forEach((svc) => {
        lines.push(`${svc.count} ${svc.name}`);
      });

      report.guideExpenses.forEach((exp) => {
        lines.push(`${formatMoney(exp)}₽ экс`);
      });

      if (report.prepaymentTotal > 0) {
        lines.push(`${formatMoney(report.prepaymentTotal)}₽ пред`);
      }

      lines.push("");
    });

    if (reportData.additionalExpenses.length > 0) {
      lines.push("Дополнительные расходы:");
      reportData.additionalExpenses.forEach((exp) => {
        lines.push(`${exp.description} - ${formatMoney(exp.amount)}₽`);
      });
      lines.push("");
    }

    if (reportData.additionalIncome.length > 0) {
      lines.push("Дополнительные доходы:");
      reportData.additionalIncome.forEach((inc) => {
        lines.push(`${inc.description} - ${formatMoney(inc.amount)}₽`);
      });
      lines.push("");
    }

    if (reportData.radioGuideParticipants > 0) {
      lines.push(
        `Радиогиды работали: ${reportData.radioGuideParticipants} шт. = ${formatMoney(reportData.radioGuideTotal)}₽`
      );
      lines.push("");
    }

    if (bankDeposit) {
      lines.push(`Положил на Р/с: ${bankDeposit}`);
    }
    if (safeDeposit) {
      lines.push(`Положил в сейф: ${safeDeposit}`);
    }

    lines.push("");
    lines.push(`Всего: ${formatMoney(reportData.profit)}`);

    if (cashAmount) {
      lines.push(`Денег: ${cashAmount}`);
    }

    if (incomeField) {
      lines.push(`Доход: ${incomeField}`);
    }

    return lines.join("\n");
  };

  const copyToClipboard = async () => {
    const text = generateReportText();
    await Clipboard.setStringAsync(text);
    Alert.alert("Скопировано", "Отчёт скопирован в буфер обмена");
  };

  const onDateChange = (event: any, date?: Date) => {
    if (Platform.OS === "ios") {
      if (date) {
        setTempDate(date);
      }
    } else {
      setShowDatePicker(false);
      if (date) {
        setSelectedDate(date);
      }
    }
  };

  const confirmDateSelection = () => {
    setSelectedDate(tempDate);
    setShowDatePicker(false);
  };

  const cancelDateSelection = () => {
    setTempDate(selectedDate);
    setShowDatePicker(false);
  };

  const openDatePicker = () => {
    setTempDate(selectedDate);
    setShowDatePicker(true);
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <ThemedText style={styles.header}>Ежедневный отчёт</ThemedText>

        <Pressable
          style={[styles.dateButton, { backgroundColor: theme.backgroundSecondary }]}
          onPress={openDatePicker}
        >
          <Feather name="calendar" size={20} color={theme.primary} />
          <ThemedText style={styles.dateText}>{formatDateDisplay(selectedDate)}</ThemedText>
        </Pressable>

        {showDatePicker && (
          <View>
            {Platform.OS === "ios" && (
              <View style={styles.datePickerButtons}>
                <Pressable onPress={cancelDateSelection} style={styles.datePickerButton}>
                  <ThemedText style={{ color: theme.textSecondary }}>Отмена</ThemedText>
                </Pressable>
                <Pressable onPress={confirmDateSelection} style={styles.datePickerButton}>
                  <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>Готово</ThemedText>
                </Pressable>
              </View>
            )}
            <DateTimePicker
              value={tempDate}
              mode="date"
              display={Platform.OS === "ios" ? "spinner" : "default"}
              onChange={onDateChange}
              maximumDate={new Date()}
            />
          </View>
        )}

        <ThemedView style={[styles.reportContainer, { backgroundColor: theme.backgroundSecondary }]}>
          <ThemedText style={styles.reportTitle}>
            📅 Отчет за {formatDateDisplay(selectedDate)}
          </ThemedText>

          {reportData.tourTypeReports.length === 0 ? (
            <ThemedText style={[styles.emptyText, { color: theme.textSecondary }]}>
              Нет экскурсий за этот день
            </ThemedText>
          ) : (
            reportData.tourTypeReports.map((report, idx) => (
              <View key={idx} style={styles.tourTypeBlock}>
                <ThemedText style={styles.tourTypeName}>{report.name}</ThemedText>
                <ThemedText style={{ color: theme.textSecondary }}>
                  {report.buses.map((b) => `${b.total}, ${b.discounted}`).join("; ")}
                </ThemedText>

                {report.freeCount > 0 && (
                  <ThemedText style={{ color: theme.textSecondary }}>
                    {report.freeCount} бесплатно
                  </ThemedText>
                )}
                {report.byTourCount > 0 && (
                  <ThemedText style={{ color: theme.textSecondary }}>
                    {report.byTourCount} по туру
                  </ThemedText>
                )}
                {report.paidCount > 0 && (
                  <ThemedText style={{ color: theme.textSecondary }}>
                    {report.paidCount} оплаченных
                  </ThemedText>
                )}

                {report.services.map((svc, sIdx) => (
                  <ThemedText key={sIdx} style={{ color: theme.textSecondary }}>
                    {svc.count} {svc.name}
                  </ThemedText>
                ))}

                {report.guideExpenses.map((exp, eIdx) => (
                  <ThemedText key={eIdx} style={{ color: theme.textSecondary }}>
                    {formatMoney(exp)}₽ экс
                  </ThemedText>
                ))}

                {report.prepaymentTotal > 0 && (
                  <ThemedText style={{ color: theme.textSecondary }}>
                    {formatMoney(report.prepaymentTotal)}₽ пред
                  </ThemedText>
                )}
              </View>
            ))
          )}

          {reportData.additionalExpenses.length > 0 && (
            <View style={styles.section}>
              <ThemedText style={styles.sectionTitle}>Дополнительные расходы:</ThemedText>
              {reportData.additionalExpenses.map((exp, idx) => (
                <ThemedText key={idx} style={{ color: theme.textSecondary }}>
                  {exp.description} - {formatMoney(exp.amount)}₽
                </ThemedText>
              ))}
            </View>
          )}

          {reportData.additionalIncome.length > 0 && (
            <View style={styles.section}>
              <ThemedText style={styles.sectionTitle}>Дополнительные доходы:</ThemedText>
              {reportData.additionalIncome.map((inc, idx) => (
                <ThemedText key={idx} style={{ color: theme.textSecondary }}>
                  {inc.description} - {formatMoney(inc.amount)}₽
                </ThemedText>
              ))}
            </View>
          )}

          {reportData.radioGuideParticipants > 0 && (
            <View style={styles.section}>
              <ThemedText style={{ color: theme.textSecondary }}>
                Радиогиды работали: {reportData.radioGuideParticipants} шт. ={" "}
                {formatMoney(reportData.radioGuideTotal)}₽
              </ThemedText>
            </View>
          )}
        </ThemedView>

        <View style={styles.inputsSection}>
          <ThemedText style={styles.inputLabel}>Положил на Р/с:</ThemedText>
          <TextInput
            style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
            value={bankDeposit}
            onChangeText={setBankDeposit}
            placeholder="Сумма"
            placeholderTextColor={theme.textSecondary}
            keyboardType="numeric"
          />

          <ThemedText style={styles.inputLabel}>Положил в сейф:</ThemedText>
          <TextInput
            style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
            value={safeDeposit}
            onChangeText={setSafeDeposit}
            placeholder="Сумма"
            placeholderTextColor={theme.textSecondary}
            keyboardType="numeric"
          />

          <View style={styles.profitRow}>
            <ThemedText style={styles.profitLabel}>Всего (прибыль):</ThemedText>
            <ThemedText style={[styles.profitValue, { color: theme.primary }]}>
              {formatMoney(reportData.profit)}₽
            </ThemedText>
          </View>

          <ThemedText style={styles.inputLabel}>Денег:</ThemedText>
          <TextInput
            style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
            value={cashAmount}
            onChangeText={setCashAmount}
            placeholder="Наличные"
            placeholderTextColor={theme.textSecondary}
            keyboardType="numeric"
          />

          <ThemedText style={styles.inputLabel}>Доход:</ThemedText>
          <TextInput
            style={[styles.input, { backgroundColor: theme.backgroundSecondary, color: theme.text }]}
            value={incomeField}
            onChangeText={setIncomeField}
            placeholder="Доход"
            placeholderTextColor={theme.textSecondary}
            keyboardType="numeric"
          />

          {loading ? (
            <ActivityIndicator size="small" color={theme.primary} style={{ marginTop: Spacing.md }} />
          ) : null}

          <Pressable
            style={[styles.saveButton, { backgroundColor: theme.success, opacity: saving ? 0.6 : 1 }]}
            onPress={saveReportData}
            disabled={saving}
          >
            <Feather name="save" size={20} color="#fff" />
            <ThemedText style={styles.copyButtonText}>
              {saving ? "Сохранение..." : hasExistingReport ? "Обновить данные" : "Сохранить данные"}
            </ThemedText>
          </Pressable>
        </View>

        <Pressable
          style={[styles.copyButton, { backgroundColor: theme.primary }]}
          onPress={copyToClipboard}
        >
          <Feather name="copy" size={20} color="#fff" />
          <ThemedText style={styles.copyButtonText}>Скопировать отчёт</ThemedText>
        </Pressable>
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: Spacing.md,
  },
  header: {
    fontSize: 24,
    fontWeight: "700",
    marginBottom: Spacing.lg,
    textAlign: "center",
  },
  dateButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.lg,
    gap: Spacing.sm,
  },
  dateText: {
    fontSize: 18,
    fontWeight: "600",
  },
  reportContainer: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.lg,
  },
  reportTitle: {
    fontSize: 18,
    fontWeight: "700",
    marginBottom: Spacing.md,
  },
  emptyText: {
    textAlign: "center",
    fontStyle: "italic",
  },
  tourTypeBlock: {
    marginBottom: Spacing.md,
  },
  tourTypeName: {
    fontSize: 16,
    fontWeight: "600",
    marginBottom: Spacing.xs,
  },
  section: {
    marginTop: Spacing.md,
    paddingTop: Spacing.md,
    borderTopWidth: 1,
    borderTopColor: "rgba(255,255,255,0.1)",
  },
  sectionTitle: {
    fontSize: 14,
    fontWeight: "600",
    marginBottom: Spacing.xs,
  },
  inputsSection: {
    marginBottom: Spacing.lg,
  },
  inputLabel: {
    fontSize: 14,
    fontWeight: "500",
    marginBottom: Spacing.xs,
  },
  input: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.md,
    fontSize: 16,
  },
  profitRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    marginVertical: Spacing.md,
    paddingVertical: Spacing.md,
    borderTopWidth: 1,
    borderBottomWidth: 1,
    borderColor: "rgba(255,255,255,0.1)",
  },
  profitLabel: {
    fontSize: 16,
    fontWeight: "600",
  },
  profitValue: {
    fontSize: 20,
    fontWeight: "700",
  },
  saveButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
    marginTop: Spacing.lg,
  },
  copyButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
  },
  copyButtonText: {
    color: "#fff",
    fontSize: 16,
    fontWeight: "600",
  },
  datePickerButtons: {
    flexDirection: "row",
    justifyContent: "space-between",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
  },
  datePickerButton: {
    padding: Spacing.sm,
  },
});
