local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

mkPlugin({
  pname = "lspkind",
  src = fetchFromGitHub({
    owner = "onsails",
    repo = "lspkind.nvim",
    rev = "cff4ae321a91ee3473a92ea1a8c637e3a9510aec",
  }),
})
