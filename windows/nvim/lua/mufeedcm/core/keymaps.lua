local global = vim.g
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

-- Map <leader> = space key
global.mapleader = " "
global.maplocalleader = " "

vim.g.VimuxRunnerType = "pane" -- Default to using a Tmux pane
vim.g.VimuxHeight = "15" -- Set the height of the Tmux pane
vim.g.VimuxOrientation = "v" -- Horizontal split

global.have_nerd_font = true

-- keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Easy split navigation
keymap("n", "<C-h>", ":wincmd h<CR>", opts)
keymap("n", "<C-l>", ":wincmd l<CR>", opts)
keymap("n", "<C-j>", ":wincmd j<CR>", opts)
keymap("n", "<C-k>", ":wincmd k<CR>", opts)

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear Search Highlights" })
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", opts)

keymap("n", "<space><space>x", "<cmd>source %<CR>")
keymap("n", "<space>x", ":.lua<CR>")
keymap("v", "<space>x", ":lua<CR>")

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- vim: ts=2 sts=2 sw=2 et
