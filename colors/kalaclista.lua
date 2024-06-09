local theme = {
  gray = {
    "#111111",
    "#1b1b1b",
    "#262626",
    "#303030",
    "#3b3b3b",
    "#474747",
    "#525252",
    "#5e5e5e",
    "#6a6a6a",
    "#777777",
    "#848484",
    "#919191",
    "#9e9e9e",
    "#ababab",
    "#b9b9b9",
    "#c6c6c6",
    "#d4d4d4",
    "#e2e2e2",
    "#f1f1f1",
  },
  light = {
    "#111111", -- black
    "#994235", -- red
    "#52650e", -- green
    "#7f5512", -- yellow
    "#4a5ba6", -- blue
    "#8b4487", -- magenta
    "#00706b", -- cyan
    "#f1f1f1", -- white
  },
  dark = {
    "#111111", -- black
    "#ff5661", -- red
    "#b0e300", -- green
    "#ffbf00", -- yellow
    "#5fc7ff", -- blue
    "#efa6ff", -- magenta
    "#00fff9", -- cyan
    "#f1f1f1", -- white
  },
}

local BLACK = { 1, theme.light[1], theme.dark[1] }
local RED = { 2, theme.light[2], theme.dark[2] }
local GREEN = { 3, theme.light[3], theme.dark[3] }
local YELLOW = { 4, theme.light[4], theme.dark[4] }
local BLUE = { 5, theme.light[5], theme.dark[5] }
local MAGENTA = { 6, theme.light[6], theme.dark[6] }
local CYAN = { 7, theme.light[7], theme.dark[7] }
local WHITE = { 8, theme.light[8], theme.dark[8] }

local GRAY50 = { 1, theme.gray[1], theme.gray[19] }
local GRAY100 = { 2, theme.gray[2], theme.gray[18] }
local GRAY150 = { 3, theme.gray[3], theme.gray[17] }
local GRAY200 = { 4, theme.gray[4], theme.gray[16] }
local GRAY250 = { 5, theme.gray[5], theme.gray[15] }
local GRAY300 = { 6, theme.gray[6], theme.gray[14] }
local GRAY350 = { 7, theme.gray[7], theme.gray[13] }
local GRAY400 = { 8, theme.gray[8], theme.gray[12] }
local GRAY450 = { 9, theme.gray[9], theme.gray[11] }
local GRAY500 = { 10, theme.gray[10], theme.gray[10] }
local GRAY550 = { 11, theme.gray[11], theme.gray[9] }
local GRAY600 = { 12, theme.gray[12], theme.gray[8] }
local GRAY650 = { 13, theme.gray[13], theme.gray[7] }
local GRAY700 = { 14, theme.gray[14], theme.gray[6] }
local GRAY750 = { 15, theme.gray[15], theme.gray[5] }
local GRAY800 = { 16, theme.gray[16], theme.gray[4] }
local GRAY850 = { 17, theme.gray[17], theme.gray[3] }
local GRAY900 = { 18, theme.gray[18], theme.gray[2] }
local GRAY950 = { 19, theme.gray[19], theme.gray[1] }

local LIGHT = 2
local DARK = 3
local MODE = vim.o.background == "light" and LIGHT or DARK
local INVERT = vim.o.background == "light" and DARK or LIGHT

local hi = function(name, opts, mode)
  local mode = mode or MODE

  local val = {}
  for k, v in pairs(opts) do
    if k == "fg" then
      val.fg = v[mode]
      --val.ctermfg = v[1]
    elseif k == "bg" then
      val.bg = v[mode]
      --val.ctermbg = v[1]
    else
      val[k] = opts[k]
    end
  end

  val.cterm = val.cterm or {}
  val.force = true
  vim.api.nvim_set_hl(0, name, val)
end

vim.g.terminal_color_0 = BLACK[MODE]
vim.g.terminal_color_1 = RED[MODE]
vim.g.terminal_color_2 = GREEN[MODE]
vim.g.terminal_color_3 = YELLOW[MODE]
vim.g.terminal_color_4 = BLUE[MODE]
vim.g.terminal_color_5 = MAGENTA[MODE]
vim.g.terminal_color_6 = CYAN[MODE]
vim.g.terminal_color_7 = WHITE[MODE]
vim.g.terminal_color_8 = BLACK[MODE]
vim.g.terminal_color_9 = RED[MODE]
vim.g.terminal_color_10 = GREEN[MODE]
vim.g.terminal_color_11 = YELLOW[MODE]
vim.g.terminal_color_12 = BLUE[MODE]
vim.g.terminal_color_13 = MAGENTA[MODE]
vim.g.terminal_color_14 = CYAN[MODE]
vim.g.terminal_color_15 = WHITE[MODE]

-- common
hi("Normal", { fg = WHITE, bg = BLACK })
hi("Bold", { bold = true })
hi("Underlined", { underline = true })
hi("Directory", { fg = CYAN })
hi("NonText", { fg = GRAY500, bold = true })
hi("SpecialKey", { fg = CYAN, bold = true })
hi("EndOfBuffer", { fg = GRAY300 })

