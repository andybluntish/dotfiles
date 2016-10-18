" Make vim more useful
set nocompatible

call plug#begin('~/.vim/bundle')

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'edkolev/tmuxline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'

Plug 'osyo-manga/vim-over'
Plug 'rking/ag.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/syntastic'

Plug 'othree/html5.vim'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-haml'
Plug 'mustache/vim-mustache-handlebars'

Plug 'JulesWang/css.vim'
Plug 'ap/vim-css-color'

Plug 'elzr/vim-json'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript', { 'branch': 'develop' }
Plug 'kchmck/vim-coffee-script'
Plug 'marijnh/tern_for_vim'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'heavenshell/vim-jsdoc'

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --tern-completer' }
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'elixir-lang/vim-elixir'

Plug 'jwhitley/vim-colors-solarized'
Plug 'w0ng/vim-hybrid'
Plug 'dracula/vim'

call plug#end()

filetype plugin indent on

" Syntax highlighting
syntax on
set t_Co=256
set background=dark
colorscheme hybrid

" Mapleader
let mapleader=" "

" Centralize backups, swapfiles and undo history
silent !mkdir -p $HOME/.vim/backups
silent !mkdir -p $HOME/.vim/swaps
silent !mkdir -p $HOME/.vim/undo

set backupdir=~/.vim/backups                      " Backup file directory
set directory=~/.vim/swaps                        " Swap file directory
set undodir=~/.vim/undo                           " Undo file directory
set undofile                                      " Persistent Undo
set undolevels=1000                               " Keep more levels of undo history

" set hidden                                        " When a buffer is brought to foreground, remember undo history and marks
set visualbell                                    " Use visual bell instead of audible bell (annnnnoying)
set ttyfast                                       " Send more characters at a given time
set ttimeoutlen=0                                 " Fix delay when escaping from insert with Esc
set encoding=utf-8                                " Set default encoding
set nobomb                                        " BOM often causes trouble
set clipboard=unnamed                             " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set mouse=a                                       " Enable mouse in all in all modes
set backspace=indent,eol,start                    " Backspacing over everything in insert mode
set autoread                                      " Read open files again when changed outside Vim
set lazyredraw                                    " Don't redraw when we don't have to
set title                                         " Show the filename in the window titlebar
set number                                        " Enable line numbers
set numberwidth=5                                 " set a wider number gutter
set showtabline=2                                 " Always show tab bar
set laststatus=2                                  " Always show status line
set ruler                                         " Show the cursor position
set noshowmode                                    " Don't show the current mode (airline.vim takes care of us)
set showcmd                                       " Show the (partial) command as it’s being typed
set report=0                                      " Show all changes
set list                                          " List mode
set listchars=tab:»·,trail:·,extends:>,precedes:< " set list mode characters
set autoindent                                    " Copy indent from last line when starting new line
set smarttab                                      " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces
set shiftwidth=2                                  " The # of spaces for indenting
set softtabstop=2                                 " Tab key results in # spaces
set expandtab                                     " Expand tabs to spaces
set hlsearch                                      " Highlight searches
set incsearch                                     " Highlight dynamically as pattern is typed
set ignorecase                                    " Ignore case of searches
set smartcase                                     " Ignore 'ignorecase' if search patter contains uppercase characters
set wildmenu                                      " Hitting TAB in command mode will show possible completions above command line
set wildmode=list:longest,list:full               " Complete only until point of ambiguity
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*,*/vendor/*
set wildignore+=*/.git/*,*/.sass-cache/*
set wildignore+=*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*
set winminheight=0                                " Allow splits to be reduced to a single line
set scrolloff=3                                   " Start scrolling three lines before horizontal border of window
set sidescrolloff=3                               " Start scrolling three columns before vertical border of window
set nofoldenable                                  " Open all folds by default
set nostartofline                                 " Don't reset cursor to start of line when moving around
set nowrap                                        " Do not wrap lines
set linebreak                                     " wrap lines at convenient points
set showbreak=↪\                                  " display marker for wrapped lines
set nojoinspaces                                  " Only insert single space after a '.', '?' and '!' with a join command
set diffopt=filler                                " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite                               " Ignore whitespace changes (focus on code changes)
set spelllang=en_au,en_gb                         " spelling language
set synmaxcol=300                                 " Stop highlighting after x columns

" General

" Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Resize splits
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

" Zoom / Restore window.
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

" JSON
au BufRead,BufNewFile *.json set ft=json syntax=javascript

" Handlebars
au BufRead,BufNewFile *.hbs,*.handlebars,*.hbs.erb,*.handlebars.erb set ft=mustache syntax=mustache

" Markdown
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set ft=markdown syntax=markdown
au FileType markdown let g:DeleteTrailingWhitespace = 0
au FileType markdown setlocal spell wrap
let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']

" Ruby
au BufRead,BufNewFile Rakefile,Capfile,Gemfile,Vagrantfile,Procfile,Guardfile,config.ru,*.rake,.autotest,.irbrc,*.treetop,*.tt set ft=ruby syntax=ruby

" Python
au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4

" Make
au FileType make setlocal noexpandtab

" Airline.vim
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" List open buffers
noremap <leader>b :CtrlPBuffer<CR>

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" You Complete Me
let g:ycm_autoclose_preview_window_after_completion = 1

" Delete trailing whitespace
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'

" Easy-align
vmap <Enter> <Plug>(EasyAlign)

" Find/Replace in whole buffer
function! VisualFindAndReplace()
  :OverCommandLine%s/
  :w
endfunction

nnoremap <Leader>fr :call VisualFindAndReplace()<CR>

" Find/Replace within current visual selection
function! VisualFindAndReplaceWithSelection() range
  :'<,'>OverCommandLine s/
  :w
endfunction

xnoremap <Leader>fr :call VisualFindAndReplaceWithSelection()<CR>

" Delimitmate
let g:delimitMate_expand_cr = 1

" SilverSearcher
set grepprg=ag\ --nogroup\ --nocolor

" Commentry
map <leader>/ :Commentary<CR>

" NERDTree
let g:NERDTreeHijackNetrw = 0
map <leader>d :NERDTreeToggle<CR>
map <leader>n :NERDTreeFind<CR>

" Toggle background
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5

" JSON
let g:vim_json_syntax_conceal = 0

" OmniComplete
au Filetype * setlocal omnifunc=syntaxcomplete#Complete
au FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au FileType python setlocal omnifunc=pythoncomplete#Complete
au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
