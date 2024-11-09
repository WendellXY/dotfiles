local configPath = vim.fn.stdpath('config') -- Get the path to the Neovim configuration directory
local swiftScriptPath = configPath .. "/utils/DetectColorScheme.swift"

-- Sets colors to line numbers Above, Current and Below in this order
local function setup_line_number_color_theme()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#51B3EC', bold=false })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FB508F', bold=false })
end

return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    local result = vim.fn.system("swift " .. swiftScriptPath):gsub("%s+", "")
    local flavour = "mocha" -- Default to mocha

    -- Kitty does not support color schemes, disable the light theme
    -- if result == "light" then
    --   flavour = "latte"
    -- end
    require("catppuccin").setup({
      transparent_background = true,
      flavour = flavour,
    })
    vim.cmd.colorscheme "catppuccin"
    setup_line_number_color_theme()
  end
}
