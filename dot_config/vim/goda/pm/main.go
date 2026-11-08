package main

import (
    "context"

    "github.com/Shougo/goda-pm.vim/ext/installer"
    "github.com/Shougo/goda-pm.vim/ext/protocol/git"
    "github.com/Shougo/goda-pm.vim/ext/toml"
    "github.com/Shougo/goda-pm.vim/pm"
)

func main() {
    b := pm.New()
    b.AddProtocol(git.New())
    b.AddExt(installer.New())
    b.SetConfig(config)
    b.Main()
}

func config(ctx context.Context, c *pm.ConfigArgs) (*pm.ConfigReturn, error) {
    file := "$BASE_DIR/plugins.toml"
    t, err := toml.Load(ctx, c.Host, file, nil)
    if err != nil {
        return nil, err
    }
    expanded, err := c.Expand(ctx, file)
    if err != nil {
        return nil, err
    }
    return &pm.ConfigReturn{
        Plugins: t.Plugins,
	CheckFiles: []string{expanded},
    }, nil
}
