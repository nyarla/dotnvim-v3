local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "nvim-lint",
  src = lib.fetchFromGitHub({
    owner = "mfussenegger",
    repo = "nvim-lint",
    rev = "e824adb9bc01647f71e55457353a68f0f37f9931",
  }),

  activatePhase = function()
    return {
      lazy = true,
      event = "InsertEnter",
    }
  end,

  configurePhase = function()
    vim.api.nvim_create_autocmd({ "InsertEnter", "BufWritePost", "TextChanged" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })

    return {
      config = function()
        local plugin = require("lint")

        plugin.linters_by_ft = {
          dockerfile = { "hadolint" },
          markdown = { "textlint" },
          nix = { "statix", "deadnix" },
        }

        plugin.linters["deadnix"] = require("lib.linters.deadnix")

        return true
      end,
    }
  end,
})

return M
