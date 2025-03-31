local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.color_scheme = "Gruvbox Dark (Gogh)"
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.font_size = 12.5

config.window_padding = {
	left = 5,
	right = 5,
	top = 5,
	bottom = 5,
}
config.background = {
	{
		source = {
			File = wezterm.config_dir .. "/background/sequoia-sunrise.jpg",
		},
		hsb = {
			hue = 1.0,
			saturation = 1.02,
			brightness = 0.25,
		},
	},
	{
		source = {
			Color = "#282c35",
		},
		width = "100%",
		height = "100%",
		opacity = 0.7,
	},
}

return config
