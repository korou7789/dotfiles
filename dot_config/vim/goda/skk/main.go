package main

import "github.com/Shougo/goda-skk.vim/engine"

func main() {
    engine.Main(engine.Config{
        Dictionaries: []engine.Dictionary{
            engine.NewJisyo("/usr/share/skk/SKK-JISYO.L", ""),
        },
        EggLikeNewline: true,
    })
}
