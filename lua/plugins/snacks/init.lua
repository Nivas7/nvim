local header = [[



    ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒    ▒▓▓▓▓▒        ▒▓▓▓▓▒
    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒    ▒▓▓▓▓▓       ▒▓▓▓▓▒
   ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒      ▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▒
                         ▓▓▓▓▓▓▓▓▓▓▓▓▓▒
                           ▒▒▒▒▒▒▒▒
    ▒▒▒▒▒▒
   ▓▓▓▓▓▓▓
   ▓▓▓▓▓▓▓▒               ▒▒▒▒▒▒▒
   ▒▓▓▓▓▓▓▓▒            ▒▓▓▓▓▓▓▓▒
    ▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒
     ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
       ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒


                           ]]

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    explorer = { enabled = true, replace_netrw = true },
    indent = {
      enabled = true,
      char = "│",
      scope = { hl = "Comment" },
      chunk = {
        enabled = false,
        hl = "Comment",
      },
    },
    win = { border = vim.g.borderStyle },
    input = { enabled = true, icon = false },
    lazygit = require("plugins.snacks.lazygit"),
    picker = require("plugins.snacks.picker"),
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = false },
    words = {
      notify_jump = true,
      modes = { "n" },
      debounce = 300,
    },
    ---@class snacks.dashboard.Config
    dashboard = {
      enabled = true,
      preset = {
        header = header,
      },
      formats = {
        header = {
          "%s",
          align = "center",
        },
      },
      sections = {
        {
          section = "header",
          padding = 4,
        },
        {
          pane = 2,
          {
            { section = "keys", gap = 1, padding = 2 },
            { section = "startup" },
          },
        },
      },
    },
    notifier = {
      timeout = 7500,
      sort = { "added" }, -- sort only by time
      width = { min = 12, max = 0.45 },
      height = { min = 1, max = 0.45 },
      icons = { error = "󰅚", warn = "", info = "󰋽", debug = "󰃤", trace = "󰓗" },
      top_down = false,
    },
    styles = {
      input = {
        backdrop = true,
        border = vim.g.borderStyle,
        title_pos = "left",
        width = 50,
        row = math.ceil(vim.o.lines / 2) - 3,
        wo = { colorcolumn = "" },
        keys = {
          CR = { "<CR>", "confirm", mode = "n" },
        },
      },
      notification = {
        border = vim.g.borderStyle,
        focusable = false,
        wo = { winblend = 0, wrap = true },
      },
      blame_line = {
        backdrop = true,
        width = 0.6,
        height = 0.6,
        border = vim.g.borderStyle,
        title = " 󰆽 Git blame ",
      },
    },
  },
  keys = {
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
    },
    {
      "<leader>sf",
      function()
        Snacks.picker.files()
      end,
      { desc = "Search for [F]iles" },
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.buffers()
      end,
      { desc = "Search for [B]uffers" },
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.help()
      end,
      { desc = "Search for [H]elp" },
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep({
          follow = true,
          hidden = true,
        })
      end,
      { desc = "Search for [G]it files" },
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      { desc = "[S]earch for [K]eys" },
    },
    {
      "<leader>ee",
      function()
        Snacks.picker.explorer({
          follow_file = true,
          auto_close = true,
        })
      end,
      { desc = "[S]earch file [E]xplorer" },
    },
    {
      "<leader>ld",
      function()
        Snacks.dim()
      end,
      { desc = "[L]ook at the current scope by [D]imming the rest" },
    },
    {
      "<leader>cz",
      function()
        Snacks.dim()
      end,
      desc = "Toggle zen mode",
    },
    {
      "<leader>cZ",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Toggle zoom",
    },
  },
  init = function()
    vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#56635f" })
  end,
}
