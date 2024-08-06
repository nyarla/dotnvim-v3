local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

mkPlugin({
  pname = "vim-vsnip",
  src = fetchFromGitHub({
    owner = "hrsh7th",
    repo = "vim-vsnip",
    rev = "7753ba9c10429c29d25abfd11b4c60b76718c438",
  }),
})
