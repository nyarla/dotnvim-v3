local function assign(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

local g = vim.g

g.kalaclista = {
  colors = {
    light = {
      foreground = "#000000",
      background = "#f8f8f8",
      blue = "#006699",
      cyan = "#009999",
      green = "#669900",
      magenta = "#996699",
      red = "#cc3300",
      yellow = "#996600",
      gray = "#999999"
    },
    dark = {
      foreground = "#f8f8f8",
      background = "#000000",
      gray = "#333333",
      blue = "#00ccff",
      cyan = "#00cccc",
      green = "#ccff00",
      magenta = "#cc99cc",
      red = "#ff6633",
      yellow = "#ffcc33"
    }
  }
}

if vim.fn.exists("syntax_on") then
  vim.cmd.syntax("reset")
end

g.color_name = "kalaclista"

local l = g.kalaclista.colors.light
local d = g.kalaclista.colors.dark

-- terminal
g.terminal_color_0 = d.background
g.terminal_color_1 = d.red
g.terminal_color_2 = d.green
g.terminal_color_3 = d.yellow
g.terminal_color_4 = d.blue
g.terminal_color_5 = d.magenta
g.terminal_color_6 = d.cyan
g.terminal_color_7 = d.foreground
g.terminal_color_8 = l.gray
g.terminal_color_9 = l.red
g.terminal_color_10 = l.green
g.terminal_color_11 = l.yellow
g.terminal_color_12 = l.blue
g.terminal_color_13 = l.magenta
g.terminal_color_14 = l.cyan
g.terminal_color_15 = l.background

-- msg
assign("Normal", {fg = d.foreground, bg = d.background})
assign("Bold", {bold = true})
assign("Directory", {fg = d.cyan})
assign("NonText", {fg = d.gray, bold = true})
assign("SpecialKey", {fg = d.cyan, bold = true})
assign("EndOfBuffer", {fg = l.gray})

-- UI
assign("MoreMsg", {fg = d.green, bold = true})
assign("ModeMsg", {fg = d.blue, bold = true})
assign("Question", {fg = d.blue, bold = true})
assign("MatchParen", {bold = true, underline = true, reverse = true})
assign("Error", {fg = d.frground, bg = d.red, bold = true})
assign("ErrorMsg", {fg = d.forground, bg = d.red, bold = true})
assign("WarningMsg", {fg = d.yellow, bg = d.background, bold = true})

assign("Cursor", {fg = d.background, bg = d.blue, bold = true})
assign("Visual", {fg = d.background, bg = d.blue})

assign("LineNr", {fg = l.gray, bg = d.backgtound})
assign("LineNrAbove", {fg = l.gray, bg = d.backgtound})
assign("LineNrBelow", {fg = l.gray, bg = d.backgtound})

assign("CursorLine", {bg = d.gray})
assign("CursorLineNr", {fg = d.foreground, bg = l.blue})

assign("Search", {bold = true, underline = true})
assign("IncSearch", {bold = true, underline = true})

assign("VertSplit", {fg = l.background})
assign("SignColumn", {bg = d.background})

assign("Pmenu", {fg = d.foreground, bg = d.background})
assign("PmenuSel", {fg = l.background, bg = l.blue})
assign("PmenuSbar", {fg = l.gray, bg = d.background})
assign("PmenuThumb", {bold = true})

assign("StatusLine", {fg = d.forground, bg = d.background, bold = true})
assign("StatusLineNC", {fg = d.forground, bg = d.background})

-- syntax
assign("Title", {fg = d.foreground})
assign("Comment", {fg = l.gray})

assign("Constant", {fg = foregound})
assign("String", {fg = d.yellow})
assign("Character", {fg = d.blue})
assign("Number", {fg = d.green})
assign("Float", {fg = d.green})
assign("Boolean", {fg = d.green})

assign("Identifier", {fg = d.foreground, bold = true})
assign("Function", {fg = d.blue, bold = true})

assign("Statement", {fg = d.green})
assign("Operator", {bold = true})

assign("PreProc", {fg = d.yellow})
assign("Type", {fg = d.green})
assign("Special", {fg = d.magenta})

assign("Underlined", {underline = true})
assign("Ignore", {fg = d.gray})
assign("Todo", {fg = d.foreground, bg = d.yellow})

-- filetypes
assign("htmlTag", {fg = d.blue})
assign("htmlEndTag", {fg = d.blue})

assign("xmlTag", {fg = d.blue})
assign("xmlEndTag", {fg = d.blue})
assign("xmlTagName", {fg = d.green})

assign("yamlBool", {fg = d.blue})

assign("markdownHeadingDelimiter", {fg = d.green, bold = true})
assign("markdownUrl", {fg = d.blue})

assign("perlIdentifier", {fg = l.blue})

assign("luaMetaMethod", {fg = d.blue})
