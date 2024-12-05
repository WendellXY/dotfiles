return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "vimdoc",
      "html",
      "css",
      "gitignore",
      "json",
      "yaml",
      "toml",
      "markdown",
      "markdown_inline",

      "c",
      "lua",
      "nu",
      "vim",
      "swift",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
