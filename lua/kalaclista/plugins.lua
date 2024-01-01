require("lazy").setup(
  {
    -- filetype
    --
    require("plugins.nvim-treesitter"),
    require("plugins.vim-perl"),
    -- edtior
    --
    require("plugins.editorconfig"),
    require("plugins.conform"),
    require("plugins.cmp"),
    require("plugins.nvim-lint"),
    -- interface
    --
    require("plugins.neo-tree"),
    require("plugins.heirline")
  }
)
