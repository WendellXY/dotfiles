return {
	{
		"wojciech-kulik/xcodebuild.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-tree.lua",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("xcodebuild").setup {
				commands = {
					extra_build_args = {
						"-parallelizeTargets",
					},
					extra_test_args = {
						"-parallel-testing-enabled",
					},
				},
			}
			local extension_path = vim.fn.expand "$MASON/packages/codelldb/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local xcodebuild_dap = require "xcodebuild.integrations.dap"
			xcodebuild_dap.setup(codelldb_path)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("xcodebuild-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						require("utils.keymap").set(keys, func, desc, mode, event)
					end
					map("<leader>vx", ":XcodebuildPicker<CR>", "Xcode Actions Picker")
				end,
			})
		end,
		cond = function()
			local xcodeproj = vim.fn.glob "*.xcodeproj"
			local xcworkspace = vim.fn.glob "*.xcworkspace"
			local swift_files = vim.fn.glob "*.swift"
			local package_swift = vim.fn.glob "Package.swift"
			local build_server = vim.fn.glob "buildServer.json"

			return xcodeproj ~= "" or xcworkspace ~= "" or swift_files ~= "" or package_swift ~= "" or build_server ~= ""
		end,
	},
}
