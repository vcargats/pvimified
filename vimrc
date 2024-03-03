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

let g:vimified_packages = ['general', 'debug', 'fancy', 'coding', 'asm', 'cpp', 'java', 'python', 'ruby', 'html', 'css', 'js', 'svelte', 'python', 'color', 'go']

" _. General
if count(g:vimified_packages, 'general')

	Plug 'embear/vim-localvimrc'
	let g:localvimrc_reverse = 1 " From local to root
	let g:localvimrc_persistent = 1 " Remember the choice


	Plug 'sheerun/vim-polyglot'
	Plug 'towolf/vim-helm' " Not yet in poliglot ;)

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
	" How to remap, this is how:
	" https://vi.stackexchange.com/questions/16161/how-to-map-c-i-separate-from-tab
	" https://www.leonerd.org.uk/hacks/fixterms/
	" In other words new vim supports that out of the box provided term
	" enabled with CSI u options. it is possible to turn that mode on at
	" Settings -> Profiles -> keys
	" One can double check with the following command
	" (don't forget to remove " escape):
	" vim -Nu NONE + 'nno <C-i> :echom \"C-i was pressed\"<cr>' +'nno <tab> :echom \"Tab was pressed\"<cr>'
	" although:
	"  * still not comfortable as mapping tab here also redefines
	"    ctrl-i even if terminal can distinguish that.
        "  * Terminal does not send meta key (Alt) so it is not possible to
        "    delete words by alt-backspace :(
	"       ** Well, actually not really - that was becase I have also
	"       changed left option key from Esc+ to Normal... But I did so
	"       because it looked like with Esc+ somehow CSI u mode was not
	"       working... still need to investigate
	" Let's face it... I have neve been neither probably will use NERD...
	" Unix/shell rules.
	" nmap <Tab> :NERDTreeToggle<CR>
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

	" Usefull for coc, to allow enabling coc per project:
	" let g:coc_start_at_startup = v:false
	" The exrc setting adds searching of the current directory for the .vimrc
	" file and loads it
	" Enabling the secure setting ensures that shell, autocmd and write
	" commands are not allowed in the .vimrc file that was found in the
	" current directory as there’s no need to take risks
	set exrc
	set secure
endif
"
"
" _. Debug
if count(g:vimified_packages, 'debug')
	Plug 'puremourning/vimspector'

	nnoremap <Leader>dd :call vimspector#Launch()<CR>
	nnoremap <Leader>de :call vimspector#Reset()<CR>
	nnoremap <Leader>dc :call vimspector#Continue()<CR>

	nnoremap <Leader>dt :call vimspector#ToggleBreakpoint()<CR>
	nnoremap <Leader>dT :call vimspector#ClearBreakpoints()<CR>

	nmap <Leader>dk <Plug>VimspectorRestart
	nmap <Leader>dh <Plug>VimspectorStepOut
	nmap <Leader>dl <Plug>VimspectorStepInto
	nmap <Leader>dj <Plug>VimspectorStepOver

	"map <F4>  <Plug>VimspectorRestart
	"map <F5>  <Plug>VimspectorContinue
	"map <F10> <Plug>VimspectorStepOver
	"map <F11> <Plug>VimspectorStepInto

	let g:vimspector_enable_mappings = 'HUMAN'
endif

" _. Fancy
if count(g:vimified_packages, 'fancy')
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	" Looks like this embeds statusline into vim's airline
	" I'd like to have the other way around
	" Hope I will have a time some day for that
	"Plug 'vimpostor/vim-tpipeline'
	" tpipeline comes bundled with its own custom minimal statusline
	"let g:tpipeline_statusline = '%!tpipeline#stl#line()'
	" You can also use standard statusline syntax, see :help stl
	"let g:tpipeline_statusline = '%f'


	" Maybe cool, but I cannot just look at that
	"set termguicolors
	"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

	" These may help to disable showing the status line
	" With that it may be posisble to embded VIM info into tmux
	" statusline
	"set noshowmode
	"set noruler
	"set laststatus=0
	"set noshowcmd
	"set shortmess=F

