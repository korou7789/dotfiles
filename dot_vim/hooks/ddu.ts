import {
    BaseConfig,
    type ConfigArguments,
} from "jsr:@shougo/ddu-vim@11.1.0/config";

export class Config extends BaseConfig {
    override config(args: ConfigArguments) {
        args.contextBuilder.patchGlobal({
            ui: "ff",
            uiParams: {
                ff: {
                    autoAction: {
                        name: 'preview'
                    },
                    sync: false,
                    previewSplit: "vertical",
                },
                filer: {
                    autoAction: {
                        name: 'preview'
                    },
                    sortTreesFirst: true,
                    previewSplit: "no",
                    toggle: true,
                },
            },
            sourceOptions: {
                _: {
                    ignoreCase: true,
                    smartCase: true,
		    matchers: ["matcher_substring"],
                },
                file: {
                    columns: ['filename'],
                },
                file_rec: {
                    sorters: ["sorter_mtime"],
                },
                file_external: {
                    sorters: ["sorter_mtime"],
                }
            },
            kindOptions: {
                action: {
                    defaultAction: "do",
                },
                file: {
                    defaultAction: "open",
                },
                ddt_tab: {
                    defaultAction: "switch",
                },
                source: {
                    defaultAction: "execute",
                },
                help: {
                    defaultAction: "open",
                },
            },
            actionOptions: {
                narrow: {
                    quit: false,
                },
            },
        })
    }
}
