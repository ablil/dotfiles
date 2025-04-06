set nocompatible " no need to make vim VI-compatible
set encoding=utf-8
set rnu nu
set showcmd     " show my keystrokes at the bottom right
set hidden      " allow me to open new buffer without writing to the previous  one
set mouse=a     " allow mouse scrolling

" Indention
set expandtab	" use spaces instead of tab
set smartindent " automatically indent next line accordingly
set autoindent
set shiftwidth=4
set tabstop=4


" searching
set incsearch   " highlight next search match
set hlsearch    " hightlight all search matches


" theming
colorscheme sorbet
set cursorline " hightlight current line
set colorcolumn=100


" Enable syntax highlighting
filetype plugin on
syntax on


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
Plugin 'tpope/vim-surround'
"Plugin 'easymotion/vim-easymotion'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-gitgutter'
call vundle#end()

map t <Plug>(easymotion-bd-w)

" Remaps for buffers
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>x :xa<CR>
nnoremap <Leader>q :qa<CR>
nnoremap <Leader>w :wa<CR>


" Bottom status line
function! BufferCount()
    return bufnr('$')
endfunction

set laststatus=2
set statusline=file:\ %f%h\ %w\ \ cwd:\ %r%{getcwd()}%h\ \ buff:\ %n/%{BufferCount()}
set statusline +=%=%c:%l/%L\ %m%r%y

set so=7    " set 7 lines from the cursor while moving vertically

" smart way of moving between windows
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Intellij IDEA specific remaps
if has('ide')
    " jump around
    map T <Action>(RunClass)
    nmap [[ <Action>(MethodUp)
    nmap ]] <Action>(MethodDown)
    nmap ]e <Action>(GotoNextError)
    nmap [e <Action>(GotoPreviousError)

    " Refactoring
    map <leader>rn <Action>(RenameElement)
    map <leader>rm <Action>(ExtractMethod)
    map <leader>rv <Action>(IntroduceVariable)
    map <leader>rf <Action>(IntroduceField)
    map <leader>rs <Action>(ChangeSignature)
    map <leader>rr <Action>(Refactorings.QuickListPopupAction)

    " remap goto actions
    map <leader>t <Action>(GotoTest)
    map <leader>n <Action>(GotoClass)
    map <leader>f <Action>(GotoFile)
    map <leader>a <Action>(GotoAction)
    map <leader>x <Action>(GotoSymbol)
    map <leader>e <Action>(RecentFiles)

    " misc
    map <leader>s <Action>(FileStructurePopup)
    map <leader>d <Action>(Debug)
    map <leader>b <Action>(ToggleLineBreakpoint)
    map <leader>\ <Action>(ActivateTerminalToolWindow)

    " PLugins
    Plug 'machakann/vim-highlightedyank'

    "" -- Map IDE actions to IdeaVim -- https://jb.gg/abva4t

    " Find more examples here: https://jb.gg/share-ideavimrc
    set notimeout

    " enable some plugins
    set surround    " enable surround plugin
    set ideajoin    " smart join with j
    set nerdtree    " navigate file explorer with hjkl
    set easymotion
    set which-key   " requires which-key idea plugin

endif

" Remove trailing empty lines on save
fun! TrimEmptyLines()
    let save_cursor = getpos('.')               " Save cursor position
    silent! %s#\($\n\s*\)\+\%$##               " Remove trailing empty lines
    call setpos('.', save_cursor)               " Restore cursor position
endfun
autocmd BufWritePre * call TrimEmptyLines() " Apply to all files


" Terraform format on save (only if 'terraform' is installed)
fun! TerraformFmt()
  " Check if 'terraform' is executable
  if executable('terraform')
    " Save cursor position and run 'terraform fmt'
    let l:save_cursor = getpos('.')
    silent execute '%!terraform fmt -'
    call setpos('.', l:save_cursor)
  else
    echo "Terraform not found! Install it first: https://www.terraform.io/downloads"
  endif
endfun
autocmd BufWritePre *.tf call TerraformFmt()
