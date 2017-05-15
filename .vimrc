runtime bundle/pathogen.vim

set nocompatible " explicitly get out of vi-compatible mode, MUST BE FIRST!
set cpoptions=Bq " When joining lines leave the cursor between the lines

filetype plugin indent on " load filetype plugins/indent settings
set backspace=indent,eol,start " make backspace a more flexible

set backupcopy=yes " so that file watchers do not get lost
if has("vms")
    set nobackup " don't keep backup, keep versions instead
else
    set backup " make backup files
    set backupdir=~/.vim/backup " where to put backup files
endif

if has("mouse")
    set mouse=a
endif

set history=50 "keep 50 lines of command line history
set clipboard+=unnamed " share windows clipboard
set fileformats=unix,dos,mac " support all three, in this order
set iskeyword+=_,$,@,%,# " none of these are word dividers
set noerrorbells " don't make noise
set wildmenu " turn on command line completion wild style
" ignore these list file extensions
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
set wildmode=list:longest " turn on wild mode huge list

set list
set listchars=tab:<.,trail:~
autocmd BufWritePre *.rb,*.js*,*.ex*,*.coffee :%s/\s\+$//e

" highlight chars over 118 characters
match ErrorMsg '\%>120v.\+'
map <F10> :match ErrorMsg ''

if has("autocmd")
    augroup vimrcEx
        au!
        " when opening the file leave the cursor where it was previously
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif
        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78
        " Changing cwd to dir of edited file
        autocmd BufEnter * lcd %:p:h
    augroup END
endif
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif

set hlsearch " do NOT higlight found phrases
set incsearch " BUT do highlight as you type you
" search phrase
set lazyredraw " do not redraw while running macros
set linespace=0 " don't insert any extra pixel lines
" betweens rows
set matchtime=5 " how many tenths of a second to blink
" matching brackets for
set nohlsearch " do not highlight searched for phrases
set novisualbell " don't blink
set numberwidth=3 " We are good up to 999 lines
set number
" makes the line numbers grey
highlight LineNr ctermfg=grey
"highlight LineNr ctermbg=black
set report=0 " tell us when anything is changed via :...
set ruler " Always show current positions along the bottom
set scrolloff=5 " Keep 5 lines (top/bottom) for scope
set showmatch " show matching brackets

set expandtab " no real tabs please!
set formatoptions=rq " Automatically insert comment leader on return,
" and let gq format comments
set ignorecase " case insensitive by default
set infercase " case inferred by default
set shiftround " when at 3 spaces, and I hit > ... go to 4, not 5
set smartcase " if there are caps, go case-sensitive
set shiftwidth=4 " auto-indent amount when using cindent,
" >>, << and stuff like that
set softtabstop=4 " when hitting tab or backspace, how many spaces
"should a tab be (see expandtab)
set tabstop=4 " real tabs should be 8, and they will show with
" set list on

" moving between the windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-h> <c-w>h
map <c-l> <c-w>l

"if i ever use tabs here are helpful mappings
"nmap           <C-h>                          :tabprevious<CR>
"nmap           t                              :tabnew
"nmap           <C-l>                          :tabnext<CR>

set fileencodings=utf8,latin2
" ruby standard 2 spaces, always
au BufRead,BufNewFile *.rb,*.rhtml,*.haml,*.yml,*.js*,*.scss*,Rules set shiftwidth=2
au BufRead,BufNewFile *.rb,*.rhtml,*.haml,*.yml,*.js*,*.scss*,Rules set softtabstop=2
" simple text editing, for instace e-mails
" add line width formatting
au BufRead,BufNewFile *.mail setlocal formatoptions+=ta
au BufRead,BufNewFile *.mail setlocal textwidth=40
au BufRead,BufNewFile *.mail match ErrorMsg ''
" magic modeline # VIMM: seeet filetype=ruby:

execute pathogen#infect()
syntax enable
filetype plugin indent on

" automagically change vim background
let hour = strftime("%H")
if 8 <= hour && hour < 16
    " set background=light
    set background=light
else
    set background=dark
endif
" Importatnt for solarized colors to display correctly in Terminator
set term=xterm-256color
colorscheme solarized
"syntasctic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ctrp mapping
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'tmp\|log\|build\|node_modules\|DS_Store\|git'

" EASY MOTION CONFIG
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key
" binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
""map  n <Plug>(easymotion-next)
""map  N <Plug>(easymotion-prev)

""map l <Plug>(easymotion-lineforward)
""map j <Plug>(easymotion-j)
""map k <Plug>(easymotion-k)
""map h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

" NERDCOMMENTER
nnoremap ,c :call NERDComment(0,"toggle")<CR>
vnoremap ,c :call NERDComment(0,"toggle")<CR>
let NERDCompactSexyComs=1
" HARD MODE
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
" external conf
set exrc
