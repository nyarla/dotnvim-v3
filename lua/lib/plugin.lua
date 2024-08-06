local M = {}

---@class kalaclistaPluginSpec
---@field pname string The plugin name
---@field src kalaclistaPluginSrc The description of plugin src
---@field dontLazy? boolean The plugin shoule not be lazy loading
---@field dontEnabled? boolean | fun(): boolean The plugin shoule not be enabled on some conditions
---@field dontLoad? boolean | fun(plugin): boolean The plugin shoule not be loaded on some conditions
---@field buildInputs? string[] The dependencies of plugin
---@field initialise? fun(plugin) This function called by initialization phase by lazy.nvim
---@field options? table
---@field configurePhase? fun(plugin, opts): boolean
---@field buildHook? fun(plugin)
---@field activators? table

--- The function to describe lazy.nvim specification
--
---@param spec kalaclistaPluginSpec The specification of plugin
---@return table lazySpec The LazySpec by lazy.nvim
function M.mkPlugin(spec)
  local lazySpec = {}

  lazySpec.name = assert(spec.pname, "You should specify a plugin name as `pname`")

  local src = assert(spec.src, "You should specify a plugin src as `src`")
  if src.kind == "git" then
    lazySpec.url = src.data.url
    lazySpec.commit = src.data.rev
    lazySpec.submodules = src.data.fetchSubmodules or false
  elseif src.kind == "local" then
    lazySpec.dir = src.data.path
  else
    error("Unsupported kind in src: " .. spec.pname .. ": " .. src.kind)
  end

  if spec.dontLazy ~= nil then
    lazySpec.lazy = not spec.dontLazy
  end

  if spec.dontEnabled ~= nil then
    if type(spec.dontEnabled) == "boolean" then
      lazySpec.enabled = not spec.dontEnabled
    elseif type(spec.dontEnabled) == "function" then
      lazySpec.enabled = function()
        return not spec.dontEnabled()
      end
    else
      error("Unsupported type in dontEnabled: " .. spec.pname .. ": " .. type(spec.dontEnabled))
    end
  end

  if spec.dontLoad ~= nil then
    if type(spec.dontLoad) == "boolean" then
      lazySpec.load = not spec.dontLoad
    elseif type(spec.dontLoad) == "function" then
      lazySpec.load = function(plugin)
        return not spec.dontLoad(plugin)
      end
    else
      error("Unsupported type in dontLoad: " .. spec.pname .. ": " .. type(spec.dontLoad))
    end
  end

  if spec.buildInputs ~= nil then
    lazySpec.dependencies = spec.buildInputs
  end

  if type(spec.initialise) == "function" then
    lazySpec.init = spec.initialise
  end

  if type(spec.options) == "table" then
    lazySpec.opts = spec.options
    lazySpec.config = true
  end

  if type(spec.configurePhase) == "function" then
    lazySpec.config = spec.configurePhase
  end

  if type(spec.buildHook) == "function" then
    lazySpec.build = spec.buildHook
  end

  if type(spec.activators) == "table" then
    if spec.activators.events ~= nil then
      lazySpec.event = spec.activators.events
    end

    if spec.activators.commands ~= nil then
      lazySpec.cmd = spec.activators.commands
    end

    if spec.activators.filetypes ~= nil then
      lazySpec.ft = spec.activators.filetypes
    end

    if spec.activators.keys ~= nil then
      lazySpec.key = spec.activators.keys
    end
  end

  return lazySpec
end

return M
