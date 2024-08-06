local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "cmp-cmdline",
  src = fetchFromGitHub({
    owner = "hrsh7th",
    repo = "cmp-cmdline",
    rev = "d250c63aa13ead745e3a40f61fdd3470efde3923",
  }),
})
