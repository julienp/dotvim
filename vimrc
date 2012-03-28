set nocompatible " Use Vim defaults

call pathogen#infect()
call pathogen#helptags()

filetype on
filetype plugin indent on
syntax on

set encoding=utf-8
set autoread
set ttyfast
set backspace=indent,eol,start
set hidden "dont require saving before switching buffers
set modeline
set nostartofline
set nobackup
set noswapfile
set undofile "persistent undo
set undodir=/tmp
set history=100 "keep 100 lines of history
set viminfo='10,:20,\"100,n~/.viminfo
"restore cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"ui
set ruler " show the cursor position
set laststatus=2 "alwasy show status line
set statusline=%<%f\ %h%m%r%y%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set listchars=tab:▸\ ,eol:¬ "invisible chars
set nolist "dont show invisible chars by default
set noerrorbells "dont beep!
set novisualbell
set showcmd "show command in the last line of the screen
set wrap linebreak
set showbreak=↪\ "show at the beginning of wrapped lines
set shortmess=at

"search
set hlsearch " highlight the last searched term
set incsearch "find as you type
set ignorecase "http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set smartcase

"indentation
set autoindent " Auto indenting
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"folding
set nofoldenable "dont fold by default
set foldmethod=indent
set foldlevel=99

"completion
set wildmenu "command line completion
set wildignore=*.o,.DS_STORE,*.obj,*.pyc,*.class,_build,*.aux,*.bbl,*.blg "ignore these files
set wildmode=full
set completeopt=menu"only show the omnicompletemenu, no docstring buffer
set pumheight=15 "limit completion menu height

if has("autocmd") && exists("+omnifunc")
autocmd Filetype *
\	if &omnifunc == "" |
\	 setlocal omnifunc=syntaxcomplete#Complete |
\	endif
endif

"clang
let g:clang_use_library=1
let g:clang_complete_copen=1
let g:clang_periodic_quickfix=1
let g:clang_complete_auto=1

"python
autocmd FileType python setlocal autoindent tabstop=4 expandtab shiftwidth=4 softtabstop=4 smarttab
autocmd FileType python call LoadRope()
let python_highlight_all=1
let g:pydoc_highlight=0
let g:pyflakes_use_quickfix=0 "don't use quickfix with pyflakes, conflicts with ack
" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

"neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_disable_auto_complete = 1
let g:neocomplcache_force_overwrite_completefunc=1
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)
" <CR>: close popup
inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : "\<C-x>\<C-o>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><ESC> pumvisible() ? "\<C-e>" : "\<ESC>"
function! s:check_back_space()"{{{
let col = col('.') - 1
return !col || getline('.')[col - 1] =~ '\s'
endfunction"}}

"awesome manpages
"see note [1] at http://crumbtrail.chesmart.in/post/5024677985/man-vim-dude
runtime! ftplugin/man.vim
nmap K :Man <cword><CR>

"autotag
source ~/.vim/bundle/autotag/autotag.vim

"jshint
let g:jshint = 1

"quickfix window minimum height 3, max 10, autoadjusts to number of errors
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction
au Filetype qf setlocal nolist nocursorline nowrap

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

"yankring
let g:yankring_history_dir = '/tmp'

let mapleader = ","
map <leader>t :CommandTFlush<cr>\|:CommandT<cr>
nnoremap <leader><leader> ``
nnoremap ; :
",space to clear search
nnoremap <leader><space> :noh<cr>
",W to remove all trailing whitespace
nnoremap <leader>W :call <SID>StripTrailingWhitespaces()<CR>
",i to toggle show invisibiles
nnoremap <leader>i :set list!<CR>
",n to toggle linenumbers
nnoremap <leader>n :set number! number?<cr>
",a to Ack the word under the cursor
nnoremap <leader>a :Ack <cword><CR>
",e to edit file with path of currently open prefilled
map <leader>e :e <C-R>=expand('%:h').'/'<CR>
map <leader>y :YRShow<CR>
"make arrow keys work in Terminal.app in insertmode
" imap [A <up>
" imap [B <down>
" imap [5C <right>
" imap [5D <left>
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
vnoremap < <gv
vnoremap > >gv
" cycle through buffers with C-j and C-k
nnoremap <C-j> :bp<cr>
nnoremap <C-k> :bn<cr>
",s for search/replace
nnoremap <leader>s :%s///g<left><left><left>
nnoremap <leader>l :TagbarToggle<CR>
nnoremap <leader>ro :call RopeOrganizeImports()<CR>
nnoremap <leader>g :call RopeGotoDefinition()<CR>

cmap w!! w !sudo tee % >/dev/null

set background=light
colorscheme solarized

if has('gui_running')
    " set guifont=Menlo\ Regular:h12
    set guifont=Inconsolata-dz:h12
    set guioptions-=T " hide toolbar
    set guioptions-=L "hide scrollbars
    set guioptions-=l "hide scrollbars
    set guioptions-=R "hide scrollbars
    set guioptions-=r "hide scrollbars
    set guioptions-=b "hide scrollbars
    set columns=110 "initial screensize
    set cursorline "hightlight current line
    set fuopt=maxvert,maxhorz "set max size for fullscreen
endif

