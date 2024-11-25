local colors = require "colors"
local icons = require "icons"
local settings = require "settings"
local app_icons = require "helpers.app_icons"

local mail = sbar.add("item", "badges.mail", {
  position = "right",
  padding_left = 0,
  padding_right = 0,
  icon = {
    string = app_icons["Mail"],
    font = "sketchybar-app-font:Regular:16.0",
    color = colors.blue,
    drawing = false,
  },
  label = {
    font = { family = settings.font.numbers },
    drawing = false,
  },
  update_freq = 60,
  click_script = "open -a Mail",
})

mail:subscribe({ "forced", "routine", "system_woke" }, function(env)
  sbar.exec("osascript -e 'tell application \"Mail\" to return the unread count of inbox'", function(result, error)
    local badge = result:match "^%s*(.-)%s*$"
    if badge == "" or badge == "0" then
      mail:set {
        padding_left = 0,
        padding_right = 0,
        icon = { drawing = false },
        label = { drawing = false },
      }
    else
      mail:set {
        padding_left = 5,
        padding_right = 5,
        icon = { drawing = true },
        label = { drawing = true, string = result },
      }
    end
  end)
end)
