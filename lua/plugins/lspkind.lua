local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "lspkind",
  src = lib.fetchFromGitHub({
    owner = "onsails",
    repo = "lspkind.nvim",
    rev = "1735dd5a5054c1fb7feaf8e8658dbab925f4f0cf",
  }),
})

return M
