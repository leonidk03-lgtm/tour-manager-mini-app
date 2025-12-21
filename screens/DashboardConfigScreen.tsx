import { useState, useMemo } from "react";
import { View, StyleSheet, Pressable, Switch, Alert } from "react-native";
import { Icon } from "@/components/Icon";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { ScreenScrollView } from "@/components/ScreenScrollView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";
import { useAuth } from "@/contexts/AuthContext";
import { hapticFeedback } from "@/utils/haptics";
import { 
  DashboardWidgetKey, 
  DASHBOARD_WIDGET_DEFINITIONS, 
  DEFAULT_DASHBOARD_CONFIG,
  DashboardConfig 
} from "@/lib/supabase";

export default function DashboardConfigScreen() {
  const { theme } = useTheme();
  const { profile, updateDashboardConfig, hasPermission, isAdmin } = useAuth();

  const currentConfig = useMemo(() => {
    return profile?.dashboard_config || DEFAULT_DASHBOARD_CONFIG;
  }, [profile?.dashboard_config]);

  const [widgets, setWidgets] = useState(() => {
    const configWidgets = currentConfig.widgets;
    return DASHBOARD_WIDGET_DEFINITIONS.map((def, index) => {
      const existing = configWidgets.find(w => w.key === def.key);
      return {
        key: def.key,
        label: def.label,
        description: def.description,
        icon: def.icon,
        visible: existing?.visible ?? true,
        order: existing?.order ?? index,
      };
    }).sort((a, b) => a.order - b.order);
  });

  const [saving, setSaving] = useState(false);
  const [hasChanges, setHasChanges] = useState(false);

  const hasAnyRentalAccess = useMemo(() => {
    return isAdmin || 
      hasPermission('rental') || 
      hasPermission('rental_clients') || 
      hasPermission('rental_orders') || 
      hasPermission('rental_payments') || 
      hasPermission('rental_commissions') || 
      hasPermission('rental_calendar');
  }, [isAdmin, hasPermission]);

  const toggleWidget = (key: DashboardWidgetKey) => {
    hapticFeedback.light();
    setWidgets(prev => prev.map(w => 
      w.key === key ? { ...w, visible: !w.visible } : w
    ));
    setHasChanges(true);
  };

  const moveWidget = (key: DashboardWidgetKey, direction: 'up' | 'down') => {
    hapticFeedback.light();
    setWidgets(prev => {
      const index = prev.findIndex(w => w.key === key);
      if (index === -1) return prev;
      
      const newIndex = direction === 'up' ? index - 1 : index + 1;
      if (newIndex < 0 || newIndex >= prev.length) return prev;
      
      const newWidgets = [...prev];
      [newWidgets[index], newWidgets[newIndex]] = [newWidgets[newIndex], newWidgets[index]];
      return newWidgets.map((w, i) => ({ ...w, order: i }));
    });
    setHasChanges(true);
  };

  const handleSave = async () => {
    setSaving(true);
    try {
      const config: DashboardConfig = {
        widgets: widgets.map((w, index) => ({
          key: w.key,
          visible: w.visible,
          order: index,
        })),
      };
      
      const { error } = await updateDashboardConfig(config);
      if (error) {
        Alert.alert("Ошибка", error);
      } else {
        Alert.alert("Сохранено", "Настройки дашборда обновлены");
        setHasChanges(false);
      }
    } catch (err) {
      Alert.alert("Ошибка", "Не удалось сохранить настройки");
    } finally {
      setSaving(false);
    }
  };

  const handleReset = () => {
    Alert.alert(
      "Сбросить настройки?",
      "Вернуть виджеты к настройкам по умолчанию?",
      [
        { text: "Отмена", style: "cancel" },
        {
          text: "Сбросить",
          style: "destructive",
          onPress: () => {
            setWidgets(
              DASHBOARD_WIDGET_DEFINITIONS.map((def, index) => ({
                key: def.key,
                label: def.label,
                description: def.description,
                icon: def.icon,
                visible: true,
                order: index,
              }))
            );
            setHasChanges(true);
          },
        },
      ]
    );
  };

  const isWidgetAvailable = (key: DashboardWidgetKey) => {
    if (key === 'rental_section') {
      return hasAnyRentalAccess;
    }
    return true;
  };

  return (
    <ScreenScrollView>
      <View style={styles.container}>
        <ThemedText style={[styles.headerText, { color: theme.textSecondary }]}>
          Включите или выключите виджеты и измените их порядок
        </ThemedText>

        <ThemedView style={[styles.widgetsList, { backgroundColor: theme.backgroundSecondary }]}>
          {widgets.map((widget, index) => {
            const available = isWidgetAvailable(widget.key);
            
            return (
              <View key={widget.key}>
                <View style={[styles.widgetItem, !available && styles.widgetUnavailable]}>
                  <View style={styles.widgetOrderControls}>
                    <Pressable
                      onPress={() => moveWidget(widget.key, 'up')}
                      disabled={index === 0}
                      style={({ pressed }) => [
                        styles.orderButton,
                        { opacity: pressed || index === 0 ? 0.3 : 1 }
                      ]}
                    >
                      <Icon name="chevron-up" size={16} color={theme.textSecondary} />
                    </Pressable>
                    <Pressable
                      onPress={() => moveWidget(widget.key, 'down')}
                      disabled={index === widgets.length - 1}
                      style={({ pressed }) => [
                        styles.orderButton,
                        { opacity: pressed || index === widgets.length - 1 ? 0.3 : 1 }
                      ]}
                    >
                      <Icon name="chevron-down" size={16} color={theme.textSecondary} />
                    </Pressable>
                  </View>

                  <View style={[styles.widgetIcon, { backgroundColor: theme.primary + '20' }]}>
                    <Icon name={widget.icon} size={20} color={available ? theme.primary : theme.textSecondary} />
                  </View>

                  <View style={styles.widgetInfo}>
                    <ThemedText style={[styles.widgetLabel, !available && { color: theme.textSecondary }]}>
                      {widget.label}
                    </ThemedText>
                    <ThemedText style={[styles.widgetDescription, { color: theme.textSecondary }]}>
                      {widget.description}
                      {!available ? " (нет доступа)" : ""}
                    </ThemedText>
                  </View>

                  <Switch
                    value={widget.visible && available}
                    onValueChange={() => toggleWidget(widget.key)}
                    disabled={!available}
                    trackColor={{ false: theme.border, true: theme.primary }}
                    thumbColor={widget.visible && available ? "#fff" : theme.textSecondary}
                  />
                </View>
                {index < widgets.length - 1 ? (
                  <View style={[styles.divider, { backgroundColor: theme.border }]} />
                ) : null}
              </View>
            );
          })}
        </ThemedView>

        <View style={styles.buttonsContainer}>
          <Pressable
            onPress={handleSave}
            disabled={!hasChanges || saving}
            style={({ pressed }) => [
              styles.saveButton,
              { 
                backgroundColor: hasChanges ? theme.primary : theme.border,
                opacity: pressed ? 0.7 : 1 
              }
            ]}
          >
            <Icon name="check" size={18} color={hasChanges ? "#fff" : theme.textSecondary} />
            <ThemedText style={[styles.saveButtonText, { color: hasChanges ? "#fff" : theme.textSecondary }]}>
              {saving ? "Сохранение..." : "Сохранить"}
            </ThemedText>
          </Pressable>

          <Pressable
            onPress={handleReset}
            style={({ pressed }) => [
              styles.resetButton,
              { backgroundColor: theme.backgroundSecondary, opacity: pressed ? 0.7 : 1 }
            ]}
          >
            <Icon name="refresh-cw" size={18} color={theme.textSecondary} />
            <ThemedText style={[styles.resetButtonText, { color: theme.textSecondary }]}>
              Сбросить
            </ThemedText>
          </Pressable>
        </View>
      </View>
    </ScreenScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    padding: Spacing.md,
  },
  headerText: {
    fontSize: 14,
    marginBottom: Spacing.md,
    textAlign: "center",
  },
  widgetsList: {
    borderRadius: BorderRadius.md,
    overflow: "hidden",
  },
  widgetItem: {
    flexDirection: "row",
    alignItems: "center",
    padding: Spacing.md,
    gap: Spacing.md,
  },
  widgetUnavailable: {
    opacity: 0.5,
  },
  widgetOrderControls: {
    flexDirection: "column",
    gap: 2,
  },
  orderButton: {
    padding: 4,
  },
  widgetIcon: {
    width: 40,
    height: 40,
    borderRadius: 10,
    alignItems: "center",
    justifyContent: "center",
  },
  widgetInfo: {
    flex: 1,
  },
  widgetLabel: {
    fontSize: 16,
    fontWeight: "500",
  },
  widgetDescription: {
    fontSize: 13,
    marginTop: 2,
  },
  divider: {
    height: 1,
    marginLeft: Spacing.md + 32,
  },
  buttonsContainer: {
    flexDirection: "row",
    gap: Spacing.md,
    marginTop: Spacing.lg,
  },
  saveButton: {
    flex: 1,
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
  },
  saveButtonText: {
    fontSize: 16,
    fontWeight: "600",
  },
  resetButton: {
    flexDirection: "row",
    alignItems: "center",
    justifyContent: "center",
    padding: Spacing.md,
    borderRadius: BorderRadius.md,
    gap: Spacing.sm,
    paddingHorizontal: Spacing.lg,
  },
  resetButtonText: {
    fontSize: 16,
  },
});
