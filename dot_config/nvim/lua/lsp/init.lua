vim.diagnostic.config({ virtual_text = true })

vim.lsp.enable({
	'denols',
	'lua_ls',
    'clangd',
})
