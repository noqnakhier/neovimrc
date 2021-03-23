" 不使用弹出窗口
if has('nvim')
    GuiPopupmenu 0
else 
    " gVim remove toolbar and menubar.
    set guioptions-=T
    set guioptions-=m
endif

" Gui Appearances
if has('gui_macvim') || has('mac')
    set guifont=Menlo\ Regular:h14
elseif has('unix')
    set guifont=Ubuntu\ Mono\ 13
elseif has('win32')
    set guifont=YaHei\ Consolas\ Hybrid:h12
    set guifontwide=SimHei:h12
endif
