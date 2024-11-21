local wezterm = require "wezterm"

local module = {}

function module.set(config)
  config.keys = {
    {
      key = "w",
      mods = "CMD",
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
      key = "d",
      mods = "CMD",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
      key = "d",
      mods = "SHIFT|CMD",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
      key = "j",
      mods = "CMD",
      action = wezterm.action.PaneSelect,
    },
    {
      key = "`",
      mods = "META",
      action = wezterm.action.RotatePanes "CounterClockwise",
    },
    {
      key = "`",
      mods = "META|SHIFT",
      action = wezterm.action.RotatePanes "Clockwise",
    },
  }
end

return module
