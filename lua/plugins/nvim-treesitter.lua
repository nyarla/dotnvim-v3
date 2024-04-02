local lib = require("lib.plugins")
local M = lib.mkPlugin({
  pname = "nvim-treesitter",
  src = lib.fetchFromGitHub({
    owner = "nvim-treesitter",
    repo = "nvim-treesitter",
    rev = "d31eb5442deb4940a98b5573b78eb822b74fbcea",
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
