return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "html",
      "css",
      "swift",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
}

