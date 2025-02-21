local opt = vim.opt
local g = vim.g
local icons = require("utils.icons")

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.markdown_recommended_style = 0 -- Fix markdown indentation settings

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.g.border_style = "rounded" ---@type "single"|"double"|"rounded"

-- General
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Defer clipboard because xsel and pbcopy can be slow
vim.api.nvim_create_autocmd("User", {
  group = vim.api.nvim_create_augroup("custom_" .. "load_clipboard", { clear = true }),
  pattern = "VeryLazy",
  callback = function()
    -- Sync clipboard between OS and Neovim.
    vim.opt.clipboard = "unnamedplus"
  end,
})
opt.swapfile = false -- creates a swapfile
opt.completeopt = "menuone,noselect" -- Autocompletion options
opt.backup = false -- creates a backup file
vim.opt.termsync = false

-- Neovim UI
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.showmatch = true -- Highlight Matching Parenthesis
opt.foldmethod = "marker" -- Enable Folding

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.linebreak = true -- Wrap on word boundary

-- Enable break indent, long lines will continue visually indented
vim.opt.breakindent = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- Save undo history
vim.opt.undofile = true

-- Don't store backup while overwriting the file
vim.opt.backup = false
vim.opt.writebackup = false

-- global bufferline
vim.opt.showtabline = 2
vim.o.tabline = "%#Normal#"

vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time

-- Show which line/column your cursor is on
-- NOTE: cursorcolumn causes glitches
vim.opt.cursorline = true
vim.opt.cursorcolumn = false

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Minimal number of screen lines to keep above, below, left and right before the cursor.
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4

-- hide nvim bottom status
vim.opt.cmdheight = 0

-- Memory
vim.opt.updatetime = 100 -- faster completion (4000ms default)
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)

-- Sets how neovim will display certain whitespace in the editor.
-- NOTE: sync with mcauley-penney/visual-whitespace.nvim opts
vim.opt.list = true
vim.opt.listchars = {
  tab = "󰌒 ",
  extends = "…",
  precedes = "…",
  trail = "·",
  nbsp = "󱁐",
}
vim.opt.fillchars = {
  eob = " ",
  diff = "╱",
  foldopen = icons.fold.open,
  foldclose = icons.fold.closed,
  foldsep = " ",
}

-- Indenting
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = false -- fix indent of line starting with `#`

-- highlight all matches on previous search pattern
opt.incsearch = true -- Start Search Before Pressing Enter
opt.ignorecase = true -- Start Search Before Pressing Enter
opt.ignorecase = true -- ignore case in search patternsnter
opt.ignorecase = true -- ignore case in search patterns

-- Preview substitutions live, as you type!
vim.opt.inccommand = "nosplit"

-- Allow going past the end of line in visual block mode
vim.opt.virtualedit = "block"

-- Don't autoformat comments
vim.opt.formatoptions = "qjl1"

-- disable nvim intro
vim.opt.shortmess:append("sI")

-- Reduce command line messages
vim.opt.shortmess:append("WcC")

-- enable 24-bit colour
vim.opt.termguicolors = true

vim.opt.compatible = false

-- max items in autocomplete menu
vim.opt.pumheight = 15

-- opacity for autocomplete menu
vim.opt.pumblend = 5

-- don't scroll after splitting
vim.opt.splitkeep = "screen"

-- NOTE: horizontal scrolling can be laggy with large horizontal lines because of regex highlighting
vim.opt.wrap = false

-- sync buffers between neovim windows
vim.opt.autoread = true

if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.smoothscroll = true
end

-- PERF: stop highlighting large lines
-- only works with syntax builtin nvim plugin
vim.opt.synmaxcol = 500

vim.opt.spell = false
vim.opt.spelllang = { "en_us", "es" }

-- docs: https://neovim.io/doc/user/options.html#'sessionoptions'
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "skiprtp" }
