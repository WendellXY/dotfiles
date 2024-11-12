return {
  "wojciech-kulik/xcodebuild.nvim",
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("xcodebuild").setup {}
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
