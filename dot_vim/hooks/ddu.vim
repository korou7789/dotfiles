" hook_add {{{
nnoremap [ddu] <Nop>
nmap <leader> [ddu]

nnoremap [ddu]<leader>
            \ <Cmd>call ddu#start(#{sources:[#{name:'source'}]})<CR>
nnoremap [ddu]ff <Cmd>call ddu#start(#{
            \ sources:[#{
            \   name: 'file_external',
            \   params: #{
            \     cmd: ['fd', '.', '-t', 'f']
            \   },
            \ }]
            \ })<CR>
nnoremap [ddu]b
            \ <Cmd>call ddu#start(#{sources:[#{name:'buffer'}]})<CR>
nnoremap [ddu]g
            \ <Cmd>call ddu#start(#{
            \ sources:[#{
            \   name: 'rg',
            \   options: #{
            \     matchers: [],
            \     volatile: v:true,
            \   }]
            \ })<CR>
nnoremap [ddu]gs
            \ <Cmd>call ddu#start(#{
            \  name: 'git_status',
            \  sources:[#{name:'git_status'}]
            \ })<CR>
nnoremap [ddu]gl
            \ <Cmd>call ddu#start(#{sources:[#{name:'git_log'}]})<CR>
nnoremap [ddu]gd
            \ <Cmd>call ddu#start(#{
            \   push: v:true,
            \   sources: [#{
            \     name: 'git_diff_tree',
            \   }]
            \ })<CR>

autocmd FileType ddu-ff call s:ddu_ff_config()
function! s:ddu_ff_config() abort
    setlocal cursorline
    nnoremap <buffer> <CR>
                \ <Cmd>call ddu#ui#do_action('itemAction')<CR>
    nnoremap <buffer> q
                \ <Cmd>call ddu#ui#do_action('quit')<CR>
    nnoremap <buffer> i
                \ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
    nnoremap <buffer> p
                \ <Cmd>call ddu#ui#do_action('toggleAutoAction')<CR>
    nnoremap <buffer> <C-u>
                \ <Cmd>call ddu#ui#do_action('previewExecute', #{
                \   command: 'execute "normal! \<C-u>"'
                \ })<CR>
    nnoremap <buffer> <C-d>
                \ <Cmd>call ddu#ui#do_action('previewExecute', #{
                \   command: 'execute "normal! \<C-d>"'
                \ })<CR>
    nnoremap <buffer> a
                \ <Cmd>call ddu#ui#do_action('chooseAction')<CR>
    nnoremap <buffer> s 
                \ <Cmd>call ddu#ui#do_action(
                \   'itemAction', #{
                \     name: 'open',
                \     params: #{
                \       command: 'split'
                \     }
                \ })<CR>
    if b:ddu_ui_name ==# 'git_status'
        nnoremap <buffer> <
                    \ <Cmd>call ddu#ui#do_action('itemAction', #{name:'add'})<CR>
        nnoremap <buffer> >
                    \ <Cmd>call ddu#ui#do_action('itemAction', #{name:'reset'})<CR>
    endif
endfunction


nnoremap [ddu]F <Cmd>call ddu#start(#{
            \ ui: 'filer',
            \   sources: [#{name:'file'}]
            \ })<CR>

autocmd FileType ddu-filer call s:ddu_filer_config()
function! s:ddu_filer_config()
    setlocal cursorline
    nnoremap <buffer><expr> <CR>
      \   ddu#ui#get_item()->get('isTree', v:false)
      \ ? "<Cmd>call ddu#ui#do_action('itemAction', #{ name: 'narrow' })<CR>"
      \ : "<Cmd>call ddu#ui#do_action('itemAction')<CR>"
    nnoremap <buffer> q
                \ <Cmd>call ddu#ui#do_action('quit')<CR>
    nnoremap <buffer> i
                \ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
    nnoremap <buffer> p
                \ <Cmd>call ddu#ui#do_action('toggleAutoAction')<CR>
    nnoremap <buffer> <C-u>
                \ <Cmd>call ddu#ui#do_action('previewExecute', #{
                \   command: 'execute "normal! \<C-u>"'
                \ })<CR>
    nnoremap <buffer> <C-d>
                \ <Cmd>call ddu#ui#do_action('previewExecute', #{
                \   command: 'execute "normal! \<C-d>"'
                \ })<CR>
    nnoremap <buffer> A
                \ <Cmd>call ddu#ui#do_action('chooseAction')<CR>
    nnoremap <buffer> s
                \ <Cmd>call ddu#ui#do_action('itemAction', #{
                \   name: 'open',
                \     params: #{
                \       command: 'split'
                \     }
                \ })<CR>
    nnoremap <buffer> <Space>
                \ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
    nnoremap <buffer> d
                \ <Cmd>call ddu#ui#do_action('itemAction', #{ 
                \   name: 'delete'
                \ })<CR>
    nnoremap <buffer> h
                \ <Cmd>call ddu#ui#do_action('itemAction', #{
                \   name: 'narrow', params: #{ path: '..' }
                \ })<CR>
    nnoremap <buffer> l
                \ <Cmd>call ddu#ui#do_action('itemAction', #{
                \   name: 'narrow'
                \ })<CR>
    nnoremap <buffer> o
                \ <Cmd>call ddu#ui#do_action('expandItem', #{
                \   mode: 'toggle'
                \ })<CR>
    nnoremap <buffer> O
                \ <Cmd>call ddu#ui#do_action('collapseItem')<CR>
endfunction


" }}}

" hook_source {{{
call ddu#custom#load_config(expand($HOOKS_DIR .. "/ddu.ts"))
" }}}
