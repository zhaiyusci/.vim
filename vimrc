"Language settings
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set encoding=utf-8
set termencoding=utf-8
"language messages zh_CN.UTF-8

"fileformat
set fileformat=unix

call plug#begin()
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'gko/vim-coloresque'
Plug 'terryma/vim-multiple-cursors'
Plug 'losingkeys/vim-niji'
Plug 'tpope/vim-surround'
Plug 'Shougo/neocomplete.vim'
Plug 'JuliaEditorSupport/julia-vim'
call plug#end()

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" do not keep a backup file, use versions instead
set nobackup		

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq
"au GUIEnter * simalt ~x

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
" but it may not work well with the terminal emulator on windows, when using
" ssh
if has('mouse')
  set mouse=
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
"syntax on
"set nohlsearch
"endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    "autocmd FileType text setlocal textwidth=78 " Yu Zhai 2016-08-02

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END

else
  " always set autoindenting on
  set autoindent		
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" ----------------------------------------------------------------------
"  ---------------------------------------------------------------------
" The following content was set by Y. Zhai <me@zhaiyusci.net>

set go=m                        " only show the menu in the GUI

"set colorcolumn=80              "set a highlight at c.80 for most condition

syntax on
set hidden

if v:progname =~? "gvim"
  "colorscheme evening-z
  "colorscheme twilight
  " Change for the using of airline
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
  " github page https://github.com/bling/vim-airline 
  "set guifontwide=DFKai-SB:h10.5
endif
set t_Co=256
"set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h9.5  
"colorscheme twilight-z
colorscheme evening-z
" colorscheme 3dglasses-z
set number
" set ic                            " Ignore Case (no neccessary unless we use fortran 
set foldmethod=marker             " the default marker is {{{     }}}
" set foldmethod=syntax            " the default marker is {{{     }}}
" Enable folding with the spacebar
nnoremap <space> za

"set cursorline
" set diffexpr=MyDiff()

" function MyDiff()
" let opt = '-a --binary '
" if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
" if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
" let arg1 = v:fname_in
" if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
" let arg2 = v:fname_new
" if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
" let arg3 = v:fname_out
" if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
" let eq = ''
" if $VIMRUNTIME =~ ' '
" if &sh =~ '\<cmd'
" let cmd = '""' . $VIMRUNTIME . '\diff"'
" let eq = '"'
" else
" let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
" endif
" else
" let cmd = $VIMRUNTIME . '\diff'
" endif
" silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
" endfunction

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

"airline begin
set laststatus=2
let g:airline_powerline_fonts=1
set noshowmode
let g:airline_theme="light"
"airline end

" filetype plugin on

" tab settings
set smarttab  
set tabstop=2  
set shiftwidth=2  
set expandtab  

" number and relative number
nnoremap <silent> <F3> :set nu!  <CR>
nnoremap <silent> <F4> :set rnu! <CR>

nnoremap <silent> <F5> :NERDTree <CR>
nnoremap <silent> <Leader><F5> :set hlsearch! <CR>

" Wrap lines
nnoremap <silent> <F6> :set wrap! <CR>

" spell check
nnoremap <silent> <F7> :set spell! <CR>

noremap j gj
noremap k gk

" Easy window navigation
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l
set pastetoggle=<F2>
nnoremap <silent> <leader>m :call Mousetoggle() <CR>
function Mousetoggle()
  if &mouse == ""
    let &mouse = "a"
    echo "Mouse enabled."
  else
    let &mouse = ""
    echo "Mouse disabled."
  endif
endfunction
" set clipboard+=unnamedplus

" Niji - rainbow parentheses plugin 
let g:niji_matching_filetypes = ['lisp', 'scheme', 'clojure', 'haskell']

" NERDcommenter
let g:NERDSpaceDelims = 1
" source ~/.vim/bundle/ctrlp.vim

let g:rust_recommended_style = 0

" Fortran
let fortran_do_enddo=1
" let g:ale_sign_column_always=1

" Julia
let g:latex_to_unicode_auto = 1

set colorcolumn=73

" Use neocomplete

"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
