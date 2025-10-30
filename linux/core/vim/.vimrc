set clipboard=unnamedplus
filetype plugin indent on
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set smartindent

set number
set relativenumber
set showmatch
set backspace=indent,eol,start
syntax on
set ignorecase
set incsearch
set wrap
set termguicolors

set undofile
if !isdirectory(expand('~/.vim/undo'))
    call mkdir(expand('~/.vim/undo'), 'p')
endif
set undodir=~/.vim/undo


let mapleader = " "
nnoremap <leader>e :Ex<CR>

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
let &t_SR = "\e[4 q"

let s:plugin_dir = expand('~/.vim/plugged')

function! s:ensure(repo)
  let name = split(a:repo, '/')[-1]
  let path = s:plugin_dir . '/' . name
  if !isdirectory(path)
    if !isdirectory(s:plugin_dir)
      call mkdir(s:plugin_dir, 'p')
    endif
    execute '!git clone --depth=1 https://github.com/' . a:repo . ' ' . shellescape(path)
  endif
  execute 'set runtimepath+=' . fnameescape(path)
endfunction

call s:ensure('ghifarit53/tokyonight-vim')
call s:ensure('junegunn/fzf')
call s:ensure('junegunn/fzf.vim')
call s:ensure('tpope/vim-commentary')
call s:ensure('itchyny/lightline.vim')
call s:ensure('machakann/vim-highlightedyank')
let g:highlightedyank_highlight_duration = 100

" call s:ensure('yegappan/lsp')

let g:tokyonight_style = 'night'
" let g:tokyonight_enable_italic = 1
let g:tokyonight_transparent_background = 1
colorscheme tokyonight

nnoremap <leader>sf  :Files<CR>
nnoremap <leader>sh  :History<CR>
nnoremap <leader>sb  :Buffers<CR>
" nnoremap <leader>sqf :CList<CR>
nnoremap <leader>sqf :clist<CR>
nnoremap <leader>sg  :Rg<Space>
nnoremap <leader>sv  :Files ~/.vim<CR>

set laststatus=2
let g:lightline = {
      \ 'colorscheme' : 'tokyonight',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'LightlineFilename'
      \ }
      \ }

function! LightlineFilename()
  return expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

" " Lsp
" Enable diagnostics highlighting
" let lspOpts = #{autoHighlightDiags: v:true}
" autocmd User LspSetup call LspOptionsSet(lspOpts)

" let lspServers = [
"       \ #{
"       \   name: 'clangd',
"       \   filetype: ['c', 'cpp', 'objc', 'objcpp'],
"       \   path: 'clangd',
"       \   args: []
"       \ }
"       \ ]

" autocmd User LspSetup call LspAddServer(lspServers)

" " Key mappings
" nnoremap gd :LspGotoDefinition<CR>
" nnoremap gr :LspShowReferences<CR>
" nnoremap K  :LspHover<CR>
" nnoremap gl :LspDiag current<CR>
" nnoremap <leader>nd :LspDiag next \| LspDiag current<CR>
" nnoremap <leader>pd :LspDiag prev \| LspDiag current<CR>
" inoremap <silent> <C-Space> <C-x><C-o>

" " Set omnifunc for completion
" autocmd FileType c,cpp setlocal omnifunc=lsp#complete

" " Custom diagnostic sign characters
" autocmd User LspSetup call LspOptionsSet(#{
"     \   diagSignErrorText: '✘',
"     \   diagSignWarningText: '▲',
"     \   diagSignInfoText: '»',
"     \   diagSignHintText: '⚑',
"     \ })
