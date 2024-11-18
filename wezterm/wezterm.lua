local appearance = require("appearance")
local font = require("font")
local keybinding = require("keybinding")

local config = {}

config.default_prog = { "/opt/homebrew/bin/nu", "-l" }
appearance.set(config)
font.set(config)
keybinding.set(config)

return config
