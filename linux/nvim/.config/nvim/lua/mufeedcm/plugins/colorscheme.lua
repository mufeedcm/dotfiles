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

	-- return {
	-- 	"AlexvZyl/nordic.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("nordic").load()
	-- 	end,
	-- }
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			vim.cmd.colorscheme("tokyonight-night")
			vim.cmd.hi("Comment gui=none")
		end,
	},
}
