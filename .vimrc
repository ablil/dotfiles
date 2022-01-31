syntax on " highlight syntax

set tabstop=2               " tab size in spaces
set shiftwidth=2            " space shift with << or >> operators
set expandtab               " use spaces instead of tabs
set smartindent             " auto indent on new line
set showmatch               " Highlight matching brace
set confirm                 " Display confirmaton dialog when closing unsaved file
set relativenumber          " Set relative numbers
set cursorline              " highlight line under cursor

set nocompatible            " be iMproved, required
filetype off                " required
colorscheme delek

" Plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surrond'
call vundle#end()

