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
" set autochdir

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
" Show command when yout type
set showcmd

" Set scroll lines
set scrolloff=5
" set ttimeoutlen=0
" Viminfo recore vim operations
set viewoptions=cursor,folds,slash,unix

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
" Auto indentation
set autoindent
" Enable folding
set foldmethod=indent
set foldlevel=99

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
    Plug 'tmhedberg/SimpylFold'
    Plug 'kshenoy/vim-signature'
    Plug 'junegunn/goyo.vim'
    Plug 'godlygeek/tabular'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'easymotion/vim-easymotion'
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
    
    " Front plugs
    Plug 'mattn/emmet-vim'

    
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
nnoremap <C-w>i <C-w>s
nnoremap <C-w>s <C-w>v
" Resize splits with arrow keys
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>


let mapleader = " "

" Set nohls when you open nvim
exec 'nohlsearch'
" Search
map <LEADER><CR> :nohlsearch<CR>

" Open the vimrc file anytime
map tr :e ~/.config/nvim/init.vim<CR>

" Duplicate words
" map <LEADER>dw /\(\<\w\+\>\)\_s*\1

" Folding
map <silent> <LEADER>o za

" Call figlet
map tx :r !figlet

" Compile function
map rr :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    set splitright
    :vsp
    :vertical resize-20
    :term python3 %
  elseif &filetype == 'html'
    exec "!chromium % &"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  endif
endfunc

map R :call CompileBuildrrr()<CR>
func! CompileBuildrrr()
  exec "w"
  if &filetype == 'vim'
    exec "source $MYVIMRC"
  elseif &filetype == 'markdown'
    exec "echo"
  endif
endfunc

" Plug settings
"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'one'

let g:colorizer_nomap = 1

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

let g:user_emmet_leader_key = '<C-k>'


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
let g:jedi#use_tag_stack = 0
let g:jedi#goto_stubs_command = '<A-A>'
 
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1
let NERDTreeShowHidden = 1
let NERDTreeIgnore = ['\.pyc','\~$','\.swp','\.git', '__pycache__']
map <silent> tt <plug>NERDTreeTabsToggle<CR>
" Solve vim-signature conflict with nerdtree
let NERDTreeMapMenu = 'M'
" Solve unuse keys as A-A, for set notimeout
let NERDTreeMapOpenExpl = '<A-A>'
let NERDTreeMapCWD = '<A-A>'


map <silent> tb :TagbarToggle<CR>
let g:tagbar_autofocus = 1

let g:NERDSpaceDelims = 1

map <silent> tu :UndotreeToggle<CR>
if has("persistent_undo")
    set undodir=$HOME/.config/nvim/undo
    set undofile
endif


let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
nmap gE <Plug>(ale_previous_wrap)
nmap ge <Plug>(ale_next_wrap)<Paste>
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
\    'python': ['autopep8', 'yapf']
\}
nmap <silent> tf :ALEFix<CR>


let g:Lf_ShortcutF = '<C-p>'
nmap <silent> <Leader>p :Leaderf function<CR>
nmap <silent> <Leader>s :Leaderf rg<CR>
nmap <silent> <Leader>l :Leaderf line<CR>
" nmap <silent> <Leader>w :Leaderf tag<CR>

