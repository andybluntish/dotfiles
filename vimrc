set nocompatible

call plug#begin('~/.vim/bundle')

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'gmarik/sudo-gui.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-eunuch'

Plug 'osyo-manga/vim-over'
Plug 'jremmen/vim-ripgrep'
Plug 'Raimondi/delimitMate'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'PeterRincker/vim-argumentative'
Plug 'w0rp/ale'
Plug 'vim-scripts/SearchComplete'

Plug 'othree/html5.vim'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-haml'
Plug 'mustache/vim-mustache-handlebars'

Plug 'JulesWang/css.vim'
Plug 'ap/vim-css-color'

Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'kchmck/vim-coffee-script'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'

Plug 'rakr/vim-one'

call plug#end()


" General
set ttyfast                    " Send more characters at a given time
set ttimeoutlen=0              " Fix delay when escaping from insert with Esc
set mouse=a                    " Enable mouse in all in all modes
set clipboard=unnamed          " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set history=100                " Number of :cmdline history items to store
set nostartofline              " Don't reset cursor to start of line when moving around
set nofoldenable               " No folding


" Appearance
syntax on                      " Turn on syntax highlighting
set synmaxcol=300              " Number of columns to apply syntax highlighting
set ruler                      " Show the cursor position
set showcmd                    " Show the (partial) command as it’s being typed
set noshowmode                 " Don't show the current mode (airline.vim takes care of us)
set laststatus=2               " Always show status line
set visualbell                 " Use visual bell instead of audible bell (annnnnoying)
set title                      " Show the filename in the window titlebar
set number                     " Enable line numbers
set nowrap                     " Disable soft-wrap
set showbreak=↪\               " Character to display at the start of soft-wrapped lines
set lazyredraw                 " Don't redraw when we don't have to
set incsearch                  " Shows the search as you type!
set hlsearch                   " Highlight search matches
set list                       " Show hidden characters
set listchars=tab:»·,trail:·,extends:>,precedes:<
set scrolloff=3                " Minimal number of lines to keep above and below the cursor
set sidescrolloff=3            " Minimal number of columns to keep to the left and right of the cursor
set winminheight=0             " Allow splits to be reduced to a single line

if (has("termguicolors"))
  " use 24-bit colour
  set termguicolors
else
  " use 265 colours
  set t_Co=256
endif

" use italics in gui
if (has("gui_running"))
  let g:one_allow_italics = 1
endif

colorscheme one
set background=dark


