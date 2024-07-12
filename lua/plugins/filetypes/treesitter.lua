local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

local M = mkPlugin({
  pname = "nvim-treesitter",
  src = fetchFromGitHub({
    owner = "nvim-treesitter",
    repo = "nvim-treesitter",
    rev = "f197a15b0d1e8d555263af20add51450e5aaa1f0", -- v0.9.2
  }),

  buildHook = function(_)
    local dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
    if (vim.uv or vim.loop).fs_stat(dir) then
      vim.cmd({ cmd = "TSUpdate" })
    end
  end,

  configurePhase = function(_, opts)
    local configurator = require("nvim-treesitter.configs")

    configurator.setup({
      ensure_installed = "all",
      sync_install = false,
      ignore_install = {
        "perl", -- I use `vim-perl`
      },
      highlight = {
        enable = true,
        disable = { "perl" },
        additional_vim_regex_highlighting = true,
      },
    })
  end,

  dontLazy = true,
})

return M
