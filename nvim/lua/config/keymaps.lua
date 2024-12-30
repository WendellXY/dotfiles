-- Helper function for setting keymaps
local function map(key, command, desc, mode)
	mode = mode or "n"
	vim.keymap.set(mode, key, command, { desc = desc })
end

-- File Management Keymaps
map("<leader>tn", ":Neotree toggle<CR>", "[T]oggle [N]avigator")
map("<leader>fn", "::Neotree focus<CR>", "[F]ocus [N]avigator")

-- Scratch Buffer
local snacks = require "snacks"
map("<A-s>", function()
	snacks.scratch()
end, "Open [S]cratch Buffer")

map("<A-S>", function()
	snacks.scratch.select()
end, "[S]elect [S]cratch Buffer")

-- Flash
local flash = require "flash"
map("s", function()
	flash.jump()
end, "Flash", { "n", "x", "o" })
map("S", function()
	flash.treesitter()
end, "Flash Treesitter", { "n", "x", "o" })
map("r", function()
	flash.remote()
end, "Remote Flash", { "o" })
map("R", function()
	flash.treesitter_search()
end, "Treesitter Search", { "o", "x" })
map("<c-s>", function()
	flash.toggle()
end, "Toggle Flash Search", { "c" })

-- Telescope
-- See `:help telescope.builtin`
local builtin = require "telescope.builtin"
map("<leader>sh", builtin.help_tags, "[S]earch [H]elp")
map("<leader>sk", builtin.keymaps, "[S]earch [K]eymaps")
map("<leader>sf", builtin.find_files, "[S]earch [F]iles")
map("<leader>ss", builtin.builtin, "[S]earch [S]elect Telescope")
map("<leader>sw", builtin.grep_string, "[S]earch current [W]ord")
map("<leader>sg", builtin.live_grep, "[S]earch by [G]rep")
map("<leader>sd", builtin.diagnostics, "[S]earch [D]iagnostics")
map("<leader>sr", builtin.resume, "[S]earch [R]esume")
map("<leader>s.", builtin.oldfiles, '[S]earch Recent Files ("." for repeat)')
map("<leader><leader>", builtin.buffers, "[ ] Find existing buffers")

-- Slightly advanced example of overriding default behavior and theme
map("<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, "[/] Fuzzily search in current buffer")

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
map("<leader>s/", function()
	builtin.live_grep {
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	}
end, "[S]earch [/] in Open Files")

-- Shortcut for searching your Neovim configuration files
map("<leader>sn", function()
	builtin.find_files { cwd = vim.fn.stdpath "config" }
end, "[S]earch [N]eovim files")
