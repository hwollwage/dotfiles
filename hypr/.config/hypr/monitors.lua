--#######################
--###    MONITORS    ####
--#######################

hl.config({
	render = {
		cm_auto_hdr = 0,
	},
})
local is_mirrored = false

local hdmi_opts = {
	output = "HDMI-A-1",
	mode = "1920x1080@100",
	position = "auto",
	scale = 1,
	bitdepth = 10,
	cm = "srgb",
}

local ensure_ui_cmd = [[
	sleep 0.3
	pgrep -x hyprpaper >/dev/null || (hyprpaper >/dev/null 2>&1 &)
	pgrep -x waybar >/dev/null || (waybar >/dev/null 2>&1 &)
]]

hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })

local hdmi_connected = false
for _, m in ipairs(hl.get_monitors()) do
	if m.name == "HDMI-A-1" then
		hdmi_connected = true
		break
	end
end

if hdmi_connected then
	hl.monitor(hdmi_opts)
	hl.monitor({ output = "eDP-1", disabled = true })
end

hl.on("monitor.added", function(m)
	if m.name == "HDMI-A-1" then
		is_mirrored = false
		hl.monitor(hdmi_opts)
		hl.exec_cmd([[
			sleep 0.4
			for i in 1 2 3 4 5 6 7 8 9 10; do
				hyprctl dispatch moveworkspacetomonitor $i HDMI-A-1
			done
			hyprctl dispatch workspace 1
			hyprctl keyword monitor "eDP-1, disable"
		]] .. ensure_ui_cmd)
	end
end)

hl.on("monitor.removed", function(m)
	if m.name == "HDMI-A-1" then
		is_mirrored = false
		hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1, mirror = "", disabled = false })
		hl.exec_cmd([[
			sleep 0.4
			for i in 1 2 3 4 5 6 7 8 9 10; do
				hyprctl dispatch moveworkspacetomonitor $i eDP-1
			done
			hyprctl dispatch workspace 1
		]] .. ensure_ui_cmd)
	end
end)

hl.bind("SUPER + P", function()
	if not is_mirrored then
		hl.monitor({
			output = "HDMI-A-1",
			mode = "preferred",
			position = "auto",
			scale = 1,
			mirror = "",
		})
		hl.monitor({
			output = "eDP-1",
			mode = "preferred",
			position = "auto",
			scale = 1,
			mirror = "HDMI-A-1",
			disabled = false,
		})
		is_mirrored = true
	else
		hl.monitor(hdmi_opts)
		hl.monitor({ output = "eDP-1", mirror = "", disabled = true })
		is_mirrored = false
	end
end, { description = "Toggle Mirror / Docked Display", locked = true })
