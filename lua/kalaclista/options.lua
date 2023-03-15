local HOME = vim.env["HOME"]

local options = {
  opt = {
    -- script encoding
    encoding = "utf-8",
    fileencoding = "utf-8",
    -- ui
    number = true,
    cursorline = true,
    termguicolors = true,
    ambiwidth = "double", -- fix it later
    scl = "yes",
    -- cache and backup
    directory = HOME .. "/.cache/nvim/swap",
    backupdir = HOME .. "/.cache/nvim/backup",
    -- interactive
    clipboard = "unnamed,unnamedplus",
    mouse = "a",
    -- editor
    expandtab = true,
    tabstop = 4,
    shiftwidth = 2,
    softtabstop = 2,
    autoindent = true,
    backspace = "indent,eol,start"
  },
  g = {},
  t = {}
}

for scope, table in pairs(options) do
  for setting, value in pairs(table) do
    vim[scope][setting] = value
  end
end
