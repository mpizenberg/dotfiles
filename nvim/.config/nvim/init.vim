" VIM-PLUG MANAGER ##################################################{{{
" Install vim-plug with the following command:
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.config/nvim/plugged')

" User interface
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }    " Nerdtree file explorer
Plug 'flazz/vim-colorschemes'            " Great collection of color themes
Plug 'itchyny/lightline.vim'             " Light status line

" Syntax and completion
Plug 'tomtom/tcomment_vim'               " Comment any type of code (gcc, gcip)
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Language server integration
Plug 'honza/vim-snippets'

" Language specific
Plug 'plasticboy/vim-markdown'           " markdown syntax
Plug 'mitsuhiko/vim-rst'                 " rst syntax
Plug 'dag/vim-fish'                      " fish shell syntax
Plug 'andys8/vim-elm-syntax'             " elm language
Plug 'cespare/vim-toml'                  " rust config files
Plug 'idris-hackers/idris-vim'           " idris language
Plug 'rust-spandex/spandex.vim'          " spandex language

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
" set expandtab                    " tabs are spaces
set tabstop=4                    " number of visual spaces per TAB
" set softtabstop=4                " number of spaces inserted in insert mode
set shiftwidth=4                 " number of spaces for 1 indentation level
" make tabs and trailing spaces visible
set list listchars=tab:·\ ,trail:∎
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
set foldmethod=syntax            " fold based on syntax
" }}}



" COC CONFIG  #######################################################{{{
set hidden                       " if hidden is not set, TextEdit might fail
set nobackup                     " Some servers have issues with backup files, see #649
set nowritebackup                " Some servers have issues with backup files, see #649
set cmdheight=2                  " Better display for messages
set updatetime=300               " bad experience for diagnostic messages when it's default 4000
set shortmess+=c                 " don't give |ins-completion-menu| messages
set signcolumn=yes               " always show signcolumns
let g:coc_snippet_next="<Tab>"   " use Tab to navigate to next snippet placeholder
let g:coc_snippet_prev="<S-Tab>" " use Shift-Tab to previous snippet placeholder

" Jumping to definition
nmap <silent> gd <Plug>(coc-definition)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)
" }}}



" STATUS LINE #######################################################{{{
function! CocCurrentFunction()
	return get(b:, 'coc_current_function', '')
endfunction

let g:lightline = {
	\ 'colorscheme': 'wombat',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'cocstatus', 'currentfunction', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'cocstatus': 'coc#status',
	\   'currentfunction': 'CocCurrentFunction'
	\ },
	\ }
" }}}



" NERDTREE ##########################################################{{{
let NERDTreeIgnore = ['\.pyc$','__pycache__','.git$']
let NERDTreeShowHidden=1
noremap <C-n> :NERDTreeToggle<CR>
" close if only nerdtree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" }}}



" LATEX CONFIGURATION ###############################################{{{
let g:tex_flavor = 'latex'       " use latex flavor instead of plaintex
let g:tex_conceal = "abdgm"      " display unicode math characters
" }}}



" MARKDOWN ##########################################################{{{
" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format
" }}}
