require("kalaclista.options")
require("kalaclista.colorscheme")

require("lazy").setup(
  {
    require("plugins.treesitter")
  }
)

local set = vim.opt

set.number = false
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 2
set.softtabstop = 2
set.autoindent = true

vim.cmd.colorscheme("kalaclista")
