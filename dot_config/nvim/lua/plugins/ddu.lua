local function floor(v)
  return v >= 0 and v - (v % 1) or v - (v % 1) - ((v % 1) ~= 0 and 1 or 0)
end

vim.fn["ddu#custom#patch_global"]({
    uiParams = {
        ff = {
            split = "floating",
            floatingBorder = "solid",
            winHeight = 'floor(&lines * 0.8)',
            winWidth = 'floor(&columns * 0.8)',
            winRow = 'floor(&lines * 0.1)',
            winCol = 'floor(&columns * 0.1)',

            previewFloating = true,
            previewFloatingBorder = "single",
            previewSplit = 'vertical',
            previewHeight = 'floor(&lines * 0.8)',
            previewWidth = 'floor(&columns * 0.4)',
            previewRow = 'floor(&lines * 0.1)',
            previewCol = 'floor(&columns * 0.5)',

            autoAction = {
                name = "preview",
            },
        },
        filer = {
            winWidth = 40,
            split = "vertical",
            splitDirection = "bo",

            previewFloating = true,
            previewFloatingBorder = "single",

            autoAction = {
                name = "preview",
            },
        },
    },
    sourceOptions = {
        _ = {
            matchers = {
                "matcher_fzf",
            },
            sorters = {
                "sorter_fzf",
            },
            ignoreCase = true,
        },
    },
    filterParams = {
        matcher_fzf = {
            highlightMatched = "Search",
        }
    },
    kindOptions = {
        action = {
            defaultAction = "do",
        },
        ui_select = {
            defaultAction = "select",
        },
    },
})

vim.fn["ddu#custom#patch_local"]("fd", {
    ui = "ff",
    sources = {
        {
            name = "file_external",
            params = {
                cmd = {
                    "fd", ".", "-t", "f",
                },
                ignoreDirectories = {
                    ".git",
                },
            },
            options = {
                sorters = {
                    "sorter_mtime",
                    "sorter_fzf",
                },
                converters = {
                    "converter_hl_dir",
                },
            },
        },
    },
    kindOptions = {
        file = {
            defaultAction = "open",
        },
    },
})

vim.fn["ddu#custom#patch_local"]("filer", {
    ui = "filer",
    sources = {
        {
            name = "file",
            params = {},
        }
    },
    sourceOptions = {
        _ = {
            columns = {
                "icon_filename",
            },
        },
    },
    kindOptions = {
        file = {
            defaultAction = "open",
        },
    },
    uiParams = {
        filer = {
            sortTreeFirst = true,
        }
    },
    actionOptions = {
        narrow = {
            quit = false,
        },
    },
    refresh = true,
})

vim.fn["ddu#custom#patch_local"]("grep", {
    ui = "ff",
    sources = {
        {
            name = "rg",
            options = {
                matchers = {},
                volatile = true,
                ignoreCase = true,
                converters = {
                    "converter_display_word",
                    "converter_hl_dir",
                    "converter_devicon",
                },
                sorters = {
                    "sorter_mtime",
                },
            },
        },
    },
    uiParams = {
        ff = {
            ignoreEmpty = false,
        },
    },
    kindOptions = {
        file = {
            defaultAction = "open",
        },
    },
})

vim.fn["ddu#custom#patch_local"]("buffer", {
    ui = "ff",
    sources = {
        {
            name = "buffer",
            options = {
                converters = {
                    "converter_devicon",
                    "converter_hl_dir",
                },
                sorters = {
                    "sorter_mtime",
                    "sorter_fzf",
                },
            },
        },
    },
    kindOptions = {
        file = {
            defaultAction = "open",
        },
    },
})

vim.fn["ddu#custom#patch_local"]("lsp", {
    ui = "ff",
    sources = {
        {
            name = {
                "lsp_diagnostic",
            },
            params = {
                buffer = 0,
            },
        },
    },
})

vim.fn["ddu#custom#patch_local"]("help", {
    ui = "ff",
    sources = {
        {
            name = "help",
        },
    },
    kindOptions = {
        help = {
            defaultAction = "open",
        },
    },
})

vim.fn["ddu#custom#patch_local"]("line", {
    ui = "ff",
    sources = {
        {
            name = "line",
        },
    },
    kindOptions = {
        file = {
            defaultAction = "open",
        },
    },
})

vim.fn["ddu#custom#patch_local"]("source", {
    ui = "ff",
    sources = {
        {
            name = "source",
            params = {
                source_name = "line",
            },
        },
    },
    kindOptions = {
        source = {
            defaultAction = "execute",
        }
    },
})

vim.fn["ddu#custom#patch_local"]("mr", {
    ui = "ff",
    sources = {
        {
            name = "mr",
            params = {
                kind = {
                    "mrw",
                },
                matchers = {
                    "matcher_relative",
                    "matcher_fzf",
                }
            },
        },
    },
    kindOptions = {
        file = {
            defaultAction = "open",
        },
    },
})

