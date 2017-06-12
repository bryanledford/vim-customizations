" Bryan's default vimrc

" Prevent duplicate autocommands
autocmd!

" Prepare for plugin loading
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Other Plugins
" Plugin 'wincent/Command-T'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'msanders/snipmate.vim'
Plugin 'sandeepcr529/Buffet.vim'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-scripts/Gundo'
Plugin 'vim-scripts/taglist.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
" Plugin 'spf13/PIV'
" Plugin 'ervandew/supertab'
" Plugin 'mattn/emmet-vim'



" All of your Plugins must be added before the following line
call vundle#end()            " required

syntax on
filetype plugin indent on

set nobackup " do not make backup files
" set backupdir=~/.vim/backup " where to put backup files
set directory=~/.vim/tmp " directory to place swap files in
set noswapfile " do not create swap files

set history=1000

" hide buffers instead of unloading them
set hidden

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
	set macligatures
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

" Set leader key
let mapleader = ","

" Space removes highlighted items
nmap <silent> <SPACE> :nohlsearch<CR>
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

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

map <Leader>u :GundoToggle<cr>

let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_WinWidth = 50
map <Leader>e :TlistToggle<cr>
map <Leader>g :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

map <Leader>n :NERDTreeToggle<cr>

map <Leader>r :register<CR>

" Format JSON
map <Leader>j :%!python -m json.tool<CR>

" Command-T lke mappings for CtrlP
map <Leader>t :CtrlP<cr>
map <Leader>b :CtrlPBuffer<cr>

map <Leader>f :Bufferlist<cr>

" Toggle Light/Dark
map <Leader>x :call ToggleSolarBG()<cr>

" Delete buffers
map <Leader>d :bd<CR>
map <Leader>D :bd!<CR>

" Switch to previous tab (control+tab)
let g:lasttab = 1
map <C-TAB> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" switch to previous buffer (alt+tab – load 'alternate' buffer into current window)
map <M-TAB> :b#<CR>

" cycle through windows. For jumping around splits
map <C-S-TAB> <C-W><C-W>

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NeoComplCache Customizations
" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


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

function! CompileTypeScript()
	let current_file = shellescape(expand('%:p'))
	let command = "tsc " . current_file
	let @p = system(command)
	call WideMsg(@p)
endfunction

function! CompileCoffee()
	let current_file = shellescape(expand('%:p'))
	let command = "coffee -c " . current_file
	let @p = system(command)
	call WideMsg(@p)
endfunction

function! CompileSASS()
	let current_file = shellescape(expand('%:p'))
	let out_file = shellescape(expand('%:p:r.scss'));
"	let command = "sass --cache-location ~/.sass-cache " . current_file . " " . out_file . ".css"
"	let @p = system(command)
"	call WideMsg(@p)
endfunction

" Check PHP syntax on save
autocmd BufWritePost,FileWritePost *.php,*.ctp call CheckPHP()

" Compile TypeScript on save
autocmd BufWritePost,FileWritePost *.ts call CompileTypeScript()

" Compile CoffeeScript on save
" autocmd BufWritePost,FileWritePost *.coffee call CompileCoffee()

" Compile SASS/SCSS on save
" autocmd BufWritePost,FileWritePost *.scss call CompileSASS()

" Compile LessCSS on save
autocmd BufWritePost,FileWritePost *.less :silent !lessc <afile> <afile>:p:r.css

" Minify CSS on save
" autocmd BufWritePost,FileWritePost *.css :silent !java -jar /usr/local/bin/yuicompressor <afile> -o <afile>:p:r.min.css

" Uglify JS on save
" This seems to be the best minifier right now, but is still fairly new
"autocmd BufWritePost,FileWritePost *.js :silent !uglifyjs -o <afile>:p:r.min.js <afile>

" added 'nested' on 17/10/12 to fix powerline issue https://github.com/Lokaltog/vim-powerline/issues/204
" http://vimdoc.sourceforge.net/htmldoc/autocmd.html#autocmd-nested
if has("autocmd")
augroup myvimrchooks
au!
  autocmd bufwritepost .vimrc nested source ~/.vimrc
augroup END
endif
