local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "nvim-lspconfig",
  src = lib.fetchFromGitHub({
    owner = "neovim",
    repo = "nvim-lspconfig",
    rev = "f4619ab31fc4676001ea05ae8200846e6e7700c7",
  }),
})

return M
