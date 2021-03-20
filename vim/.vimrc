" set syntax highlight
syntax on

" set tab size in spaces
set tabstop=2

" set number of space to shift when using << or >> operators
set shiftwidth=2

" indent using spaces instead of tab (tabs vs spaces)
set expandtab

" auto indent on new line
set smartindent

" display stop bar
set colorcolumn=80

" set number of line to keep above and below the cursor
set scrolloff=5

" highlight line under cursor
set cursorline

" Vundle configuration
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-surround'
call vundle#end()            " required
filetype plugin indent on    " required

" lightline plugin config
set laststatus=2
