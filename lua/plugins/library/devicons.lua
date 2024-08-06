local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "nvim-web-devicons",
  src = fetchFromGitHub({
    owner = "nvim-tree",
    repo = "nvim-web-devicons",
    rev = "3722e3d1fb5fe1896a104eb489e8f8651260b520",
  }),
})
