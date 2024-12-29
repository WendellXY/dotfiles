-- vim:fileencoding=utf-8:foldmethod=marker

-- Set leader keys {{{
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- }}}

-- Tab and indentation settings {{{
vim.opt.tabstop = 2 -- Number of spaces that a tab character represents
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = false -- Use tabs instead of spaces
-- }}}

-- UI settings {{{
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.cursorline = true -- Highlight the current line
vim.opt.signcolumn = "yes" -- Always show the sign column
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.breakindent = true -- Enable break indent
vim.opt.scrolloff = 10 -- Keep 10 lines visible when scrolling
vim.opt.list = true -- Show whitespace characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.showmode = false -- Hide the mode text in command line
vim.opt.inccommand = "split" -- Show incremental results for substitute
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below
-- }}}

-- Clipboard settings {{{
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus" -- Use system clipboard
end)
-- }}}

-- Undo settings {{{
vim.opt.undofile = true -- Enable persistent undo
-- }}}

-- Search settings {{{
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Override ignorecase if search contains uppercase
-- }}}

-- Timing settings {{{
vim.opt.updatetime = 250 -- Reduce update time for better responsiveness
vim.opt.timeoutlen = 300 -- Shorter timeout for mapped key sequences
-- }}}

-- Highlight on yank {{{
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- }}}

-- LSP markdown settings {{{
vim.lsp.util.convert_input_to_markdown_lines = true
vim.lsp.util.stylize_markdown = true
-- }}}

-- Global flag for NERD fonts {{{
vim.g.have_nerd_font = true
-- }}}

-- Lazy.nvim configuration {{{
require "config.lazy"
-- }}}

-- Key mappings {{{
require "config.keymaps"
-- }}}
