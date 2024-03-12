local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "cmp-nvim-lsp",
  src = lib.fetchFromGitHub({
    owner = "hrsh7th",
    repo = "cmp-nvim-lsp",
    rev = "5af77f54de1b16c34b23cba810150689a3a90312",
  }),

  buildInputs = { "nvim-lspconfig", "nvim-cmp" },
})

return M
