-- Color Scheme setup
return {
-- {
--   "gambhirsharma/vesper.nvim",
--   lazy = false,
--   priority = 1000,
--   name = "vesper",
--   config = function ()
--    vim.cmd([[colorscheme vesper]])
--   end
-- },
	{
		"darianmorat/gruvdark.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = false,
			colors = {
				bg0 = "#000000",
				-- bg1 = "#000000",
				-- bg2 = "#000000",
				-- bg3 = "#000000",
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
