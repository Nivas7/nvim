return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        cmd = "LazyDev",
        dependencies = {
            -- {'gonstoll/wezterm-types', lazy = true},
            { "Bilal2453/luvit-meta", lazy = true },
        },
        opts = {
            library = {
                { path = "luvit-meta/library", words = { "vim%.uv" } },
                { path = "snacks.nvim",        words = { "Snacks" } },
                { "nvim-dap-ui" },
                -- {path = 'wezterm-types', mods = {'wezterm'}},
            },
        },
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true, -- optional: only load when needed
    },

}
