local lib = require("lib.plugins")

local M = lib.mkPlugin({
  pname = "codeium",
  src = lib.fetchFromGitHub({
    owner = "Exafunction",
    repo = "codeium.nvim",
    rev = "a070f57c0f54bd940436b94c8b679bcad5a48811",
  }),

  buildInputs = {
    "nvim-cmp",
    "plenary",
  },

  configurePhase = function()
    return {
      config = function()
        require("codeium").setup({
          ["config_path"] = vim.env.HOME .. "/.local/share/nvim/codeium/config",
          ["bin_path"] = vim.env.HOME .. "/.local/share/nvim/codeium/bin",
        })
      end,
    }
  end,
})

return M
