return {
	"akinsho/bufferline.nvim",
	enabled = false,

	--[[ tag = "v3.*", ]]
	config = function()
		local status_ok, bufferline = pcall(require, "bufferline")
		if not status_ok then
			return
		end
		vim.opt.termguicolors = true
		bufferline.setup({
			options = {
				style_preset = require("bufferline").style_preset.no_italic,
			},
		})

		-- Navigate buffers
		vim.keymap.set("n", "<S-l>", ":bnext<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>x", "<cmd> bp|sp|bn|bd! <CR>", { noremap = true, silent = true })
	end,
}
