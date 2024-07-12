local M = {}

---@class kalaclistaLinterSpec
---@field pname string The name of described linter
---@field configurePhase fun(): table The configurator function to described linter
---@field parsePhase fun(string): table The parser function to parse string of linter command output
---@field buildArgs fun(): (string|fun(): string)[] The function to build arguments of linter command

--- The function to describe nvim-linter spec
--
---@param spec kalaclistaLinterSpec The spec of linters
---@return table linterSpec The spec of nvim-linter
function M.mkLinter(spec)
  local pname = assert(spec.pname, "You should specify `pname` to linter spec")
  local configurePhase = assert(spec.configurePhase, "You should specify `configurePhase` to linter spec as function")
  local parsePhase = assert(spec.parsePhase, "You should specify `parsePhase` to linter spec as function")
  local buildArgs = assert(spec.buildArgs, "You should specify `buildArgs` to spec as function")

  local config = configurePhase()
  config.args = buildArgs
  config.parser = parsePhase

  return {
    name = pname,
    config = config,
  }
end

return M
