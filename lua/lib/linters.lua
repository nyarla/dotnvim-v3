local M = {}

M.INFO = vim.diagnostic.severity.INFO
M.WARN = vim.diagnostic.severity.WARN
M.ERROR = vim.diagnostic.severity.ERROR

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

function M.mkWrapper(pname, executable, buildArgs)
  local nixrun = vim.env.HOME .. "/.config/nvim/pkgs/bin/nix-run"
  local args = {
    nixrun,
    "--package",
    pname,
    "--app",
    executable,
    "--",
  }

  for _, arg in ipairs(buildArgs()) do
    table.insert(args, arg)
  end

  return args
end

function M.mkLinter(opts)
  local pname = assert(opts.pname, "`pname` required")
  local executable = assert(opts.executable, "`executable` required")
  local buildArgs = assert(opts.buildArgs, "`buildArgs` required")
  local parsePhase = assert(opts.parsePhase, "`parsePhase` required")
  local configurePhase = assert(opts.configurePhase, "`configurePhase` required")

  local cfg = configurePhase()
  cfg.cmd = "bash"
  cfg.args = M.mkWrapper(pname, executable, buildArgs)
  cfg.parser = parsePhase

  return cfg
end

return M
