" VIM-PLUG MANAGER ###################################################
" need the file ~/.vim/autoload/plug.vim

call plug#begin('~/.vim/plugged')
" Nerdree file explorer
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Display thin vertical line at each indentation level for code indented with spaces
Plug 'Yggdroot/indentLine'
" Comment any type of code (gcc, gcip)
Plug 'tomtom/tcomment_vim'
" Syntax plugins
Plug 'peterhoeg/vim-qml'
Plug 'mitsuhiko/vim-rst'
Plug 'dag/vim-fish'
Plug 'elmcast/elm-vim'
call plug#end()

" PERSONAL ###########################################################
let mapleader=","                " leader is comma

" COLOR ##############################################################
set t_Co=256                     " uses more colors
set background=dark              " use dark background
syntax enable                    " enable syntax processing
colorscheme jellybeans           " awesome colorscheme

" INDENTATION ########################################################
"set expandtab                    " tabs are spaces
set tabstop=4                    " number of visual spaces per TAB
"set softtabstop=4                " number of spaces in tab when editing
set shiftwidth=4                 " number of spaces for 1 indentation level
" make tabs and eol visible
set list listchars=tab:▸\ ,eol:¬,trail:·
set autoindent                   " copy indent on new line
filetype plugin indent on        " load filetype-specific indent files
" align blocks and keep them selected
vnoremap < <gv
vnoremap > >gv

" UI CONFIG ##########################################################
set mouse=a                      " Enable mouse usage (all modes)
set number                       " show line numbers
set showcmd                      " show command in bottom bar
set cursorline                   " highlight current line
set wildmenu                     " visual autocomplete for command menu
set lazyredraw                   " redraw only when we need to.
set showmatch                    " highlight matching [{()}]
set ignorecase                   " case insensitive
set encoding=utf8

" SEARCHING ##########################################################
set incsearch                    " search as characters are entered
set hlsearch                     " highlight matches
" turn off search highlight with [,<space>]
nnoremap <leader><space> :nohlsearch<CR>

" FOLDING ############################################################
set foldenable                   " enable folding
set foldlevelstart=10            " open most folds by default
set foldnestmax=10               " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent            " fold based on indent level

" MOVEMENT ###########################################################
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" ,, is escape
inoremap ,, <esc>

" NERDTREE ###########################################################
let NERDTreeIgnore = ['\.pyc$','__pycache__']
