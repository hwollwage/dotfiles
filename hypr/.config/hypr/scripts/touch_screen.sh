#!/usr/bin/env bash

NAME="ELAN901C:00 04F3:2A3B"
FLAG_FILE="$HOME/.cache/touchscreen_disabled"

nodes() {
  for d in /sys/class/input/input*; do
    [ "$(cat "$d/name" 2>/dev/null)" = "$NAME" ] && echo "$d"
  done
}

set_state() {
  for d in $(nodes); do
    echo "$1" >"$d/inhibited" 2>/dev/null
  done
}

is_disabled() {
  for d in $(nodes); do
    [ "$(cat "$d/inhibited" 2>/dev/null)" = "1" ] && return 0
  done
  return 1
}

case "$1" in
toggle)
  if is_disabled; then
    set_state 0
    rm -f "$FLAG_FILE"
  else
    set_state 1
    touch "$FLAG_FILE"
  fi
  pkill -RTMIN+8 waybar
  exit 0
  ;;
restore)
  for _ in $(seq 1 30); do
    [ -n "$(nodes)" ] && [ -w "$(nodes | head -n1)/inhibited" ] && break
    sleep 0.5
  done
  set_state 1
  touch "$FLAG_FILE"
  pkill -RTMIN+8 waybar
  exit 0
  ;;
esac

if is_disabled; then
  echo '{"text": "󱠲", "alt": "disabled", "tooltip": "Touchscreen: [OFF]", "class": "disabled"}'
else
  echo '{"text": "󱠬", "alt": "enabled", "tooltip": "Touchscreen: [ON]", "class": "enabled"}'
fi
