" Autocmd {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent exec '!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') | exe 'cd' argv()[0] | endif
autocmd CursorHold * lua vim.diagnostic.open_float(0, { scope = 'cursor', focus = false })
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankRegister "' | endif
autocmd FileType text,markdown,mail,gitcommit,cucumber setlocal spell spelllang=en_us
autocmd TermOpen * setlocal signcolumn=no
" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'neovim/nvim-lspconfig'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-haml'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'mhinz/vim-sayonara'
Plug '907th/vim-auto-save'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'gmake' }
Plug 'terrortylor/nvim-comment'
Plug 'ojroques/vim-oscyank'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/nvim-cmp'
Plug 'rust-lang/rust.vim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'pwntester/octo.nvim'
Plug 'akinsho/toggleterm.nvim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'github/copilot.vim'
Plug 'mrjones2014/dash.nvim', { 'do': 'make install' }
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
set formatoptions-=t " do not auto-wrap text
set hidden " hide files in the background instead of closing them
set ignorecase " case-insensitive search
set laststatus=3 " global status bar
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
set rtp+=/opt/homebrew/opt/fzf
set shiftwidth=2 " normal mode indentation commands use 2 spaces
set showmatch " highlight matching [{()}]
set showtabline=2 " always show tabline
set signcolumn=yes
set smartcase " switch search to case-sensitive when uppercase letter
set softtabstop=2
set switchbuf-=split
set tabstop=2
set termencoding=utf8
set termguicolors
set textwidth=120
set undodir=~/.config/nvim/undo
set undofile
set updatetime=1000

let mapleader=" "
" }}}

" nvim-tree.lua {{{
lua <<EOF
require'nvim-tree'.setup {
  open_on_tab = true,
  git = {
    enable = true
  },
  renderer = {
    special_files = { 'README.md', 'Gemfile' },
    icons = {
      git_placement = 'signcolumn',
      show = {
        file = false,
        folder = false,
        folder_arrow = false,
        git = false
      }
    }
  },
  filters = {
    custom = { '^.git$' }
  },
  actions = {
    change_dir = {
      enable = false
    },
  },
  view = {
    signcolumn = "no",
    width = 40,
    hide_root_folder = true
  }
}
EOF
" }}}

" Bufferline {{{
lua << EOF
require('bufferline').setup {
  options = {
    numbers = 'none',
    close_command = "bdelete! %d",
    indicator = {
      style = 'none'
    },
    max_name_length = 20,
    max_prefix_length = 15,
    tab_size = 20,
    diagnostics = false,
    offsets = {
      {
        filetype = 'NvimTree',
        text = function()
          return vim.fn.getcwd()
        end,
        text_align = 'left'
      }
    },
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = false,
    separator_style = { '', '' },
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    sort_by = 'id'
  },
  highlights = {
    fill = {
      bg = '#282828'
    },
    background = {
      bg = '#282828'
    },
    buffer_selected = {
      bg = '#3c3836'
    }
  }
}
EOF
" }}}

" Tree-sitter {{{
lua <<EOF
require('nvim-treesitter.configs').setup {
  highlight = { enable = true },
  ensure_installed = {
    'ruby',
    'dockerfile',
    'fish',
    'json',
    'yaml',
    'html',
    'javascript',
    'scss',
    'rust',
    'terraform',
    'toml'
  },
}
EOF
" }}}

" Telescope {{{
lua <<EOF
local telescope = require('telescope')
telescope.setup {
  defaults = {
    file_ignore_patterns = { '^.git/', '.lock', '.keep', '.enc', 'db/schema.rb' }
  },
  pickers = {
    find_files = {
      hidden = true
    }
  },
  extensions = {
    dash = {
      search_engine = 'google',
      debounce = 500,
      file_type_keywords = {
        dashboard = false,
        NvimTree = false,
        TelescopePrompt = false,
        terminal = false,
        fzf = false,
        ruby = { 'ruby', 'rails' },
        javascript = { 'javascript' }
      }
    }
  }
}
telescope.load_extension('fzf')
EOF
" }}}

