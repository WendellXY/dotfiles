-- local wezterm = require "wezterm"
--
-- local function get_appearance()
--   if wezterm.gui then
--     return wezterm.gui.get_appearance()
--   end
--   return "Dark"
-- end
--
-- local function scheme_for_appearance(appearance)
--   if appearance:find "Dark" then
--     return "Ocean (dark) (terminal.sexy)"
--   else
--     return "Ocean (light) (terminal.sexy)"
--   end
-- end

local module = {}

function module.set(config)
	config.default_cursor_style = "BlinkingUnderline"
	config.hide_tab_bar_if_only_one_tab = true
	config.window_decorations = "NONE | RESIZE"
	config.color_scheme = "Catppuccin Mocha"

	-- config.color_scheme = scheme_for_appearance(get_appearance())
end

return module
