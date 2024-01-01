require("lazy").setup(
  {
    -- filetype
    --
    require("plugins.nvim-treesitter"),
    require("plugins.vim-perl"),
    -- edtior
    --
    require("plugins.editorconfig"),
    require("plugins.cmp"),
    require("plugins.neoformat"),
    require("plugins.null-ls"),
    -- interface
    --
    require("plugins.neo-tree"),
    require("plugins.heirline")
  }
)
