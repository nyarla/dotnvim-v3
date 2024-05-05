local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "conform",
  src = lib.fetchFromGitHub({
    owner = "stevearc",
    repo = "conform.nvim",
    rev = "12b3995537f52ba2810a9857e8ca256881febbda",
  }),

  activatePhase = function()
    return {
      lazy = true,
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
    }
  end,

  configurePhase = function()
    return {
      init = function()
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = {
            -- Web
            -- ===
            -- documents
            "*.html",
            "*.md",
            "*.mdx",
            -- javascript / typescript
            "*.cjs",
            "*.js",
            "*.jsx",
            "*.mjs",
            "*.ts",
            "*.tsx",
            -- css / scss
            "*.css",
            "*.scss",
            -- Development
            -- ===========
            -- database
            "*.sql",
            -- languages
            "*.go",
            "*.lua",
            "*.pl",
            "*.pm",
            "*.t",
            -- Configuration
            -- =============
            "*.json",
            "*.nix",
            "*.toml",
            "*.yaml",
          },
          callback = function(args)
            require("conform").format({ bufnr = args.buf, timeout_ms = 10000 })
          end,
        })

        vim.api.nvim_create_user_command("Format", function(args)
          local range = nil
          if args.count ~= -1 then
            local eol = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
            range = {
              start = { args.line1, 0 },
              ["end"] = { args.line2, eol:len() },
            }
          end
          require("conform").format({ async = true, lsp_fallback = true, range = range })
        end, { range = true })
      end,
      opts = {
        formatters_by_ft = {
          -- Web
          -- ===
          html = { "prettier" },
          markdown = { "prettier" },

          javascript = { "biome" },
          javascriptreact = { "biome" },
          typescript = { "biome" },
          typescriptreact = { "biome" },

          css = { "prettier" },
          scss = { "prettier" },

          -- Development
          -- ===========
          -- database
          sql = { "sqlfluff" },

          -- languages
          go = { "goimports", "gofmt" },
          lua = { "stylua" },
          perl = { "perltidy" },

          -- Configuration
          -- =============
          json = { "biome" },
          nix = { "nixfmt" },
          toml = { "taplo" },
          yaml = { "prettier" },
        },
        formatters = {
          biome = {
            args = { "format", "--indent-style", "space", "--line-ending", "lf", "--stdin-file-path", "$FILENAME" },
          },
        },
      },
    }
  end,
})

return M
