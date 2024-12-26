return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			vim.o.statusline = " "
		else
			vim.o.laststatus = 0
		end
		-- Add top padding by simulating space before statusline
		vim.cmd("autocmd VimEnter * silent! normal! gg0") -- Scroll to top to simulate padding
		vim.cmd("redraw") -- Force redraw after the above command
	end,
	opts = function()
		vim.o.laststatus = vim.g.lualine_laststatus

		local theme = require("lualine.themes.gruvbox")

		for _, mode in pairs(theme) do
			mode.a.fg = mode.a.bg
			mode.a.gui = ""

			mode.c.fg = mode.b.fg

			for _, section in pairs(mode) do
				section.bg = nil
			end
		end

		vim.cmd("highlight custom_tab_active guifg=#e69875")

		return {
			options = {
				component_separators = { left = " ", right = " " },
				section_separators = { left = " ", right = " " },
				theme = theme,
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard" } },
			},

			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},

			tabline = {
				-- lualine_a = {
				-- 	{
				-- 		"tabs",
				-- 		mode = 1,
				-- 		path = 0,
				-- 		show_modified_status = true,
				-- 		max_length = vim.o.columns,
				-- 		symbols = {
				-- 			modified = "",
				-- 		},
				-- 		tabs_color = {
				-- 			active = "custom_tab_active",
				-- 		},
				-- 	},
				-- },
			},
		}
	end,
}
