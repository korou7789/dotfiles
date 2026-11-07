package main

import (
    "github.com/Shougo/goda-fi.vim/fi"
    "github.com/Shougo/goda-fi.vim/ui/ff"
    "github.com/Shougo/goda-fi.vim/ui/filer"
    "github.com/Shougo/goda-fi.vim/ext/source/file"
    "github.com/Shougo/goda-fi.vim/ext/source/filerec"
    "github.com/Shougo/goda-fi.vim/ext/filter/matchersubstring"
    kindfile "github.com/Shougo/goda-fi.vim/ext/kind/file"
    "github.com/Shougo/goda-fi.vim/ext/column/filename"
)

func main() {
    b := fi.New()
    b.AddUI(ff.New())
    b.AddUI(filer.New())
    b.AddSource(file.New(file.Params{}))
    b.AddSource(filerec.New(filerec.Params{}))
    b.AddFilter(matchersubstring.New(matchersubstring.Params{}))
    b.AddKind(kindfile.New())
    b.AddColumn(filename.New(filename.DefaultParams()))

    b.PatchGlobal(fi.Options{
        UI: "ff",
        SourceOptions: map[string]fi.SourceOptions{
            "_": {Matchers: []string{"matchersubstring"}},
        },
        KindOptions: map[string]fi.KindOptions{
            "file": {DefaultAction: "open"},
        },
    })
    b.PatchLocal("filer", fi.Options{
        UI: "filer",
        Sources: fi.Sources("file"),
        SourceOptions: map[string]fi.SourceOptions{
            "file": {Columns: []string{"filename"}},
        },
        UIParams: map[string]fi.Params{
            "filer": {"sort": "filename", "sortTreesFirst": true},
        },
        ActionOptions: map[string]fi.ActionOptions{
            "narrow": {Quit: new(false)},
        },
    })
    b.PatchLocal("files", fi.Options{UI: "ff", Sources: fi.Sources("filerec")})
    b.Main()
}
