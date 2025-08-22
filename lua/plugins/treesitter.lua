return {
    { -- Highlight, edit, and navigate code
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter.configs", -- Sets main module to use for opts
        -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "html",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "query",
                "vim",
                "vimdoc",
            },
            -- Autoinstall languages that are not installed
            auto_install = true,
            highlight = {
                enable = true,
            },
            playground = {
                enable = true,
                disable = {},
            },
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,
                    keymaps = {
                        ["af"] = { query = "@function.outer", desc = "Select outer part of a function region" },
                        ["if"] = { query = "@function.inner", desc = "Select inner part of a function region" },
                        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class region" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>xp"] = { query = "@parameter.inner", desc = "Swap parameter with the next one" },
                    },
                    swap_previous = {
                        ["<leader>xP"] = { query = "@parameter.inner", desc = "Swap parameter with the previous one" },
                    },
                },
            },
            indent = { enable = true, disable = { "ruby" } },
        },
    },

    -- NOTE: js,ts,jsx,tsx Auto Close Tags
    {
        "windwp/nvim-ts-autotag",
        enabled = true,
        ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact", "svelte" },
        config = function()
            -- Independent nvim-ts-autotag setup
            require("nvim-ts-autotag").setup({
                opts = {
                    enable_close = true, -- Auto-close tags
                    enable_rename = true, -- Auto-rename pairs
                    enable_close_on_slash = false, -- Disable auto-close on trailing `</`
                },
                per_filetype = {
                    ["html"] = {
                        enable_close = true, -- Disable auto-closing for HTML
                    },
                    ["typescriptreact"] = {
                        enable_close = true, -- Explicitly enable auto-closing (optional, defaults to `true`)
                    },
                },
            })
        end,
    },
}
