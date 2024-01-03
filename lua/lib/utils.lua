local M = {}

M.HOME = vim.env.HOME

function M.Path(path)
  return M.HOME .. path
end

function M.Merge(dst, src)
  for _, val in ipairs(src) do
    table.insert(dst, val)
  end
end

function M.EnabledIf(feature, callback)
  local key = "NVIM_ENABLE_" .. string.upper(feature)

  if vim.env[key] == nil then
    return
  end

  if vim.env[key] == "0" or vim.env[key] == "false" then
    return
  end

  callback(vim.env[key])
end

return M
