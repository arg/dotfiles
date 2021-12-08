" Autocmd {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent exec "!\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'cd' argv()[0] | endif
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
autocmd User LspDiagnosticsChanged call lightline#update()
autocmd FileType text,markdown,mail,gitcommit setlocal spell spelllang=en_us
autocmd FileType ruby iabbrev <buffer> pry binding.pry
" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug '907th/vim-auto-save'
Plug 'nvim-telescope/telescope.nvim'
Plug 'terrortylor/nvim-comment'
Plug 'vim-test/vim-test'
Plug 'ojroques/vim-oscyank'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'rust-lang/rust.vim'
Plug 'preservim/nerdtree' " TODO: replace with https://github.com/kyazdani42/nvim-tree.lua
call plug#end()
" }}}

" Options {{{
" NeoVim defaults are not listed
" https://neovim.io/doc/user/vim_diff.html#vim-differences

set bufhidden=wipe " wipe empty buffer at start
set clipboard+=unnamedplus " use system clipboard
set cmdheight=1 " use a status bar that is 1 row high
set colorcolumn=+0 " show visual indicator
set completeopt=menu,menuone,preview,noselect,noinsert " completion options
set cursorline " highlight the line currently under cursor
set expandtab " use spaces, not tabs
set fcs=eob:\ " hide ~
set foldenable " enable folding
set hidden " hide files in the background instead of closing them
set ignorecase " case-insensitive search
set lazyredraw " don’t update screen during macro and script execution
set list " show hidden characters
set listchars=tab:\*\ ,trail:· " show · for trailing space, * for trailing tab
set modelines=1
set nobackup " prevent backups of files, since using vcs
set noeb vb t_vb= " disable audio and visual bells
set noshowmode " do not show current mode
set noswapfile " don't use swapfile
set nowrap " don't wrap lines
set nu rnu " show mixed line numbers
set number relativenumber " show mixed line numbers
set shiftwidth=2 " normal mode indentation commands use 2 spaces
set showmatch " highlight matching [{()}]
set showtabline=2 " always show tabline
set signcolumn=yes
set smartcase " switch search to case-sensitive when uppercase letter
set softtabstop=2
set switchbuf-=split
set tabstop=2
set termencoding=utf8
set textwidth=103
set undodir=~/.config/nvim/undo
set undofile
set updatetime=1000
" }}}

" NERDTree {{{
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeNaturalSort = 1
let NERDTreeWinSize = 50
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
" }}}

" Tree-sitter {{{
lua <<EOF
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true
  },
  ensure_installed = {
    "ruby",
    "dockerfile",
    "fish",
    "json",
    "yaml",
    "html",
    "javascript",
    "scss",
    "rust",
    "toml"
  },
}
EOF
" }}}

" Telescope {{{
lua <<EOF
local telescope = require('telescope')
telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case"
    }
  }
}
EOF
" }}}

" GitSigns {{{
lua require('gitsigns').setup()
" }}}

" Netrw {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
" }}}

" Color scheme {{{
try
  colorscheme gruvbox
catch
endtry
let g:gruvbox_bold = '0'
" }}}

" GitGutter {{{
let g:gitgutter_map_keys = 0
" }}}

" nvim-comment {{{
lua <<EOF
require('nvim_comment').setup {
  marker_padding = true,
  create_mappings = false
}
EOF
" }}}

" nvim-cmp {{{
lua <<EOF
local cmp = require('cmp')
cmp.setup {
  completion = {
    autocomplete = false
  },
  sources = {
    { name = 'nvim_lsp' }
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
  }
}
EOF
" }}}

" LSP {{{
lua <<EOF
local nvim_lsp = require('lspconfig')
local servers = { 'solargraph', 'rls' }
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 500
    }
  }
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false
  }
)
EOF
" }}}

" SplitJoin {{{
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
" }}}

" AutoSave {{{
let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]
" }}}

" VimTest {{{
let test#ruby#rspec#file_pattern = '_spec\.rb'
let test#ruby#rspec#options = {
  \ 'nearest': '--backtrace',
  \ 'file':    '--format documentation',
  \ 'suite':   '',
\}
" }}}

" Lightline {{{
function! LightlineLSPMajor() abort
  let l:errors = luaeval('vim.lsp.diagnostic.get_count(0, "Error")')
  return l:errors == 0 ? '' : printf('E:%d', l:errors)
endfunction

function! LightlineLSPMinor() abort
  let l:warnings = luaeval('vim.lsp.diagnostic.get_count(0, "Warning")')
  let l:info = luaeval('vim.lsp.diagnostic.get_count(0, "Information")')
  let l:total = l:warnings + l:info
  return l:total == 0 ? '' : printf('W:%d', l:total)
endfunction

function! LightlineLSPOK() abort
  let l:errors = luaeval('vim.lsp.diagnostic.get_count(0, "Error")')
  let l:warnings = luaeval('vim.lsp.diagnostic.get_count(0, "Warning")')
  let l:info = luaeval('vim.lsp.diagnostic.get_count(0, "Information")')
  let l:total = l:errors + l:warnings + l:info
  return l:total == 0 ? 'OK' : ''
endfunction

let g:lightline = {
\  'colorscheme': 'gruvbox',
\  'active': {
\    'left': [['mode'], ['filetype'], ['relativepath']],
\    'right': [
\      ['lsp_major', 'lsp_minor', 'lsp_ok'],
\      ['lineinfo'],
\      ['gitbranch']
\    ]
\  },
\  'tabline': {
\    'left': [['buffers']],
\    'right': [[]]
\  },
\  'component_expand': {
\    'buffers': 'lightline#bufferline#buffers',
\    'lsp_major': 'LightlineLSPMajor',
\    'lsp_minor': 'LightlineLSPMinor',
\    'lsp_ok': 'LightlineLSPOK',
\  },
\  'component_type': {
\    'buffers': 'tabsel',
\    'lsp_major': 'error',
\    'lsp_minor': 'warning',
\    'lsp_ok': 'right',
\  },
\  'component_function': {
\    'gitbranch': 'fugitive#head',
\  },
\}

let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#filename_modifier = ':t'
" }}}

" Keymaps {{{
let mapleader=","
nnoremap <silent> <C-n> :Explore<CR>
noremap  <silent>// :nohlsearch<CR>
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
nnoremap <silent> tn :TestNearest<CR>
nnoremap <silent> tf :TestFile<CR>
nnoremap <silent> ts :TestSuite<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>
nnoremap <silent> <Tab> :bnext<CR>
noremap <silent> <C-w> :bd<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-o> :Telescope find_files<CR>
nnoremap <silent> <C-g> :Telescope live_grep<CR>
nnoremap <silent> <C-t> :Telescope lsp_workspace_symbols<CR>
nmap <silent> <C-_> :CommentToggle<CR>
vmap <silent> <C-_> :CommentToggle<CR>
nnoremap <silent> <C-l> <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Space> za
nnoremap <silent> <C-q> :terminal<CR>
tnoremap <silent> <C-q> <C-\><C-n>
" }}}

" vim:foldmethod=marker:foldlevel=0
