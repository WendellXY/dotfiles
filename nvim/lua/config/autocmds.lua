local autocmd = vim.api.nvim_create_autocmd

autocmd("QuitPre", {
  callback = function()
    -- Reset the cursor style on exit
    os.execute('printf "\\e[5 q" > $(tty)')
  end
})
