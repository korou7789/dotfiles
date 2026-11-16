package main

import (
    "github.com/Shougo/goda-term.vim/term"
    "github.com/Shougo/goda-term.vim/ext/ui/shell"
)

func main() {
    b := term.New()
    b.AddUI(shell.New())
    b.PatchGlobal(term.Options{
        UIParams: map[string]term.Params{
            "shell": {
                "split": "horizontal",
                "startInsert": true,
                "shellHistoryPath": "~/.cache/goda-term-shell-history",
            },
        },
    })
    b.Main()
}
