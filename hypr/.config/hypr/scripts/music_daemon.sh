#!/bin/bash

ART_PATH="/tmp/hyprlock_cover.jpg"
TITLE_PATH="/tmp/hyprlock_title.txt"
STATUS_PATH="/tmp/hyprlock_status.txt"
LAST_SONG=""

echo " " >"$TITLE_PATH"
echo "▶" >"$STATUS_PATH"

while true; do
  player=""
  for p in $(playerctl -l 2>/dev/null); do
    t=$(playerctl -p "$p" metadata title 2>/dev/null)
    if [[ "$t" == *"arch.mp4"* ]]; then
      continue
    fi
    if [ "$(playerctl -p "$p" status 2>/dev/null)" = "Playing" ]; then
      player="$p"
      break
    fi
    [ -z "$player" ] && player="$p"
  done

  if [ -z "$player" ]; then
    echo " " >"$TITLE_PATH"
    echo "▶" >"$STATUS_PATH"
    rm -f "$ART_PATH"
    LAST_SONG=""
    sleep 2
    continue
  fi

  status=$(playerctl -p "$player" status 2>/dev/null)
  if [ "$status" = "Playing" ]; then
    echo "⏸" >"$STATUS_PATH"
  else
    echo "▶" >"$STATUS_PATH"
  fi

  title=$(playerctl -p "$player" metadata title 2>/dev/null)
  artist=$(playerctl -p "$player" metadata artist 2>/dev/null)

  if [[ "$title" == *"arch.mp4"* ]] || [ -z "$title" ]; then
    echo " " >"$TITLE_PATH"
    rm -f "$ART_PATH"
    LAST_SONG=""
    sleep 2
    continue
  fi

  current_song="$title ~ $artist"
  if [ -n "$artist" ]; then
    echo "${current_song:0:55}" >"$TITLE_PATH"
  else
    echo "${title:0:55}" >"$TITLE_PATH"
  fi

  if [ "$current_song" != "$LAST_SONG" ]; then
    LAST_SONG="$current_song"
    ~/.config/hypr/scripts/album_art.sh
  fi

  sleep 1.5
done
