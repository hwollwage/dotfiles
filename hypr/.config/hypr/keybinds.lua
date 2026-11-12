--#######################
--###    KEYBINDS    ####
--#######################

local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "hyprlauncher"

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + 0", hl.dsp.exec_cmd("wlogout"))

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("copyq toggle"))

-- wireplumber / wpctl
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- brightnessctl
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -o /home/edelweiss/Pictures/Screenshots_hypr/"))
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))

-- emoji
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("emote"))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

hl.bind("SUPER + CTRL + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

hl.bind("SUPER + CTRL + h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + k", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + j", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

hl.bind("SUPER + Escape", hl.dsp.window.close())
hl.bind("CTRL + ALT + escape", hl.dsp.window.kill())

hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + Page_up", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + Page_down", hl.dsp.focus({ workspace = "r-1" }))

hl.bind(mainMod .. " + CTRL + h", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + Right", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + CTRL + Left", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + Left", hl.dsp.window.move({ workspace = -1 }))

hl.bind(mainMod .. " + ALT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.swap({ direction = "d" }))
