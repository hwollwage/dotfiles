#!/bin/bash
STATE_FILE="/tmp/hyprlock_play_state"
LAST_PLAYER_FILE="/tmp/hyprlock_last_player"

# find player being playted
PLAYER=$(playerctl -l 2>/dev/null | while read -r p; do
  if [ "$(playerctl -p "$p" status 2>/dev/null)" = "Playing" ]; then
    echo "$p"
    break
  fi
done)

# if nothing played, check if last player still active
if [ -z "$PLAYER" ] && [ -f "$LAST_PLAYER_FILE" ]; then
  SAVED=$(cat "$LAST_PLAYER_FILE")
  if playerctl -l 2>/dev/null | grep -Fxq "$SAVED"; then
    PLAYER="$SAVED"
  fi
fi

# fallback: prioritze mpv / spotify that opened
if [ -z "$PLAYER" ]; then
  PLAYER=$(playerctl -l 2>/dev/null | grep -E "^(mpv|spotify)" | head -n 1)
  [ -z "$PLAYER" ] && PLAYER=$(playerctl -l 2>/dev/null | head -n 1)
fi

[ -n "$PLAYER" ] && echo "$PLAYER" >"$LAST_PLAYER_FILE"

case "$1" in
toggle)
  CURRENT=$(playerctl -p "$PLAYER" status 2>/dev/null)
  if [ "$CURRENT" = "Playing" ]; then
    echo "Paused" >"$STATE_FILE"
  else
    echo "Playing" >"$STATE_FILE"
  fi
  playerctl -p "$PLAYER" play-pause
  exit 0
  ;;
next)
  playerctl -p "$PLAYER" next
  (sleep 0.3 && ~/.config/hypr/scripts/album_art.sh) >/dev/null 2>&1 &
  exit 0
  ;;
prev)
  playerctl -p "$PLAYER" previous
  (sleep 0.3 && ~/.config/hypr/scripts/album_art.sh) >/dev/null 2>&1 &
  exit 0
  ;;
esac

REAL_STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null)

if [ -f "$STATE_FILE" ]; then
  AGE=$(($(date +%s) - $(stat -c %Y "$STATE_FILE")))
  if [ "$AGE" -lt 2 ]; then
    STATUS=$(cat "$STATE_FILE")
  else
    rm -f "$STATE_FILE"
    STATUS="$REAL_STATUS"
  fi
else
  STATUS="$REAL_STATUS"
fi

if [ "$STATUS" = "Playing" ]; then
  echo "⏸"
elif [ "$STATUS" = "Paused" ]; then
  echo "▶"
else
  echo "⏹"
fi
