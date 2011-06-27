set nocompatible " Use Vim defaults

filetype on "http://tooky.github.com/2010/04/08/there-was-a-problem-with-the-editor-vi-git-on-mac-os-x.html#comment-87526162
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

filetype on
filetype plugin on
filetype indent on
syntax on

set encoding=utf-8
set ttyfast
set backspace=indent,eol,start
set hidden " dont require saving before switching buffera
set modeline
set nostartofline
set nobackup
set noswapfile
set undofile
set undodir=/tmp
set history=100 " keep 100 lines of history
set viminfo='10,:20,\"100,%,n~/.viminfo

"ui
set ruler " show the cursor position
set laststatus=2 "alwasy show status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set listchars=tab:▸\ ,eol:¬ "invisible chars
set nolist "dont show invisible chars by default
set noerrorbells "dont beep!
set novisualbell
set showcmd "show command in the last line of the screen
set wrap linebreak
set showbreak=↪ "show at the beginning of wrapped lines
set showmatch "show matching brackets
set viewoptions=folds,cursor
set mouse=a "enable mouse in terminal

"scrolling

"search
set hlsearch " highlight the last searched term
set incsearch "find as you type
set ignorecase "http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set smartcase
set gdefault "global search/replace

"indentation
set autoindent " Auto indenting
set nofoldenable "dont fold by default
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

"foldint
set foldmethod=indent
set foldlevel=99
"save and load folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview
autocmd	BufRead *.* silent loadview

"completion
set wildmenu "command line completion
set wildignore=*.o,.DS_STORE,*.obj,*.pyc,*.class,_build "ignore these file extensions
set wildmode=full
set completeopt=menu,longest "only show the omnicompletemenu, no docstring buffer
set pumheight=15 "limit completion menu height
set ofu=syntaxcomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabCrMapping = 1

autocmd FileType python setlocal autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4 smarttab
autocmd FileType python set omnifunc=pythoncomplete#Complete
let python_highlight_all = 1

autocmd FileType c setlocal autoindent tabstop=2 expandtab shiftwidth=2 softtabstop=2 smarttab
autocmd BufWritePost,FileWritePost *.c,*.h silent call g:ClangUpdateQuickFix()

let g:clang_complete_copen=1
"quickfix window minimum height 3, max 10, autoadjusts to number of errors
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

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

"delimitMate
let delimitMate_smart_quotes = 1

"Key mpapping
let mapleader = ","
"\v in search makes vim use normal regexp
"nnoremap / /\v
"vnoremap / /\v
nnoremap ; :
",space to clear search
nnoremap <leader><space> :noh<cr>
"omnicomplete ctrl-space, Nul works in Terminal.app, C-Space in MacVim
"inoremap <Nul> <C-x><C-o>
"inoremap <C-Space> <C-x><C-o>
"esc to close omnimenu
"inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
"enter to select an item from the menu
"inoremap <expr> <CR>	   pumvisible() ? "\<C-y>" : "\<CR>"
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
",n to toggle linenumbers
nnoremap <leader>n :set number! number?<cr>
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
" Indent using tabs (while in visual mode)
vnoremap <tab>       >gv
vnoremap <s-tab>     <gv
vnoremap <           <gv
vnoremap >           >gv
" cycle through buffers with C-j and C-k
nnoremap <C-j> :bp<cr>
nnoremap <C-k> :bn<cr>

"unmap ⌘-t, then map it to command-t plugin
"this needs to be in .gvimrc, as the system macvim gvimrc is loaded after the
"~/.vimrc
"if has('gui_macvim')
"	macmenu &File.New\ Tab key=<nop>
"	map <D-t> :CommandT<CR>
"endif

let NERDTreeWinSize=25

if has('gui_running')
	set background=light
	"let g:solarized_contrast="high"
	colorscheme solarized
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

