local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local methods = vim.lsp.protocol.Methods

-- Icons for diagnostic severity levels
local diagnostic_icons = {
    ERROR = '',
    WARN = '',
    HINT = '',
    INFO = '',
}

-- Icons for completion kinds
local icons = {
    Class = " ",
    Color = " ",
    Constant = " ",
    Constructor = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Keyword = " ",
    Method = "ƒ ",
    Module = "󰏗 ",
    Property = " ",
    Snippet = " ",
    Struct = " ",
    Text = " ",
    Unit = " ",
    Value = " ",
    Variable = " ",
}

-- Apply icons to completion kinds
local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
    completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end

-- Diagnostic configuration
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = diagnostic_icons.ERROR,
            [vim.diagnostic.severity.WARN] = diagnostic_icons.WARN,
            [vim.diagnostic.severity.HINT] = diagnostic_icons.HINT,
            [vim.diagnostic.severity.INFO] = diagnostic_icons.INFO,
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
        },
    },
    update_in_insert = true,
    underline = true,
    virtual_text = true,
    severity_sort = true,
    float = {
        source = 'if_many',
        prefix = function(diag)
            local level = vim.diagnostic.severity[diag.severity]
            local prefix = string.format(' %s ', diagnostic_icons[level])
            return prefix, 'Diagnostic' .. level:gsub('^%l', string.upper)
        end,
    },
})

-- Override hover with custom styling
local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
    return hover({
        border = "single",
        max_width = math.floor(vim.o.columns * 0.7),
        max_height = math.floor(vim.o.lines * 0.7),
    })
end

-- Override signature help with custom styling
local signature_help = vim.lsp.buf.signature_help
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.signature_help = function()
    return signature_help({
        title = "Signature help",
        border = "single",
        title_pos = "left",
        max_width = math.floor(vim.o.columns * 0.4),
        max_height = math.floor(vim.o.lines * 0.5),
    })
end

