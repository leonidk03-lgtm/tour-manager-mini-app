import { useState, useEffect } from "react";
import { View, StyleSheet, TextInput, Pressable, Alert, ActivityIndicator } from "react-native";
import { ScreenKeyboardAwareScrollView } from "@/components/ScreenKeyboardAwareScrollView";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useCompanySettings, CompanySettings } from "@/contexts/CompanySettingsContext";
import { hapticFeedback } from "@/utils/haptics";

function SectionTitle({ title }: { title: string }) {
  const { theme } = useTheme();
  return (
    <ThemedText style={[styles.sectionTitle, { color: theme.textSecondary }]}>
      {title}
    </ThemedText>
  );
}

function FieldRow({ label, value, onChangeText, placeholder, keyboardType = "default", multiline = false }: {
  label: string;
  value: string;
  onChangeText: (text: string) => void;
  placeholder?: string;
  keyboardType?: "default" | "numeric" | "email-address" | "phone-pad";
  multiline?: boolean;
}) {
  const { theme } = useTheme();
  return (
    <View style={styles.fieldRow}>
      <ThemedText style={[styles.fieldLabel, { color: theme.textSecondary }]}>{label}</ThemedText>
      <TextInput
        style={[
          styles.fieldInput,
          multiline && styles.fieldInputMultiline,
          { backgroundColor: theme.backgroundRoot, color: theme.text, borderColor: theme.border }
        ]}
        value={value}
        onChangeText={onChangeText}
        placeholder={placeholder}
        placeholderTextColor={theme.textSecondary}
        keyboardType={keyboardType}
        multiline={multiline}
        numberOfLines={multiline ? 3 : 1}
      />
    </View>
  );
}

