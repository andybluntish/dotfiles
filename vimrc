" Make Vim more useful
set nocompatible

" Setup Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

Plugin 'chriskempson/base16-vim'

Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'helino/vim-json'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'mxw/vim-jsx'

Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'gorodinskiy/vim-coloresque'

Plugin 'mattn/emmet-vim'
Plugin 'Raimondi/delimitMate'
Plugin 'ddollar/nerdcommenter'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/DeleteTrailingWhitespace'

filetype plugin indent on


" Optimize for fast terminal connections
set ttyfast

" Disable error bells
set noerrorbells
set visualbell

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" buffers can exist in the background without being in a window
set hidden

" Use UTF-8 without BOM
scriptencoding utf-8
set encoding=utf-8 nobomb

" Don’t add empty newlines at the end of files
set binary
set noeol

" Reload files changed outside vim
set autoread

" Keep undo history across sessions, by storing in file.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
  set undolevels=1000
  set undoreload=10000
endif

" do not keep backups after close
set nobackup

" do not keep a backup while working
set nowritebackup

" don't keep swp files either
set noswapfile

" Respect modeline in files
set modeline
set modelines=4

" Allow backspace in insert mode
set backspace=indent,eol,start

" Allow cursor keys in insert mode
set esckeys

" Enable mouse in all modes
set mouse=a

" Change mapleader from \
let mapleader=","

" Enable syntax highlighting
syntax on
filetype on
filetype plugin on
filetype indent on

" Highlight current line
set cursorline

" Enable line numbers
set number
set numberwidth=5

" Show the cursor position
set ruler

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" Show the (partial) command as it’s being typed
set showcmd

" Store lots of :cmdline history
set history=1000

" Always show status line
set laststatus=2

" Indentation
set autoindent
set smartindent
set smarttab

" 2-space soft tabs
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·,extends:>,precedes:<

" Highlight searches
set hlsearch

" Ignore case of searches unless a capital letter is used
set ignorecase
set smartcase

" Highlight dynamically as pattern is typed
set incsearch

" Highlight matching brackets
set showmatch
set mat=5

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Don't wrap lines
set nowrap

" Wrap lines at convenient points
set linebreak

" Spelling language
set spelllang=en_gb

" Completion
set completeopt=longest,menu
set wildmode=list:longest,list:full
set wildmenu

" <Enter> selects highlighted item when menu is open
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Folding
set foldmethod=syntax
set foldnestmax=3
set nofoldenable

" Color scheme
set t_Co=256
set background=dark
colorscheme desert


" NERDCommenter
map <leader>/ <plug>NERDCommenterToggle<CR>

" Enable newline support in Delimitmate
let delimitMate_expand_cr = 1

" CTRL-P ignore
let g:ctrlp_custom_ignore = {
      \ 'dir': '\.git$\|node_modules\|bower_components',
      \ }

" Delete trailing whitespace automatically on save
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'



" Filetype mappings
if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make setlocal noexpandtab

  " Set the Ruby filetype for a number of common Ruby files without .rb
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby

  " Make sure all mardown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown

  " Disable 'delete trailing whitespace' for Markdown files
  au FileType markdown let g:DeleteTrailingWhitespace = 0

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4

  if exists("+omnifunc")
    au Filetype * setlocal omnifunc=syntaxcomplete#Complete
    au FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
    au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    au FileType python setlocal omnifunc=pythoncomplete#Complete
    au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  endif
endif

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Mappings
if has("gui_macvim") && has("gui_running")

  " Move lines up and down
  nnoremap <D-j> :m .+1<CR>==
  nnoremap <D-k> :m .-2<CR>==
  inoremap <D-j> <Esc>:m .+1<CR>==gi
  inoremap <D-k> <Esc>:m .-2<CR>==gi
  vnoremap <D-j> :m '>+1<CR>gv=gv
  vnoremap <D-k> :m '<-2<CR>gv=gv

  " Close the current HTML tag
  imap <D-≥> <C-X>/
  nmap <D-≥> i<C-X>/<Esc>
else

  " Move lines up and down
  nnoremap <C-j> :m .+1<CR>==
  nnoremap <C-k> :m .-2<CR>==
  inoremap <C-j> <Esc>:m .+1<CR>==gi
  inoremap <C-k> <Esc>:m .-2<CR>==gi
  vnoremap <C-j> :m '>+1<CR>gv=gv
  vnoremap <C-k> :m '<-2<CR>gv=gv

  " Close the current HTML tag
  imap <leader>. <C-X>/
  nmap <leader>. i<C-X>/<Esc>
endif