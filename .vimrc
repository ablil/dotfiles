syntax on " highlight syntax

set tabstop=2               " tab size in spaces
set shiftwidth=2            " space shift with << or >> operators
set expandtab               " use spaces instead of tabs
set smartindent             " auto indent on new line

set colorcolumn=80
set relativenumber

set scrolloff=3
set cursorline              " highlight line under cursor

" Vundle configuration
set nocompatible            " be iMproved, required
filetype off                " required

" VUNDLE CONFIG STAR 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
call vundle#end()           " required
filetype plugin indent on   " required
" VUNDLE CONFIG END 
