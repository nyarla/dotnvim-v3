require("lazy").setup({
  spec = {
    -- interface
    --
    require("plugins.heirline"),
    require("plugins.neo-tree"),

    -- filetype
    --require("plugins.nvim-treesitter"),
    require("plugins.vim-perl"),

    -- edtior
    --
    require("plugins.conform"),
    require("plugins.editorconfig"),
    require("plugins.nvim-lint"),

    -- completion
    --
    require("plugins.lspkind"),
    require("plugins.nvim-lspconfig"),
    require("plugins.plenary"),
    require("plugins.vim-vsnip"),

    require("plugins.nvim-cmp"),

    require("plugins.cmp-buffer"),
    require("plugins.cmp-cmdline"),
    require("plugins.cmp-nvim-lsp"),
    require("plugins.cmp-path"),
    --require("plugins.cmp-treesitter"),
    require("plugins.cmp-vsnip"),
    require("plugins.codeium"),
  },
  rocks = { enabled = false },
})
