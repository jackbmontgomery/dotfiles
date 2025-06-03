local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.font_size = 15
config.hide_mouse_cursor_when_typing = true

config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.window_padding = {
	left = 10,
	right = 10,
	top = 10,
	bottom = 10,
}

config.background = {
	{
		source = {
			Color = "#15171c",
		},
		width = "100%",
		height = "100%",
		opacity = 1,
	},
}

config.keys = {
	{
		key = "Enter",
		mods = "CTRL",
		action = wezterm.action.SendString("\x1b[99~"),
	},
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action.SendString("\x1b[A"),
	},
}

return config