hi("Title", { fg = WHITE, bold = true })
hi("Comment", { fg = GRAY500 })

hi("String", { fg = YELLOW })
hi("Character", { fg = CYAN })
hi("Number", { fg = YELLOW })
hi("Boolean", { fg = GREEN })
hi("Float", { fg = YELLOW })

hi("Identifier", { fg = WHITE, bold = true })
hi("Function", { fg = BLUE, bold = true })

hi("Constant", { bold = true })

hi("Statement", { fg = GREEN })
hi("Operator", { bold = true })

hi("PreProc", { fg = YELLOW })
hi("Type", { fg = GREEN })
hi("Special", { fg = GRAY200 })
hi("Tag", { fg = GREEN })

hi("Ignore", { fg = GRAY300 })
hi("Todo", { fg = BLACK, bg = YELLOW })

-- filetypes
hi("@tag.html", { fg = GREEN, bold = true })
hi("@tag.attribute.html", { fg = CYAN })
hi("@tag.delimiter.html", { fg = BLUE, bold = false })
hi("@operator.html", { fg = CYAN, bold = true }, INVERT)

-- UI
hi("MoreMsg", { fg = GREEN })
hi("ModeMsg", { fg = BLUE })
hi("Question", { fg = BLUE, bold = true })
hi("MatchParen", { fg = RED, bold = true, underline = true })
hi("Error", { fg = BLACK, bg = RED })
hi("ErrorMsg", { fg = BLACK, bg = RED })
hi("WarningMsg", { fg = BLACK, bg = YELLOW })

hi("CursorLine", { bg = GRAY800 })
hi("CursorLineNr", { fg = WHITE, bg = GRAY800 })

hi("LineNr", { fg = GRAY500 })
hi("LineNrAbove", { fg = GRAY500 })
hi("LineNrBelow", { fg = GRAY500 })

hi("Search", { bold = true, underline = true })
hi("IncSearch", { bold = true, underline = true })

hi("Cursor", { reverse = true })
hi("Visual", { reverse = true })

hi("VertSplit", { fg = WHITE })
hi("SignColumn", { bg = BLACK })

hi("StatusLine", { fg = WHITE, bg = GRAY800 })
hi("StatusLineNC", { bg = GRAY800 })
hi("Pmenu", { fg = WHITE, bg = BLACK })
hi("PmenuSel", { fg = WHITE, bg = BLUE }, INVERT)
hi("PmenuSbar", { fg = GRAY700, bg = BLACK })
hi("PmenuThumb", { bold = true })

-- plugins
hi("NeoTreeDirectoryIcon", { fg = YELLOW })

hi("NeoTreeTabActive", { fg = GREEN })
hi("NeoTreeTabInactive", { fg = GRAY700 })

hi("TabLine", { bg = BLACK })
hi("TabLineSel", { bg = BLUE })
hi("TabLineClose", { fg = RED, bg = BLACK })

hi("HeirLineToggleFileManager", { fg = YELLOW, bold = true })
hi("HeirLineOpenTerminal", { fg = CYAN, bold = true })
hi("HeirLineOpenNewTab", { bold = true })

hi("CmpWinPmenuSbar", { bg = BLUE }, INVERT)
hi("CmpItemAbbrMatchFuzzy", { fg = WHITE, bg = BLUE }, INVERT)
hi("CmpItemAbbrMatch", { fg = WHITE, bg = GREEN }, INVERT)
hi("CmpItemKind", { fg = WHITE })
hi("CmpItemKindClass", { link = "Identifier" })
hi("CmpItemKindColor", { link = "CmpItemKind" })
hi("CmpItemKindConstant", { link = "Constant" })
hi("CmpItemKindConstructor", { link = "Function" })
hi("CmpItemKindCopilot", { fg = WHITE })
hi("CmpItemKindEnum", { link = "Identifier" })
hi("CmpItemKindEnumMember", { link = "Type" })
hi("CmpItemKindEvent", { link = "Statement" })
hi("CmpItemKindField", { link = "Type" })
hi("CmpItemKindFile", { fg = WHITE })
hi("CmpItemKindFolder", { fg = YELLOW })
hi("CmpItemKindFunction", { link = "Function" })
hi("CmpItemKindInterface", { link = "Identifier" })
hi("CmpItemKindKeyword", { link = "Identifier" })
hi("CmpItemKindMethod", { link = "Function" })
hi("CmpItemKindModule", { link = "Identifier" })
hi("CmpItemKindOperator", { link = "Operator" })
hi("CmpItemKindProperty", { link = "Type" })
hi("CmpItemKindReference", { link = "Identifier" })
hi("CmpItemKindSnippet", { link = "Special" })
hi("CmpItemKindStruct", { link = "Constant" })
hi("CmpItemKindText", { fg = BLUE })
hi("CmpItemKindTypeParameter", { link = "Identifier" })
hi("CmpItemKindUnit", { link = "Type" })
hi("CmpItemKindValue", { link = "Identifier" })
hi("CmpItemKindVariable", { link = "Identifier" })
