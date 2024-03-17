local M = {}

M.INFO = vim.diagnostic.severity.INFO
M.WARN = vim.diagnostic.severity.WARN
M.ERROR = vim.diagnostic.severity.ERROR
M.HINT = vim.diagnostic.severity.HINT

function M.isJSON(src)
  if vim.startswith(src, "{") and not vim.startswith(src, "}") then
    return true
  end

  if vim.startswith(src, "[") and not vim.startswith(src, "]") then
    return true
  end

  return false
end

function M.fromJSON(src)
  return vim.json.decode(src)
end

function M.map(inputs, fn)
  local results = {}

  for _, result in ipairs(inputs) do
    table.insert(results, fn(result))
  end

  return results
end

function M.mkLinter(opts)
  local executable = assert(opts.executable, "`executable` required")
  local buildArgs = assert(opts.buildArgs, "`buildArgs` required")
  local parsePhase = assert(opts.parsePhase, "`parsePhase` required")
  local configurePhase = assert(opts.configurePhase, "`configurePhase` required")

  local cfg = configurePhase()
  cfg.cmd = executable
  cfg.args = buildArgs()
  cfg.parser = parsePhase

  return cfg
end

return M
