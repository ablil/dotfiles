set nocompatible
set encoding=utf-8

" shared leader and IdeaVim keymap
source ~/.vim/keymaps.vim

" editing
set rnu nu
set showcmd
set hidden
set mouse=a
set backspace=indent,eol,start
set scrolloff=7
set signcolumn=yes
set updatetime=300
set ttimeoutlen=10
set nrformats-=octal
set path+=**
set termguicolors
if has('mac') || has('macunix')
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif

" keep swap/undo/backup files out of the working tree
for s:dir in [$HOME.'/.vim/swap', $HOME.'/.vim/backup', $HOME.'/.vim/undo-history']
    if !isdirectory(s:dir)
        call mkdir(s:dir, 'p')
    endif
endfor
set undofile
set undodir=~/.vim/undo-history//
set directory=~/.vim/swap//
set backupdir=~/.vim/backup//

" Indention
set expandtab
set smartindent
set autoindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set shiftround

" searching
set incsearch
set hlsearch
set ignorecase
set smartcase

" theming
colorscheme sorbet
set cursorline
set colorcolumn=100

filetype plugin indent on
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

" plugins live in ~/.vim/pack/plugins/start (native packages, no manager)
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>g :Rg<CR>
nnoremap <Leader>l :BLines<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>q :qa<CR>
nnoremap <Leader>w :wa<CR>
nnoremap <silent> <Leader><CR> :nohlsearch<CR>

" Bottom status line
set laststatus=2
set statusline=file:\ %f%h\ %w\ \ cwd:\ %{getcwd()}\ \ buff:\ %n/%{len(getbufinfo({'buflisted':1}))}
set statusline +=%=%c:%l/%L\ %m%r%y

fun! RunCurrentFile() abort
    let l:file = expand('%:p')
    if empty(l:file)
        call s:Warn('buffer has no file to run')
        return
    endif
    execute '!' . shellescape(l:file, 1)
endfun

" run the current file, expect shebang on top
nnoremap <Leader>x :call RunCurrentFile()<CR>

" smart way of moving between windows
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

fun! s:RealBuffer() abort
    return &buftype ==# '' && &modifiable
endfun

fun! s:Warn(msg) abort
    echohl WarningMsg | echomsg a:msg | echohl None
endfun

" Remove trailing empty lines on save
fun! TrimEmptyLines() abort
    if !s:RealBuffer()
        return
    endif
    let l:save_cursor = getpos('.')
    silent! %s#\($\n\s*\)\+\%$##
    call setpos('.', l:save_cursor)
endfun

augroup dotfiles_trim_empty
    autocmd!
    autocmd BufWritePre * call TrimEmptyLines()
augroup END

" Terraform format on save, buffer is left untouched when fmt fails
fun! TerraformFmt() abort
    if !s:RealBuffer()
        return
    endif
    if !executable('terraform')
        call s:Warn('terraform not found')
        return
    endif
    let l:current = getline(1, '$')
    let l:formatted = system('terraform fmt -', join(l:current, "\n"))
    if v:shell_error
        call s:Warn('terraform fmt failed, buffer left unchanged')
        return
    endif
    let l:lines = split(l:formatted, "\n")
    if empty(l:lines) || l:lines ==# l:current
        return
    endif
    let l:save_cursor = getpos('.')
    silent %delete _
    call setline(1, l:lines)
    call setpos('.', l:save_cursor)
endfun

augroup dotfiles_terraform_fmt
    autocmd!
    autocmd BufWritePre *.tf call TerraformFmt()
augroup END
