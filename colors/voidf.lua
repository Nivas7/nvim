vim.opt.background = "dark"
if vim.g.colors_name ~= nil then vim.cmd("hi clear") end
if vim.g.syntax_on == 1     then vim.cmd("syntax reset") end
vim.g.colors_name = "voidf"

local C = {
    bg0    = "#0d0c0c",
    bg     = "#171717",
    bg3    = "#282727",
    bg1    = "#141414",
    bg2    = "#1d1c19",

    fg2    = "#d8d8d8",
    fg3    = "#c8c8c8",
    fg     = "#c5c9c5",
    fg1    = "#969bb1",
    fg5    = "#d0d0bd",
    fg6    = "#d3d3de",
    fg7    = "#cacad3",
    fg8    = "#c8c093",
    grey   = "#808080",
    grey2  = "#a6a69c",
    grey3  = "#9e9e9c",
    grey4 = "#71767e",
    grey5 = "#898e98",
    grey6 = "#484848",
    comment = "#7A857A",
    visual = "#223249",
    red    = "#f43838",
    red0 = "#FBB1B1",
    error = "#f43838",
    orange = "#e58f35",
    yellow = "#e9da24",
    warning = "#f4df30",
    green  = "#98cc6c",
    ok     = "#85dd3c",
    blue   = "#96a6c8",
    hint = "#6a9589",
    info = "#678897",
}

local __color__ = {
    bg0     = "#0d0c0c",
    bg      = "#171717",
    bg1     = "#1d1c19",
    fg      = "#cacad3",
    fg1     = "#c8c093",
    visual  = "#223249",

    red0    = "#c03030",
    red     = "#f43838",
    yellow  = "#f4df30",
    aqua    = "#6a9589", -- hint
    teal0   = "#08272b",
    teal01  = "#00434d",
    teal    = "#678897", -- info
    blue    = "#96a6c8",
    grey0   = "#252528",
    grey    = "#7a857a",
    grey1   = "#5a5a5a",
    grey2   = "#71767e",
    green0  = "#273621",
    green   = "#98cc6c",
    orange  = "#e58f35",
    brown   = "#b38318",
    milky   = "#eec982",
}

local hi = vim.api.nvim_set_hl

-- Basic Editor
hi(0, "ColorColumn",  { bg = __color__.grey0 })
hi(0, "Conceal",      { fg = __color__.grey2 })
hi(0, "CursorLine",   { bg = __color__.grey0 })
hi(0, "Directory",    { fg = __color__.blue })
hi(0, "DiffAdd",      { bg = __color__.green0 })
hi(0, "DiffChange",   { bg = __color__.teal0 })
hi(0, "DiffDelete",   { fg = __color__.red0 })
hi(0, "DiffText",     { bg = __color__.teal01 })
hi(0, "LineNr",       { fg = __color__.grey1 })
hi(0, "Normal",       { bg = __color__.bg, fg = __color__.fg })
hi(0, "NormalFloat",  { bg = __color__.bg0, blend = 7 })
hi(0, "FloatTitle",   { bg = __color__.bg0, blend = 7 })
hi(0, "StatusLine",   { bg = __color__.bg0, fg = __color__.fg1 })
hi(0, "Visual",       { bg = __color__.visual })
hi(0, "CurSearch",    { bg = __color__.milky, fg = __color__.bg })
hi(0, "Search",       { bg = __color__.brown, fg = __color__.bg })
hi(0, "Pmenu",        { bg = __color__.bg1, fg = __color__.fg })
hi(0, "PmenuSel",     { bg = __color__.visual, fg = __color__.fg })
hi(0, "TabLine",      { bg = __color__.bg0, fg = __color__.fg1 })
hi(0, "TabLineSel",   { bg = __color__.visual, fg = __color__.fg1 })

-- Syntax
hi(0, "Comment", { fg = __color__.grey })
hi(0, "String",    { fg = __color__.green })

-- Diagnostic
-- hi(0, "DiagnosticOk",             { fg = __color__.ok })
hi(0, "DiagnosticError",          { fg = __color__.red })
hi(0, "DiagnosticInfo",           { fg = __color__.teal })
hi(0, "DiagnosticHint",           { fg = __color__.aqua })
hi(0, "DiagnosticWarn",           { fg = __color__.yellow })
-- hi(0, "DiagnosticUnderlineOk",    { sp = __color__.ok,     undercurl = true })
hi(0, "DiagnosticUnderlineError", { sp = __color__.red,    undercurl = true })
hi(0, "DiagnosticUnderlineInfo",  { sp = __color__.teal,   undercurl = true })
hi(0, "DiagnosticUnderlineHint",  { sp = __color__.aqua,   undercurl = true })
hi(0, "DiagnosticUnderlineWarn",  { sp = __color__.yellow, undercurl = true })

-- Treesitter
-- LSP

------------------------------------------------------------


-- hi(0, "Identifier", { fg = C.blue })
hi(0, "Identifier", { fg = __color__.fg })
hi(0, "Constant", { fg = C.blue })
hi(0, "Type", { fg = C.fg1 })
-- hi(0, "Special", { fg = C.red0 })
-- hi(0, "Delimiter", { fg = C.red0 })
hi(0, "Keyword", { fg = C.orange })
hi(0, "Conditional", { fg = C.orange })
hi(0, "Statement", { fg = __color__.fg })
hi(0, "PreProc", { fg = C.grey5 })
-- hi(0, "Function", { fg = C.fg5 })
hi(0, "Function", { fg = __color__.fg })
hi(0, "dartBraces", { fg = __color__.fg })
hi(0, "Label", { fg = __color__.aqua })

-- hi(0, "Added", { fg = "#b3f6c0" })

hi(0, "ErrorMsg", { fg = __color__.red })
hi(0, "WarningMsg", { fg = __color__.yellow })
-- hi(0, "MatchParen", {})


-- hi(0, "@variable", { fg = C.grey2 })
hi(0, "@variable", { fg = __color__.fg })
hi(0, "Title", { fg = __color__.fg })

-- Terminal colors
vim.g.terminal_color_0 = ""
vim.g.terminal_color_1 = ""
vim.g.terminal_color_2 = ""
vim.g.terminal_color_3 = ""
vim.g.terminal_color_4 = ""
vim.g.terminal_color_5 = ""
vim.g.terminal_color_6 = ""
vim.g.terminal_color_9 = ""
vim.g.terminal_color_10 = ""
vim.g.terminal_color_11 = ""
vim.g.terminal_color_12 = ""
vim.g.terminal_color_13 = ""
vim.g.terminal_color_14 = ""
vim.g.terminal_color_15 = ""
