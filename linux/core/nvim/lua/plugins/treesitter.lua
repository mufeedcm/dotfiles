return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	lazy = false,
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"svelte",
			"dockerfile",
			"prisma",
			"bash",
			"c",
			"cpp",
			"astro",
			"css",
			"diff",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
		},
		auto_install = true,
		highlight = {
			enable = true,
			-- disable = { "c", "rust", "latex" },
			disable = function(lang, buf)
				local max_filesize = 100 * 1024
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,

			additional_vim_regex_highlighting = false,
		},
	},
}
