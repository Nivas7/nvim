-- `silent = true` is a crucial option for most mappings.
local opts = { silent = true }

-- A simple helper to add a description to a mapping.
-- This makes your mappings self-documenting in tools like `:help which-key`.
local function with_desc(desc)
    return vim.tbl_extend("force", opts, { desc = desc })
end

-- Use a local variable to shorten the function name.
local keymap = vim.keymap.set

-- Leader Key and Core Mappings

-- Set the space key as the leader key.
-- This is a modern standard and keeps the leader key easy to reach.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Save, Quit, and Close
keymap("n", "<leader>w", "<Cmd>write<CR>", with_desc("Save File"))
keymap("n", "<leader>q", "<Cmd>quit<CR>", with_desc("Quit Window"))
keymap("n", "<leader>c", "<Cmd>bd<CR>", with_desc("Close Buffer"))

-- Remove Search Highlights
keymap("n", "\\", "<Cmd>noh<CR>", with_desc("Remove Search Highlights"))

-- Navigate Quickfix List
keymap("n", "<C-n>", "<Cmd>cnext<CR>", with_desc("Next Quickfix Item"))
keymap("n", "<C-p>", "<Cmd>cprevious<CR>", with_desc("Previous Quickfix Item"))

-- Navigation and Movement

-- Move lines up and down in normal and visual modes.
keymap({ "n", "v" }, "<A-j>", ":m .+1<CR>==<Esc>", with_desc("Move line down"))
keymap({ "n", "v" }, "<A-k>", ":m .-2<CR>==<Esc>", with_desc("Move line up"))

-- Visual Mode Mappings

-- Indent selected text while staying in visual mode.
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Don't yank text when pasting in visual mode.
keymap("v", "p", "P", opts)

-- Insert Mode Mappings

-- Move cursor with C-h,j,k,l while in insert mode.
keymap("i", "<C-h>", "<Left>", opts)
keymap("i", "<C-j>", "<Down>", opts)
keymap("i", "<C-k>", "<Up>", opts)
keymap("i", "<C-l>", "<Right>", opts)

-- Buffer Navigation

-- Better buffer navigation with the leader key.
keymap("n", "<leader>bn", ":bnext<CR>", with_desc("Next buffer"))
keymap("n", "<leader>bp", ":bprevious<CR>", with_desc("Previous buffer"))
keymap("n", "<leader>bd", ":bdelete<CR>", with_desc("Delete buffer"))
keymap("n", "<leader>bl", ":ls<CR>", with_desc("List buffers"))

-- Terminal Mappings

-- Better terminal window navigation.
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

-- stylua: ignore start
-- These mappings depend on a custom `extras.terminal` module.
-- They are kept here as-is, as they are specific to your setup.
local term = require("extras.terminal")

keymap("t", "<C-q>", [[<C-\><C-n>]], with_desc("Escape in terminal window"))
keymap({ "n", "t" }, "<A-t>", function() term:new({ execn = "zsh", name = "Shell" }):toggle() end,
    with_desc("Open Shell"))
keymap({ "n", "t" }, "<A-g>", function() term:new({ execn = "lazygit", name = "Lazygit" }):toggle() end,
    with_desc("Open Lazygit"))
keymap({ "n", "t" }, "<A-b>", function() term:new({ execn = "btop", name = "Btop" }):toggle() end, with_desc("Open Btop"))
keymap({ "n", "t" }, "<A-p>", function() term:new({ execn = "python", name = "Python" }):toggle() end,
    with_desc("Open Python"))
keymap("n", "<Leader>gg", function() term:new({ name = "Lazygit", execn = "lazygit" }):toggle() end, with_desc("Lazygit"))
-- stylua: ignore end

-- System clipboard mappings.
keymap({ "n", "v" }, "<Leader>y", '"+y', with_desc("Yank to clipboard"))
keymap("n", "<Leader>yy", '"+yy', with_desc("Yank line to clipboard"))
keymap({ "n", "v" }, "<Leader>p", '"+p', with_desc("Paste from clipboard"))
keymap({ "n", "v" }, "<Leader>d", '"+d', with_desc("Delete to clipboard"))

-- Smart insert on empty lines.
-- This is a clever custom mapping to start a new, properly indented line.
keymap("n", "i", function()
    if #vim.fn.getline(".") == 0 then
        return [["_cc]]
    else
        return "i"
    end
end, { expr = true, silent = true, desc = "Properly indent on empty line when insert" })

-- Source the current file to reload the configuration.
keymap("n", "<Leader>x", "<Cmd>so %<CR>", with_desc("Source the current file"))

-- Write file with sudo.
-- This depends on a custom `extras.sudo-write` module.
keymap("n", "<C-S-s>", function()
    require("extras.sudo-write").write()
end, with_desc("Write File with sudo"))
