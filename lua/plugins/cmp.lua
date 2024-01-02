local lib = require("lib/utils")
local SRCS = {
  -- common completer
  --
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-path",
  -- treesitter completer
  --
  "nvim-treesitter/nvim-treesitter",
  "ray-x/cmp-treesitter",
  -- lsp completer
  --
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/cmp-nvim-lsp",
  -- sinippet completer
  --
  "hrsh7th/vim-vsnip",
  "hrsh7th/cmp-vsnip",
}

local LLM = {
  ["tabnine"] = {
    { "tzachar/cmp-tabnine", build = "./install.sh" },
  },
  ["codeium"] = {
    {
      "Exafunction/codeium.nvim",
      dependencies = {
        "vim-lua/plenary.nvim",
      },
      config = function()
        require("codeium").setup({
          ["config_path"] = lib.Path("/.local/share/nvim/codeium/config"),
          ["bin_path"] = lib.Path("/.local/share/nvim/codeium/bin"),
        })
      end,
    },
  },
  ["copilot"] = {},
}

-- dependencies
--
local dependencies = {
  "nvim-lua/plenary.nvim",
  "onsails/lspkind.nvim",
}

lib.Merge(dependencies, SRCS)

lib.EnabledIf("tabnine", function()
  return lib.Merge(dependencies, LLM["tabnine"])
end)

lib.EnabledIf("codeium", function()
  return lib.Merge(dependencies, LLM["codeium"])
end)

lib.EnabledIf("copilot", function()
  return lib.Merge(dependencies, LLM["copilot"])
end)

-- configuration
--
return {
  "hrsh7th/nvim-cmp",
  dependencies = dependencies,
  opts = function()
    -- lib
    --
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    -- setup
    --
    require("mason").setup()
    require("mason-lspconfig").setup_handlers({
      function(server)
        require("lspconfig")[server].setup({
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })
      end,
      ["lua_ls"] = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        })
      end,
    })

    -- keybindings
    --
    local cmpBufferKeyBindings = {
      ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<Left>"] = cmp.mapping.close(),
      ["<Right>"] = cmp.mapping.close(),
      ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    }

    local cmpCmdlineKeyBindings = {
      ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    }

    -- options
    --
    local lspkindInitArgs = {
      symbol_map = {
        Codeium = "",
        Copilot = "",
        Error = "",
        String = "",
        TabNine = "",
      },
    }

    -- sources
    --
    local cmpCompletionSources = {
      -- 9x: lsp, treesitter
      { name = "nvim_lsp", priority = 81 },
      { name = "treesitter", priority = 80 },
      -- 8x: path
      { name = "path", priority = 79 },
      -- 7x; vsnip, buffer
      { name = "vsnip", priority = 69 },
      { name = "buffer", priority = 68 },
    }

    lib.EnabledIf("tabnine", function()
      table.insert(cmpCompletionSources, 1, { name = "cmp_tabnine", priority = 90 })
      require("cmp_tabnine.config"):setup({
        max_lines = 1000,
        max_num_results = 2,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "...",
        ignored_file_types = {
          "html",
          "markdown",
        },
      })
    end)

    lib.EnabledIf("codeium", function()
      table.insert(cmpCompletionSources, 1, { name = "codeium", priority = 90 })
    end)

    -- TODO: add configuration for GitHub Copilot
    -- lib.EnabledIf("copilot", function() end)

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(cmpCmdlineKeyBindings),
      sources = {
        { name = "treesitter", priority = 100 },
        { name = "buffer", priority = 99 },
      },
    })

    cmp.setup.cmdline({ ":" }, {
      mapping = cmp.mapping.preset.cmdline(cmpCmdlineKeyBindings),
      sources = cmp.config.sources({
        { name = "cmdline" },
      }, {
        { name = "path" },
      }),
    })

    -- configuration
    --
    lspkind.init(lspkindInitArgs)

    return {
      formatting = {
        fields = { "abbr", "menu", "kind" },
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        }),
        before = function(entry, vim_item)
          if entry.source.name == "cmp_tabnine" then
            vim_item.kind = "TabNine"
          end

          return vim_item
        end,
      },
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered({ scrollbar = false }),
        documentation = cmp.config.window.bordered({ scrollbar = false }),
      },
      mapping = cmp.mapping.preset.insert(cmpBufferKeyBindings),
      sources = cmp.config.sources(cmpCompletionSources),
    }
  end,
}
