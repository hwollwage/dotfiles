--#######################
--###    MONITORS    ####
--#######################

local is_mirrored = false

local hdmi_connected = false
for _, m in ipairs(hl.get_monitors()) do
	if m.name == "HDMI-A-1" then
		hdmi_connected = true
		break
	end
end

if hdmi_connected then
	hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@100", position = "auto", scale = 1 })
	hl.monitor({ output = "eDP-1", disabled = true })
else
	hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })
end

hl.on("monitor.added", function(m)
	if m.name == "HDMI-A-1" then
		is_mirrored = false
		hl.monitor({ output = "eDP-1", disabled = true })
		hl.dispatch(hl.dsp.focus({ workspace = 1 }))
	end
end)

hl.on("monitor.removed", function(m)
	if m.name == "HDMI-A-1" then
		is_mirrored = false
		hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1, mirror = "", disabled = false })
	end
end)

hl.on("hyprland.start", function()
	for _, m in ipairs(hl.get_monitors()) do
		if m.name == "HDMI-A-1" then
			is_mirrored = false
			hl.monitor({ output = "eDP-1", disabled = true })
		end
	end
	hl.exec_cmd([[sleep 0.5 && hyprctl eval 'hl.dispatch(hl.dsp.focus({ workspace = 1 }))']])
end)

hl.bind("SUPER + P", function()
	if not is_mirrored then
		hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 1, mirror = "" })
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
		hl.monitor({ output = "eDP-1", mirror = "", disabled = true })
		is_mirrored = false
	end
end, { description = "Toggle Mirror / Docked Display" })
