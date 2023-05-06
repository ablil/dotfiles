set nocompatible
set rnu nu
set expandtab
set incsearch
set hlsearch
set smartindent
set showcmd

set shiftwidth=4
set tabstop=4
set modelines=0     " turned off for security reasons
set clipboard=unnamedplus
set mouse=a

colorscheme default


" STOP USING THE FUCKING ARROW KEYS
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Change the cursor in different modes
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[2 q"


" PLUGINS
call plug#begin()
Plug 'udalov/kotlin-vim'
Plug 'tpope/vim-surround'
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()
