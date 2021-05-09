" quickfix and location lists
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
nnoremap <leader>j :lnext<CR>zz
nnoremap <leader>k :lprev<CR>zz

" terminal mode
tnoremap <Esc> <C-\><C-n>

" cut, copy and paste

" paste over text
vnoremap <leader>p "_dP

" yank to clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" black-hole delete
nnoremap <leader>d "_d
vnoremap <leader>d "_d
