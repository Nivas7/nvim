return {
	"hrsh7th/nvim-cmp",
	event = "VeryLazy",
	enabled = vim.g.cmp_enable,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-emoji",
		"garymjr/nvim-snippets",
		{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			preselect = cmp.PreselectMode.None,
			completion = {
				completeopt = "menu,menuone,noinsert,noselect",
			},
			mapping = {
				["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-k>"] = cmp.mapping.scroll_docs(-4),
				["<C-j>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-e>"] = cmp.mapping.abort(), -- close completion window
				["<Esc>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
			},
			sources = cmp.config.sources({
				{ name = "lazydev", group_index = 0 },
				{ name = "nvim_lsp", keyword_length = 2 },
				{
					name = "snippets",
					keyword_length = 3,
					entry_filter = function()
						local ctx = require("cmp.config.context")
						local in_string = ctx.in_syntax_group("String") or ctx.in_treesitter_capture("string")
						local in_comment = ctx.in_syntax_group("Comment") or ctx.in_treesitter_capture("comment")
						return not in_string and not in_comment
					end,
				},
			}, {
				{ name = "buffer", keyword_length = 3 },
				{ name = "emoji" },
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
		})

		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
		})
	end,
}
