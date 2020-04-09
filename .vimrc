set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.fzf
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" add molokai colorscheme
Plugin 'tomasr/molokai'
" fzf
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" comments
Plugin 'tpope/vim-commentary'
" editorconfig
Plugin 'editorconfig/editorconfig-vim'
" cpp highlight
Plugin 'octol/vim-cpp-enhanced-highlight'

call vundle#end()            " required
filetype plugin indent on    " required

" add line numbers
set number
set relativenumber

set wildmenu
set path+=**

" active airline on startup
set laststatus=2

set term=screen-256color
" Set vim to support 256 colors
set t_Co=256

syntax on

if filereadable(expand('~/.vim/bundle/molokai/colors/molokai.vim'))
    " set default colorscheme
    " More schemes at http://www.bytefluent.com/vivify/
    colorscheme molokai "symfony colorful256 or dante
endif

set textwidth=80
set colorcolumn=81

set mouse=a
set ignorecase	"Do case insensitive
set incsearch	"incremental search
set hlsearch
set showmatch

set ttyfast

set bs=indent,eol,start   " allow backspacing over everything in insert mode)"
" tab indent
set tabstop=2

" soft tab
set softtabstop=2
set expandtab

" indent
set shiftwidth=2

" smart indent
" set smartindent

" keep indentation on next line
set autoindent

if empty(glob('~/.vim/undodir'))
    silent !mkdir ~/.vim/undodir
endif
set undodir=~/.vim/undodir
set undofile

" Display CRLF as ^M.
" CRLF is for windows
if has("autocmd")
    au BufReadPost * :edit ++fileformat=unix
endif

function! s:remove_crlf()
    let pos = getpos('.')
    %s///e
    call setpos('.', pos)
    " :setlocal fileformat=unix
    " :write
    " :e
endfunction

command -nargs=0 RemoveCrlf :call s:remove_crlf()

"·remove·trailing·whitespace
function! s:remove_trail_whitespace()
    if &filetype == 'markdown'
        return
    endif
    let pos = getpos('.')
    %s/\s\+$//e
    call setpos('.', pos)
endfunction

"autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * call s:remove_trail_whitespace()

" set nowraping
set nowrap
set listchars=eol:¶,tab:→\ ,space:·
set listchars+=precedes:<,extends:>
set list

"show command
set showcmd

"auto reload
set autoread

" highlight the current line
set cursorline

" save
nnoremap <C-s> :update<CR>
inoremap <C-s> <ESC>:update<CR>

" comment style for cpp
autocmd Filetype cpp setlocal commentstring=//\ %s
" comment style for CMakeLists
autocmd Filetype cmake setlocal commentstring=#\ %s
autocmd BufNewFile CMakeLists.txt setlocal commentstring=#\ %s

" Install fzf if not installed
if empty(glob('~/.fzf'))
    silent !git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    silent !~/.fzf/install --no-key-bindings --completion --update-rc
endif

" grep search using fzf
command! -bang -nargs=* Grep call fzf#vim#grep('grep --color=always -rnI '.shellescape(<q-args>), 0, <bang>0)

"add comment
nnoremap <C-_> :Commentary<CR>
inoremap <C-_> <ESC>:Commentary<CR><insert>
vnoremap <C-_> :Commentary<CR>gv

nnoremap <C-p> :FZF<CR>
nnoremap <C-l> :Buffers<CR>
