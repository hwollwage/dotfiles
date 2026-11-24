--#######################
--###    KEYBINDS    ####
--#######################

local terminal = "kitty"
local fileManager = "dolphin"

hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E", hl.dsp.exec_cmd(fileManager))

-- app exec
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("copyq toggle"))
hl.bind("SUPER + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind("SUPER + 0", hl.dsp.exec_cmd("wlogout"))
hl.bind(
	"PRINT",
	hl.dsp.exec_cmd(
		'sh -c "pkill slurp; pkill hyprpicker; hyprshot -m region --freeze -o ~/Pictures/Screenshots_hypr/"'
	)
)

hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + period", hl.dsp.exec_cmd("emote"))

-- movement (focus, resize, drag, move, close, kill, swap, float)
hl.bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + CTRL + left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + h", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + l", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + k", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind("SUPER + CTRL + j", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

hl.bind("SUPER + Page_up", hl.dsp.focus({ workspace = "r+1" }))
hl.bind("SUPER + Page_down", hl.dsp.focus({ workspace = "r-1" }))

hl.bind("SUPER + SHIFT + Right", hl.dsp.window.move({ workspace = "+1" }))
hl.bind("SUPER + SHIFT + Left", hl.dsp.window.move({ workspace = -1 }))

hl.bind("SUPER + ALT + left", hl.dsp.window.swap({ direction = "l" }))
hl.bind("SUPER + ALT + right", hl.dsp.window.swap({ direction = "r" }))
hl.bind("SUPER + ALT + up", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + ALT + down", hl.dsp.window.swap({ direction = "d" }))

hl.bind("SUPER + Escape", hl.dsp.window.close())
hl.bind("CTRL + ALT + escape", hl.dsp.window.kill())
hl.bind("SUPER + B", hl.dsp.window.float({ action = "toggle" }))

-- swayosd volume, brightness (onscreendisplay)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume lower"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("swayosd-client --brightness raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("swayosd-client --brightness lower --min-brightness 0"),
	{ locked = true, repeating = true }
)

-- switch focus picture-in-picture (pip)
hl.bind("SUPER + Control_R", function()
	local window = hl.get_active_window()
	if window and window.floating then
		hl.dispatch(hl.dsp.window.cycle_next({ tiled = true }))
	else
		hl.dispatch(hl.dsp.focus({ window = "floating" }))
	end
end)
