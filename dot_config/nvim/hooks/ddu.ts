import {
    BaseConfig,
    type ConfigArguments,
} from "jsr:@shougo/ddu-vim@~9.4.0/config";
import type { Denops } from "jsr:@denops/std";

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
                    floatingBorder: "rounded",
                    winCol: "(&columns / 8)",
                    winRow: "(&lines / 8)",
                    winWidth: "(&columns - (&columns / 4))",
                    winHeight: "(&lines - (&lines / 4))",
                    
                    
                    previewFloating: true,
                    previewFloatingBorder: "rounded",
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
                    converters: ["converter_hl_dir", "converter_devicon"],
                    smartCase: true,
                },
                file: {
                    columns: ["icon_filename"],
                },
            },
            filterParams: {
                matcher_fzf: {
                    highlightMatched: "Search",
                },
            },
            sourceParams: {
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
                source: {
                    defaultAction: "execute",
                },
            },
            actionOptions: {
                narrow: {
                    quit: false,
                },
            },
        })
        args.contextBuilder.patchLocal("file_recursive", {
            sources: [{
                name: "file_rec",
                params: {
                    ignoreDirectories: [
                        ".git",
                    ],
                },
                options: {
                    sorters: [
                        "sorter_mtime",
                    ],
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
                options: {
                    converters: [],
                },
                params: {},
            }],
        })
        args.contextBuilder.patchLocal("grep", {
            sources: [{
                name: "rg",
                options: {
                    matchers: ["converter_display_word", "matcher_fzf"],
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
                options: {
                    converters: ["converter_relativepath"],
                },
            }],
        })
        args.contextBuilder.patchLocal("source", {
            sources: [{
                name: "source",
            }],
        })
        args.contextBuilder.patchLocal("dpp", {
            sources: [{
                name: "dpp",
            }]
        })
        args.contextBuilder.patchLocal("fd", {
            sources: [{
                name: "file_external",
                params: {
                    cmd: ['fd', '.', '-H', '-E', '__pycache__', '-t', 'f'],
                },
                options: {
                    sorters: [
                        "sorter_mtime",
                    ],
                },
            }],
        })
    }
}
