-- Autocompletion plugin configuration
return {
	"hrsh7th/nvim-cmp", -- Core plugin for autocompletion
	enabled = true,
	event = "InsertEnter", -- Load this plugin when entering Insert mode
	dependencies = {
		{
			"L3MON4D3/LuaSnip", -- Snippet engine
			build = (function()
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			dependencies = {
				{
					"rafamadriz/friendly-snippets", -- Predefined snippet collection
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load() -- Lazy load VSCode-style snippets
					end,
				},
			},
		},
		"saadparwaiz1/cmp_luasnip", -- Integration between nvim-cmp and LuaSnip
		"hrsh7th/cmp-nvim-lsp", -- Source for LSP-based autocompletion
		"hrsh7th/cmp-path", -- Source for filesystem path autocompletion
		{
			"roobert/tailwindcss-colorizer-cmp.nvim", -- Tailwind CSS color preview in autocompletion
			config = true, -- Use default configuration
		},
		"hrsh7th/cmp-buffer", -- Source for buffer autocompletion
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local colorizer_cmp = require("tailwindcss-colorizer-cmp")

		-- LuaSnip setup
		luasnip.config.setup({
			enabled = true,
			enable_autosnippets = true, -- Enable auto-snippets
			store_selection_keys = "<Tab>", -- Key to store visual selection for snippet expansion
			update_events = "TextChanged,TextChangedI", -- Events to trigger snippet updates
		})

		-- Reload LuaSnip snippets with <Leader>L
		vim.keymap.set(
			"n",
			"<Leader>L",
			'<Cmd>lua require("luasnip.loaders.from_lua").load({paths = { "~/.config/nvim/lua/mufeedcm/plugins/LuaSnip/" }})<CR>'
		)

		-- Keymap for jumping to the next snippet placeholder or expanding snippets
		vim.api.nvim_set_keymap(
			"i",
			"jk",
			"luasnip.jump(1) and '<Plug>luasnip-jump-next' or 'jk'",
			{ expr = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"s",
			"jk",
			"luasnip.jump(1) and '<Plug>luasnip-jump-next' or 'jk'",
			{ expr = true, silent = true }
		)

		-- Keymap for jumping backward in snippet placeholders
		vim.api.nvim_set_keymap(
			"i",
			"<S-Tab>",
			"luasnip.jump(-1) and '<Plug>luasnip-jump-prev' or '<S-Tab>'",
			{ expr = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"s",
			"<S-Tab>",
			"luasnip.jump(-1) and '<Plug>luasnip-jump-prev' or '<S-Tab>'",
			{ expr = true, silent = true }
		)

		-- Keymap for cycling through choices in snippet placeholders
		vim.api.nvim_set_keymap(
			"i",
			"<C-j>",
			"luasnip.choice_index() ~= 0 and '<Plug>luasnip-next-choice' or '<C-j>'",
			{ expr = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"s",
			"<C-j>",
			"luasnip.choice_index() ~= 0 and '<Plug>luasnip-next-choice' or '<C-j>'",
			{ expr = true, silent = true }
		)

		-- Completion setup
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body) -- Function to expand snippet
				end,
			},
			completion = { completeopt = "menu,menuone,noinsert" }, -- Customize completion behavior
			window = {
				completion = cmp.config.window.bordered(),
				documentation = {
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:Normal",
					side = "right",
				},
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.confirm({ select = true }) -- Confirm completion with Tab
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump() -- Expand or jump for snippets
					else
						fallback() -- Fallback to normal Tab behavior
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1) -- Jump to the previous placeholder
					else
						fallback()
					end
				end, { "i", "s" }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
				["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll documentation down
				["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger completion
				["<C-e>"] = cmp.mapping.abort(), -- Abort completion
			}),
			formatting = {
				fields = { "abbr", "kind", "menu" }, -- Fields to display in the completion menu
				format = function(entry, item)
					local ok, formatted = pcall(colorizer_cmp.formatter, entry, item) -- Tailwind color preview
					if ok then
						return formatted
					end
					return item
				end,
				expandable_indicator = false, -- Disable expandable indicator
			},
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- LSP-based completion source
				{ name = "luasnip" }, -- Snippet completion source
				{ name = "path" }, -- Filesystem path completion
				{ name = "buffer" }, -- ADDED: Buffer-based completion (words in the current file)
				{
					name = "tailwindcss-colorizer-cmp",
					priority = 1000, -- High priority for Tailwind CSS source
					-- ADDED: Restrict this source to specific file types to prevent it from running everywhere
					option = {
						get_filetype = function()
							local allowed_filetypes = {
								"html",
								"css",
								"javascript",
								"javascriptreact",
								"typescriptreact",
							}
							local filetype = vim.bo.filetype
							return vim.tbl_contains(allowed_filetypes, filetype) and filetype or nil
						end,
					},
				},
			}),
		})
	end,
}
