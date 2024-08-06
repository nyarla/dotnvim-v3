local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "cmp-nvim-lsp",
  src = fetchFromGitHub({
    owner = "hrsh7th",
    repo = "cmp-nvim-lsp",
    rev = "39e2eda76828d88b773cc27a3f61d2ad782c922d",
  }),

  buildInputs = { "nvim-lspconfig" },
})
