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
    a = { fg = "#fabd2f", bg = "#3c3836", gui = "bold" },  -- Yellow on dark gray
    b = { fg = "#d5c4a1", bg = "#1d2021" },                  -- Light beige on very dark gray
    c = { fg = "#b8bb26", bg = "#1d2021" },                  -- Green on very dark gray
  },
  insert = {
    a = { fg = "#1d2021", bg = "#8ec07c", gui = "bold" },  -- Dark gray on green
    b = { fg = "#d5c4a1", bg = "#1d2021" },                -- Light beige on very dark gray
    c = { fg = "#b8bb26", bg = "#1d2021" },                -- Green on very dark gray
  },
  visual = {
    a = { fg = "#1d2021", bg = "#fb4934", gui = "bold" },  -- Dark gray on red
    b = { fg = "#d5c4a1", bg = "#1d2021" },                -- Light beige on very dark gray
    c = { fg = "#b8bb26", bg = "#1d2021" },                -- Green on very dark gray
  },
  replace = {
    a = { fg = "#1d2021", bg = "#d3869b", gui = "bold" },  -- Dark gray on purple
    b = { fg = "#d5c4a1", bg = "#1d2021" },                -- Light beige on very dark gray
    c = { fg = "#b8bb26", bg = "#1d2021" },                -- Green on very dark gray
  },
  command = {
    a = { fg = "#1d2021", bg = "#fabd2f", gui = "bold" },  -- Dark gray on yellow
    b = { fg = "#d5c4a1", bg = "#1d2021" },                -- Light beige on very dark gray
    c = { fg = "#b8bb26", bg = "#1d2021" },                -- Green on very dark gray
  },
  inactive = {
    a = { fg = "#a89984", bg = "#1d2021" },  -- Light beige on very dark gray
    b = { fg = "#a89984", bg = "#1d2021" },  -- Light beige on very dark gray
    c = { fg = "#a89984", bg = "#1d2021" },  -- Light beige on very dark gray
  },
}

vim.cmd("highlight custom_tab_active guifg=#fabd2f")  -- Set active tab color to yellow
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
