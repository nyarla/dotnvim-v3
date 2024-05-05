local lib = require("lib.linters")

local function textlintrc()
  local path = vim.fn.expand("%:p")
  local paths = { "" }
  local config = ""

  for dir in string.gmatch(path, "[^/]+") do
    local rc = table.concat(paths, "/") .. "/.textlintrc"

    if vim.fn.filereadable(rc) == 1 then
      config = rc
      goto last
    end

    for _, extension in ipairs({ "cjs", "js", "json", "yaml", "yml" }) do
      local fn = table.concat(paths, "/") .. "/.textlintrc." .. extension

      if vim.fn.filereadable(fn) == 1 then
        config = fn
        goto last
      end
    end

    table.insert(paths, dir)
  end

  ::last::

  if config == "" then
    return ""
  end

  return "--config=" .. config
end

local function buildArgs()
  return { "--format=json", textlintrc }
end

local serevity = {
  lib.INFO,
  lib.WARN,
  lib.ERROR,
}

local M = lib.mkLinter({
  executable = "textlint",

  configurePhase = function()
    return {
      stream = "stdout",
      ignore_exitcode = false,
    }
  end,

  buildArgs = buildArgs,

  parsePhase = function(src)
    if vim.trim(src) == "" or src == nil then
      return {}
    end

    if not lib.isJSON(src) then
      return {}
    end

    local decoded = vim.json.decode(src)[1]
    local file = decoded.filePath
    local messages = decoded.messages

    local diagnostics = {}

    for _, msg in ipairs(messages) do
      if msg.type == "lint" then
        table.insert(diagnostics, {
          file = file,
          lnum = msg.loc.start.line - 1,
          end_lnum = msg.loc["end"].line - 1,
          col = msg.loc.start.column - 1,
          end_col = msg.loc["end"].column - 1,
          source = msg.ruleId,
          message = msg.message,
          severity = serevity[msg.severity + 1],
        })
      end
    end

    return diagnostics
  end,
})

return M
