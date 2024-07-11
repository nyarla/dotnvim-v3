local M = {}

--- The kind of plugin source.
--
---@alias kalaclistaPluginSrcKind
---| "git"
---| "local"

--- The data description of git soruce.
--
---@class kalaclistaPluginSrcGit
---@field url string The URL of git source
---@field rev string The revision of git
---@field fetchSubmodules? boolean To fetch with git submodules

--- The data description of GitHub source.
--
---@class kalaclistaPluginSrcGitHub
---@field owner string The owner of GitHub repository
---@field repo string The repository name on GitHub
---@field rev string The revision of git
---@field fetchSubmodules? boolean To fetch with git submodules

--- The data description of local path.
--
---@class kalaclistaPluginSrcLocal
---@field path string The path to local directory

---@alias kalaclistaPluginSrcData
---| kalaclistaPluginSrcGit
---| kalaclistaPluginSrcLocal

---@class kalaclistaPluginSrc
---@field kind kalaclistaPluginSrcKind The kind of source
---@field data kalaclistaPluginSrcData The data of source

--- The description to git plugin source.
--
---@param src kalaclistaPluginSrcGit The git src definition
---@return kalaclistaPluginSrc description The described git source
function M.fetchgit(src)
  return {
    kind = "git",
    data = src,
  }
end

--- The description to GitHub plugin source.
--
---@param src kalaclistaPluginSrcGitHub The description to GitHub resource
---@return kalaclistaPluginSrc description The described git source
function M.fetchFromGitHub(src)
  local owner = assert(src.owner, "You should specify GitHub username as `owner`")
  local repo = assert(src.repo, "You should specify GitHub repository name as `repo`")
  local rev = src.rev ~= nil and src.rev or "HEAD"

  local url = "https://github.com/" .. owner .. "/" .. repo .. ".git"

  local description = {
    kind = "git",
    data = {
      url = url,
      rev = rev,
    },
  }

  return description
end

--- The description to local plugin source.
--
---@param path string The local path of plugin source
---@return kalaclistaPluginSrc description The described local source
function M.localFrom(path)
  return {
    kind = "local",
    data = {
      path = path,
    },
  }
end

return M