" Files and buffers
silent !mkdir -p $HOME/.vim/undo > /dev/null 2>&1
set undodir=~/.vim/undo        " Directory to save undo files
set undofile                   " Persist undo history to a file
set undolevels=1000            " Maximum number of changes that can be undone
set nobackup                   " Don't make a backup before overwriting a file
set nowritebackup              " Don't make a backup before writing the file
set noswapfile                 " Don't create swap files
set hidden                     " Allow buffers to exist in the background
set autoread                   " Read open files again when changed outside Vim
set wildmenu                   " Enhanced completion mode
set wildmode=list:longest,list:full
set wildignore+=.DS_Store      " File patterns to ignore when expanding wildcards
set wildignore+=*/vim/undo*
set wildignore+=*/.git/*
set wildignore+=*/.sass-cache/*
set wildignore+=*/bower_components/*
set wildignore+=*/node_modules/*
set wildignore+=*/vendor/*
set wildignore+=*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd


" Text and editing
set backspace=indent,eol,start " Backspacing over everything in insert mode
set encoding=utf-8             " Set the default character encoding
set nobomb                     " No BOMs
set spelllang=en_au,en_gb      " Spellchecking languages
set linebreak                  " Break on boundaries when wrapping
set nojoinspaces               " Only one space when joining lines
set expandtab                  " Spaces, not tabs-obviously ;-)
set tabstop=2                  " Set the wisth of hard tabs
set softtabstop=2              " Set the width of soft tabs
set shiftwidth=2               " Set the width of indents
set shiftround                 " Round indents to multiples of 'shiftwidth'
set autoindent                 " Copy indent from current line when starting a new line
set smartindent                " Be smart about auto indenting
set ignorecase                 " Ignore case in search patterns
set smartcase                  " Obey case if there's an upper case character in search patterns
set iskeyword+=-,_,$,@,%,#,?   " These are not word dividers
set omnifunc=syntaxcomplete#Complete


" File types
filetype plugin indent on
augroup filetypedetect
au BufNewFile,BufRead *.{rjs,rbw,gem,gemspec,ru,rake} setlocal filetype=ruby
au BufNewFile,BufRead {Gemfile,Guardfile,Rakefile,Capfile,Procfile} setlocal filetype=ruby
au BufNewFile,BufRead *.ejs setlocal filetype=html

au FileType text setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 spell
au FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
au FileType plaintex setlocal spell
au FileType make setlocal noexpandtab
au FileType markdown setlocal iskeyword-=/ wrap linebreak nolist textwidth=0 wrapmargin=0 spell

au FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
au FileType html,xml,markdown setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
au FileType python setlocal omnifunc=pythoncomplete#Complete
augroup END


" Mappings
let mapleader=" "

" Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Resize splits with arrow keys
nnoremap <Left> :vertical resize +1<CR>
nnoremap <Right> :vertical resize -1<CR>
nnoremap <Up> :resize +1<CR>
nnoremap <Down> :resize -1<CR>

" Fix page up and down
map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>

" Move based on display lines, not physical lines
map j gj
map k gk

" Move selected lines up and down
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Paste toggle
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>

" Clear Highlight
nnoremap <Esc><Esc> :nohlsearch<CR>

" Removes doc lookup binding because it's easy to fat finger
nmap K k
vmap K k

" jj in insert mode exits back to normal mode
inoremap jj <Esc>

" save without reaching for :
map <Leader>w :w<CR>

" use ; instead of : because it is quicker
nnoremap ; :

" Use ;w!! to sudo save a file
cnoremap w!! w !sudo tee % >/dev/null

" Toggle buffer diff
nnoremap <Leader>don :diffthis<CR>
nnoremap <Leader>dof :diffoff<CR>

" Zoom / Restore splits
function! ToggleZoomWindow() abort
  if exists('t:zoomed') && t:zoomed
    exec t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction

nnoremap <leader>z :call ToggleZoomWindow()<CR>

" Toggle background
nnoremap <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Plugins

" Airline.vim
let g:airline_powerline_fonts = 1

" Make CtrlP search in the current working directory by default
" Useful for monorepos
let g:ctrlp_cmd = 'CtrlP .'

" Use rg (ripgrep) in CtrlP for listing files.
" Respects .gitignore, and is fast enough to not require caching.
if executable('rg')
  let g:ctrlp_user_command = 'rg --vimgrep --files --smart-case %s'
  let g:ctrlp_use_caching = 0
endif

" List open buffers
noremap <leader>b :CtrlPBuffer<CR>

" Delete trailing whitespace
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'
au FileType markdown let g:DeleteTrailingWhitespace = 0

" Find/Replace in whole buffer
function! VisualFindAndReplace()
  :OverCommandLine%s/
  :w
endfunction

" Find/Replace within current visual selection
function! VisualFindAndReplaceWithSelection() range
  :'<,'>OverCommandLine s/
  :w
endfunction

nnoremap <Leader>fr :call VisualFindAndReplace()<CR>
xnoremap <Leader>fr :call VisualFindAndReplaceWithSelection()<CR>

" Delimitmate
let g:delimitMate_expand_cr = 1

" Commentry
map <leader>/ :Commentary<CR>

" NERDTree
let g:NERDTreeHijackNetrw = 0
noremap <leader>dn :NERDTreeToggle<CR>
noremap <leader>nn :NERDTreeFind<CR>
noremap <leader>fn :NERDTreeFocus<CR>

" Ale
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_fixers = { 'javascript': [ 'eslint' ] }

nmap <silent> <leader>E <Plug>(ale_previous_wrap)
nmap <silent> <leader>e <Plug>(ale_next_wrap)
nmap <silent> <leader>fx <Plug>(ale_fix)

" JSON
let g:vim_json_syntax_conceal = 0

" Markdown
let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']
