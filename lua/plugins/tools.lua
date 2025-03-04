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
