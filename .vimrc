"i vim: set fdm=marker :

" #Essentials {{{
" Nocompat with vi
set nocompatible

" Turns syntax highlighting on
syntax enable

" Numbers, can you imagine?
set number

" Extra info on the bottom
set ruler

" Highlight current line
set cursorline

" Leader key is comma
let mapleader = ","
let maplocalleader = ","

" ##Search tweaks {{{
set hlsearch
set incsearch
" Kill current search
nnoremap <silent> <Leader>/ :nohlsearch<CR>
"}}}


" ##AutoCmd essentials{{{
if has("autocmd")
  " Enable file type detection
  filetype on
  filetype plugin indent on
endif
"}}}

" Prefer spaces to tabs and set size to 2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Allows to use mouse to move the cursor
set mouse=a

" Tweak the behavior of <Tab> in command mode
set wildmenu
set wildmode=longest:full,full

" Indentation tweaks:
" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv
" dumb indent
set autoindent

" No need to switch back to English in normal mode
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

" Buffers tweaks
" Allow to switch from changed buffer
set hidden

" Splits tweaks {{{
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" I want new splits to appear to the right and to the bottom of the current
set splitbelow
set splitright
" }}}


" Wrapping tweaks "{{{
set wrap
set linebreak
set textwidth=80
set formatoptions=cq " format using textwidth, including comments and gq
"}}}

" I can type :help myself, thanks.
noremap <F1> <Esc>

" Save undo history persistently on disk, takes extra space "{{{
if has('persistent_undo')         " persistend undo history
  " create the directory if it doesn't exist
  silent !mkdir ~/.vim/undo > /dev/null 2>&1
  set undofile                  " Save undo's after file closes
  set undodir=~/.vim/undo/      " where to save undo histories
  set undolevels=100            " How many undos
  set undoreload=3000           " number of lines to save for undo
endif
"}}}

" Gaming swap files "{{{
" create the directory if it doesn't exist
silent !mkdir ~/.vim/swap > /dev/null 2>&1
set backupdir=~/.vim/swap/
set directory=~/.vim/swap/
"}}}

" MacVim or GVim options "{{{
if has("gui_running")
  set guioptions-=L
  set guioptions-=r
  set guioptions-=T
endif
"}}}

" Semicolon is just colon
nnoremap ; :

" Tweak ESC to be 'jk' typed fast
imap jk <ESC>
" Do not disable it, since kinesis has cool remap to the left thumb
" imap <ESC> <nop>
"}}}

" #Leader mappings {{{
" Show/hide invisibles by <leader>l
nnoremap <leader>l :set list!<CR>
" Toggle spelling on/off
nnoremap <silent> <leader>s :set spell!<CR>
" Tab movements
nnoremap <leader>m :tabn<CR>
nnoremap <leader>n :tabp<CR>
" }}}

" #MISC {{{
"    Automatically reload vimrc when it's saved "{{{
         augroup VimrcSo
           au!
           autocmd BufWritePost $MYVIMRC so $MYVIMRC
         augroup END
"    }}}

" for nvim: map esc in terminal mode to the terminal esacpe
" double escape will be 'send escape to the terminal program'
    if has("nvim")
      tnoremap <ESC> <C-\><C-n>
      tnoremap <ESC><ESC> <ESC>
    endif

    set shell=fish

    if has("gui_running")
      let g:airline_powerline_fonts=1
      " Even special font for this crap
      set guifont=Source\ Code\ Pro\ for\ Powerline:h13
    endif
" }}}

" #Bundles {{{
"   ##Setup Vundle {{{
        set rtp+=~/.vim/bundle/Vundle.vim
        call vundle#begin()
        Plugin 'gmarik/Vundle.vim'
"   }}}

"   ##Bundles {{{
"       Undo/Redo tree
        Plugin 'sjl/gundo.vim'
"       Surround - invoked by `S` in visual mode
        Plugin 'tpope/vim-surround'

"       ###Colorscheme {{{
            Plugin 'slava/vim-colors-tomorrow'
            set t_Co=256
            let g:tomorrow_termcolors = 256
            let g:tomorrow_termtrans = 0 " set to 1 if using transparant background
            let g:tomorrow_diffmode = "high"

            try
              colorscheme tomorrow
            catch
"           we don't have this theme or it throws
            endtry

"           set background=light
            set background=dark
"       }}}

"       ###Ctrl+Space {{{
"           extra colors
            hi CtrlSpaceNormal   guifg=#839496 guibg=#073642 guisp=#839496 gui=NONE ctermfg=12 ctermbg=0 cterm=NONE
            hi CtrlSpaceSelected guifg=#586e75 guibg=#eee8d5 guisp=#839496 gui=reverse,bold ctermfg=10 ctermbg=7 cterm=reverse,bold
            hi CtrlSpaceSearch   guifg=#cb4b16 guibg=NONE gui=bold ctermfg=9 ctermbg=NONE term=bold cterm=bold
            hi CtrlSpaceStatus   guifg=#839496 guibg=#002b36 gui=reverse term=reverse cterm=reverse ctermfg=12 ctermbg=8

"           use ag which is faster
            if executable("ag") 
              let g:ctrlspace_glob_command = 'ag -l --nocolor -g ""'
            endif

            let g:ctrlspace_ignored_files = '\v(tmp|temp|.build|.meteor\/local)[\/]'
            let g:ctrlspace_load_last_workspace_on_start = 'true'
            let g:ctrlspace_save_workspace_on_exit = 'true'
            

            Plugin 'szw/vim-ctrlspace' 
"       }}}

"       ### Syntax {{{
            Plugin 'slava/vim-spacebars'
            Plugin 'pangloss/vim-javascript'
            Plugin 'tpope/vim-markdown'
"       }}}
"   }}}

"   ##Finish Vundle {{{
        call vundle#end()
        filetype plugin indent on
"   }}}
" }}}

" HACK: For some reason setting the colorscheme in the end makes the most sense
colorscheme tomorrow

