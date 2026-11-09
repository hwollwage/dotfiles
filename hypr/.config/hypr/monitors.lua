--#######################
--###    MONITORS    ####
--#######################

local M = {}

local INT = "eDP-1"
local EXT = "HDMI-A-1"
local INT_MODE = "1920x1080@60"
local EXT_MODE = "1920x1080@100"
local ext_present = false

local function has_ext()
	for _, m in ipairs(hl.get_monitors() or {}) do
		if m.name == EXT then
			return true
		end
	end
	return false
end

local function focus_ws1()
	hl.exec_cmd([[sh -c "sleep 1; hyprctl eval \"hl.dispatch(hl.dsp.focus({ workspace = '1' }))\""]])
end

local function warn(text)
	print("monitors: " .. text)
	hl.notification.create({ text = text, timeout = 3000, icon = "ok" })
end

local mirror_timer
mirror_timer = hl.timer(function()
	mirror_timer:set_enabled(false)
	hl.monitor({ output = EXT, mode = EXT_MODE, position = "0x0", scale = 1, mirror = INT })
	focus_ws1()
end, { timeout = 1000, type = "repeat" })
mirror_timer:set_enabled(false)

function M.laptop()
	mirror_timer:set_enabled(false)
	hl.monitor({ output = INT, mode = INT_MODE, position = "0x0", scale = 1, disabled = false })
	focus_ws1()
end

function M.external()
	mirror_timer:set_enabled(false)
	hl.monitor({ output = EXT, mode = EXT_MODE, position = "0x0", scale = 1, disabled = false })
	hl.monitor({ output = INT, disabled = true })
	focus_ws1()
end

function M.mirror()
	print("monitors: mirror called")
	hl.exec_cmd([[
    hyprctl eval "hl.monitor({ output = 'eDP-1', mode = '1920x1080@60', position = 'auto-right', scale = 1, disabled = false })"
    sleep 1
    hyprctl eval "hl.monitor({ output = 'HDMI-A-1', mode = '1920x1080@100', position = '0x0', scale = 1, mirror = 'eDP-1' })"
  ]])
	focus_ws1()
end

function M.external_if_connected()
	if not (ext_present or has_ext()) then
		warn("HDMI-A-1 not detected")
		return
	end
	ext_present = true
	M.external()
end

function M.mirror_if_connected()
	if not (ext_present or has_ext()) then
		warn("HDMI-A-1 not detected")
		return
	end
	ext_present = true
	M.mirror()
end

ext_present = has_ext()
M.laptop()
if ext_present then
	M.external()
end

hl.on("monitor.added", function(m)
	if m.name == EXT then
		ext_present = true
		M.external()
	end
end)

hl.on("monitor.removed", function(m)
	if m.name == EXT then
		ext_present = false
		M.laptop()
	end
end)

return M
