return {
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})

      local ui = require('config.ui')
      local borders = { border = ui.borders }
      local lsp = vim.lsp
      local handlers = {
        ["textDocument/hover"] = lsp.with(lsp.handlers.hover, borders),
        ["txtdocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, borders),
      }

      local servers = {
        clangd = {},
        sourcekit = {
          root_dir = lspconfig.util.root_pattern(
            '.git',
            'Package.swift'
          ),
        },
        lspconfig.rust_analyzer.setup {}
      }

      for server, setup in pairs(servers) do
        setup.handlers = handlers
        lspconfig[server].setup(setup)
      end

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    end
  }
}
