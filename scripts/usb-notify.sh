#!/bin/bash

USER_NAME=$(who | awk '{print $1}' | head -n 1)
USER_ID=$(id -u "$USER_NAME")

ACTION=$1
DEVICE_NAME=${2:-"USB Sys"}

if [ "$ACTION" == "add" ]; then
  TITLE="USB connected"
  BODY="$DEVICE_NAME plugged in."
  ICON="drive-removable-media"
else
  TITLE="USB disconnect"
  BODY="$DEVICE_NAME unplugged."
  ICON="media-eject"
fi

# sudo udevadm control --reload-rules
# sudo udevadm trigger
# (sering lupa cik 😹)

sudo -u "$USER_NAME" DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USER_ID/bus" \
  notify-send -a "USB Sys" -i "$ICON" "$TITLE" "$BODY"
