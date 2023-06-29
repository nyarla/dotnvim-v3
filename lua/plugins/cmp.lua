return {
  "hrsh7th/nvim-cmp",
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
    "ray-x/cmp-treesitter",
    "zbirenbaum/copilot.lua",
    "zbirenbaum/copilot-cmp",
    {"tzachar/cmp-tabnine", build = "./install.sh"}
  },
  opts = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    local lspkindInitOpts = {
      symbol_map = {
        Copilot = "",
        TabNine = "",
        String = "",
        Error = ""
      }
    }

    local completionSources = {
      {name = "vim_lsp", priority = 99},
      {name = "treesitter", priority = 89},
      {name = "path", priority = 88},
      {name = "vsnip", priority = 79},
      {name = "buffer", priority = 78}
    }

    local useGitHubCopilot = vim.env["NVIM_USE_GITHUB_COPILOT"] == "1"
    local useTabNine = vim.env["NVIM_USE_TABNINE"] == "1"

    if useGitHubCopilot then
      table.insert(completionSources, 1, {name = "copilot", priority = 100})
      require("copilot").setup(
        {
          suggestion = {enabled = false},
          panel = {enabled = false},
          filetypes = {
            html = false,
            markdown = false,
            gitcommit = false,
            gitrebase = false
          }
        }
      )
      require("copilot_cmp").setup()
    elseif useTabNine then
      table.insert(completionSources, 1, {name = "cmp_tabnine", priority = 100})
      local tabnine = require("cmp_tabnine.config")
      tabnine:setup(
        {
          max_lines = 1000,
          max_num_results = 20,
          sort = true,
          run_on_every_keystroke = true,
          snippet_placeholder = "...",
          ignored_file_types = {
            "html",
            "markdown"
          },
          show_prediction_strength = false
        }
      )
    end

    local bufferKeyBindings = {
      ["<Up>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
      ["<Down>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
      ["<Left>"] = cmp.mapping.close(),
      ["<Right>"] = cmp.mapping.close(),
      ["<Tab>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
      ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
      ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true})
    }

    local cmdlineKeyBindings = {
      ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true})
    }

    lspkind.init(lspkindInitOpts)

    cmp.setup.cmdline(
      {"/", "?"},
      {
        mapping = cmp.mapping.preset.cmdline(cmdlineKeyBindings),
        sources = {
          {name = "treesitter", priority = 100},
          {name = "buffer", priority = 99}
        }
      }
    )

    cmp.setup.cmdline(
      {":"},
      {
        mapping = cmp.mapping.preset.cmdline(cmdlineKeyBindings),
        sources = cmp.config.sources(
          {
            {name = "cmdline"}
          },
          {
            {name = "path"}
          }
        )
      }
    )

    return {
      formatting = {
        fields = {"abbr", "menu", "kind"},
        format = lspkind.cmp_format(
          {
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "..."
          }
        ),
        before = function(entry, vim_item)
          if entry.source.name == "cmp_tabnine" then
            vim_item.kind = "TabNine"
          end

          return vim_item
        end
      },
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end
      },
      window = {
        completion = cmp.config.window.bordered({scrollbar = false}),
        documentation = cmp.config.window.bordered({scrollbar = false})
      },
      mapping = cmp.mapping.preset.insert(bufferKeyBindings),
      sources = cmp.config.sources(completionSources)
    }
  end
}
