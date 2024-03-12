local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "cmp-path",
  src = lib.fetchFromGitHub({
    owner = "hrsh7th",
    repo = "cmp-path",
    rev = "91ff86cd9c29299a64f968ebb45846c485725f23",
  }),

  buildInputs = { "nvim-cmp" },
})

return M
