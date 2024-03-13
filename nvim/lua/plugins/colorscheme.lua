local configPath = vim.fn.stdpath('config') -- Get the path to the Neovim configuration directory
local swiftScriptPath = configPath .. "/utils/DetectColorScheme.swift"

return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    local result = vim.fn.system("swift " .. swiftScriptPath):gsub("%s+", "")
    local flavour = "mocha" -- Default to mocha
    if result == "light" then
      flavour = "latte"
    end
    require("catppuccin").setup({
      transparent_background = true,
      flavour = flavour,
    })
    vim.cmd.colorscheme "catppuccin"
  end
}
