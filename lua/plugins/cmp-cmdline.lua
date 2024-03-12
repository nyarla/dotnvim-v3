local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "cmp-cmdline",
  src = lib.fetchFromGitHub({
    owner = "hrsh7th",
    repo = "cmp-cmdline",
    rev = "8ee981b4a91f536f52add291594e89fb6645e451",
  }),

  buildInputs = { "nvim-cmp" },
})

return M
