local function floor(v)
  return v >= 0 and v - (v % 1) or v - (v % 1) - ((v % 1) ~= 0 and 1 or 0)
end

vim.fn["ddu#custom#patch_global"]({
    uiParams = {
        ff = {
            -- winHeight = 20,
            -- split = "horizontal",

            -- previewFloating = true,
            -- previewFloatingBorder = "rounded",

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
