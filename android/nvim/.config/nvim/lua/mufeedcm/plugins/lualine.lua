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

		-- Define the TokyoNight Night theme for lualine with harder colors
		local theme = {
			normal = {
				a = { fg = "#e0af68", bg = "#383c56", gui = "bold" },
				b = { fg = "#c0caf5", bg = "#24283b" },
				c = { fg = "#a9b1d6", bg = "#24283b" },
			},
			insert = {
				a = { fg = "#1e1e2e", bg = "#9ece6a", gui = "bold" },
				b = { fg = "#c0caf5", bg = "#24283b" },
				c = { fg = "#a9b1d6", bg = "#24283b" },
			},
			visual = {
				a = { fg = "#1e1e2e", bg = "#f7768e", gui = "bold" },
				b = { fg = "#c0caf5", bg = "#24283b" },
				c = { fg = "#a9b1d6", bg = "#24283b" },
			},
			replace = {
				a = { fg = "#1e1e2e", bg = "#9d7cd8", gui = "bold" },
				b = { fg = "#c0caf5", bg = "#24283b" },
				c = { fg = "#a9b1d6", bg = "#24283b" },
			},
			command = {
				a = { fg = "#1e1e2e", bg = "#e0af68", gui = "bold" },
				b = { fg = "#c0caf5", bg = "#24283b" },
				c = { fg = "#a9b1d6", bg = "#24283b" },
			},
			inactive = {
				a = { fg = "#a9b1d6", bg = "#24283b" },
				b = { fg = "#a9b1d6", bg = "#24283b" },
				c = { fg = "#a9b1d6", bg = "#24283b" },
			},
		}

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
				--     {
				--         "tabs",
				--         mode = 1,
				--         path = 0,
				--         show_modified_status = true,
				--         max_length = vim.o.columns,
				--         symbols = {
				--             modified = "",
				--         },
				--         tabs_color = {
				--             active = "custom_tab_active",
				--         },
				--     },
				-- },
			},
		}
	end,
}
