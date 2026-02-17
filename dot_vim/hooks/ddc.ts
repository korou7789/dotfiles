import {
    BaseConfig,
    type ConfigArguments,
} from "jsr:@shougo/ddc-vim@10.1.0/config";

export class Config extends BaseConfig {
    override async config(args: ConfigArguments): Promise<void> {

        args.contextBuilder.patchGlobal({
            ui: "pum",
            sources: [
                "around",
                "file",
            ],
            sourceOptions: {
                _: {
                    ignoreCase: true,
                    matchers: ["matcher_fuzzy"],
                    sorters: ["sorter_fuzzy"],
                    converters: ["converter_fuzzy"],
                },
                file: {
                    mark: "FILE",
                    isVolatile: true,
                    forceCompletionPattern: String.raw`\S/\S*`,
                },
	    }
        });
    }
}
