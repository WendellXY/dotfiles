return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "c",
      "lua",
      "nu",
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
