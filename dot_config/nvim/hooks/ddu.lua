--- lua_add {{{
local maps = {
    n = {
        ["<leader>f"] = function() vim.fn["ddu#start"]({ name = "file_recursive" }) end,
        ["<leader>e"] = function() vim.fn["ddu#start"]({ name = "fd" }) end,
        ["<Leader>g"] = function() vim.fn["ddu#start"]( { name = "grep" } ) end,
        ["<Leader>b"] = function() vim.fn["ddu#start"]( { name = "buffer" } ) end,
        ["<Leader>h"] = function() vim.fn["ddu#start"]( { name = "help" } ) end,
        ["<Leader>l"] = function() vim.fn["ddu#start"]( { name = "lsp" } ) end,
        ["<Leader>t"] = function() vim.fn["ddu#start"]( { name = "line" } ) end,
        ["<Leader>m"] = function() vim.fn["ddu#start"]( { name = "mr" } ) end,

        ["<Leader>F"] = function() vim.fn["ddu#start"]( { name = "filer" } ) end,
    }
}

for mode, mode_maps in pairs(maps) do
    for lhs, rhs in pairs(mode_maps) do
        vim.keymap.set(mode , lhs, rhs, {noremap = true, silent = true})
    end
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-ff",
    callback = function()
        vim.opt_local.cursorline = true
        local maps = {
            n = {
                ["<CR>"] = function() vim.fn["ddu#ui#async_action"]("itemAction") end,
                ["q"] = function() vim.fn["ddu#ui#async_action"]("quit") end,
                ["i"] = function() vim.fn["ddu#ui#async_action"]("openFilterWindow") end,
                ["p"] = function() vim.fn["ddu#ui#async_action"]("toggleAutoAction") end,
                ["a"] = function() vim.fn["ddu#ui#async_action"]("chooseAction") end,
                ["<Tab>"] = function() vim.fn["ddu#ui#async_action"]("toggleSelectItem") end,

                ["<C-u>"] = function() vim.fn["ddu#ui#async_action"]("previewExecute", { command = [[execute "normal! \<C-u>"]] }) end,
                ["<C-d>"] = function() vim.fn["ddu#ui#async_action"]("previewExecute", { command = [[execute "normal! \<C-d>"]] }) end,

                ["c"] = function()
                    vim.fn["ddu#ui#do_action"]("updateOptions", { sources = { { name = "source" } } })
                    vim.fn["ddu#ui#do_action"]("redraw", { params = "refreshItems" })
                end,
            },
        }
        for mode, mode_maps in pairs(maps) do
            for lhs, rhs in pairs(mode_maps) do
                vim.keymap.set(mode , lhs, rhs, {noremap = true, silent = true, buffer = true})
            end
        end
    end
})


vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-filer",
        callback = function()
        vim.opt_local.cursorline = true
        local maps = {
            n = {
                ["<CR>"] = function()
                    if not vim.fn["ddu#ui#get_item"]().isTree then
                        vim.fn["ddu#ui#do_action"]("itemAction")
                    end
                end,
                ["q"] = function() vim.fn["ddu#ui#async_action"]("quit") end,
                ["i"] = function() vim.fn["ddu#ui#async_action"]("openFilterWindow") end,
                ["p"] = function() vim.fn["ddu#ui#async_action"]("toggleAutoAction") end,
                ["a"] = function() vim.fn["ddu#ui#async_action"]("chooseAction") end,
                ["<Tab>"] = function() vim.fn["ddu#ui#async_action"]("toggleSelectItem") end,
                ["<C-p>"] = function() vim.fn["ddu#ui#async_action"]("previewExecute", { command = [[execute "normal! \<C-u>"]] }) end,
                ["<C-n>"] = function() vim.fn["ddu#ui#async_action"]("previewExecute", { command = [[execute "normal! \<C-d>"]] }) end,

                ["h"] = function() vim.fn["ddu#ui#async_action"]("itemAction", { name = "narrow", params = { path = ".." } } ) end,
                ["l"] = function() vim.fn["ddu#ui#async_action"]("itemAction", { name = "narrow" }) end,
                ["o"] = function() vim.fn["ddu#ui#async_action"]("expandItem", { mode = "toggle" }) end,
                ["n"] = function() vim.fn["ddu#ui#async_action"]("itemAction", { name = "newFile" }) end,
                ["N"] = function() vim.fn["ddu#ui#async_action"]("itemAction", { name = "newDirectory" }) end,
                ["r"] = function() vim.fn["ddu#ui#async_action"]("itemAction", { name = "rename" }) end,
                ["d"] = function() vim.fn["ddu#ui#async_action"]("itemAction", { name = "delete" }) end,
            },
        }
        for mode, mode_maps in pairs(maps) do
            for lhs, rhs in pairs(mode_maps) do
                vim.keymap.set(mode , lhs, rhs, {noremap = true, silent = true, buffer = true})
            end
        end
    end,
})

--- }}}

--- lua_source {{{

vim.fn["ddu#custom#load_config"](vim.env.HOOKS_DIR .. "/ddu.ts")

--- }}}
