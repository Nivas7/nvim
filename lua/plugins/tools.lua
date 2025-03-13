return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- import comment plugin safely
      local comment = require("Comment")

      local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

      -- enable comment
      comment.setup({
        -- for commenting tsx, jsx, svelte, html files
        pre_hook = ts_context_commentstring.create_pre_hook(),
      })
    end,
  },
  {
    -- Quickly Jump through the todo tags
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local todo_comments = require("todo-comments")

      todo_comments.setup({
        keywords = {
          FIX = {
            icon = " ", -- icon used for the sign, and in search results
            color = "error", -- can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
            -- signs = false, -- configure signs for some keywords individually
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning", alt = { "DON SKIP" } },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO", "READ", "COLORS" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
      })

      -- keymaps
      vim.keymap.set("n", "]t", function()
        todo_comments.jump_next()
      end, { desc = "Next todo comment" })

      vim.keymap.set("n", "[t", function()
        todo_comments.jump_prev()
      end, { desc = "Previous todo comment" })
    end,
  },
  {
    "Wansmer/treesj",
    keys = {
      {
        "<leader>s",
        function()
          require("treesj").toggle()
        end,
        desc = "󰗈 Split-join lines",
      },
      { "<leader>s", "gw}", ft = "markdown", desc = "󰗈 Reflow rest of paragraph" },
    },
    opts = {
      use_default_keymaps = false,
      cursor_behavior = "start",
      max_join_length = math.huge,
    },
    config = function(_, opts)
      local gww = { both = {
        fallback = function()
          vim.cmd("normal! gww")
        end,
      } }
      local joinWithoutCurly = {
        -- remove curly brackets in js when joining if statements https://github.com/Wansmer/treesj/issues/150
        statement_block = {
          join = {
            format_tree = function(tsj)
              if tsj:tsnode():parent():type() == "if_statement" then
                tsj:remove_child({ "{", "}" })
                tsj:update_preset({ recursive = false }, "join")
              else
                require("treesj.langs.javascript").statement_block.join.format_tree(tsj)
              end
            end,
          },
        },
        -- one-line-if-statement can be split into multi-line https://github.com/Wansmer/treesj/issues/150
        expression_statement = {
          join = { enable = false },
          split = {
            enable = function(tsn)
              return tsn:parent():type() == "if_statement"
            end,
            format_tree = function(tsj)
              tsj:wrap({ left = "{", right = "}" })
            end,
          },
        },
        return_statement = {
          join = { enable = false },
          split = {
            enable = function(tsn)
              return tsn:parent():type() == "if_statement"
            end,
            format_tree = function(tsj)
              tsj:wrap({ left = "{", right = "}" })
            end,
          },
        },
      }
      opts.langs = {
        comment = { source = gww, element = gww }, -- comments in any language
        lua = { comment = gww },
        jsdoc = { source = gww, description = gww },
        javascript = joinWithoutCurly,
        typescript = joinWithoutCurly,
      }
      require("treesj").setup(opts)
    end,
  },
}