---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
    local keymap = vim.keymap.set
    local lsp = vim.lsp
    local opts = { silent = true, buffer = bufnr } -- Buffer-local keymaps
    local function merge_opts(desc, others)
        return vim.tbl_extend("force", opts, { desc = desc }, others or {})
    end

    -- LSP Actions
    keymap("n", "gd", lsp.buf.definition, merge_opts("Go to definition"))
    keymap("n", "gi", function() lsp.buf.implementation({ border = "single" }) end, merge_opts("Go to implementation"))
    keymap("n", "gr", lsp.buf.references, merge_opts("Show references"))
    keymap("n", "K", function() lsp.buf.hover({ border = "rounded", max_height = 30, max_width = 120 }) end,
        merge_opts("Show hover"))
    keymap("n", "<leader>lr", lsp.buf.rename, merge_opts("Rename symbol"))
    keymap("n", "<leader>la", lsp.buf.code_action, merge_opts("Code action"))
    keymap("n", "<leader>ls", lsp.buf.document_symbol, merge_opts("Document symbols"))
    keymap("n", "<leader>lS", lsp.buf.workspace_symbol, merge_opts("Workspace symbols"))
    keymap("n", "<leader>lf", lsp.buf.format, merge_opts("Format buffer"))
    keymap("n", "<leader>lh", function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({})) end,
        merge_opts("Toggle inlay hints"))
    keymap("n", "<leader>ll", lsp.codelens.run, merge_opts("Run codelens"))

    -- Diagnostic Actions
    keymap("n", "gl", vim.diagnostic.open_float, merge_opts("Show diagnostic"))
    keymap("n", "<leader>dn", function() vim.diagnostic.jump({ count = 1, float = true }) end,
        merge_opts("Next diagnostic"))
    keymap("n", "<leader>dp", function() vim.diagnostic.jump({ count = -1, float = true }) end,
        merge_opts("Previous diagnostic"))
    keymap("n", "<leader>dq", vim.diagnostic.setloclist, merge_opts("Set location list"))
    keymap("n", "<leader>dv", function()
        vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
    end, merge_opts("Toggle diagnostic virtual lines"))
    keymap("n", "<leader>dD", function()
        local ok, diag = pcall(require, "extras.workspace-diagnostic")
        if ok then
            for _, cur_client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                diag.populate_workspace_diagnostics(cur_client, 0)
            end
            vim.notify("INFO: Diagnostics populated")
        else
            vim.notify("extras.workspace-diagnostic not found", vim.log.levels.ERROR)
        end
    end, merge_opts("Populate workspace diagnostics"))

    -- Signature Help
    if client:supports_method(methods.textDocument_signatureHelp) then
        keymap("i", "<C-s>", function()
            if vim.g.blink_enabled then
                local ok, blink = pcall(require, "blink.cmp")
                if ok and blink then
                    local blink_window = require("blink.cmp.completion.windows.menu")
                    if blink_window.win:is_open() then
                        blink.hide()
                    end
                else
                    vim.notify("blink.cmp not found", vim.log.levels.WARN)
                end
            end
            vim.lsp.buf.signature_help()
        end, merge_opts("Show signature help"))
    end

    -- Document Highlights
    if client:supports_method(methods.textDocument_documentHighlight) then
        vim.b[bufnr].highlight_enabled = false
        local group_name = "lsp_document_highlight"

        local function enable_document_highlight()
            local under_cursor_highlights_group = augroup(group_name, { clear = true })
            autocmd({ "CursorHold", "InsertLeave" }, {
                group = under_cursor_highlights_group,
                desc = "Highlight references under cursor",
                buffer = bufnr,
                callback = vim.lsp.buf.document_highlight,
            })
            autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
                group = under_cursor_highlights_group,
                desc = "Clear highlight references",
                buffer = bufnr,
                callback = vim.lsp.buf.clear_references,
            })
            vim.b[bufnr].highlight_enabled = true
        end

        local function disable_document_highlight()
            vim.api.nvim_clear_autocmds({ group = group_name, buffer = bufnr })
            vim.lsp.buf.clear_references()
            vim.b[bufnr].highlight_enabled = false
        end

        local function toggle_document_highlight()
            if vim.b[bufnr].highlight_enabled then
                disable_document_highlight()
            else
                enable_document_highlight()
            end
        end
        keymap("n", "<leader>ma", toggle_document_highlight, merge_opts("Toggle document highlights"))
    end

    -- Format Command
    vim.api.nvim_create_user_command("Format", function(args)
        local ok, conform = pcall(require, "conform")
        if not ok then
            vim.notify("conform.nvim not found", vim.log.levels.ERROR)
            return
        end
        local range = nil
        if args.count ~= -1 then
            local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1] or ""
            range = {
                start = { args.line1, 0 },
                ["end"] = { args.line2, end_line:len() },
            }
        end
        conform.format({ lsp_format = "fallback", async = true, range = range })
    end, { range = true, desc = "Format buffer or range with conform.nvim" })
end

-- Initialize LSP servers (configurations loaded from .config/nvim/lsp/)
autocmd("FileType", {
    group = augroup("lsp-init", { clear = true }),
    pattern = { "lua", "go", "typescript", "javascript", "html", "css" },
    callback = function()
        vim.lsp.enable({
            "lua-ls",
            "gopls",
            "ts-ls",
            "tailwindcss",
            "html-ls",
            "css-ls",
        })
    end,
})

-- LSP Attach
autocmd("LspAttach", {
    group = augroup("lsp-attach", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if not client then
            return
        end
        on_attach(client, args.buf)
    end,
})

-- User Commands
vim.api.nvim_create_user_command("LspStop", function(opts)
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if opts.args == "" or opts.args == client.name then
            client:stop(true)
            vim.notify(client.name .. ": stopped")
        end
    end
end, {
    desc = "Stop all or specific LSP clients for the current buffer",
    nargs = "?",
    complete = function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        return vim.tbl_map(function(client) return client.name end, clients)
    end,
})

vim.api.nvim_create_user_command("LspRestart", function()
    vim.lsp.stop_client(vim.lsp.get_clients())
    vim.defer_fn(vim.cmd.edit, 200)
    vim.notify("LSP clients restarted")
end, {
    desc = "Restart all LSP clients for the current buffer",
})

vim.api.nvim_create_user_command("LspLog", function()
    vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
    desc = "Open LSP log file in a vertical split",
})

vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("silent checkhealth vim.lsp")
end, {
    desc = "Show LSP health information",
})
