local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "cmp-treesitter",
  src = lib.fetchFromGitHub({
    owner = "ray-x",
    repo = "cmp-treesitter",
    rev = "13e4ef8f4dd5639fca2eb9150e68f47639a9b37d",
  }),

  buildInputs = { "nvim-treesitter", "nvim-cmp" },
})

return M
