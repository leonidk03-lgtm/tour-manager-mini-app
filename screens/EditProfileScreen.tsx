import { useState } from "react";
import { View, StyleSheet, Pressable, TextInput, Alert } from "react-native";
import { Feather } from "@expo/vector-icons";
import { useNavigation } from "@react-navigation/native";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenKeyboardAwareScrollView } from "@/components/ScreenKeyboardAwareScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";

export default function EditProfileScreen() {
  const { theme } = useTheme();
  const navigation = useNavigation();
  const { profile, updateOwnProfile } = useAuth();

  const [displayName, setDisplayName] = useState(profile?.display_name || "");
  const [newPassword, setNewPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [isSaving, setIsSaving] = useState(false);
  const [showPassword, setShowPassword] = useState(false);

  const handleSave = async () => {
    if (newPassword && newPassword !== confirmPassword) {
      Alert.alert("Ошибка", "Пароли не совпадают");
      return;
    }

    if (newPassword && newPassword.length < 6) {
      Alert.alert("Ошибка", "Пароль должен содержать минимум 6 символов");
      return;
    }

    if (!displayName.trim()) {
      Alert.alert("Ошибка", "Имя не может быть пустым");
      return;
    }

    setIsSaving(true);

    const updateData: { displayName?: string; password?: string } = {};
    
    if (displayName.trim() !== profile?.display_name) {
      updateData.displayName = displayName.trim();
    }
    
    if (newPassword) {
      updateData.password = newPassword;
    }

    if (Object.keys(updateData).length === 0) {
      Alert.alert("Информация", "Нет изменений для сохранения");
      setIsSaving(false);
      return;
    }

    const { error } = await updateOwnProfile(updateData);
    setIsSaving(false);

    if (error) {
      Alert.alert("Ошибка", error);
    } else {
      Alert.alert("Успешно", "Профиль обновлен", [
        { text: "OK", onPress: () => navigation.goBack() }
      ]);
    }
  };

  return (
    <ScreenKeyboardAwareScrollView>
      <View style={styles.container}>
        <ThemedView
          style={[
            styles.section,
            { backgroundColor: theme.backgroundSecondary, borderRadius: BorderRadius.md },
          ]}
        >
          <ThemedText style={styles.sectionTitle}>Личные данные</ThemedText>
          
          <View style={styles.field}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Имя
            </ThemedText>
            <TextInput
              style={[
                styles.input,
                { backgroundColor: theme.backgroundTertiary, color: theme.text, borderColor: theme.border },
              ]}
              value={displayName}
              onChangeText={setDisplayName}
              placeholder="Введите имя"
              placeholderTextColor={theme.textSecondary}
            />
          </View>

          <View style={styles.field}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Email
            </ThemedText>
            <View
              style={[
                styles.readOnlyField,
                { backgroundColor: theme.backgroundTertiary, borderColor: theme.border },
              ]}
            >
              <ThemedText style={{ color: theme.textSecondary }}>
                {profile?.email || ""}
              </ThemedText>
              <Feather name="lock" size={16} color={theme.textSecondary} />
            </View>
            <ThemedText style={[styles.hint, { color: theme.textSecondary }]}>
              Email нельзя изменить
            </ThemedText>
          </View>
        </ThemedView>

        <ThemedView
          style={[
            styles.section,
            { backgroundColor: theme.backgroundSecondary, borderRadius: BorderRadius.md },
          ]}
        >
          <ThemedText style={styles.sectionTitle}>Изменить пароль</ThemedText>
          
          <View style={styles.field}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Новый пароль
            </ThemedText>
            <View style={styles.passwordContainer}>
              <TextInput
                style={[
                  styles.input,
                  styles.passwordInput,
                  { backgroundColor: theme.backgroundTertiary, color: theme.text, borderColor: theme.border },
                ]}
                value={newPassword}
                onChangeText={setNewPassword}
                placeholder="Введите новый пароль"
                placeholderTextColor={theme.textSecondary}
                secureTextEntry={!showPassword}
              />
              <Pressable
                style={styles.eyeButton}
                onPress={() => setShowPassword(!showPassword)}
              >
                <Feather
                  name={showPassword ? "eye-off" : "eye"}
                  size={20}
                  color={theme.textSecondary}
                />
              </Pressable>
            </View>
          </View>

          <View style={styles.field}>
            <ThemedText style={[styles.label, { color: theme.textSecondary }]}>
              Подтвердите пароль
            </ThemedText>
            <TextInput
              style={[
                styles.input,
                { backgroundColor: theme.backgroundTertiary, color: theme.text, borderColor: theme.border },
              ]}
              value={confirmPassword}
              onChangeText={setConfirmPassword}
              placeholder="Повторите пароль"
              placeholderTextColor={theme.textSecondary}
              secureTextEntry={!showPassword}
            />
          </View>

          <ThemedText style={[styles.hint, { color: theme.textSecondary }]}>
            Оставьте поля пароля пустыми, если не хотите его менять
          </ThemedText>
        </ThemedView>

        <Pressable
          style={[
            styles.saveButton,
            { backgroundColor: theme.primary, opacity: isSaving ? 0.7 : 1 },
          ]}
          onPress={handleSave}
          disabled={isSaving}
        >
          <Feather name="check" size={20} color={theme.buttonText} />
          <ThemedText style={[styles.saveButtonText, { color: theme.buttonText }]}>
            {isSaving ? "Сохранение..." : "Сохранить изменения"}
          </ThemedText>
        </Pressable>
      </View>
    </ScreenKeyboardAwareScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    gap: Spacing.xl,
  },
  section: {
    padding: Spacing.lg,
    gap: Spacing.lg,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: "600",
  },
  field: {
    gap: Spacing.xs,
  },
  label: {
    fontSize: 14,
    fontWeight: "500",
  },
  input: {
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
    fontSize: 16,
  },
  readOnlyField: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "space-between",
    paddingHorizontal: Spacing.md,
    paddingVertical: Spacing.sm,
    borderRadius: BorderRadius.sm,
    borderWidth: 1,
  },
  hint: {
    fontSize: 12,
    marginTop: Spacing.xs,
  },
  passwordContainer: {
    position: "relative",
  },
  passwordInput: {
    paddingRight: 50,
  },
  eyeButton: {
    position: "absolute",
    right: Spacing.md,
    top: 0,
    bottom: 0,
    justifyContent: "center",
  },
  saveButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    gap: Spacing.sm,
    paddingVertical: Spacing.lg,
    borderRadius: BorderRadius.sm,
  },
  saveButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
});
