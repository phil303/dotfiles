" Options {{{1
" ----------------------
" Vundle Settings {{{2
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'vim-ruby/vim-ruby'
Bundle 'altercation/vim-colors-solarized'
Bundle 'garbas/vim-snipmate'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-markdown'
Bundle 'vim-scripts/matchit.zip'
Bundle 'vim-scripts/Gundo'
Bundle 'vim-scripts/mako.vim'
Bundle 'vim-scripts/closetag.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-powerline'
Bundle 'kchmck/vim-coffee-script'
Bundle 'gg/python.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'airblade/vim-gitgutter'

filetype plugin indent on     " required


" }}}2
" General Settings
set nocompatible

set encoding=utf-8    "Default encoding set to utf-8
set nomodeline        "Modelines for diff ft handling but are a security risk.
set scrolloff=3       "Scroll offset equal to 3 lines
set showmode          "Vim default on. Vi off. Displays mode in command line.
set fillchars=diff:\  "'\' replaces '-' in Vim diff
set undofile          "Vim automatically saves undo history to an undo file
set undoreload=10000  "Save the whole buffer for undo when reloading it.
set nolist            "Show invisible symbols as characters.
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set showbreak=↪       "When breakline is present, show argument as character
set wildmenu          "Turns command-line completion on
set wildignore=*~,.git,tmp,_site,*.log,*.pyc	"Matching files ignored
set wildmode=list:longest,full          "act more like bash
set wrap              "Wraps text
set linebreak         "Wrap breaks at word boundaries
set virtualedit+=block  "Don't get.  Most people recommend though
"set autochdir         "Change working directory to that of the file opened
set autoindent        "Indented lines have the same indent level
set autoread          "Externally updated files are automatically read
set autowrite         "Autosave modified buffers when switching to another
set backspace=indent,eol,start    "Backspace over indents, line breaks, etc.
set completeopt=longest,menuone   "Completion options
set gdefault          "Global substitution is set on
set guioptions-=A     "Disallows putting selected text into copy register
set guioptions-=T     "Disallows gui toolbar
set guioptions-=m     "Disallows gui menubar
set guioptions-=r     "Disallows right handed scrollbar
set guioptions-=R
set guioptions-=l     "Disallows left handed scrollbar
set guioptions-=L     
set history=1000      "History of ':' commands.  Vim default is 20.
set hlsearch          "Highlight search matches
set ignorecase        "Ignores case of search terms
set smartcase         "Override 'ignorecase' if search contains uppercases.
set incsearch         "matches as you type
set laststatus=2      "2 means all windows will have a status line
set magic             "Default on. Allows for special char. in search patterns
set matchtime=3       "Argument is the tenths of a second until matching parens
set ruler             "Show the cursor position (row,column)
set shiftwidth=2      "Number of spaces used for autoindent
set shiftround        "Round indent to multiple of 'shiftwidth'
set expandtab         "Tabs are expanded as spaces
set tabstop=2         "Number of spaces tab accounts for
set softtabstop=2     "Tabs count for 2 spaces when editing
set smarttab          "sw at the start of the line, sts everywhere else
set showmatch         "When a bracket is inserted, briefly jump to matching one
set splitright        "New buffers open on the right side of current buffer
set splitbelow        "New buffers open below current buffer
set textwidth=78      "Max width of text inserted.  '0' disables
set noerrorbells      "Default off. Turn off audible bell
set visualbell        "Default off.  Turn on visual bell
set number            "Row numbers
set clipboard=unnamed "all operations work with OS clipboard

" Fold for only Vimscript
augroup filetype_vim
  autocmd!
  autocmd Filetype vim setlocal foldmethod=marker
augroup end

" Use a bar-shaped cursor for insert mode, even through tmux. (Steve Losh)
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

if has('mouse')
  set mouse=a
  if &term =~ "xterm" || &term =~ "screen"
    autocmd VimEnter * set ttymouse=xterm2
    autocmd FocusGained * set ttymouse=xterm2
    autocmd BufEnter * set ttymouse=xterm2
  endif
endif

