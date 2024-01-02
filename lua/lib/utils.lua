local HOME = vim.env["HOME"]

local Path = function(path)
  return HOME .. path
end

local Merge = function(dst, src)
  for _, val in ipairs(src) do
    table.insert(dst, val)
  end
end

local EnabledIf = function(feature, callback)
  local key = "NVIM_ENABLE_" .. string.upper(feature)

  if vim.env[key] == nil then
    return
  end

  env = vim.env[key]

  if env == "0" or env == "false" then
    return
  end

  callback(env)
  return
end

return {
  ["HOME"] = HOME,
  ["EnabledIf"] = EnabledIf,
  ["Merge"] = Merge,
  ["Path"] = Path,
}
