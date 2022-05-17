" Vundle Settings {{{1
filetype off
" I don't know why this works for go syntax highlighting but it does
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
nnoremap <leader>` :PluginInstall!<CR>

Plugin 'gmarik/vundle'

" Utility
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/Gundo'

" Appearance
Plugin 'airblade/vim-gitgutter'
Plugin 'kshenoy/vim-signature'
Plugin 'Lokaltog/vim-powerline'

" Syntax
Plugin 'vim-syntastic/syntastic'
Plugin 'fatih/vim-go'
Plugin 'gg/python.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'mxw/vim-jsx'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-markdown'
Plugin 'vim-ruby/vim-ruby'

filetype plugin indent on     " required



" Options {{{1
" ----------------------
" General Settings
set nocompatible

set encoding=utf-8    " Default encoding set to utf-8
set nomodeline        " Modelines for diff ft handling but are a security risk.
set scrolloff=3       " Scroll offset equal to 3 lines
set showmode          " Vim default on. Vi off. Displays mode in command line.
set undofile          " Vim automatically saves undo history to an undo file
set undoreload=10000  " Save the whole buffer for undo when reloading it.
set nolist            " Show invisible symbols as characters.
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:·  
set showbreak=↪       " When breakline is present, show argument as character
set wildmenu          " Turns command-line completion on
set wildignore=*~,*.log,*.pyc	"Matching files ignored
set wildmode=list:longest,full          "act more like bash
set wrap              " Wraps text
set linebreak         " Wrap breaks at word boundaries
set virtualedit+=block  "Don't get.  Most people recommend though
set autoindent        " Indented lines have the same indent level
set autoread          " Externally updated files are automatically read
set autowrite         " Autosave modified buffers when switching to another
set backspace=indent,eol,start    "Backspace over indents, line breaks, etc.
set completeopt=longest,menuone   "Completion options
set guioptions-=A     " Disallows putting selected text into copy register
set guioptions-=T     " Disallows gui toolbar
set guioptions-=m     " Disallows gui menubar
set guioptions-=r     " Disallows right handed scrollbar
set guioptions-=R
set guioptions-=l     " Disallows left handed scrollbar
set guioptions-=L     
set history=1000      " History of ':' commands.  Vim default is 20.
set hlsearch          " Highlight search matches
set ignorecase        " Ignores case of search terms
set smartcase         " Override 'ignorecase' if search contains uppercases.
set incsearch         " matches as you type
set laststatus=2      " 2 means all windows will have a status line
set magic             " Default on. Allows for special char. in search patterns
set matchtime=3       " Argument is the tenths of a second until matching parens
set ruler             " Show the cursor position (row,column)
set shiftwidth=2      " Number of spaces used for autoindent
set shiftround        " Round indent to multiple of 'shiftwidth'
set expandtab         " Tabs are expanded as spaces
set tabstop=2         " Number of spaces tab accounts for
set softtabstop=2     " Tabs count for 2 spaces when editing
set smarttab          " sw at the start of the line, sts everywhere else
set showmatch         " When a bracket is inserted, briefly jump to matching one
set splitright        " New buffers open on the right side of current buffer
set splitbelow        " New buffers open below current buffer
set textwidth=78      " Max width of text inserted.  '0' disables
set noerrorbells      " Default off. Turn off audible bell
set visualbell        " Default off.  Turn on visual bell
set number            " Row numbers
set lazyredraw        " Don't redraw when don't have to
set clipboard=unnamed " all operations work with OS clipboard
set colorcolumn=+1    " color background slightly different at text width + 1
set cursorline        " highlight current line
set lazyredraw
" set autochdir

" Fold for only Vimscript
augroup filetype_vim
  autocmd!
  autocmd Filetype vim setlocal foldmethod=marker
augroup end

" Use a bar-shaped cursor for insert mode, even through tmux. (Steve Losh)
if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    autocmd VimEnter * set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter * set ttymouse=xterm2
  endif
endif

" Set colorscheme {{{2
" Hack, revert a change in gitgutter's behavior. 
" This has to be set before solarized for some reason
autocmd ColorScheme * 
      \ highlight clear SignColumn
      \ highlight GitGutterAdd ctermfg=green
      \ highlight GitGutterChange ctermfg=yellow
      \ highlight GitGutterDelete ctermfg=red
      \ highlight GitGutterChangeDelete ctermfg=yellow

syntax enable
set background=dark
colorscheme solarized
call togglebg#map("<F5>")   " Toggle colorscheme b/w light and dark with F5

"}}}2

" Backups {{{2
" 
" http://stackoverflow.com/questions/4331776/change-vim-swap-backup-undo-file-name
" Save your temp vim files to a less annoying place than the current directory.
if isdirectory(expand('~/.vim_tmp/backup')) == 0
  :silent !mkdir -p ~/.vim_tmp/backup >/dev/null 2>&1
endif
set backupdir=~/.vim_tmp/backup/
set backup

if isdirectory(expand('/.vim_tmp/swap')) == 0
  :silent !mkdir -p ~/.vim_tmp/swap >/dev/null 2>&1
endif
set directory=~/.vim_tmp/swap//

if exists("+undofile")
  if isdirectory(expand('/.vim_tmp/undo')) == 0
    :silent !mkdir -p ~/.vim_tmp/undo > /dev/null 2>&1
  endif
  set undodir=~/.vim_tmp/undo//
  set undofile
endif
" }}}2

" Resize splits when vim is resized {{{2
autocmd VimResized * exe "normal! \<c-w>="
" Jump to last known cursor position
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
" }}}2

" Filetype Adjustments{{{1
" get rid of annoying whitespace on save
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

if has('autocmd')
  autocmd Filetype python setlocal ai et sta sw=4 sts=4
  autocmd Filetype coffee setlocal ai et sta sw=4 sts=4
  autocmd FileType typescript,javascript,c,cpp,java,php,python,coffee,scss,css autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
  autocmd FileType gitcommit set tw=72
endif
" }}}1
" Mappings {{{1
let mapleader = ","

" Better hand movements
inoremap jj <Esc>

" No more shifting to get the colon
nnoremap ; :

" move over wrapped lines
nnoremap j gj
nnoremap k gk

" esc to clear search highlighting
nnoremap Z :let @/ = ""<cr><esc>

" Better beginning/end of line movements
nnoremap H ^
nnoremap L $

" Remap K to split lines (Steve Losh)
nnoremap K i<CR><Esc><Right>mwgk:silent! s/\v +$//<CR>:noh<CR>`w

