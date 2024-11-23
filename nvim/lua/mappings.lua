require "nvchad.mappings"

-- Unmap Default Keybindings

local del = vim.keymap.del

del("n", "<Leader>/")
del("v", "<Leader>/")

del("n", "<Leader>n")
del("n", "<Leader>rn")

del("n", "<C-n>")
del("n", "<leader>e")
-- Set Keybindings

local map = vim.keymap.set

-- Sidebar
map("n", "<D-0>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
map("n", "<D-1>", "<cmd>NvimTreeFocus<CR>", { desc = "nvimtree focus window" })
-- Comments
map("n", "<D-/>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<D-/>", "gc", { desc = "toggle comment", remap = true })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Nvim DAP
map("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
map("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
map("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
map("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
map("n", "<Leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = "Debugger toggle breakpoint" })
map(
  "n",
  "<Leader>dd",
  "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  { desc = "Debugger set conditional breakpoint" }
)
map("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
map("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- rustaceanvim
map("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })

map("n", "gd", "<cmd>Telescope lsp_definitions trim_text=true<cr>", { desc = "Show LSP definitions" })
