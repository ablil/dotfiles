
" Inder using 2 spaces
set tabstop=2

" When shifting, indent using two spaces
set shiftwidth=2

" Convert tabs to spaces
set expandtab
set smartindent             " auto indent on new line

" Set relative numbers on gutter
set relativenumber

" Highlight line under cursor
set cursorline

" When searching, and going to next occurence with n
" do NOT wrap to start of file after reaching EOF
set nowrapscan

set nocompatible            " be iMproved, required
filetype off                " required
colorscheme desert

" mapping

" Change the cursor in different modes
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[2 q"

" use system clipboard config
set clipboard=unnamedplus

syntax on " highlight syntax
