local lib = require("lib.linters")
local parser = require("lint.parser")

local M = lib.mkLinter({
  pname = "statix",
  executable = "statix",

  configurePhase = function()
    return {
      stdin = true,
      stream = "stdout",
      ignore_exitcode = true,
    }
  end,

  buildArgs = function()
    return {
      "check",
      "-o",
      "errfmt",
      "--stdin",
    }
  end,

  parsePhase = parser.from_errorformat("<stdin>>%l:%c:%t:%n:%m", {
    source = "statix",
  }),
})

return M
