require("kalaclista.options")
require("kalaclista.colorscheme")

require("lazy").setup(
  {
    require("plugins.treesitter")
  }
)

local set = vim.opt

set.autoindent = true
set.expandtab = true
set.number = false
set.shiftwidth = 2
set.softtabstop = 2
set.tabstop = 4

vim.cmd.colorscheme("kalaclista")
