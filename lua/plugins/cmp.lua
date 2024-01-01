local HOME = vim.env["HOME"]

local sources = {
  ["common"] = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path"
  },
  ["treesitter"] = {
    "nvim-treesitter/nvim-treesitter",
    "ray-x/cmp-treesitter"
  },
  ["snippet"] = {
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-vsnip"
  },
  ["llm"] = {
    ["TabNine"] = {
      {"tzachar/cmp-tabnine", build = "./install.sh"}
    },
    ["CodeiumAI"] = {
      {
        "Exafunction/codeium.nvim",
        dependencies = {
          "vim-lua/plenary.nvim"
        },
        config = function()
          require("codeium").setup(
            {
              ["config_path"] = HOME .. "/Applications/Development/codeium/config",
              ["bin_path"] = HOME .. "/Applications/Development/codeium/bin"
            }
          )
        end
      }
    },
    ["GitHubCopilot"] = {}
  }
}

local dependencies = {
  "nvim-lua/plenary.nvim",
  "onsails/lspkind.nvim"
}

for _, src in ipairs({"common", "treesitter", "snippet"}) do
  for _, dep in ipairs(sources[src]) do
    table.insert(dependencies, dep)
  end
end

local ENABLE_TABNINE = vim.env["NVIM_ENABLE_TABNINE"] == "1"
local ENABLE_GITHUB_COPILOT = vim.env["NVIM_ENABLE_GITHUB_COPILOT"] == "1"
local ENABLE_CODEIUM_AI = vim.env["NVIM_ENABLE_CODEIUM_AI"] == "1"

if ENABLE_TABNINE then
  table.insert(dependencies, sources["llm"]["TabNine"])
end

if ENABLE_GITHUB_COPILOT then
  table.insert(dependencies, sources["llm"]["GitHubCopilot"])
end

if ENABLE_CODEIUM_AI then
  table.insert(dependencies, sources["llm"]["CodeiumAI"])
end

return {
  "hrsh7th/nvim-cmp",
  dependencies = dependencies,
  opts = function()
    -- lib
    --
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    -- keybindings
    --
    local cmpBufferKeyBindings = {
      ["<Up>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
      ["<Down>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
      ["<Left>"] = cmp.mapping.close(),
      ["<Right>"] = cmp.mapping.close(),
      ["<Tab>"] = cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Insert}),
      ["<S-Tab>"] = cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Insert}),
      ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true})
    }

    local cmpCmdlineKeyBindings = {
      ["<CR>"] = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Insert, select = true})
    }

    -- options
    --
    local lspkindInitArgs = {
      symbol_map = {
        Codeium = "",
        Copilot = "",
        Error = "",
        String = "",
        TabNine = ""
      }
    }

    -- sources
    --
    local cmpCompletionSources = {
      -- 9x: lsp, treesitter
      -- {name = "vim_lsp", priority = 81},
      {name = "treesitter", priority = 80},
      -- 8x: path
      {name = "path", priority = 79},
      -- 7x; vsnip, buffer
      {name = "vsnip", priority = 69},
      {name = "buffer", priority = 68}
    }

    if ENABLE_TABNINE then
      table.insert(cmpCompletionSources, 1, {name = "cmp_tabnine", priority = 90})
      require("cmp_tabnine.config"):setup(
        {
          max_lines = 1000,
          max_num_results = 2,
          sort = true,
          run_on_every_keystroke = true,
          snippet_placeholder = "...",
          ignored_file_types = {
            "html",
            "markdown"
          }
        }
      )
    end

    if ENABLE_GITHUB_COPILOT then
    -- FIXME: configuration to GitHub Copilot
    end

    if ENABLE_CODEIUM_AI then
      table.insert(cmpCompletionSources, 1, {name = "codeium", priority = 90})
    end

    cmp.setup.cmdline(
      {"/", "?"},
      {
        mapping = cmp.mapping.preset.cmdline(cmpCmdlineKeyBindings),
        sources = {
          {name = "treesitter", priority = 100},
          {name = "buffer", priority = 99}
        }
      }
    )

    cmp.setup.cmdline(
      {":"},
      {
        mapping = cmp.mapping.preset.cmdline(cmpCmdlineKeyBindings),
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

    -- configuration
    --
    lspkind.init(lspkindInitArgs)

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
      mapping = cmp.mapping.preset.insert(cmpBufferKeyBindings),
      sources = cmp.config.sources(cmpCompletionSources)
    }
  end
}
