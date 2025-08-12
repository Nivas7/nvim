-- Mason PATH is handled by core.mason-path
vim.lsp.enable({
    -- "jdtls",
    "lua-ls",
    "gopls",
    "ts-ls",
    "tailwindcss",
    "html-ls",
    "css-ls",
})

-- Diagnostics {{{
local config = {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.HINT] = "",
            [vim.diagnostic.severity.INFO] = "",
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
        focusable = false,
        style = "minimal",
        border = "single",
        source = "always",
        header = "",
        prefix = "",
        suffix = "",
    },
}
vim.diagnostic.config(config)

-- Improve LSPs UI {{{
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

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
    completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end

-- Lsp capabilities and on_attach {{{
-- Here we grab default Neovim capabilities and extend them with ones we want on top
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
    dynamicRegistration = true,
    lineFoldingOnly = true,
}

capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local ok, diag = pcall(require, "extras.workspace-diagnostic")
        if ok then
            diag.populate_workspace_diagnostics(client, bufnr)
        end
    end,
})
-- }}}


-- Create keybindings, commands, inlay hints and autocommands on LSP attach {{{
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then
            return
        end
        ---@diagnostic disable-next-line need-check-nil
        if client.server_capabilities.completionProvider then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
            -- vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
        end
        ---@diagnostic disable-next-line need-check-nil
        if client.server_capabilities.definitionProvider then
            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        end

        -- -- nightly has inbuilt completions, this can replace all completion plugins
        if client:supports_method("textDocument/completion", bufnr) then
            -- Enable auto-completion
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        end

        --- Disable semantic tokens
        ---@diagnostic disable-next-line need-check-nil
        client.server_capabilities.semanticTokensProvider = nil

        -- All the keymaps
        -- stylua: ignore start
        local keymap = vim.keymap.set
        local lsp = vim.lsp
        local opts = { silent = true }
        local function opt(desc, others)
            return vim.tbl_extend("force", opts, { desc = desc }, others or {})
        end
        keymap("n", "gd", function() vim.lsp.buf.definition() end, opt("Go to definition"))
        keymap("n", "gD", function()
            local ok, diag = pcall(require, "extras.definition")
            if ok then
                diag.get_def()
            end
        end, opt("Get the definition in a float"))

        keymap("n", "gi", function() lsp.buf.implementation({ border = "single" }) end, opt("Go to implementation"))
        keymap("n", "gr", lsp.buf.references, opt("Show References"))
        keymap("n", "gl", vim.diagnostic.open_float, opt("Open diagnostic in float"))
        keymap("n", "K", function() vim.lsp.buf.hover() end, opts)
        -- disable the default binding first before using a custom one
        pcall(vim.keymap.del, "n", "K", { buffer = ev.buf })
        keymap("n", "K", function() lsp.buf.hover({ border = "rounded", max_height = 30, max_width = 120 }) end,
            opt("Toggle hover"))
        keymap("n", "<leader>lf", function() vim.lsp.buf.format() end, opt("Toggle AutoFormat"))
        keymap("n", "<leader>lI", vim.cmd.Mason, opt("Mason"))
        keymap("n", "<leader>lS", lsp.buf.workspace_symbol, opt("Workspace Symbols"))
        keymap("n", "<leader>la", lsp.buf.code_action, opt("Code Action"))
        keymap("n", "<leader>lh", function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({})) end,
            opt("Toggle Inlayhints"))
        keymap("n", "<leader>li", vim.cmd.LspInfo, opt("LspInfo"))
        keymap("n", "<leader>ll", lsp.codelens.run, opt("Run CodeLens"))
        keymap("n", "<leader>lr", lsp.buf.rename, opt("Rename"))
        keymap("n", "<leader>ls", lsp.buf.document_symbol, opt("Doument Symbols"))

        keymap("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        keymap("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        keymap("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        keymap("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        keymap("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

        -- diagnostic mappings
        keymap("n", "<Leader>dD", function()
            local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
            if ok then
                for _, cur_client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                    diag.populate_workspace_diagnostics(cur_client, 0)
                end
                vim.notify("INFO: Diagnostic populated")
            end
        end, opt("Popluate diagnostic for the whole workspace"))
        keymap("n", "<leader>dn", function() vim.diagnostic.jump({ count = 1, float = true }) end, opt("Next Diagnostic"))
        keymap("n", "<leader>dp", function() vim.diagnostic.jump({ count = -1, float = true }) end,
            opt("Prev Diagnostic"))
        keymap("n", "<leader>dq", vim.diagnostic.setloclist, opt("Set LocList"))
        keymap("n", "<leader>dv", function()
            vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
        end, opt("Toggle diagnostic virtual_lines"))
        -- stylua: ignore end
    end,
})

-- Start, Stop, Restart, Log commands {{{
vim.api.nvim_create_user_command("LspStart", function()
    vim.cmd.e()
end, { desc = "Starts LSP clients in the current buffer" })

vim.api.nvim_create_user_command("LspStop", function(opts)
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if opts.args == "" or opts.args == client.name then
            client:stop(true)
            vim.notify(client.name .. ": stopped")
        end
    end
end, {
    desc = "Stop all LSP clients or a specific client attached to the current buffer.",
    nargs = "?",
    complete = function(_, _, _)
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local client_names = {}
        for _, client in ipairs(clients) do
            table.insert(client_names, client.name)
        end
        return client_names
    end,
})

vim.api.nvim_create_user_command("LspRestart", function()
    local detach_clients = {}
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        client:stop(true)
        if vim.tbl_count(client.attached_buffers) > 0 then
            detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
        end
    end
    local timer = vim.uv.new_timer()
    if not timer then
        return vim.notify("Servers are stopped but havent been restarted")
    end
    timer:start(
        100,
        50,
        vim.schedule_wrap(function()
            for name, client in pairs(detach_clients) do
                local client_id = vim.lsp.start(client[1].config, { attach = false })
                if client_id then
                    for _, buf in ipairs(client[2]) do
                        vim.lsp.buf_attach_client(buf, client_id)
                    end
                    vim.notify(name .. ": restarted")
                end
                detach_clients[name] = nil
            end
            if next(detach_clients) == nil and not timer:is_closing() then
                timer:close()
            end
        end)
    )
end, {
    desc = "Restart all the language client(s) attached to the current buffer",
})

vim.api.nvim_create_user_command("LspLog", function()
    vim.cmd.vsplit(vim.lsp.log.get_filename())
end, {
    desc = "Get all the lsp logs",
})

vim.api.nvim_create_user_command("LspInfo", function()
    vim.cmd("silent checkhealth vim.lsp")
end, {
    desc = "Get all the information about all LSP attached",
})
-- }}}

--- lsp.lua ends here
