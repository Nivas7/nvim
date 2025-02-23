return {
  "hrsh7th/nvim-cmp",
  event = { "VeryLazy", "InsertEnter" },
  enabled = true,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind.nvim",
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
    },
    { "saadparwaiz1/cmp_luasnip" },
    { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      preselect = cmp.PreselectMode.None,
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
      window = {
        completion = cmp.config.window.bordered({
          border = "single",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          border = "single",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-m>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp", keyword_length = 2 },
        { name = "luasnip" },
        { name = "path" },
      }),
      formatting = {
        format = function(entry, item)
          lspkind.cmp_format({
            mode = "symbol_text",
          })(entry, item) -- add icons
          return require("tailwindcss-colorizer-cmp").formatter(entry, item)
        end,
        fields = { "abbr", "kind" }, -- Remove 'menu' to avoid truncation
      },
      experimental = {
        ghost_text = true, -- Better Ux
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }),
    })

    vim.api.nvim_create_autocmd("CursorHold", {
      group = vim.api.nvim_create_augroup("_cancel_snippet", { clear = true }),
      desc = "Cancel snippet and avoid cursor jumping to the first line of the file",
      callback = function()
        if luasnip.expand_or_jumpable() then
          vim.cmd('silent! lua require("luasnip").unlink_current()')
        end
      end,
    })
  end,
}
