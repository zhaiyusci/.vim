"Language settings
scriptencoding utf-8
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
Plug 'losingkeys/vim-niji'
Plug 'tpope/vim-surround'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'joshdick/onedark.vim', { 'branch': 'main' }
Plug 'ludovicchabant/vim-gutentags'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
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

set hidden

if v:progname =~? "gvim"
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
endif
set t_Co=256
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
let g:airline_symbols.space = "\ua0"

" airline begin
set laststatus=2
let g:airline_powerline_fonts=1
set noshowmode
let g:airline_theme="onedark"
let g:airline_experimental = 0

" filetype plugin on
autocmd BufNewFile,BufRead,BufEnter * if &ft == '' | set ft=Unknown | endif

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
"
" Allow saving of files as sudo when I forgot to start vim using sudo.
command SaveWithSudo :w !sudo tee > /dev/null %

" Niji - rainbow parentheses plugin 
let g:niji_matching_filetypes = ['lisp', 'scheme', 'clojure', 'haskell']

" NERDcommenter
let g:NERDSpaceDelims = 1
" source ~/.vim/bundle/ctrlp.vim

let g:rust_recommended_style = 0

" Fortran
let fortran_do_enddo=1
" let fortran_free_source=1
let fortran_more_precise=1
" let g:ale_sign_column_always=1

" Julia
let g:latex_to_unicode_auto = 1

set colorcolumn=73

" For onedark.vim colorscheme
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, 
" you can remove the outermost $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    " For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  " For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  " Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

let g:onedark_hide_endofbuffer = 1
let g:onedark_terminal_italics = 1
let g:onedark_termcolors=256

syntax on
colorscheme onedark

" ctags
set tags=./.tags;,.tags

" gutentags 
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" ale
" let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++11 -I/usr/include/eigen3'
let g:ale_c_clang_options = '-Wall -O2 -std=c99'
let g:ale_cpp_clang_options = '-Wall -O2 -std=c++11 -I/usr/include/eigen3 -D __YDVR_SCALAR__=double -I/home/yuzhai/Documents/ydvr/src'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_linters = {
      \   'cpp' : ['clang', 'cppcheck'],
      \}

" deoplete
let g:deoplete#enable_at_startup = 1

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction " }}}

