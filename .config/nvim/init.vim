" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" set for clipboard
let &t_ut=''
set autochdir

" editor behavior
" Plain text automatic line break
set textwidth=80
" Hightlight column
set colorcolumn=80
" Ignorecase while search
set ignorecase
" Remove swapfile (backup)
set noswapfile
set nobackup
" Disable unnecessary redraw
set lazyredraw
" Enable RegExp in search pattern
set magic
" Disable break line
set wrap
" Show cursor position
set ruler
" Show number of line
set number
" Default file encodings
set fileencodings=utf-8
" Show commands completion in bottom menu
set wildmenu
" Enable cursorline
set cursorline
" Invisible chars
set listchars=space:·,tab:│\ ,eol:¬
" Show invisible chars
set list
" Use system clipboard by default
set clipboard=unnamed
" What's this?
set showmatch

" Tab setup
" Tab size in spaces
set tabstop=4
" Tab size in spaces used for >>, << commands
set shiftwidth=4
" Colonum number when hit Tab in insert mode
set softtabstop=4
" Replace tabs with spaces
set expandtab
" Remove spaces like tabs
set smarttab
" Enable automatic indentation
set smartindent

" Color setup
" Enable 24bit color support
set termguicolors 
" Auto complete config
let g:python3_host_prog = "/usr/local/bin/python3"
" set completeopt-=preview
set completeopt=noinsert,menuone,noselect
"
set notimeout
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
set splitbelow


" Settings by filetype
" HTML
autocmd Filetype html setlocal ts=2 sts=2 sw=2
" CSS
autocmd Filetype css setlocal ts=2 sts=2 sw=2
" JavaScript
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
" C
autocmd Filetype c setlocal ts=8 sts=8 sw=8 noet

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


call plug#begin()
    " Auto complete plugs
    Plug 'jiangmiao/auto-pairs'
    if has('nvim')
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
        Plug 'Shougo/deoplete.nvim'
        Plug 'roxma/nvim-yarp'
        Plug 'roxma/vim-hug-neovim-rpc'
    endif
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'zchee/deoplete-jedi'
    
    " Format plugs
    Plug 'Yggdroot/indentLine'
    Plug 'dense-analysis/ale'
    
    " Find and search plugs
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    
    " Beauty plugs
    Plug 'rakr/vim-one'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'lilydjwg/colorizer'
    Plug 'luochen1990/rainbow'
    
    " Tools plugs
    Plug 'junegunn/goyo.vim'
    Plug 'godlygeek/tabular'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'majutsushi/tagbar'
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/nerdcommenter'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'mbbill/undotree'
    Plug 'gregsexton/matchtag'
    Plug 'davidhalter/jedi-vim'
    Plug 'ervandew/supertab'
    Plug 'mhinz/vim-signify'

    
    " Be depended plug
    Plug 'roxma/nvim-yarp'
    Plug 'Shougo/neco-vim'
    
call plug#end()


colorscheme one
filetype plugin indent on
syntax on
highlight ExtraWhitespace guibg=#E06C75


nmap <silent> gb :bn<CR>
nmap <silent> gB :bp<CR>
inoremap <S-Insert><ESC>:setl paste<CR>gi<C-R>+<ESC>:setl nopaste<CR>gi


" Plug settings
"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'one'


let g:SuperTabDefaultCompletionType="context"
let g:SuperTabDefaultCompletionType = "<c-n><c-p>"


let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
call deoplete#custom#source('LanguageClient',
            \ 'min_pattern_length',
            \ 2)
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['String']
            \ )
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif


imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffers = "right"

 
map <silent> tt <plug>NERDTreeTabsToggle<CR>


map <silent> tb :TagbarToggle<CR>


nmap <silent> <C-m> <Plug>NERDCommenterToggle
nmap <silent> <C-m> <Plug>NERDCommenterToggle
let g:NERDSpaceDelims = 1


map <silent> tu :UndotreeToggle<CR>
if has("persistent_undo")
    set undodir=$HOME/.config/nvim/undo
    set undofile
endif


let g:ale_linters = {
\    'javascript': ['eslint'],
\    'css': ['stylelint'],
\    'python': ['flake8', 'pylint']
\}
let g:ale_linters_ignore = {'python': ['pylint']}
" " Set syntax correct
let g:ale_fixers= {
\    'javascript': ['eslint'],
\    'css': ['stylelint'],
\    'python': ['autopep8']
\}

nmap <silent> tf :ALEFix<CR>

