local M = {}

function M.fetchFromGitHub(opts)
  local owner = assert(opts.owner, "fetchFromGitHub: argument `owner` is missing")
  local repo = assert(opts.repo, "fetchFromGitHub: argument `repo` is missing")
  local rev = assert(opts.rev, "fetchFromGitHub: argument `rev` is missing")

  return {
    url = "https://github.com/" .. owner .. "/" .. repo .. ".git",
    commit = rev,
  }
end

function M.mkPlugin(opts)
  local pname = assert(opts.pname, "mkPlugin: `pname` required")
  local src = assert(opts.src, "mkPlugin: `src` required")

  local plugin = {}

  -- name
  plugin.name = pname

  -- plugin source
  for k, v in pairs(src) do
    plugin[k] = v
  end

  if type(opts.buildInputs) == "table" then
    plugin.dependencies = {}
    for _, name in ipairs(opts.buildInputs) do
      table.insert(plugin.dependencies, require("plugins." .. name))
    end
  end

  if type(opts.activatePhase) == "function" then
    local cfg = opts.activatePhase()
    local keys = { "lazy", "enabled", "cond", "event", "cmd", "ft" }

    for _, k in ipairs(keys) do
      if cfg[k] ~= nil then
        plugin[k] = cfg[k]
      end
    end
  end

  if type(opts.configurePhase) == "function" then
    local cfg = opts.configurePhase()
    local keys = { "init", "opts", "config" }

    for _, k in ipairs(keys) do
      if cfg[k] ~= nil then
        plugin[k] = cfg[k]
      end
    end
  end

  if type(opts.buildPhase) == "function" then
    local cfg = opts.buildPhase()
    local keys = { "build" }

    for _, k in ipairs(keys) do
      if cfg[k] ~= nil then
        plugin[k] = cfg[k]
      end
    end
  end

  return plugin
end

return M
