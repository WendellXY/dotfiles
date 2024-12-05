return {
  "wojciech-kulik/xcodebuild.nvim",
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-tree.lua",
    "mfussenegger/nvim-dap",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("xcodebuild").setup {
      commands = {
        extra_build_args = {
          "-parallelizeTargets",
        },
        extra_test_args = {
          "-parallelizeTargets",
        },
      },
    }
    local mason_registry = require "mason-registry"
    local codelldb = mason_registry.get_package "codelldb"
    local extension_path = codelldb:get_install_path() .. "/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local xcodebuild_dap = require "xcodebuild.integrations.dap"
    xcodebuild_dap.setup(codelldb_path)
  end,
  cond = function()
    local xcodeproj = vim.fn.glob "*.xcodeproj"
    local xcworkspace = vim.fn.glob "*.xcworkspace"
    local swift_files = vim.fn.glob "*.swift"
    local package_swift = vim.fn.glob "Package.swift"
    local build_server = vim.fn.glob "buildServer.json"

    return xcodeproj ~= "" or xcworkspace ~= "" or swift_files ~= "" or package_swift ~= "" or build_server ~= ""
  end,
}
