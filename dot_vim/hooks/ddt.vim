" hook_add {{{
nnoremap <leader>t <Cmd>call ddt#start(#{
            \ ui: 'terminal',
            \ uiParams: #{
            \   split:'vertical'}
            \ })<CR>
autocmd FileType ddt-shell call s:ddt_terminal_settings()
function s:ddt_terminal_settings() abort
endfunction

" }}}
" hook_source {{{
call ddt#custom#load_config(expand($HOOKS_DIR .. "/ddt.ts"))

" }}}
