" VIM-PLUG MANAGER ##################################################{{{
" Install vim-plug with the following command:
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.config/nvim/plugged')

" User interface
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }    " Nerdtree file explorer
Plug 'flazz/vim-colorschemes'            " Great collection of color themes
Plug 'bling/vim-airline'                 " Personalized status bar

" Syntax and completion
Plug 'tomtom/tcomment_vim'               " Comment any type of code (gcc, gcip)
Plug 'w0rp/ale'                          " Syntax checking
Plug 'Shougo/deoplete.nvim'              " Auto completion tools
Plug 'SirVer/ultisnips'                  " Snippets made easy (<Tab>)
Plug 'honza/vim-snippets'

" Language specific
Plug 'mitsuhiko/vim-rst'                 " rst syntax
Plug 'dag/vim-fish'                      " fish shell syntax
Plug 'elmcast/elm-vim'                   " elm language
Plug 'pbogut/deoplete-elm'               " elm completion for deoplete
Plug 'neovimhaskell/haskell-vim'         " haskell language
Plug 'eagletmt/neco-ghc'                 " haskell completion for deoplete
Plug 'rust-lang/rust.vim'                " rust language
Plug 'lervag/vimtex'                     " Lite LaTeX plugin

" Git integration
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'                " git wrapper
Plug 'airblade/vim-gitgutter'            " git sign symbols before ligne number

call plug#end()                          " Add plugins to &runtimepath
" }}}



" PERSONAL  #########################################################{{{
set mouse=a                      " enable mouse
let mapleader=","                " leader is comma
inoremap ,, <esc>
" }}}



" COLOR #############################################################{{{
set background=dark              " use dark background
syntax enable                    " enable syntax processing
colorscheme jellybeans           " awesome colorscheme
" }}}



" INDENTATION #######################################################{{{
"set expandtab                    " tabs are spaces
set tabstop=4                    " number of visual spaces per TAB
"set softtabstop=4                " number of spaces inserted in insert mode
set shiftwidth=4                 " number of spaces for 1 indentation level
" make tabs and trailing spaces visible
set list listchars=tab:▸\ ,trail:∎
set autoindent                   " copy indent on new line
filetype plugin indent on        " load filetype-specific indent files
" Align blocks and keep them selected
vnoremap < <gv
vnoremap > >gv
" }}}



" UI CONFIG #########################################################{{{
set number                       " show line numbers
set showcmd                      " show command in bottom bar
set cursorline                   " highlight current line
set wildmenu                     " visual autocomplete for command menu
set lazyredraw                   " redraw only when we need to.
set showmatch                    " highlight matching [{()}]
set ignorecase                   " case insensitive
set encoding=utf8                " use UTF-8 encoding
let g:airline_powerline_fonts = 1
set conceallevel=2               " use vim conceal feature
" }}}



" SEARCHING #########################################################{{{
set incsearch                    " search as characters are entered
set hlsearch                     " highlight matches
" turn off search highlight with [,<space>]
nnoremap <leader><space> :nohlsearch<CR>
" }}}



" FOLDING ###########################################################{{{
set foldenable                   " enable folding
set foldlevelstart=10            " open most folds by default
set foldnestmax=10               " 10 nested fold max
" space toggles folds
nnoremap <space> za
set foldmethod=indent            " fold based on indent level
" }}}



" NERDTREE ##########################################################{{{
let NERDTreeIgnore = ['\.pyc$','__pycache__','.git$']
let NERDTreeShowHidden=1
noremap <C-n> :NERDTreeToggle<CR>
" close if only nerdtree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}



" AUTO COMPLETION ###################################################{{{
" Use deoplete.
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
	let g:deoplete#omni#input_patterns = {}
endif

" UltiSnips config
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
" }}}



" SYNTAX CHECKING ###################################################{{{
let g:ale_lint_on_text_changed = 0
map <Leader>s :ALEToggle<CR>
" }}}



" LATEX CONFIGURATION ###############################################{{{
let g:tex_flavor = 'latex'       " use latex flavor instead of plaintex
let g:tex_conceal = "abdgm"      " display unicode math characters
let g:deoplete#omni#input_patterns.tex = '\\(?:'
	\ .  '\w*cite\w*(?:\s*\[[^]]*\]){0,2}\s*{[^}]*'
	\ . '|\w*ref(?:\s*\{[^}]*|range\s*\{[^,}]*(?:}{)?)'
	\ . '|hyperref\s*\[[^]]*'
	\ . '|includegraphics\*?(?:\s*\[[^]]*\]){0,2}\s*\{[^}]*'
	\ . '|(?:include(?:only)?|input)\s*\{[^}]*'
	\ . '|\w*(gls|Gls|GLS)(pl)?\w*(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
	\ . '|includepdf(\s*\[[^]]*\])?\s*\{[^}]*'
	\ . '|includestandalone(\s*\[[^]]*\])?\s*\{[^}]*'
	\ . '|usepackage(\s*\[[^]]*\])?\s*\{[^}]*'
	\ . '|documentclass(\s*\[[^]]*\])?\s*\{[^}]*'
	\ . '|\w*'
	\ .')'
" }}}
