local global_sources = {
    'lsp',
    'file',
    'denippet',
    'around',
    'buffer',
    'rg',
    'skkeleton',
    'skkeleton_okuri',
}

vim.fn["ddc#custom#patch_global"]{
    ui = 'pum',
    sources = global_sources,
}

vim.fn["ddc#custom#patch_global"]('sourceOptions', {
    _ = {
        ignoreCase = true,
        matchers = {'matcher_head', 'matcher_fuzzy'},
        sorters = {'sorter_rank', 'sorter_fuzzy'},
        converters = {
            'converter_remove_overlap',
            'converter_fuzzy',
        },
    },

    lsp = {
        mark = '[LSP]',
        isVolatile = true,
        forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
    },

    denippet = {
        mark = '[SNIP]'
    },

    file = {
        mark = '[FILE]',
        isVolatile = true,
        forceCompletionPattern = [[\S/\S*]],
    },

    buffer = {
        mark = '[BUF]'
    },

    rg = {
        mark = '[RG]',
        minAutoCompleteLength = 4,
    },

    skkeleton = {
        mark = '[SKK]',
        matchers = {},
        sorters = {},
        converters = {},
        isVolatile = true,
        minAutoCompleteLength = 1,
    },

    ["skkeleton_okuri"] = {
        mark = '[SKK*]',
        matchers = {},
        sorters = {},
        converters = {},
        isVolatile = true,
        minAutoCompleteLength = 1,
    },
})

vim.fn["ddc#custom#patch_global"]("filterParams", {
    ["matchers_fuzzy"] = {
        splitMode = "word",
    },
})

vim.fn["ddc#enable"]()
