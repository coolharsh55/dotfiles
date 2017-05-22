colorscheme solarized
set background=dark

set tabstop=4  " no of spaces per tab
set softtabstop=4  " number of spaces in tab when editing
set expandtab  " tabs are spaces
set shiftwidth=4
"set textwidth=79
"set wrap
set colorcolumn=78
set autoindent
set fileformat=unix
set spell   " Enable spell-checking
set relativenumber

"" Advanced
set confirm " Prompt confirmation dialogs
set ruler   " Show row and column ruler information
set showtabline=2   " Show tab bar
set cmdheight=2 " Command line height

set autochdir   " Change working directory to open buffer
set relativenumber
set nocompatible
filetype off

set undolevels=1000 " Number of undo levels
set backspace=indent,eol,start  " Backspace behaviour

syntax enable  " set syntax on
let python_highlight_all=1
set number  " show line numbers
filetype indent on  " load filetype specific indentation
set encoding=utf-8

set showcmd  " show command in bottom bar
set cursorline  " highlight current line
set wildmenu  " autocomplete for command menu

set lazyredraw  " redraw only when needed
set showmatch  " highlight matching brackets
set incsearch  " search as characters are entered
set hlsearch  " highlight search matches
" nnoremap <leader><space> :nohlsearch<CR>  " map remove highlight to \<space>
nnoremap gV `[v`]  " visually select block of characters last inserted

" save session - will open same windows next time with vim -S
" nnoremap <leader>s :mksession<CR>

" airline
set laststatus=2

" Tags
nmap <F8> :TagbarToggle<CR>

" folding
set foldmethod=indent
set foldlevel=99
" enable folding with spacebar
noremap <space> za
" see docstrings for folded code
let g:SimpylFold_docstring_preview=1

" splits
set splitbelow
set splitright

" movement
" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" indent guidlines
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=blue ctermbg=240
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=250

" powerline
set laststatus=2
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled = 1

" Limelight
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.5

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 0

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
"let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" PLUGINS
call plug#begin('~/.vim/plugged')

" linter
Plug 'w0rp/ale'
" git
Plug 'tpope/vim-fugitive'
" netrw (directory listing) tools
Plug 'tpope/vim-vinegar'
" brackets
Plug 'tpope/vim-surround'
" fuzzy file finder
Plug 'kien/ctrlp.vim'
" colorscheme
Plug 'altercation/vim-colors-solarized'
" theme for status bar
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" sidebar with tags
Plug 'majutsushi/tagbar'
" commenting
Plug 'tpope/vim-commentary'
" show visual indication of indents
Plug 'nathanaelkane/vim-indent-guides'
" sublime multiple cursors
Plug 'terryma/vim-multiple-cursors'
" minimalist writing environment
Plug 'junegunn/goyo.vim'
" limelight writing focus
Plug 'junegunn/limelight.vim'
" easy moving around matching words
Plug 'easymotion/vim-easymotion'
" marks in sidebar
Plug 'kshenoy/vim-signature'



" Initialize plugin system
call plug#end()
