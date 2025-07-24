return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					local l = vim.lsp
					l.handlers["textDocument/hover"] = function(_, result, ctx, config)
						config = config or { border = "rounded", focusable = true }
						config.focus_id = ctx.method
						if not (result and result.contents) then
							return
						end
						local markdown_lines = l.util.convert_input_to_markdown_lines(result.contents)
						markdown_lines = vim.tbl_filter(function(line)
							return line ~= ""
						end, markdown_lines)
						if vim.tbl_isempty(markdown_lines) then
							return
						end
						return l.util.open_floating_preview(markdown_lines, "markdown", config)
					end

					local autocmd = vim.api.nvim_create_autocmd

					autocmd({ "BufEnter", "BufWinEnter" }, {
						pattern = { "*.vert", "*.frag" },
						callback = function(e)
							vim.cmd("set filetype=glsl")
						end,
					})

					autocmd("LspAttach", {
						callback = function(e)
							local opts = { buffer = e.buf }
							vim.keymap.set("n", "gd", function()
								vim.lsp.buf.definition()
							end, opts)
							vim.keymap.set("n", "K", function()
								vim.lsp.buf.hover()
							end, opts)
							vim.keymap.set("n", "<leader>lf ", vim.lsp.buf.format)
							vim.keymap.set("n", "<leader>la", function()
								vim.lp.buf.code_action()
							end, opts)
							vim.keymap.set("n", "<leader>lr", function()
								vim.lsp.buf.rename()
							end, opts)
							vim.keymap.set("n", "<leader>k", function()
								vim.diagnostic.open_float()
							end, opts)
						end,
					})
					-- When you move your cursor, the highlights will be cleared (the second autocommand).

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if
						client
						and client_supports_method(
							client,
							vim.lsp.protocol.Methods.textDocument_documentHighlight,
							event.buf
						)
					then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN] = " ",
						[vim.diagnostic.severity.HINT] = " ",
						[vim.diagnostic.severity.INFO] = "󰔨 ",
					},
				} or {},
				virtual_text = {
					source = "if_many",
					spacing = 2,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("blink.cmp").get_lsp_capabilities()
			)

			local servers = {
				lua_ls = {
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
							workspace = {
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				},
				ts_ls = {
					capabilities = capabilities,
					single_file_support = false,
					on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = false
					end,
					init_options = {
						preferences = {
							includeCompletionsWithSnippetText = true,
							includeCompletionsForImportStatements = true,
						},
					},
				},
				gopls = { capabilities = capabilities },
				html = { capabilities = capabilities },
				cssls = { capabilities = capabilities },
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
