
if exists("b:current_syntax")
    finish
endif

syntax keyword keyword2048 2048 board
highlight link keyword2048 Keyword

let b:current_syntax = "2048"
