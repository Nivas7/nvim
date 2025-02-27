return {
  "saghen/blink.cmp",
  lazy = true,
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "none",
      ["<CR>"] = { "select_and_accept", "fallback" },
      ["<S-CR>"] = { "hide" }, -- `hide` keeps `auto_insert`, `cancel` does not
      ["<C-space>"] = { "show" },
      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<PageDown>"] = { "scroll_documentation_down", "fallback" },
      ["<PageUp>"] = { "scroll_documentation_up", "fallback" },
    },
    cmdline = {
      keymap = {
        preset = "enter",
        ["<CR>"] = { "accept_and_enter", "fallback" },
      },
    },
    appearance = {
      -- supported: tokyonight, nightfox
      -- not supported: gruvbox-material
      use_nvim_cmp_as_default = false,

      nerd_font_variant = "normal",
      kind_icons = {
        -- different icons of the corresponding source
        Text = "󰉿", -- `buffer`
        Snippet = "󰞘", -- `snippets`
        File = "", -- `path`

        Folder = "󰉋",
        Method = "󰊕",
        Function = "󰡱",
        Constructor = "",
        Field = "󰇽",
        Variable = "󰀫",
        Class = "󰜁",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Color = "󰏘",
        Reference = "",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰅲",
      },
    },
    completion = {
      menu = {
        border = vim.g.borderStyle,
        draw = {
          align_to = "none", -- keep in place
          treesitter = { "lsp" },
          columns = {
            { "label", "label_description", "kind_icon", gap = 1 },
          },
          components = {
            label = { width = { max = 35 } },
            label_description = { width = { max = 20 } },
            kind_icon = {
              text = function(ctx)
                -- detect emmet-ls
                local source, client = ctx.item.source_id, ctx.item.client_id
                local lspName = client and vim.lsp.get_client_by_id(client).name
                if lspName == "emmet_language_server" then
                  source = "emmet"
                end

                -- use source-specific icons, and `kind_icon` only for items from LSPs
                local sourceIcons = {
                  git = "󰊢",
                  snippets = "󰩫",
                  buffer = "󰦨",
                  emmet = "",
                  path = "",
                  cmdline = "󰘳",
                }
                return sourceIcons[source] or ctx.kind_icon
              end,
            },
          },
        },
      },
      list = {
        cycle = { from_top = false }, -- cycle at bottom, but not at the top
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        window = {
          border = vim.g.borderStyle,
          max_width = 50,
          max_height = 20,
        },
      },
      ghost_text = {
        enabled = false,
      },
    },
    signature = {
      enabled = true,
    },

    sources = {
      per_filetype = {
        ["rip-substitute"] = { "buffer" },
        gitcommit = {},
      },

      providers = {
        lsp = {
          fallbacks = {}, -- do not use `buffer` as fallback
          enabled = function()
            if vim.bo.ft ~= "lua" then
              return true
            end

            -- prevent useless suggestions when typing `--` in lua, but
            -- keep the useful `---@param;@return` suggestion
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local charsBefore = vim.api.nvim_get_current_line():sub(col - 2, col)
            local luadocButNotComment = not charsBefore:find("^%-%-?$") and not charsBefore:find("%s%-%-?")
            return luadocButNotComment
          end,
        },
        snippets = {
          -- don't show when triggered manually (= length 0), useful
          -- when manually showing completions to see available fields
          min_keyword_length = 1,
          score_offset = -1,
          opts = { clipboard_register = "+" }, -- register to use for `$CLIPBOARD`
        },
        path = {
          opts = { get_cwd = vim.uv.cwd },
        },
        buffer = {
          max_items = 4,
          min_keyword_length = 4,

          -- with `-7`, typing `then` in lua prioritize the `then .. end`
          -- snippet, effectively acting as `nvim-endwise`
          score_offset = -7,

          opts = {
            -- show completions from all buffers used within the last x minutes
            get_bufnrs = function()
              local mins = 15
              local allOpenBuffers = vim.fn.getbufinfo({ buflisted = 1, bufloaded = 1 })
              local recentBufs = vim
                .iter(allOpenBuffers)
                :filter(function(buf)
                  local recentlyUsed = os.time() - buf.lastused < (60 * mins)
                  local nonSpecial = vim.bo[buf.bufnr].buftype == ""
                  return recentlyUsed and nonSpecial
                end)
                :map(function(buf)
                  return buf.bufnr
                end)
                :totable()
              return recentBufs
            end,
          },
        },
      },
    },
  },
}
