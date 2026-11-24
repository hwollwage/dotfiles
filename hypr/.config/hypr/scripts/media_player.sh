#!/bin/bash
LAST_PLAYER_FILE="/tmp/hyprlock_last_player"

PLAYER=$(playerctl -l 2>/dev/null | while read -r p; do
  if [ "$(playerctl -p "$p" status 2>/dev/null)" = "Playing" ]; then
    echo "$p"
    break
  fi
done)

if [ -z "$PLAYER" ] && [ -f "$LAST_PLAYER_FILE" ]; then
  SAVED=$(cat "$LAST_PLAYER_FILE")
  playerctl -l 2>/dev/null | grep -q "^$SAVED$" && PLAYER="$SAVED"
fi

if [ -z "$PLAYER" ]; then
  if playerctl -l 2>/dev/null | grep -q "^spotify$"; then
    PLAYER="spotify"
  else
    PLAYER=$(playerctl -l 2>/dev/null | head -n 1)
  fi
fi

[ -z "$PLAYER" ] && exit 0

TITLE=$(playerctl -p "$PLAYER" metadata title 2>/dev/null)
ARTIST=$(playerctl -p "$PLAYER" metadata artist 2>/dev/null)

if [ -n "$TITLE" ]; then
  TEXT="$ARTIST ~ $TITLE"
  [ ${#TEXT} -gt 45 ] && TEXT="${TEXT:0:42}..."
  echo "$TEXT"
fi
