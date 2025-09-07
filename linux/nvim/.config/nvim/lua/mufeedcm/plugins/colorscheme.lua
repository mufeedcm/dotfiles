-- Color Scheme setup
return {
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	enabled = true,
	-- 	priority = 1000,
	-- 	opts = ...,
	-- 	config = function()
	-- 		vim.o.background = "dark"
	-- 		vim.cmd([[colorscheme gruvbox]])
	-- 	end,
	-- },
	--
	--
	-- {
	-- 	"RRethy/base16-nvim",
	-- 	enabled = true,
	-- 	priority = 1000,
	-- },
	--
	{
		"darianmorat/gruvdark.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = false,
			colors = {
				bg0 = "#000000",
				bg1 = "#1a1a1a",
				bg2 = "#202020",
				bg3 = "#262626",
			},
			-- highlights = {
			-- 	Normal = { bg = "#000000" },
			-- 	NormalNC = { bg = "#000000" },
			-- 	NormalFloat = { bg = "#000000" },
			-- 	SignColumn = { bg = "#000000" },
			-- 	EndOfBuffer = { fg = "#000000" },
			-- 	Visual = { bg = "#333333" },
			-- },
		},
		config = function(_, opts)
			require("gruvdark").setup(opts)
			vim.cmd.colorscheme("gruvdark")
			vim.o.background = "dark"
		end,
	},

	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	enabled = true,
	-- 	priority = 1000,
	-- 	opts = {
	-- 		contrast = "hard", -- optional, for more punchy colors
	-- 		transparent_mode = false,
	-- 	},
	-- 	config = function()
	-- 		vim.o.background = "dark"
	-- 		vim.cmd.colorscheme("gruvbox")
	--
	-- 		-- Set background to pure black
	-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
	-- 		vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" })
	-- 	end,
	-- },

	-- return {
	-- 	"AlexvZyl/nordic.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("nordic").load()
	-- 	end,
	-- }
	--
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	priority = 1000, -- Load before other plugins
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			style = "night", -- Choose your preferred style
	-- 			on_highlights = function(hl, c)
	-- 				hl.WinSeparator = { fg = c.blue, bg = c.bg } -- Customize the separator color
	-- 			end,
	-- 		})
	-- 		vim.cmd.colorscheme("tokyonight-night")
	-- 		vim.cmd.hi("Comment gui=none")
	-- 	end,
	-- },
	-- {
	-- -- normal tokyonight
	-- 	"folke/tokyonight.nvim",
	-- 	priority = 1000, -- Make sure to load this before all the other start plugins.
	-- 	init = function()
	-- 		vim.cmd.colorscheme("tokyonight-night")
	-- 		vim.cmd.hi("Comment gui=none")
	-- 	end,
	-- },

	-- {
	-- 	-- tokyonight with bg black
	-- 	"folke/tokyonight.nvim",
	-- 	priority = 1000,
	-- 	init = function()
	-- 		vim.cmd.colorscheme("tokyonight-night")
	--
	-- 		-- Make background pure black
	-- 		vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
	-- 		vim.api.nvim_set_hl(0, "NormalNC", { bg = "#000000" }) -- Inactive windows too
	-- 		vim.api.nvim_set_hl(0, "Comment", { italic = false }) -- You already did this but now using modern style
	-- 	end,
	-- },
}
