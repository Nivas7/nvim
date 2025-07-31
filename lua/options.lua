-- Pre-requisites
local o = vim.opt
vim.g.mapleader = " "

-- General
o.undofile = true
o.cursorline = false
o.termguicolors = true
o.clipboard = "unnamedplus"
o.scrolloff = 5

-- netrw-customization
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 20
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = "cp -r"

-- disable nvim intro
o.shortmess:append("sI")

-- Statusline
o.showmode = true

-- Indenting
o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.smartindent = true
o.autoindent = true
o.expandtab = true

-- Enable filetype-specific plugins and indentation
-- o.filetype = "on"
-- o.filetype.plugin = "on"
-- o.filetype.indent = "on"

o.ignorecase = true
o.smartcase = true
o.mouse = "a"
o.fillchars = { eob = " " }

-- Number
o.number = true
o.relativenumber = true

-- Column
o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400

-- Character limit column
o.colorcolumn = "80"

-- Disable colorcolumn for markdown
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.colorcolumn = ""
	end,
})

-- go to previous/next line with h,l,left arrow and right arrow
o.whichwrap:append("<>[]hl")

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- Automatic :retab on save (fix indentation errors)
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	command = "retab",
})
