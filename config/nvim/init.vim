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
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'ray-x/lsp_signature.nvim'

" Completion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'github/copilot.vim'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'rebelot/kanagawa.nvim'

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
set list listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:+
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

" Colors
colorscheme kanagawa

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
imap <C-x><C-j> <Plug>(fzf-complete-file-ag)
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
      'svelte',
      'jsdoc',
      'html',
      'css',
      'scss',
      'ruby',
      'python',
      'elixir',
      'bash',
      'lua',
      'sql',
      'vim',
      'json',
      'xml',
      'yaml',
      'toml',
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
    }
  }
EOF

" ------------------------------------------------------------------------------
" Completion
" ------------------------------------------------------------------------------
lua << EOF
  local cmp = require('cmp')
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn['vsnip#anonymous'](args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-k>'] = cmp.mapping.scroll_docs(-4),
      ['<C-j>'] = cmp.mapping.scroll_docs(4),
      ['<C-e>'] = cmp.mapping.abort(),
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-n>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ['<C-p>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'path' },
    }, {
      { name = 'buffer' },
    }),
    experimental = {
      ghost_text = false -- this feature conflict with copilot.vim's preview.
    }
  })
EOF

" ------------------------------------------------------------------------------
" LSP
" ------------------------------------------------------------------------------
lua << EOF
  -- LSP servers
  local servers = {
    'html',
    'cssls',
    'ts_ls',
    'bashls',
    'ruby_lsp',
    'standardrb',
    'pylsp',
    'elixirls',
    'ember',
    'glint',
    'eslint',
  }

  -- Setup Mason and install LSPs
  local lsp = require('lspconfig')
  local mason = require('mason')
  local mason_lspconfig = require("mason-lspconfig")

  mason.setup {}
  mason_lspconfig.setup {
    ensure_installed = servers,
    automatic_installation = true
  }

  -- Setup LSP and detect capabilities
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- Configure LSP when attached to a buffer, mainly keybindings
  local on_attach = function(client, bufnr)
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
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
    vim.keymap.set('n', ']e', vim.diagnostic.goto_next, bufnopts)
    vim.keymap.set('n', '<Leader>fm', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
  end

  local handlers = {
    -- default handler
    function (server_name)
      require("lspconfig")[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
      }
    end,

    -- Ruby LSP
    ['ruby_lsp'] = function ()
      require("lspconfig").ruby_lsp.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        init_options = {
          formatter = 'standard',
          linters = { 'standard' }
        },
      }
    end,

    -- TypeScript
    ['ts_ls'] = function ()
      require("lspconfig").ts_ls.setup {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'EslintFixAll',
          })
          on_attach(client, bufnr)
        end,
        settings = {
          implicitProjectConfig = {
            experimentalDecorators = true
          }
        },
        filetypes = {
          'javascript',
          'typescript.glimmer',
          'typescript',
          'javascript.glimmer'
        }
      }
    end
  }

  mason_lspconfig.setup_handlers(handlers)

  -- Format on save, using the LSP
  vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
EOF
