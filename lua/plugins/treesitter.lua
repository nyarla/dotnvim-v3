return {
  "nvim-treesitter/nvim-treesitter",
  rev = "cd436f92f65def9c7e74a7324d3eab422ef85643",
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
