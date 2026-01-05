call plug#begin('~/.vim/bundle')
Plug 'Raimondi/delimitMate'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-ragtag'
Plug 'michaeljsmith/vim-indent-object'
Plug 'kshenoy/vim-signature'
Plug 'vim-scripts/SearchComplete'

" File navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'mason-org/mason.nvim'
Plug 'mason-org/mason-lspconfig.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'master', 'do': ':TSUpdate'}
Plug 'EdenEast/nightfox.nvim'

call plug#end()

filetype plugin indent on

" Basic settings
set undofile
set noswapfile
set number
set cursorline
set signcolumn=auto
set foldcolumn=auto
set splitbelow splitright
set nowrap
set linebreak
set showbreak=↪\
set breakindent
set list listchars=tab:\ \ ,trail:·,extends:>,precedes:<,nbsp:+
set tabstop=2 shiftwidth=0 softtabstop=-1 expandtab
set smartindent
set ignorecase smartcase
set formatoptions+=rn1
set completeopt=longest,menuone
set wildignore+=.DS_Store,*/.git/*,*/.sass-cache/*,*/node_modules/*
set wildignore+=*/vendor/*,*/log/*,*/tmp/*,*/build/*,*/dist/*,*/doc/*
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd
set spelllang=en_au,en_gb
set clipboard+=unnamedplus
set termguicolors

" Colors
colorscheme nightfox

" Big button is best
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

" Add Leader to prevent accidental invocation
nnoremap K k
vnoremap K k
nnoremap <Leader>K K
vnoremap <Leader>K K

" Move selected lines up and down
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Clear Highlight
nnoremap <Esc><Esc> :nohlsearch<CR>

" save without reaching for :
noremap <Leader>w :w<CR>

" Use :w!! to sudo save a file
cnoremap w!! w !sudo tee % >/dev/null

" Commenting
nmap <Leader>/ gcc
vmap <Leader>/ gc

" Toggle buffer diff
nnoremap <Leader>don :diffthis<CR>
nnoremap <Leader>dof :diffoff<CR>

" Copy current file path to clipboard
nnoremap <F10> :let @+ = expand("%")<CR>

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

" Filetype associations
autocmd BufNewFile,BufRead *.{webc,njk,ejs} setlocal filetype=html
autocmd BufNewFile,BufRead *.{rjs,rbw,gem,gemspec,ru,rake} setlocal filetype=ruby
autocmd BufNewFile,BufRead {Gemfile,Guardfile,Rakefile,Capfile,Procfile} setlocal filetype=ruby
autocmd BufNewFile,BufRead .{env,envrc} setlocal filetype=sh
autocmd BufNewFile,BufRead *.go.html setlocal filetype=gotmpl

" Filetype-specific settings
autocmd FileType text setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 spell
autocmd FileType plaintex setlocal spell
autocmd FileType markdown setlocal iskeyword-=/ wrap linebreak nolist textwidth=0 wrapmargin=0 spell
autocmd FileType make setlocal noexpandtab

" ------------------------------------------------------------------------------
" NERDTree
" ------------------------------------------------------------------------------
let g:NERDTreeMinimalUI=1

noremap <Leader>dn :NERDTreeToggle<CR>
noremap <Leader>nn :NERDTreeFind<CR>
noremap <Leader>fn :NERDTreeFocus<CR>

" Exit if the last window is NERDTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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
" Jump between hunks
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

" Load hunks into quickfix
noremap <Leader>h :GitGutterQuickFix <Bar> :copen<CR>

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
imap <C-x><C-j> <Plug>(fzf-complete-file)
imap <C-x><C-l> <Plug>(fzf-complete-line)

" ------------------------------------------------------------------------------
" Tree-sitter
" ------------------------------------------------------------------------------
lua << EOF
  -- Setup Treesitter and install parsers
  require'nvim-treesitter.configs'.setup {
    auto_install = true,
    highlight = {
      enable = true,
    },
    ensure_installed = {
      'javascript',
      'typescript',
      'glimmer',
      'html',
      'css',
      'scss',
      'ruby',
      'python',
      'elixir',
      'bash',
      'fish',
      'lua',
      'sql',
      'vim',
      'json',
      'xml',
      'yaml',
      'dockerfile',
      'make',
      'regex',
      'markdown',
      'markdown_inline',
      'diff',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'go',
      'gomod',
      'gosum',
      'gotmpl'
    }
  }
EOF

" ------------------------------------------------------------------------------
" LSP
" ------------------------------------------------------------------------------
lua << EOF
  -- Setup Mason and install LSPs
  require('mason').setup {}
  require('mason-lspconfig').setup {
    ensure_installed = {
      'html',
      'cssls',
      'ts_ls',
      'eslint',
      'ember',
      'glint',
      'ruby_lsp',
      'standardrb',
      'pylsp',
      'gopls',
    }
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      local bufopts = { noremap=true, silent=true, buffer=args.buf }

      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<Leader>u', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<Leader><Space>', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', '<Leader>a', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', '<Leader>e', vim.diagnostic.setloclist, bufopts)
      vim.keymap.set('n', '[e', vim.diagnostic.goto_prev, bufopts)
      vim.keymap.set('n', ']e', vim.diagnostic.goto_next, bufopts)
      vim.keymap.set('n', '<Leader>fm', vim.lsp.buf.format, bufopts)
      vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)

      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end

      -- format on save
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = args.buf,
        callback = function()
          if client.name == 'eslint' then
            vim.cmd('LspEslintFixAll')
          elseif client:supports_method('textDocument/formatting') then
            vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000, async = false })
          end
        end
      })
    end,
  })

  vim.lsp.config('ruby_lsp', {
    init_options = {
      formatter = 'standard',
      linters = { 'standard' },
      addonSettings = {
        ["Ruby LSP Rails"] = {
          enablePendingMigrationsPrompt = false,
        }
      }
    }
  })

  vim.lsp.config('ts_ls', {
    settings = {
      implicitProjectConfig = {
        experimentalDecorators = true
      }
    },
    filetypes = {
      'javascript',
      'javascript.glimmer',
      'typescript',
      'typescript.glimmer'
    }
  })

  -- Signature
  require('lsp_signature').setup({})

  -- Copilot
  require('copilot').setup({
    suggestion = {
      auto_trigger = true,
    },
    panel = { auto_refresh = true },
    filetypes = {
      sh = function ()
        if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), '^%.env.*') then
          -- disable for .env files
          return false
        end

        return true
      end,
    },
  })

  require("CopilotChat").setup({
    model = 'claude-opus-4.5'
  })
EOF
