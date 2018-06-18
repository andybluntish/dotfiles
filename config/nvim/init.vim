call plug#begin('~/.vim/bundle')

Plug 'rakr/vim-one'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'michaeljsmith/vim-indent-object'
Plug 'junegunn/vim-easy-align'
Plug 'osyo-manga/vim-over'
Plug 'Raimondi/delimitMate'
Plug 'tmhedberg/matchit'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-ragtag'
Plug 'PeterRincker/vim-argumentative'
Plug 'vim-scripts/SearchComplete'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'w0rp/ale'
Plug 'vim-scripts/fish.vim', { 'for': 'fish' }
Plug 'othree/html5.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'JulesWang/css.vim'
Plug 'ap/vim-css-color'
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf.vim'

call plug#end()

" Map leader
" <Space> is by far the easiest key to hit
let mapleader=" "

" Colours and syntax highlighting
syntax on
set t_Co=256
set termguicolors
set background=dark
colorscheme one

if (has("gui_running"))
  let g:one_allow_italics = 1
endif

" Local directories
silent !mkdir -p $HOME/.config/nvim/undo > /dev/null 2>&1

" Config
set undodir=~/.config/nvim/undo
set ttyfast                          " Send more characters at a given time
set lazyredraw                       " Don't redraw when we don't have to
set ttimeoutlen=0                    " Fix delay when escaping from insert with Esc
set mouse=a                          " Enable mouse in all in all modes
set clipboard=unnamedplus            " Use the OS clipboard by default (on versions compiled with `+clipboard`)
set history=10000                    " Number of :cmdline history items to store
set undolevels=1000                  " Maximum number of changes that can be undone
set undofile                         " Persist undo history to a file
set nobackup                         " Don't make a backup before overwriting a file
set nowritebackup                    " Don't make a backup before writing the file
set noswapfile                       " Don't create swap files
set hidden                           " Allow buffers to exist in the background
set autoread                         " Read open files again when changed outside Vim
set backspace=indent,eol,start       " Backspacing over everything in insert mode
set encoding=utf-8                   " Set the default character encoding
set nobomb                           " No BOMs
set spelllang=en_au,en_gb            " Spellchecking languages
set linebreak                        " Break on boundaries when wrapping
set nojoinspaces                     " Only one space when joining lines
set expandtab                        " Spaces, not tabs-obviously ;-)
set tabstop=2                        " Set the wisth of hard tabs
set softtabstop=2                    " Set the width of soft tabs
set shiftwidth=2                     " Set the width of indents
set shiftround                       " Round indents to multiples of 'shiftwidth'
set autoindent                       " Copy indent from current line when starting a new line
set smartindent                      " Be smart about auto indenting
set smartcase                        " Obey case if there's an upper case character in search patterns
set ignorecase                       " Ignore case in search patterns
set incsearch                        " Shows the search as you type!
set hlsearch                         " Highlight search matches
set gdefault                         " By default add g flag to search/replace. Add g to toggle
set title                            " Show the filename in the window titlebar
set number                           " Enable line numbers
set nowrap                           " Disable soft-wrap
set showbreak=↪\                     " Character to display at the start of soft-wrapped lines
set nostartofline                    " Don't reset cursor to start of line when moving around
set cursorline                       " Highlight the current line
set splitbelow                       " New window goes below
set splitright                       " New windows goes right
set ruler                            " Show the cursor position
set report=0                         " Show all changes
set showcmd                          " Show the (partial) command as it’s being typed
set noshowmode                       " Don't show the current mode (airline.vim takes care of us)
set laststatus=2                     " Always show status line
set visualbell                       " Use visual bell instead of audible bell (annnnnoying)
set nofoldenable                     " No folding
set list                             " Show hidden characters
set listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:+
set scrolloff=3                      " Minimal number of lines to keep above and below the cursor
set sidescrolloff=3                  " Minimal number of columns to keep to the left and right of the cursor
set winminheight=0                   " Allow splits to be reduced to a single line
set diffopt=filler                   " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite                  " Ignore whitespace changes (focus on code changes)
set formatoptions+=r                 " Continue comments by default
set formatoptions+=n                 " Recognize numbered lists
set formatoptions+=1                 " Break before 1-letter words
set wildmenu                         " Enhanced completion mode
set wildchar=<TAB>                   " Character for CLI expansion (TAB-completion)
set wildmode=list:longest,list:full
set wildignore+=.DS_Store            " File patterns to ignore when expanding wildcards
set wildignore+=*/nvim/backup*,*/nvim/swap*,*/nvim/undo*
set wildignore+=*/.git/*
set wildignore+=*/.sass-cache/*
set wildignore+=*/bower_components/*
set wildignore+=*/node_modules/*
set wildignore+=*/vendor/*
set wildignore+=*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd
set iskeyword+=-,_,$,@,%,#,?         " These are not word dividers
set omnifunc=syntaxcomplete#Complete " Set omni-completion method

filetype plugin indent on

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
  let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']
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
  map <PageUp> <C-U>
  map <PageDown> <C-D>
  imap <PageUp> <C-O><C-U>
  imap <PageDown> <C-O><C-D>

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
  map j gj
  map k gk

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
  map <F2> :set invpaste paste?<CR>

  " Removes doc lookup binding because it's easy to fat finger
  nmap K k
  vmap K k

  " save without reaching for :
  map <Leader>w :w<CR>

  " use ; instead of : because it is quicker
  nnoremap ; :

  " Use :w!! to sudo save a file
  cnoremap w!! w !sudo tee % >/dev/null

  " Toggle buffer diff
  nnoremap <Leader>don :diffthis<CR>
  nnoremap <Leader>dof :diffoff<CR>

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

  " Toggle background
  nnoremap <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
augroup END

" Airline.vim
augroup airline_config
  autocmd!

  let g:airline_powerline_fonts = 1
  let g:airline#extensions#ale#enabled = 1
augroup END

" Ale.vim
augroup ale_config
  autocmd!

  let g:ale_linters = {}
  let g:ale_linters['javascript'] = ['eslint']
  let g:ale_linters['typescript'] = ['tslint', 'tsserver', 'typecheck']

  let g:ale_fixers = {}
  let g:ale_fixers['javascript'] = ['eslint', 'prettier']

  let g:ale_fix_on_save = 1
  let g:ale_sign_column_always = 1
  let g:ale_completion_enabled = 1
  let g:ale_javascript_prettier_use_local_config = 1

  nmap <silent> <leader>E <Plug>(ale_previous_wrap)
  nmap <silent> <leader>e <Plug>(ale_next_wrap)
  nmap <silent> <leader>fx <Plug>(ale_fix)
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

" Deoplete.vim
augroup deoplete_config
  autocmd!

  let g:deoplete#enable_at_startup = 1
augroup END

" EasyAlign.vim
augroup easy_align_config
  autocmd!

  " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
  vmap <Enter> <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
  nmap <Leader>a <Plug>(EasyAlign)
augroup END

" fzf
augroup fzf_config
  autocmd!
  set rtp+=/usr/local/opt/fzf

  let g:fzf_layout = { 'up': '~40%' }
  let g:fzf_history_dir = '~/.config/nvim/fzf-history'
  let g:fzf_buffers_jump = 1 " Jump to existing buffer if available

  nnoremap <C-p> :Files<CR>
  nnoremap <C-g> :GFiles?<CR>
  nnoremap <C-b> :Buffers<CR>
  nnoremap <C-t> :Tags<CR>
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

  " Fuzzy file search with ripgrep
  command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
augroup END

" NERD Commenter
augroup nerd_commenter
  autocmd!

  let NERDSpaceDelims=1
  let NERDCompactSexyComs=1
  map <leader>/ <plug>NERDCommenterToggle
augroup END

" NERDTree
augroup nerd_tree
  autocmd!

  let g:NERDTreeHijackNetrw = 0
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

  nnoremap <Leader>fr :call VisualFindAndReplace()<CR>
  xnoremap <Leader>fr :call VisualFindAndReplaceWithSelection()<CR>
augroup END

" tern_for_vim
augroup tern_for_vim_config
  autocmd!

  " Use the same tern for tern_for_vim and deoplete-ternjs
  let g:tern#command = ["tern"]
  let g:tern#arguments = ["--persistent"]
augroup END