export default function CompanySettingsScreen() {
  const { theme } = useTheme();
  const { settings, isLoading, updateSettings } = useCompanySettings();
  const [saving, setSaving] = useState(false);

  const [formData, setFormData] = useState<Partial<CompanySettings>>({
    companyName: "",
    inn: "",
    kpp: "",
    ogrn: "",
    legalAddress: "",
    actualAddress: "",
    bankName: "",
    bik: "",
    correspondentAccount: "",
    settlementAccount: "",
    directorName: "",
    directorPosition: "Индивидуальный предприниматель",
    phone: "",
    email: "",
    documentPrefix: "Р",
  });

  useEffect(() => {
    if (settings) {
      setFormData({
        companyName: settings.companyName,
        inn: settings.inn,
        kpp: settings.kpp,
        ogrn: settings.ogrn,
        legalAddress: settings.legalAddress,
        actualAddress: settings.actualAddress,
        bankName: settings.bankName,
        bik: settings.bik,
        correspondentAccount: settings.correspondentAccount,
        settlementAccount: settings.settlementAccount,
        directorName: settings.directorName,
        directorPosition: settings.directorPosition,
        phone: settings.phone,
        email: settings.email,
        documentPrefix: settings.documentPrefix,
      });
    }
  }, [settings]);

  const updateField = (key: keyof CompanySettings, value: string) => {
    setFormData(prev => ({ ...prev, [key]: value }));
  };

  const handleSave = async () => {
    if (!formData.companyName?.trim()) {
      Alert.alert("Ошибка", "Укажите название компании");
      return;
    }
    if (!formData.inn?.trim()) {
      Alert.alert("Ошибка", "Укажите ИНН");
      return;
    }

    setSaving(true);
    hapticFeedback.light();
    try {
      const result = await updateSettings(formData);
      if (result.error) {
        Alert.alert("Ошибка", result.error);
      } else {
        Alert.alert("Сохранено", "Реквизиты компании обновлены");
      }
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось сохранить");
    } finally {
      setSaving(false);
    }
  };

  if (isLoading) {
    return (
      <View style={[styles.loadingContainer, { backgroundColor: theme.backgroundRoot }]}>
        <ActivityIndicator size="large" color={theme.primary} />
      </View>
    );
  }

  return (
    <ScreenKeyboardAwareScrollView>
      <View style={styles.container}>
        <SectionTitle title="Основные данные" />
        <ThemedView style={[styles.section, { borderColor: theme.border }]}>
          <FieldRow
            label="Название компании"
            value={formData.companyName || ""}
            onChangeText={(v) => updateField("companyName", v)}
            placeholder="ИП Иванов И.И. или ООО «Компания»"
          />
          <FieldRow
            label="ИНН"
            value={formData.inn || ""}
            onChangeText={(v) => updateField("inn", v)}
            placeholder="1234567890"
            keyboardType="numeric"
          />
          <FieldRow
            label="КПП (для ООО)"
            value={formData.kpp || ""}
            onChangeText={(v) => updateField("kpp", v)}
            placeholder="123456789"
            keyboardType="numeric"
          />
          <FieldRow
            label="ОГРН/ОГРНИП"
            value={formData.ogrn || ""}
            onChangeText={(v) => updateField("ogrn", v)}
            placeholder="1234567890123"
            keyboardType="numeric"
          />
        </ThemedView>

        <SectionTitle title="Адреса" />
        <ThemedView style={[styles.section, { borderColor: theme.border }]}>
          <FieldRow
            label="Юридический адрес"
            value={formData.legalAddress || ""}
            onChangeText={(v) => updateField("legalAddress", v)}
            placeholder="г. Москва, ул. Примерная, д. 1"
            multiline
          />
          <FieldRow
            label="Фактический адрес"
            value={formData.actualAddress || ""}
            onChangeText={(v) => updateField("actualAddress", v)}
            placeholder="г. Москва, ул. Примерная, д. 1"
            multiline
          />
        </ThemedView>

        <SectionTitle title="Банковские реквизиты" />
        <ThemedView style={[styles.section, { borderColor: theme.border }]}>
          <FieldRow
            label="Наименование банка"
            value={formData.bankName || ""}
            onChangeText={(v) => updateField("bankName", v)}
            placeholder="АО «Тинькофф Банк»"
          />
          <FieldRow
            label="БИК"
            value={formData.bik || ""}
            onChangeText={(v) => updateField("bik", v)}
            placeholder="044525974"
            keyboardType="numeric"
          />
          <FieldRow
            label="Корр. счёт"
            value={formData.correspondentAccount || ""}
            onChangeText={(v) => updateField("correspondentAccount", v)}
            placeholder="30101810145250000974"
            keyboardType="numeric"
          />
          <FieldRow
            label="Расчётный счёт"
            value={formData.settlementAccount || ""}
            onChangeText={(v) => updateField("settlementAccount", v)}
            placeholder="40802810000000000000"
            keyboardType="numeric"
          />
        </ThemedView>

        <SectionTitle title="Руководитель" />
        <ThemedView style={[styles.section, { borderColor: theme.border }]}>
          <FieldRow
            label="ФИО руководителя"
            value={formData.directorName || ""}
            onChangeText={(v) => updateField("directorName", v)}
            placeholder="Иванов Иван Иванович"
          />
          <FieldRow
            label="Должность"
            value={formData.directorPosition || ""}
            onChangeText={(v) => updateField("directorPosition", v)}
            placeholder="Индивидуальный предприниматель"
          />
        </ThemedView>

        <SectionTitle title="Контакты" />
        <ThemedView style={[styles.section, { borderColor: theme.border }]}>
          <FieldRow
            label="Телефон"
            value={formData.phone || ""}
            onChangeText={(v) => updateField("phone", v)}
            placeholder="+7 (999) 123-45-67"
            keyboardType="phone-pad"
          />
          <FieldRow
            label="Email"
            value={formData.email || ""}
            onChangeText={(v) => updateField("email", v)}
            placeholder="info@company.ru"
            keyboardType="email-address"
          />
        </ThemedView>

        <SectionTitle title="Документы" />
        <ThemedView style={[styles.section, { borderColor: theme.border }]}>
          <FieldRow
            label="Префикс номера"
            value={formData.documentPrefix || ""}
            onChangeText={(v) => updateField("documentPrefix", v)}
            placeholder="Р"
          />
          <View style={styles.numbersInfo}>
            <ThemedText style={[styles.numbersLabel, { color: theme.textSecondary }]}>
              Следующие номера документов:
            </ThemedText>
            <ThemedText style={[styles.numbersValue, { color: theme.text }]}>
              Счёт: {settings?.nextInvoiceNumber || 1} | Акт: {settings?.nextActNumber || 1} | Договор: {settings?.nextContractNumber || 1} | Накладная: {settings?.nextWaybillNumber || 1}
            </ThemedText>
          </View>
        </ThemedView>

        <Pressable
          onPress={handleSave}
          disabled={saving}
          style={({ pressed }) => [
            styles.saveButton,
            { backgroundColor: theme.primary, opacity: pressed || saving ? 0.7 : 1 }
          ]}
        >
          <ThemedText style={[styles.saveButtonText, { color: theme.buttonText }]}>
            {saving ? "Сохранение..." : "Сохранить"}
          </ThemedText>
        </Pressable>
      </View>
    </ScreenKeyboardAwareScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing.md,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  sectionTitle: {
    fontSize: 13,
    fontWeight: "600",
    textTransform: "uppercase",
    marginTop: Spacing.sm,
  },
  section: {
    borderRadius: BorderRadius.md,
    borderWidth: 1,
    padding: Spacing.md,
    gap: Spacing.md,
  },
  fieldRow: {
    gap: Spacing.xs,
  },
  fieldLabel: {
    fontSize: 13,
    fontWeight: "500",
  },
  fieldInput: {
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    padding: Spacing.sm,
    fontSize: 15,
  },
  fieldInputMultiline: {
    minHeight: 70,
    textAlignVertical: "top",
  },
  numbersInfo: {
    gap: Spacing.xs,
    paddingTop: Spacing.sm,
    borderTopWidth: StyleSheet.hairlineWidth,
    borderTopColor: "#ccc",
  },
  numbersLabel: {
    fontSize: 12,
  },
  numbersValue: {
    fontSize: 13,
    fontWeight: "500",
  },
  saveButton: {
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    alignItems: "center",
    marginTop: Spacing.md,
    marginBottom: Spacing.xl,
  },
  saveButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
});
