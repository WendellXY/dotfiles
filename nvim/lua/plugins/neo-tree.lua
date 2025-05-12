return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		local neo_tree = require "neo-tree"
		neo_tree.setup {
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					never_show = { ".DS_Store", "thumbs.db" },
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
			},
		}
	end,
}
