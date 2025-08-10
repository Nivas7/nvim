return {
  {
    "echasnovski/mini.nvim",
    config = function()
      local gen_spec = require("mini.ai").gen_spec
      local gen_ai_spec = require("mini.extra").gen_ai_spec
      require("mini.ai").setup({
        custom_textobjects = {
          -- Make `|` select both edges in non-balanced way
          ["|"] = gen_spec.pair("|", "|", { type = "non-balanced" }),
          a = require("mini.ai").gen_spec.argument({ brackets = { "%b()" } }),

          -- Tweak function call to not detect dot in function name
          f = gen_spec.function_call({ name_pattern = "[%w_]" }),

          -- Function definition (needs treesitter queries with these captures)
          F = gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          o = gen_spec.treesitter({
            a = { "@conditional.outer", "@loop.outer" },
            i = { "@conditional.inner", "@loop.inner" },
          }),
          c = gen_spec.treesitter({
            i = { "@class.inner" },
            a = { "@class.outer" },
          }),

          g = gen_ai_spec.buffer(),
          D = gen_ai_spec.diagnostic(),
          I = gen_ai_spec.indent(),
          L = gen_ai_spec.line(),
          N = gen_ai_spec.number(),
        },
      })
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require("mini.surround").setup()

      require("mini.pairs").setup()

      require("mini.comment").setup()

      require("mini.colors").setup()


      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end,
  },

  {
    "echasnovski/mini.icons",
    enabled = true,
    opts = {},
    lazy = true,
  },
}
