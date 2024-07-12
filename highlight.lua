require("kalaclista.options").setup()
require("kalaclista.colorscheme").setup()
require("kalaclista.lazy").setup()
require("kalaclista.plugins").setup({
  use = { "library", "ui", "filetype" },
})
vim.diagnostic.config({
  underline = false,
  virtual_text = false,
  float = false,
})
