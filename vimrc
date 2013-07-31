" Use tpope/pathogen to manage plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

set nocompatible                                   " use Vim settings, not Vi

set noswapfile                                     " do not use a swapfile
set nobackup                                       " do not keep backup files
set nowritebackup                                  " do not make a backup before overwriting files

set modeline                                       " respect modelines in files
set modelines=4                                    " number of lines to look for modelines at the start of the file

set history=50                                     " number of commands to remember
set undolevels=1000                                " number of changes that can be undone

set laststatus=2                                   " always show the status line
set cmdheight=2                                    " number of lines for the command-line
set ruler                                          " show the cursor position
set showcmd                                        " show the current command
set showmode                                       " show the current mode
set title                                          " show the file name in the window title bar
set scrolloff=3                                    " start scrolling before the edges

set number                                         " show line numbers
set numberwidth=5                                  " minimum number of columns to use for the line number

set showmatch                                      " show matching brackets
set matchtime=5                                    " tenths of a second to show the matching brackets

set hlsearch                                       " highlight all search matches
set ignorecase                                     " ignore case in the search pattern
set incsearch                                      " match searches incrementally

filetype plugin indent on                          " enable filetype detection, plugins, indent

syntax on                                          " enable syntax highlighting
colorscheme desert                                 " set colour scheme
set background=dark                                " use a dark background colour
set cursorline                                     " highlight the current line

set ttyfast                                        " optimize for fast terminal connections
set nolazyredraw                                   " turn off lazy redraw
set clipboard=unnamed                              " use the OS clipboard
set mouse=a                                        " enable mouse in all modes

set noerrorbells                                   " no bell
set visualbell                                     " use visual bell, instead of beeping
set report=0                                       " notify about file changes

set hidden                                         " buffers can exist in the background
set encoding=utf-8 nobomb                          " use UTF-8 without BOM
set binary                                         " enable binary mode
set noeol                                          " don't add empty newline at the end of file

set esckeys                                        " allow cursor keys in insert mode
set backspace=indent,eol,start                     " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,]
set nostartofline                                  " don't reset cursor to start of line when moving around
set virtualedit=block                              " allow Virtual Edit in visual block mode

set wildmenu                                       " command-line completion enhanced mode
set wildmode=list:longest,full                     " completion mode
set complete=.,w,t                                 " set the matches for insert mode completion
" set omnifunc=syntaxcomplete#Complete

set nowrap                                         " do not wrap text
set linebreak                                      " if wrapping, only wrap at a character in the `breakat` option

set autoindent                                     " copy indenting from current line when starting a new line
set smartindent                                    " use smart autoindenting when starting a new line
set formatoptions+=n                               " support for numbered/bullet lists

set list                                           " display unprintable characters
set listchars=tab:»·,trail:·,extends:>,precedes:<  " display trailing whitespace; when text is off screen

set shiftwidth=2                                   " number of spaces used for each step of (auto)indent
set tabstop=2                                      " number of spaces a tab counts for
set softtabstop=2                                  " number of spaces a tab counts for during editing
set nosmarttab                                     " insert spaces at the start of a line
set expandtab                                      " use spaces, not tabs


"""
" Plugins
"""

" DeleteTrailingWhitespace (automatically on save)
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'


" Syntastic
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=0
let g:syntastic_auto_loc_list=2


" Tagbar
map <leader>tb :TagbarToggle<CR>


" CTRL-P
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$',
  \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
  \ }


" NERDCommenter
if has("gui_macvim") && has("gui_running")
  map <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i
else
  map <leader>/ <plug>NERDCommenterToggle<CR>
endif


" NERDTree
let NERDTreeHijackNetrw = 0
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.rbc$', '\.rbo$', '\.class$', '\.o$', '\~$']

" Default mapping, <leader>n
map <leader>n :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>

autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd FocusGained * call s:UpdateNERDTree()

" If the parameter is a directory, cd into it
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
    " NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
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


" Ack
if has("gui_macvim") && has("gui_running")
  " Command-Shift-F on OSX
  map <D-F> :Ack<space>
else
  " Define <C-F> to a dummy value to see if it would set <C-f> as well.
  map <C-F> :dummy

  if maparg("<C-f>") == ":dummy"
    " <leader>f on systems where <C-f> == <C-F>
    map <leader>f :Ack<space>
  else
    " <C-F> if we can still map <C-f> to <S-Down>
    map <C-F> :Ack<space>
  endif

  map <C-f> <S-Down>
endif


"""
" Custom mappings
"""

" Automatically resize splits when resizing MacVim window
if has("gui_running") && has("autocmd")
  autocmd VimResized * wincmd =
endif

" Map the arrow keys to be based on display lines, not physical lines
map <Down> gj
map <Up> gk

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


augroup vimrcEx
  autocmd!

  " in makefiles, use real tabs, not tabs expanded to spaces
  autocmd FileType make setlocal noexpandtab

  " set the Ruby filetype for a number of common Ruby files without .rb
  autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,config.ru,*.rake} set ft=ruby

  " make sure all markdown files have the correct filetype
  autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} set ft=markdown

  " enable soft-wrapping for text and markdown files
  autocmd filetype text,markdown setlocal wrap

  " treat JSON files like JavaScript
  autocmd BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
  autocmd FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4

  " preserve trailing whitespace for Markdown files
  autocmd BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} let g:DeleteTrailingWhitespace = 0

  " Quit if NERDTree is the last window
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

augroup END