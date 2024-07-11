set nocompatible

syntax on

set shortmess+=I

set number
set relativenumber

set laststatus=2

set backspace=indent,eol,start

nmap Q <Nop>

set noerrorbells visualbell t_vb=

set encoding=utf-8

set fillchars=eob:\ 

let mapleader = ','

" Set tabs to 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

autocmd FileType text setlocal spell spelllang=en_us
autocmd FileType markdown setlocal spell spelllang=en_us

call plug#begin()
Plug 'junegunn/goyo.vim'
Plug 'preservim/vim-colors-pencil'
Plug 'morhetz/gruvbox'
Plug 'junegunn/limelight.vim'
Plug 'reedes/vim-pencil'
call plug#end()

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

let g:gruvbox_contrast_dark = 'dark'
colo gruvbox
" colo pencil
set termguicolors
set background=dark

" Prose mode using Goyo and Pencil
let w:ProseModeOn = 0

function EnableProseMode()
	setlocal spell spelllang=en_us
	Goyo 66
	SoftPencil
	echo "Prose Mode On"
endfu

function DisableProseMode()
	Goyo!
	NoPencil
	setlocal nospell
	echo "Prose Mode Off"
endfu

function ToggleProseMode()
	if w:ProseModeOn == 0
		call EnableProseMode()
		let w:ProseModeOn = 1
	else
		call DisableProseMode()
	endif
endfu

command Prose call EnableProseMode()
command UnProse call DisableProseMode()
command ToggleProse call ToggleProseMode()

function ScratchBufferize()
	setlocal buftype=nofile
	setlocal bufhidden=hide
	setlocal noswapfile
endfu

nnoremap <Leader>d :new \| read ! sdcv <C-R><C-W> <CR>:call ScratchBufferize() <CR>:normal gg<CR>
nnoremap <Leader>t :new \| read ! moby <C-R><C-W> \| tr , '\n' <CR>:call ScratchBufferize() <CR>:normal gg2dd <CR>

