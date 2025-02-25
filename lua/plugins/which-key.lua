---Set up plugin-specific groups cleanly with the plugin config
---@param spec wk.Spec
vim.g.whichkeyAddSpec = function(spec)
  if not spec.mode then
    spec.mode = { "n", "x" }
  end
  -- Deferred to ensure spec is loaded after whichkey itself
  vim.defer_fn(function()
    require("which-key").add(spec)
  end, 1500)
end

--------------------------------------------------------------------------------

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>iK",
      -- alternative: `:Telescope keymaps` with `only_buf = true`
      function()
        require("which-key").show({ global = false })
      end,
      desc = "⌨️ Keymaps (buffer)",
    },
  },
  opts = {
    delay = 444,

    -- https://github.com/folke/which-key.nvim/blob/main/lua/which-key/presets.lua
    preset = "helix",
    win = {
      border = vim.g.borderStyle,
      height = { min = 1, max = 0.99 },
      no_overlap = false, -- `false` = allow popup over the cursor
    },

    spec = {
      { -- leader subgroups
        mode = { "n", "x" },
        { "<leader>", group = "󰓎 Leader" },
        { "<leader>c", group = " Code action" },
        { "<leader>e", group = "󰓗 Execute" },
        { "<leader>r", group = "󱗘 Refactor" },
        { "<leader>g", group = "󰊢 Git" },
        { "<leader>i", group = "󱈄 Inspect" },
        { "<leader>o", group = "󰒓 Option toggle" },
        { "<leader>p", group = "󰏗 Packages" },
        { "<leader>q", group = " Quickfix" },
        { "<leader>u", group = "󰕌 Undo" },
      },
      { -- not using `text_objects` preset, since it's too crowded
        mode = { "o", "x" },
        { "r", group = "rest of" },
        { "i", group = "inner" },
        { "a", group = "outer" },
        { "g", group = "misc" },
        { "ip", desc = "¶ paragraph" },
        { "ap", desc = "¶ paragraph" },
        { "ib", desc = "󰅲 bracket" },
        { "ab", desc = "󰅲 bracket" },
        { "it", desc = " tag" },
        { "at", desc = " tag" },
        { "is", desc = "󰰢 sentence" },
        { "as", desc = "󰰢 sentence" },
        { "iw", desc = "󰬞 word" },
        { "aw", desc = "󰬞 word" },
        { "gn", desc = " search result" },
      },
      { -- base groups
        mode = { "n", "x" },
        { "g", group = "Goto" },
        { "z", group = "Fold & spelling" },
      },
    },
    plugins = {
      marks = false,
      registers = false,
      spelling = { enabled = false },
      presets = {
        motions = false,
        g = false,
        text_objects = false,
        z = false,
        nav = false,
        operator = false,
      },
    },
    filter = function(map)
      -- need to remove comment mapping shere, since they are nvim-builtins
      -- that do still show up with disabled whichkey-preset
      local nvimBultins = { "gc", "gcc", "]d", "zf", "g~", "gu", "gU", "<C-W><C-D>", "<C-W>d" }
      if vim.tbl_contains(nvimBultins, map.lhs) then
        return false
      end

      return map.desc ~= nil
    end,
    replace = {
      desc = { -- redundant info for when displayed in which-key
        { " outer ", " " },
        { " inner ", " " },
        { " rest of ", " " },
      },
    },
    icons = {
      group = "", -- different color for groups already distinguishable enough
      separator = "│",
      mappings = false, -- disable icons for keymaps.
      -- NOTE unfortuenately, we cannot get icons from the keymap
      -- descriptions, so we just use the icons from there and disable
      -- whickey's icon features
    },
    keys = {
      scroll_down = "<PageDown>",
      scroll_up = "<PageUp>",
    },
    show_help = false,
  },
}
