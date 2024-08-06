local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "nui",
  src = fetchFromGitHub({
    owner = "MunifTanjim",
    repo = "nui.nvim",
    rev = "61574ce6e60c815b0a0c4b5655b8486ba58089a1",
  }),
})
