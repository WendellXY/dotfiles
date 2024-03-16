local wezterm = require "wezterm"

local module = {}

function module.set(config)
  config.default_cursor_style = "BlinkingUnderline"
  config.hide_tab_bar_if_only_one_tab = true
  config.window_decorations = "NONE | RESIZE"

  config.colors = {
    foreground = "#dbdbdb",
    background = "#14191e",
    ansi = {
      "#14191e",
      "#b43c29",
      "#00c200",
      "#c7c400",
      "#2743c7",
      "#bf3fbd",
      "#00c5c7",
      "#c7c7c7",
    },
    brights = {
      "#676767",
      "#dc7974",
      "#57e690",
      "#ece100",
      "#a6aaf1",
      "#e07de0",
      "#5ffdff",
      "#feffff",
    },
  }
end

return module
