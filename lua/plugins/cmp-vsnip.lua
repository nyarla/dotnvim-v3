local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "cmp-vsnip",
  src = lib.fetchFromGitHub({
    owner = "hrsh7th",
    repo = "cmp-vsnip",
    rev = "989a8a73c44e926199bfd05fa7a516d51f2d2752",
  }),

  buildInputs = { "vim-vsnip", "nvim-cmp" },
})

return M
