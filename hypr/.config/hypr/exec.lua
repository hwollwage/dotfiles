--#######################
--###    EXEC    ####
--#######################

hl.on("hyprland.start", function()
	hl.exec_cmd("waybar")
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("copyq --start-server")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("swaync")
end)
