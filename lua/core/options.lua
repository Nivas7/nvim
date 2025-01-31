
local opt = vim.opt
local g = vim.g

-- Setting Up leader Key
g.mapleader = " "
g.maplocalleader = " "

g.editorconfig = false
g.markdown_recommended_style = 0 -- Fix markdown indentation settings

-- Set to true if you have a Nerd Font installed and selected in the terminal
g.have_nerd_font = true
g.have_nerd_font = true


-- General
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.clipboard = "unnamedplus"
opt.swapfile = false -- creates a swapfile
opt.completeopt = "menuone,noselect" -- Autocompletion options
opt.undofile = true -- enable persistent undo
opt.backup = false -- creates a backup file

-- Neovim UI
opt.number = true -- set numbered lines
opt.relativenumber = true -- set relative numbered lines
opt.showmatch = true -- Highlight Matching Parenthesis
opt.foldmethod = "marker" -- Enable Folding
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.smartcase = true -- smart case
opt.linebreak = true -- Wrap on word boundary
opt.laststatus = 0 --disable native statusline
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.cursorline = true -- highlight the current line
opt.scrolloff = 4
opt.sidescrolloff = 8
opt.cmdheight = 1
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore

-- Memory
opt.history = 100 -- Remember N lines in History
opt.lazyredraw = true -- Faster Scrolling
opt.synmaxcol = 240 -- Max column for Syntax Highliting
opt.updatetime = 100 -- faster completion (4000ms default)
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)

-- Tabs, Indent
opt.expandtab = true -- convert tabs to spaces
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.showtabline = 0 -- always show tabs
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.smartindent = true -- make indenting smarter again
opt.autoindent = true -- Auto indent new Lines
opt.breakindent = true

-- Search
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.incsearch = true -- Start Search Before Pressing Enter
opt.ignorecase = true -- ignore case in search patterns
opt.inccommand = "split" -- split below for to show replaces

-- Files
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- Appearence
opt.pumheight = 10 -- pop up menu height
opt.pumblend = 10  -- pop up menu transparency
opt.termguicolors = true -- set term gui colors (most terminals support this)

-- Wild menu
opt.wildmode = "longest:full,full"  -- Command-line completion mode
opt.wildignore = "*/node_modules/*,*/.git/*,*/vendor/*"	-- Ignore certain files & Directories

-- Window
opt.title = true
opt.titlelen = 0 -- do not shorten title
opt.titlestring = "%{getcwd()}"

opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " ", diff = "╱", eob = " " }

-- Buffer Behaviour
opt.switchbuf = "usetab"
opt.virtualedit = "block"
-- Ensure I dont freak out by hitting the cap w when exiting
vim.cmd [[
  cnoreabbrev Wq wq
  cnoreabbrev wQ wq
  cnoreabbrev WQ wq
  cnoreabbrev W w
  cnoreabbrev Q q
]]




