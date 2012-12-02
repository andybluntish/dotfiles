" Use Vim, not VI
set nocompatible

" Use the OS clipboard (only if compiled with `+clipboard`)
set clipboard=unnamed

" Remember more commands and search patterns
set history=1000
set undolevels=1000

" Optimize for fast terminal connections
set ttyfast

" Shhhhh...
set noerrorbells
set visualbell

" Enable mouse in all modes
set mouse=a

" Buffers can exist in the background
set hidden

" Tell us about changes
set report=0

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Don’t add empty newlines at the end of files
set binary
set noeol

" Completion
set wildmenu
set wildmode=list:longest,full
set complete=.,w,t

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l,[,]

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Don't use swap files
set noswapfile
set nobackup
set nowritebackup

" Line Numbers
set number
set numberwidth=5

" Status Line
set laststatus=2
set cmdheight=2
set ruler
set showcmd
set showmode

" Show the filename in the window titlebar
set title

" Highlight the current line
set cursorline

" turn off lazy redraw
set nolazyredraw

" Indention
set autoindent
set smartindent

" Tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab

filetype plugin on
filetype indent on

" Show matching brackets/braces
set showmatch
set mat=5

" Allow Virtual Edit in visual block mode
set virtualedit=block

" Wrapping
set nowrap
set linebreak

" support for numbered/bullet lists
set formatoptions+=n

" Search
set hlsearch
set ignorecase
set incsearch

" Display extra whitespace
set list
set listchars=tab:»·,trail:·

" Enable syntax highlighting
syntax on
colorscheme desert

" Start scrolling before the edges
set scrolloff=3

" Trip trailing whitespace on save
function! s:StripWhiteSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

autocmd BufWritePre * StripWhiteSpace
command! -range=% StripWhiteSpaces :silent call <SID>StripWhiteSpaces()
