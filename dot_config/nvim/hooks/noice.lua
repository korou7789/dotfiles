--- lua_source {{{

require("noice").setup({
    cmdline = {
        enabled = true,
        view = "cmdline"
    },
    lsp = {
        progress = {
            enabled = false,
        },
    },
    messages = {
        view = "split",
    },
})

--- }}}
