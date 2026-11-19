--#######################
--###    WINDOW RULES    ####
--#######################

-- notifications blur
hl.layer_rule({
	match = { namespace = "notifications" },
	blur = true,
})

-- rofi animation

hl.layer_rule({
	match = { namespace = "rofi" },
	animation = "slide",
})

-- copyq rules float, size, pos
hl.window_rule({
	match = {
		class = "^(com\\.github\\.hluk\\.copyq)$",
	},
	float = true,
	size = "600 700",
	move = "35% 30%",
})

hl.window_rule({
	match = {
		class = "xdg-desktop-portal-gtk",
	},
	float = true,
	-- size = "1280 720",
	center = true,
})

hl.window_rule({
	match = {
		class = "^(floating-nmtui)$",
	},
	float = true,
	size = { 600, 500 },
	center = true,
})

hl.window_rule({
	match = {
		class = "^(org.kde.gwenview)$",
	},
	float = true,
	size = "1280 720",
	center = true,
})

hl.window_rule({
	match = {
		class = "org.pulseaudio.pavucontrol",
	},
	float = true,
	size = "800 700",
	center = true,
})
