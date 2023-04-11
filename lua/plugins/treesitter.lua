return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  opts = {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = {"perl"},
    highlight = {
      enable = true,
      disable = {"perl"},
      additional_vim_regex_highlighting = true
    }
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end
}
