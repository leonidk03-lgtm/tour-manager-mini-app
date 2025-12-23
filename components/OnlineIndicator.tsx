import { View, StyleSheet } from 'react-native';
import { ThemedText } from '@/components/ThemedText';
import { useTheme } from '@/hooks/useTheme';
import { usePresence } from '@/contexts/PresenceContext';
import { Spacing, Typography } from '@/constants/theme';

interface OnlineIndicatorProps {
  userId: string;
  showText?: boolean;
  size?: 'small' | 'medium' | 'large';
}

export function OnlineIndicator({ userId, showText = false, size = 'small' }: OnlineIndicatorProps) {
  const { theme } = useTheme();
  const { isOnline, getLastSeenText } = usePresence();
  
  const online = isOnline(userId);
  const lastSeenText = getLastSeenText(userId);
  
  const dotSize = size === 'small' ? 8 : size === 'medium' ? 10 : 12;
  const borderWidth = size === 'small' ? 1.5 : 2;
  
  return (
    <View style={styles.container}>
      <View
        style={[
          styles.dot,
          {
            width: dotSize,
            height: dotSize,
            borderRadius: dotSize / 2,
            backgroundColor: online ? theme.success : theme.textSecondary,
            borderColor: theme.backgroundDefault,
            borderWidth,
          },
        ]}
      />
      {showText && !online && lastSeenText ? (
        <ThemedText style={[styles.lastSeenText, { color: theme.textSecondary }]}>
          {lastSeenText}
        </ThemedText>
      ) : null}
    </View>
  );
}

interface OnlineCounterProps {
  style?: object;
}

export function OnlineCounter({ style }: OnlineCounterProps) {
  const { theme } = useTheme();
  const { onlineCount, totalCount } = usePresence();
  
  return (
    <View style={[styles.counterContainer, style]}>
      <View style={[styles.counterDot, { backgroundColor: theme.success }]} />
      <ThemedText style={[styles.counterText, { color: theme.textSecondary }]}>
        {onlineCount}/{totalCount}
      </ThemedText>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  dot: {
    marginRight: Spacing.xs,
  },
  lastSeenText: {
    fontSize: Typography.small.fontSize,
  },
  counterContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: Spacing.xs,
  },
  counterDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
  },
  counterText: {
    fontSize: Typography.caption.fontSize,
  },
});
