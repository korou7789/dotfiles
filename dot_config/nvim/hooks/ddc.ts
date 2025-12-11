import {
    BaseConfig,
    type ConfigArguments,
} from "jsr:@shougo/ddc-vim@10.1.0/config";

export class Config extends BaseConfig {
    override async config(args: ConfigArguments): Promise<void> {

        args.contextBuilder.patchGlobal({
            ui: "pum",
            sources: [
                "lsp",
                "denippet",
                "around",
                "rg",
                "file",
                "skkeleton",
                "skkeleton_okuri",
            ],
            autoCompleteEvents: [
                "CmdlineChanged",
                "CmdlineEnter",
                "InsertEnter",
                "TextChangedI",
                "TextChangedP",
                "TextChangedT",
            ],
            cmdlineSources: {
                ":": ["cmdline", "cmdline_history", "around"],
                "/": ["around"],
                "?": ["around"],
            },
            sourceOptions: {
                _: {
                    ignoreCase: true,
                    matchers: ["matcher_fuzzy"],
                    sorters: ["sorter_fuzzy"],
                    converters: ["converter_remove_overlap", "converter_fuzzy"],
                },
                lsp: {
                    mark: "[LSP]",
                    isVolatile: true,
                    forceCompletionPattern: String.raw`\.\w*|::\w*|->\w*`,
                },
                denippet: {
                    mark: "[SNIP]",
                },
                file: {
                    mark: "[FILE]",
                    isVolatile: true,
                    forceCompletionPattern: String.raw`\S/\S*`,
                },
                buffer: {
                    mark: "[BUF]",
                },
                rg: {
                    mark: "[RG]",
                    minAutoCompleteLength: 4,
                },
                cmdline: {
                    mark: "[CMD]",
                    forceCompletionPattern: String.raw`\\S/\\S*|\\.\\w*`,
                    dup: "force",
                },
                cmdline_history: {
                    mark: "[HIST]",
                    sorters: [],
                },
                skkeleton: {
                    mark: "[SKK]",
                    isVolatile: true,
                    minAutoCompleteLength: 1,
                    matchers: [],
                    sorters: [],
                    converters: [],
                },
                skkeleton_okuri: {
                    mark: "[SKK*]",
                    isVolatile: true,
                    minAutoCompleteLength: 1,
                    matchers: [],
                    sorters: [],
                    converters: [],
                },
            },
            filterParams: {
                matcher_fuzzy: {
                    splitMode: "word",
                },
            },
        });
    }
}
