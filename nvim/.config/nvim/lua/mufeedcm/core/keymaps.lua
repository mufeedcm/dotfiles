local global = vim.g
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local apimap = vim.api.nvim_set_keymap

-- Map <leader> = space key
global.mapleader = " "
global.maplocalleader = " "

global.have_nerd_font = true

keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- window management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Easy split navigation
keymap("n", "<C-h>", ":wincmd h<CR>", opts)
keymap("n", "<C-l>", ":wincmd l<CR>", opts)
keymap("n", "<C-j>", ":wincmd j<CR>", opts)
keymap("n", "<C-k>", ":wincmd k<CR>", opts)

-- Resize Vertical Split (Height)
vim.api.nvim_set_keymap("n", "<A-k>", ":resize +2<CR>", { noremap = true, silent = true }) -- Move down the height
vim.api.nvim_set_keymap("n", "<A-j>", ":resize -2<CR>", { noremap = true, silent = true }) -- Move up the height

-- Resize Horizontal Split (Width)
vim.api.nvim_set_keymap("n", "<A-h>", ":vertical resize +2<CR>", { noremap = true, silent = true }) -- Move right the width
vim.api.nvim_set_keymap("n", "<A-l>", ":vertical resize -2<CR>", { noremap = true, silent = true }) -- Move left the width

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear Search Highlights" })
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", opts)

-- Open a terminal in a horizontal split (Press <Leader>t)
vim.api.nvim_set_keymap("n", "<Leader>sh", ":split | terminal<CR>", { noremap = true, silent = true })
-- Horizontal split terminal

-- Open a terminal in a vertical split (Press <Leader>v)
vim.api.nvim_set_keymap("n", "<Leader>sv", ":vsplit | terminal<CR>", { noremap = true, silent = true })
-- Vertical split terminal

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Plugins

-- texlab
keymap("n", "<Leader>lb", "<CMD>TexlabBuild<CR>", opts)
keymap("n", "<Leader>ls", "<CMD>TexlabForward<CR>", opts)
-- automatically build and open latex file
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.tex",
	callback = function()
		vim.cmd("TexlabBuild")
		vim.cmd("TexlabForward")
	end,
})

-- Barbar.nvim
-- apimap("n", "<leader>,", "<Cmd>BufferPrevious<CR>", opts)
-- apimap("n", "<leader>.", "<Cmd>BufferNext<CR>", opts)
-- apimap("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", opts)
-- apimap("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", opts)
-- apimap("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", opts)
-- apimap("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", opts)
-- apimap("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", opts)
-- apimap("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", opts)
-- apimap("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", opts)
-- apimap("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", opts)
-- apimap("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", opts)
-- apimap("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)
-- apimap("n", "<leader>cc", "<Cmd>BufferClose<CR>", opts)

-- vim: ts=2 sts=2 sw=2 et
