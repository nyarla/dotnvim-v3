local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

local M = mkPlugin({
  pname = "nvim-lint",
  src = fetchFromGitHub({
    owner = "mfussenegger",
    repo = "nvim-lint",
    rev = "efc6fc83f0772283e064c53a8f9fb5645bde0bc0",
  }),

  activators = {
    events = { "InsertEnter", "BufWritePost", "TextChanged" },
  },

  configurePhase = function()
    local plugin = require("lint")

    plugin.linters_by_ft = {
      dockerfile = { "hadolint" },
      markdown = { "textlint" },
      nix = { "statix", "deadnix" },
    }

    -- FIXME: to use `lib.linter.mkLinter`
    plugin.linters.textlint = require("lib.linters.textlint")
  end,
})

return M