vim.fn["ddu#custom#patch_local"]("command_history", {
    ui = "ff",
    sources = {
        name = "command_history",
    }
})

local opts = { noremap = true, silent = true, buffer = true }

vim.keymap.set("n", "<Leader>f", function() vim.fn["ddu#start"]( { name = "fd" } ) end, {noremap = true, silent = true})

vim.keymap.set("n", "<Leader>g", function() vim.fn["ddu#start"]( { name = "grep" } ) end, {noremap = true, silent = true})

vim.keymap.set("n", "<Leader>b", function() vim.fn["ddu#start"]( { name = "buffer" } ) end, {noremap = true, silent = true})

vim.keymap.set("n", "<Leader>h", function() vim.fn["ddu#start"]( { name = "help" } ) end, {noremap = true, silent = true})

vim.keymap.set("n", "<Leader>l", function() vim.fn["ddu#start"]( { name = "lsp" } ) end, {noremap = true, silent = true})

vim.keymap.set("n", "<Leader>t", function() vim.fn["ddu#start"]( { name = "line" } ) end, {noremap = true, silent = true})

vim.keymap.set("n", "<Leader>m", function() vim.fn["ddu#start"]( { name = "mr" } ) end, {noremap = true, silent = true})

vim.keymap.set("n", "<Leader>s", function() vim.fn["ddu#start"]( { name = "source" } ) end, {noremap = true, silent = true})


vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-ff",
    callback = function()
    vim.keymap.set({"n"}, "q", [[<Cmd>call ddu#ui#async_action("quit")<CR>]], opts)
    vim.keymap.set({"n"}, "<CR>", [[<Cmd>call ddu#ui#async_action("itemAction")<CR>]], opts)
    vim.keymap.set({"n"}, "i", [[<Cmd>call ddu#ui#async_action("openFilterWindow")<CR>]], opts)
    vim.keymap.set({"n"}, "p", [[<Cmd>call ddu#ui#async_action("toggleAutoAction")<CR>]], opts)
    vim.keymap.set({"n"}, "a", function() vim.fn["ddu#ui#async_action"]("chooseAction") end, opts)

    vim.keymap.set({"n"}, "<C-p>", [[<Cmd>call ddu#ui#do_action('previewExecute', #{ command: 'execute "normal! \<C-u>"' })<CR>]], opts)
    vim.keymap.set({"n"}, "<C-n>", [[<Cmd>call ddu#ui#do_action('previewExecute', #{ command: 'execute "normal! \<C-d>"' })<CR>]], opts)

    vim.keymap.set({"n"}, "<Tab>", function() vim.fn["ddu#ui#do_action"]("toggleSelectItem") end, opts)
    end,
})

vim.keymap.set("n", "<Leader>F", function()
vim.fn["ddu#start"]( { name = "filer" } ) end, { noremap = true })

vim.api.nvim_create_autocmd("FileType", {
        pattern = "ddu-filer",
        callback = function()
        vim.keymap.set({"n"}, "q", function() vim.fn["ddu#ui#do_action"]("quit") end, opts)

        vim.keymap.set({"n"}, "<CR>", function()
                if not vim.fn["ddu#ui#get_item"]().isTree then
                    vim.fn["ddu#ui#do_action"]("itemAction")
                end
            end, opts)

        vim.keymap.set({"n"}, "p", [[<Cmd>call ddu#ui#do_action("toggleAutoAction")<CR>]], opts)
        vim.keymap.set({"n"}, "h", function() vim.fn["ddu#ui#async_action"]("itemAction", { name = "narrow", params = { path = ".." } } ) end, opts)
        vim.keymap.set({"n"}, "l", function() vim.fn["ddu#ui#async_action"]("itemAction", { name = "narrow" }) end, opts)
        vim.keymap.set({"n"}, "o", function() vim.fn["ddu#ui#async_action"]("expandItem", { mode = "toggle" }) end, opts)
        vim.keymap.set({"n"}, "i", function() vim.fn["ddu#ui#do_action"]("openFilterWindow") end, opts)
        vim.keymap.set({"n"}, "n", function() vim.fn["ddu#ui#do_action"]("itemAction", { name = "newFile" }) end, opts)
        vim.keymap.set({"n"}, "N", function() vim.fn["ddu#ui#do_action"]("itemAction", { name = "newDirectory" }) end, opts)
        vim.keymap.set({"n"}, "r", function() vim.fn["ddu#ui#do_action"]("itemAction", { name = "rename" }) end, opts)
        vim.keymap.set({"n"}, "d", function() vim.fn["ddu#ui#do_action"]("itemAction", { name = "delete" }) end, opts)
        vim.keymap.set({"n"}, "a", function() vim.fn["ddu#ui#do_action"]("chooseAction") end, opts)

        vim.keymap.set({"n"}, "<Tab>", function() vim.fn["ddu#ui#do_action"]("toggleSelectItem") end, opts)
    end,
})
