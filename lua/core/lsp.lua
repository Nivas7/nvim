vim.lsp.enable({
    "lua-ls",
    "gopls",
    "ts-ls",
    "tailwindcss",
    "html-ls",
    "css-ls",
})

-- ============================================================================
-- LSP Configuration
-- ============================================================================

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Then, add or modify your custom capabilities on top
capabilities.textDocument.foldingRange = {
    dynamicRegistration = true,
    lineFoldingOnly = true,
}

capabilities.textDocument.semanticTokens.multilineTokenSupport = true
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Configure diagnostics
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

-- Improve LSP UI with icons 
local icons = {
    Class = " ", Color = " ", Constant = " ", Constructor = " ",
    Enum = " ", EnumMember = " ", Event = " ", Field = " ",
    File = " ", Folder = " ", Function = "󰊕 ", Interface = " ",
    Keyword = " ", Method = "ƒ ", Module = "󰏗 ", Property = " ",
    Snippet = " ", Struct = " ", Text = " ", Unit = " ",
    Value = " ", Variable = " ",
}

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
    completion_kinds[i] = icons[kind] and icons[kind] .. kind or kind
end

-- Set the global LSP configuration with the merged capabilities
vim.lsp.config("*", {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        local ok, diag = pcall(require, "extras.workspace-diagnostic")
        if ok then
            diag.populate_workspace_diagnostics(client, bufnr)
        end
    end,
})

-- ============================================================================
-- Autocommands, Keymaps, and Commands
-- ============================================================================

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if not client then
            return
        end

        -- Note: omnifunc and tagfunc are for Neovim's built-in completion
        -- and can be removed if you are using blink.cmp, as it handles completion.
        -- If you still want to keep them for fallback purposes, that's fine.
        -- For a minimal config, these can be removed.
        ---@diagnostic disable-next-line need-check-nil
        if client.server_capabilities.completionProvider then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        end
        ---@diagnostic disable-next-line need-check-nil
        if client.server_capabilities.definitionProvider then
            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        end

        if client:supports_method("textDocument/completion", bufnr) then
            -- Enable auto-completion
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        end

        -- Disable semantic tokens if you want
        ---@diagnostic disable-next-line need-check-nil
        client.server_capabilities.semanticTokensProvider = nil

        -- Consolidate and simplify keymaps
        local keymap = vim.keymap.set
        local lsp = vim.lsp
        local opts = { silent = true, buffer = ev.buf } -- set buffer here to avoid repetition
        local function opt(desc, others)
            return vim.tbl_extend("force", opts, { desc = desc }, others or {})
        end

        -- Lsp Actions
        keymap("n", "gd", function() lsp.buf.definition() end, opt("Go to definition"))
        keymap("n", "gD", function()
          local ok, diag = pcall(require, "extras.definition")
          if ok then
            diag.get_def()
          end
        end, opt("Get the definition in a float"))
        keymap("n", "gi", function() lsp.buf.implementation({ border = "single" }) end, opt("Go to implementation"))
        keymap("n", "gr", lsp.buf.references, opt("Show References"))
        keymap("n", "K", function() lsp.buf.hover({ border = "rounded", max_height = 30, max_width = 120 }) end, opt("Toggle hover"))
        keymap("n", "<leader>lr", lsp.buf.rename, opt("Rename"))
        keymap("n", "<leader>la", lsp.buf.code_action, opt("Code Action"))
        keymap("n", "<leader>ls", lsp.buf.document_symbol, opt("Doument Symbols"))
        keymap("n", "<leader>lS", lsp.buf.workspace_symbol, opt("Workspace Symbols"))
        keymap("n", "<leader>lf", function() lsp.buf.format() end, opt("Toggle AutoFormat"))
        keymap("n", "<leader>lh", function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({})) end, opt("Toggle Inlayhints"))
        keymap("n", "<leader>ll", lsp.codelens.run, opt("Run CodeLens"))

        -- Diagnostic actions
        keymap("n", "gl", vim.diagnostic.open_float, opt("Open diagnostic in float"))
        keymap("n", "<leader>dn", function() vim.diagnostic.jump({ count = 1, float = true }) end, opt("Next Diagnostic"))
        keymap("n", "<leader>dp", function() vim.diagnostic.jump({ count = -1, float = true }) end, opt("Prev Diagnostic"))
        keymap("n", "<leader>dq", vim.diagnostic.setloclist, opt("Set LocList"))
        keymap("n", "<leader>dv", function()
          vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
        end, opt("Toggle diagnostic virtual_lines"))
        keymap("n", "<Leader>dD", function()
          local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
          if ok then
            for _, cur_client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
              diag.populate_workspace_diagnostics(cur_client, 0)
            end
            vim.notify("INFO: Diagnostic populated")
          end
        end, opt("Popluate diagnostic for the whole workspace"))
    end,
})

-- Streamlined User Commands
-- LspStart is removed as it's not a proper command.
-- LspRestart is simplified to a more robust implementation.
-- LspInfo is removed as Neovim provides a native command.

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

-- Simplified and robust LspRestart
vim.api.nvim_create_user_command("LspRestart", function()
    vim.lsp.stop_client(vim.lsp.get_clients())
    -- Reload the buffer after a short delay to allow clients to fully stop
    vim.defer_fn(vim.cmd.edit, 100)
    vim.notify("LSP clients restarted")
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

