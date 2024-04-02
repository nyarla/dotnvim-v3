local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "plenary",
  src = lib.fetchFromGitHub({
    owner = "nvim-lua",
    repo = "plenary.nvim",
    rev = "8aad4396840be7fc42896e3011751b7609ca4119",
  }),
})

return M