endif
"

" _. Cancy
if count(g:vimified_packages, 'css')
	Plug 'cakebaker/scss-syntax.vim'
endif
"

" _. Coding

if count(g:vimified_packages, 'coding')
	Plug 'preservim/tagbar'
	nmap <leader>t :TagbarToggle<CR>

	Plug 'preservim/nerdcommenter'

	Plug 'ycm-core/YouCompleteMe'
	let g:ycm_always_populate_location_list = 1
	let g:ycm_confirm_extra_conf = 1
	let g:ycm_auto_hover=''
	nmap <C-y> <Plug>(YCMHover)

	nmap <leader>fw <Plug>(YCMFindSymbolInWorkspace)
	nmap <leader>fd <Plug>(YCMFindSymbolInDocument)
	nnoremap <C-g>  :YcmCompleter GoToDefinitionElseDeclaration<CR>
	nnoremap <silent> <leader>r <cmd>execute 'YcmCompleter RefactorRename' input( 'Rename to: ' )<CR>

	" Provides Location List and Quickfix lists shortcuts.
	" YCM does not seem to populate QuickFix list, just Location List
	Plug 'Valloric/ListToggle'

"	Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
"	" Use tab for trigger completion with characters ahead and navigate.
"	" NOTE: There's always complete item selected by default, you may want to enable
"	" no select by `"suggest.noselect": true` in your configuration file.
"	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"	" other plugin before putting this into your config.
"	inoremap <silent><expr> <TAB>
"				\ coc#pum#visible() ? coc#pum#next(1) :
"				\ CheckBackspace() ? "\<Tab>" :
"				\ coc#refresh()
"	inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"
"	" Make <CR> to accept selected completion item or notify coc.nvim to format
"	" <C-g>u breaks current undo, please make your own choice.
"	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"				\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
"	function! CheckBackspace() abort
"		let col = col('.') - 1
"		return !col || getline('.')[col - 1]  =~# '\s'
"	endfunction
"
"	" Use <c-space> to trigger completion.
"	if has('nvim')
"		inoremap <silent><expr> <c-space> coc#refresh()
"	else
"		inoremap <silent><expr> <c-n> coc#refresh()
"	endif
"
"	" Use K to show documentation in preview window.
"	nnoremap <silent> K :call ShowDocumentation()<CR>
"	nnoremap <silent> gh :call ShowDocumentation()<CR>
"
"	function! ShowDocumentation()
"		if &filetype == 'vim'
"			execute 'h '.expand('<cword>')
"		elseif CocAction('hasProvider', 'hover')
"			call CocActionAsync('doHover')
"		endif
"	endfunction
"
"	" Highlight the symbol and its references when holding the cursor.
"	autocmd CursorHold * silent call CocActionAsync('highlight')
"
"	" rename and inspect the current word in the cursor
"	nmap <leader>cr  <Plug>(coc-rename)
"
"	" that modifies default nerdcommenter's toggle comment state
"	autocmd VimEnter *  noremap <leader>ci  :CocCommand workspace.inspectEdit<CR>
"
"	" Use `[g` and `]g` to navigate diagnostics
"	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"	nmap <silent> [g <Plug>(coc-diagnostic-prev)
"	nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
	" GoTo code navigation.
	"nmap <silent> gd <Plug>(coc-definition)
	"nmap <silent> gy <Plug>(coc-type-definition)
	"nmap <silent> gi <Plug>(coc-implementation)
	"nmap <silent> gr <Plug>(coc-references)
"
"	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"	" delays and poor user experience.
"	set updatetime=300
"
"	" Always show the signcolumn, otherwise it would shift the text each time
"	" diagnostics appear/become resolved.
	set signcolumn=number
"
"	let g:coc_start_at_startup = v:false

	autocmd FileType gitcommit set tw=68 spell
	autocmd FileType gitcommit setlocal foldmethod=manual
endif
"
" _. asm
if count(g:vimified_packages, 'asm')
	Plug 'ARM9/arm-syntax-vim'
	au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7
endif


"let g:coc_global_extensions = []
" _. Cpp
if count(g:vimified_packages, 'cpp')
endif

" _. Java
"if count(g:vimified_packages, 'java')
"	let g:coc_global_extensions += ['coc-java']
"endif
"
"" _. Ruby
"if count(g:vimified_packages, 'ruby')
"	let g:coc_global_extensions += ['coc-solargraph']
"endif

" _. Js
if count(g:vimified_packages, 'js')
endif

" _. svelte
if count(g:vimified_packages, 'svelte')
	Plug 'leafOfTree/vim-svelte-plugin'
	let g:vim_svelte_plugin_load_full_syntax = 1

	" Set local options based on subtype
	function! OnChangeSvelteSubtype(subtype)
		echom 'Subtype is '.a:subtype
		if empty(a:subtype) || a:subtype == 'html'
			setlocal commentstring=<!--%s-->
			setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
		elseif a:subtype =~ 'css'
			setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
		else
			setlocal commentstring=//%s
			setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
		endif
	endfunction
endif

"" _. Python
"if count(g:vimified_packages, 'python')
"	let g:coc_global_extensions += ['coc-pyright']
"endif
"
"" _. Golang
"if count(g:vimified_packages, 'golang')
"	let g:coc_global_extensions += ['coc-go']
"endif

" _. Color
if count(g:vimified_packages, 'color')
	Plug 'tomasr/molokai'
	Plug 'altercation/vim-colors-solarized'
	Plug 'chriskempson/base16-vim'
	Plug 'jacoborus/tender.vim'
	Plug 'huyvohcmc/atlas.vim'
endif




" General

"

" Mappings
" stop using arrow keys.
noremap <left>  <nop>
noremap <up>    <nop>
noremap <down>  <nop>
noremap <right> <nop>

" better ESC
inoremap <C-k> <Esc>
" Emacs bindings in command line mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Splits ,v and ,h to open new splits (vertical and horizontal)
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j
" Easy splitted window navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
"

" _ Vim
augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
"
"
" . folding
set foldlevelstart=0
set foldmethod=syntax
" disable folding, but still behaves strange on buffer switch
set nofoldenable

" Space to toggle folds.
nnoremap <space> za
vnoremap <space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to "focus" the current fold.
nnoremap <leader>z zMzvzz

exec ':so '.s:dotvim.'/functions/my_fold_text.vim'
"

" _ backups
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
" _

" White characters
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
"

" Settings
set modelines=0
set noeol
if exists('+relativenumber')
  set relativenumber
endif
set numberwidth=3
set winwidth=83
set autoread
set backspace=indent,eol,start
set binary
set cinoptions=:0,(s,u0,U1,g0,t0
set encoding=utf-8
set hidden
set history=1000
set incsearch
set laststatus=2
set list
set showcmd
set wildmenu

" Don't redraw while executing macros
set nolazyredraw

" Disable the macvim toolbar
set guioptions-=T

set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:␣
set showbreak=↪

set notimeout
set ttimeout
set ttimeoutlen=10

" Do not make complete as preview. It is little bit annoying and not used
" by may extensively.
" The options I'd like to have is to open Doc bar (similar was as TagBar) by
" request
"set completeopt=longest,menuone,preview
set completeopt=longest,menuone

" Trailing whitespace
" Only shown when not in insert mode so I don't go insane.
augroup trailing
	au!
	au InsertEnter * :set listchars-=trail:␣
	au InsertLeave * :set listchars+=trail:␣
augroup END

" . searching

" sane regexes
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set showmatch
set gdefault
set hlsearch

" clear search matching
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

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

" _. Color - Once again to set colorscheme after plug#end
if count(g:vimified_packages, 'color')
	" During installation the molokai colorscheme might not be avalable
	if filereadable(globpath(&rtp, 'colors/molokai.vim'))
		colorscheme molokai
		" That is too much to see directories with bold
		hi Directory cterm=none
		" Better search foreground not to fade in coc-locations
		hi Search ctermfg=8
		highlight CocFloating ctermbg=236
	else
		colorscheme default
	endif
else
	colorscheme default
endif
"

