call plug#begin('~/.vim/bundle')

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'osyo-manga/vim-over'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'michaeljsmith/vim-indent-object'
Plug 'vim-scripts/SearchComplete'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'kshenoy/vim-signature'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'elixir-editors/vim-elixir'
Plug 'ap/vim-css-color'
Plug 'morhetz/gruvbox'

call plug#end()

" Colours and syntax highlighting
if (has('termguicolors'))
  set termguicolors
endif

let g:gruvbox_italic = 1

syntax enable
colorscheme gruvbox

" Map leader
" <Space> is by far the easiest key to hit
let mapleader=' '

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
if has ('unnamedplus')
  set clipboard=unnamedplus
endif

" Shared config
filetype plugin indent on
set mouse=a
set undofile
set noswapfile
set spelllang=en_au,en_gb
set tabstop=2 shiftwidth=2 softtabstop=-1 expandtab
set smartindent
set ignorecase smartcase
set gdefault
set cursorline
set number
set signcolumn=yes
set noshowmode
set nowrap
set linebreak
set showbreak=↪\
set splitbelow splitright
set list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:+
set formatoptions+=rn1
set shortmess+=c
set wildmode=list:longest,list:full
set wildignore+=.DS_Store,*/.git/*,*/.sass-cache/*,*/bower_components/*,*/node_modules/*
set wildignore+=*/vendor/*,*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd
set iskeyword+=-,_,$,@,%,#,?

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
  noremap <PageUp> <C-u>
  noremap <PageDown> <C-d>
  inoremap <PageUp> <C-o><C-U>
  inoremap <PageDown> <C-o><C-d>

  " Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
  nnoremap <C-j> <C-w>j
  nnoremap <C-k> <C-w>k
  nnoremap <C-h> <C-w>h
  nnoremap <C-l> <C-w>l

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

  " Removes doc lookup binding because it's easy to fat finger
  nmap K k
  vmap K k

  " save without reaching for :
  noremap <Leader>w :w<CR>

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
  nnoremap <Leader>z :call ToggleZoomWindow()<CR>
augroup END

" Txt
augroup filetype_txt
  autocmd!

  au FileType text setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 spell
  au FileType plaintex setlocal spell
augroup END

" Markdown
augroup filetype_markdown
  autocmd!

  au FileType markdown setlocal iskeyword-=/ wrap linebreak nolist textwidth=0 wrapmargin=0 spell
augroup END

" Make
augroup filetype_make
  autocmd!

  au FileType make setlocal noexpandtab
augroup END

" HTML
augroup filetype_html
  autocmd!

  au BufNewFile,BufRead *.{webc,ejs} setlocal filetype=html
augroup END

" Ruby
augroup filetype_ruby
  autocmd!

  au BufNewFile,BufRead *.{rjs,rbw,gem,gemspec,ru,rake} setlocal filetype=ruby
  au BufNewFile,BufRead {Gemfile,Guardfile,Rakefile,Capfile,Procfile} setlocal filetype=ruby
augroup END

" CoC
augroup coc
  autocmd!

  let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-ember',
  \ 'coc-eslint',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-markdownlint',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-sh',
  \ 'coc-solargraph',
  \ 'coc-svg',
  \ 'coc-tsserver',
  \ 'coc-yaml',
  \ 'coc-elixir',
  \ ]

  " Use <tab> and <S-tab> to navigate completion list: >
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  " Insert <tab> when previous text is space, refresh completion if not.
  inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1):
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Use <CR> to confirm completion, use: >
  inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

  " Make <CR> to confirm selection of selected complete item
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  nnoremap <silent> <Leader>c :<C-u>CocList commands<cr>
  nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
  nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

  nmap <silent> <Leader>E <Plug>(coc-diagnostic-prev-error)
  nmap <silent> <Leader>e <Plug>(coc-diagnostic-next-error)
  nmap <silent> <Leader>gd <Plug>(coc-definition)
  nmap <silent> <Leader>gy <Plug>(coc-type-definition)
  nmap <silent> <Leader>gi <Plug>(coc-implementation)
  nmap <silent> <Leader>gr <Plug>(coc-references)

  nmap <Leader>do <Plug>(coc-codeaction)
  nmap <Leader>rn <Plug>(coc-rename)
  nmap <leader>f <Plug>(coc-format-selected)
  vmap <leader>f <Plug>(coc-format-selected)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')
  nnoremap <Leader>fm :Format<CR>
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

  let g:airline#extensions#branch#format = 1
  let g:airline#extensions#branch#displayed_head_limit = 16
augroup END

" GitGutter
augroup gitgutter
  let g:gitgutter_override_sign_column_highlight = 1
  highlight SignColumn guibg=bg
  highlight SignColumn ctermbg=bg

  " Jump between hunks
  nmap <Leader>gn <Plug>(GitGutterNextHunk)
  nmap <Leader>gp <Plug>(GitGutterPrevHunk)

  " Load hunks into quickfix
  nmap <Leader>gh :GitGutterQuickFix <Bar> :copen<CR>
augroup END

" Fugitive
augroup fugitive
  nnoremap <Leader>gb :GBrowse<CR>
  vnoremap <Leader>gb :'<,'>:GBrowse<CR>
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

  let g:fzf_layout = { 'up': '~40%' }
  let g:fzf_history_dir = '~/.config/nvim/fzf-history'
  let g:fzf_buffers_jump = 1 " Jump to existing buffer if available

  nnoremap <C-p> :Files<CR>
  nnoremap <Leader>p :Files<CR>
  nnoremap <Leader>gf :GFiles?<CR>
  nnoremap <Leader>b :Buffers<CR>
  nnoremap <Leader>t :Tags<CR>
  nnoremap <Leader>m :Marks<CR>
  nnoremap <Leader>l :Lines<CR>

  " Mapping selecting mappings
  nmap <Leader><Tab> <Plug>(fzf-maps-n)
  xmap <Leader><Tab> <Plug>(fzf-maps-x)
  omap <Leader><Tab> <Plug>(fzf-maps-o)

  " Insert mode completion
  imap <C-x><C-k> <Plug>(fzf-complete-word)
  imap <C-x><C-f> <Plug>(fzf-complete-path)
  imap <C-x><C-j> <Plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <Plug>(fzf-complete-line)
augroup END

" NERD Commenter
augroup nerd_commenter
  autocmd!

  let NERDSpaceDelims=1
  map <Leader>/ <Plug>NERDCommenterToggle
augroup END

" NERDTree
augroup nerd_tree
  autocmd!

  " Exit if the last window is NERDTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

  let g:NERDTreeMinimalUI = 1

  noremap <Leader>dn :NERDTreeToggle<CR>
  noremap <Leader>nn :NERDTreeFind<CR>
  noremap <Leader>fn :NERDTreeFocus<CR>
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
