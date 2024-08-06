local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "neo-tree",
  src = fetchFromGitHub({
    owner = "nvim-neo-tree",
    repo = "neo-tree.nvim",
    rev = "8c75e8a2949cd6cd35525799200a8d34471ee9eb",
  }),

  buildInputs = { "plenary", "nvim-web-devicons", "nui", "nvim-window-picker" },

  initialise = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    vim.fn.sign_define("DiagnostivSignError", { text = "", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnostivSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnostivSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnostivSignHint", { text = "", texthl = "DiagnosticSignHint" })
  end,

  options = {
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,

    default_component_configs = {
      indent = {
        with_expanders = true,
      },
    },

    window = {
      width = 30,
      mappings = {
        ["<2-LeftMouse>"] = function(state, callback)
          local cc = require("neo-tree.sources.common.commands")
          if vim.fn.winnr("$") == 1 then
            cc.open(state, callback)
          else
            cc.open_with_window_picker(state, callback)
          end
        end,
      },
    },

    source_selector = {
      winbar = true,
      sources = {
        { source = "filesystem", display_name = "" },
        { source = "buffers", display_name = "󰂮" },
        { source = "git_status", display_name = "" },
      },
      content_layout = "center",
    },
    filesystem = {
      follow_current_file = { enabled = true },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },

      window = {
        mappings = {
          ["<2-LeftMouse>"] = function(state, callback)
            local fs = require("neo-tree.sources.filesystem.commands")
            if vim.fn.winnr("$") == 1 then
              fs.open(state, callback)
            else
              fs.open_with_window_picker(state, callback)
            end
          end,
        },
      },
    },
  },
})
