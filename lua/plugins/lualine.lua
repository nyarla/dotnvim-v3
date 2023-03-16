vim.cmd(
  [[
function! OpenNewTab(minwid, count, button, mod)
  if a:button == 'l'
    tabnew
  endif
endfunction

function! OpenNewTerminal(minwid, count, button, mod)
  if a:button == 'l'
    tabnew
    terminal
  endif
endfunction
]]
)
return {
  "nvim-lualine/lualine.nvim",
  rev = "e99d733e0213ceb8f548ae6551b04ae32e590c80",
  lazy = false,
  opts = function()
    local lualine = require("lualine")
    local theme = require("lualine.themes.auto")
    local colors = {
      bright = "#f8f8f8",
      dark = "#000000",
      gray = "#999999",
      blue = "#00ccff",
      cyan = "#00cccc",
      green = "#ccff00",
      magenta = "#cc99cc",
      red = "#ff6633",
      yellow = "#ffcc33"
    }

    local config = {
      options = {
        icons_enabled = true,
        theme = theme,
        component_separators = "",
        section_separators = ""
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {
        lualine_a = {
          {
            "%@OpenNewTerminal@%X",
            color = {fg = colors.cyan, bg = colors.dark},
            padding = {left = 1, right = 0}
          },
          {
            "%@OpenNewTab@%X",
            color = {fg = colors.bright, bg = colors.dark},
            padding = {left = 1, right = 0}
          }
        },
        lualine_b = {
          {
            "tabs",
            mode = 0,
            tabs_color = {
              active = {fg = colors.dark, bg = colors.blue},
              inactive = {fg = colors.dark, bg = colors.gray}
            }
          }
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      }
    }

    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      function()
        return "  "
      end,
      color = function()
        local mode_color = {
          n = colors.blue,
          no = colors.gray,
          nov = colors.gray,
          ["no"] = colors.gray,
          --
          v = colors.green,
          V = colors.green,
          Vs = colors.green,
          [""] = colors.green,
          ["s"] = colors.green,
          s = colors.green,
          S = colors.green,
          [""] = colors.green,
          --
          i = colors.yellow,
          ic = colors.yellow,
          ix = colors.yellow,
          --
          R = colors.red,
          Rc = colors.red,
          Rvc = colors.red,
          Rvx = colors.red,
          Rx = colors.red,
          --
          c = colors.magenta,
          cv = colors.magenta,
          --
          r = colors.green,
          rm = colors.green,
          ["r?"] = colors.green,
          ["!"] = colors.green,
          --
          t = colors.cyan
        }

        return {bg = mode_color[vim.fn.mode()], fg = colors.dark}
      end,
      padding = 0
    }

    ins_left {
      "filename",
      cond = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 and vim.bo.filetype ~= "neo-tree"
      end,
      file_status = true,
      path = 1,
      symbols = {
        modified = " ",
        readonly = " ",
        unnamed = " "
      },
      padding = {left = 1}
    }

    ins_left {
      function()
        return ""
      end,
      cond = function()
        return vim.bo.filetype ~= ""
      end,
      padding = {left = 1},
      color = {fg = colors.gray}
    }

    ins_left {
      "filetype",
      colors = true,
      padding = {right = 1}
    }

    ins_left {
      function()
        return ""
      end,
      cond = function()
        return vim.bo.filetype ~= ""
      end,
      padding = 0,
      color = {fg = colors.gray}
    }

    ins_right {
      "fileformat",
      cond = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 and vim.bo.filetype ~= "NvimTree"
      end,
      symbols = {
        unix = "LF",
        dos = "CRLF",
        mac = "CR"
      }
    }

    ins_right {
      "location"
    }

    ins_right {
      "diagnostics",
      sources = {"vim_lsp"},
      symbols = {error = "", warn = "", info = ""},
      diagnostics_color = {
        error = {fg = colors.red},
        warn = {fg = colors.yellow},
        info = {fg = colors.cyan}
      }
    }
    return config
  end
}
