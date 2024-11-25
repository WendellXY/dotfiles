local colors = require "colors"
local icons = require "icons"
local settings = require "settings"
local app_icons = require "helpers.app_icons"

local wechat = sbar.add("item", "badges.wechat", {
  position = "right",
  padding_left = 0,
  padding_right = 0,
  icon = {
    string = app_icons["WeChat"],
    font = "sketchybar-app-font:Regular:16.0",
    color = colors.green,
    drawing = false,
  },
  label = {
    font = { family = settings.font.numbers },
    drawing = false,
  },
  update_freq = 10,
  click_script = "open -a Wechat",
})

wechat:subscribe({ "forced", "routine", "system_woke" }, function(env)
  sbar.exec("sh $CONFIG_DIR/utils/get-app-badge.sh WeChat", function(result, error)
    local badge = result:match "^%s*(.-)%s*$"
    if badge == "?" or badge == "0" then
      wechat:set {
        padding_left = 0,
        padding_right = 0,
        icon = { drawing = false },
        label = { drawing = false },
      }
    else
      wechat:set {
        padding_left = 5,
        padding_right = 5,
        icon = { drawing = true },
        label = { drawing = true, string = result },
      }
    end
  end)
end)
