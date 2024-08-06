local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "editorconfig",
  src = fetchFromGitHub({
    owner = "gpanders",
    repo = "editorconfig.nvim",
    rev = "5b9e303e1d6f7abfe616ce4cc8d3fffc554790bf",
  }),

  activators = {
    events = { "InsertEnter" },
  },
})
