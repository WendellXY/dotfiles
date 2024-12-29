-- Helper function for setting keymaps
local function map(mode, key, command, desc)
	vim.keymap.set(mode, key, command, { desc = desc })
end

-- File Management Keymaps
map('n', '<C-n>', ':Neotree toggle<CR>', 'Toggle Neo-tree')
map('n', '<leader>nf', '::Neotree focus<CR>', 'Focus Neo-tree')

