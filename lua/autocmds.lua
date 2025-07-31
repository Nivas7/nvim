vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("TextYanking", { clear = true }),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client.supports_method and client:supports_method("textDocument/completion") then
			if vim.lsp.completion and vim.lsp.completion.enable then
				vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
			end
		end
	end,
})

-- don't auto comment new line
vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- Define netrw custom keymaps
local function netrw_mapping()
	local opts = { buffer = true, noremap = true, silent = true }

	vim.keymap.set("n", "H", "u", opts) -- Go up a directory
	vim.keymap.set("n", "h", "-^", opts) -- Jump to parent
	vim.keymap.set("n", "l", "<CR>", opts) -- Open file or enter directory

	vim.keymap.set("n", ".", "gh", opts) -- Toggle hidden files
	vim.keymap.set("n", "P", "<C-w>z", opts) -- Close preview window

	vim.keymap.set("n", "L", "<CR>:Lexplore<CR>", opts) -- Open and reload netrw
	vim.keymap.set("n", "<Leader>dd", ":Lexplore<CR>", opts) -- Custom leader mapping
end

-- Auto apply keymaps when netrw is opened
vim.api.nvim_create_augroup("NetrwMapping", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = "NetrwMapping",
	pattern = "netrw",
	callback = netrw_mapping,
})
