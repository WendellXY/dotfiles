local wezterm = require "wezterm"
local module = {}

function module.set(config)
  config.keys = {
    {
      key = 'w',
      mods = 'CMD',
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
      key = "d",
      mods = "CMD",
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = "d",
      mods = "SHIFT|CMD",
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
  }
end

return module
