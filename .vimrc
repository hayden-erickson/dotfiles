syntax on

" make tabs behave as expected
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set nu

set wildmenu            " visual autocomplete for command menu
set showmatch           " highlight matching [{()}]

set incsearch           " search as characters are entered
set hlsearch            " highlight matches

set cursorline 
hi CursorLine cterm=BOLD ctermbg=darkgrey

" move vertically by visual line
nnoremap j gj
nnoremap k gk

let mapleader=","       " leader is comma


" tab creation and navigation
map <leader>tn :tabnew ./<cr>
map <leader>x gt
map <leader>z gT
map <leader>vs :vs ./<cr>

" easily move between windows
map <C-l> <C-w>l
map <C-k> <C-w>k
map <C-j> <C-w>j
map <C-h> <C-w>h

" resize windows
"  - vertically
map <leader>< 10<C-w><
map <leader>> 10<C-w>>
"  - horizontally
map <leader><Up> 10<C-w>+
map <leader><Down> 10<C-w>-


" sudo nerdtree
map \ :vs ./<cr> :vertical resize 30<cr>
let g:netrw_liststyle=3
let g:netrw_preview=0


execute pathogen#infect()
