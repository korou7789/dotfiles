" hook_add {{{
inoremap <C-n> <Cmd>call pum#map#select_relative(+1, "loop")<CR>
inoremap <C-p> <Cmd>call pum#map#select_relative(-1, "loop")<CR>
inoremap <C-y> <Cmd>call pum#map#confirm()<CR>
inoremap <C-l> <Cmd>call ddc#map#manual_complete()<CR>

cnoremap <Tab> <Cmd>call pum#map#insert_relative(+1, "loop")<CR>
cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1, "loop")<CR>
cnoremap <C-n> <Cmd>call pum#map#insert_relative(+1, "loop")<CR>
cnoremap <C-p> <Cmd>call pum#map#insert_relative(-1, "loop")<CR>
cnoremap <C-y> <Cmd>call pum#map#confirm()<CR>
cnoremap <C-l> <Cmd>call ddc#map#manual_complete()<CR>

nnoremap : <Cmd>call ddc#enable_cmdline_completion()<CR>:
" }}}
" hook_source {{{
call ddc#custom#load_config(expand($HOOKS_DIR .. "/ddc.ts"))
call ddc#enable()
" }}}
