vim.api.nvim_create_autocmd(
  "BufWritePre",
  {
    pattern = {
      "*.css",
      "*.go",
      "*.html",
      "*.js",
      "*.json",
      "*.lua",
      "*.nix",
      "*.pl",
      "*.pm",
      "*.scss",
      "*.t",
      "*.ts",
      "*.xml",
      "*.yaml",
      "cpanfile"
    },
    callback = function(args)
      require("conform").format({bufnr = args.buf})
    end
  }
)

vim.api.nvim_create_user_command(
  "Format",
  function(args)
    local range = nil
    if args.count ~= -1 then
      local eol = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
      range = {
        start = {args.line1, 0},
        ["end"] = {args.line2, eol:len()}
      }
    end
    require("conform").format({async = true, lsp_fallback = true, range = range})
  end,
  {range = true}
)

return {
  "stevearc/conform.nvim",
  lazy = true,
  event = "BufWritePre",
  opts = {
    formatters_by_ft = {
      -- FIXME: switch to biome for web-related files
      css = {"prettier"},
      go = {{"goimports", "gofmt"}},
      html = {"prettier"},
      javascript = {"prettier"},
      javascriptreact = {"prettier"},
      json = {"perttier"},
      lua = {"luafmt"},
      nix = {"nixfmt"},
      perl = {"perltidy"},
      scss = {"prettier"},
      typescript = {"prettier"},
      typescriptreact = {"prettier"},
      yaml = {"preitter"}
    },
    formatters = {
      -- FIXME: switch to stylua
      luafmt = {
        command = "luafmt",
        args = {"--stdin", "-i", "2"},
        stdin = true
      }
    }
  }
}
