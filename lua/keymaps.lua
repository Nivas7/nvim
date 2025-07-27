vim.g.mapleader = " "
local map = function(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, opts)
end

local opts = { noremap = true, silent = true }

-- Delete a word backwards
map("n", "db", 'vb"_d')

-- Vscode like utility move lines in Visual Mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

--utility vim.keymap.setpings
map("n", "n", "nzzzv") -- keep the cursor centered when doing 'n'
map("n", "N", "Nzzzv") -- keep the cursor centered when doing 'N'
map("n", "J", "mzJ`z", { desc = "Join line without moving the cursor" })
map("n", "cn", "*``cgn", { desc = "Change next match by pressing dot (.)" })
map("n", "cN", "*``cgN", { desc = "Change previous match by pressing dot (.)" })
map("n", "<leader>vp", "`[v`]<CR>", { desc = "Select pasted text" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })

map("n", "<leader>ts", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })
map("n", "<leader>th", "<cmd>set hlsearch!<CR>", { desc = "Toggle highlights (hlsearch)" })
--
-- the how it be paste
map("x", "<leader>p", [["_dP]])

-- remember yanked
map("v", "p", '"_dp', opts)

-- Copies or Yank to system clipboard
map("n", "<leader>Y", [["+Y]], opts)

-- leader d delete wont remember as yanked/clipboard when delete pasting
map({ "n", "v" }, "<leader>d", [["_d]])
map({ "i" }, "<C-l>", "<Right>", { desc = "Move cursor to right" })
map({ "i" }, "<C-h>", "<Left>", { desc = "Move cursor to right" })

-- Better window management

vim.keymap.set("n", "hs", ":split<Return>", opts)
vim.keymap.set("n", "vs", ":vsplit<Return>", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
vim.keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", { desc = "Resize split up" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", { desc = "Resize split down" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize split left" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize split right" })

---------------------
-- LSP diagnostics --
---------------------
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "LSP: make a location list" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "LSP: open floating diagnostic window" })
map("n", "[d", vim.diagnostic.get_prev, { desc = "LSP: move to previous diagnostic" })
map("n", "]d", vim.diagnostic.get_next, { desc = "LSP: move to next diagnostic" })

map("n", "<leader>vl", function()
	local new_config = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = new_config })
	print("toggled diagnostic virtual_lines")
end, { desc = "LSP: Toggle diagnostic virtual_lines" })

---------
-- Misc --
----------
map("n", "<leader>ss", '<cmd>source<CR><cmd>echo "sourced" expand("%:t")<CR>', { desc = "MISC: source current file" })

-- Buffers

map("n", "<leader>q", "<cmd>q!<CR>", { desc = "Close buffer/window" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Go to previous buffer" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "(V) Indent to left" })
map("v", ">", ">gv", { desc = "(V) Indent to right" })

-- Visual vim.keymap.sets
map("v", "<leader>r", '"hy:%s/<C-r>h//g<left><left>') -- Replace all instances of highlighted words
map("v", "<C-s>", ":sort<CR>") -- Sort highlighted text in visual mode with Control+S

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
