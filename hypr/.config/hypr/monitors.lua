--#######################
--###    MONITORS    ####
--#######################

local is_mirrored = false

-- Cek apakah HDMI-A-1 sudah tercolok sejak awal konfigurasi dimuat
local hdmi_connected = false
for _, m in ipairs(hl.get_monitors()) do
	if m.name == "HDMI-A-1" then
		hdmi_connected = true
		break
	end
end

-- Atur monitor berdasarkan kondisi awal (mencegah eDP-1 merebut workspace 1)
if hdmi_connected then
	hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@100", position = "auto", scale = 1 })
	hl.monitor({ output = "eDP-1", disabled = true })
else
	hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })
end

-- Saat kabel HDMI dicolokkan di tengah sesi, masuk mode docked
hl.on("monitor.added", function(m)
	if m.name == "HDMI-A-1" then
		is_mirrored = false
		hl.monitor({ output = "eDP-1", disabled = true })
		hl.dispatch(hl.dsp.focus({ workspace = 1 }))
	end
end)

-- Saat kabel HDMI dicabut, hidupkan kembali layar laptop normal
hl.on("monitor.removed", function(m)
	if m.name == "HDMI-A-1" then
		is_mirrored = false
		hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1, mirror = "", disabled = false })
	end
end)

-- Pastikan fokus langsung ke workspace 1 setelah inisialisasi monitor selesai
hl.on("hyprland.start", function()
	for _, m in ipairs(hl.get_monitors()) do
		if m.name == "HDMI-A-1" then
			is_mirrored = false
			hl.monitor({ output = "eDP-1", disabled = true })
		end
	end
	hl.exec_cmd([[sleep 0.5 && hyprctl eval 'hl.dispatch(hl.dsp.focus({ workspace = 1 }))']])
end)

-- Shortcut SUPER + P untuk toggle Mirror (eDP-1 menyalin HDMI-A-1) / Docked
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
