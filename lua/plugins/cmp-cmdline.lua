local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "cmp-cmdline",
  src = lib.fetchFromGitHub({
    owner = "hrsh7th",
    repo = "cmp-cmdline",
    rev = "d250c63aa13ead745e3a40f61fdd3470efde3923",
  }),

  buildInputs = { "nvim-cmp" },
})

return M
