call plug#begin('$HOME/.vim/plugged')
Plug 'junegunn/vim-plug'
" Light Line status bar [nice to have]
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
" Colorscheme
" Plug 'tek256/simple-dark'
" Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-one'
" Delimitmate
Plug 'Raimondi/delimitMate'
" CoC - Code Completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" CTRL-P
Plug 'ctrlpvim/ctrlp.vim'
" Undotree
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
" Markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'rwxrob/vim-pandoc-syntax-simple'
" Auto Completion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Vim go
" Plug 'govim/govim'
" AI
Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
call plug#end()

" General settings
set nocompatible
filetype plugin on
syntax on

set omnifunc=syntaxcomplete#Complete

if !has("gui_running")
  set t_Co=256
endif

" set Vim-specific sequences for RGB colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Set the cursor as a line in Insert mode & as a block in Normal mode
" KEEP THE FOUR LINES BELOW EXACTLY AS THEY ARE!
" 1 or 0 -> blinking block
" 2 -> solid block
" 3 -> blinking underscore
" 4 -> solid underscore
" Recent versions of xterm (282 or above) also support
" 5 -> blinking vertical bar
" 6 -> solid vertical bar
let &t_ti.="[0 q"
let &t_SI.="[6 q"
let &t_EI.="[0 q"
let &t_te.="[0 q"

set ttimeout
set ttimeoutlen=1
set ttyfast

set listchars=tab:>-,trail:~,extends:>,precedes:<,space:*

set fo+=t
set fo-=l

set textwidth=72
set wrapmargin=2

set hlsearch
set incsearch
set nobackup
set nowritebackup
set noswapfile
set noshowmode
set number
set relativenumber
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set showmatch
set wildmode=longest,list,full
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set ignorecase
set smartcase
set laststatus=2
set backupdir=~/.tmp
set directory=~/.tmp
set foldmethod=indent
set foldlevel=99
set cursorline
set hidden
set cmdheight=1
set updatetime=50
set shortmess+=c
set signcolumn=yes
set undofile
set undodir=~/.vim/undotree
set viminfo='20,<1000,s1000
set splitbelow
set splitright
set showcmd
set encoding=utf-8

set ruf=%30(%=%#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

" Disable mouse click to go to position
set mouse-=a

" Colorscheme
if (has("termguicolors"))
  set termguicolors
endif

set background=dark

"colorscheme simple-dark
colorscheme one

" colorscheme nord
if (g:colors_name == "nord")
  let g:nord_cursor_line_number_background = 1
  let g:nord_uniform_status_lines = 1
  let g:nord_italic = 1
endif

" Set highlight for search pattern
hi Search cterm=NONE ctermfg=204 ctermbg=236 guifg=#E06C75 guibg=#3E4452

" CTRL-P
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_use_caching = 0

" DelimitMate
let delimitmate_expand_cr = 1

" Light Line
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste', 'spell' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo', 'filetype', 'bufnum' ] ] },
      \ 'component_function': { 'gitbranch': 'gitbranch#name' }, }

" CoC Settings
let g:coc_disable_startup_warning = 1
inoremap <silent><expr> <c-space> coc#refresh()

" Asyncomplete
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" GoTo code navigation.
nmap <buffer>gd <Plug>(coc-definition)
nmap <buffer>gy <Plug>(coc-type-definition)
nmap <buffer>gi <Plug>(coc-implementation)
nmap <buffer>gr <Plug>(coc-references)
nnoremap <buffer><leader>cr :CocRestart<CR>

" " golang
" let g:go_fmt_fail_silently = 0
" let g:go_fmt_command = 'goimports'
" let g:go_fmt_autosave = 1
" let g:go_gopls_enabled = 1
" let g:go_def_mode = 'gopls'
" let g:go_info_mode = 'gopls'
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_variable_declarations = 1
" let g:go_highlight_variable_assignments = 1
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_diagnostic_errors = 1
" let g:go_highlight_diagnostic_warnings = 1
" let g:go_auto_type_info = 1
" let g:go_auto_sameids = 0
" let g:go_metalinter_command='golangci-lint'
" let g:go_metalinter_command='golint'
" let g:go_metalinter_autosave=0
" let g:go_gopls_analyses = { 'composites' : v:false }
" " au FileType go nmap <leader>t :GoTest!<CR>
" " au FileType go nmap <leader>v :GoVet!<CR>
" " au FileType go nmap <leader>b :GoBuild!<CR>
" " au FileType go nmap <leader>c :GoCoverageToggle<CR>
" " au FileType go nmap <leader>i :GoInfo<CR>
" " au FileType go nmap <leader>l :GoMetaLinter!<CR>
" au FileType go nnoremap <leader>rs :!clear && go run %<CR>
" au FileType go nnoremap <leader>rn :GOVIMRename<CR>
" 
" call govim#config#Set("ExperimentalMouseTriggeredHoverPopupOptions", {
"       \ "mousemoved": "any",
"       \ "pos": "topleft",
"       \ "line": +1,
"       \ "col": 0,
"       \ "moved": "any",
"       \ "wrap": v:false,
"       \ "close": "click",
"       \ "padding": [0, 1, 0, 1],
"       \})
" 

" Key maps
let mapleader="\<space>"
tnoremap <esc> <C-\><C-N>
nnoremap <silent><leader>up :source ~/.vim/vimrc<CR> :PlugInstall<CR>
nnoremap <F9> :source ~/.vim/vimrc<CR>
nnoremap <silent><leader>rc :e ~/.vim/vimrc<CR>
nnoremap <C-L> :nohl<CR><C-L>
nnoremap <silent><leader>b :buffers<CR>

" Toggle Quickfix Window
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        :top cw 10
     else
        cw
    endif
endfunction

nnoremap <silent><leader>qw :call ToggleQuickFix()<CR>

" Shellcheck a bash/sh script - Run current file in bash
au FileType sh nnoremap <leader>sc :!clear && shellcheck %<CR>
au FileType sh nnoremap <leader>rs :!clear && bash %<CR>

" Folding
nnoremap <leader>f za

" Undo tree
let g:undotree_WindowLayout=2
nnoremap <silent><leader>ut :UndotreeToggle<CR>

" Spellchecking switching key binds
nnoremap <silent><leader>se :setlocal spell spelllang=sv<CR>
nnoremap <silent><leader>en :setlocal spell spelllang=en<CR>
nnoremap <silent><leader>ns :set nospell<CR>
hi SpellBad guifg=#E06C75

" Codeium Settings
" let g:codeium_enabled = v:false
let g:codeium_disable_bindings = 1
imap <script><silent><nowait><expr> <C-g> codeium#Accept()
