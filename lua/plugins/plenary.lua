local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "plenary",
  src = lib.fetchFromGitHub({
    owner = "nvim-lua",
    repo = "plenary.nvim",
    rev = "f7adfc4b3f4f91aab6caebf42b3682945fbc35be",
  }),
})

return M
