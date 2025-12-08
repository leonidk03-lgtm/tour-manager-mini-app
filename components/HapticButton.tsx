import React from 'react';
import { Pressable, PressableProps, StyleSheet, ViewStyle } from 'react-native';
import { hapticFeedback } from '@/utils/haptics';

interface HapticButtonProps extends PressableProps {
  hapticType?: 'light' | 'medium' | 'heavy' | 'selection';
  activeOpacity?: number;
  activeScale?: number;
}

export default function HapticButton({
  onPress,
  hapticType = 'light',
  activeOpacity = 0.7,
  activeScale,
  style,
  children,
  ...props
}: HapticButtonProps) {
  const handlePress = (event: any) => {
    hapticFeedback[hapticType]();
    onPress?.(event);
  };

  return (
    <Pressable
      onPress={handlePress}
      style={({ pressed }) => [
        typeof style === 'function' ? style({ pressed }) : style,
        pressed && { opacity: activeOpacity },
        pressed && activeScale ? { transform: [{ scale: activeScale }] } : null,
      ]}
      {...props}
    >
      {children}
    </Pressable>
  );
}
