" Autocmd {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent exec "!\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'cd' argv()[0] | endif
" }}}

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug '907th/vim-auto-save'
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'janko/vim-test'
Plug 'tmsvg/pear-tree'
Plug 'dense-analysis/ale'
Plug 'ludovicchabant/vim-gutentags'
Plug 'maximbaz/lightline-ale'
call plug#end()
" }}}

" Options {{{
" NeoVim defaults are not listed
" https://neovim.io/doc/user/vim_diff.html#vim-differences

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
" set spell
set switchbuf-=split
set tabstop=2
set termencoding=utf8
set textwidth=103
set undodir=~/.config/nvim/undo
set undofile
set updatetime=1000
" set virtualedit=onemore " allow the cursor to go beyond last character in line
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

" NERDCommenter {{{
let NERDSpaceDelims = 1
let g:NERDCreateDefaultMappings = 0
" }}}

" SplitJoin {{{
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
" }}}

" GutenTags {{{
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['Gemfile']
let g:gutentags_cache_dir = "~/.cache/ctags"
let g:gutentags_file_list_command = 'find app/**/*.rb'
let g:gutentags_ctags_extra_args = ['--tag-relative=yes', '--fields=+ailmnS']
" }}}

" Ale {{{
let g:ale_linters = {
\  'ruby': ['rubocop']
\}
let g:ale_fixers = {
\  'ruby': ['rubocop']
\}
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_ruby_rubocop_options = "--config /app/.rubocop.yml"
" }}}

" AutoSave {{{
let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged"]
" }}}

" VimTest {{{
let test#ruby#rspec#executable = 'docker-compose exec app bundle exec rspec'
let test#ruby#rspec#options = {
  \ 'nearest': '--backtrace',
  \ 'file':    '--format documentation',
  \ 'suite':   '',
\}
" }}}

" Lightline {{{
let g:lightline = {
\  'colorscheme': 'gruvbox',
\  'active': {
\    'left': [['mode'], ['filetype'], ['relativepath']],
\    'right': [
\      [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ],
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
\    'linter_checking': 'lightline#ale#checking',
\    'linter_infos': 'lightline#ale#infos',
\    'linter_warnings': 'lightline#ale#warnings',
\    'linter_errors': 'lightline#ale#errors',
\    'linter_ok': 'lightline#ale#ok',
\  },
\  'component_type': {
\    'buffers': 'tabsel',
\    'linter_checking': 'right',
\    'linter_infos': 'right',
\    'linter_warnings': 'warning',
\    'linter_errors': 'error',
\    'linter_ok': 'right',
\  },
\  'component_function': {
\    'gitbranch': 'fugitive#head'
\  },
\}
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#ale#indicator_checking = '..'
let g:lightline#ale#indicator_infos = 'I: '
let g:lightline#ale#indicator_warnings = 'W: '
let g:lightline#ale#indicator_errors = 'E: '
let g:lightline#ale#indicator_ok = 'OK'
" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = {'left': '', 'right': '' }
" }}}

" Keymaps {{{
" leader key
let mapleader=","

" toggle Netrw
nnoremap <silent> <C-n> :Explore<CR>

" clean search highlight
noremap  <silent>// :nohlsearch<CR>

" complete by TAB key
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" run nearest test
nnoremap <silent> tn :TestNearest<CR>

" test file
nnoremap <silent> tf :TestFile<CR>

" test suite
nnoremap <silent> ts :TestSuite<CR>

" move to the previous buffer
nnoremap <silent> <S-Tab> :bprevious<CR>

" move to the next buffer
nnoremap <silent> <Tab> :bnext<CR>

" close the current buffer
noremap <silent> <C-w> :bd<CR>

" open files list
nnoremap <silent> <C-o> :GFiles<CR>

" search in current file
nnoremap <silent> <C-f> :BLines<CR>

" search in all files
nnoremap <silent> <C-g> :Rg<CR>

" search in tags
nnoremap <silent> <C-t> :Tags<CR>

" duplicate a line
nnoremap <silent> <C-d> yyp<CR>

" toggle line commenting
nmap <silent> <C-_> <Plug>NERDCommenterToggle
vmap <silent> <C-_> <Plug>NERDCommenterToggle

" fix code with Ale
nnoremap <silent> <C-l> :ALEFix<CR>

" toggle fold
nnoremap <silent> <Space> za
" }}}

" vim:foldmethod=marker:foldlevel=0
