-- [] mini.nvimluasnip
-- [] mini.starter
-- [] mini.surround
-- [] mini.statusline
-- [] indent-blankline
-- [] nvim-autopars
-- [] nvim-ts-autotab
-- [] bufferline
-- [] nvim-tree
-- [] fugitive
-- [] oil.nvim
-- [x] noice.nvim
-- [] which-key
-- [] nvim-colorizer
-- [] tailwindcss-colorizer-cmp
-- [] alpha-nvim
-- [] supermaven
-- [x] codeium.nvim
-- [x] flash.nvim

return {
	-- {
	-- 	"3rd/image.nvim",
	-- 	opts = {},
	-- },
	-- ----------------------------------------
	-- Mini.nvim plugins
	{
		"echasnovski/mini.nvim",
		config = function()
			-- ----------------------------------------
			require("mini.indentscope").setup()
			-- ----------------------------------------
			require("mini.ai").setup({ n_lines = 500 })
			-- Better Around/Inside textobjects
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote

			-- ----------------------------------------
			require("mini.surround").setup({
				-- Add/delete/replace surroundings (brackets, quotes, etc.)
				-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
				-- - sd'   - [S]urround [D]elete [']quotes
				-- - sr)'  - [S]urround [R]eplace [)] [']
				mappings = {
					add = "sa", -- Add surrounding in Normal and Visual modes
					delete = "sd", -- Delete surrounding
					find = "sf", -- Find surrounding (to the right)
					find_left = "sF", -- Find surrounding (to the left)
					highlight = "sh", -- Highlight surrounding
					replace = "sr", -- Replace surrounding
					update_n_lies = "sn", -- Update `n_lines`

					suffix_last = "l", -- Suffix to search with "prev" method
					suffix_next = "n", -- Suffix to search with "next" method
				},
			})
			-- ----------------------------------------
			require("mini.starter").setup({
				evaluate_single = false,
				footer = os.date(),
			})
			local function remap_navigation(args)
				vim.keymap.set("n", "<C-j>", function()
					vim.api.nvim_input("<C-n>")
				end, { buffer = args.buf })
				vim.keymap.set("n", "<C-k>", function()
					vim.api.nvim_input("<C-p>")
				end, { buffer = args.buf })
			end
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniStarterOpened",
				callback = remap_navigation,
			})
			-- ----------------------------------------
			-- require("mini.statusline").setup({
			-- 	use_icons = vim.g.have_nerd_font,
			-- 	content = {
			-- 		active = function()
			-- 			local check_macro_recording = function()
			-- 				if vim.fn.reg_recording() ~= "" then
			-- 					return "Recording @" .. vim.fn.reg_recording()
			-- 				else
			-- 					return ""
			-- 				end
			-- 			end
			-- 			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			-- 			local git = MiniStatusline.section_git({ trunc_width = 40 })
			-- 			local diff = MiniStatusline.section_diff({ trunc_width = 75 })
			-- 			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			-- 			-- local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
			-- 			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			-- 			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			-- 			local location = MiniStatusline.section_location({ trunc_width = 200 })
			-- 			local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
			-- 			local macro = check_macro_recording()
			-- 			return MiniStatusline.combine_groups({
			-- 				{ hl = mode_hl, strings = { mode } },
			-- 				{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
			-- 				"%<", -- Mark general truncate point
			-- 				{ hl = "MiniStatuslineFilename", strings = { filename } },
			-- 				"%=", -- End left alignment
			-- 				{ hl = "MiniStatuslineFilename", strings = { macro } },
			-- 				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
			-- 				{ hl = mode_hl, strings = { search, location } },
			-- 			})
			-- 		end,
			-- 	},
			-- })
		end,
	},
	-- ----------------------------------------
	-- indent lines
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			indent = { char = "┊" },
		},
		main = "ibl",
	},
	-- ----------------------------------------
	-- Auto Pair brackets
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup({})
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	-- ----------------------------------------
	-- Auto tag
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
				per_filetype = {
					["html"] = {
						enable_close = false,
					},
				},
			})
		end,
	},
	-- ----------------------------------------
	-- Tab Bar
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	dependencies = "kyazdani42/nvim-web-devicons",
	-- 	--[[ tag = "v3.*", ]]
	-- 	config = function()
	-- 		local status_ok, bufferline = pcall(require, "bufferline")
	-- 		if not status_ok then
	-- 			return
	-- 		end
	-- 		vim.opt.termguicolors = true
	-- 		bufferline.setup({
	-- 			options = {
	-- 				style_preset = require("bufferline").style_preset.no_italic,
	-- 			},
	-- 		})
	--
	-- 		-- Navigate buffers
	-- 		vim.keymap.set("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true })
	-- 		vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { noremap = true, silent = true })
	-- 		vim.keymap.set("n", "<leader>x", "<cmd> bp|sp|bn|bd! <CR>", { noremap = true, silent = true })
	-- 	end,
	-- },
	-- ----------------------------------------
	-- File tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
		},
		opts = {
			filesystem = {
				window = {
					mappings = {
						["\\"] = "close_window",
					},
				},
			},
		},
	},
	-- ----------------------------------------
	-- Git setup
	{
		"tpope/vim-fugitive",
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	-- ----------------------------------------
	-- File tree
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		dependencies = {
			{
				"echasnovski/mini.icons",
				opts = {},
			},
		},
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				delete_to_trash = false,
				skip_confirm_for_simple_edits = true,
				columns = { "icon" },
				keymaps = {
					["<C-h>"] = false,
					["<M-h>"] = "actions.select_split",
				},
				view_options = {
					show_hidden = true,
					natural_order = true,
				},
				win_options = {
					wrap = true,
				},
				-- float = {
				-- 	-- Padding around the floating window
				-- 	padding = 8,
				-- 	max_width = 50,
				-- 	max_height = 0,
				-- 	border = "rounded",
				-- 	win_options = {
				-- 		winblend = 0,
				-- 	},
				-- },
			})

			vim.keymap.set("n", "<leader>O", "<CMD>Oil<CR>", { desc = "Toggle parent directory" })
			vim.keymap.set("n", "<leader>o", require("oil").toggle_float, { desc = "Toggle floating directory" })
		end,
	},
	-- ----------------------------------------
	-- cool messages
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {},
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- 	init = function()
	-- 		require("noice").setup({
	-- 			lsp = {
	-- 				override = {
	-- 					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 					["vim.lsp.util.stylize_markdown"] = true,
	-- 					["cmp.entry.get_documentation"] = true,
	-- 				},
	-- 			},
	--
	-- 			presets = {
	-- 				bottom_search = true, -- use a classic bottom cmdline for search
	-- 				command_palette = true, -- position the cmdline and popupmenu together
	-- 				long_message_to_split = true, -- long messages will be sent to a split
	-- 				inc_rename = false, -- enables an input dialog for inc-rename.nvim
	-- 				lsp_doc_border = false, -- add a border to hover docs and signature help
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- ----------------------------------------
	-- Keybinds preview
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
		opts = {
			preset = "helix",
			icons = {
				mappings = vim.g.have_nerd_font,
			},
			spec = {
				{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
	},
	-- ----------------------------------------
	-- Color colorizer
	{

		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true,
				},
			})
		end,
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},

	----------------------------------------
	-- --	dash board
	-- {
	-- 	"goolord/alpha-nvim",
	-- 	dependencies = {
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	--
	-- 	config = function()
	-- 		local alpha = require("alpha")
	-- 		local dashboard = require("alpha.themes.dashboard")
	-- 		dashboard.section.header.val = {
	-- 			"                                                     ",
	-- 			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
	-- 			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
	-- 			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
	-- 			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	-- 			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	-- 			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
	-- 			"                                                     ",
	-- 		}
	--
	-- 		dashboard.section.buttons.val = {
	-- 			dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	-- 			dashboard.button("f", "  Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
	-- 			dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
	-- 			dashboard.button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
	-- 			dashboard.button("q", "󰿅  Quit", ":qa<CR>"),
	-- 		}
	-- 		alpha.setup(dashboard.opts)
	-- 		vim.cmd([[
	-- 		 autocmd FileType alpha setlocal nofoldenable
	-- 		]])
	-- 	end,
	-- },
	--
	--
	-- ----------------------------------------
	-- Supermaven
	--
	-- {
	-- 	"supermaven-inc/supermaven-nvim",
	-- 	config = function()
	-- 		require("supermaven-nvim").setup({})
	-- 	end,
	-- },
	--
	-- ----------------------------------------
	-- Codeium
	{
		-- "Exafunction/codeium.nvim",
		-- dependencies = {
		-- 	"nvim-lua/plenary.nvim",
		-- 	"hrsh7th/nvim-cmp",
		-- },
		-- config = function()
		-- 	require("codeium").setup({
		-- 		enable_cmp_source = false,
		-- 		virtual_text = {
		-- 			enabled = true,
		-- 			manual = false,
		-- 			filetypes = {},
		-- 			default_filetype_enabled = true,
		-- 			idle_delay = 75,
		-- 			virtual_text_priority = 65535,
		-- 			map_keys = true,
		-- 			accept_fallback = nil,
		-- 			key_bindings = {
		-- 				accept = "<Tab>",
		-- 				accept_word = false,
		-- 				accept_line = false,
		-- 				clear = false,
		-- 			},
		-- 		},
		-- 	})
		-- end,
	},
	-- ----------------------------------------
	{
		-- "folke/flash.nvim",
		-- event = "VeryLazy",
		-- ---@type Flash.Config
		-- opts = {},
		--  -- stylua: ignore
		--  keys = {
		--    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		--    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		--    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		--    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		--    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		--  },
	},
	-- ----------------------------------------
}
