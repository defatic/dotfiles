call plug#begin('$HOME/.config/nvim/plugged')
" let vim-plug manage it self [must have]
Plug 'junegunn/vim-plug', { 'do': ':UpdateRemotePlugins' }
" Light Line [nice to have]
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
" Colorscheme
Plug 'chriskempson/base16-vim'
Plug 'tek256/simple-dark'
"Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
" Tabline
Plug 'mkitt/tabline.vim'
" Delimitmate
Plug 'Raimondi/delimitMate'
" Color Paren
Plug 'oblitum/rainbow'
" CSS Colors
Plug 'ap/vim-css-color'
" Vim Wiki
Plug 'vimwiki/vimwiki'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }
" CoC - Code Completion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" CTRL-P
Plug 'kien/ctrlp.vim'
" Undotree
Plug 'mbbill/undotree'
" LimeLight
Plug 'junegunn/limelight.vim'
" Python
Plug 'pappasam/jedi-language-server'

Plug '~/Programing/vim-plugins/test'
call plug#end()

" General settings
set nocompatible
filetype plugin on
syntax on

if !has("gui_running")
  set t_Co=256
endif

set termguicolors
set nobackup
set nowritebackup
set noswapfile
set noshowmode
set relativenumber
set tabstop=2 shiftwidth=2 softtabstop=2
set expandtab
set autoindent
set smartindent
set hlsearch
set incsearch
set showmatch
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set ignorecase
set smartcase
set laststatus=2
set textwidth=80
set ls=2
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
set undodir=~/.config/nvim/undodir
set undofile

" Enable rainbow paren
let g:rainbow_active = 1

" Python3 path
let g:python3_host_prog = '/usr/bin/python'

" Disable mouse click to go to position
set mouse-=a

" Vim Colorscheme
let g:gruvbox_material_background = 'hard'
colorscheme gruvbox-material

"colorscheme base16-ia-dark
set background=dark
"let base16colorspace=256

" Set highlight for search pattern
hi Search cterm=NONE ctermfg=204 ctermbg=236 guifg=#E06C75 guibg=#3E4452

" CTRL-P
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_use_caching = 0

" Undotree
nnoremap <silent><leader>u :UndotreeShow<CR>

" Light Line
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ] },
      \ 'component_function': { 'gitbranch': 'gitbranch#name' }, }

" Vim Wiki
let g:vimwiki_list = [ { 'path': '~/.vimwiki/', 'syntax': 'markdown', 'ext': '.md' } ]

" Clang Format config
let g:clang_format#auto_format = 1
let g:clang_format#code_style = "LLVM"
let g:clang_format#style_options = {
     \ "AllowShortIfStatementsOnASingleLine" : "false",
     \ "IndentCaseLabels" : "true",
     \ "IndentWidth" : 2,
     \ "PointerAlignment" : "Left",
     \ "TabWidth" : 2,
     \ "AlignConsecutiveMacros" : "true",
     \ "AlignConsecutiveAssignments" : "true",
     \ "AlignConsecutiveDeclarations" : "true",
     \ "AlignEscapedNewlines" : "true",
     \ "AlignTrailingComments" : "true",
     \ "AlignOperands" : "true",
     \ "AllowShortBlocksOnASingleLine" : "true",
     \ "AllowShortFunctionsOnASingleLine" : "true",
     \ "ColumnLimit" : 80,
     \ "KeepEmptyLinesAtTheStartOfBlocks" : "false",
     \ "SortIncludes" : "false",
     \ "SpaceAfterCStyleCast" :"false" }

" CoC Settings
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

" Keymaps
let mapleader="\<space>"
tnoremap <esc> <C-\><C-N>
nnoremap <leader>up :source ~/.config/nvim/init.vim<CR> :PlugInstall<CR>
nnoremap <F9> :source ~/.config/nvim/init.vim<CR>
nnoremap <silent><leader>cl :noh<CR>
nnoremap <silent><leader>rc :e ~/.config/nvim/init.vim<CR>

nnoremap <leader>f za

nnoremap <silent><leader>ll :Limelight!!<CR>

nnoremap <silent><C-t> :tabnew<CR>
nnoremap <silent><S-w> :tabclose<CR>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()