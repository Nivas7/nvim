return {
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            -- Optional: load custom snippets from your config path
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = { vim.fn.stdpath("config") .. "/snippets" }
            })
        end,
        opts = { history = true, delete_check_events = "TextChanged" },
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        event = "InsertEnter",
        version = "*",
        config = function()
            require("blink.cmp").setup({
                keymap = {
                    preset = "default",
                },

                appearance = {
                    use_nvim_cmp_as_default = true,
                    nerd_font_variant = "normal",
                },

                completion = {
                    list = {
                        selection = {
                            preselect = function(ctx)
                                return ctx.mode ~= "cmdline"
                                    and not require("blink.cmp").snippet_active({ direction = 1 })
                            end,
                            auto_insert = function(ctx)
                                return ctx.mode == "cmdline"
                            end,
                        },
                    },
                    trigger = {
                        prefetch_on_insert = true,
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 150,
                    },
                    accept = {
                        auto_brackets = {
                            enabled = true,
                        },
                    },
                },
                snippets = {
                    preset = "luasnip", -- Specify the snippet engine preset
                },

                sources = {
                    default = { "lsp", "path", "snippets", "buffer" },
                },
                cmdline = {
                    enabled = true,
                    completion = {
                        menu = {
                            auto_show = false,
                        },
                    },
                    keymap = {
                        preset = "default",
                        ["<Tab>"] = {
                            function(cmp)
                                if not cmp.is_menu_visible() then
                                    cmp.show_and_insert()
                                end
                                return cmp.select_next()
                            end,
                        },
                        ["<S-Tab>"] = {
                            function(cmp)
                                if not cmp.is_menu_visible() then
                                    cmp.show_and_insert()
                                end
                                return cmp.select_prev()
                            end,
                        },
                    },
                    sources = function()
                        local type = vim.fn.getcmdtype()
                        if type == ":" then
                            return { "cmdline" }
                        end
                        return {}
                    end,
                },
                signature = { enabled = false },
            })

            local capabilities = require("blink.cmp").get_lsp_capabilities()
            vim.lsp.config("*", { capabilities = capabilities })
        end,
    },
}
