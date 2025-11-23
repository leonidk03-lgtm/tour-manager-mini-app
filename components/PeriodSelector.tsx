import { View, StyleSheet, Pressable } from "react-native";
import { ThemedText } from "@/components/ThemedText";
import { ThemedView } from "@/components/ThemedView";
import { Spacing, BorderRadius } from "@/constants/theme";
import { useTheme } from "@/hooks/useTheme";

interface PeriodSelectorProps {
  selectedPeriod: "day" | "week" | "month";
  onPeriodChange: (period: "day" | "week" | "month") => void;
}

export function PeriodSelector({ selectedPeriod, onPeriodChange }: PeriodSelectorProps) {
  const { theme } = useTheme();

  const periods: { value: "day" | "week" | "month"; label: string }[] = [
    { value: "day", label: "День" },
    { value: "week", label: "Неделя" },
    { value: "month", label: "Месяц" },
  ];

  return (
    <View style={styles.container}>
      {periods.map((period) => {
        const isSelected = selectedPeriod === period.value;
        return (
          <Pressable
            key={period.value}
            onPress={() => onPeriodChange(period.value)}
            style={({ pressed }) => ({ opacity: pressed ? 0.7 : 1, flex: 1 })}
          >
            <ThemedView
              style={[
                styles.button,
                {
                  backgroundColor: isSelected ? theme.primary : theme.backgroundDefault,
                  borderColor: theme.border,
                  borderRadius: BorderRadius.xs,
                },
              ]}
            >
              <ThemedText
                style={[
                  styles.buttonText,
                  {
                    color: isSelected ? theme.buttonText : theme.text,
                  },
                ]}
              >
                {period.label}
              </ThemedText>
            </ThemedView>
          </Pressable>
        );
      })}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    gap: Spacing.sm,
  },
  button: {
    paddingVertical: Spacing.md,
    paddingHorizontal: Spacing.lg,
    borderWidth: 1,
    alignItems: "center",
  },
  buttonText: {
    fontSize: 14,
    fontWeight: "500",
  },
});