" Status line {{{2
" Turned off for Powerline
"set statusline=%F%m%r%h%w
"set statusline+=\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}
"set statusline+=\ %#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"set statusline+=%=(%{&ff}/%Y)
"set statusline+=\ (line\ %l\/%L,\ col\ %c)
" }}}2

" Set colorscheme {{{2
syntax enable
set background=dark
colorscheme solarized
call togglebg#map("<F5>")   " Toggle colorscheme b/w light and dark with F5
"}}}2

" Backups {{{2
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files
set backup
" }}}2

" Resize splits when vim is resized {{{2
autocmd VimResized * exe "normal! \<c-w>="
" Jump to last known cursor position
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
" }}}2

" Autocompletion{{{2
if has('autocmd')
  autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
  autocmd FileType python set omnifunc=pythoncomplete#Complete
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType c set omnifunc=ccomplete#Complete
  autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete " may require ruby compiled in
  autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
  autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
endif
" }}}2

" Filetype Adjustments{{{2
if has('autocmd')
  autocmd Filetype python setlocal ai et sta sw=4 sts=4
  autocmd Filetype coffee setlocal ai et sta sw=4 sts=4
  autocmd BufRead,BufNewFile *.pde set filetype=arduino
  autocmd BufRead,BufNewFile *.ino set filetype=arduino
endif
" }}}2


" Abbreviations {{{1
iabbrev hh =>
iabbrev @@ philaquilina@gmail.com
iabbrev ww philaquilina.com

" Mappings {{{1
let mapleader = ","

" Better hand movements
inoremap jj <Esc>
inoremap uu _

" 
nnoremap j gj
nnoremap k gk

" Better beginning/end of line movements
nnoremap H ^
nnoremap L $

" Remap K to split lines (Steve Losh)
nnoremap K i<CR><Esc><Right>mwgk:silent! s/\v +$//<CR>:noh<CR>`w

" Remap J to split lines (Steve Losh)
nnoremap J mzJ`z

" Yank selection ot system keyboard
vnoremap Y "*y

" Esc to remove search highlighting
nnoremap <silent> <esc> :noh<return><esc>

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
" Move a line of text using Alt+[jk], indent with Alt+[hl]
nnoremap <D-j> :m+<CR>==
nnoremap <D-k> :m-2<CR>==
nnoremap <D-h> <<
nnoremap <D-l> >>
inoremap <D-j> <Esc>:m+<CR>==gi
inoremap <D-k> <Esc>:m-2<CR>==gi
inoremap <D-h> <Esc><<`]a
inoremap <D-l> <Esc>>>`]a
vnoremap <D-j> :m'>+<CR>gv=gv
vnoremap <D-k> :m-2<CR>gv=gv
vnoremap <D-h> <gv

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
" Edit vimrc file
nnoremap <silent> <leader>ev :execute "split" resolve(expand($MYVIMRC))<CR>
nnoremap <leader>sv :source $MYVIMRC<CR> :echo "Sourced!"<CR>

" Plugins {{{1
" NERDTree
nnoremap <silent> <leader>n :NERDTreeToggle %:p:h<CR>
let g:NERDTreeWinSize   = 22
let g:NERDTreeChDirMode = 2       "Change CWD to NERDTree root
let g:NERDTreeIgnore = ['\.pyc$']

" Snipmate
let g:snipMate          = {'no_match_completion_feedkeys_chars': "\<tab>" }    "Fixes tab
let g:snipMateNextOrTrigger = '<Tab>'

" CtrlP
nnoremap <silent> <leader>p :CtrlP<CR>
let g:ctrlp_prompt_mappings   = { 'PrtClearCache()': ['<F5>','<c-r>'] }
let g:ctrlp_reuse_window      = 'NERD_tree_2'
let g:ctrlp_working_path_mode = 2  "Find nearest parent folder with source control

" Syntastic
let g:syntastic_enable_signs       = 1
let g:syntastic_disabled_filetypes = ['html']
let g:syntastic_stl_format         = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'
let g:syntastic_auto_loc_list      = 2
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
