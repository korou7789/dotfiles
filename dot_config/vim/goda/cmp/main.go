package main

import (
	"github.com/Shougo/goda-cmp.vim/cmp"
	"github.com/Shougo/goda-cmp.vim/ext/filter/matcherhead"
	"github.com/Shougo/goda-cmp.vim/ext/filter/sortertext"
	"github.com/Shougo/goda-cmp.vim/ext/source/around"
	"github.com/Shougo/goda-cmp.vim/ext/source/lsp"
	"github.com/Shougo/goda-cmp.vim/ext/source/vim"
	"github.com/Shougo/goda-cmp.vim/ext/source/cmdline"
	"github.com/Shougo/goda-cmp.vim/ext/source/cmdlinehistory"
	"github.com/Shougo/goda-cmp.vim/ext/ui/pum"
)

func main() {
    b := cmp.New()
    b.AddUI(pum.New())
    b.AddSource(around.New(around.Params{MinLength: 2}))
    b.AddSource(vim.New())
    b.AddSource(cmdline.New())
    b.AddSource(cmdlinehistory.New(cmdlinehistory.Params{}))
    b.AddSource(lsp.New(lsp.Params{
	Name: "gopls",
	Command: []string{"gopls"},
	Filetypes: []string{"go"},
	RootMarkers: []string{"go.work", "go.mod", ".git"},
    }))
    b.AddFilter(matcherhead.New(matcherhead.Params{}))
    b.AddFilter(sortertext.New())
    b.PatchGlobal(cmp.Config{
        UI: "pum",
        Sources: []string{"around"},
	CmdlineSources: map[string][]string{
		":": {"cmdline", "cmdlinehistory"},
	},
        SourceOptions: map[string]cmp.SourceOption{
            "_": {Matchers: []string{"matcherhead"}},
	    "cmdline": {Mark: "cmdline"},
	    "cmdlinehistory": {Mark: "history"},
        },
        AutoCompleteDelay: new(0),
    })
    b.PatchFiletype("vim", cmp.Config{
	Sources: []string{"vim", "around"},
    })
    b.PatchFiletype("go", cmp.Config{
	Sources: []string{"gopls", "around"},
	SourceOptions: map[string]cmp.SourceOption{
		"gopls": {
			Mark: "LSP",
			Matchers: []string{},
			Sorters: []string{"sortertext"},
			ForceCompletionPattern: `\.\w*`,
		},
	},
    })
    b.Main()
}

