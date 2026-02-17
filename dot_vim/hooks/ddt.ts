import {
    BaseConfig,
    type ConfigArguments
} from "jsr:@shougo/ddt-vim@~2.0.0/config"

export class Config extends BaseConfig {
    override async config(args: ConfigArguments): Promise<void> {
        args.contextBuilder.patchGlobal({
            uiParams: {
                terminal: {
                    command: ["bash"],
                    promptPattern: "\\w*% \\?",
                },
            },
        });
    }
}
