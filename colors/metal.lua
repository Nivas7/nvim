-- Custom colorscheme based on base16-black-metal
local colors = {
  bg         = "#000000",
  fg         = "#c1c1c1",
  cursor     = "#c1c1c1",
  color0     = "#000000",
  color1     = "#5f8787",
  color2     = "#dd9999",
  color3     = "#b88c7d",
  color4     = "#a89cbd",
  color5     = "#d4a6ba",
  color6     = "#aaaaaa",
  color7     = "#c1c1c1",
  color8     = "#59636e",
  color9     = "#5f8787",
  color10    = "#dd9999",
  color11    = "#b88c7d",
  color12    = "#a89cbd",
  color13    = "#d4a6ba",
  color14    = "#aaaaaa",
  color15    = "#c1c1c1",
  column     = "#1a1a1e"
}

vim.cmd("highlight clear")
vim.cmd("syntax reset")
vim.o.background = "dark"
vim.g.colors_name = "wal"

-- Core UI groups
vim.api.nvim_set_hl(0, "Normal",         { fg = colors.fg, bg = colors.bg })
vim.api.nvim_set_hl(0, "Cursor",         { fg = colors.bg, bg = colors.cursor })
vim.api.nvim_set_hl(0, "ColorColumn",    { bg = colors.column })
vim.api.nvim_set_hl(0, "CursorLine",     { bg = "#111111" })
vim.api.nvim_set_hl(0, "CursorLineNr",   { fg = colors.color4, bold = true })
vim.api.nvim_set_hl(0, "LineNr",         { fg = colors.color8 })
vim.api.nvim_set_hl(0, "StatusLine",     { fg = colors.fg, bg = colors.color0 })
vim.api.nvim_set_hl(0, "VertSplit",      { fg = colors.color8 })

-- Syntax groups
vim.api.nvim_set_hl(0, "Comment",        { fg = colors.color8, italic = true })
vim.api.nvim_set_hl(0, "Constant",       { fg = colors.color5 })
vim.api.nvim_set_hl(0, "String",         { fg = colors.color2 })
vim.api.nvim_set_hl(0, "Identifier",     { fg = colors.color4 })
vim.api.nvim_set_hl(0, "Function",       { fg = colors.color4 })
vim.api.nvim_set_hl(0, "Statement",      { fg = colors.color1 })
vim.api.nvim_set_hl(0, "Keyword",        { fg = colors.color1, italic = true })
vim.api.nvim_set_hl(0, "Type",           { fg = colors.color6 })
vim.api.nvim_set_hl(0, "Special",        { fg = colors.color3 })
vim.api.nvim_set_hl(0, "Todo",           { fg = colors.color0, bg = colors.color11 })

-- UI highlights
vim.api.nvim_set_hl(0, "Pmenu",          { fg = colors.fg, bg = "#1a1a1a" })
vim.api.nvim_set_hl(0, "PmenuSel",       { fg = colors.bg, bg = colors.color4 })
vim.api.nvim_set_hl(0, "Search",         { fg = colors.bg, bg = colors.color5 })
vim.api.nvim_set_hl(0, "Visual",         { bg = "#333333" })

