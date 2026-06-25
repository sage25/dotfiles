" ========================= 基础功能 =========================
set nocompatible               " 关闭兼容模式，使用 Vim 特性
syntax on                      " 启用语法高亮
filetype plugin indent on      " 启用文件类型检测、插件、缩进
let g:c_syntax_for_h = 1       " .h 文件用 C 语法高亮
set backspace=indent,eol,start " 退格键
set showmode                   " 显示模式
nnoremap <F6> :set paste!<CR>  " F6切换paste模式

" ========================= 基本 UI =========================
set number                     " 显示行号
set relativenumber             " 显示相对行号
set signcolumn=auto            " 自动显示符号列
set scrolloff=5                " 上下滚动边界
set cursorline                 " 高亮光标所在行

" ========================= 缩进/Tab =========================
set expandtab
set tabstop=4                 " Tab 占 4 个空格
set shiftwidth=4
set softtabstop=4
set expandtab                  " Tab 转为空格
set smartindent                " 智能缩进
set hidden                     " 支持隐藏缓冲区
set cinoptions+=g0,l0          " 访问限定符、case不缩进

" ========================= 编码/完成 ========================
set encoding=utf-8             " 启用 UTF-8 编码
set fileencodings=utf-8,latin1 " 允许文件使用 utf-8 或 latin1
set completeopt=menuone,noinsert,noselect   " 补全菜单优化
set updatetime=300             " 插件更新、光标保持事件触发间隔

" ===================== leader 键、键位映射 ====================
let mapleader = " "            " leader 键（空格）

" 常用移动/窗口键位
inoremap jk <Esc>
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" NERDTree 映射
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" Startify 映射
nnoremap <leader>ss :SSave<CR>
nnoremap <leader>sl :SLoad<CR>
nnoremap <leader>sd :SDelete<CR>
nnoremap <leader>st :Startify<CR>

" ========================= 插件管理 =========================
call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'joshdick/onedark.vim'
Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'sage25/leetcode.vim'
" Plug 'github/copilot.vim'
call plug#end()

" ==================== 插件相关配置 ====================
" ---- NERDTree 自动打开/关闭 ----
autocmd VimEnter * NERDTree | wincmd p
let g:NERDTreeWinSize = 20
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | silent! quit | endif

" ---- IndentLine ----
let g:indentLine_enabled = 1
let g:indentLine_char = '┆'
let g:indentLine_fileTypeExclude = ['help', 'startify', 'dashboard', 'nerdtree', 'tagbar', 'vista', 'packer', 'vim-plug']
let g:indentLine_showFirstIndentLevel = v:true
let g:indentLine_showTrailingBlanklineIndent = v:false

" ---- Startify ----
let g:startify_session_persistence = 1
let g:startify_files_number = 10
let g:startify_bookmarks = ['~/.vimrc', '~/projects', '~/notes']
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions'] },
      \ { 'type': 'files',     'header': ['   Recent Files'] },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
      \ { 'type': 'commands',  'header': ['   Commands'] }
      \ ]
let g:startify_custom_header = [
      \' __        __  _____   _        ____    ___    __  __   _____    _ ', 
      \' \ \      / / | ____| | |      / ___|  / _ \  |  \/  | | ____|  | |',
      \'  \ \ /\ / /  |  _|   | |     | |     | | | | | |\/| | |  _|    | |',
      \'   \ V  V /   | |___  | |___  | |___  | |_| | | |  | | | |___   |_|',
      \'    \_/\_/    |_____| |_____|  \____|  \___/  |_|  |_| |_____|  (_)',
      \'                                                                   ',
      \ ]
let g:startify_commands = ['Find Files :Files', 'New File :ene']


" ================= coc.nvim 补全及快捷键 ==================
let g:coc_global_extensions = ['coc-clangd']

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" ===================== 视图与文件位置保存 =====================
set viewoptions=folds,cursor,unix,slash
autocmd BufWinLeave * if expand('%') != '' | silent! mkview | endif
autocmd BufWinEnter * silent! loadview
autocmd BufReadPost * 
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" ===================== 自动保存功能 ========================
function! AutoSave(timer) abort
    if &modified && !&readonly && bufname('%') != ''
        silent! write
    endif
endfunction
let g:autosave_timer = timer_start(300000, 'AutoSave', {'repeat': -1})

" ===================== 撤销持久化 ========================
if !isdirectory(expand('~/.vim/undo'))
    call mkdir(expand('~/.vim/undo'), 'p')
endif
set undofile
let &undodir = expand('~/.vim/undo//')
set undolevels=1000
set undoreload=5000

" ===================== 高亮与主题 ==========================
" Theme load guard & toggle (persistent)
let s:theme_flagfile = expand('~/.vim/theme_enabled')

if filereadable(s:theme_flagfile)
  let g:theme_enabled = 1
else
  let g:theme_enabled = 0
endif

function! s:apply_theme() abort
  if !get(g:, 'theme_enabled', 0)
    if exists('g:colors_name')
      highlight clear
      if exists('syntax_on')
        syntax reset
      endif
    endif
    return
  endif

  set termguicolors
  set background=dark
  colorscheme onedark

  highlight Pmenu      guibg=#282c34 guifg=#abb2bf
  highlight PmenuSel   guibg=#61afef guifg=#282c34
  highlight PmenuSbar  guibg=#3e4452
  highlight PmenuThumb guibg=#abb2bf

  highlight CursorLineNr guifg=#61afef guibg=NONE gui=bold ctermfg=75 ctermbg=NONE cterm=bold
  highlight LineNr guifg=#c0c6cf guibg=NONE ctermfg=252 ctermbg=NONE
  highlight IndentLine guifg=#3e4452 guibg=NONE ctermfg=240 ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight FoldColumn guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
endfunction

call s:apply_theme()

function! s:ToggleTheme() abort
  let g:theme_enabled = !get(g:, 'theme_enabled', 0)
  if g:theme_enabled
    call writefile(['1'], s:theme_flagfile)
    echo "Theme enabled"
  else
    call delete(s:theme_flagfile)
    echo "Theme disabled"
  endif
  call s:apply_theme()
endfunction

nnoremap <silent> <leader>tt :call <SID>ToggleTheme()<CR>

" ===================== 仅 daily 文件夹新建文件插入模板 =====================
augroup DaliyTemplates
  autocmd!
  autocmd BufNewFile $HOME/code/daily/** call s:ApplyDaliyTemplate()
augroup END

function! s:ApplyDaliyTemplate() abort
  let l:tpl_dir = expand('~/.vim/templates')
  let l:tpl = l:tpl_dir . '/leetcode.tpl'
  if !filereadable(l:tpl)
    return
  endif

  let l:lines = readfile(l:tpl)
  for i in range(0, len(l:lines)-1)
    let l:lines[i] = substitute(l:lines[i], '%FILENAME%', expand('%:t'), 'g')
    let l:lines[i] = substitute(l:lines[i], '%DATE%', strftime("%Y-%m-%d"), 'g')
    let l:lines[i] = substitute(l:lines[i], '%USER%', getenv('USER'), 'g')
  endfor

  call setline(1, l:lines)

  let lnum = search('%CURSOR%', 'nw')
  if lnum > 0
    let lline = getline(lnum)
    let lcol = match(lline, '%CURSOR%')
    call setline(lnum, substitute(lline, '%CURSOR%', '', ''))
    call cursor(lnum, lcol + 1)
  else
    normal! gg
  endif
endfunction

" ==================== END ====================
