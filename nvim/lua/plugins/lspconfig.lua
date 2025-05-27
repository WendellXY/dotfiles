---@diagnostic disable: missing-fields
return {
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		lazy = true,
		event = "LspAttach",
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup {
				vim.diagnostic.config { virtual_text = false },
			}
		end,
	},
	{ "mason-org/mason.nvim", opts = {} },
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {},
	},
}
