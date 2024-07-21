" formatting "
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4

" filetype "

set autoindent
set fileformat=unix
syntax enable
let python_highlight_all=1
filetype indent on
set encoding=utf-8
set autochdir   " Change working directory to open buffer
set nocompatible
filetype off
set directory=$HOME/.dump//

" move between buffers without saving "
set hidden

" spell "
set nospell   " Enable spell-checking

" line numbers "
set number
set relativenumber
set cursorline

" rulers and margins "
set colorcolumn=80
set ruler

" search "
set showmatch
set incsearch
set hlsearch

" folding "
set foldmethod=indent
set foldlevel=99
" enable folding with spacebar
noremap <space> za

" disable modeline
" in ttl files, ex: is taken as a vim command
set nomodeline
" set option so paste works without indents
set mouse=a
set copyindent
set pastetoggle=<F3>
exec "set <F24>=\<Esc>[O"
exec "set <F25>=\<Esc>[I"

" movement
" splits
set splitbelow
set splitright
" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" UI/UX "
set confirm " Prompt confirmation dialogs
set showtabline=2   " Show tab bar
set cmdheight=2 " Command line height
set showcmd  " show command in bottom bar
set wildmenu  " autocomplete for command menu
set lazyredraw  " redraw only when needed
nnoremap gV `[v`]  " visually select block of characters last inserted

" undo "
set undolevels=1000 " Number of undo levels
set backspace=indent,eol,start  " Backspace behaviour

" gui options "
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar

""" PLUGINS """

" Tags
nmap <F8> :TagbarToggle<CR>

" folding
" see docstrings for folded code
let g:SimpylFold_docstring_preview=1

" airline
set laststatus=2
" let g:airline_theme='wombat'
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
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" ale
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

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
" Plug 'altercation/vim-colors-solarized'
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
" tmux focus events
Plug 'tmux-plugins/vim-tmux-focus-events'
" incsearch
Plug 'haya14busa/incsearch.vim'
" dracula theme
Plug 'dracula/vim', { 'as': 'dracula' }
" Vim RDF + Prefix auto-complete
Plug 'niklasl/vim-rdf'
" ShellCheck for bash linting
Plug 'itspriddle/vim-shellcheck'

" Initialize plugin system
call plug#end()
" colorscheme "
colorscheme default
set background=light
