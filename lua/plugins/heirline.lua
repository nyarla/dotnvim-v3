return {
  "rebelot/heirline.nvim",
  dependences = {
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  opts = function()
    -- theme
    --
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
      yellow = "#ffcc33",
    }

    local theme = colors

    -- lib
    --
    local lib = require("heirline.utils")
    local cond = require("heirline.conditions")

    local iconinfo = require("nvim-web-devicons").get_icon_color

    local function is_active()
      return tonumber(vim.g.actual_curwin) == vim.api.nvim_get_current_win()
    end

    local function is_file()
      local file = true

      if file and vim.bo.filetype == "neo-tree" then
        file = false
      end

      if file and vim.bo.buftype == "terminal" then
        file = false
      end

      return file
    end

    local function get_os_symbol()
      local symbol = " "

      if vim.fn.isdirectory("/Users") == 1 then
        symbol = "  "
      elseif vim.fn.isdirectory("/etc/nixos") == 1 then
        symbol = "  "
      elseif vim.fn.isdirectory("/mnt/c") == 1 then
        symbol = "  "
      end

      return symbol
    end

    -- tabline
    --
    local toggleFileManager = {
      provider = " ",
      hl = "HeirlineToggleFileManager",
      on_click = {
        name = "toggleFileManager",
        callback = function()
          vim.cmd("Neotree toggle")
        end,
      },
    }

    local openTerminal = {
      provider = " ",
      hl = "HeirlineOpenTerminal",
      on_click = {
        name = "openNewTabAsTerminal",
        callback = function()
          vim.cmd("tabnew | terminal")
        end,
      },
    }

    local openNewTab = {
      provider = " ",
      hl = "HeirlineOpenNewTab",
      on_click = {
        name = "openNewTab",
        callback = function()
          vim.cmd("tabnew")
        end,
      },
    }

    local tablineTab = {
      provider = function(self)
        return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
      end,
      hl = function(self)
        if not self.is_active then
          return "TabLine"
        else
          return "TabLineSel"
        end
      end,
    }

    local tablineTabs = {
      condition = function()
        return true
      end,
      lib.make_tablist(tablineTab),
      { provider = "%=%999X%X", hl = "TabLineClose" },
    }

    local heirlineTabline = {
      toggleFileManager,
      openTerminal,
      openNewTab,
      tablineTabs,
    }

    -- statusline
    --
    local statusEditorMode = {
      provider = function(self)
        return self.symbol
      end,
      init = function(self)
        self.mode = vim.fn.mode(1)
        self.symbol = get_os_symbol()
      end,
      condition = is_file,
      static = {
        mode_colors = {
          n = theme.blue,
          no = theme.gray,
          nov = theme.gray,
          ["no"] = theme.gray,
          --
          v = theme.green,
          V = theme.green,
          Vs = theme.green,
          [""] = theme.green,
          ["s"] = theme.green,
          s = theme.green,
          S = theme.green,
          [""] = theme.green,
          --
          i = theme.yellow,
          ic = theme.yellow,
          ix = theme.yellow,
          --
          R = theme.red,
          Rc = theme.red,
          Rvc = theme.red,
          Rvx = theme.red,
          Rx = theme.red,
          --
          c = theme.magenta,
          cv = theme.magenta,
          --
          r = theme.green,
          rm = theme.green,
          ["r?"] = theme.green,
          ["!"] = theme.green,
          --
          t = theme.cyan,
        },
        hl = function(self)
          return { bg = self.mode_colors[self.mode], fg = theme.dark }
        end,
      },
    }

    local statusSpecialMode = {
      static = {
        supported = {
          ["neo-tree"] = true,
          ["terminal"] = true,
        },
        data = {
          ["neo-tree"] = {
            symbol = "  ",
            color = theme.yellow,
          },
          ["terminal"] = {
            symbol = "  ",
            color = theme.cyan,
          },
        },
      },
      provider = function(self)
        return self.symbol
      end,
      hl = function(self)
        return { bg = self.color, fg = colors.dark }
      end,
      condition = function(self)
        local bo = vim.bo
        local enabled = false

        if not enabled and self.supported[bo.filetype] ~= nil then
          self.symbol = self.data[bo.filetype].symbol
          self.color = self.data[bo.filetype].color
          enabled = true
        end

        if not enabled and self.supported[bo.buftype] ~= nil then
          self.symbol = self.data[bo.buftype].symbol
          self.color = self.data[bo.buftype].color
          enabled = true
        end

        return enabled
      end,
    }

    local displayFiletype = {
      init = function(self)
        local icon, color = iconinfo(vim.fn.bufname(), vim.bo.filetype)

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
        return { fg = self.color, bg = colors.darkgray }
      end,
    }

    local displayFilename = {
      condition = is_file,
      provider = function()
        local fullpath = vim.fn.expand("%:~:.")
        local cwd = vim.fn.getcwd()

        return ((fullpath:sub(0, #cwd) == cwd) and fullpath:sub(#cwd + 1) or fullpath) .. " "
      end,
      hl = { fg = colors.bright, bg = colors.darkgray },
    }

    local statusReadonly = {
      condition = function()
        return is_file() and vim.bo.readonly
      end,
      provider = " ",
      hl = { fg = colors.yellow, bg = colors.darkgray },
    }

    local displayCRLF = {
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
      hl = { bg = colors.darkgray },
    }

    local ruler = {
      provider = " %l/%L",
      condition = is_file,
      hl = { bg = colors.darkgray },
    }

    local hasDiagnostics = {
      condition = cond.has_diagnostics,
      static = {
        icons = {
          error = " ",
          warn = " ",
          info = " ",
          hints = " ",
        },
        diagnostic = function(self, level)
          return self.diag[level] > 0 and (self.icons[level] .. self.diag[level] .. " ")
        end,
      },
      init = function(self)
        local diag = {
          error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }),
          warn = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }),
          hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT }),
          info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO }),
        }

        self.diag = diag
      end,
      update = { "DiagnosticChanged", "BufEnter" },
      {
        provider = function(self)
          return self.diagnostic(self, "error")
        end,
        hl = { fg = colors.red, bg = colors.darkgray },
      },
      {
        provider = function(self)
          return self.diagnostic(self, "warn")
        end,
        hl = { fg = colors.yellow, bg = colors.darkgray },
      },
      {
        provider = function(self)
          return self.diagnostic(self, "hints")
        end,
        hl = { fg = colors.cyan, bg = colors.darkgray },
      },
      {
        provider = function(self)
          return self.diagnostic(self, "info")
        end,
        hl = { fg = colors.bright, bg = colors.darkgray },
      },
    }

    local statusModified = {
      condition = function()
        return vim.bo.modified
      end,
      provider = " ",
    }

    local activeStatusLine = {
      condition = function()
        return is_active()
      end,
      statusEditorMode,
      statusSpecialMode,
      displayFiletype,
      statusModified,
      statusReadonly,
      displayFilename,
      displayCRLF,
      { provider = "%=" },
      ruler,
      hasDiagnostics,
    }

    local inactiveStatusLine = {
      condition = function()
        return not is_active()
      end,
      {
        provider = function(self)
          return string.rep("-", tonumber(vim.api.nvim_win_get_width(0)))
        end,
      },
      hl = { fg = colors.bright },
    }

    local heirlineStatusline = {
      activeStatusLine,
      inactiveStatusLine,
    }

    return {
      tabline = heirlineTabline,
      statusline = heirlineStatusline,
    }
  end,
}
