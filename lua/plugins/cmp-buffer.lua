local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "cmp-buffer",
  src = lib.fetchFromGitHub({
    owner = "hrsh7th",
    repo = "cmp-buffer",
    rev = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
  }),

  buildInputs = { "nvim-cmp" },
})

return M
