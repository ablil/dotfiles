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
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'udalov/kotlin-vim'
Plugin 'tpope/vim-surround'
Plugin 'maxmellon/vim-jsx-pretty'
call vundle#end()