" GitSigns {{{
lua <<EOF
local gitsigns = require('gitsigns')
gitsigns.setup()
EOF
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

" ToggleTerm {{{
lua <<EOF
local toggleterm = require('toggleterm')
toggleterm.setup{
  open_mapping = [[<C-q>]],
  direction = 'float',
  hide_numbers = true,
  start_in_insert = true,
  insert_mappings = true,
  terminal_mappings = true,
  persist_size = true,
  shade_terminals = false,
  border = 'single'
}
EOF
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
  completion = { autocomplete = false },
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
local servers = {'solargraph', 'rls'}
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    flags = { debounce_text_changes = 500 }
  }
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
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
let g:auto_save_events = ['InsertLeave', 'TextChanged']
" }}}

" LuaLine {{{
lua <<EOF
local custom_gruvbox = require'lualine.themes.gruvbox'

custom_gruvbox.normal.c.bg = '#3c3836'
custom_gruvbox.normal.c.fg = '#928374'
custom_gruvbox.insert.c.bg = '#3c3836'
custom_gruvbox.insert.c.fg = '#928374'
custom_gruvbox.visual.c.bg = '#3c3836'
custom_gruvbox.visual.c.fg = '#928374'
custom_gruvbox.replace.c.bg = '#3c3836'
custom_gruvbox.replace.c.fg = '#928374'
custom_gruvbox.command.c.bg = '#3c3836'
custom_gruvbox.command.c.fg = '#928374'

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = custom_gruvbox,
    component_separators = '',
    section_separators = '',
    always_divide_middle = true,
    globalstatus = true
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'filetype'},
    lualine_c = {
      {
        'filename',
        path = 1
      }
    },
    lualine_x = {'branch'},
    lualine_y = {'location'},
    lualine_z = {
      {
        'diagnostics',
        sections = {'error', 'warn', 'info'},
        colored = false,
        always_visible = true,
        symbols = { error = '', warn = '/', info = '/' },
        fmt = function(str)
          return str:gsub('%s+', '')
        end
      }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  --tabline = {
  --  lualine_a = {
  --    {
  --      'buffers',
  --      max_length = vim.o.columns - 4
  --    }
  --  }
  --},
  extensions = {'nvim-tree'}
}
EOF
" }}}

" Octo {{{
lua <<EOF
local octo = require('octo')
octo.setup()
EOF
" }}}

" Vim Table Mode {{{
 let g:table_mode_corner='|'
" }}}

" Copilot {{{
let g:copilot_no_maps = v:true
let g:copilot_filetypes = {
  \ '*': v:false,
  \ 'ruby': v:true,
  \ }
" }}}

" Keymaps {{{
nnoremap <Space> <Nop>
nnoremap <silent> <C-n> :NvimTreeToggle<CR>
nnoremap <silent>// :nohlsearch<CR>
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <C-j> copilot#Accept("\<CR>")
inoremap <silent><expr> <C-h> copilot#Next()
inoremap <silent><expr> <C-l> copilot#Next()
nnoremap <silent> <Tab> :BufferLineCycleNext<CR>
nnoremap <silent> <S-Tab> :BufferLineCyclePrev<CR>
nnoremap <silent> <C-w> :Sayonara!<CR>
nnoremap J <PageDown>
nnoremap K <PageUp>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nnoremap <silent> <C-o> :Telescope find_files<CR>
nnoremap <silent> <C-g> :Telescope live_grep<CR>
nnoremap <silent> <C-f> :Telescope lsp_document_symbols<CR>
nnoremap <silent> <C-t> :Telescope lsp_workspace_symbols<CR>
nnoremap <silent> <C-d> :Telescope dash search<CR>
nnoremap <silent> <C-_> :CommentToggle<CR>
vnoremap <silent> <C-_> :CommentToggle<CR>
nnoremap <silent> <C-s> <cmd>lua vim.lsp.buf.format { async = true }<CR>
nnoremap <silent> <C-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <C-Space> za
tnoremap <silent> <C-w> <C-\><C-n>
nnoremap <silent> <Leader>g :0G<CR>
" }}}

" vim:foldmethod=marker:foldlevel=0
