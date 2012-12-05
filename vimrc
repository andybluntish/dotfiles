"""
" Initial Setup
"""

" Use Vim, not VI
set nocompatible

" Use tpope/pathogen to manage plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" Optimize for fast terminal connections
set ttyfast

" turn off lazy redraw
set nolazyredraw

" Shhhhh...
set noerrorbells
set visualbell

" Use the OS clipboard (if compiled with `+clipboard`)
" set clipboard=unnamed

" Enable mouse in all modes
set mouse=a

" Buffers can exist in the background
set hidden

" Tell us about file changes
set report=0

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Don’t add empty newlines at the end of files
set binary
set noeol

filetype plugin on
filetype indent on



"""
" Backup Files
"""

" Don't use swap files
set noswapfile
set nobackup
set nowritebackup



"""
" History
"""

" Remember more commands and search patterns
set history=1000
set undolevels=1000



"""
" Movement
"""

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l,[,]

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Start scrolling before the edges
set scrolloff=3

" Allow Virtual Edit in visual block mode
set virtualedit=block

" support for numbered/bullet lists
set formatoptions+=n



"""
" Display and Formatting
"""

" Show the filename in the window titlebar
set title

" Line Numbers
set number
set numberwidth=5

" Highlight the current line
set cursorline

" Show matching brackets/braces
set showmatch
set mat=5

" Status Line
set laststatus=2
set cmdheight=2
set ruler
set showcmd
set showmode

" Wrapping
set nowrap
set linebreak

" Display extra whitespace
set list
set listchars=tab:»·,trail:·,extends:>,precedes:<

" Enable syntax highlighting
syntax on

" Set colorscheme
colorscheme desert



"""
" Tabs and Indents
"""

" Tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab

" Indention
set autoindent
set smartindent



"""
" Completion
"""

set wildmenu
set wildmode=list:longest,full
set complete=.,w,t

" Turn on omni-complete
set omnifunc=syntaxcomplete#Complete



"""
" Search and Highlighting
"""

set hlsearch
set ignorecase
set incsearch



"""
" File Types
"""

if has("autocmd")

  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make setlocal noexpandtab

  " Set the Ruby filetype for a number of common Ruby files without .rb
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,config.ru,*.rake} set ft=ruby

  " Make sure all mardown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set ft=markdown

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4

endif



"""
" Plugins
"""

" DeleteTrailingWhitespace (automatically on save)
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'


" SuperTab
let g:SuperTabDefaultCompletionType = "context"


" delimitMate

" This option turns on/off the expansion of <CR>.
let delimitMate_expand_cr = 1
au FileType * let b:delimitMate_expand_cr = 1

" This option turns on/off the expansion of <Space>.
let delimitMate_expand_space = 1
au FileType * let b:delimitMate_expand_space = 1

" This option turns on/off the balancing of matching pairs.
let delimitMate_balance_matchpairs = 1
au FileType * let b:delimitMate_balance_matchpairs = 1


" CTRL-P
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
  \ }


" Tagbar
map <leader>tb :TagbarToggle<CR>


" NERDCommenter
if has("gui_macvim") && has("gui_running")
  map <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i
else
  map <leader>/ <plug>NERDCommenterToggle<CR>
endif



"""
" Custom mappings
"""

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

" Automatically resize splits when resizing MacVim window
if has("gui_running") && has("autocmd")
  autocmd VimResized * wincmd =
endif

" MacVim shift-arrow-keys
if has("gui_macvim") && has("gui_running")
  let macvim_hig_shift_movement = 1
endif

" Map command-[ and command-] to indenting or outdenting
" while keeping the original selection in visual mode
" in both MacVim and Terminal Vim
if has("gui_macvim") && has("gui_running")

  vmap <D-]> >gv
  vmap <D-[> <gv

  nmap <D-]> >>
  nmap <D-[> <<

  omap <D-]> >>
  omap <D-[> <<

  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

  " Bubble single lines
  nmap <D-Up> [e
  nmap <D-Down> ]e
  nmap <D-k> [e
  nmap <D-j> ]e

  " Bubble multiple lines
  vmap <D-Up> [egv
  vmap <D-Down> ]egv
  vmap <D-k> [egv
  vmap <D-j> ]egv

else

  vmap <A-]> >gv
  vmap <A-[> <gv

  nmap <A-]> >>
  nmap <A-[> <<

  omap <A-]> >>
  omap <A-[> <<

  imap <A-]> <Esc>>>i
  imap <A-[> <Esc><<i

  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  nmap <C-k> [e
  nmap <C-j> ]e

  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
  vmap <C-k> [egv
  vmap <C-j> ]egv

endif
