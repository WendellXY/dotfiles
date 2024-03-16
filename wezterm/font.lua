local wezterm = require "wezterm"

local module = {}

function module.set(config)
  config.font = wezterm.font "SFMono Nerd Font"
  config.font_size = 13.0
end

return module
