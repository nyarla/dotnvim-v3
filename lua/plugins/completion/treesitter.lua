local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "cmp-treesitter",
  src = fetchFromGitHub({
    owner = "ray-x",
    repo = "cmp-treesitter",
    rev = "958fcfa0d8ce46d215e19cc3992c542f576c4123",
  }),

  buildInputs = { "nvim-treesitter" },
})
