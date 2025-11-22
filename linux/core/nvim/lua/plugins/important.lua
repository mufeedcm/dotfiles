return {
	-- file tree
	{
		"stevearc/oil.nvim",
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
				view_options = {
					show_hidden = true,
					natural_order = true,
				},
				win_options = {
					wrap = true,
				},
			})
			vim.keymap.set("n", "<leader>e", function()
				if vim.bo.filetype == "oil" then
					vim.cmd("bd")
				else
					vim.cmd("Oil")
				end
			end, { desc = "Toggle parent directory" })
		end,
	},
	-- git
	{
		{
			"tpope/vim-fugitive",
		},
		{
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup()
			end,
		},
	},
	-- Indentation
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			indent = { char = "┊" },
		},
		main = "ibl",
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  -- Which key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			icons = {
				mappings = vim.g.have_nerd_font,
			},
			spec = {
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>g", group = "[L]sp" },
				-- { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
				-- { "<leader>d", group = "[D]ocument" },
				-- { "<leader>r", group = "[R]ename" },
				-- { "<leader>w", group = "[W]orkspace" },
				-- { "<leader>t", group = "[T]oggle" },
				-- { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	-- color preview
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
}
