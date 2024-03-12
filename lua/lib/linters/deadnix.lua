local lib = require("lib.linters")

local M = lib.mkLinter({
  pname = "deadnix",
  executable = "deadnix",

  configurePhase = function()
    return {
      append_fname = true,
      stream = "stdout",
    }
  end,

  buildArgs = function()
    return { "--output-format=json" }
  end,

  parsePhase = function(output)
    if vim.trim(output) == "" or output == nil then
      return {}
    end

    if not lib.isJSON(output) then
      return {}
    end

    local decoded = lib.fromJSON(output)
    local file = decoded.file
    local results = decoded.results
    local diagnostics = lib.map(results, function(msg)
      return {
        file = file,
        lnum = msg.line - 1,
        col = msg.column - 1,
        end_col = msg.endColumn - 1,
        message = msg.message,
        serverity = lib.WARN,
      }
    end)

    return diagnostics
  end,
})

return M
