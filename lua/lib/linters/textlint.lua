local serevity = {
  vim.diagnostic.severity.INFO,
  vim.diagnostic.severity.WARN,
  vim.diagnostic.severity.ERROR,
}

local extensions = {
  "cjs",
  "js",
  "json",
  "yaml",
  "yml",
}

return {
  cmd = "textlint",
  append_fname = true,
  args = {
    "--format=json",
    function()
      local path = vim.fn.expand("%:p")
      local paths = { "" }
      local textlintrc = ""

      for dir in string.gmatch(path, "[^/]+") do
        local rc = table.concat(paths, "/") .. "/.textlintrc"

        if vim.fn.filereadable(rc) == 1 then
          textlintrc = rc
          break
        end

        for _, ext in ipairs(extensions) do
          local fn = table.concat(paths, "/") .. "/.textlintrc." .. ext

          if vim.fn.filereadable(fn) == 1 then
            textlintrc = fn
            break
          end
        end

        table.insert(paths, dir)
      end

      if textlintrc ~= "" then
        return "--config=" .. textlintrc
      end

      return ""
    end,
  },
  stream = "stdout",
  ignore_exitcode = true,
  parser = function(output, _)
    if vim.trim(output) == "" or output == nil then
      return {}
    end

    if not vim.startswith(output, "[") then
      return {}
    end

    local decoded = vim.json.decode(output)[1]

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
}
