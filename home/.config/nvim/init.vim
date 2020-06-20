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
Plug 'morhetz/gruvbox'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'mbbill/undotree'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug '907th/vim-auto-save'
Plug 'junegunn/fzf', { 'dir': '~/.config/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'rhysd/git-messenger.vim'
Plug 'janko/vim-test'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tmsvg/pear-tree'
Plug 'w0rp/ale'
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
set virtualedit=onemore " allow the cursor to go beyond last character in line
" }}}

" Netrw {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
" }}}

" Color scheme {{{
try
  colorscheme gruvbox
catch
endtry
let g:gruvbox_bold = '0'
" }}}

" NERDTree {{{
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"
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

" Ale {{{
let g:ale_completion_enabled = 1
let g:ale_linters = {
\  'ruby': ['rubocop', 'solargraph'],
\}
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'ruby': ['rubocop']
\}
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
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

" Airline {{{
let g:airline_theme='gruvbox'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tagbar#enabled = 0
let g:airline_section_y = ''
let g:airline_section_z = '%4l:%3c'
let g:airline_skip_empty_sections = 1
" }}}

" UndoTree {{{
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_HelpLine = 0
" }}}

" Keymaps {{{
" leader key
let mapleader=","

" in insert or command mode, move cursor by using Ctrl
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" open a new empty buffer
nnoremap <silent> <C-t> :enew<CR>

" toggle NERDTree
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" do split
nnoremap <silent> <Leader>s :SplitjoinSplit<cr>

" do join
nnoremap <silent> <Leader>j :SplitjoinJoin<cr>

" toggle GitMessenger
nmap <silent> <F8> <Plug>(git-messenger)

" complete by TAB key
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" run nearest test
nnoremap <silent> tn :TestNearest<CR>

" test file
nnoremap <silent> tf :TestFile<CR>

" test suite
nnoremap <silent> ts :TestSuite<CR>

" move to the previous buffer
nnoremap <silent> <C-h> :bprevious<CR>

" move to the next buffer
nnoremap <silent> <C-l> :bnext<CR>
nnoremap <silent> <Tab> :bnext<CR>

" close the current buffer and move to the previous one
noremap <silent> <C-w> :bp <BAR> bd #<CR>

" open files list
nnoremap <silent> <C-o> :Files<CR>

" search in current file
nnoremap <silent> <C-f> :BLines<CR>

" search in all files
nnoremap <silent> <C-g> :Rg<CR>

" duplicate a line
nnoremap <silent> <C-d> yyp<CR>

" toggle line commenting
nmap <silent> <C-_> <Plug>NERDCommenterToggle
vmap <silent> <C-_> <Plug>NERDCommenterToggle

" rename
" nnoremap <silent> <F2>

" go to definition
nnoremap <F3> <C-]>

" fix code with Ale
nnoremap <silent> <F5> :ALEFix<CR>

" open buffers list
"nnoremap <silent> <C-b> :Buffers<CR> " there is a bug - cant select the bottommost buffer

function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <C-b> :call fzf#run({
\ 'source': reverse(<sid>buflist()),
\ 'sink': function('<sid>bufopen'),
\ 'options': '+m',
\ 'down': len(<sid>buflist()) + 2
\ })<CR>

nnoremap <silent> <C-u> :UndotreeToggle<CR>

nnoremap <silent> <Space> za

" cut to clipboard
vnoremap <silent> <C-x> "+d

" copy to clipboard
vnoremap <silent> <C-c> "+y

" paste from clipboard
inoremap <silent> <C-v> <ESC>"+pa
" }}}

" vim:foldmethod=marker:foldlevel=0
