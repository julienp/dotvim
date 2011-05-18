filetype on "http://tooky.github.com/2010/04/08/there-was-a-problem-with-the-editor-vi-git-on-mac-os-x.html#comment-87526162
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible " Use Vim defaults
set bs=2 " backspacing over everything in insert mode
set ai " Auto indenting
set history=100 " keep 100 lines of history
set ruler " show the cursor position
set hidden " dont require saving before switching buffera
set viminfo='20,\"200 " keep a .viminfo file
set hlsearch " highlight the last searched term
set tabstop=4

syntax on " syntax highlighting

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
			\ if ! exists("g:leave_my_cursor_position_alone") |
			\ if line("'\"") > 0 && line ("'\"") <= line("$") |
			\ exe "normal g'\"" |
			\ endif |
			\ endif

autocmd FileType python set complete+=k~/.vim/syntax/python.vim isk+=.,(
autocmd FileType python setl autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4
let python_highlight_all = 1
let python_highlight_indent_errors = 1

"unmap ⌘-t, then map it to command-t plugin
"this needs to be in .gvimrc, as the system macvim gvimrc is loaded after the
"~/.vimrc
"if has('gui_macvim')
"	macmenu &File.New\ Tab key=<nop>
"	map <D-t> :CommandT<CR>
"endif

let mapleader = ","

if has('gui_running')
	colorscheme ir_black
	set guifont=Menlo\ Regular:h12
	set guioptions-=T " hide toolbar
	set guioptions-=L "hide scrollbars
	set guioptions-=l "hide scrollbars
	set guioptions-=R "hide scrollbars
	set guioptions-=r "hide scrollbars
	set guioptions-=b "hide scrollbars
	set columns=110 "initial screensize
	set fuopt=maxvert,maxhorz "set max size for fullscreen
	highlig Visual guifg=NONE guibg=darkgray
	highlight NonText guifg=#4a4a59
	highlight SpecialKey guifg=#4a4a59
endif

"invisible chars
set listchars=tab:▸\ ,eol:¬

"highlight trailing whitespace in red
"http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set laststatus=2 "alwasy show status line
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

set nofoldenable "dont fold by default

