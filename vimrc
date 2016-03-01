" Make Vim more useful
set nocompatible

" Setup Vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'mxw/vim-jsx'
Plugin 'marijnh/tern_for_vim'
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'osyo-manga/vim-over'
Plugin 'airblade/vim-gitgutter'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'Shougo/neocomplete.vim'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'Raimondi/delimitMate'
Plugin 'junegunn/vim-easy-align'
Plugin 'vim-scripts/DeleteTrailingWhitespace'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jwhitley/vim-colors-solarized'

call vundle#end()

filetype plugin on
filetype indent on

silent !mkdir ~/.vim/backups > /dev/null 2>&1

set ttyfast                                            " optimize for fast terminal connections
set noerrorbells                                       " disable error bells
set visualbell                                         " display a visual bell
set encoding=utf-8 nobomb                              " utf-8 without bom
set clipboard=unnamed                                  " use the OS clipboard
set hidden                                             " buffers can exist in the background
set autoread                                           " reload files changed outside vim
set history=500                                        " store lots of command line history
set undofile                                           " save undo tree to file
set undolevels=1000                                    " maximum number of changes that can be undone
set undodir=~/.vim/backups                             " save undo files here
set nobackup                                           " do not keep backups after close
set nowritebackup                                      " do not keep a backup while working
set noswapfile                                         " do not keep swp files
set modeline                                           " respect modeline in files
set backspace=indent,eol,start                         " allow backspace in insert mode
set esckeys                                            " allow cursor keys in insert mode
set mouse=a                                            " enable mouse in all modes
set cursorline                                         " highlight current line
set number                                             " enable line numbers
set numberwidth=5                                      " set a wider number gutter
set ruler                                              " show the cursor position
set showmode                                           " show the current mode
set title                                              " show the filename in the window titlebar
set showcmd                                            " show the (partial) command as it's being typed
set laststatus=2                                       " always show status line
set autoindent                                         " copy indent from current line when starting a new line
set smartindent                                        " do smart autoindenting when starting a new line
set expandtab                                          " soft tabs
set softtabstop=2                                      " tabs are 2 spaces wide
set shiftwidth=2                                       " shift lines by 2 spaces
set list listchars=tab:»·,trail:·,extends:>,precedes:< " set list mode characters
set hlsearch                                           " highlight search matches
set incsearch                                          " highlight dynamically as pattern is typed
set showmatch                                          " highlight matching brackets
set ignorecase                                         " ignore case of search patterns
set smartcase                                          " respect case of search parrern when it has an uppercase letter
set nostartofline                                      " don't reset cursor to start of line when moving around.
set scrolloff=3                                        " start scrolling before the horizontal window border
set nowrap                                             " don't wrap lines
set linebreak                                          " wrap lines at convenient points
set showbreak=↪\                                       " display marker for wrapped lines
set spelllang=en_gb                                    " spelling language
set pastetoggle=<F5>                                   " toggle paste mode
set ttimeoutlen=50                                     " fix delay when escaping from insert with esc

" Completion
set completeopt=longest,menu
set wildmode=list:longest,list:full
set wildignore=*.swp,*.bak,*.pyc,*.class,tmp/**,dist/**,node_modules/**,bower_components/**
set wildmenu

" Folding
set foldmethod=syntax
set foldnestmax=3
set nofoldenable

" Enable syntax highlighting
syntax on
set t_Co=256
set background=dark
colorscheme solarized

" Leader
let g:mapleader = " "

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Syntastic
let g:syntastic_check_on_open = 1

" Delimitmate
let g:delimitMate_expand_cr = 1

" Delete trailing whitespace
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'

" Code completion
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 0

" JSON
let g:vim_json_syntax_conceal = 0

" Emmet
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key = ','

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Set filetype for unknown extensions
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} setf ruby
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown

" In Makefiles, use real tabs, not tabs expanded to spaces
au FileType make setlocal noexpandtab

" Markdown files
au FileType markdown let g:DeleteTrailingWhitespace = 0
au FileType markdown setlocal spell

" Make Python follow PEP8 for whitespace ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4

" OmniComplete
au Filetype * setlocal omnifunc=syntaxcomplete#Complete
au FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
au FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
au FileType python setlocal omnifunc=pythoncomplete#Complete
au FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Run Emmet for HTML, XML, XSLT, Handlebars, and Markdown
au FileType html,xml,xslt,css,html.handlebars,markdown EmmetInstall

" Open NERDTree at startup if no file specified
au FocusGained * call s:UpdateNERDTree()

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

" Zoom / Restore window.
" https://coderwall.com/p/qqz1lq/vim-zoom-restore-window
function! s:ZoomToggle() abort
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
command! ZoomToggle call s:ZoomToggle()

" Move based on display lines, not physical lines
map j gj
map k gk

" Move between splits
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Move selected lines up and down
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Use <TAB> for completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Resize splits
nnoremap <Left> :vertical resize +1<CR>
nnoremap <Right> :vertical resize -1<CR>
nnoremap <Up> :resize +1<CR>
nnoremap <Down> :resize -1<CR>

" Zoom window
nnoremap <leader>z :ZoomToggle<CR>

" Align
vmap <Enter> <Plug>(EasyAlign)

" Toggle Comment
map <leader>/ :Commentary<CR>

" Toggle NERDTree
map <leader>d :NERDTreeToggle<CR>
map <leader>n :NERDTreeFind<CR>

" Toggle Tagbar
map <leader>t :TagbarToggle<CR>

" Find/Replace
nnoremap <Leader>fr :call VisualFindAndReplace()<CR>
xnoremap <Leader>fr :call VisualFindAndReplaceWithSelection()<CR>

" List open buffers
noremap <leader>b :CtrlPBuffer<CR>

" Clear Highlight
nnoremap <Esc><Esc> :nohlsearch<CR>
