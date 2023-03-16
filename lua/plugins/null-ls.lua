return {
  "jose-elias-alvarez/null-ls.nvim",
  rev = "09e99259f4cdd929e7fb5487bf9d92426ccf7cc1",
  dependences = {
    "nvim-lua/plenary.nvim",
  },
  lazy = false,
  opts = function()
    local null_ls = require("null-ls")

    return {
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
        null_ls.builtins.diagnostics.textlint.with({ filetypes = { "markdown" } }),
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.diagnostics.zsh,
      }
    }
  end
}
