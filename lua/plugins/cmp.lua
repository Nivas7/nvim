return {
  "hrsh7th/nvim-cmp",
  -- event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- autocompletion
    "rafamadriz/friendly-snippets", -- snippets
    "onsails/lspkind.nvim", -- vs-code pictograms
    "roobert/tailwindcss-colorizer-cmp.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local colorizer = require("tailwindcss-colorizer-cmp").formatter

    local rhs = function(keys)
      return vim.api.nvim_replace_termcodes(keys, true, true, true)
    end

    local lsp_kinds = {
      Class = " ",
      Color = " ",
      Constant = " ",
      Constructor = " ",
      Enum = " ",
      EnumMember = " ",
      Event = " ",
      Field = " ",
      File = " ",
      Folder = " ",
      Function = " ",
      Interface = " ",
      Keyword = " ",
      Method = " ",
      Module = " ",
      Operator = " ",
      Property = " ",
      Reference = " ",
      Snippet = " ",
      Struct = " ",
      Text = " ",
      TypeParameter = " ",
      Unit = " ",
      Value = " ",
      Variable = " ",
    }

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      experimental = {
        -- HACK: experimenting with ghost text
        -- look at `toggle_ghost_text()` function below.
        ghost_text = true,
      },
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      window = {
        documentation = {
          border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
        completion = {
          border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
        },
      },
      -- config nvim cmp to work with snippet engine
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      -- autocompletion sources
      sources = cmp.config.sources({
        { name = "luasnip" }, -- snippets
        { name = "nvim_lsp" },
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
        { name = "tailwindcss-colorizer-cmp" },
      }),
      -- mapping = cmp.mapping.preset.insert({
      --     ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      --     ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
      --     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      --     ["<C-f>"] = cmp.mapping.scroll_docs(4),
      --     ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      --     ["<C-e>"] = cmp.mapping.abort(), -- close completion window
      --     ["<CR>"] = cmp.mapping.confirm({ select = false }),
      -- }),

      -- NOTE: ! Experimenting with Customized Mappings ! --
      mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }),
      -- setup lspkind for vscode pictograms in autocompletion dropdown menu
      formatting = {
        format = function(entry, vim_item)
          -- Add custom lsp_kinds icons
          vim_item.kind = string.format("%s %s", lsp_kinds[vim_item.kind] or "", vim_item.kind)

          -- add menu tags (e.g., [Buffer], [LSP])
          vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[LaTeX]",
          })[entry.source.name]

          -- use lspkind and tailwindcss-colorizer-cmp for additional formatting
          vim_item = lspkind.cmp_format({
            maxwidth = 30,
            ellipsis_char = "...",
          })(entry, vim_item)

          if entry.source.name == "nvim_lsp" then
            vim_item = colorizer(entry, vim_item)
          end

          return vim_item
        end,
        -- format = lspkind.cmp_format({
        --         maxwidth = 30,
        --         ellipsis_char = "...",
        --         before = require("tailwindcss-colorizer-cmp").formatter
        -- }),
        -- format = require("tailwindcss-colorizer-cmp").formatter
      },
    })

    -- NOTE: Added Ghost text stuff
    -- Only show ghost text at word boundaries, not inside keywords. Based on idea
    -- from: https://github.com/hrsh7th/nvim-cmp/issues/2035#issuecomment-2347186210

    local config = require("cmp.config")
    local toggle_ghost_text = function()
      if vim.api.nvim_get_mode().mode ~= "i" then
        return
      end

      local cursor_column = vim.fn.col(".")
      local current_line_contents = vim.fn.getline(".")
      local character_after_cursor = current_line_contents:sub(cursor_column, cursor_column)

      local should_enable_ghost_text = character_after_cursor == ""
        or vim.fn.match(character_after_cursor, [[\k]]) == -1

      local current = config.get().experimental.ghost_text
      if current ~= should_enable_ghost_text then
        config.set_global({
          experimental = {
            ghost_text = should_enable_ghost_text,
          },
        })
      end
    end

    vim.api.nvim_create_autocmd({ "InsertEnter", "CursorMovedI" }, {
      callback = toggle_ghost_text,
    })
    -- ! Ghost text stuff ! --
  end,
}
