local lib = require("lib.plugins")

local function useLSP(server, pkg, exe, args, override)
  local lsp = require("lspconfig")
  local cmd = {
    "bash",
    vim.env.HOME .. "/.config/nvim/pkgs/bin/nix-run",
    "--app",
    exe,
    "--paclage",
    pkg,
    "--",
  }

  for _, arg in ipairs(args) do
    table.insert(cmd, arg)
  end

  override.cmd = cmd
  override.capabilities = require("cmp_nvim_lsp").default_capabilities()

  return lsp[server].setup(override)
end

local M = lib.mkPlugin({
  pname = "nvim-cmp",
  src = lib.fetchFromGitHub({
    owner = "hrsh7th",
    repo = "nvim-cmp",
    rev = "04e0ca376d6abdbfc8b52180f8ea236cbfddf782",
  }),

  activatePhase = function()
    return {
      lazy = false,
    }
  end,

  configurePhase = function()
    return {
      init = function()
        useLSP("lua_ls", "lua-lsp", "lua-lsp", {}, {})
      end,
      opts = function()
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

        -- configuration
        return {
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
        }
      end,
    }
  end,
})

return M
