local HOME = vim.env["HOME"]

local options = {
  opt = {
    -- script encoding
    encoding = "utf-8",
    fileencoding = "utf-8",
    -- ui
    ambiwidth = "double", -- fix it later
    cursorline = true,
    number = true,
    scl = "yes",
    termguicolors = true,
    showtabline = 2,
    -- cache and backup
    backupdir = HOME .. "/.cache/nvim/backup",
    directory = HOME .. "/.cache/nvim/swap",
    -- interactive
    clipboard = "unnamed,unnamedplus",
    mouse = "a",
    -- editor
    autoindent = true,
    backspace = "indent,eol,start",
    expandtab = true,
    shiftwidth = 2,
    softtabstop = 2,
    tabstop = 4,
    updatetime = 500,
  },
  g = {},
  t = {},
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end

vim.fn.setcellwidths({
  { 0x2500, 0x25FF, 1 },
  { 0xE000, 0xF800, 2 },
})

if vim.fn.isdirectory(HOME .. "/.local/share/nvim/mason/bin") then
  vim.env["PATH"] = vim.env["PATH"] .. ":" .. HOME .. "/.local/share/nvim/mason/bin"
end

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  pattern = "*",
  callback = function()
    vim.diagnostic.open_float()
  end,
})

vim.diagnostic.config({
  float = {
    scope = "line",
    border = "rounded",
  },
})
