local M = {}

--- The function to parse JSON string.
--
---@param src string The string of JSON
---@return any? data The parsed data from JSON
function M.parse(src)
  local ok, data = pcall(vim.json.decode, src)

  if not ok then
    return nil
  end

  return data
end

--- The function for stringify data to JSON.
--
---@param data any The any data of lua
---@return string json The JSON string
function M.stringify(data)
  return vim.json.encode(data)
end

return M
