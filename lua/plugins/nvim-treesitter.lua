local lib = require("lib.plugins")
local M = lib.mkPlugin({
  pname = "nvim-treesitter",
  src = lib.fetchFromGitHub({
    owner = "nvim-treesitter",
    repo = "nvim-treesitter",
    rev = "883c72cddc34195a3b916905f6e61d789ddd3599",
  }),

  configurePhase = function()
    return {
      config = function()
        local configurator = require("nvim-treesitter.configs")

        configurator.setup({
          ensure_installed = "all",
          sync_install = false,
          ignore_install = { "perl" },
          highlight = {
            enable = true,
            disable = { "perl" },
            additional_vim_regex_highlighting = true,
          },
        })
      end,
    }
  end,

  buildPhase = function()
    return {
      build = ":TSUpdate",
    }
  end,
})

return M
