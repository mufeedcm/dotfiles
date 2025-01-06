return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Autocompletion integration
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- Enhanced capabilities for LSP
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

			-- Keybindings for LSP
			local function on_attach(client, bufnr)
				local buf_set_keymap = function(mode, lhs, rhs, desc)
					vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
				end

				buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition")
				buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", "References")
				buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation")
				buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Symbol")
				buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Actions")
				buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", "Show Diagnostics")
				buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous Diagnostic")
				buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic")
			end

			-- LSP server configurations
			local servers = {
				lua_ls = { -- Lua (sumneko)
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							diagnostics = { globals = { "vim" } },
							workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
							telemetry = { enable = false },
						},
					},
				},
				html = {}, -- HTML
				cssls = {}, -- CSS
				ts_ls = {}, -- JavaScript and TypeScript
				tailwindcss = { -- Tailwind CSS
					filetypes = { "html", "css", "javascript", "javascriptreact", "typescriptreact" },
				},
				svelte = {}, -- Svelte
				astro = {}, -- Astro
				-- marksman = {},
				-- clangd = {
				-- 	cmd = { "clangd" },
				-- 	filetypes = { "c", "cpp" },
				-- },
				-- pyright = {},
				-- gols = {
				-- 	cmd = { "gopls" },
				-- 	filetypes = { "go", "gomod" },
				-- 	root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
				-- 	settings = {
				-- 		gopls = {
				-- 			analyses = {
				-- 				unusedparams = true,
				-- 			},
				-- 			staticcheck = true,
				-- 		},
				-- 	},
				-- },
			}

			-- Set up servers
			for server, config in pairs(servers) do
				lspconfig[server].setup(vim.tbl_extend("force", {
					capabilities = capabilities,
					on_attach = on_attach,
				}, config))
			end

			-- Diagnostic symbols in the sign column
			local signs = { Error = "", Warn = "", Hint = "", Info = "" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end,
	},
}
