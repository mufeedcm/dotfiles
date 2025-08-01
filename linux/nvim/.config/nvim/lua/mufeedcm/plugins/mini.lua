return {
	"echasnovski/mini.nvim",
	config = function()
		-- require("mini.files").setup({
		-- 	vim.keymap.set("n", "<leader>o", function()
		-- 		require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
		-- 	end, { desc = "Open mini.files at current file", noremap = true, silent = true }),
		-- 	mappings = {
		-- 		go_in = "l", --  <CR> for Enter
		-- 		go_out = "h",
		-- 	},
		-- })
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
}
