import React from "react";
import { Ionicons } from "@expo/vector-icons";
import { StyleProp, TextStyle } from "react-native";

const featherToIonicons: Record<string, string> = {
  "alert-circle": "alert-circle-outline",
  "alert-triangle": "warning-outline",
  "arrow-down-circle": "arrow-down-circle-outline",
  "arrow-left": "arrow-back",
  "arrow-right": "arrow-right",
  "arrow-up-circle": "arrow-up-circle-outline",
  "calendar": "calendar-outline",
  "check": "checkmark",
  "check-circle": "checkmark-circle-outline",
  "check-square": "checkbox-outline",
  "chevron-down": "chevron-down",
  "chevron-left": "chevron-back",
  "chevron-right": "chevron-forward",
  "chevron-up": "chevron-up",
  "clock": "time-outline",
  "copy": "copy-outline",
  "credit-card": "card-outline",
  "database": "server-outline",
  "dollar-sign": "cash-outline",
  "download": "download-outline",
  "edit": "create-outline",
  "edit-2": "create-outline",
  "edit-3": "create-outline",
  "eye": "eye-outline",
  "eye-off": "eye-off-outline",
  "file-text": "document-text-outline",
  "filter": "filter-outline",
  "globe": "globe-outline",
  "grid": "grid-outline",
  "hash": "keypad-outline",
  "home": "home-outline",
  "info": "information-circle-outline",
  "link": "link-outline",
  "link-2": "link-outline",
  "list": "list-outline",
  "lock": "lock-closed-outline",
  "log-in": "log-in-outline",
  "log-out": "log-out-outline",
  "mail": "mail-outline",
  "map": "map-outline",
  "map-pin": "location-outline",
  "maximize": "expand-outline",
  "maximize-2": "expand-outline",
  "menu": "menu-outline",
  "message-circle": "chatbubble-outline",
  "message-square": "chatbubble-outline",
  "minus": "remove-outline",
  "minus-circle": "remove-circle-outline",
  "more-horizontal": "ellipsis-horizontal",
  "more-vertical": "ellipsis-vertical",
  "navigation": "navigate-outline",
  "package": "cube-outline",
  "percent": "pricetag-outline",
  "pie-chart": "pie-chart-outline",
  "plus": "add",
  "plus-circle": "add-circle-outline",
  "radio": "radio-outline",
  "refresh-ccw": "refresh-outline",
  "refresh-cw": "refresh-outline",
  "rotate-ccw": "refresh-outline",
  "save": "save-outline",
  "search": "search-outline",
  "send": "send-outline",
  "settings": "settings-outline",
  "share": "share-outline",
  "share-2": "share-social-outline",
  "shield": "shield-outline",
  "sliders": "options-outline",
  "square": "square-outline",
  "star": "star-outline",
  "trash": "trash-outline",
  "trash-2": "trash-outline",
  "trending-down": "trending-down-outline",
  "trending-up": "trending-up-outline",
  "truck": "car-outline",
  "user": "person-outline",
  "users": "people-outline",
  "x": "close",
  "x-circle": "close-circle-outline",
};

interface IconProps {
  name: string;
  size?: number;
  color?: string;
  style?: StyleProp<TextStyle>;
}

export function Icon({ name, size = 24, color = "#FFFFFF", style }: IconProps) {
  const ioniconsName = featherToIonicons[name] || "help-circle-outline";
  return (
    <Ionicons
      name={ioniconsName as any}
      size={size}
      color={color}
      style={style}
    />
  );
}

export default Icon;
