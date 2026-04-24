" ==================================================
" @file .vimrc
" @brief Vim configuration file
" ==================================================

" --------------------------------------------------
" general
" --------------------------------------------------
set nocompatible
syntax on
filetype plugin indent on

" --------------------------------------------------
" display
" --------------------------------------------------
set number
set relativenumber
set cursorline
set showmatch
set scrolloff=8
set sidescrolloff=8
set ruler
set laststatus=2

" --------------------------------------------------
" search
" --------------------------------------------------
set hlsearch
set incsearch
set ignorecase
set smartcase

" --------------------------------------------------
" indentation
" --------------------------------------------------
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4

" --------------------------------------------------
" editing
" --------------------------------------------------
set backspace=indent,eol,start
set mouse=a
set hidden

" --------------------------------------------------
" navigation
" --------------------------------------------------
set whichwrap+=<,>,h,l
nnoremap j gj
nnoremap k gk

" --------------------------------------------------
" timing
" --------------------------------------------------
set timeoutlen=500

" --------------------------------------------------
" appearance
" --------------------------------------------------
if has('termguicolors')
    set termguicolors
endif
set nolist
set background=dark
let g:github_colors_soft = 1
colorscheme github
highlight Normal       ctermbg=NONE guibg=NONE
highlight NonText      ctermbg=NONE guibg=NONE
highlight LineNr       ctermbg=NONE guibg=NONE
highlight EndOfBuffer  ctermbg=NONE guibg=NONE
highlight Folded       ctermbg=NONE guibg=NONE
highlight CursorLine   ctermbg=NONE guibg=NONE

" --------------------------------------------------
" window
" --------------------------------------------------
set splitright
set splitbelow

" --------------------------------------------------
" undo
" --------------------------------------------------
if has('persistent_undo')
    set undofile
endif

" --------------------------------------------------
" keymaps
" --------------------------------------------------
nnoremap <Esc><Esc> :nohlsearch<CR>
inoremap jk <Esc>
inoremap kj <Esc>
