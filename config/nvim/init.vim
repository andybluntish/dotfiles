if !has('nvim')
  set nocompatible
endif

call plug#begin('~/.vim/bundle')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'christoomey/vim-tmux-navigator'
Plug 'osyo-manga/vim-over'
Plug 'Raimondi/delimitMate'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-ragtag'
Plug 'michaeljsmith/vim-indent-object'
Plug 'PeterRincker/vim-argumentative'
Plug 'vim-scripts/SearchComplete'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'kshenoy/vim-signature'
Plug 'vim-scripts/fish.vim', { 'for': 'fish' }
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'plasticboy/vim-markdown'
Plug 'othree/html5.vim'
Plug 'JulesWang/css.vim'
Plug 'ap/vim-css-color'
Plug 'elzr/vim-json'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'mustache/vim-mustache-handlebars'
Plug 'posva/vim-vue'
Plug 'niftylettuce/vim-jinja'
Plug 'jparise/vim-graphql'
Plug 'ekalinin/dockerfile.vim'
Plug 'chr4/nginx.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'mhartington/oceanic-next'
Plug 'dracula/vim'

call plug#end()

" Colours and syntax highlighting
set t_Co=256
if (has('termguicolors'))
  set termguicolors
endif

syntax enable
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme dracula

" Map leader
" <Space> is by far the easiest key to hit
let mapleader=' '

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
if has ('unnamedplus')
  set clipboard=unnamedplus
endif

" VIM-only config (make it match Neovim defaults)
if !has('nvim')
  silent !mkdir -p ~/.local/share/nvim/undo > /dev/null 2>&1
  set undodir=~/.local/share/nvim/undo

  set ttyfast
  set autoindent
  set autoread
  set background=dark
  set backspace=indent,eol,start
  set encoding=utf-8
  set formatoptions=tcqj
  set history=10000
  set hlsearch
  set incsearch
  set langnoremap
  set laststatus=2
  set ruler
  set shortmess+=F
  set shortmess-=S
  set showcmd
  set smarttab
  set nostartofline
  set wildmenu
endif

" Neovim-only config
if has('nvim')
  "
endif

