" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


set lazyredraw
set magic
set nowrap
set number
set paste
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set smartindent
set termguicolors
set background=dark

call plug#begin()
     Plug 'rakr/vim-one'
     Plug 'vim-airline/vim-airline'	
     Plug 'lilydjwg/colorizer'
call plug#end()

colorscheme one

let g:airline_powerline_fonts = 1
let g:airline_theme = 'one'



