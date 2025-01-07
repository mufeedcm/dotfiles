return {
	{
		enabled = false,
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
}
