return {
  "jose-elias-alvarez/null-ls.nvim",
  dependences = {
    "nvim-lua/plenary.nvim",
  },
  lazy = false,
  opts = function()
    local null_ls = require("null-ls")

    vim.api.nvim_set_option("updatetime", 500)

    local id = vim.api.nvim_create_augroup("diagnostic-popup", { clear = true })
    vim.api.nvim_create_autocmd({ "CursorHold" }, {
      group = id,
      callback = function()
        if vim.lsp.buf.server_ready() then
          vim.diagnostic.open_float({
            border = "rounded",
          })
        end
      end,
    })

    return {
      debug = true,
      sources = {
        -- diagnostics
        null_ls.builtins.code_actions.statix,
        null_ls.builtins.diagnostics.deadnix,
        null_ls.builtins.diagnostics.editorconfig_checker,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.luacheck,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.diagnostics.statix,
        null_ls.builtins.diagnostics.textlint.with({ filetypes = { "markdown" }, timeout = 10000 }),
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.zsh,
      },
    }
  end,
}
