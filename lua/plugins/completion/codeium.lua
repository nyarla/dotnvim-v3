local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "codeium",
  src = fetchFromGitHub({
    owner = "Exafunction",
    repo = "codeium.nvim",
    rev = "f6a2ef32a9e923cb0104a19d3e426b0e40e49505",
  }),
})
