" hook_add {{{
nnoremap <leader>f <Cmd>call ddu#start(#{sources:[#{name:'file_rec'}]})<CR>
nnoremap <leader>b <Cmd>call ddu#start(#{sources:[#{name:'buffer'}]})<CR>

function s:ddu_ff_config() abort
    nnoremap <buffer> <CR> <Cmd>call ddu#ui#do_action('itemAction')<CR>
    nnoremap <buffer> q <Cmd>call ddu#ui#do_action('quit')<CR>
    nnoremap <buffer> i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
endfunction
autocmd FileType ddu-ff call s:ddu_ff_config()


" }}}

" hook_source {{{
call ddu#custom#load_config(expand($HOOKS_DIR .. "/ddu.ts"))
" }}}
