" Bryan's default vimrc

" Prevent duplicate autocommands
autocmd!

set nocompatible

" Pathogen
call pathogen#infect()
syntax on
filetype plugin indent on

set nobackup " do not make backup files
" set backupdir=~/.vim/backup " where to put backup files
set directory=~/.vim/tmp " directory to place swap files in
set noswapfile " do not create swap files

set history=1000

set scrolloff=3

" stop beeping at me
set visualbell
set t_vb&

" The default for 'backspace' is very confusing to new users, so change it to a
" more sensible value.  Add "set backspace&" to your ~/.vimrc to reset it.
" set backspace+=indent,eol,start

set number

"set ruler

if has('gui_running')
	set background=dark
	colorscheme solarized
	set guioptions=egmrt
else
	colorscheme molokai
endif

let g:Powerline_symbols = 'fancy'
set laststatus=2

set ts=4
set sts=4
set sw=4

set autoindent
set cmdheight=2

" Use case insensitive search, except when using capital letters
set hlsearch
set incsearch
set ignorecase
set smartcase

" Space removes highlighted items
nmap <silent> <SPACE> :nohlsearch<CR>

set cursorline

" set transparency=5

au BufRead,BufNewFile *.as set filetype=actionscript

" Save and load folds automatically
au BufWinLeave *.* mkview
au BufWinEnter *.* silent loadview

" automatically source vim sessions so I can open them with the finder
au BufRead *.vis so %

au BufRead,BufNewFile *.* IndentGuidesEnable

" not needed with snippets, but for example
" iab fun function()<CR>{<CR><TAB><CR><BS>}<ESC>bbi

let g:solarized_termcolors=256
function! ToggleSolarBG()
	let &background = ( &background == "dark"? "light" : "dark" )
endfunction

set wildmenu
set wildmode=list:longest,full

let mapleader = ","

map <Leader>u :GundoToggle<cr>

let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_WinWidth = 50
map <Leader>e :TlistToggle<cr>
map <Leader>g :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

map <Leader>r :register<CR>

map <Leader>f :Bufferlist<cr>

map <Leader>x :call ToggleSolarBG()<cr>

map <Leader>d :bd<CR>
map <Leader>D :bd!<CR>

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>


function! MakeSession()
"  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessiondir = $HOME . "/.vim/sessions"
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  if has('gui_running')
	  let b:filename = b:sessiondir . '/guisession.vim'
  else
	  let b:filename = b:sessiondir . '/session.vim'
  endif
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
"  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessiondir = $HOME . "/.vim/sessions"
  if has('gui_running')
	  let b:sessionfile = b:sessiondir . "/guisession.vim"
  else
	  let b:sessionfile = b:sessiondir . "/session.vim"
  endif
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

if has('gui_running')
	au VimEnter * nested :call LoadSession()
endif
au VimLeave * :call MakeSession()

" WideMsg() prints [long] message up to (&columns-1) length
" guaranteed without "Press Enter" prompt.
function! WideMsg(msg)
	let x=&ruler | let y=&showcmd
    set noruler noshowcmd
	redraw
	echo a:msg
	let &ruler=x | let &showcmd=y
endfun

function! CheckPHP()
	let current_file = shellescape(expand('%:p'))
	let command = "php -l " . current_file 
	let @p = system(command)
	call WideMsg(@p)
endfunction

" Check PHP syntax on save
autocmd BufWritePost,FileWritePost *.php,*.ctp call CheckPHP()

" Compile LessCSS on save
autocmd BufWritePost,FileWritePost *.less :silent !lessc <afile> <afile>:p:r.css

" Minify CSS on save
autocmd BufWritePost,FileWritePost *.css :silent !java -jar /usr/local/bin/yuicompressor <afile> -o <afile>:p:r.min.css

" Uglify JS on save
" This seems to be the best minifier right now, but is still fairly new
autocmd BufWritePost,FileWritePost *.js :silent !uglifyjs -o <afile>:p:r.min.js <afile>

" added 'nested' on 17/10/12 to fix powerline issue https://github.com/Lokaltog/vim-powerline/issues/204
" http://vimdoc.sourceforge.net/htmldoc/autocmd.html#autocmd-nested
if has("autocmd")
augroup myvimrchooks
au!
  autocmd bufwritepost .vimrc nested source ~/.vimrc
augroup END
endif
