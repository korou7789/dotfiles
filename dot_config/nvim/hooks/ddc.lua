--- lua_source {{{

vim.fn["ddc#custom#load_config"](vim.env.HOOKS_DIR .. "/ddc.ts")

vim.fn["ddc#enable_terminal_completion"]()
vim.fn["ddc#enable"]()

-- pum
vim.fn["pum#set_option"]{
    border = 'single',
    max_height = 20,
    preview = true,
}

vim.keymap.set({ "i", "t" }, "<C-n>", function() vim.fn["pum#map#insert_relative"](1, "loop") end)
vim.keymap.set({ "i", "t" }, "<C-p>", function() vim.fn["pum#map#insert_relative"](-1, "loop") end)
vim.keymap.set({"i", "t" }, "<C-y>", function () vim.fn["pum#map#confirm"]() end)

vim.api.nvim_create_user_command("CommandlinePre", function()
    vim.keymap.set("c", "<C-n>", function() vim.fn["pum#map#insert_relative"](1, "loop") end)
    vim.keymap.set("c", "<C-p>", function() vim.fn["pum#map#insert_relative"](-1, "loop") end)
    vim.keymap.set("c", "<C-y>", function () vim.fn["pum#map#confirm"]() end)
    vim.api.nvim_create_autocmd("User", {
        pattern = "DDCCmdlineLeave",
        once = true,
        callback = function()
            vim.keymap.del("c", "<C-n>")
            vim.keymap.del("c", "<C-p>")
            vim.keymap.del("c", "<C-y>")
        end,
    })
    vim.fn["ddc#enable_cmdline_completion"]()
end, {})

vim.keymap.set("n", ":", [[<Cmd>CommandlinePre<CR>:]])
vim.keymap.set("n", "/", [[<Cmd>CommandlinePre<CR>/]])
vim.keymap.set("n", "?", [[<Cmd>CommandlinePre<CR>?]])

--- }}}

--- lua_post_source {{{

vim.lsp.config("*", {
    capabilities = require("ddc_source_lsp").make_client_capabilities(),
})

--- }}}
