local appearance = require "appearance"
local font = require "font"
local keybinding = require "keybinding"

local config = {}

config.animation_fps = 120
config.audible_bell = "Disabled"
config.enable_kitty_keyboard = true
config.disable_default_key_bindings = true
config.max_fps = 120

appearance.set(config)
font.set(config)
keybinding.set(config)

return config
