-- globals
local global = vim.g
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

global.mapleader = " "
global.maplocalleader = " "
global.have_nerd_font = true

-- keymaps
keymap("n", "<C-h>", ":wincmd h<CR>", opts) -- move left split
keymap("n", "<C-l>", ":wincmd l<CR>", opts) -- move right split
keymap("n", "<C-j>", ":wincmd j<CR>", opts) -- move down split
keymap("n", "<C-k>", ":wincmd k<CR>", opts) -- move up split

keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "clear search highlights" })
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", opts) -- exit terminal mode

keymap("n", "<leader><leader>x", "<cmd>source %<CR>") -- reload current file

-- autocmds
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight on yank",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- options
local opt = vim.opt

-- general
opt.encoding = "utf-8"
opt.mouse = "a"
opt.showmode = false
opt.updatetime = 250
opt.timeoutlen = 300
opt.undofile = true
opt.clipboard = "unnamedplus"

-- ui
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 10

-- text display
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- completion
vim.o.completeopt = "menu,menuone,noinsert"

-- searching
opt.ignorecase = true
opt.smartcase = true

-- splits
opt.splitright = true
opt.splitbelow = true

-- spell checking
opt.spell = true
opt.spelllang = "en_us"

-- command behavior
opt.inccommand = "split"

-- filetype & plugins
vim.cmd("filetype plugin on")
vim.filetype.add({ extension = { mdx = "markdown" } })
