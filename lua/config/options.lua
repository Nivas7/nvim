
-- Use local variables for options to keep the global scope clean
local opt = vim.opt

-- General appearance and behavior
opt.cmdheight = 1             -- Give more space to the command line
opt.ignorecase = true         -- Ignore case in search patterns
opt.mouse = 'a'               -- Allow mouse usage in all modes
opt.pumheight = 10            -- Max height of the completion pop-up menu
opt.showmode = false          -- Don't show the mode in the command line
opt.smartcase = true          -- Smart case searching
opt.smartindent = true        -- Smart indenting for new lines
opt.splitbelow = true         -- Horizontal splits appear below the current window
opt.splitright = true         -- Vertical splits appear to the right of the current window
opt.termguicolors = true      -- Enable 24-bit colors
opt.timeoutlen = 500          -- Time to wait for a mapped sequence to complete
opt.updatetime = 300          -- Faster completion, reduces the delay for `CursorHold` events
opt.conceallevel = 0          -- Make concealed characters visible
opt.clipboard = "unnamedplus"

-- Files and backups
opt.backup = false            -- No backup files
opt.swapfile = false          -- No swap files
opt.undofile = true           -- Enable persistent undo
opt.undodir = vim.fn.stdpath('data') .. '/undodir' -- Set persistent undo directory

-- Text formatting and indentation
opt.expandtab = true          -- Use spaces instead of tabs
opt.shiftwidth = 4            -- Number of spaces to use for each indent level
opt.tabstop = 4               -- Number of spaces for a hard tab
opt.softtabstop = 4           -- Behaves like tabstop but for soft tabs
opt.wrap = false              -- Don't wrap lines
opt.linebreak = true          -- Wrap at word boundaries when `wrap` is enabled

-- UI and navigation
opt.number = true             -- Show line numbers
opt.relativenumber = true     -- Show relative line numbers
opt.numberwidth = 2           -- Set the number column width
opt.signcolumn = 'yes'        -- Always show the sign column
opt.scrolloff = 8             -- Minimum number of screen lines to keep above/below the cursor
opt.sidescrolloff = 8         -- Minimum number of screen columns to keep on the left/right
opt.cursorline = true         -- Highlight the current line
opt.colorcolumn = '80'        -- Highlight the 80th column
opt.laststatus = 3            -- Always show a global statusline
opt.showtabline = 2           -- Always show the tabline
opt.guifont = 'JetBrainsMono NF:h14' -- Set the font for GUIs like Neovide

-- Completion and searching
opt.completeopt = { 'menuone', 'popup', 'noinsert', 'noselect' } -- More explicit options
opt.hlsearch = true           -- Highlight all matches on previous search
opt.incsearch = true          -- Highlight matches as you type

-- Folding
opt.foldenable = false
opt.foldmethod = 'expr'       -- Use an expression for folding
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- Treesitter-based folding
opt.foldtext = ''             -- Don't show the default fold text


-- Use the modern API for options
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
vim.opt.iskeyword:append('-')
vim.opt.whichwrap:append('<>[]hl')
vim.opt.diffopt:append('linematch:60')
vim.opt.shortmess:append({ C = true, c = true, I = true })
vim.opt.cinkeys:remove({ ':', '0#', '0#', '!', 'o', 'O' }) -- Removes some default C-style indent keys that can be annoying
vim.opt.indentkeys:remove(':')
vim.opt.fillchars = { eob = ' ', fold = ' ' }
vim.opt.splitkeep = 'screen'
vim.opt.inccommand = 'split'

-- Global settings
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.c_syntax_for_h = true

-- ============================================================================
-- Autocommands
-- ============================================================================

-- A single autogroup for all your custom autocommands
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup('CustomConfigs', { clear = true })

-- Disable colorcolumn for specific file types
autocmd('FileType', {
  group = augroup,
  pattern = { 'markdown', 'txt', 'help' },
  callback = function()
    vim.opt_local.colorcolumn = ''
  end,
})

-- Automatic retab on save
autocmd('BufWritePre', {
  group = augroup,
  pattern = '*',
  command = 'retab',
})

-- Auto-resize split windows when Neovim window is resized
autocmd('VimResized', {
  group = augroup,
  pattern = '*',
  command = 'wincmd =',
})


-- Add Mason-managed binaries to the PATH
local is_windows = vim.fn.has('win32') ~= 0
local sep = is_windows and '\\' or '/'
local delim = is_windows and ';' or ':'
local mason_path = vim.fn.stdpath('data') .. sep .. 'mason' .. sep .. 'bin'

if not string.find(vim.env.PATH, mason_path, 1, true) then
  vim.env.PATH = mason_path .. delim .. vim.env.PATH
end
