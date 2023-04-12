return {
  "rebelot/heirline.nvim",
  dependences = {
    "nvim-tree/nvim-web-devicons"
  },
  lazy = false,
  opts = function()
    local utils = require("heirline.utils")
    local conditions = require("heirline.conditions")

    local colors = {
      bright = "#f8f8f8",
      dark = "#000000",
      gray = "#999999",
      darkgray = "#222222",
      blue = "#00ccff",
      cyan = "#00cccc",
      green = "#ccff00",
      magenta = "#cc99cc",
      red = "#ff6633",
      yellow = "#ffcc33"
    }

    -- tabline
    --

    local buttonFileManager = {
      provider = " ",
      hl = "HeirlineButtonFileManager",
      on_click = {
        name = "openFileManager",
        callback = function()
          vim.cmd("Neotree toggle")
        end
      }
    }

    local buttonTerminal = {
      provider = " ",
      hl = "HeirlineButtonTerminal",
      on_click = {
        name = "openTerminalonNewTab",
        callback = function()
          vim.cmd("tabnew | terminal")
        end
      }
    }

    local buttonNewTab = {
      provider = " ",
      hl = "HeirlineButtonNewTab",
      on_click = {
        name = "openNewTab",
        callback = function()
          vim.cmd("tabnew")
        end
      }
    }

    local tabPage = {
      provider = function(self)
        return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
      end,
      hl = function(self)
        if not self.is_active then
          return "TabLine"
        else
          return "TabLineSel"
        end
      end
    }

    local tabPages = {
      condition = function()
        return true
      end,
      utils.make_tablist(tabPage),
      {provider = "%=%999X%X", hl = "TabLineClose"}
    }

    local globalTabline = {
      buttonFileManager,
      buttonTerminal,
      buttonNewTab,
      tabPages
    }

    -- statusline
    --

    local function is_active()
      return tonumber(vim.g.actual_curwin) == vim.api.nvim_get_current_win()
    end

    local function is_file()
      return not (vim.bo.filetype == "neo-tree" or vim.bo.buftype == "terminal")
    end

    local editorMode = {
      provider = function(self)
        return self.symbol
      end,
      init = function(self)
        self.mode = vim.fn.mode(1)

        if vim.fn.isdirectory("/Users") == 1 then
          self.symbol = "  "
        elseif vim.fn.isdirectory("/etc/nixos") == 1 then
          self.symbol = "  "
        elseif vim.fn.isdirectory("/mnt/c") == 1 then
          self.symbol = "  "
        else
          self.symbol = "  "
        end
      end,
      condition = is_file,
      static = {
        mode_colors = {
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
        },
        hl = function(self)
          return {bg = self.mode_colors[self.mode], fg = colors.dark}
        end
      }
    }

    local specialMode = {
      static = {
        filetype = {
          ["neo-tree"] = {
            symbol = "  ",
            color = colors.yellow
          }
        },
        buftype = {
          ["terminal"] = {
            symbol = "  ",
            color = colors.cyan
          }
        }
      },
      provider = function(self)
        return self.symbol
      end,
      hl = function(self)
        return {bg = self.color, fg = colors.dark}
      end,
      condition = function(self)
        local ft = vim.bo.filetype
        local bt = vim.bo.buftype
        local enabled = false

        local data = self.filetype[ft]
        if data ~= nil then
          self.symbol = data.symbol
          self.color = data.color

          enabled = true
        end

        data = self.buftype[bt]
        if data ~= nil then
          self.symbol = data.symbol
          self.color = data.color

          enabled = true
        end

        return enabled
      end
    }

    local filetype = {
      init = function(self)
        local icon, color = require "nvim-web-devicons".get_icon_color(vim.fn.bufname(), vim.bo.filetype)

        if icon ~= nil and color ~= nil then
          self.symbol = " " .. icon .. " "
          self.color = color
        else
          self.symbol = "  "
          self.color = colors.bright
        end
      end,
      condition = is_file,
      provider = function(self)
        return self.symbol
      end,
      hl = function(self)
        return {fg = self.color, bg = colors.darkgray}
      end
    }

    local filename = {
      condition = is_file,
      provider = function(self)
        local fullpath = vim.fn.expand("%:~:.")
        local cwd = vim.fn.getcwd()
        return ((fullpath:sub(0, #cwd) == cwd) and fullpath:sub(#cwd + 1) or fullpath) .. " "
      end,
      hl = {fg = colors.bright, bg = colors.darkgray}
    }

    local readonly = {
      condition = function()
        return is_file() and vim.bo.readonly
      end,
      provider = " ",
      hl = {fg = colors.yellow, bg = colors.darkgray}
    }

    local crlf = {
      condition = is_file,
      provider = function()
        local symbol = ""
        if vim.bo.fileformat == "unix" then
          symbol = "/ "
        elseif vim.bo.fileformat == "mac" then
          symbol = "/ "
        else
          symbol = "/ "
        end

        return symbol
      end,
      hl = {bg = colors.darkgray}
    }

    local ruler = {
      provider = " %l/%L",
      condition = is_file,
      hl = {bg = colors.darkgray}
    }

    local scroll = {
      condition = is_file,
      static = {
        bar = {"🭶", "🭷", "🭸", "🭹", "🭺", "🭻"}
      },
      provider = function(self)
        local cursor = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local idx = math.floor((cursor - 1) / lines * #self.bar) + 1

        return self.bar[idx]
      end,
      hl = {fg = colors.blue, bg = colors.darkgray}
    }

    local diagnostics = {
      condition = conditions.has_diagnostics,
      static = {
        icons = {
          error = " ",
          warn = " ",
          info = " ",
          hint = " "
        },
        diagnostic = function(self, level)
          return self.diag[level] > 0 and (self.icons[level] .. self.diag[level] .. " ")
        end
      },
      init = function(self)
        local diag = {
          error = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR}),
          warn = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN}),
          hints = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.HINT}),
          info = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.INFO})
        }

        self.diag = diag
      end,
      update = {"DiagnosticChanged", "BufEnter"},
      {
        provider = function(self)
          return self.diagnostic(self, "error")
        end,
        hl = {fg = colors.red, bg = colors.darkgray}
      },
      {
        provider = function(self)
          return self.diagnostic(self, "warn")
        end,
        hl = {fg = colors.yellow, bg = colors.darkgray}
      },
      {
        provider = function(self)
          return self.diagnostic(self, "hints")
        end,
        hl = {fg = colors.cyan, bg = colors.darkgray}
      },
      {
        provider = function(self)
          return self.diagnostic(self, "info")
        end,
        hl = {fg = colors.bright, bg = colors.darkgray}
      }
    }

    local modified = {
      condition = function()
        return vim.bo.modified
      end,
      provider = " "
    }

    local activeStatusLine = {
      condition = function()
        return is_active()
      end,
      editorMode,
      specialMode,
      scroll,
      filetype,
      modified,
      readonly,
      filename,
      crlf,
      {provider = "%="},
      ruler,
      diagnostics
    }

    local inactiveStatusLine = {
      condition = function()
        return not is_active()
      end,
      {
        provider = function(self)
          return string.rep("-", tonumber(vim.api.nvim_win_get_width(0)))
        end
      },
      hl = {fg = colors.bright}
    }

    local globalStatusline = {
      activeStatusLine,
      inactiveStatusLine
    }

    return {
      tabline = globalTabline,
      statusline = globalStatusline
    }
  end
}
