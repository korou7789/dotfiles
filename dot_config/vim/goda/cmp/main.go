package main

import (
    "github.com/Shougo/goda-cmp.vim/cmp"
    "github.com/Shougo/goda-cmp.vim/ext/filter/matcherhead"
    "github.com/Shougo/goda-cmp.vim/ext/source/around"
    "github.com/Shougo/goda-cmp.vim/ext/source/vim"
    "github.com/Shougo/goda-cmp.vim/ext/ui/pum"
)

func main() {
    b := cmp.New()
    b.AddUI(pum.New())
    b.AddSource(around.New(around.Params{MinLength: 2}))
    b.AddSource(vim.New())
    b.AddFilter(matcherhead.New(matcherhead.Params{}))
    b.PatchGlobal(cmp.Config{
        UI: "pum",
        Sources: []string{"around"},
        SourceOptions: map[string]cmp.SourceOption{
            "_": {Matchers: []string{"matcherhead"}},
        },
        AutoCompleteDelay: new(0),
    })
    b.PatchFiletype("vim", cmp.Config{
	Sources: []string{"vim", "around"},
    })
    b.Main()
}
