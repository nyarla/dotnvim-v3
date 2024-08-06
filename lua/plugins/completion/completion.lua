local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

local function useLSP(server, override)
  local lsp = require("lspconfig")
  override.capabilities = require("cmp_nvim_lsp").default_capabilities()
  return lsp[server].setup(override)
end

local M = mkPlugin({
  pname = "nvim-cmp",
  src = fetchFromGitHub({
    owner = "hrsh7th",
    repo = "nvim-cmp",
    rev = "ae644feb7b67bf1ce4260c231d1d4300b19c6f30",
  }),

  dontLazy = true,

  buildInputs = {
    "lspkind",

    "cmp-buffer",
    "cmp-cmdline",
    "codeium",
    "cmp-nvim-lsp",
    "cmp-path",
    "cmp-treesitter",
    "cmp-vsnip",
  },

  initialise = function()
    -- scripts / languages
    useLSP("bashls", {})
    useLSP("gopls", {})
    useLSP("lua_ls", {})
    useLSP("tsserver", {})

    useLSP("perlnavigator", {
      settings = {
        perlnavigator = {
          perlPath = "perl",
          enableWarnings = true,
          perlcriticEnabled = false,
        },
      },
    })

    -- web
    useLSP("tailwindcss", {})

    -- databases
    useLSP("sqls", {})

    --- config files
    useLSP("nixd", {})
    useLSP("taplo", {})
    useLSP("jsonls", {
      cmd = { "vscode-json-languageserver", "--stdio" },
    })
  end,

  configurePhase = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    --- key bindings
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
    local cmpCompletionSources = {
      { name = "codeium", priority = 99 },
      { name = "nvim_lsp", priority = 20 },
      { name = "treesitter", priority = 11 },
      { name = "vsnip", priority = 10 },
      { name = "path", prioirity = 1 },
      { name = "buffer", priority = 0 },
    }

    -- setup
    lspkind.init(lspkindInitArgs)

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(cmpCmdlineKeyBindings),
      sources = {
        { name = "treesitter", priotity = 100 },
        { name = "buffer", priotity = 99 },
      },
    })

    cmp.setup.cmdline({ ":" }, {
      mapping = cmp.mapping.preset.cmdline(cmpCmdlineKeyBindings),
      sources = {
        { name = "cmdline", priotity = 100 },
        { name = "path", priotity = 99 },
      },
    })

    cmp.setup({
      formatting = {
        fields = { "abbr", "menu", "kind" },
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
        }),
        before = function(_, vim_item)
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
    })

    return true
  end,
})

return M
