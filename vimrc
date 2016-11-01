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

" Filetypes
filetype plugin on
filetype indent on

" General config
set history=1000               " Store lots of :cmdline history
set backspace=indent,eol,start " Backspacing over everything in insert mode
set mouse=a                    " Enable mouse in all in all modes
set clipboard=unnamed          " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set ruler                      " Show the cursor position
set laststatus=2               " Always show status line
set winminheight=0             " Allow splits to be reduced to a single line
set ttyfast                    " Send more characters at a given time
set ttimeoutlen=0              " Fix delay when escaping from insert with Esc
set lazyredraw                 " Don't redraw when we don't have to
set title                      " Show the filename in the window titlebar
set number                     " Enable line numbers
set numberwidth=5              " set a wider number gutter
set showcmd                    " Show the (partial) command as it’s being typed
set noshowmode                 " Don't show the current mode (airline.vim takes care of us)
set visualbell                 " Use visual bell instead of audible bell (annnnnoying)
set autoread                   " Read open files again when changed outside Vim
set hidden                     " Allow buffers to exist in the background
set nostartofline              " Don't reset cursor to start of line when moving around

" Syntax highlighting
syntax on
set t_Co=256
set synmaxcol=300
set background=dark
colorscheme hybrid

" Mapleader
let mapleader=" "

" Turn off swap files
set noswapfile
set nobackup
set nowritebackup

" Persistent undo
silent !mkdir -p $HOME/.vim/undo > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile
set undolevels=1000

" Indentation
set autoindent
set smartindent
set smarttab  
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Display tabs and trailing spaces visually
set list
set listchars=tab:»·,trail:·,extends:>,precedes:<

" Wrapping
set nowrap
set linebreak
set showbreak=↪\
set nojoinspaces

" Folds
set nofoldenable

" Completion
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=.DS_Store
set wildignore+=*/vim/undo*
set wildignore+=*/.git/*
set wildignore+=*/.sass-cache/*
set wildignore+=*/bower_components/*
set wildignore+=*/node_modules/*
set wildignore+=*/vendor/*
set wildignore+=*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd

" Scrolling
set scrolloff=3
set sidescrolloff=3

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Encoding
set encoding=utf-8
set nobomb

" Spelling
set spelllang=en_au,en_gb


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
au BufRead,BufNewFile *.json setlocal ft=json syntax=javascript

" Handlebars
au BufRead,BufNewFile *.hbs,*.handlebars,*.hbs.erb,*.handlebars.erb setlocal ft=mustache syntax=mustache

" Markdown
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setlocal ft=markdown syntax=markdown
au FileType markdown let g:DeleteTrailingWhitespace = 0
au FileType markdown setlocal spell wrap
let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']

" Ruby
au BufRead,BufNewFile Rakefile,Capfile,Gemfile,Vagrantfile,Procfile,Guardfile,config.ru,*.rake,.autotest,.irbrc,*.treetop,*.tt setlocal ft=ruby syntax=ruby

" Python
au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4

" Make
au FileType make setlocal noexpandtab

" Airline.vim
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1

" CtrlP searches in the current working directory by default
let g:ctrlp_cmd = 'CtrlP .'

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