" Shared config
set lazyredraw
set ttimeoutlen=0
set updatetime=300
set mouse=a
set undolevels=1000
set undofile
set nobackup
set nowritebackup
set noswapfile
set hidden
set nobomb
set spelllang=en_au,en_gb
set linebreak
set nojoinspaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set smartindent
set smartcase
set ignorecase
set gdefault
set title
set number
set signcolumn=yes
set nowrap
set showbreak=↪\
set cursorline
set splitbelow
set splitright
set report=0
set noshowmode
set visualbell
set nofoldenable
set list
set listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:+
set scrolloff=3
set sidescrolloff=3
set winminheight=0
set diffopt=filler
set diffopt+=iwhite
set formatoptions+=r
set formatoptions+=n
set formatoptions+=1
set shortmess+=c
set wildchar=<TAB>
set wildmode=list:longest,list:full
set wildignore+=.DS_Store
set wildignore+=*/.git/*
set wildignore+=*/.sass-cache/*
set wildignore+=*/bower_components/*
set wildignore+=*/node_modules/*
set wildignore+=*/vendor/*
set wildignore+=*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd
set iskeyword+=-,_,$,@,%,#,?

filetype plugin indent on

let g:python_host_prog  = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/opt/python/libexec/bin/python'

" JSON
augroup filetype_json
  autocmd!

  let g:vim_json_syntax_conceal = 0
augroup END

" JavaScript
augroup filetype_js
  autocmd!

  au BufNewFile,BufRead *.ejs setlocal filetype=html
augroup END

" Markdown
augroup filetype_markdown
  autocmd!

  au FileType markdown setlocal iskeyword-=/ wrap linebreak nolist textwidth=0 wrapmargin=0 spell
  let g:vim_markdown_fenced_languages = ['bash=sh', 'ruby=rb', 'erb=eruby.html', 'javascript=js', 'typescript=ts']
augroup END

" Ruby
augroup filetype_ruby
  autocmd!

  au BufNewFile,BufRead *.{rjs,rbw,gem,gemspec,ru,rake} setlocal filetype=ruby
  au BufNewFile,BufRead {Gemfile,Guardfile,Rakefile,Capfile,Procfile} setlocal filetype=ruby
augroup END

" Txt
augroup filetype_txt
  autocmd!

  au FileType text setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 spell
  au FileType plaintex setlocal spell
augroup END

" Make
augroup filetype_make
  autocmd!

  au FileType make setlocal noexpandtab
augroup END

" Shell
augroup filetype_shell
  autocmd!

  au BufNewFile,BufRead *.fish set ft=fish
augroup END

" General config
augroup general_config
  autocmd!

  " Speed up viewport scrolling
  nnoremap <C-e> 3<C-e>
  nnoremap <C-y> 3<C-y>

  " Resize splits with arrow keys
  nnoremap <Left> :vertical resize +1<CR>
  nnoremap <Right> :vertical resize -1<CR>
  nnoremap <Up> :resize +1<CR>
  nnoremap <Down> :resize -1<CR>

  " Fix page up and down
  noremap <PageUp> <C-U>
  noremap <PageDown> <C-D>
  inoremap <PageUp> <C-O><C-U>
  inoremap <PageDown> <C-O><C-D>

  " Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
  nnoremap <C-j> <C-W>j
  nnoremap <C-k> <C-W>k
  nnoremap <C-h> <C-W>h
  nnoremap <C-l> <C-W>l

  " Move based on display lines, not physical lines
  noremap j gj
  noremap k gk

  " Move selected lines up and down
  vnoremap <C-j> :m '>+1<CR>gv=gv
  vnoremap <C-k> :m '<-2<CR>gv=gv

  " Remap keys for auto-completion menu
  inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<CR>"
  inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
  inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"


  " Clear Highlight
  nnoremap <Esc><Esc> :nohlsearch<CR>

  " Paste toggle
  set pastetoggle=<F2>
  noremap <F2> :set invpaste paste?<CR>

  " Removes doc lookup binding because it's easy to fat finger
  nmap K k
  vmap K k

  " save without reaching for :
  noremap <leader>w :w<CR>

  " use ; instead of : because it is quicker
  nnoremap ; :

  " Use :w!! to sudo save a file
  cnoremap w!! w !sudo tee % >/dev/null

  " Toggle buffer diff
  nnoremap <leader>don :diffthis<CR>
  nnoremap <leader>dof :diffoff<CR>

  " Zoom / Restore splits
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

" Terminal
augroup terminal
  if has('nvim')
    " go into normal mode in terminal with Esc
    tnoremap <Esc> <C-\><C-n>

    " start terminal in insert mode
    autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif

    " open terminal
    function! OpenTerminal()
      split term://fish
      resize 15
    endfunction

    nnoremap <leader>cm :call OpenTerminal()<CR>
  endif
augroup END

" CoC
augroup coc
  autocmd!

  let g:coc_global_extensions = [
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-tsserver',
  \ 'coc-solargraph',
  \ 'coc-svg',
  \ 'coc-vetur',
  \ 'coc-tailwindcss'
  \ ]

  nmap <silent> <leader>e <Plug>(coc-diagnostic-next-error)
  nmap <silent> <leader>E <Plug>(coc-diagnostic-prev-error)

  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gr <Plug>(coc-references)

  nmap <leader>do <Plug>(coc-codeaction)
  nmap <leader>rn <Plug>(coc-rename)
augroup END

" Airline.vim
augroup airline_config
  autocmd!

  let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  let g:airline_symbols.branch = ''
  let g:airline_symbols.linenr = ''
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.dirty='*'
augroup END

" Delete trailing whitespace
augroup delete_trailing_whitespace_config
  autocmd!

  au FileType markdown let g:DeleteTrailingWhitespace = 0
  let g:DeleteTrailingWhitespace = 1
  let g:DeleteTrailingWhitespace_Action = 'delete'
augroup END

" Delimitmate
augroup delimitmate_config
  autocmd!

  let g:delimitMate_expand_cr = 1
augroup END

" fzf
augroup fzf_config
  autocmd!
  set rtp+=/usr/local/opt/fzf

  let g:fzf_layout = { 'up': '~40%' }
  let g:fzf_history_dir = '~/.config/nvim/fzf-history'
  let g:fzf_buffers_jump = 1 " Jump to existing buffer if available

  nnoremap <leader>p :Files<CR>
  nnoremap <leader>g :GFiles?<CR>
  nnoremap <leader>b :Buffers<CR>
  nnoremap <leader>t :Tags<CR>
  " nnoremap <C-m> :Marks<CR>
  nnoremap <leader>l :Lines<CR>

  " Mapping selecting mappings
  nmap <leader><tab> <plug>(fzf-maps-n)
  xmap <leader><tab> <plug>(fzf-maps-x)
  omap <leader><tab> <plug>(fzf-maps-o)

  " Insert mode completion
  imap <c-x><c-k> <plug>(fzf-complete-word)
  imap <c-x><c-f> <plug>(fzf-complete-path)
  imap <c-x><c-j> <plug>(fzf-complete-file-ag)
  imap <c-x><c-l> <plug>(fzf-complete-line)
augroup END

" NERD Commenter
augroup nerd_commenter
  autocmd!

  let NERDSpaceDelims=1
  map <leader>/ <plug>NERDCommenterToggle
augroup END

" NERDTree
augroup nerd_tree
  autocmd!

  " Open NERDTree automatically when launching with a directory
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

  " Exit if the last window is NERDTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  let g:NERDTreeMinimalUI = 1

  noremap <leader>dn :NERDTreeToggle<CR>
  noremap <leader>nn :NERDTreeFind<CR>
  noremap <leader>fn :NERDTreeFocus<CR>
augroup END

" Vim Over
augroup over_config
  autocmd!

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

  nnoremap <leader>fr :call VisualFindAndReplace()<CR>
  xnoremap <leader>fr :call VisualFindAndReplaceWithSelection()<CR>
augroup END
