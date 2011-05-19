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
set viminfo='20,\"200 " keep a .viminfo file
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
set wildignore=*.pyc,*.class "ignore these file extensions
set wildmode=full
set completeopt=menu,longest "only show the omnicompletemenu, no docstring buffer
set nobackup
set mouse=a "enable mouse in terminal
set showcmd "show command in the last line of the screen

syntax on " syntax highlighting

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
			\ if ! exists("g:leave_my_cursor_position_alone") |
			\ if line("'\"") > 0 && line ("'\"") <= line("$") |
			\ exe "normal g'\"" |
			\ endif |
			\ endif

autocmd FileType python setlocal complete+=k~/.vim/syntax/python.vim isk+=.,(
autocmd FileType python setlocal autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4 smarttab
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete


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

"Key mpapping
let mapleader = ","
"\v in search makes vim use normal regexp
"nnoremap / /\v
"vnoremap / /\v
nnoremap ; :
",space to clear search
nnoremap <leader><space> :noh<cr>
"omnicomplete ctrl-space
inoremap <C-Space> <C-x><C-o>
"esc to close omnimenu
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
"jk movmenet keys in omnibox, sort of conflicts with completeopt longest
"inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
"inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
",W to remove all trailing whitespace
nnoremap <leader>W :call <SID>StripTrailingWhitespaces()<CR>
",d to toggle NERDTree
nnoremap <leader>d :NERDTreeToggle<CR>
",i to toggle show invisibiles
nnoremap <leader>i :set list!<CR>
" Ctrl-movement to move between splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"unmap ⌘-t, then map it to command-t plugin
"this needs to be in .gvimrc, as the system macvim gvimrc is loaded after the
"~/.vimrc
"if has('gui_macvim')
"	macmenu &File.New\ Tab key=<nop>
"	map <D-t> :CommandT<CR>
"endif


if has('gui_running')
	set background=dark
	colorscheme ir_black
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
	set background=light
	colorscheme ir_black
endif

