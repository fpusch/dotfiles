" telescope
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>
nnoremap <leader>pf :lua require('telescope.builtin').find_files()<CR>

" telescope git
nnoremap <leader>gb :lua require('telescope.builtin').git_branches()<CR>
nnoremap <leader>gcf :lua require('telescope.builtin').git_commits()<CR>
nnoremap <leader>gf :lua require('telescope.builtin').git_files()<CR>

lua require('fpusch/telescope')
