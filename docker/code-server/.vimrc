filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'wesleyche/SrcExpl'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'johngrib/vim-game-code-break'
Plugin 'stephpy/vim-yaml'

call vundle#end()
filetype plugin indent on

set backspace=indent,eol,start
set encoding=utf-8
set nu
set ai
set ts=4
set sw=4
set expandtab
set cc=80,100
" set textwidth=100
set hlsearch
syntax on

set clipboard=unnamed " use OS clipboard

" colorscheme seoul256
set t_Co=256
set background=dark

map <F8> :NERDTreeToggle<CR>
map <F2> :GoDef<CR>
map <F4> :TagbarToggle<CR>

" NERDTree configs
let NERDTreeShowHidden=1
