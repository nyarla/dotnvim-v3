local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

local patterns = {
  -- web
  "*.html",
  "*.md",
  "*.mdx",

  "*.cjs",
  "*.js",
  "*.jsx",
  "*.mjs",
  "*.ts",
  "*.tsx",

  "*.css",
  "*.scss",

  -- db
  "*.sql",

  -- languages
  "*.go",
  "*.lua",
  "*.pl",
  "*.pm",
  "*.t",
  "cpanfile",

  -- data format
  "*.json",
  "*.nix",
  "*.toml",
  "*.yaml",
}

local formatAll = function(args)
  require("conform").format({ bufnr = args.buf, timeout_ms = 10000 })
end

local formatPartial = function(args)
  local range = nil
  if args.count ~= -1 then
    local eol = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, eol:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = patterns,
  callback = formatAll,
})

vim.api.nvim_create_user_command("Format", formatPartial, { range = true })

return mkPlugin({
  pname = "conform",
  src = fetchFromGitHub({
    owner = "stevearc",
    repo = "conform.nvim",
    rev = "cd75be867f2331b22905f47d28c0c270a69466aa",
  }),

  options = {
    formatters_by_ft = {
      -- web
      html = { "prettier" },
      markdown = { "prettier" },

      javascript = { "biome" },
      javascriptreact = { "biome" },
      typescript = { "biome" },
      typescriptreact = { "biome" },

      css = { "prettier" },
      scss = { "prettier" },

      -- db
      sql = { "sqlfluff" },

      -- language
      go = { "goimports", "gofmt" },
      lua = { "stylua" },
      perl = { "perltidy" },

      -- data format
      json = { "biome" },
      nix = { "nixfmt" },
      toml = { "talpo" },
      yaml = { "prettier" },
    },

    formatters = {
      biome = {
        args = {
          "format",
          "--indent-style",
          "space",
          "--line-ending",
          "lf",
          "--stdin-file-path",
          "$FILENAME",
        },
      },
    },
  },

  activators = {
    events = { "BufWritePre" },
    commands = { "ConformInfo", "Format" },
  },
})
