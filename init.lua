require("kalaclista.options").setup()
require("kalaclista.colorscheme").setup()
require("kalaclista.lazy").setup()
require("kalaclista.plugins").setup({
  use = { "library", "ui", "filetype", "editor", "completion" },
})
require("kalaclista.keymap").setup()
