
if exists("b:current_syntax")
    finish
endif

syntax keyword keyword2048 2048 board

syntax keyword function2048 UP DOWN LEFT RIGHT

highlight link keyword2048 Keyword
highlight link function2048 Function

let b:current_syntax = "2048"
