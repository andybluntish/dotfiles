" Use Vim settings, rather then Vi settings
set nocompatible

" Don't create backup or swap files
set nobackup
set nowritebackup
set noswapfile

" Remember more commands and search patterns
set history=1000
set undolevels=1000

" line numbers
set number
set numberwidth=5

" Show the line and column number of the cursor position
set ruler

" display incomplete commands
set showcmd

" command line height
set cmdheight=2

" Always display the status line
set laststatus=2

" Show the current mode
set showmode

" Show the filename in the window titlebar
set title

" turn off lazy redraw
set nolazyredraw

" Highlight searches
set hlsearch

" Ignore case of searches
set ignorecase

" Highlight dynamically as pattern is typed
set incsearch

" Display extra whitespace
set list
set listchars=tab:»·,trail:·

" Show matching brackets/braces
set showmatch

" duration to show matching brace (1/10 sec)
set mat=5

" tell us about changes
set report=0

" Enable mouse in all modes
set mouse=a

" Disable error bells
set noerrorbells
set visualbell

" Enhance command-line completion
set wildmenu
set wildmode=list:longest,full
set complete=.,w,t

" Don't wrap
set nowrap

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" backspace and cursor keys wrap to
set whichwrap+=<,>,h,l,[,]

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab
set nosmarttab

" Automatically indent new lines
set autoindent
set smartindent

" Turn on filetype plugins
filetype plugin indent on

" Set default encoding to UTF-8
set encoding=utf-8

" allow virtual edit in visual block ..
set virtualedit=block

" support for numbered/bullet lists
set formatoptions+=n


" Enable syntax highlighting
syntax on

" Color scheme
colorscheme desert

" Hide the toolbar in gvim
set guioptions-=T

" Set font in gvim
set guifont=Menlo:h14

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
