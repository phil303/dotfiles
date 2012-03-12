" Section - Options {{{1
" ----------------------
" Pathogen Settings {{{2
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
filetype plugin indent on

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
set wildignore=*~,.git,tmp,_site,*.log	"Matching files ignored
set wildmode=list:longest,full      "act more like bash
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
set mouse=a           "Enable mouse in all modes
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
set foldmethod=marker "Folding on markers

" Status line {{{2
set statusline=%F%m%r%h%w
set statusline+=\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}
set statusline+=\ %#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=(%{&ff}/%Y)
set statusline+=\ (line\ %l\/%L,\ col\ %c)
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

" RubyComplete{{{2
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1
" }}}2

" Mappings {{{1
let mapleader = ","

imap hh =>
" Esc to remove search highlighting
nnoremap <silent> <esc> :noh<return><esc>
" Use ctrl+hjkl to move between window splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" Creat empty line without leaving normal mode
nnoremap <Enter> m`o<Esc>k``

" Keep search matches in middle of window
nnoremap <silent> n nzzzv:call PulseCursorLine()<cr>
nnoremap <silent> N Nzzzv:call PulseCursorLine()<cr>
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
" Autocompletion (based off lucapette vimrc)
"" Omni completion with ctrl-space
inoremap <expr> <C-o> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"

"" User defined completion with ctrl-u.
inoremap <expr> <C-u> pumvisible() \|\| &completefunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-u><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
"" make ctrl-j/ctrl-k do the same thing in all popup menus
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"


"Shortcuts
" Toggle 'set list'
nmap <leader>l :set list!<CR>
" Edit vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
" Git
nmap <leader>gd :Gdiff<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gw :Gwrite<CR>

" Plugins {{{1
" NERDTree
nmap <silent> <leader>n :NERDTreeToggle %:p:h<CR>
let g:NERDTreeWinSize = 22
let g:NERDTreeChDirMode = 2       "Change CWD to NERDTree root

" Snipmate
let g:snipMate = {'no_match_completion_feedkeys_chars': "\<tab>" }    "Fixes tab
let g:snips_trigger_key = '<Tab>'

" Command-t
let g:CommandTMatchWindowAtTop = 1

" Syntastic
let g:syntastic_enable_signs = 1
let g:syntastic_disabled_filetypes = ['html']
let g:syntastic_stl_format = '[%E{Error 1/%e: line %fe}%B{, }%W{Warning 1/%w: line %fw}]'
let g:syntastic_auto_loc_list = 2

" Gundo
nnoremap <silent> <leader>u :GundoToggle<CR>
let g:gundo_right = 1

" Vim-Ruby-docs
let g:ruby_doc_command='open'

" Experimental Test Functions {{{1
function! PulseCursorLine()       "From Steve Losh vimrc
    let current_window = winnr()

    windo set nocursorline
    execute current_window . 'wincmd w'

    setlocal cursorline

    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    hi CursorLine guibg=#2a2a2a
    redraw
    sleep 5m

    hi CursorLine guibg=#333333
    redraw
    sleep 5m

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 5m

    hi CursorLine guibg=#444444
    redraw
    sleep 5m

    hi CursorLine guibg=#4a4a4a
    redraw
    sleep 5m

    hi CursorLine guibg=#444444
    redraw
    sleep 5m

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 5m

    hi CursorLine guibg=#333333
    redraw
    sleep 5m

    hi CursorLine guibg=#2a2a2a
    redraw
    sleep 5m

    execute 'hi ' . old_hi

    windo set nocursorline
    execute current_window . 'wincmd w'
endfunction
" }}}1
