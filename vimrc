set nocompatible " Use Vim defaults

filetype on "http://tooky.github.com/2010/04/08/there-was-a-problem-with-the-editor-vi-git-on-mac-os-x.html#comment-87526162
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set encoding=utf-8
set ttyfast
set backspace=indent,eol,start
set autoindent " Auto indenting
set history=100 " keep 100 lines of history
"set viminfo=h,'20,\"200 " keep a .viminfo file
set ruler " show the cursor position
set hidden " dont require saving before switching buffera
set hlsearch " highlight the last searched term
set incsearch "find as you type
set ignorecase "http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set smartcase
set gdefault "global search/replace
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab
set scrolloff=4 "keep 4 lines when scrolling
set nofoldenable "dont fold by default
set foldmethod=indent
set foldlevel=99
set laststatus=2 "alwasy show status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set listchars=tab:▸\ ,eol:¬ "invisible chars
set nolist "dont show invisible chars by default
set showmatch "show matching brackets
set noerrorbells "dont beep!
set novisualbell
set wildmenu "command line completion
set wildignore=*.pyc,*.class,_build "ignore these file extensions
set wildmode=full
set completeopt=menu,longest "only show the omnicompletemenu, no docstring buffer
set nobackup
set mouse=a "enable mouse in terminal
set showcmd "show command in the last line of the screen
set wrap linebreak
set showbreak=↪ "show at the beginning of wrapped lines
set viewoptions=folds,cursor "only store fold information in views

syntax on " syntax highlighting

" When editing a file, always jump to the last cursor position
"autocmd BufReadPost *
			"\ if ! exists("g:leave_my_cursor_position_alone") |
			"\ if line("'\"") > 0 && line ("'\"") <= line("$") |
			"\ exe "normal g'\"" |
			"\ endif |
			"\ endif

autocmd FileType python setlocal autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4 smarttab
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

"save and load folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

function! <SID>StripTrailingWhitespaces()
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business:
	%s/\s\+$//e
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction

"closetag, doesn't seem to play nicely with pathogen
let g:closetag_html_style=1
autocmd Filetype html source ~/.vim/bundle/closetag/scripts/closetag.vim

"Key mpapping
let mapleader = ","
"\v in search makes vim use normal regexp
"nnoremap / /\v
"vnoremap / /\v
nnoremap ; :
",space to clear search
nnoremap <leader><space> :noh<cr>
"omnicomplete ctrl-space, Nul works in Terminal.app, C-Space in MacVim
inoremap <Nul> <C-x><C-o>
inoremap <C-Space> <C-x><C-o>
"esc to close omnimenu
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
"enter to select an item from the menu
inoremap <expr> <CR>	   pumvisible() ? "\<C-y>" : "\<CR>"
"jk movmenet keys in omnibox, sort of conflicts with completeopt longest
"inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
"inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
",W to remove all trailing whitespace
nnoremap <leader>W :call <SID>StripTrailingWhitespaces()<CR>
",d to toggle NERDTree
nnoremap <leader>d :NERDTreeToggle<CR>
",D to open a new NERDTree, useful to change CWD
nnoremap <leader>D :NERDTree<CR>
",i to toggle show invisibiles
nnoremap <leader>i :set list!<CR>
" Ctrl-movement to move between splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
",e to edit file with path of currently open prefilled
map <leader>e :e <C-R>=expand('%:h').'/'<CR>
"make arrow keys work in Terminal.app in insertmode
imap [A <up>
imap [B <down>
imap [5C <right>
imap [5D <left>

"unmap ⌘-t, then map it to command-t plugin
"this needs to be in .gvimrc, as the system macvim gvimrc is loaded after the
"~/.vimrc
"if has('gui_macvim')
"	macmenu &File.New\ Tab key=<nop>
"	map <D-t> :CommandT<CR>
"endif

let NERDTreeWinSize=25

if has('gui_running')
	colorscheme ir_black
	set background=dark
	set guifont=Menlo\ Regular:h12
	set guioptions-=T " hide toolbar
	set guioptions-=L "hide scrollbars
	set guioptions-=l "hide scrollbars
	set guioptions-=R "hide scrollbars
	set guioptions-=r "hide scrollbars
	set guioptions-=b "hide scrollbars
	set columns=110 "initial screensize
	set cursorline "hightlight current line
	set fuopt=maxvert,maxhorz "set max size for fullscreen
else
	colorscheme koehler
	set background=light
	set nocursorline
endif

