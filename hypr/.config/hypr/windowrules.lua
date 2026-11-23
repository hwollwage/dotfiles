--#######################
--###    WINDOW RULES    ####
--#######################

-- notifications blur
hl.layer_rule({ match = { namespace = "notifications" }, blur = true })
-- rofi animation
hl.layer_rule({ match = { namespace = "rofi" }, animation = "slide" })
hl.animation({ leaf = "layers", enabled = true, speed = 0.5, bezier = "default" })

-- copyq rules float, size, pos
hl.window_rule({
	match = { class = "^(com\\.github\\.hluk\\.copyq)$" },
	float = true,
	size = "600 700",
	move = "35% 30%",
})

-- display picker (obs, zoom, etc)
hl.window_rule({ match = { class = "hyprland-share-picker" }, float = true, size = "400 500", center = true })
-- archive manager fileroller
hl.window_rule({ match = { class = "org.gnome.FileRoller" }, float = true, size = "800 600", center = true })

-- pip brave
hl.window_rule({
	match = { class = "^(brave-browser)$", title = "(?i).*picture[- ]in[- ]picture.*" },
	float = true,
	size = "450 255",
	center = true,
	pin = true,
})

-- kde passwd popup
hl.window_rule({ match = { class = "org.kde.kded6" }, float = true, size = "800 600", center = true })
-- file picker popup
hl.window_rule({ match = { class = "xdg-desktop-portal-gtk" }, float = true, center = true })
-- floating nmtui
hl.window_rule({ match = { class = "^(floating-nmtui)$" }, float = true, size = { 600, 500 }, center = true })
-- gwenview img
hl.window_rule({ match = { class = "^(org.kde.gwenview)$" }, float = true, size = "1280 720", center = true })
-- audio controll
hl.window_rule({ match = { class = "org.pulseaudio.pavucontrol" }, float = true, size = "800 700", center = true })
-- calculator (qalculate-gtk)
hl.window_rule({ match = { class = "qalculate-gtk" }, float = true, size = "200 250", center = true, pin = true })
-- circuitjs
hl.window_rule({ match = { class = "^(Circuit JS1)$" }, float = true, size = "800 600", center = true })
