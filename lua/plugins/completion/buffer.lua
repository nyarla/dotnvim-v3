local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "cmp-buffer",
  src = fetchFromGitHub({
    owner = "hrsh7th",
    repo = "cmp-buffer",
    rev = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
  }),
})
