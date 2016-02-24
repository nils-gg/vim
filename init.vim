set nocompatible        " be iMproved, required
set modelines=0         " set the number of modelines Vim parses, when it starts, to zero
filetype off            " required

" NEOBUNDLE
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'tpope/vim-fugitive'                  " Git wrapper
NeoBundle 'wincent/command-t'                   " Fast file navigation for VIM
NeoBundle 'rstacruz/sparkup', {'rtp': 'vim/'}   " A parser for a condensed HTML format
NeoBundle 'Valloric/YouCompleteMe'              " A code-completion engine for Vim
NeoBundle 'ternjs/tern_for_vim'                 " plugin that provides Tern-based JavaScript editing support

NeoBundle 'scrooloose/nerdtree'                 " A tree file-explorer plugin for vim
NeoBundle 'kien/ctrlp.vim'                      " Fuzzy file, buffer, mru, tag, etc finder
NeoBundle 'Raimondi/delimitMate'                " provide insert mode auto-completion for quotes, parens, brackets, etc

" Vim-Go-IDE
NeoBundle 'fatih/vim-go'
NeoBundle 'nsf/gocode'
" Colorschemes
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'

" status/tabline for vim
NeoBundle 'bling/vim-airline'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'skammer/vim-css-color'

call neobundle#end()
NeoBundleCheck

" delimitMate settings
let g:delimitMate_expand_cr = 1

" allow backspacing over everything in insert mode
if has("vms")
    set nobackup        " do not keep a backup file, use versions instead
else
    set backup          " keep a backup file
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")

    syntax on

    set hlsearch

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

endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

filetype plugin on
set omnifunc=syntaxcomplete#Complete

" AUTOCOMPLETE
autocmd FileType go setlocal omnifunc=gocomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
""""  autocmd Filetype java setlocal omnifunc=javacomplete#Complete

let g:EclimCompletionMethod='omnifunc'

"" colorscheme
colorscheme jellybeans
"colorscheme hybrid

set tabstop=4           " insert n spaces for a tab
set shiftwidth=4        " number of space characters inserted for indentation
set softtabstop=4       " number of space characters tab inserts in insert mode
set expandtab           " insert space characters whenever the tab key is pressed
set scrolloff=3         " number of context lines displayed above and below the cursor

set list                    " display whitespace 
set listchars=tab:▸\ ,eol:¬ " customize the way whitespace characters are shown

set encoding=utf-8      " The encoding displayed
set hidden              " hide buffer when it is abandoned

set wildmenu                " enable a menu at the bottom of the vim/gvim window
set wildmode=list:longest   " 1. tab - a list of completions will be shown and the command
                                " will be completed to the longest common command.
                            " 2. tab - the wildmenu will show up with all the completions
                                " that were listed before. 

set visualbell          " flash screen instead of sounding a beep

set cursorline          " Highlight current line
set colorcolumn=85      " highlight specific column

set showmode            " Show mode (insert, visual, normal)
set showcmd             " show information about the current command going on 
set laststatus=2        " always displaying status line 
set ruler               " display ruler on the status line at the bottom 
                        " line ,column ,virtual column, relative position

set backspace=indent,eol,start  " Influences the working of backspace (bs)
                                " indent - allow backspacing over autoindent
                                " eol - allow backspacing over line breaks (join lines)
                                " start - allow backspacing over the start of insert; 
                                " CTRL-W and CTRL-U stop once at the start of insert.

set relativenumber      " display line numbers relative to the line with the cursor
set number              " display line number

set undofile            " persistent undo 
set history=50          " keep 50 lines of command line history

set incsearch           " do incremental searching
set hlsearch            " highlight all search matches
set ignorecase          " searching is not case sensitive
set smartcase           " When 'ignorecase' and 'smartcase' are on, if a pattern contains an 
                        " uppercase letter, it's case sensitive, otherwise it's not
set showmatch           " briefly jump to the opening bracket/paren/brace 
                        " when you type the closing bracket/paren/brace,

set gdefault            " When on, the ":substitute" flag 'g' is default on. All matches in a line
                        " are substituted instead of one. When a 'g' flag is given to a ":substitute"
                        " command, this will toggle the substitution of all or one match

set wrap                " lines longer than the window width will wrap and continue on the next line
set textwidth=78        " wrap text automatically
set formatoptions=qrn1  " automatic formatting
                            " q - allow 'gq' to work
                                " gp - reformat paragraph
                            " r - (in mail) comment leader after
                            " n - numbered lists
                            " 1 - single letter words on next line

" Don't use Ex mode, use Q for formatting
map Q gq

" make the tab key match bracket pairs
nnoremap <tab> %
vnoremap <tab> %

inoremap jj <ESC>       " remap <ESC> to jj when in INSERT mode

" open a new vertical split and switch over to it. If not changed: <leader> = \
nnoremap <leader>w <C-w>v<C-w>l

" map <C-[h/j/k/l]> to the commands needed to move around splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

"open NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

"show hidden files by default (NERDTree)
let NERDTreeShowHidden=1

"Go-settings
"""""""""""""""""""""""""""""
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"format with goimports instead of gofmt
let g:go_fmt_command = "goimports"
autocmd FileType c nnoremap <buffer> <silent> <C-]> :YcmCompleter GoTo<cr>

"invoke go Lint :Lint
set rtp+=P/home/nils/go/src/github.com/golang/lint/misc/vim

"syntastic settings
"""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_html_tidy_ignore_errors = ['proprietary attribute "ng-', 'proprietary attribute "pdk-']
let g:syntastic_javascript_checkers = ['eslint']
