return {
  -- HACK: docs @ https://github.com/folke/snacks.nvim/blob/main/docs
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  -- NOTE: Options
  opts = {
    animate = {
      enabled = true,
      duration = 20, -- ms per step
      easing = "linear",
      fps = 60, -- frames per second. Global setting for all animations
    },
    explorer = {
      enabled = true,
      layout = { cycle = true },
    },
    indent = {
      enabled = true,
      char = "│",
      scope = { hl = "Comment" },
      chunk = {
        enabled = false,
        hl = "Comment",
      },
    },
    quickfile = {
      enabled = true,
      exclude = { "latex" },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
      style = "fancy",
    },
    input = { enabled = true },
    -- HACK: read picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
    picker = {
      enabled = true,
      formatters = {
        file = {
          filename_first = false,
          filename_only = false,
          icon_width = 2,
        },
      },
      sources = {
        explorer = {
          auto_close = true,
        },
      },
      layout = {
        -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
        -- override picker layout in keymaps function as a param below
        preset = "telescope", -- defaults to this layout unless overidden
        cycle = false,
      },
      layouts = {
        select = {
          preview = false,
          layout = {
            backdrop = false,
            width = 0.6,
            min_width = 80,
            height = 0.4,
            min_height = 10,
            box = "vertical",
            border = "rounded",
            title = "{title}",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
          },
        },
        telescope = {
          reverse = true, -- set to false for search bar to be on top
          layout = {
            box = "horizontal",
            backdrop = false,
            width = 0.8,
            height = 0.9,
            border = "none",
            {
              box = "vertical",
              { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
              {
                win = "input",
                height = 1,
                border = "rounded",
                title = "{title} {live} {flags}",
                title_pos = "center",
              },
            },
            {
              win = "preview",
              title = "{preview:Preview}",
              width = 0.50,
              border = "rounded",
              title_pos = "center",
            },
          },
        },
        ivy = {
          layout = {
            box = "vertical",
            backdrop = false,
            width = 0,
            height = 0.4,
            position = "bottom",
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "bottom" },
            {
              box = "horizontal",
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.5, border = "left" },
            },
          },
        },
      },
    },
    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { key = "n", desc = "New File", action = ":ene | startinsert" },
          { key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { key = "s", desc = "Restore Session", section = "session" },
          { key = "q", desc = "Quit", action = ":qa" },
        },
        header = " ⚡ Neovim",
      },
    },
    formats = { header = { "%s", align = "center" } },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { section = "startup" },
    },
  },
  scroll = {
    enabled = true,
    animate = {
      duration = { step = 10, total = 150 },
      easing = "linear",
    },
    spamming = 10, -- threshold for spamming detection
  },

  terminal = {
    enabled = true,
    win = {
      style = "terminal",
      border = vim.g.border_style,
      position = "float",
      height = 0.8,
      width = 0.8,
    },
  },
  words = { enabled = true },
  styles = {
    notification = {
      border = vim.g.border_style,
      wo = { wrap = true }, -- Wrap notifications
      history = {
        border = vim.g.border_style,
      },
    },
    scratch = {
      border = vim.g.border_style,
    },
  },
  -- NOTE: Keymaps
  keys = {
    {
      "<leader>lg",
      function()
        require("snacks").lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      function()
        require("snacks").lazygit.log()
      end,
      desc = "Lazygit Logs",
    },
    {
      "<leader>ee",
      function()
        require("snacks").explorer()
      end,
      desc = "Open Snacks Explorer",
    },
    {
      "<leader>rN",
      function()
        require("snacks").rename.rename_file()
      end,
      desc = "Fast Rename Current File",
    },
    {
      "<leader>dB",
      function()
        require("snacks").bufdelete()
      end,
      desc = "Delete or Close Buffer  (Confirm)",
    },

    -- Snacks Picker
    {
      "<leader>pf",
      function()
        require("snacks").picker.files()
      end,
      desc = "Find Files (Snacks Picker)",
    },
    {
      "<leader>pc",
      function()
        require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>ps",
      function()
        require("snacks").picker.grep()
      end,
      desc = "Grep word",
    },
    {
      "<leader>pws",
      function()
        require("snacks").picker.grep_word()
      end,
      desc = "Search Visual selection or Word",
      mode = { "n", "x" },
    },
    {
      "<leader>pk",
      function()
        require("snacks").picker.keymaps({ layout = "ivy" })
      end,
      desc = "Search Keymaps (Snacks Picker)",
    },

    -- Git Stuff
    {
      "<leader>gbr",
      function()
        require("snacks").picker.git_branches({ layout = "select" })
      end,
      desc = "Pick and Switch Git Branches",
    },

    -- Other Utils
    {
      "<leader>th",
      function()
        require("snacks").picker.colorschemes({ layout = "ivy" })
      end,
      desc = "Pick Color Schemes",
    },
    {
      "<leader>vh",
      function()
        require("snacks").picker.help()
      end,
      desc = "Help Pages",
    },
  },
}
