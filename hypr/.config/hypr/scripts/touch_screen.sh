#!/usr/bin/env bash

DEVICE="elan901c:00-04f3:2a3b"
FLAG_FILE="$HOME/.cache/touchscreen_disabled"

if [ "$1" = "toggle" ]; then
  if [ -f "$FLAG_FILE" ]; then
    hyprctl keyword "device[$DEVICE]:enabled" true
    rm "$FLAG_FILE"
  else
    hyprctl keyword "device[$DEVICE]:enabled" false
    touch "$FLAG_FILE"
  fi
fi

if [ -f "$FLAG_FILE" ]; then
  echo '{"text": "󱠲", "alt": "disabled", "tooltip": "Touchscreen: [OFF]", "class": "disabled"}'
else
  echo '{"text": "󱠬", "alt": "enabled", "tooltip": "Touchscreen: [ON]", "class": "enabled"}'
fi
