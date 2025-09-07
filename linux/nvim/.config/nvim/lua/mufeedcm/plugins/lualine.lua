return {
	"nvim-lualine/lualine.nvim",
	enabled = false,
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
		local theme = "auto" -- Use terminal colors

		return {
			options = {
				theme = theme,
				component_separators = { left = " ", right = " " },
				section_separators = { left = " ", right = " " },
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
			tabline = {},
		}
	end,
}
