
nnoremap <buffer> <silent> n :call NewGame2048() <Bar> call PrettyPrint() <CR>
nnoremap <buffer> <silent> <Up> :call Up2048() <Bar> call PrettyPrint() <CR>
nnoremap <buffer> <silent> <Down> :call Down2048() <Bar> call PrettyPrint() <CR>
nnoremap <buffer> <silent> <Left> :call Left2048() <Bar> call PrettyPrint() <CR>
nnoremap <buffer> <silent> <Right> :call Right2048() <Bar> call PrettyPrint() <CR>

nnoremap <buffer> <silent> h :call Left2048() <Bar> call PrettyPrint() <CR>
nnoremap <buffer> <silent> j :call Down2048() <Bar> call PrettyPrint() <CR>
nnoremap <buffer> <silent> k :call Up2048() <Bar> call PrettyPrint() <CR>
nnoremap <buffer> <silent> l :call Right2048() <Bar> call PrettyPrint() <CR>