" Remap J to split lines (Steve Losh)
nnoremap J mzJ`z

" Yank selection ot system keyboard
vnoremap Y "*y

" Use ctrl+hjkl to move between window splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Create empty line without leaving normal mode
nnoremap <Enter> m`o<Esc>k``

" Keep search matches in middle of window
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv

" Respect destination indentation level when pasting
nnoremap <leader>p p
nnoremap <leader>P P
nnoremap p p'[v']=
nnoremap P P'[v']=
vnoremap <D-l> >gv

"" make ctrl-j/ctrl-k do the same thing in all popup menus
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"


"Shortcuts
" Toggle 'set list'
nnoremap <leader>l :set list!<CR>
nnoremap <leader>rl :g/^\W*$/d<CR>
" Edit vimrc file
nnoremap <silent> <leader>ev :execute "split" resolve(expand($MYVIMRC))<CR>
nnoremap <leader>sv :source $MYVIMRC<CR> :echo "Sourced!"<CR>

" Plugins {{{1
" NERDTree
nnoremap <silent> <leader>n :NERDTreeToggle %:p:h<CR>
let g:NERDTreeWinSize   = 22
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.pyc$']

" CtrlP / CtrlP extension funky
nnoremap <silent> <leader>p :CtrlPMixed<CR>
nnoremap <silent> <leader>P :CtrlP<CR>
nnoremap <silent> <leader>o :CtrlPFunky<CR>
nnoremap <silent> <leader>O :execute 'CtrlPFunky ' . expand('<cword>')<CR>
let g:ctrlp_prompt_mappings   = { 'PrtClearCache()': ['<F5>','<c-r>'] }
let g:ctrlp_reuse_window      = 'NERD_tree_2'
let g:ctrlp_working_path_mode = 2   " Find nearest parent folder with source control
let g:ctrlp_extensions = ['mixed', 'funky']
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_show_hidden = 0

" Syntastic
let g:syntastic_stl_format         = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
nnoremap <silent> <leader>e :Errors<CR>

" Fugitive
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gb :Gblame<CR>

" Gundo
nnoremap <silent> <leader>u :GundoToggle<CR>
let g:gundo_right = 1

" vim-go
let g:go_fmt_command = "goimports"

" vim-jsx
let g:jsx_ext_required = 0

" rename.vim
nnoremap <leader>r :Rename
