import { useState, useMemo, useEffect, useCallback, useRef } from "react";
import { View, StyleSheet, Pressable, TextInput, Alert, Platform, ActivityIndicator } from "react-native";
import { Feather } from "@expo/vector-icons";
import * as Clipboard from "expo-clipboard";
import DateTimePicker from "@react-native-community/datetimepicker";
import Animated, { useAnimatedStyle, useSharedValue, withTiming } from "react-native-reanimated";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { ScreenKeyboardAwareScrollView } from "@/components/ScreenKeyboardAwareScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useData } from "@/contexts/DataContext";
import { useAuth } from "@/contexts/AuthContext";
import { supabase } from "@/lib/supabase";

const getLocalDateKey = (date: Date): string => {
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  return `${year}-${month}-${day}`;
};

interface CollapsibleSectionProps {
  title: string;
  icon: keyof typeof Feather.glyphMap;
  children: React.ReactNode;
  defaultExpanded?: boolean;
}

function CollapsibleSection({ title, icon, children, defaultExpanded = true }: CollapsibleSectionProps) {
  const { theme } = useTheme();
  const [expanded, setExpanded] = useState(defaultExpanded);
  const rotation = useSharedValue(defaultExpanded ? 1 : 0);

  const toggleExpanded = () => {
    setExpanded(!expanded);
    rotation.value = withTiming(expanded ? 0 : 1, { duration: 200 });
  };

  const chevronStyle = useAnimatedStyle(() => ({
    transform: [{ rotate: `${rotation.value * 180}deg` }],
  }));

  return (
    <ThemedView style={[styles.collapsibleContainer, { backgroundColor: theme.backgroundSecondary }]}>
      <Pressable style={styles.collapsibleHeader} onPress={toggleExpanded}>
        <View style={styles.collapsibleTitleRow}>
          <Feather name={icon} size={18} color={theme.primary} />
          <ThemedText style={styles.collapsibleTitle}>{title}</ThemedText>
        </View>
        <Animated.View style={chevronStyle}>
          <Feather name="chevron-up" size={20} color={theme.textSecondary} />
        </Animated.View>
      </Pressable>
      {expanded ? <View style={styles.collapsibleContent}>{children}</View> : null}
    </ThemedView>
  );
}

