local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "nvim-lspconfig",
  src = fetchFromGitHub({
    owner = "neovim",
    repo = "nvim-lspconfig",
    rev = "cf97d2485fc3f6d4df1b79a3ea183e24c272215e",
  }),
})
