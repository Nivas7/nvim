local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Turn off arrow keys - force HJKL
map("n", "<UP>", "<NOP>")
map("n", "<DOWN>", "<NOP>")
map("n", "<LEFT>", "<NOP>")
map("n", "<RIGHT>", "<NOP>")

-- Use x and Del key for black hole register
map("", "<Del>", '"_x')
map("", "x", '"_x')

-- Paste over selected text
map("v", "p", '"_dP')

-- Remove highlighting
map("n", "<leader>nh", ":nohl<CR>")

-- Better line navigation
map("n", "j", "v:count == 0 ? 'gj' :  'j'", { expr = true })
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Select All
map("n", "<C-a>", "ggVG", { desc = "Slect all" })

map("n", "<leader>vs", "<cmd>vsplit<cr>", { desc = "Vertical Split"})
map("n", "<leader>hs", "<cmd>split<cr>", { desc = "Horizontal Split"})

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("v", "k", ":m '>-2<cr>gv=gv") -- move current line up
map("v", "j", ":m '>+1<cr>gv=gv") -- move current line down

map("n", "<M-Up>", ":resize +2<CR>")
map("n", "<M-Down>", ":resize -2<CR>")
map("n", "<M-Left>", ":vertical resize -2<CR>")
map("n", "<M-Right>", ":vertical resize +2<CR>")

map({ "n", "v" }, "<leader>y", '"+y', { desc = "copy to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "paste from system clipboard" })

-- Buffer Navigation
map("n", "<leader>q", "<cmd>q!<cr>", { desc = "close buffer/window" })
map("n", "<s-l>", "<cmd>bnext<cr>", { desc = "go to next buffer" })
map("n", "<s-h>", "<cmd>bprevious<cr>", { desc = "go to previous buffer" })


