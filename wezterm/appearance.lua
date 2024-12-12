local wezterm = require "wezterm"

local function scheme_for_appearance(appearance)
  -- if appearance:find "Dark" then
  return "Catppuccin Mocha"
  -- else
  -- return "Catppuccin Latte"
  -- end
end

local module = {}

function module.set(config)
  config.default_cursor_style = "BlinkingBar"
  config.hide_tab_bar_if_only_one_tab = true
  config.window_decorations = "NONE | RESIZE"
  config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
end

return module
