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
                },
                filer: {
                },
            },
            sourceOptions: {
                _: {
                    ignoreCase: true,
                    smartCase: true,
		    matchers: ["matcher_substring"],
                },
                file: {
                },
                file_rec: {
                    sorters: ["sorter_mtime"],
                },
            },
            kindOptions: {
                action: {
                    defaultAction: "do",
                },
                file: {
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
