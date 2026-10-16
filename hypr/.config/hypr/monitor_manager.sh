#!/bin/bash

# Nama port laptop dan external monitor (cek via 'hyprctl monitors')
LAPTOP="eDP-1"
EXTERNAL="HDMI-A-1"

handle() {
    case $1 in
        monitoradded\>>$EXTERNAL|monitorremoved\>>$EXTERNAL)
            check_monitors
            ;;
    esac
}

check_monitors() {
    # Cek apakah external monitor sedang aktif/terhubung
    if hyprctl monitors | grep -q "$EXTERNAL"; then
        # Colok HDMI: Aktifkan HDMI, matikan layar laptop (atau atur sesuai keinginan)
        hyprctl keyword monitor "$EXTERNAL, preferred, auto, 1"
        hyprctl keyword monitor "$LAPTOP, disable"
    else
        # Cabut HDMI: Aktifkan kembali layar laptop
        hyprctl keyword monitor "$LAPTOP, preferred, auto, 1"
        hyprctl keyword monitor "$EXTERNAL, disable"
    fi
}

# Jalankan sekali di awal saat script mulai
check_monitors

# Mendengarkan socket event dari Hyprland
socat - UNIX-CONNECT:/tmp/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock | while read -r line; do
    handle "$line"
done
