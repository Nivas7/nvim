local scratch_path = os.getenv("HOME") .. "/Documents/personal/notes/scratch"

return {
    "folke/snacks.nvim",
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        gitbrowse = { enabled = true },
        dashboard = { enabled = false },
        notifier = { enabled = false },
        statuscolumn = { enabled = false },
        words = { enabled = false },
        lazygit = { enabled = false },
        image = {
            doc = { inline = false, float = false },
            convert = { notify = false },
        },
        picker = {
            finder = "explorer",
            hidden = true,
            supports_live = false,
            ui_select = false,
        },
        scratch = {
            root = scratch_path,
            win = { width = 150, height = 40, border = "single" },
        },
    },
    keys = function()
        local snacks = require("snacks")
        return {
            {
                "<leader>.",
                function()
                    vim.ui.input({
                        prompt = "Enter scratch buffer title: ",
                        default = "",
                    }, function(t)
                        if not vim.fn.isdirectory(scratch_path) then
                            vim.fn.mkdir(scratch_path, "p")
                        end

                        if not t then
                            return
                        end

                        local title = t ~= "" and t:gsub("%s+", "_") or "Untitled"
                        snacks.scratch.open({
                            ft = "markdown",
                            name = title .. "_" .. os.date("%Y-%m-%d-%H-%M-%S"),
                            win = {
                                title = title,
                            },
                        })
                    end)
                end,
                desc = "Open a scratch buffer",
            },
            {
                "<leader>S",
                -- function() snacks.scratch.select() end,
                function() Utils.fzf.scratch_select() end,
                desc = "Select a scratch buffer",
            },
            {
                "<leader>cR",
                function() snacks.rename.rename_file() end,
                desc = "Rename File",
            },
            {
                "<leader>gy",
                function() snacks.gitbrowse() end,
                desc = "Open line(s)  in browser",
                mode = { "n", "v" },
            },
            {
                "<leader>gY",
                function()
                    snacks.gitbrowse.open({
                        open = function(url)
                            vim.fn.setreg("+", url)
                            vim.notify("Yanked url to clipboard")
                        end,
                    })
                end,
                desc = "Copy line(s)  link",
                mode = { "n", "v" },
            },
            {
                "<leader>ee",
                snacks.picker.explorer,
                desc = "Open file explorer",
            },
        }
    end,
}
