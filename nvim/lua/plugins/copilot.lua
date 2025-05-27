return {
	{
		"zbirenbaum/copilot.lua",
		lazy = true,
		event = "InsertEnter",
		enabled = true,
		opts = {
			panel = {
				enabled = false,
				-- auto_refresh = true,
			},
			suggestion = {
				enabled = false,
				-- auto_trigger = true,
				-- hide_during_completion = true,
				-- keymap = {
				-- 	accept = "<C-y>",
				-- 	accept_word = false,
				-- 	accept_line = false,
				-- 	next = false,
				-- 	prev = false,
				-- 	dismiss = false,
				-- },
			},
			filetypes = { ["*"] = true },
		},
		config = function(_, opts)
			require("copilot").setup(opts)

			-- hide copilot suggestions when cmp menu is open
			-- to prevent odd behavior/garbled up suggestions
			-- local cmp_status_ok, cmp = pcall(require, "cmp")
			-- if cmp_status_ok then
			-- 	cmp.event:on("menu_opened", function()
			-- 		vim.b.copilot_suggestion_hidden = true
			-- 	end)
			--
			-- 	cmp.event:on("menu_closed", function()
			-- 		vim.b.copilot_suggestion_hidden = false
			-- 	end)
			-- end
		end,
	},
}
