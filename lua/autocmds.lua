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
