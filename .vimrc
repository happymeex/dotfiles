" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Allow copying text to system clipboard
set clipboard=unnamedplus

" Unbind some useless/annoying default key bindings.
" 'Q' in normal mode enters Ex mode. You almost never want this.
nmap Q <Nop>

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. 
" set mouse+=a

let mapleader = ','
let maplocalleader = ','

" remap visual block mode to q for WSL reasons
nnoremap q <c-v>

" enable UTF8 character encoding; needed for vimtex
set encoding=utf-8


" Using vim-plug to manage plugins; this is actually necessary for my tsx
" config to work bc vim-jsx-typescript needs to be loaded before I set .tsx
" files to be syntax-highlighted as .ts files
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'SirVer/ultisnips'
Plug 'lervag/vimtex'
call plug#end()

""""""""""""
"COC CONFIG"
""""""""""""

set updatetime=300

" navigate completion suggestions with <C-j> (not using tab bc ultisnips)
inoremap <silent><expr> <C-j>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<C-j>" :
      \ coc#refresh()
inoremap <expr><C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" carriage return to accept selected completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" use <c-space> to force open completion suggestion panel
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" K opens panel showing documentation
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

""""""""""""

" make .tex extensions have .tex filetypes
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_ignore_filters = [
            \'Underfull \\hbox (badness [0-9]*) in ',
            \'Overfull \\hbox ([0-9]*.[0-9]*pt too wide) in ',
            \]

" ultisnips stuff
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = ';'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips']
nnoremap <leader>r <Cmd>call UltiSnips#RefreshSnippets()<CR>

let g:vimtex_view_method = 'zathura'

" NERDTree shortcuts
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" set cursorline 
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" Set tabs to 4 spaces
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" command completion
set wildmenu
set wildmode=list:longest,full

" CtrlP plugin key remap
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
    \ 'dir': 'node_modules',
    \ 'file': '\.swp'
  \ }

" Color scheme
let g:gruvbox_contrast_dark = 'dark'
colo gruvbox
set bg=dark

" Treat .tsx files as .ts for syntax highlighting purposes only;
" Note that using 'filetype=typescript' causes problems with the linter
augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set syntax=typescript
augroup END

" auto indent; I think vim-plug turns this on automatically but whatever
filetype plugin indent on
