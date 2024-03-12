local lib = require("lib.linters")

local severity = {
  error = lib.ERROR,
  warning = lib.WARN,
  info = lib.INFO,
  hint = lib.HINT,
}

local M = lib.mkLinter({
  pname = "hadolint",
  executable = "hadolint",

  configurePhase = function()
    return {
      stdin = true,
      stream = "stdout",
      ignore_exitcode = true,
    }
  end,

  buildArgs = function()
    return { "--format", "json", "-" }
  end,

  parsePhase = function(src)
    if vim.trim(src) == "" or src == nil then
      return {}
    end

    if not lib.isJSON(src) then
      return {}
    end

    local decoded = lib.fromJSON(src)
    return lib.map(decoded, function(msg)
      return {
        file = msg.file,
        lnum = msg.line - 1,
        end_lnum = msg.line - 1,
        col = msg.column - 1,
        end_col = msg.column - 1,
        message = msg.message,
        serverity = severity[msg.level],
        code = msg.code,
        source = "hadolint",
      }
    end)
  end,
})

return M
