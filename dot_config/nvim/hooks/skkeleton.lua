--- lua_add {{{
vim.keymap.set({"i", "c", "t"}, "<C-j>", "<Plug>(skkeleton-toggle)")
--- }}}

--- lua_source {{{
vim.fn["skkeleton#config"]({
    globalDictionaries = {
        "~/.skk/SKK-JISYO.L",
    },
    eggLikeNewline = true,
    markerHenkan = "",
    markerHenkanSelect = "",
})
vim.fn["skkeleton#register_kanatable"]("rom", {
    jj = "escape",
})

local prev_buffer_config = nil

local function skkeleton_pre()
    prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()
    vim.fn["ddc#custom#patch_buffer"]("sources", {
        "skkeleton",
    })
end

local function skkeleton_post()
    if prev_buffer_config then
        vim.fn["ddc#custom#set_buffer"](prev_buffer_config)
        prev_buffer_config = nil
    end
end

vim.api.nvim_create_autocmd("User", {
    pattern = "skkeleton-enable-pre",
    callback = function()
        skkeleton_pre()
    end,
})

vim.api.nvim_create_autocmd("User", {
    pattern = "skkeleton-disable-pre",
    callback = function ()
        skkeleton_post()
    end,
})

--- }}}
