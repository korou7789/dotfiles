" hook_add {{{
nnoremap <leader>f <Cmd>call ddu#start(#{sources:[#{name:'file_rec'}]})<CR>
nnoremap <leader>b <Cmd>call ddu#start(#{sources:[#{name:'buffer'}]})<CR>
nnoremap <leader>g <Cmd>call ddu#start(#{
            \ sources:[#{
            \     name:'rg',
            \     options:#{
            \         matchers:[],
            \         volatile: v:true
            \     },
            \ }]
            \ })<CR>
nnoremap <leader>gs <Cmd>call ddu#start(#{sources:[#{name:'git_status'}]})<CR>
nnoremap <leader>gl <Cmd>call ddu#start(#{sources:[#{name:'git_log'}]})<CR>

function s:ddu_ff_config() abort
    setlocal cursorline
    nnoremap <buffer> <CR> <Cmd>call ddu#ui#do_action('itemAction')<CR>
    nnoremap <buffer> q <Cmd>call ddu#ui#do_action('quit')<CR>
    nnoremap <buffer> i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
    nnoremap <buffer> a <Cmd>call ddu#ui#do_action('chooseAction')<CR>
endfunction
autocmd FileType ddu-ff call s:ddu_ff_config()


" }}}

" hook_source {{{
call ddu#custom#load_config(expand($HOOKS_DIR .. "/ddu.ts"))
" }}}
