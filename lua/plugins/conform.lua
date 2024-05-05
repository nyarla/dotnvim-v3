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
            -- web
            "*.css",
            "*.html",
            "*.js",
            "*.jsx",
            "*.scss",
            "*.ts",
            "*.tsx",
            -- sql
            "*.sql",
            -- languages
            "*.go",
            "*.lua",
            "*.pl",
            "*.pm",
            "*.t",
            -- data structures
            "*.json",
            "*.nix",
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
          -- web
          css = { "prettier" },
          scss = { "prettier" },
          html = { "prettier" },

          javascript = { "biome" },
          javascriptreact = { "biome" },
          typescript = { "biome" },
          typescriptreact = { "biome" },

          markdown = { "prettier" },
          -- sql
          sql = { "sqlfluff" },

          -- languages
          go = { "goimports", "gofmt" },
          lua = { "stylua" },
          perl = { "perltidy" },

          -- data structures
          json = { "biome" },
          nix = { "nixfmt" },
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
