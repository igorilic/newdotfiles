" Use Vim settings rather then Vi
set nocompatible
set encoding=utf-8
scriptencoding utf-8
au BufWritePost ~/.vimrc so ~/.vimrc

" Leader - (')
let mapleader = "'"

" === General Config ===

set backspace=2 " Backspace deletes
set history=1000
set ruler " show the cursor position all the time
set showcmd " display incomplete command
set laststatus=2 " always display the status line
set autowrite " automatically :write before running commands
set autoread " reload files changed outside vim
au FocusGained,BufEnter * :silent! !

" --- no swap ---
set nobackup
set nowritebackup
set noswapfile

" --- set default font
set guifont=Inconsolata\ for\ Powerline:h24
set cursorline " highlight the current line
set visualbell " stop beeping
set wildmenu
set wildmode=list:longest,full

" --- search ---
set gdefault " never have to type /g at the end of search / replace
set ignorecase " case insensitive searching
set smartcase
set hlsearch
nnoremap <silent> <leader>, :noh<cr> " stop hl after search
set incsearch
set showmatch

" --- tabs
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" 80 chars 
set textwidth=80
set formatoptions=qrn1
set wrapmargin=0
set colorcolumn=+1

" --- numbers ---
set number
set numberwidth=5

" --- auto resize ---
set winwidth=104
set winheight=5
set winminheight=5
set winheight=999

" --- matchpairs ---

set matchpairs+=<:>
set matchpairs+=“:”
set matchpairs+=‘:’
set matchpairs+=►:◄
set matchpairs+=«:»

" tret <li> and <p> tags like the block tags
let g:html_indent_tags = 'li\|p'

" === scrolling ===

set scrolloff=8 " start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" === toggle relative numbering ===
set rnu
function! ToggleNumberOn()
  set nu!
  set rnu
endfunction
function! ToggleRelativeOn()
  set rnu!
  set nu
endfunction
autocmd FocusLost * call ToggleRelativeOn()
autocmd FocusGained * call ToggleRelativeOn()
autocmd InsertEnter * call ToggleRelativeOn()
autocmd InsertLeave * call ToggleRelativeOn()

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" navigate properly when ines are wrapped
nnoremap j gj
nnoremap k gk

" use tab to jump between blocks
nnoremap <tab> %
vnoremap <tab> %

" vertical diffs
set diffopt+=vertical

" switch syntax hl on when the terminal has colors
if (&t_Co >2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Load all plugins
" TODO
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

""" System clipboard copy and paste support
set pastetoggle=<F2>
" --- copy paster to /from clipboard
vnoremap <C-c> "*y
map <silent><Leader>p :set paste<CR>o<esc>"*]p:set nopaste<cr>"
map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<cr>"

" === keyboard shortcuts ===

nnoremap <leader>q @q

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<C-R>:cw<CR>

" bind \ to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
" Ag will search from project root
let g:ag_working_path_mode="r"

" map ctrl+s to save in any mode
nnoremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>
" map leader s
map <leader>s <C-S>

" quickly close window
nnoremap <leader>x :x<cr>
nnoremap <leader>X :q!<cr>

" zoom a vim pane, <C-w> to rebalance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" switch between the last two files
nnoremap <leader><leader> <c-^>

" resize panes
noremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

"inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

""" Autocommands

" save whenever switching windows or leaving vim
au FocusLost, WinLeave * :silent! wa

" automaticaly rebalanced windows on vim resize
autocmd VimResized * :wincmd =

"update dir to current file
autocmd BufEnter * silent! cd %:p:h

" syntastic eslint
let g:syntastic_javascript_checkers = ['eslint']
let g:jsx_ext_required = 0 " Allow JSX in normal JS files
