return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configurator = require("nvim-treesitter.configs")

    configurator.setup(
      {
        ensure_installed = "all",
        sync_install = false,
        ignore_install = {"perl"},
        highlight = {
          enable = true,
          disable = {"perl"},
          additional_vim_regex_highlighting = true
        }
      }
    )
  end
}
