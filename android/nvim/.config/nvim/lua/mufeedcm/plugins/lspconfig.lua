-- LSP Plugins
--
return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition") -- <C-t> to jump back
					map("gr", require("telescope.builtin").lsp_references, "Goto References")
					map("gI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type lsp_definition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
					map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Worksapce Symbols")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "Goto Declaration")

					-- Highlight the references under teh curser
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						-- To clear the highlight under the curser
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

					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Change diagnostic symbols in the sign column (gutter)
			if vim.g.have_nerd_font then
				local signs = { Error = "", Warn = "", Hint = "", Info = "" }
				for type, icon in pairs(signs) do
					local hl = "DiagnosticSign" .. type
					vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
				end
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local servers = {
				html = {},
				cssls = {},
				svelte = {},
				tailwindcss = {},
				--
				-- clangd = {
				-- 	cmd = { "clangd" },
				-- 	filetypes = { "c", "cpp" },
				-- },
				-- pyright = {},
				ts_ls = {},
				-- lua_ls = {
				-- 	settings = {
				-- 		Lua = {
				-- 			completion = {
				-- 				callSnippet = "Replace",
				-- 			},
				-- 		},
				-- 	},
				-- },
				-- -- Latex Setup

				-- texlab = {
				-- 	cmd = { "texlab" },
				-- 	filetypes = { "tex", "plaintex", "bib" },
				-- 	settings = {
				-- 		auxDirectory = ".",
				-- 		bibtexFormatter = "texlab",
				-- 		build = {
				-- 			executable = "tectonic",
				-- 			args = {
				-- 				"-X",
				-- 				"compile",
				-- 				"%f",
				-- 				"--synctex",
				-- 				"--keep-logs",
				-- 				"--keep-intermediates",
				-- 			},
				-- 			forwardSearchAfter = true,
				-- 			onSave = true,
				-- 		},
				-- 		chktex = {
				-- 			onEdit = false,
				-- 			onOpenAndSave = false,
				-- 		},
				-- 		diagnosticsDelay = 300,
				-- 		formatterLineLength = 80,
				-- 		forwardSearch = {
				-- 			executable = "zathura",
				-- 			args = {
				-- 				"--synctex-forward",
				-- 				"%l:1:%f",
				-- 				"%p",
				-- 			},
				-- 		},
				-- 	},
				-- },
			}
			require("mason").setup()
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				-- "isort",
				-- "black",
				-- "stylua",
				"eslint_d",
				-- "pylint",
				-- "clang-format",
				-- "latexindent",
				-- "luacheck",
				"prettierd",
				"prettier",
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
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
