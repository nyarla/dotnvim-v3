local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "cmp-vsnip",
  src = fetchFromGitHub({
    owner = "hrsh7th",
    repo = "cmp-vsnip",
    rev = "989a8a73c44e926199bfd05fa7a516d51f2d2752",
  }),

  buildInputs = { "vim-vsnip" },
})
