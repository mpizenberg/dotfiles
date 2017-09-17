" VIM-PLUG MANAGER ##################################################{{{
" First install vim-plug with the following command:
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Then copy this file in: ~/.config/nvim/
" Install all requirements (neovim, python3, python3 neovim package,
" nerd-fonts, rust, cargo, ... (see below for details))
" Finally launch nvim and run: :PlugInstall

call plug#begin('~/.config/nvim/plugged')

" Nerdtree file explorer
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
" Great collection of color themes
Plug 'flazz/vim-colorschemes'
" correct terminal palette colors
"Plug 'KevinGoodsell/vim-csexact'
" rst syntax
Plug 'mitsuhiko/vim-rst'
" Display thin vertical line at each indentation level for code indented with spaces
" Plug 'Yggdroot/indentLine'
" Personalized status bar
Plug 'bling/vim-airline'
" Some icons (need to install nerd-fonts to work)
" Plug 'ryanoasis/vim-devicons'
" Comment any type of code (gcc, gcip)
Plug 'tomtom/tcomment_vim'
" Syntax checking hacks
Plug 'vim-syntastic/syntastic'
" Auto completion tools (deoplete is still alpha)
Plug 'Shougo/deoplete.nvim'
" Snippets made easy (<Tab>)
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Search files
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
" Real-time collaborative editing
" Plug 'Floobits/floobits-neovim'
" fish shell syntax
Plug 'dag/vim-fish'
" elm language
Plug 'pbogut/deoplete-elm'
Plug 'elmcast/elm-vim'
" haskell language
Plug 'neovimhaskell/haskell-vim'
Plug 'eagletmt/neco-ghc'
" rust language
Plug 'rust-lang/rust.vim'
" html5
Plug 'othree/html5-syntax.vim'
" LaTeX
Plug 'lervag/vimtex'

" Add plugins to &runtimepath
call plug#end()
" }}}



" PERSONAL  #########################################################{{{
set mouse=a                      " enable mouse
let mapleader=","                " leader is comma
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
" make tabs and eol visible
set list listchars=tab:▸\ ,trail:▣
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
" set laststatus=2                 " show only one status line
set encoding=utf8
" let g:airline_powerline_fonts = 1
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 11
let g:elm_format_autosave = 1    " use elm-format
let g:rustfmt_autosave = 1       " use rustfmt
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
" space open/closes folds
nnoremap <space> za
set foldmethod=indent            " fold based on indent level
" }}}



" MOVEMENT ##########################################################{{{
" ,, is escape
inoremap ,, <esc>
" }}}



" NERDTREE ##########################################################{{{
" autocmd vimenter * NERDTree
" let NERDTreeIgnore = ['\.pyc$','__pycache__']
let NERDTreeShowHidden=1
set shell=sh
let g:NERDTreeIndicatorMapCustom = {
	\ "Modified"  : "✹",
	\ "Staged"    : "✚",
	\ "Untracked" : "✭",
	\ "Renamed"   : "➜",
	\ "Unmerged"  : "═",
	\ "Deleted"   : "✖",
	\ "Dirty"     : "✗",
	\ "Clean"     : "✔︎",
	\ "Unknown"   : "?"
	\ }
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
" https://rumpelsepp.github.io/2016/08/12/let-nerdtree-respect-gitignore.html
let loaded_netrwPlugin=1         " disable builtin bloated netrw plugin
noremap <C-n> :NERDTreeToggle<CR>
" close if only nerdtree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}



" AUTO COMPLETION ###################################################{{{
" Use deoplete.
let g:deoplete#enable_at_startup = 1

" UltiSnips config
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
" }}}



" SYNTAX CHECKING ###################################################{{{
" Syntastic config
map <Leader>s :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_rust_checkers = ['rustc']
let g:syntastic_html_checkers = ['validator']
" }}}



" LATEX CONFIGURATION ###############################################{{{
let g:tex_flavor = 'latex'       " use latex flavor instead of plaintex
if !exists('g:deoplete#omni#input_patterns')
	let g:deoplete#omni#input_patterns = {}
endif
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
