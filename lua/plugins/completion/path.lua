local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "cmp-path",
  src = fetchFromGitHub({
    owner = "hrsh7th",
    repo = "cmp-path",
    rev = "91ff86cd9c29299a64f968ebb45846c485725f23",
  }),
})
