" Make vim more useful
set nocompatible

filetype plugin indent on

" Syntax highlighting
syntax on
set t_Co=256
set background=dark
colorscheme solarized

" Mapleader
let mapleader=" "

" Centralize backups, swapfiles and undo history
silent !mkdir -p $HOME/.vim/backups
silent !mkdir -p $HOME/.vim/swaps
silent !mkdir -p $HOME/.vim/undo

set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo
set history=200 " Keep 200 lines of command line history
set undofile " Persistent Undo
set undolevels=1000 " Keep 1000 levels of undo history
set viminfo=%,'9999,s512,n~/.vim/viminfo " Restore buffer list, marks are remembered for 9999 files, registers up to 512Kb are remembered

" Config
set hidden " When a buffer is brought to foreground, remember undo history and marks
set visualbell " Use visual bell instead of audible bell (annnnnoying)
set noerrorbells " Disable error bells - don't beep
set ttyfast " Send more characters at a given time
set encoding=utf-8 nobomb " BOM often causes trouble
set modeline " respect modeline in files
set clipboard=unnamed " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set mouse=a " Enable mouse in all in all modes
set backspace=indent,eol,start " Backspacing over everything in insert mode
set esckeys " Allow cursor keys in insert mode
set autoread " Read open files again when changed outside Vim
set lazyredraw " Don't redraw when we don't have to
set title " Show the filename in the window titlebar
set shortmess=atI " Don't show the intro message when starting vim
set number " Enable line numbers
set numberwidth=5 " set a wider number gutter
set cursorline " Highlight current line
set showtabline=2 " Always show tab bar
set laststatus=2 " Always show status line
set ruler " Show the cursor position
"set noshowmode " Don't show the current mode (airline.vim takes care of us)
set showcmd " Show the (partial) command as it’s being typed
set report=0 " Show all changes
set list listchars=tab:»·,trail:·,extends:>,precedes:< " set list mode characters
set autoindent " Copy indent from last line when starting new line
set smarttab " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces
set shiftwidth=2 " The # of spaces for indenting
set softtabstop=2 " Tab key results in # spaces
set expandtab " Expand tabs to spaces
set magic " Enable extended regexes
set hlsearch " Highlight searches
set incsearch " Highlight dynamically as pattern is typed
set ignorecase " Ignore case of searches
set smartcase " Ignore 'ignorecase' if search patter contains uppercase characters
set gdefault " By default add g flag to search/replace. Add g to toggle
set wrapscan " Searches wrap around end of file
set ofu=syntaxcomplete#Complete " Set omni-completion method
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set wildmenu " Hitting TAB in command mode will show possible completions above command line
set wildchar=<TAB> " Character for CLI expansion (TAB-completion)
set wildmode=list:longest,list:full " Complete only until point of ambiguity
set wildignore+=.DS_Store
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*
set winminheight=0 " Allow splits to be reduced to a single line
set splitbelow " New window goes below
set splitright " New windows goes right
set scrolloff=3 " Start scrolling three lines before horizontal border of window
set sidescrolloff=3 " Start scrolling three columns before vertical border of window
set nofoldenable " Open all folds by default
set foldmethod=syntax " Syntax are used to specify folds
set foldnestmax=5 " Set max fold nesting level
set foldminlines=0 " Allow folding single lines
set nostartofline " Don't reset cursor to start of line when moving around
set nowrap " Do not wrap lines
set linebreak " wrap lines at convenient points
set showbreak=↪\ " display marker for wrapped lines
set nojoinspaces " Only insert single space after a '.', '?' and '!' with a join command
set diffopt=filler " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite " Ignore whitespace changes (focus on code changes)
set spelllang=en_au,en_gb " spelling language

" General
augroup general_config
  autocmd!

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

  " Fixage up and down {{{
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

  " Use <TAB> for completion
  inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

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
augroup END

" Filetypes

" JavaScript
augroup filetype_javascript
  autocmd!
  let g:jsx_ext_required = 0
augroup END

" JSON
augroup filetype_json
  autocmd!
  au BufRead,BufNewFile *.json set ft=json syntax=javascript
  let g:vim_json_syntax_conceal = 0
augroup END

" Handlebars
augroup filetype_hbs
  autocmd!
  au BufRead,BufNewFile *.hbs,*.handlebars,*.hbs.erb,*.handlebars.erb setlocal ft=mustache syntax=mustache
augroup END

" Markdown {{{
augroup filetype_markdown
  autocmd!
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf ft=markdown syntax=markdown
  au FileType markdown let g:DeleteTrailingWhitespace = 0
  au FileType markdown setlocal spell
  let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']
augroup END

" Ruby
augroup filetype_ruby
  autocmd!
  au BufRead,BufNewFile Rakefile,Capfile,Gemfile,Vagrantfile,Procfile,Guardfile,config.ru,*.rake,.autotest,.irbrc,*.treetop,*.tt set ft=ruby syntax=ruby
augroup END

" Python
augroup filetype_python
  autocmd!
  au FileType python setlocal softtabstop=4 tabstop=4 shiftwidth=4
augroup END

" Make
augroup filetype_make
  autocmd!
  au FileType make setlocal noexpandtab
augroup END
