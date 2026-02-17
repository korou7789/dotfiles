import type {
  ContextBuilder,
  ExtOptions,
  Plugin,
} from "jsr:@shougo/dpp-vim@~5.1.0/types";
import {
  BaseConfig,
  type ConfigReturn,
} from "jsr:@shougo/dpp-vim@~5.1.0/config";
import { type Dpp } from "jsr:@shougo/dpp-vim@~5.1.0/dpp";
import { type Protocol } from "jsr:@shougo/dpp-vim@~5.1.0/protocol";
import { mergeFtplugins } from "jsr:@shougo/dpp-vim@~5.1.0/utils";
import type {
  Ext as LazyExt,
  LazyMakeStateResult,
  Params as LazyParams,
} from "jsr:@shougo/dpp-ext-lazy@~2.0.1";
import type {
  Ext as TomlExt,
  Params as TomlParams,
} from "jsr:@shougo/dpp-ext-toml@2.0.1";
import type { Denops } from "jsr:@denops/std@8.2.0";

export class Config extends BaseConfig {
  override async config(args: {
    denops: Denops;
    contextBuilder: ContextBuilder;
    basePath: string;
    dpp: Dpp;
  }): Promise<ConfigReturn> {
    args.contextBuilder.setGlobal({
      protocols: ["git"],
    });

    const [context, options] = await args.contextBuilder.get(args.denops);
    const tomlFilesDir = "~/.vim/toml/";

    const protocols = (await args.denops.dispatcher.getProtocols()) as Record<string, Protocol>;

    const recordPlugins: Record<string, Plugin> = {};
    const ftplugins: Record<string, string> = {};
    const hooksFiles: string[] = [];

    const [tomlExt, tomlOptions, tomlParams]: [
      TomlExt | undefined,
      ExtOptions,
      TomlParams,
    ] = await args.denops.dispatcher.getExt(
      "toml"
    ) as [TomlExt | undefined, ExtOptions, TomlParams];
    if (tomlExt) {
      const action = tomlExt.actions.load;

      const tomlFiles = [
        { name: "dpp.toml", lazy: false },
        { name: "colorscheme.toml", lazy: false },
        { name: "ddu.toml", lazy: true },
        { name: "ddc.toml", lazy: true },
        { name: "lazy.toml", lazy: true },
      ].map((tomlFile) =>
        action.callback({
          denops: args.denops,
          context,
          options,
          protocols,
          extOptions: tomlOptions,
          extParams: tomlParams,
          actionParams: {
            path: tomlFilesDir + tomlFile.name,
            options: {
              lazy: tomlFile.lazy,
            },
          },
        }),
      );
      const tomls = await Promise.all(tomlFiles);
      for (const toml of tomls) {
        for (const plugin of toml.plugins ?? []) {
          recordPlugins[plugin.name] = plugin;
        }
        if (toml.hooks_file) {
          hooksFiles.push(toml.hooks_file);
        }
        if (toml.ftplugins) {
            mergeFtplugins(ftplugins, toml.ftplugins);
        }
      }
    }
    
    const [lazyExt, lazyOptions, lazyParams]: [
      LazyExt | undefined,
      ExtOptions,
      LazyParams,
    ] = (await args.denops.dispatcher.getExt("lazy")) as [
      LazyExt | undefined,
      ExtOptions,
      LazyParams,
    ];
    let lazyResult: LazyMakeStateResult | undefined = undefined;

    if (lazyExt) {
      const action = lazyExt.actions.makeState;
      lazyResult = await action.callback({
        denops: args.denops,
        context,
        options,
        protocols,
        extOptions: lazyOptions,
        extParams: lazyParams,
        actionParams: { plugins: Object.values(recordPlugins) },
      });
    }
    
    return {
      ftplugins,
      hooksFiles,
      plugins: lazyResult?.plugins ?? [],
      stateLines: lazyResult?.stateLines ?? [],
    };
  }
}
