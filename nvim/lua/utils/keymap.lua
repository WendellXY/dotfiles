local M = {}

function M.set(key, command, desc, mode, event)
	mode = mode or "n"
	if event == nil then
		vim.keymap.set(mode, key, command, { desc = desc })
	else
		vim.keymap.set(mode, key, command, { desc = desc, buffer = event.buffer })
	end
end

function M.del(key, mode)
	mode = mode or "n"
	vim.keymap.del(mode, key)
end

return M
