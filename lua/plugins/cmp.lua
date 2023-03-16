return {
  "hrsh7th/nvim-cmp",
  rev = "feed47fd1da7a1bad2c7dca456ea19c8a5a9823a",
  dependencies = {
    "dmitmel/cmp-vim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/vim-vsnip",
    "mattn/vim-lsp-settings",
    "neovim/nvim-lspconfig",
    "onsails/lspkind.nvim",
    "prabirshrestha/vim-lsp",
    "ray-x/cmp-treesitter"
  },
  opts = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    local keybinds = {
      ["<Tab>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
      ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
      ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = true}),
      ["<Left>"] = cmp.mapping.abort(),
      ["<Right>"] = cmp.mapping.abort(),
      ["<Up>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
      ["<Down>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert})
    }

    cmp.setup.cmdline(
      {"/", "?"},
      {
        mapping = cmp.mapping.preset.cmdline(keybinds),
        sources = {
          {name = "buffer"}
        }
      }
    )

    cmp.setup.cmdline(
      ":",
      {
        mapping = cmp.mapping.preset.cmdline(keybinds),
        sources = cmp.config.sources(
          {
            {name = "path"}
          },
          {
            {name = "cmdline"}
          }
        )
      }
    )

    return {
      formatting = {
        fields = {"kind", "abbr", "menu"},
        format = lspkind.cmp_format(
          {
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "..."
          }
        )
      },
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
      },
      mapping = cmp.mapping.preset.insert(keybinds),
      sources = cmp.config.sources(
        {
          {name = "vim_lsp"},
          {name = "vsnip"},
          {name = "path"},
          {name = "treesitter"}
        },
        {
          {name = "buffer"}
        }
      )
    }
  end
}
