import {
    BaseConfig,
    type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~9.4.0/config";

export class Config extends BaseConfig {
    override config(args: ConfigArguments) {
        args.contextBuilder.patchGlobal({
            ui: "ff",
            uiParams: {
                ff: {
                    autoAction: {
                        name: "preview",
                    },

                    split: "floating",
                    floatingBorder: "single",
                    winCol: "(&columns / 8)",
                    winRow: "(&lines / 8)",
                    winWidth: "(&columns - (&columns / 4))",
                    winHeight: "(&lines - (&lines / 4))",
                    
                    
                    previewFloating: true,
                    previewFloatingBorder: "single",
                    previewSplit: "vertical",
                    previewWindowOptions: [
                        ["&signcolumn", "no"],
                        ["&foldcolumn", 0],
                        ["&foldenable", 0],
                        ["&number", 0],
                        ["&relativenumber", 0],
                        ["&wrap", 0],
                    ],
                    previewCol: "(&columns / 2)",
                    previewRow: "(&lines / 8)",
                    previewWidth: "((&columns) - (&columns / 4)) / 2",
                    previewHeight: "(&lines - (&lines / 4))",
                },
                filer: {
                    autoAction: {
                        name: "preview",
                    },
                    sortTreeFirst: true,

                    winWidth: 40,
                    split: "vertical",
                    splitDirection: "bo",

                    previewFloating: true,
                    previewFloatingBorder: "single",
                },
            },
            sourceOptions: {
                _: {
                    ignoreCase: true,
                    matchers: ["matcher_fzf"],
                    sorters: ["sorter_fzf"],
                    smartCase: true,
                },
                file: {
                    columns: ["filename"],
                },
            },
            filterParams: {
                matcher_fzf: {
                    highlightMatched: "Search",
                },
            },
            sourceParams: {
                file_external: {
                    ignoreDirectories: [
                        ".git",
                    ],
                },
            },
            kindOptions: {
                action: {
                    defaultAction: "do",
                },
                file: {
                    defaultAction: "open",
                },
                help: {
                    defaultAction: "open",
                },
                ui_select: {
                    defaultAction: "select",
                },
                command_history: {
                    defaultAction: "execute",
                },
            },
            actionOptions: {
                narrow: {
                    quit: false,
                },
            },
        })
        args.contextBuilder.patchLocal("fd", {
            sources: [{
                name: "file_external",
                params: {
                    cmd: [
                        "fd", 
                        "--hidden",
                        "--type",
                        "f",
                        "--color",
                        "never",
                        "--glob",
                    ],
                    options: {
                        sorters: [
                            "sorter_mtime",
                            "sorter_fzf",
                        ],
                        converters: [
                            "converter_hl_dir",
                        ],
                    },
                },
            }],
            kindOptions: {
                file: {
                    defaultAction: "open",
                }
            }
        })
        args.contextBuilder.patchLocal("filer", {
            ui: "filer",
            sources: [{
                name: "file",
                params: {},
            }],
        })
        args.contextBuilder.patchLocal("grep", {
            sources: [{
                name: "rg",
                options: {
                    matchers: [],
                    volatile: true,
                },
                params: {
                    args: [
                        "--column", "--no-heading", "--color", "never",
                    ],
                },
            }],
        })
        args.contextBuilder.patchLocal("buffer", {
            sources: [{
                name: "buffer",
            }],
        })
        args.contextBuilder.patchLocal("help", {
            sources: [{
                name: "help",
            }],
        })
        args.contextBuilder.patchLocal("mr", {
            sources: [{
                name: "mr",
            }],
        })
    }
}
