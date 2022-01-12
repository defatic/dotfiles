call plug#begin('$HOME/.vim/plugged')
Plug 'junegunn/vim-plug'
" Light Line status bar [nice to have]
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
" Colorscheme
" Plug 'tek256/simple-dark'
Plug 'arcticicestudio/nord-vim'
Plug 'rakr/vim-one'
" Delimitmate
Plug 'Raimondi/delimitMate'
" CSS Colors
Plug 'ap/vim-css-color'
" CoC - Code Completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" CTRL-P
Plug 'ctrlpvim/ctrlp.vim'
" Undotree
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
" Markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'rwxrob/vim-pandoc-syntax-simple'
" Vim go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
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
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
set showmatch
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
      \   'left': [ [ 'mode', 'paste'],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] },
      \ 'component_function': { 'gitbranch': 'gitbranch#name' }, }

" Clang Format config
let g:clang_format#auto_format = 1
let g:clang_format#code_style = "LLVM"
let g:clang_format#style_options = {
      \ "AllowShortIfStatementsOnASingleLine" : "true",
      \ "IndentCaseLabels" : "true",
      \ "IndentWidth" : 2,
      \ "TabWidth" : 2,
      \ "PointerAlignment" : "Left",
      \ "AlignConsecutiveMacros" : "true",
      \ "AlignConsecutiveAssignments" : "true",
      \ "AlignConsecutiveDeclarations" : "true",
      \ "AlignEscapedNewlines" : "true",
      \ "AlignTrailingComments" : "true",
      \ "AlignOperands" : "true",
      \ "AllowShortBlocksOnASingleLine" : "true",
      \ "AllowShortFunctionsOnASingleLine" : "true",
      \ "ColumnLimit" : 79,
      \ "KeepEmptyLinesAtTheStartOfBlocks" : "false",
      \ "SortIncludes" : "false",
      \ "SpaceAfterCStyleCast" :"false" }

" CoC Settings
let g:coc_disable_startup_warning = 1

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <buffer> <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <buffer> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <buffer> <silent><expr> <C-space> coc#refresh()

" GoTo code navigation.
nmap <buffer> <leader>gd <Plug>(coc-definition)
nmap <buffer> <leader>gy <Plug>(coc-type-definition)
nmap <buffer> <leader>gi <Plug>(coc-implementation)
nmap <buffer> <leader>gr <Plug>(coc-references)
nnoremap <buffer> <leader>cr :CocRestart<CR>

" golang
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = 'goimports'
let g:go_fmt_autosave = 1
let g:go_gopls_enabled = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1
let g:go_auto_type_info = 1
let g:go_auto_sameids = 0
let g:go_metalinter_command='golangci-lint'
let g:go_metalinter_command='golint'
let g:go_metalinter_autosave=0
let g:go_gopls_analyses = { 'composites' : v:false }
au FileType go nmap <leader>t :GoTest!<CR>
au FileType go nmap <leader>v :GoVet!<CR>
au FileType go nmap <leader>b :GoBuild!<CR>
au FileType go nmap <leader>c :GoCoverageToggle<CR>
au FileType go nmap <leader>i :GoInfo<CR>
au FileType go nmap <leader>l :GoMetaLinter!<CR>

" Key maps
let mapleader="\<space>"
tnoremap <esc> <C-\><C-N>
nnoremap <silent><leader>up :source ~/.vim/vimrc<CR> :PlugInstall<CR>
nnoremap <F9> :source ~/.vim/vimrc<CR>
nnoremap <silent><leader>rc :e ~/.vim/vimrc<CR>
nnoremap <C-L> :nohl<CR><C-L>

" Folding
nnoremap <leader>f za

" Undo tree
nnoremap <silent><leader>ut :UndotreeToggle<CR>

" Tabs
nnoremap <silent><C-t> :tabnew<CR>
nnoremap <silent><S-w> :tabclose<CR>

" Spellchecking switching key binds
nnoremap <leader>se :setlocal spell spelllang=sv<CR>
nnoremap <leader>en :setlocal spell spelllang=en<CR>
nnoremap <silent><leader>ns :set nospell<CR>
hi SpellBad guifg=#E06C75

" Window navigation made easy
" nnoremap <c-j> <c-w>j
" nnoremap <c-k> <c-w>k
" nnoremap <c-h> <c-w>h
" nnoremap <c-l> <c-w>l

" Strip trailing white spaces
" fun! TrimWhitespace()
"   let l:save = winsaveview()
"   keeppatterns %s/\s\+$//e
"   call winrestview(l:save)
" endfun

" autocmd BufWritePre * :call TrimWhitespace()
