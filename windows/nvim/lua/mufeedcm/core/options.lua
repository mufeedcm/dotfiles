-- [[ Setting options ]]
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.number = true -- add line numbers
opt.relativenumber = true -- add relative line numbers

vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })

-- Tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs
opt.shiftwidth = 2 -- 2 spaces for indent with
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- Set completeopt for better completion behavior
vim.o.completeopt = "menu,menuone,noinsert"

-- Enable mouse mode, can be useful for resizing splits.
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)

-- Open PDF files with SumatraPDF
vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*.pdf",
	callback = function()
		local file_path = vim.fn.shellescape(vim.fn.expand("%:p"))
		vim.fn.jobstart("SumatraPDF " .. file_path, { detach = true })
		vim.cmd("bdelete") -- Optional: Close the buffer after opening externally
	end,
})

-- Open image files with the default image viewer
vim.api.nvim_create_autocmd("BufRead", {
	pattern = {
		"*.jpg",
		"*.jpeg",
		"*.png",
		"*.svg",
		"*.bmp",
		"*.gif",
		"*.ico",
		"*.tiff",
		"*.tif",
		"*.webp",
		"*.heif",
		"*.heic",
	},
	callback = function()
		local file_path = vim.fn.expand("%:p")
		vim.fn.jobstart("start " .. file_path, { detach = true })
		vim.cmd("bdelete") -- Optional: Close the buffer after opening externally
	end,
})

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- opt.list = true
-- opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- use powershell instead of cmd.exe
vim.o.shell = "pwsh.exe"
vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command $PSStyle.OutputRendering = 'PlainText';"
vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
vim.o.shellquote = ""
vim.o.shellxquote = ""
-- vim: ts=2 sts=2 sw=2 et
