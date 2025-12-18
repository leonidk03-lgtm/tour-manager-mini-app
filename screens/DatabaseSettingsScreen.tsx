import { useState, useEffect } from "react";
import { View, StyleSheet, Pressable, Alert, TextInput } from "react-native";
import { Icon } from "@/components/Icon";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenKeyboardAwareScrollView } from "@/components/ScreenKeyboardAwareScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { getSupabaseConfig, updateSupabaseConfig, resetSupabaseConfig } from "@/lib/supabase";
import { useAuth } from "@/contexts/AuthContext";
import { reloadAppAsync } from "expo";
import { DISPATCH_URL_KEY } from "./DispatchingScreen";

const DEFAULT_DISPATCH_URL = "http://turburo-kazan.ru/managers/zapis-na-ekskursiyu.php?arrFilter_ff%5BNAME%5D=&arrFilter_DATE_ACTIVE_FROM_1=&arrFilter_DATE_ACTIVE_FROM_2=&arrFilter_pf%5BTYPE%5D=&arrFilter_pf%5BGOSTINICI%5D=&arrFilter_CREATED_BY=&sort=date_ex&USER_REMEMBER=Y&set_filter=Показать&set_filter=Y";

export default function DatabaseSettingsScreen() {
  const { theme } = useTheme();
  const { signOut } = useAuth();
  const [url, setUrl] = useState("");
  const [anonKey, setAnonKey] = useState("");
  const [dispatchUrl, setDispatchUrl] = useState("");
  const [isLoading, setIsLoading] = useState(true);
  const [isSaving, setIsSaving] = useState(false);

  useEffect(() => {
    loadConfig();
  }, []);

  const loadConfig = async () => {
    try {
      const config = await getSupabaseConfig();
      setUrl(config.url);
      setAnonKey(config.anonKey);
      
      const savedDispatchUrl = await AsyncStorage.getItem(DISPATCH_URL_KEY);
      setDispatchUrl(savedDispatchUrl || DEFAULT_DISPATCH_URL);
    } catch (error) {
      console.error("Error loading config:", error);
    } finally {
      setIsLoading(false);
    }
  };

  const handleSave = async () => {
    if (!url.trim() || !anonKey.trim()) {
      Alert.alert("Ошибка", "Заполните все поля");
      return;
    }

    Alert.alert(
      "Сменить базу данных?",
      "Приложение будет перезапущено для применения изменений. Вам потребуется войти заново.",
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Сохранить",
          onPress: async () => {
            setIsSaving(true);
            try {
              await signOut();
              await updateSupabaseConfig(url.trim(), anonKey.trim());
              await reloadAppAsync();
            } catch (error) {
              console.error("Error saving config:", error);
              Alert.alert("Ошибка", "Не удалось сохранить настройки");
              setIsSaving(false);
            }
          },
        },
      ]
    );
  };

  const handleReset = () => {
    Alert.alert(
      "Сбросить настройки?",
      "Будут восстановлены настройки по умолчанию. Приложение будет перезапущено.",
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Сбросить",
          style: "destructive",
          onPress: async () => {
            try {
              await signOut();
              await resetSupabaseConfig();
              await reloadAppAsync();
            } catch (error) {
              console.error("Error resetting config:", error);
              Alert.alert("Ошибка", "Не удалось сбросить настройки");
            }
          },
        },
      ]
    );
  };

  const handleSaveDispatchUrl = async () => {
    if (!dispatchUrl.trim()) {
      Alert.alert("Ошибка", "Введите URL");
      return;
    }

    try {
      await AsyncStorage.setItem(DISPATCH_URL_KEY, dispatchUrl.trim());
      Alert.alert("Успешно", "URL сохранен. Перезапустите вкладку Отправление для применения.");
    } catch (error) {
      console.error("Error saving dispatch URL:", error);
      Alert.alert("Ошибка", "Не удалось сохранить URL");
    }
  };

  const handleResetDispatchUrl = async () => {
    try {
      await AsyncStorage.removeItem(DISPATCH_URL_KEY);
      setDispatchUrl(DEFAULT_DISPATCH_URL);
      Alert.alert("Успешно", "URL сброшен на значение по умолчанию");
    } catch (error) {
      console.error("Error resetting dispatch URL:", error);
      Alert.alert("Ошибка", "Не удалось сбросить URL");
    }
  };

  if (isLoading) {
    return (
      <View style={[styles.loadingContainer, { backgroundColor: theme.backgroundRoot }]}>
        <ThemedText>Загрузка...</ThemedText>
      </View>
    );
  }

  return (
    <ScreenKeyboardAwareScrollView>
      <View style={styles.container}>
        <ThemedView
          style={[
            styles.infoCard,
            {
              borderColor: theme.border,
              borderRadius: BorderRadius.sm,
            },
          ]}
        >
          <View style={styles.infoRow}>
            <Icon name="info" size={20} color={theme.primary} />
            <ThemedText style={[styles.infoText, { color: theme.textSecondary }]}>
              Здесь вы можете изменить подключение к базе данных Supabase. После сохранения приложение перезапустится.
            </ThemedText>
          </View>
        </ThemedView>

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>Подключение к Supabase</ThemedText>
          
          <View style={styles.inputGroup}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>URL проекта</ThemedText>
            <TextInput
              style={[
                styles.input,
                {
                  backgroundColor: theme.backgroundSecondary,
                  borderColor: theme.border,
                  color: theme.text,
                },
              ]}
              value={url}
              onChangeText={setUrl}
              placeholder="https://xxxxx.supabase.co"
              placeholderTextColor={theme.textSecondary}
              autoCapitalize="none"
              autoCorrect={false}
              keyboardType="url"
            />
          </View>

          <View style={styles.inputGroup}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>Anon Key</ThemedText>
            <TextInput
              style={[
                styles.input,
                styles.multilineInput,
                {
                  backgroundColor: theme.backgroundSecondary,
                  borderColor: theme.border,
                  color: theme.text,
                },
              ]}
              value={anonKey}
              onChangeText={setAnonKey}
              placeholder="eyJhbGciOiJIUzI1NiIsInR5cCI6..."
              placeholderTextColor={theme.textSecondary}
              autoCapitalize="none"
              autoCorrect={false}
              multiline
              numberOfLines={3}
            />
          </View>
        </View>

        <View style={styles.actions}>
          <Pressable
            style={[
              styles.button,
              styles.saveButton,
              { backgroundColor: theme.primary },
              isSaving ? { opacity: 0.5 } : null,
            ]}
            onPress={handleSave}
            disabled={isSaving}
          >
            <Icon name="check" size={18} color={theme.buttonText} />
            <ThemedText style={[styles.buttonText, { color: theme.buttonText }]}>
              {isSaving ? "Сохранение..." : "Сохранить Supabase"}
            </ThemedText>
          </Pressable>

          <Pressable
            style={[
              styles.button,
              styles.resetButton,
              { borderColor: theme.error },
            ]}
            onPress={handleReset}
          >
            <Icon name="refresh-cw" size={18} color={theme.error} />
            <ThemedText style={[styles.buttonText, { color: theme.error }]}>
              Сбросить Supabase
            </ThemedText>
          </Pressable>
        </View>

        <View style={[styles.divider, { backgroundColor: theme.border }]} />

        <View style={styles.section}>
          <ThemedText style={styles.sectionTitle}>Вкладка Отправление</ThemedText>
          
          <View style={styles.inputGroup}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>URL страницы</ThemedText>
            <TextInput
              style={[
                styles.input,
                styles.multilineInput,
                {
                  backgroundColor: theme.backgroundSecondary,
                  borderColor: theme.border,
                  color: theme.text,
                },
              ]}
              value={dispatchUrl}
              onChangeText={setDispatchUrl}
              placeholder="https://example.com/page"
              placeholderTextColor={theme.textSecondary}
              autoCapitalize="none"
              autoCorrect={false}
              multiline
              numberOfLines={3}
            />
          </View>
        </View>

        <View style={styles.actions}>
          <Pressable
            style={[
              styles.button,
              styles.saveButton,
              { backgroundColor: theme.primary },
            ]}
            onPress={handleSaveDispatchUrl}
          >
            <Icon name="check" size={18} color={theme.buttonText} />
            <ThemedText style={[styles.buttonText, { color: theme.buttonText }]}>
              Сохранить URL
            </ThemedText>
          </Pressable>

          <Pressable
            style={[
              styles.button,
              styles.resetButton,
              { borderColor: theme.textSecondary },
            ]}
            onPress={handleResetDispatchUrl}
          >
            <Icon name="refresh-cw" size={18} color={theme.textSecondary} />
            <ThemedText style={[styles.buttonText, { color: theme.textSecondary }]}>
              Сбросить URL
            </ThemedText>
          </Pressable>
        </View>
      </View>
    </ScreenKeyboardAwareScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: Spacing.lg,
    gap: Spacing.lg,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  infoCard: {
    padding: Spacing.md,
    borderWidth: 1,
  },
  infoRow: {
    flexDirection: "row",
    alignItems: "flex-start",
    gap: Spacing.sm,
  },
  infoText: {
    flex: 1,
    fontSize: 14,
    lineHeight: 20,
  },
  section: {
    gap: Spacing.md,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: "600",
    marginBottom: Spacing.xs,
  },
  inputGroup: {
    gap: Spacing.xs,
  },
  label: {
    fontSize: 14,
    fontWeight: "500",
  },
  input: {
    borderWidth: 1,
    borderRadius: BorderRadius.sm,
    padding: Spacing.md,
    fontSize: 14,
  },
  multilineInput: {
    minHeight: 80,
    textAlignVertical: "top",
  },
  actions: {
    gap: Spacing.md,
    marginTop: Spacing.lg,
  },
  divider: {
    height: 1,
    marginVertical: Spacing.md,
  },
  button: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.sm,
    gap: Spacing.sm,
  },
  saveButton: {},
  resetButton: {
    borderWidth: 1,
    backgroundColor: "transparent",
  },
  buttonText: {
    fontSize: 16,
    fontWeight: "600",
  },
});
