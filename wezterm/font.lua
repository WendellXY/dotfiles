local wezterm = require "wezterm"

local module = {}

function module.set(config)
	config.font = wezterm.font "MonaspiceNe Nerd Font Mono"
	config.font_size = 13.0
	config.harfbuzz_features = { "calt", "liga", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "ss09" }
end

return module
