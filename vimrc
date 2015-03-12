" Make Vim more useful
set nocompatible

" Setup Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

Plugin 'jwhitley/vim-colors-solarized'

Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'mxw/vim-jsx'

Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'majutsushi/tagbar'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'gorodinskiy/vim-coloresque'

Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'marijnh/tern_for_vim'
Plugin 'mattn/emmet-vim'
Plugin 'Raimondi/delimitMate'
Plugin 'ddollar/nerdcommenter'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-surround'
Plugin 'vim-scripts/DeleteTrailingWhitespace'

call vundle#end()
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

" 2-space soft tabs, round to the nearest multiple
set shiftwidth=2
set softtabstop=2
set shiftround
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

" Folding
set foldmethod=syntax
set foldnestmax=3
set nofoldenable

" Color scheme
set t_Co=256
set background=dark
colorscheme desert


" Airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'


" Check syntax on open, not just save
let g:syntastic_check_on_open = 1


" NERDCommenter
map <leader>/ <plug>NERDCommenterToggle<CR>


" NERDTree
map <leader>n :NERDTreeToggle<CR>
let NERDTreeHijackNetrw = 0

" If the parameter is a directory, cd into it
" https://github.com/carlhuda/janus/blob/master/janus/vim/tools/janus/after/plugin/nerdtree.vim#L12
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
" https://github.com/carlhuda/janus/blob/master/janus/vim/tools/janus/after/plugin/nerdtree.vim#L38
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif
endfunction

if has("autocmd")
  autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
  autocmd FocusGained * call s:UpdateNERDTree()
endif


" Tagbar
map <leader>t :TagbarToggle<CR>


" Enable newline support in Delimitmate
let delimitMate_expand_cr = 1


" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


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

  " Enable spellchecking for Markdown
  au FileType markdown setlocal spell

  " Syntax-based folding in JavaScript
  au FileType javascript call JavaScriptFold()

  " Don't hide quotes in JSON files
  let g:vim_json_syntax_conceal = 0

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
map j gj
map k gk

" Move lines up and down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Mappings
if has("gui_macvim") && has("gui_running")

  " Close the current HTML tag
  imap <D-≥> <C-X>/
  nmap <D-≥> i<C-X>/<Esc>
else

  " Close the current HTML tag
  imap <leader>. <C-X>/
  nmap <leader>. i<C-X>/<Esc>
endif

" Find all 'TODO' comments using The Silver Searcher
command Todo Ag TODO\|FIXME\|BUG
