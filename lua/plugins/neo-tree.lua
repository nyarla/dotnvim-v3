return {
  "nvim-neo-tree/neo-tree.nvim",
  tag = "2.55",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  lazy = false,
  init = function() 
    vim.g.neo_tree_remove_legacy_commands = 1
    vim.fn.sign_define("DiagnostivSignError", { text = "", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnostivSignError", { text = "", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnostivSignError", { text = "", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnostivSignError", { text = "", texthl = "DiagnosticSignHint" })
  end,
  opts = function()
    return {
      close_if_last_window = false,
      source_selector = {
        winbar = true,
      },

      window = {
        width = 30,
        filesystem = {
          follow_current_file = true,
          hijack_netrw_behavior = "open_current",
          use_libuv_file_watcher = true,
        },
      },
    }
  end,
}
