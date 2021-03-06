" support line numbers
set number

" line length ruler
set ruler
set colorcolumn=121
set textwidth=120

" give cursor room while scrolling
set scrolloff=3

" highlight searches
set hlsearch
set incsearch

" forward-slash search case-insensitive
set ignorecase
set smartcase

" syntax highlighting
syntax on
filetype on
filetype plugin on
filetype indent on
set cursorline cursorcolumn
hi CursorColumn ctermbg=18

" sane cursor movement
nmap j gj
nmap k gk

" quieter
set visualbell
