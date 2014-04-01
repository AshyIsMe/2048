
nnoremap <buffer> <silent> n :NewGame2048 <CR>
nnoremap <buffer> <silent> <Up> :call game2048#Up() <Bar> call game2048#PrettyPrint() <CR>
nnoremap <buffer> <silent> <Down> :call game2048#Down() <Bar> call game2048#PrettyPrint() <CR>
nnoremap <buffer> <silent> <Left> :call game2048#Left() <Bar> call game2048#PrettyPrint() <CR>
nnoremap <buffer> <silent> <Right> :call game2048#Right() <Bar> call game2048#PrettyPrint() <CR>

nnoremap <buffer> <silent> h :call game2048#Left() <Bar> call game2048#PrettyPrint() <CR>
nnoremap <buffer> <silent> j :call game2048#Down() <Bar> call game2048#PrettyPrint() <CR>
nnoremap <buffer> <silent> k :call game2048#Up() <Bar> call game2048#PrettyPrint() <CR>
nnoremap <buffer> <silent> l :call game2048#Right() <Bar> call game2048#PrettyPrint() <CR>
