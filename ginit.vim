" 不使用弹出窗口
GuiPopupmenu 0

" Gui Appearances
if has('gui_macvim') || has('mac')
    set guifont=Menlo\ Regular:h14
elseif has('unix')
    set guifont=Ubuntu\ Mono\ 13
elseif has('win32')
    set guifont=Consolas:h10
endif
