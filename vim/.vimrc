colorscheme solarized
set background=dark


set tabstop=4  " no of spaces per tab
set softtabstop=4  " number of spaces in tab when editing
set expandtab  " tabs are spaces
set shiftwidth=4
set textwidth=79
set wrap
set autoindent
set fileformat=unix
set spell   " Enable spell-checking

"" Advanced
set confirm " Prompt confirmation dialogs
set ruler   " Show row and column ruler information
set showtabline=2   " Show tab bar
set cmdheight=2 " Command line height

set autochdir   " Change working directory to open buffer

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

" NERDTree
" map <C-n> :NERDTreeToggle<CR>
map <F2> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

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
let g:airline_theme='molokai'

" syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" PLUGINS
call plug#begin('~/.vim/plugged')

" ale - lint
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'git://github.com/tpope/vim-surround.git'
" Plug 'Valloric/YouCompleteMe'
Plug 'terryma/vim-multiple-cursors'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" folding
Plug 'tmhedberg/SimpylFold'
" python indentation
Plug 'vim-scripts/indentpython.vim'
" Plug 'Valloric/YouCompleteMe'
"Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8'
Plug 'altercation/vim-colors-solarized'
Plug 'kien/ctrlp.vim'

" Initialize plugin system
call plug#end()
