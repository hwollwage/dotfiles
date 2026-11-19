#!/usr/bin/env bash

if pgrep -f "[f]loating-nmtui" >/dev/null; then
  pkill -f "[f]loating-nmtui"
else
  kitty --class floating-nmtui -e nmtui &
fi
