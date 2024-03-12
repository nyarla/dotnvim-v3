local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "vim-vsnip",
  src = lib.fetchFromGitHub({
    owner = "hrsh7th",
    repo = "vim-vsnip",
    rev = "02a8e79295c9733434aab4e0e2b8c4b7cea9f3a9",
  }),
})

return M
