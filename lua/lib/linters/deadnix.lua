return {
  cmd = "deadnix",
  append_fname = true,
  args = {"--output-format=json"},
  stream = "stdout",
  parser = function(output, _)
    if vim.trim(output) == "" or output == nil then
      return {}
    end

    if not vim.startswith(output, "{") then
      return {}
    end

    local decoded = vim.json.decode(output)

    local file = decoded.file
    local results = decoded.results

    local diagnostics = {}
    for _, msg in ipairs(results) do
      table.insert(
        diagnostics,
        {
          file = file,
          lnum = msg.line - 1,
          col = msg.column - 1,
          end_col = msg.endColumn - 1,
          message = msg.message,
          severity = vim.diagnostic.severity.WARN
        }
      )
    end

    return diagnostics
  end
}
