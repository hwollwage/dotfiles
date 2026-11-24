#!/bin/bash
COVER_PATH="/tmp/hyprlock_cover.jpg"
LAST_PLAYER_FILE="/tmp/hyprlock_last_player"

# find player being played
PLAYER=$(playerctl -l 2>/dev/null | while read -r p; do
  if [ "$(playerctl -p "$p" status 2>/dev/null)" = "Playing" ]; then
    echo "$p"
    break
  fi
done)

# check last player if nothing playing
if [ -z "$PLAYER" ] && [ -f "$LAST_PLAYER_FILE" ]; then
  SAVED=$(cat "$LAST_PLAYER_FILE")
  playerctl -l 2>/dev/null | grep -q "^$SAVED$" && PLAYER="$SAVED"
fi

# fallback spotify / 1st player
if [ -z "$PLAYER" ]; then
  if playerctl -l 2>/dev/null | grep -q "^spotify$"; then
    PLAYER="spotify"
  else
    PLAYER=$(playerctl -l 2>/dev/null | head -n 1)
  fi
fi

[ -z "$PLAYER" ] && exit 0

URL=$(playerctl -p "$PLAYER" metadata mpris:artUrl 2>/dev/null)
SONG_URL=$(playerctl -p "$PLAYER" metadata xesam:url 2>/dev/null)
CACHE_KEY="${URL:-$SONG_URL}"

# if no URL, delete last cover
if [ -z "$CACHE_KEY" ]; then
  rm -f "$COVER_PATH" /tmp/hyprlock_cover_url
  exit 0
fi

# update only if music / url change
if [ "$(cat /tmp/hyprlock_cover_url 2>/dev/null)" != "$CACHE_KEY" ] || [ ! -f "$COVER_PATH" ]; then
  rm -f /tmp/hyprlock_cover_raw

  if [ -n "$URL" ]; then
    if [[ "$URL" == file://* ]]; then
      FILE_PATH="${URL#file://}"
      FILE_PATH=$(printf '%b' "${FILE_PATH//%/\\x}")
      cp "$FILE_PATH" /tmp/hyprlock_cover_raw 2>/dev/null
    elif [[ "$URL" == http* ]]; then
      curl -sL "$URL" -o /tmp/hyprlock_cover_raw
    elif [[ "$URL" == data:image/* ]]; then
      echo "$URL" | sed -E 's/^data:image\/[a-zA-Z]+;base64,//' | base64 -d >/tmp/hyprlock_cover_raw 2>/dev/null
    fi

  elif [[ "$SONG_URL" == file://* ]] && command -v ffmpeg >/dev/null 2>&1; then
    AUDIO_PATH="${SONG_URL#file://}"
    AUDIO_PATH=$(printf '%b' "${AUDIO_PATH//%/\\x}")
    ffmpeg -y -i "$AUDIO_PATH" -an -vcodec copy /tmp/hyprlock_cover_raw >/dev/null 2>&1
  fi

  if [ -s /tmp/hyprlock_cover_raw ]; then
    if command -v magick >/dev/null 2>&1; then
      magick /tmp/hyprlock_cover_raw "$COVER_PATH" 2>/dev/null
    elif command -v convert >/dev/null 2>&1; then
      convert /tmp/hyprlock_cover_raw "$COVER_PATH" 2>/dev/null
    elif command -v ffmpeg >/dev/null 2>&1; then
      ffmpeg -y -i /tmp/hyprlock_cover_raw "$COVER_PATH" >/dev/null 2>&1
    else
      cp /tmp/hyprlock_cover_raw "$COVER_PATH" 2>/dev/null
    fi
  else
    rm -f "$COVER_PATH"
  fi

  echo "$CACHE_KEY" >/tmp/hyprlock_cover_url
fi

echo "$COVER_PATH"
