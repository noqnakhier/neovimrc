""""""""""""""""""""""""""""""""
" NeoVim Python设定
""""""""""""""""""""""""""""""""
" 使用`python -v venv venv`在相应的config文件夹中创建虚拟环境，
" 在venv环境中使用命令pip install pynvim以增加neovim的支持
""""""""""""""""""""""""""""""""
if has('nvim')
    if has('win32')
        let g:python3_host_prog = 'D:/Dev/Neovim/venv/Scripts/python.exe'
    else
        let g:python3_host_prog = '~/.config/nvim/venv/bin/python'
    endif
    " 禁止使用python2
    let g:loaded_python_provider = 0
endif

""""""""""""""""""""""""""""""""
" Vim-Plug插件管理配置
""""""""""""""""""""""""""""""""
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'godlygeek/tabular' | Plug 'plasticboy/vim-markdown'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go'
Plug 'kristijanhusak/defx-git'
Plug 'jiangmiao/auto-pairs'
Plug 'crusoexia/vim-monokai'
Plug 'rust-lang/rust.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'mzlogin/vim-markdown-toc'
Plug 'ferrine/md-img-paste.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ferrine/md-img-paste.vim'


call plug#end()


""""""""""""""""""""""""""""""""
" 基本配置
""""""""""""""""""""""""""""""""
syntax enable
filetype plugin indent on  
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set cindent
set autoindent
set smartindent
set number
set fileencodings=utf-8,cp936,gbk,big5
set encoding=utf8 
set termencoding=utf-8
set filetype=unix
let mapleader=","
colorscheme monokai

""""""""""""""""""""""""""""""""
" 窗口操作快捷键
""""""""""""""""""""""""""""""""
nmap <silent> <leader>wc <C-w>c
nmap <silent> <leader>wo <C-w>o
nmap <silent> <leader>ws <C-w>s
nmap <silent> <leader>wt <C-w>v
nmap <silent> <leader>wh <C-w>h
nmap <silent> <leader>wl <C-w>l
nmap <silent> <leader>wj <C-w>j
nmap <silent> <leader>wj <C-w>k

" 退出Terminal模式的按键设置
"tnoremap <Esc> <C-\><C-n>


""""""""""""""""""""""""""""""""
" UltiSnips快捷键设置
"""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger = '<c-e>'
let g:UltiSnipsListSnippets = '<c-tab>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'


""""""""""""""""""""""""""""""""
" Vim-Plug插件管理配置
""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1


""""""""""""""""""""""""""""""""
" Vim Markdown设置
""""""""""""""""""""""""""""""""
" 关闭markdown的自动折叠功能
let g:vim_markdown_folding_disabled = 1

" Allow for the TOC window to auto-fit when it's possible for it to shrink. It never increases its default size (half screen), it only shrinks.
let g:vim_markdown_toc_autofit = 1

" To enable conceal use Vim's standard conceal configuration.
" set conceallevel=2

" To disable conceal regardless of conceallevel setting, add the following to your .vimrc:
let g:vim_markdown_conceal = 0

let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_fenced_languages = ['csharp=cs', 'golang=go', 'javascript=js']
let g:vim_markdown_math = 1
" let g:vim_markdown_frontmatter = 1
" Set image paste 
autocmd FileType markdown nmap <buffer><silent> <leader>mp :call mdip#MarkdownClipboardImage()<CR>

let g:vmt_auto_update_on_save = 0


" img-paste-vim 设置，Linux需要安装xclip
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR> 
"let g:mdip_imgdir = 'img'
"let g:mdip_imgname = 'image'
 
 
 
""""""""""""""""""""""""""""""""
" Defx的基本设置
""""""""""""""""""""""""""""""""
call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': 'defx',
      \ 'toggle': 1,
      \ 'resume': 1
      \ })
"参考自http://liaoph.com/modern-vim/
"打开Defx文件浏览器，并且使用当前文件所在目录为Root
map <silent> <leader>d :Defx `expand('%:p:h')` -search=`expand('%:p')`<CR>

" Avoid the white space highting issue
" autocmd FileType defx match ExtraWhitespace /^^/
" Keymap in defx
autocmd FileType defx call s:defx_my_settings()

function! s:defx_my_settings() abort
  "IndentLinesDisable
  setl nospell
  setl signcolumn=no
  setl nonumber

  " 展开或关闭文件夹，或者打开文件
  nnoremap <silent><buffer><expr> o
  \ defx#is_directory() ?
  \ defx#do_action('open_or_close_tree') :
  \ defx#do_action('drop',)

  " 进入文件夹及其子文件夹
  nnoremap <silent><buffer><expr> O defx#do_action('drop')

  " 水平分割打开文件
  nnoremap <silent><buffer><expr> s defx#do_action('drop', 'split')
  " 竖直分割打开文件
  nnoremap <silent><buffer><expr> v defx#do_action('drop', 'vsplit')
  " 在新tab打开文件
  nnoremap <silent><buffer><expr> t defx#do_action('drop', 'tabe')
  " 复制
  nnoremap <silent><buffer><expr> C defx#do_action('copy')
  " 粘贴
  nnoremap <silent><buffer><expr> P defx#do_action('paste')
  " 重命名
  nnoremap <silent><buffer><expr> M defx#do_action('rename')
  " 移动到垃圾箱
  nnoremap <silent><buffer><expr> D defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> A defx#do_action('new_multiple_files')
  " 返回上级
  nnoremap <silent><buffer><expr> U defx#do_action('cd', ['..'])
  " 显示隐藏文件（"."开头的文件）
  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
  " 选中文件
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select')
  " 刷新
  nnoremap <silent><buffer><expr> R defx#do_action('redraw')
endfunction

""""""""""""""""""""""""""""""""
" Defx Git 设置
""""""""""""""""""""""""""""""""

let g:defx_git#indicators = {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ }
let g:defx_git#column_length = 0
hi def link Defx_filename_directory NERDTreeDirSlash
hi def link Defx_git_Modified Special
hi def link Defx_git_Staged Function
hi def link Defx_git_Renamed Title
hi def link Defx_git_Unmerged Label
hi def link Defx_git_Untracked Tag
hi def link Defx_git_Ignored Comment

" Defx icons
" Requires nerd-font, install at https://github.com/ryanoasis/nerd-fonts or
" brew cask install font-hack-nerd-font
" Then set non-ascii font to Driod sans mono for powerline in iTerm2
" Plug 'kristijanhusak/defx-icons'
" disbale syntax highlighting to prevent performence issue
" let g:defx_icons_enable_syntax_highlight = 1
"

" 最后一个窗口时关闭
autocmd BufEnter * if 0 == len(filter(range(1, winnr('$')), 'empty(getbufvar(winbufnr(v:val), "&bt"))')) | qa! | endif

""""""""""""""""""""""""""""""""
" COC Setting设置"
""""""""""""""""""""""""""""""""

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"""""""""""""""""""""""""""
" Golang setting
"""""""""""""""""""""""""""

" 这个设置与COC相冲突，禁止后由coc提供此功能
let g:go_def_mapping_enabled = 0

" Add Missing imports on save
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Map keys to command
autocmd FileType go nmap <leader>gj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap <leader>glj :CocCommand go.tags.add.line json<cr>
autocmd FileType go nmap <leader>gy :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap <leader>gly :CocCommand go.tags.add.line yaml<cr>
autocmd FileType go nmap <leader>gc :CocCommand go.tags.clear<cr>
autocmd FileType go nmap <leader>glc :CocCommand go.tags.clear.line<cr>
