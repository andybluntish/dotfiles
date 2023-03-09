call plug#begin('~/.vim/bundle')
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'vim-scripts/SearchComplete'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'herringtondarkholme/yats.vim'
Plug 'joukevandermaas/vim-ember-hbs'
Plug 'elixir-editors/vim-elixir'
Plug 'morhetz/gruvbox'
call plug#end()

filetype plugin indent on

set undofile
set noswapfile
set mouse=a
set number
set cursorline
set signcolumn=auto
set splitbelow splitright
set nowrap
set linebreak
set showbreak=↪\
set breakindent
set list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:+
set tabstop=2 shiftwidth=0 softtabstop=-1 expandtab
set smartindent
set ignorecase smartcase
set formatoptions+=rn1
set completeopt=longest,menuone,preview
set wildmode=list:longest,list:full
set wildignore+=.DS_Store,*/.git/*,*/.sass-cache/*,*/bower_components/*,*/node_modules/*
set wildignore+=*/vendor/*,*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd
set shortmess+=c
set iskeyword+=-,_,$,@,%,#,?
set spelllang=en_au,en_gb
set clipboard+=unnamedplus
set omnifunc=syntaxcomplete#Complete
set termguicolors

let g:gruvbox_italic = 1
colorscheme gruvbox

let mapleader=' '

" Speed up viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Better split switching (Ctrl-j, Ctrl-k, Ctrl-h, Ctrl-l)
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Resize splits with arrow keys
noremap <Left> :vertical resize +1<CR>
noremap <Right> :vertical resize -1<CR>
noremap <Up> :resize +1<CR>
noremap <Down> :resize -1<CR>

" Move based on display lines, not physical lines
noremap j gj
noremap k gk

" Move selected lines up and down
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Clear Highlight
nnoremap <Esc><Esc> :nohlsearch<CR>

" save without reaching for :
noremap <Leader>w :w<CR>

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

" Set filetypes
au BufNewFile,BufRead *.{webc,njk,ejs} setlocal filetype=html
au BufNewFile,BufRead *.{rjs,rbw,gem,gemspec,ru,rake} setlocal filetype=ruby
au BufNewFile,BufRead {Gemfile,Guardfile,Rakefile,Capfile,Procfile} setlocal filetype=ruby

" Configure filetypes
au FileType text setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 spell
au FileType plaintex setlocal spell
au FileType markdown setlocal iskeyword-=/ wrap linebreak nolist textwidth=0 wrapmargin=0 spell
au FileType make setlocal noexpandtab

" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------
let g:NERDTreeMinimalUI=1

noremap <Leader>dn :NERDTreeToggle<CR>
noremap <Leader>nn :NERDTreeFind<CR>
noremap <Leader>fn :NERDTreeFocus<CR>

" Exit if the last window is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ------------------------------------------------------------------------------
" NERDCommenter
" ------------------------------------------------------------------------------
let g:NERDSpaceDelims=1

noremap <Leader>/ <Plug>NERDCommenterToggle

" ------------------------------------------------------------------------------
" Delimitmate
" ------------------------------------------------------------------------------
let g:delimitMate_expand_cr = 1

" ------------------------------------------------------------------------------
" Delete trailing whitespace
" ------------------------------------------------------------------------------
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'

au FileType markdown let g:DeleteTrailingWhitespace = 0

" ------------------------------------------------------------------------------
" Fugitive
" ------------------------------------------------------------------------------
nnoremap <Leader>gb :GBrowse<CR>
vnoremap <Leader>gb :'<,'>:GBrowse<CR>

" ------------------------------------------------------------------------------
" GitGutter
" ------------------------------------------------------------------------------
let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=bg
highlight SignColumn ctermbg=bg

" Jump between hunks
noremap <Leader>gn <Plug>(GitGutterNextHunk)
noremap <Leader>gp <Plug>(GitGutterPrevHunk)

" Load hunks into quickfix
noremap <Leader>gh :GitGutterQuickFix <Bar> :copen<CR>

" ------------------------------------------------------------------------------
" fzf
" ------------------------------------------------------------------------------
let g:fzf_layout = { 'up': '~40%' }
let g:fzf_history_dir = '~/.config/nvim/fzf-history'
let g:fzf_buffers_jump = 1 " Jump to existing buffer if available

nnoremap <C-p> :Files<CR>
nnoremap <Leader>p :Files<CR>
nnoremap <Leader>gf :GFiles?<CR>
nnoremap <Leader>b :Buffers<CR>
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

" " Remap keys for auto-completion menu
" inoremap <expr> <CR>   pumvisible() ? "\<C-y>" : "\<CR>"
" inoremap <expr> <Down> pumvisible() ? "\<C-n>" : "\<Down>"
" inoremap <expr> <Up> pumvisible() ? "\<C-p>" : "\<Up>"

" " CoC
" let g:coc_global_extensions = [
" \ 'coc-css',
" \ 'coc-ember',
" \ 'coc-eslint',
" \ 'coc-html',
" \ 'coc-json',
" \ 'coc-markdownlint',
" \ 'coc-prettier',
" \ 'coc-pyright',
" \ 'coc-sh',
" \ 'coc-solargraph',
" \ 'coc-svg',
" \ 'coc-tsserver',
" \ 'coc-yaml',
" \ 'coc-elixir',
" \ ]

" " Use <tab> and <S-tab> to navigate completion list: >
" function! s:check_back_space() abort
  " let col = col('.') - 1
  " return !col || getline('.')[col - 1]  =~ '\s'
" endfunction

" " Insert <tab> when previous text is space, refresh completion if not.
" inoremap <silent><expr> <TAB>
" \ coc#pum#visible() ? coc#pum#next(1):
" \ <SID>check_back_space() ? "\<Tab>" :
" \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" " Use <CR> to confirm completion, use: >
" inoremap <expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<CR>"

" " Make <CR> to confirm selection of selected complete item
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#_select_confirm()
" \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" nnoremap <silent> <Leader>c :<C-u>CocList commands<cr>
" nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
" nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>

" nmap <silent> <Leader>E <Plug>(coc-diagnostic-prev-error)
" nmap <silent> <Leader>e <Plug>(coc-diagnostic-next-error)
" nmap <silent> <Leader>gd <Plug>(coc-definition)
" nmap <silent> <Leader>gy <Plug>(coc-type-definition)
" nmap <silent> <Leader>gi <Plug>(coc-implementation)
" nmap <silent> <Leader>gr <Plug>(coc-references)

" nmap <Leader>do <Plug>(coc-codeaction)
" nmap <Leader>rn <Plug>(coc-rename)
" nmap <leader>f <Plug>(coc-format-selected)
" vmap <leader>f <Plug>(coc-format-selected)

" " Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
  " if (index(['vim','help'], &filetype) >= 0)
    " execute 'h '.expand('<cword>')
  " elseif (coc#rpc#ready())
    " call CocActionAsync('doHover')
  " else
    " execute '!' . &keywordprg . " " . expand('<cword>')
  " endif
" endfunction

" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')
" nnoremap <Leader>fm :Format<CR>
