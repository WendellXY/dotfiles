local wezterm = require "wezterm"

local module = {}

function module.set(config)
  config.keys = {
    -- MARK: General
    {
      key = "q",
      mods = "SUPER",
      action = wezterm.action.QuitApplication,
    },
    {
      key = "c",
      mods = "SUPER",
      action = wezterm.action.CopyTo "Clipboard",
    },
    {
      key = "v",
      mods = "SUPER",
      action = wezterm.action.PasteFrom "Clipboard",
    },
    {
      key = "l",
      mods = "CTRL|SHIFT",
      action = wezterm.action.ShowDebugOverlay,
    },
    -- MARK: Pane management
    {
      key = "w",
      mods = "SUPER",
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },
    {
      key = "d",
      mods = "SUPER",
      action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
    },
    {
      key = "d",
      mods = "SHIFT|SUPER",
      action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
    },
    {
      key = "j",
      mods = "SUPER",
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
