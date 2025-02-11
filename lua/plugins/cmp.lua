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
				["<CR>"] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert }),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<Up>"] = cmp.mapping.select_prev_item(cmp_select_opts),
				["<Down>"] = cmp.mapping.select_next_item(cmp_select_opts),
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select_opts),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select_opts),
				["<C-y>"] = cmp.mapping.complete(),
			},
			sources = cmp.config.sources({
				{ name = "lazydev",  group_index = 0 },
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
