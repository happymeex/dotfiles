nmap <localleader>l <Plug>(vimtex-compile-ss)
nmap <localleader>lc <Plug>(vimtex-compile)

if empty(v:servername) && exists('*remote_startserver')
    call remote_startserver('VIM')
endif

let g:vimtex_view_method='zathura'
nmap <localleader>v <plug>(vimtex-view)
