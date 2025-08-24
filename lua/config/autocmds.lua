local autocmd = vim.api.nvim_create_autocmd

-- Use a single autogroup to manage all custom autocommands.
-- This is a best practice to prevent duplicates if the config is sourced multiple times.
local augroup = vim.api.nvim_create_augroup("MyOptimalConfig", { clear = true })


-- Statusline
local statusline_group = vim.api.nvim_create_augroup("StatusLine", {})
autocmd({ "WinEnter", "BufEnter" }, {
    pattern = "*",
    group = statusline_group,
    callback = function()
        if vim.bo.filetype == "oil" then
            vim.wo.statusline = "%{%v:lua.require('extras.statusline').oil()%}"
            return
        end
        vim.wo.statusline = "%{%v:lua.require('extras.statusline').active()%}"
    end,
})

autocmd({ "WinLeave", "BufLeave" }, {
    pattern = "*",
    group = statusline_group,
    callback = function(args)
        local leaving_buf_filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
        if leaving_buf_filetype == "oil" then
            vim.wo.statusline = "%{%v:lua.require('extras.statusline').oil()%}"
            return
        end
        vim.wo.statusline = "%{%v:lua.require('extras.statusline').inactive()%}"
    end,
})

-- ============================================================================
-- Core Editing Autocommands
-- ============================================================================

-- Don't auto-comment new lines.
-- This runs whenever a buffer is entered and prevents unwanted `//` or `--` characters.
autocmd("BufEnter", {
    group = augroup,
    command = "set formatoptions-=cro"
})


-- Go to the last edit position when opening a file.
-- This is a highly useful feature for resuming work exactly where you left off.
-- The check ensures the cursor isn't moved to an invalid position.
autocmd("BufReadPost", {
    group = augroup,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Highlight on yank.
-- Provides immediate visual feedback when you copy text, confirming the action worked.
autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank({
            higroup = "Visual",
            timeout = 40, -- The highlight will fade after 40ms
        })
    end,
})

-- Show the cursor line only in the active window.
-- This reduces visual clutter and makes it easier to focus on the current window.
autocmd({ "InsertLeave", "WinEnter" }, {
    group = augroup,
    command = "set cursorline"
})
autocmd({ "InsertEnter", "WinLeave" }, {
    group = augroup,
    command = "set nocursorline"
})


-- Set specific options for email buffers.
-- This is a more optimal approach, as it uses `vim.opt_local` to set settings
-- only for the current buffer, and it avoids setting global options like `columns`.
autocmd("Filetype", {
    group = augroup,
    pattern = "mail",
    callback = function()
        vim.opt_local.textwidth = 72
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.wrapmargin = 0
        vim.opt_local.colorcolumn = "73"
    end,
})

-- Enable spell checking for specific document types.
-- `vim.opt_local` ensures these settings are per-buffer, not global.
autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup,
    pattern = { "*.txt", "*.md", "*.tex" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en"
    end,
})

-- Create a buffer-local keymap for man pages.
-- Using `vim.keymap.set` is the modern and preferred way to define mappings.
autocmd("FileType", {
    group = augroup,
    pattern = "man",
    callback = function()
        vim.keymap.set('n', 'q', ':quit<CR>', { buffer = true, silent = true })
    end,
})
