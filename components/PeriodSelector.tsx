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
            style={({ pressed }) => [
              styles.button,
              {
                backgroundColor: isSelected
                  ? theme.primary
                  : pressed
                  ? theme.backgroundSecondary
                  : "transparent",
                borderRadius: BorderRadius.lg,
              },
            ]}
          >
            <ThemedText
              style={[
                styles.buttonText,
                {
                  color: isSelected ? theme.buttonText : theme.text,
                  fontWeight: isSelected ? "600" : "400",
                },
              ]}
            >
              {period.label}
            </ThemedText>
          </Pressable>
        );
      })}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: "row",
    gap: Spacing.xs,
  },
  button: {
    flex: 1,
    paddingVertical: Spacing.sm,
    paddingHorizontal: Spacing.md,
    alignItems: "center",
    justifyContent: "center",
  },
  buttonText: {
    fontSize: 14,
  },
});
