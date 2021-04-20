set path+=**

" menu when typing find
set wildmode=longest,list,full
set wildmenu
" ignore files
set wildignore+=**/coverage/*
set wildignore+=**/node_modules/*
set wildignore+=**/.git/*

call plug#begin('~/.vim/plugged')

call plug#end()

