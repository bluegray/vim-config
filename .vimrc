set nocompatible      " Use vim, no vi defaults

call pathogen#infect()

set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
set encoding=utf-8    " Set default encoding to UTF-8
set hidden
set showcmd

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter
filetype plugin indent on
set autoindent

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

set backup
set backupdir=~/.vim/_backup//    " where to put backup files.
set directory=~/.vim/_temp//      " where to put swap files.

setlocal spell spelllang=en_us
colorscheme bluegray

set guifont=Consolas\ 10

let g:syntastic_mode_map = { 'mode': 'active',
                            \ 'active_filetypes': ['ruby', 'php', 'python'],
                            \ 'passive_filetypes': ['puppet'] }
let g:cssColorVimDoNotMessMyUpdatetime = 2

"set statusline+=%#warningmsg#
"set statusline+=%{fugitive#statusline()}
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%#todo#%y%#warningmsg#%{fugitive#statusline()}%{SyntasticStatuslineFlag()}%*%=%#error#%c%*,%l/%L\ %P

"Get back ctrl-c/v/a
source $VIMRUNTIME/mswin.vim

"autocmd VimEnter * NERDTree
"autocmd BufEnter * wincmd r
"autocmd BufEnter * vertical resize 150
"autocmd BufEnter * NERDTreeMirror
"autocmd VimEnter * wincmd w
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"autocmd BufNew * wincmd l

let mappings = expand('~/.vim/mappings.vim')
if filereadable(mappings)
  exe 'source ' . mappings
endif

map ,1    :set guifont=Dejavu\ Sans\ Mono\ 10<CR>
map ,2    :set guifont=ProFont\ 8<CR>
map ,3    :set guifont=ProggyCleanTTSZBP\ 12<CR>
map ,4    :set guifont=ProggyTinyTTSZ\ 12<CR>
map ,5    :set guifont=Dina\ ttf\ 10px\ 12<CR>
map ,6    :set guifont=Anonymous\ Pro\ 9<CR>
map ,7    :set guifont=Inconsolata\ 10<CR>
map ,8    :set guifont=Inconsolata\ 11<CR>
map ,9    :set guifont=Inconsolata\ 12<CR>
map ,88   :set guifont=Consolas\ 8<CR>
map ,99   :set guifont=Consolas\ 9<CR>
map ,00   :set guifont=Consolas\ 10<CR>
map ,11   :set guifont=Consolas\ 11<CR>
map ,22   :set guifont=Consolas\ 12<CR>

map ,ss   :source ~/.vimrc<Enter>
map ,vv   :edit ~/.vimrc<Enter>
map ,hh   :help quickref<Enter>
map ,pp   :help pattern<Enter>
map ,ww   :set wrap!<Enter>
map ,df   :vertical diffsplit

"map <leader>n :NERDTreeToggle<CR>
"map <leader>m :NERDTreeMirror<CR>
map <Leader>n :NERDTreeTabsToggle<CR>
map <Leader>m :NERDTreeMirrorToggle<CR>
map <leader>gs :Gstatus<CR>
map <leader>gd :Gdiff<CR>
map <leader>du :diffupdate<CR>
map <leader>bb :BookmarkToRoot<Space>
map <leader>ff mzgg=G`z<CR>

map ,d    gg:.,$!sort --unique<Enter>
map ,w    :%s/\s\+$//e<Enter>
map ,st   :%s/^ \+/\=substitute(submatch(0), repeat(' ', &tabstop), "\t", 'g')<Enter>

nnoremap ,m :w <BAR> !lessc % <BAR> cssmin.py > /home/bluegray/devel/cognician.com/web/css/%:t:r.css<CR><space>

map <silent> ,md :silent !md<CR><CR>
map <silent> ,mm :w<CR> :silent !md<CR><CR>
map <silent> <leader>s :set spell!<CR>


" Load custom whitespace settings
function SetCognicianOptions()
  set softtabstop=2 shiftwidth=2 noexpandtab
  colorscheme bluegray_alt
endfunction
if has("autocmd")
  augroup module
    au BufRead,BufNewFile *.module set softtabstop=2 shiftwidth=2
    au BufRead,BufNewFile *.install set softtabstop=2 shiftwidth=2
    au BufRead,BufNewFile *.tpl.php set softtabstop=2 shiftwidth=2
    au BufRead,BufNewFile *.inc set softtabstop=2 shiftwidth=2
    au BufRead,BufNewFile template.php set softtabstop=2 shiftwidth=2
    au BufRead,BufNewFile *.rb set softtabstop=2 shiftwidth=2
    au BufRead,BufNewFile *.yml set softtabstop=2 shiftwidth=2 expandtab
    au BufRead,BufNewFile rsnapshot.conf set tabstop=8 shiftwidth=8 noexpandtab
    au BufRead,BufNewFile *.php call SetCognicianOptions()
    au BufRead,BufNewFile *.rb  if match(@%,'/Semaphore/')>=0     | call SetCognicianOptions() | else | colorscheme bluegray | end
    au BufRead,BufNewFile *.erb if match(@%,'/Semaphore/')>=0     | call SetCognicianOptions() | else | colorscheme bluegray | end
  augroup END
endif

"Handle unwanted whitespace
match Todo /\s\+$\| \+\ze\t\|\t\+\zs \+/
set list listchars=tab:»·,trail:·,extends:>,precedes:<

au BufRead,BufNewFile *.erb match Todo /<?php\_.\{-}?>/

"Remove trailing whitspace only from .py files
autocmd BufWritePre *.py :%s/\s\+$//e

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

    " Set the Ruby filetype for a number of common Ruby files without .rb
    au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,config.ru,*.rake} set ft=ruby

autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn
      \ if &ft =~# '^\%(conf\|modula2\)$' |
      \   set ft=markdown |
      \ else |
      \   setf markdown |
      \ endif

autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn set com=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,b:-
autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn set com=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,b:*
autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn set com=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,b:+
autocmd BufNewFile,BufRead *.markdown,*.md,*.mdown,*.mkd,*.mkdn set formatoptions=tcroqln


"From http://stackoverflow.com/questions/2415237/techniques-in-git-grep-and-vim
func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

func GitGrepWord()
  normal! "zyiw
  call GitGrep('-w -e ', getreg('z'))
endf
nmap <leader>gg :call GitGrepWord()<CR>

" Settings for VimClojure
"let vimclojure#HighlightBuiltins=1
"let vimclojure#ParenRainbow=1

autocmd FileType sass,scss,stylus syn cluster sassCssAttributes add=@cssColors
autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}
autocmd BufRead,BufNewFile *.html setlocal foldmethod=indent

let g:slimv_swank_clojure = '! xterm -e lein_swank.sh &'
let g:lisp_rainbow=1
