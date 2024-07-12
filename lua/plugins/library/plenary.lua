local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "plenary",
  src = fetchFromGitHub({
    owner = "nvim-lua",
    repo = "plenary.nvim",
    rev = "a3e3bc82a3f95c5ed0d7201546d5d2c19b20d683",
  }),
})
