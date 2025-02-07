local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- General Settings Group
local general = augroup("_general", { clear = true })

-- Highlight when yanking (copying) text Try it with `yap` in normal mode - See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = general,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
	end,
})

-- Return to last Edit position when opening files
autocmd("BufReadPost", {
	group = general,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- Editing --
local editing = augroup("_editing", { clear = true })

-- Enable spell check and word wrap for certain file types
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = editing,
	pattern = { "gitcommit", "markdown", "txt" },
	desc = "Enable spell checking and text wrapping for certain filetypes",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Prevent IndentLine from hiding ``` in markdown files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = editing,
	pattern = { "markdown" },
	callback = function()
		vim.g["indentLine_enabled"] = 0
		vim.g["markdown_syntax_conceal"] = 0
	end,
})

-- Formatting --
local fromatting = augroup("_formatting", { clear = true })

-- Adjust how text is formatted
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = formatting,
	pattern = "*",
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Remove Whitespace on save
autocmd("BufWritePre", {
	group = formatting,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Don't auto Comment on new lines
autocmd("BufEnter", {
	group = general,
	pattern = "*",
	command = "set fo-=c fo-=r fo-=o",
})

-- to make border as same as neovim ColorScheme
autocmd({ "UIEnter", "ColorScheme" }, {
	callback = function()
		local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
		if not normal.bg then
			return
		end
		io.write(string.format("\027Ptmux;\027\027]11;#%06x\007\027\\", normal.bg))
		io.write(string.format("\027]11;#%06x\027\\", normal.bg))
	end,
})

autocmd("UILeave", {
	callback = function()
		io.write("\027Ptmux;\027\027]111;\007\027\\")
		io.write("\027]111\027\\")
	end,
})

-- Close different buffers with `q`
autocmd("FileType", {
	group = "_general",
	pattern = "qf,help,man,notify,lspinfo,spectre_panel,startuptime,tsplayground,PlenaryTestPopup,neotest-summary",
	callback = function()
		vim.cmd("nnoremap <silent><buffer> q :close<cr>")
	end,
})

-- Resize splits if windows get resized
autocmd("VimResized", {
	group = general,
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- Check if file chnaged when its window is focus, more eager than `autoread`
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = general,
	command = "checktime",
})

-- Auto create a dir when saving a file, in case some intermediate directory does not exist
autocmd("BufWritePre", {
	group = general,
	callback = function(event)
		if event.match:match("^%/w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Disable eslint on node_modules
autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "**/node_modules/**", "node_modules", "/node_modules/*" },
	group = augroup("DisableEslintOnNodeModules", {}),
	callback = function()
		vim.diagnostic.disable(0)
	end,
})

-- Fugitive keymaps
autocmd("BufWinEnter", {
	pattern = "fugitive",
	group = augroup("Fugitive", {}),
	callback = function()
		if vim.bo.filetype ~= "fugitive" then
			return
		end

		-- Only run this on fugitive buffers
		local bufnr = vim.api.nvim_get_current_buf()
		vim.keymap.set("n", "<leader>P", function()
			vim.cmd.Git("push")
		end, { buffer = bufnr, remap = false, desc = "Fugitive: Push" })
		vim.keymap.set("n", "<leader>p", function()
			vim.cmd.Git("pull")
		end, { buffer = bufnr, remap = false, desc = "Fugitive: Pull" })
	end,
})

-- Make sure any opened buffer which is contained in a git repo will be tracked
-- vim.cmd('autocmd BufEnter * :lua require("lazygit.utils").project_root_dir()')

-- Statusline
local statusline_group = augroup("StatusLine", {})
autocmd({ "WinEnter", "BufEnter" }, {
	pattern = "*",
	group = statusline_group,
	callback = function()
		if vim.bo.filetype == "oil" then
			vim.o.statusline = "%!v:lua.require('statusline').oil()"
			return
		end
		vim.o.statusline = "%!v:lua.require('statusline').active()"
	end,
})

autocmd({ "WinLeave", "BufLeave" }, {
	pattern = "*",
	group = statusline_group,
	callback = function()
		vim.o.statusline = "%!v:lua.require('statusline').inactive()"
	end,
})
