call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

let s:dotvim = fnamemodify(globpath(&rtp, 'pvimified.dir'), ':p:h')
let mapleader = ","

let g:vimified_packages = ['general', 'fancy', 'coding', 'python', 'ruby', 'html', 'css', 'js', 'color', 'go']

" _. General {{{
if count(g:vimified_packages, 'general')

	Plug 'sheerun/vim-polyglot'
	Plug 'junegunn/vim-emoji'
	Plug 'junegunn/vim-easy-align' " TODO: Check the documentation -> looks very interesting at the first sight
	" Start interactive EasyAlign in visual mode (e.g. vipya)
	xmap ya <Plug>(EasyAlign)
	" Start interactive EasyAlign for a motion/text object (e.g. yaip)
	nmap ya <Plug>(EasyAlign)

	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

	Plug 'tpope/vim-endwise'
	Plug 'tpope/vim-surround'

	Plug 'vim-scripts/YankRing.vim'
	let g:yankring_history_dir = s:dotvim.'/tmp/'
	nmap <leader>y :YRShow<cr>

	Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }
	" [vcargats] Tab is the <c-i> but c-i is also a jump forward!
	" How to remap
	nmap <Tab> :NERDTreeToggle<CR>
	" Disable the scrollbars (NERDTree)
	set guioptions-=r
	set guioptions-=L
	" Keep NERDTree window fixed between multiple toggles
	set winfixwidth
	" TODO: combine NERD with fzf

	" Plugin outside ~/.vim/plugged with post-update hook
	Plug 'junegunn/fzf'

	Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
	Plug 'ryanoasis/vim-devicons'
	Plug 'dstein64/vim-startuptime'


endif
" }}}

" _. Fancy {{{
if count(g:vimified_packages, 'fancy')
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
endif
" }}}

" _. Coding {{{

if count(g:vimified_packages, 'coding')
	Plug 'preservim/tagbar'
	nmap <leader>t :TagbarToggle<CR>

	Plug 'preservim/nerdcommenter'

	autocmd FileType gitcommit set tw=68 spell
	autocmd FileType gitcommit setlocal foldmethod=manual
endif
" }}}

" _. Color {{{
if count(g:vimified_packages, 'color')
	Plug 'tomasr/molokai'
	Plug 'chriskempson/base16-vim'
endif
" }}}

" General {{{

" }}}

" Mappings {{{
" stop using arrow keys.
noremap <left>  <nop>
noremap <up>    <nop>
noremap <down>  <nop>
noremap <right> <nop>

" clear highlight after search
noremap <silent><Leader>/ :nohls<CR>
" better ESC
inoremap <C-k> <Esc>
" }}}

" _ backups {{{
if has('persistent_undo')
	" undo files
	exec 'set undodir='.s:dotvim.'/tmp/undo//'
	set undofile
	set undolevels=3000
	set undoreload=10000
endif
" backups
exec 'set backupdir='.s:dotvim.'/tmp/backup//'
" swap files
exec 'set directory='.s:dotvim.'/tmp/swap//'
set backup
set noswapfile
" _ }}}

" White characters {{{
set autoindent
set tabstop=4
set softtabstop=4
set textwidth=80
set shiftwidth=4
set expandtab
set wrap
set formatoptions=qrn1
if exists('+colorcolumn')
	set colorcolumn=+1
endif
set cpo+=J
" }}}

" Settings {{{
set autoread
set backspace=indent,eol,start
set binary
set cinoptions=:0,(s,u0,U1,g0,t0
set completeopt=menuone,preview
set encoding=utf-8
set hidden
set history=1000
set incsearch
set laststatus=2
set list

" Don't redraw while executing macros
set nolazyredraw

" Disable the macvim toolbar
set guioptions-=T

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:␣
set showbreak=↪

set notimeout
set ttimeout
set ttimeoutlen=10

" Trailing whitespace {{{
" Only shown when not in insert mode so I don't go insane.
augroup trailing
	au!
	au InsertEnter * :set listchars-=trail:␣
	au InsertLeave * :set listchars+=trail:␣
augroup END

" . searching {{{

" sane regexes
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set showmatch
set gdefault
set hlsearch

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }


" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting

" _. Color - Once again to set colorscheme after plug#end {{{
if count(g:vimified_packages, 'color')
	" During installation the molokai colorscheme might not be avalable
	if filereadable(globpath(&rtp, 'colors/molokai.vim'))
		colorscheme molokai
	else
		colorscheme default
	endif
else
	colorscheme default
endif
" }}}
