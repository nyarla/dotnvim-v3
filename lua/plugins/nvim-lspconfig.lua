local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "nvim-lspconfig",
  src = lib.fetchFromGitHub({
    owner = "neovim",
    repo = "nvim-lspconfig",
    rev = "1917b562a02f20885900b1da0f0ea25028ccedab",
  }),
})

return M
