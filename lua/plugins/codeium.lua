local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "codeium",
  src = lib.fetchFromGitHub({
    owner = "Exafunction",
    repo = "codeium.nvim",
    rev = "cd5913ff5481229b15186293d1d46dd9500789f9",
  }),

  buildInputs = {
    "nvim-cmp",
    "plenary",
  },

  configurePhase = function()
    require("codeium").setup({
      ["config_path"] = vim.env.HOME .. "/.local/share/nvim/codeium/config",
      ["bin_path"] = vim.env.HOME .. "/.local/share/nvim/codeium/bin",
    })
  end,
})

return M