export default function DailyReportScreen() {
  const { theme } = useTheme();
  const { isAdmin, profile } = useAuth();
  const { excursions, transactions, tourTypes, additionalServices, radioGuidePrice } = useData();

  const today = useRef(new Date()).current;
  const [selectedDate, setSelectedDate] = useState(today);
  const [tempDate, setTempDate] = useState(today);
  const [showDatePicker, setShowDatePicker] = useState(false);
  const loadingDateRef = useRef(0);

  const [bankDeposit, setBankDeposit] = useState("");
  const [safeDeposit, setSafeDeposit] = useState("");
  const [cashAmount, setCashAmount] = useState("");
  const [incomeField, setIncomeField] = useState("");
  const [loading, setLoading] = useState(false);
  const [saving, setSaving] = useState(false);
  const [hasExistingReport, setHasExistingReport] = useState(false);
  const [reportId, setReportId] = useState<string | null>(null);

  const [savedBankDeposit, setSavedBankDeposit] = useState("");
  const [savedSafeDeposit, setSavedSafeDeposit] = useState("");
  const [savedCashAmount, setSavedCashAmount] = useState("");
  const [savedIncomeField, setSavedIncomeField] = useState("");

  const hasUnsavedChanges = 
    bankDeposit !== savedBankDeposit ||
    safeDeposit !== savedSafeDeposit ||
    cashAmount !== savedCashAmount ||
    incomeField !== savedIncomeField;

  const loadReportData = useCallback(async (dateStr: string) => {
    const requestId = ++loadingDateRef.current;
    setLoading(true);
    
    try {
      const { data, error } = await supabase
        .from("daily_reports")
        .select("*")
        .eq("report_date", dateStr)
        .maybeSingle();
      
      if (loadingDateRef.current !== requestId) return;
      
      if (error) {
        console.error("Error loading report:", error);
        return;
      }
      
      if (data) {
        const bank = data.bank_deposit?.toString() || "";
        const safe = data.safe_deposit?.toString() || "";
        const cash = data.cash_amount?.toString() || "";
        const income = data.income_field?.toString() || "";
        setBankDeposit(bank);
        setSafeDeposit(safe);
        setCashAmount(cash);
        setIncomeField(income);
        setSavedBankDeposit(bank);
        setSavedSafeDeposit(safe);
        setSavedCashAmount(cash);
        setSavedIncomeField(income);
        setHasExistingReport(true);
        setReportId(data.id);
      } else {
        setBankDeposit("");
        setSafeDeposit("");
        setCashAmount("");
        setIncomeField("");
        setSavedBankDeposit("");
        setSavedSafeDeposit("");
        setSavedCashAmount("");
        setSavedIncomeField("");
        setHasExistingReport(false);
        setReportId(null);
      }
    } catch (err) {
      console.error("Error loading report:", err);
    } finally {
      if (loadingDateRef.current === requestId) {
        setLoading(false);
      }
    }
  }, []);

  const saveReportData = async () => {
    const dateStr = getLocalDateKey(selectedDate);
    setSaving(true);
    
    try {
      const reportData = {
        report_date: dateStr,
        bank_deposit: bankDeposit ? parseFloat(bankDeposit) : null,
        safe_deposit: safeDeposit ? parseFloat(safeDeposit) : null,
        cash_amount: cashAmount ? parseFloat(cashAmount) : null,
        income_field: incomeField || null,
        manager_id: profile?.id || null,
        updated_at: new Date().toISOString(),
      };

      if (reportId) {
        const { error } = await supabase
          .from("daily_reports")
          .update(reportData)
          .eq("id", reportId);
        
        if (error) throw error;
      } else {
        const { data, error } = await supabase
          .from("daily_reports")
          .insert(reportData)
          .select()
          .single();
        
        if (error) throw error;
        setReportId(data.id);
      }
      
      setSavedBankDeposit(bankDeposit);
      setSavedSafeDeposit(safeDeposit);
      setSavedCashAmount(cashAmount);
      setSavedIncomeField(incomeField);
      setHasExistingReport(true);
      Alert.alert("Сохранено", "Данные отчёта сохранены");
    } catch (err) {
      console.error("Error saving report:", err);
      Alert.alert("Ошибка", "Не удалось сохранить данные");
    } finally {
      setSaving(false);
    }
  };

  const selectedDateStr = getLocalDateKey(selectedDate);
  
  useEffect(() => {
    loadReportData(selectedDateStr);
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
    const dateStr = getLocalDateKey(selectedDate);

    const dayExcursions = excursions.filter((e) => e.date === dateStr);
    const dayTransactions = transactions.filter((t) => t.date === dateStr);

    const tourTypeMap: Record<
      string,
      {
        name: string;
        buses: { total: number; discounted: number }[];
        freeCount: number;
        byTourCount: number;
        paidCount: number;
        services: { name: string; count: number }[];
        guideExpenses: number[];
        prepaymentTotal: number;
      }
    > = {};

    let radioGuideParticipants = 0;

    dayExcursions.forEach((exc) => {
      const tourType = tourTypes.find((t) => t.id === exc.tourTypeId);
      const typeName = tourType?.name || "Неизвестный тип";

      if (!tourTypeMap[exc.tourTypeId]) {
        tourTypeMap[exc.tourTypeId] = {
          name: typeName,
          buses: [],
          freeCount: 0,
          byTourCount: 0,
          paidCount: 0,
          services: [],
          guideExpenses: [],
          prepaymentTotal: 0,
        };
      }

      const group = tourTypeMap[exc.tourTypeId];

      const total = exc.fullPriceCount + exc.discountedCount + exc.freeCount + exc.byTourCount + exc.paidCount;
      group.buses.push({ total, discounted: exc.discountedCount });
      group.freeCount += exc.freeCount;
      group.byTourCount += exc.byTourCount;
      group.paidCount += exc.paidCount;

      if (tourType?.hasRadioGuides) {
        radioGuideParticipants += total;
      }

      exc.additionalServices.forEach((svc) => {
        const service = additionalServices.find((s) => s.id === svc.serviceId);
        if (service) {
          const existing = group.services.find((s) => s.name === service.name);
          if (existing) {
            existing.count += svc.count;
          } else {
            group.services.push({ name: service.name, count: svc.count });
          }
        }
      });

      const guideExpense = exc.expenses.find((e) => e.type === "guide" || e.type === "Экскурсовод");
      if (guideExpense) {
        group.guideExpenses.push(guideExpense.amount);
      }

      const prepayment = exc.expenses.find((e) => e.type === "prepayment" || e.type === "Предоплата");
      if (prepayment) {
        group.prepaymentTotal += prepayment.amount;
      }
    });

    const tourTypeReports = Object.values(tourTypeMap);

    const additionalExpenses: { description: string; amount: number }[] = [];
    const additionalIncome: { description: string; amount: number }[] = [];

    dayTransactions.forEach((t) => {
      if (t.type === "expense") {
        additionalExpenses.push({ description: t.description, amount: t.amount });
      } else {
        additionalIncome.push({ description: t.description, amount: t.amount });
      }
    });

    let totalRevenue = 0;
    let totalExpenses = 0;

    dayExcursions.forEach((exc) => {
      const tourType = tourTypes.find((t) => t.id === exc.tourTypeId);
      if (tourType) {
        totalRevenue += exc.fullPriceCount * tourType.fullPrice;
        totalRevenue += exc.discountedCount * tourType.discountedPrice;
      }
      exc.additionalServices.forEach((svc) => {
        const service = additionalServices.find((s) => s.id === svc.serviceId);
        if (service) {
          totalRevenue += svc.count * service.price;
        }
      });
      exc.expenses.forEach((e) => {
        totalExpenses += e.amount;
      });
    });

    dayTransactions.forEach((t) => {
      if (t.type === "income") {
        totalRevenue += t.amount;
      } else {
        totalExpenses += t.amount;
      }
    });

    const radioGuideTotal = radioGuideParticipants * radioGuidePrice;
    totalRevenue += radioGuideTotal;

    const profit = totalRevenue - totalExpenses;

    return {
      tourTypeReports,
      additionalExpenses,
      additionalIncome,
      totalRevenue,
      totalExpenses,
      profit,
      radioGuideParticipants,
      radioGuideTotal,
      excursionCount: dayExcursions.length,
      transactionCount: dayTransactions.length,
    };
  }, [selectedDate, excursions, transactions, tourTypes, additionalServices, radioGuidePrice]);

  const generateReportText = () => {
    const lines: string[] = [];

    lines.push(`Отчет за ${formatDateDisplay(selectedDate)}`);
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
        if (exp > 0) {
          lines.push(`${formatMoney(exp)}р экс`);
        }
      });

      if (report.prepaymentTotal > 0) {
        lines.push(`${formatMoney(report.prepaymentTotal)}р пред`);
      }

      lines.push("");
    });

    if (reportData.additionalExpenses.length > 0) {
      lines.push("Дополнительные расходы:");
      reportData.additionalExpenses.forEach((exp) => {
        lines.push(`${exp.description} - ${formatMoney(exp.amount)}р`);
      });
      lines.push("");
    }

    if (reportData.additionalIncome.length > 0) {
      lines.push("Дополнительные доходы:");
      reportData.additionalIncome.forEach((inc) => {
        lines.push(`${inc.description} - ${formatMoney(inc.amount)}р`);
      });
      lines.push("");
    }

    if (reportData.radioGuideParticipants > 0) {
      lines.push(
        `Радиогиды работали: ${reportData.radioGuideParticipants} шт. = ${formatMoney(reportData.radioGuideTotal)}р`
      );
      lines.push("");
    }

    if (bankDeposit) {
      lines.push(`Положил на Р/с: ${bankDeposit}`);
    }
    if (safeDeposit) {
      lines.push(`Положил в сейф: ${safeDeposit}`);
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
    <ScreenKeyboardAwareScrollView>
      <View style={styles.container}>
        <View style={styles.headerRow}>
          <ThemedText style={styles.header}>Ежедневный отчёт</ThemedText>
          {hasUnsavedChanges ? (
            <View style={[styles.statusBadge, { backgroundColor: theme.warning }]}>
              <Feather name="edit-3" size={12} color="#fff" />
              <ThemedText style={styles.statusText}>Изменено</ThemedText>
            </View>
          ) : hasExistingReport ? (
            <View style={[styles.statusBadge, { backgroundColor: theme.success }]}>
              <Feather name="check" size={12} color="#fff" />
              <ThemedText style={styles.statusText}>Сохранено</ThemedText>
            </View>
          ) : null}
        </View>

        <Pressable
          style={[styles.dateButton, { backgroundColor: theme.backgroundSecondary }]}
          onPress={openDatePicker}
        >
          <Feather name="calendar" size={20} color={theme.primary} />
          <ThemedText style={styles.dateText}>{formatDateDisplay(selectedDate)}</ThemedText>
        </Pressable>

        {showDatePicker ? (
          <View>
            {Platform.OS === "ios" ? (
              <View style={styles.datePickerButtons}>
                <Pressable onPress={cancelDateSelection} style={styles.datePickerButton}>
                  <ThemedText style={{ color: theme.textSecondary }}>Отмена</ThemedText>
                </Pressable>
                <Pressable onPress={confirmDateSelection} style={styles.datePickerButton}>
                  <ThemedText style={{ color: theme.primary, fontWeight: "600" }}>Готово</ThemedText>
                </Pressable>
              </View>
            ) : null}
            <DateTimePicker
              value={tempDate}
              mode="date"
              display={Platform.OS === "ios" ? "spinner" : "default"}
              onChange={onDateChange}
              maximumDate={new Date()}
            />
          </View>
        ) : null}

        {loading ? (
          <ActivityIndicator size="large" color={theme.primary} style={{ marginVertical: Spacing.xl }} />
        ) : (
          <>
            <CollapsibleSection 
              title={`Экскурсии (${reportData.excursionCount})`} 
              icon="map"
              defaultExpanded={true}
            >
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

                    {report.freeCount > 0 ? (
                      <ThemedText style={{ color: theme.textSecondary }}>
                        {report.freeCount} бесплатно
                      </ThemedText>
                    ) : null}
                    {report.byTourCount > 0 ? (
                      <ThemedText style={{ color: theme.textSecondary }}>
                        {report.byTourCount} по туру
                      </ThemedText>
                    ) : null}
                    {report.paidCount > 0 ? (
                      <ThemedText style={{ color: theme.textSecondary }}>
                        {report.paidCount} оплаченных
                      </ThemedText>
                    ) : null}

                    {report.services.map((svc, sIdx) => (
                      <ThemedText key={sIdx} style={{ color: theme.textSecondary }}>
                        {svc.count} {svc.name}
                      </ThemedText>
                    ))}

                    {report.guideExpenses.filter((exp) => exp > 0).map((exp, eIdx) => (
                      <ThemedText key={eIdx} style={{ color: theme.textSecondary }}>
                        {formatMoney(exp)}р экс
                      </ThemedText>
                    ))}

                    {report.prepaymentTotal > 0 ? (
                      <ThemedText style={{ color: theme.textSecondary }}>
                        {formatMoney(report.prepaymentTotal)}р пред
                      </ThemedText>
                    ) : null}
                  </View>
                ))
              )}

              {reportData.radioGuideParticipants > 0 ? (
                <View style={styles.radioGuideRow}>
                  <Feather name="radio" size={16} color={theme.primary} />
                  <ThemedText style={{ color: theme.textSecondary, marginLeft: Spacing.xs }}>
                    Радиогиды: {reportData.radioGuideParticipants} шт. = {formatMoney(reportData.radioGuideTotal)}р
                  </ThemedText>
                </View>
              ) : null}
            </CollapsibleSection>

            {(reportData.additionalExpenses.length > 0 || reportData.additionalIncome.length > 0) ? (
              <CollapsibleSection 
                title={`Транзакции (${reportData.transactionCount})`} 
                icon="credit-card"
                defaultExpanded={false}
              >
                {reportData.additionalExpenses.length > 0 ? (
                  <View style={styles.transactionGroup}>
                    <ThemedText style={[styles.transactionGroupTitle, { color: theme.error }]}>
                      Расходы:
                    </ThemedText>
                    {reportData.additionalExpenses.map((exp, idx) => (
                      <ThemedText key={idx} style={{ color: theme.textSecondary }}>
                        {exp.description} - {formatMoney(exp.amount)}р
                      </ThemedText>
                    ))}
                  </View>
                ) : null}

                {reportData.additionalIncome.length > 0 ? (
                  <View style={styles.transactionGroup}>
                    <ThemedText style={[styles.transactionGroupTitle, { color: theme.success }]}>
                      Доходы:
                    </ThemedText>
                    {reportData.additionalIncome.map((inc, idx) => (
                      <ThemedText key={idx} style={{ color: theme.textSecondary }}>
                        {inc.description} - {formatMoney(inc.amount)}р
                      </ThemedText>
                    ))}
                  </View>
                ) : null}
              </CollapsibleSection>
            ) : null}

            <CollapsibleSection 
              title="Финансовая сводка" 
              icon="dollar-sign"
              defaultExpanded={true}
            >
              <View style={styles.summaryRow}>
                <ThemedText style={styles.summaryLabel}>Выручка:</ThemedText>
                <ThemedText style={[styles.summaryValue, { color: theme.success }]}>
                  {formatMoney(reportData.totalRevenue)}р
                </ThemedText>
              </View>
              <View style={styles.summaryRow}>
                <ThemedText style={styles.summaryLabel}>Расходы:</ThemedText>
                <ThemedText style={[styles.summaryValue, { color: theme.error }]}>
                  {formatMoney(reportData.totalExpenses)}р
                </ThemedText>
              </View>
              <View style={[styles.summaryRow, styles.profitRow]}>
                <ThemedText style={styles.profitLabel}>Прибыль:</ThemedText>
                <ThemedText style={[styles.profitValue, { color: theme.primary }]}>
                  {formatMoney(reportData.profit)}р
                </ThemedText>
              </View>
            </CollapsibleSection>

            <CollapsibleSection 
              title="Ручной ввод" 
              icon="edit"
              defaultExpanded={true}
            >
              <View style={styles.inputRow}>
                <ThemedText style={styles.inputLabel}>Положил на Р/с:</ThemedText>
                <TextInput
                  key={`bank-${selectedDateStr}`}
                  style={[styles.input, { backgroundColor: theme.backgroundTertiary, color: theme.text }]}
                  value={bankDeposit}
                  onChangeText={setBankDeposit}
                  placeholder="Сумма"
                  placeholderTextColor={theme.textSecondary}
                  keyboardType="numeric"
                />
              </View>

              <View style={styles.inputRow}>
                <ThemedText style={styles.inputLabel}>Положил в сейф:</ThemedText>
                <TextInput
                  key={`safe-${selectedDateStr}`}
                  style={[styles.input, { backgroundColor: theme.backgroundTertiary, color: theme.text }]}
                  value={safeDeposit}
                  onChangeText={setSafeDeposit}
                  placeholder="Сумма"
                  placeholderTextColor={theme.textSecondary}
                  keyboardType="numeric"
                />
              </View>

              <View style={styles.inputRow}>
                <ThemedText style={styles.inputLabel}>Денег:</ThemedText>
                <TextInput
                  key={`cash-${selectedDateStr}`}
                  style={[styles.input, { backgroundColor: theme.backgroundTertiary, color: theme.text }]}
                  value={cashAmount}
                  onChangeText={setCashAmount}
                  placeholder="Наличные"
                  placeholderTextColor={theme.textSecondary}
                  keyboardType="numeric"
                />
              </View>

              <View style={styles.inputRow}>
                <ThemedText style={styles.inputLabel}>Доход:</ThemedText>
                <TextInput
                  key={`income-${selectedDateStr}`}
                  style={[styles.input, { backgroundColor: theme.backgroundTertiary, color: theme.text }]}
                  value={incomeField}
                  onChangeText={setIncomeField}
                  placeholder="Можно +, -, ="
                  placeholderTextColor={theme.textSecondary}
                  keyboardType="default"
                />
              </View>
              <View style={styles.symbolButtons}>
                <Pressable
                  style={[styles.symbolButton, { backgroundColor: theme.backgroundTertiary }]}
                  onPress={() => setIncomeField((prev) => prev + "+")}
                >
                  <ThemedText style={styles.symbolButtonText}>+</ThemedText>
                </Pressable>
                <Pressable
                  style={[styles.symbolButton, { backgroundColor: theme.backgroundTertiary }]}
                  onPress={() => setIncomeField((prev) => prev + "-")}
                >
                  <ThemedText style={styles.symbolButtonText}>-</ThemedText>
                </Pressable>
                <Pressable
                  style={[styles.symbolButton, { backgroundColor: theme.backgroundTertiary }]}
                  onPress={() => setIncomeField((prev) => prev + "=")}
                >
                  <ThemedText style={styles.symbolButtonText}>=</ThemedText>
                </Pressable>
              </View>
            </CollapsibleSection>
          </>
        )}

        <View style={styles.actionButtons}>
          <Pressable
            style={[
              styles.saveButton, 
              { 
                backgroundColor: hasUnsavedChanges ? theme.success : theme.backgroundSecondary,
                opacity: saving ? 0.6 : 1 
              }
            ]}
            onPress={saveReportData}
            disabled={saving}
          >
            <Feather name="save" size={20} color={hasUnsavedChanges ? "#fff" : theme.textSecondary} />
            <ThemedText style={[styles.buttonText, { color: hasUnsavedChanges ? "#fff" : theme.textSecondary }]}>
              {saving ? "Сохранение..." : "Сохранить"}
            </ThemedText>
          </Pressable>

          <Pressable
            style={[styles.copyButton, { backgroundColor: theme.primary }]}
            onPress={copyToClipboard}
          >
            <Feather name="copy" size={20} color="#fff" />
            <ThemedText style={styles.buttonText}>Скопировать</ThemedText>
          </Pressable>
        </View>
      </View>
    </ScreenKeyboardAwareScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: Spacing.md,
  },
  headerRow: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    marginBottom: Spacing.lg,
    gap: Spacing.sm,
  },
  header: {
    fontSize: 22,
    fontWeight: "700",
  },
  statusBadge: {
    flexDirection: "row",
    alignItems: "center",
    paddingHorizontal: Spacing.sm,
    paddingVertical: 4,
    borderRadius: BorderRadius.sm,
    gap: 4,
  },
  statusText: {
    color: "#fff",
    fontSize: 11,
    fontWeight: "600",
  },
  dateButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.md,
    gap: Spacing.sm,
  },
  dateText: {
    fontSize: 18,
    fontWeight: "600",
  },
  collapsibleContainer: {
    borderRadius: BorderRadius.md,
    marginBottom: Spacing.md,
    overflow: "hidden",
  },
  collapsibleHeader: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    padding: Spacing.md,
  },
  collapsibleTitleRow: {
    flexDirection: "row",
    alignItems: "center",
    gap: Spacing.sm,
  },
  collapsibleTitle: {
    fontSize: 16,
    fontWeight: "600",
  },
  collapsibleContent: {
    paddingHorizontal: Spacing.md,
    paddingBottom: Spacing.md,
  },
  emptyText: {
    textAlign: "center",
    fontStyle: "italic",
  },
  tourTypeBlock: {
    marginBottom: Spacing.md,
  },
  tourTypeName: {
    fontSize: 15,
    fontWeight: "600",
    marginBottom: Spacing.xs,
  },
  radioGuideRow: {
    flexDirection: "row",
    alignItems: "center",
    marginTop: Spacing.sm,
    paddingTop: Spacing.sm,
    borderTopWidth: 1,
    borderTopColor: "rgba(255,255,255,0.1)",
  },
  transactionGroup: {
    marginBottom: Spacing.sm,
  },
  transactionGroupTitle: {
    fontSize: 14,
    fontWeight: "600",
    marginBottom: Spacing.xs,
  },
  summaryRow: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    paddingVertical: Spacing.xs,
  },
  summaryLabel: {
    fontSize: 14,
  },
  summaryValue: {
    fontSize: 16,
    fontWeight: "600",
  },
  profitRow: {
    marginTop: Spacing.sm,
    paddingTop: Spacing.sm,
    borderTopWidth: 1,
    borderTopColor: "rgba(255,255,255,0.1)",
  },
  profitLabel: {
    fontSize: 16,
    fontWeight: "600",
  },
  profitValue: {
    fontSize: 20,
    fontWeight: "700",
  },
  inputRow: {
    marginBottom: Spacing.sm,
  },
  inputLabel: {
    fontSize: 13,
    fontWeight: "500",
    marginBottom: Spacing.xs,
  },
  input: {
    padding: Spacing.sm,
    borderRadius: BorderRadius.sm,
    fontSize: 15,
  },
  symbolButtons: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  symbolButton: {
    paddingVertical: Spacing.xs,
    paddingHorizontal: Spacing.md,
    borderRadius: BorderRadius.sm,
  },
  symbolButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
  actionButtons: {
    flexDirection: "row",
    gap: Spacing.sm,
    marginTop: Spacing.md,
  },
  saveButton: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.xs,
  },
  copyButton: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.xs,
  },
  buttonText: {
    color: "#fff",
    fontSize: 14,
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
