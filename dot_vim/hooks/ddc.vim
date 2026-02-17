" hook_add {{{
inoremap <C-n> <Cmd>call pum#map#select_relative(+1, "loop")<CR>
inoremap <C-p> <Cmd>call pum#map#select_relative(-1, "loop")<CR>
inoremap <C-y> <Cmd>call pum#map#confirm()<CR>
" }}}
" hook_source {{{
call ddc#custom#load_config(expand($HOOKS_DIR .. "/ddc.ts"))
call ddc#enable()
" }}}
