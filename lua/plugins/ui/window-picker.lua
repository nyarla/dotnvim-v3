local mkPlugin = require("lib.plugin").mkPlugin
local fetchFromGitHub = require("lib.src").fetchFromGitHub

return mkPlugin({
  pname = "nvim-window-picker",
  src = fetchFromGitHub({
    owner = "s1n7ax",
    repo = "nvim-window-picker",
    rev = "41cfaa428577c53552200a404ae9b3a0b5719706",
  }),
  options = {
    autoselect_one = true,
    include_current = true,
    show_prompt = false,
    filter_rules = {
      -- filter using buffer options
      bo = {
        -- if the file type is one of following, the window will be ignored
        filetype = { "neo-tree-popup", "notify" },
        -- if the buffer type is one of following, the window will be ignored
        buftype = { "terminal", "quickfix" },
      },
    },
    fg_color = "#ffffff",
    current_win_hl_color = "#669900",
    other_win_hl_color = "#669900",
    selection_chars = "ABCDEF",
  },
})
