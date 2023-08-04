return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      tag = "v1.5",
      config = function()
        require "window-picker".setup(
          {
            autoselect_one = true,
            include_current = true,
            show_prompt = false,
            filter_rules = {
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = {"neo-tree", "neo-tree-popup", "notify"},
                -- if the buffer type is one of following, the window will be ignored
                buftype = {"terminal", "quickfix"}
              }
            },
            fg_color = "#ffffff",
            current_win_hl_color = "#669900",
            other_win_hl_color = "#669900",
            selection_chars = "ABCDEF"
          }
        )
      end
    }
  },
  cmd = "Neotree",
  lazy = false,
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    vim.fn.sign_define("DiagnostivSignError", {text = "", texthl = "DiagnosticSignError"})
    vim.fn.sign_define("DiagnostivSignWarn", {text = "", texthl = "DiagnosticSignWarn"})
    vim.fn.sign_define("DiagnostivSignInfo", {text = "", texthl = "DiagnosticSignInfo"})
    vim.fn.sign_define("DiagnostivSignHint", {text = "", texthl = "DiagnosticSignHint"})
  end,
  opts = function()
    local cc = require("neo-tree.sources.filesystem.commands")

    return {
      close_if_last_window = false,
      source_selector = {
        winbar = true,
        sources = {
          {source = "filesystem", display_name = ""},
          {source = "buffers", display_name = "󰂮"},
          {source = "git_status", display_name = ""}
        },
        content_layout = "center"
      },
      filesystem = {
        follow_current_file = {enabled = true},
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        width = 30,
      }
    }
  end
}
