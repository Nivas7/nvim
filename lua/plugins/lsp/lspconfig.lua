return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require("lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- completion capabilities (blink.cmp)
    local blink = require("blink.cmp")
    if blink then
      capabilities = blink.get_lsp_capabilities()
    end

    -- configure matlab server
    lspconfig["clangd"].setup({
      capabilities = capabilities,
    })
    -- configure matlab server
    lspconfig["matlab_ls"].setup({
      capabilities = capabilities,
    })
    -- configure yaml server>
    lspconfig["yamlls"].setup({
      capabilities = capabilities,
    })
    -- configure htmx server
    lspconfig["htmx"].setup({
      capabilities = capabilities,
    })
    -- configure bash server
    lspconfig["bashls"].setup({
      capabilities = capabilities,
    })
    -- configure html server
    lspconfig["html"].setup({
      capabilities = capabilities,
    })

    -- configure golang server
    lspconfig["gopls"].setup({
      capabilities = capabilities,
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      settings = {
        gopls = {
          completeUnimported = true,
          usePlaceholders = true,
          analyses = {
            unusedparams = true,
          },
        },
      },
    })

    -- configure typescript server with plugin
    lspconfig["ts_ls"].setup({
      capabilities = capabilities,
    })

    -- configure css server
    lspconfig["cssls"].setup({
      capabilities = capabilities,
    })

    -- configure tailwindcss server
    lspconfig["tailwindcss"].setup({
      capabilities = capabilities,
    })

    -- configure prisma orm server
    lspconfig["prismals"].setup({
      capabilities = capabilities,
    })

    -- configure graphql language server
    lspconfig["graphql"].setup({
      capabilities = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    -- configure emmet language server
    lspconfig["emmet_ls"].setup({
      capabilities = capabilities,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    -- configure python server
    lspconfig["pyright"].setup({
      capabilities = capabilities,
    })

    -- configure lua server (with special settings)
    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          competion = {
            callSnippet = "Replace",
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    local x = vim.diagnostic.severity
    local icons = require("utils.icons")
    local config = {
      -- Enable virtual text
      virtual_text = { -- or false for disable
        prefix = "", -- ■  󰊠
        suffix = "",
        format = function(diagnostic)
          local prefix = icons.misc.Ghost .. " "
          local suffix = " "
          -- return full message with custom prefix & suffix
          return prefix .. diagnostic.message .. suffix
        end,
      },
      update_in_insert = true,
      signs = {
        text = {
          [x.ERROR] = icons.diagnostics.Error,
          [x.WARN] = icons.diagnostics.Warn,
          [x.HINT] = icons.diagnostics.Hint,
          [x.INFO] = icons.diagnostics.Info,
        },
        numhl = {
          [x.ERROR] = "WarningMsg",
          [x.WARN] = "ErrorMsg",
          [x.HINT] = "DiagnosticHint",
          [x.INFO] = "DiagnosticInfo",
        },
      },
      underline = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    }

    vim.diagnostic.config(config)
    -- add borders to lsp info window
    require("lspconfig.ui.windows").default_options.border = "single"
  end,
}
