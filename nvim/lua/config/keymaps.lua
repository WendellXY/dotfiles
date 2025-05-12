-- Helper function for setting keymaps
local keymap = require "utils.keymap"

keymap.del "grr"
keymap.del "gri"
keymap.del "gra"
keymap.del "grn"

-- File Management Keymaps
keymap.set("<leader>vtn", ":Neotree toggle<CR>", "Toggle Navigator")
keymap.set("<leader>vfn", "::Neotree focus<CR>", "Focus Navigator")
keymap.set("<leader>nt", ":Neotree toggle<CR>", "Navigator: Toggle")
keymap.set("<leader>nf", "::Neotree focus<CR>", "Navigator: Focus")

-- Terminal
keymap.set("<leader>tt", ":ToggleTerm direction=tab<CR>", "New Terminal: Tab")
keymap.set("<leader>tv", ":ToggleTerm direction=vertical<CR>", "New Terminal: Vertical")
keymap.set("<leader>th", ":ToggleTerm direction=horizontal<CR>", "New Terminal: Horizontal")
keymap.set("<leader>tf", ":ToggleTerm direction=float<CR>", "New Terminal: Float")
keymap.set("<A-i>", ":ToggleTerm direction=float<CR>", "New Terminal: Float")

-- Scratch Buffer
local snacks = require "snacks"
keymap.set("<leader>ws", function()
	snacks.scratch()
end, "Open [S]cratch Buffer")

keymap.set("<leader>S", function()
	snacks.scratch.select()
end, "[S]elect [S]cratch Buffer")

-- Flash
local flash = require "flash"
keymap.set("<A-s>", function()
	flash.jump()
end, "Flash", { "n", "x", "o" })
keymap.set("<A-S>", function()
	flash.treesitter()
end, "Flash Treesitter", { "n", "x", "o" })
keymap.set("r", function()
	flash.remote()
end, "Remote Flash", { "o" })
keymap.set("R", function()
	flash.treesitter_search()
end, "Treesitter Search", { "o", "x" })
keymap.set("<c-s>", function()
	flash.toggle()
end, "Toggle Flash Search", { "c" })

-- Telescope
-- See `:help telescope.builtin`
local builtin = require "telescope.builtin"
keymap.set("<leader>ds", builtin.diagnostics, "Search Diagnostics")
keymap.set("<leader>fs", builtin.find_files, "Open File")
keymap.set("<leader>f.", builtin.oldfiles, "Open Recent")
keymap.set("<leader>hs", builtin.help_tags, "Search Help")
keymap.set("<leader>hk", builtin.keymaps, "keymaps Help")
keymap.set("<leader>ht", builtin.builtin, "Telescope Help")
keymap.set("<leader>sf", builtin.find_files, "Search [F]ile")
keymap.set("<leader>sw", builtin.grep_string, "Search current [W]ord")
keymap.set("<leader>sg", builtin.live_grep, "Search by [G]rep")
keymap.set("<leader>sr", builtin.resume, "Search [R]esume")
keymap.set("<leader><leader>", builtin.buffers, "[ ] Find existing buffers")

-- Slightly advanced example of overriding default behavior and theme
keymap.set("<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, "[/] Fuzzily search in current buffer")

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
keymap.set("<leader>s/", function()
	builtin.live_grep {
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	}
end, "Search in Open Files")

-- Shortcut for searching your Neovim configuration files
keymap.set("<leader>sn", function()
	builtin.find_files { cwd = vim.fn.stdpath "config" }
end, "Search [N]eovim files")
