"This is a game of 2048 in vim just for fun.
"
"board is an array of 16 ints arranged like:
"[ 0,  1,  2,  3
"  4,  5,  6,  7
"  8,  9, 10, 11
" 12, 13, 14, 15 ]

"AA TODO: change hard coded boardsize of 16 to any number with a whole square
"root


function! game2048#New()
  let board = repeat([0], 4 * 4)
  let board = game2048#AddRandTile(l:board)
  let board = game2048#AddRandTile(l:board)

  exe ":tabnew"
  set filetype=2048

  let failed = append(line('$'), "New game of 2048!")
  let failed = append(line('$'), "2048 board: " . string(l:board))

  call game2048#PrettyPrint()

  return l:board
endfunction

function! game2048#Up()
  call append(line('$'), 'UP')
  call append(line('$'), '')
  call cursor(line('$'),0)
  let last = search('^2048 board', 'b')
  if l:last == 0
    return 0
  endif
  let boardstring = getline(l:last)[12:]
  if game2048#IsGameOver(l:boardstring)
    return 0
  endif
  let b = eval(boardstring)
  let newBoard = []

  let newCols = []  "build up the list in column first order
  for i in range(0,3)
    let col = [l:b[l:i]] + [l:b[l:i+4]] + [l:b[l:i+8]] + [l:b[l:i+12]]
    let col = filter(l:col, 'v:val != 0')
    if len(l:col) > 1
      for j in range(0, len(l:col) - 2, 1)
        if l:col[l:j] == l:col[l:j+1]
          let l:col[l:j] = l:col[l:j] * 2
          let l:col[l:j+1] = 0
        endif
      endfor
    endif

    let col = filter(l:col, 'v:val != 0')
    let col = extend(l:col, repeat([0], 4-len(l:col)))
    let newCols = extend(newCols, l:col)
  endfor

  "now transpose newCols back into row first order
  for i in range(0, 3)
    let newBoard = extend(newBoard, [l:newCols[l:i]] + [l:newCols[l:i+4]] + [l:newCols[l:i+8]] + [l:newCols[l:i+12]])
  endfor

  "let newBoard = game2048#TransposeBoard(b, 'l')
  "let failed = append(line('$'), "trans left: " . string(l:newBoard))
  "call game2048#PrintBoard(l:newBoard)
  "let newBoard = game2048#ShiftBoard(b, 'l')
  "let failed = append(line('$'), "shift left: " . string(l:newBoard))
  "call game2048#PrintBoard(l:newBoard)
  "let newBoard = game2048#TransposeBoard(b, 'r')
  "let failed = append(line('$'), "trans right " . string(l:newBoard))
  "call game2048#PrintBoard(l:newBoard)

  "Check if we've won
  if game2048#IsGameWon(l:newBoard)
    let failed = append(line('$'), "!!! YOU WIN !!!")
    let failed = append(line('$'), "Press n to start a new game")
    let failed = append(line('$'), "2048 board: " . string(l:newBoard))
  else
    "now add a new tile if able
    let newBoard = game2048#AddRandTile(l:newBoard)
    let failed = append(line('$'), "2048 board: " . string(l:newBoard))
  endif

  return l:newBoard
endfunction


function! game2048#Down()
  call append(line('$'), 'DOWN')
  call append(line('$'), '')
  call cursor(line('$'),0)
  let last = search('^2048 board', 'b')
  if l:last == 0
    return 0
  endif
  let boardstring = getline(l:last)[12:]
  if game2048#IsGameOver(l:boardstring)
    return 0
  endif
  let b = eval(boardstring)
  let newBoard = []

  let newCols = []  "build up the list in column first order
  for i in range(0,3)
    let col = [l:b[l:i]] + [l:b[l:i+4]] + [l:b[l:i+8]] + [l:b[l:i+12]]
    let col = filter(l:col, 'v:val != 0')
    if len(l:col) > 1
      for i in range(len(l:col) - 1,1, -1)
        if l:col[l:i] == l:col[l:i-1]
          let l:col[l:i] = l:col[l:i] * 2
          let l:col[l:i-1] = 0
        endif
      endfor
    endif

    let col = filter(l:col, 'v:val != 0')
    let col = extend(repeat([0], 4-len(l:col)), l:col)
    let newCols = extend(newCols, l:col)
  endfor

  "now transpose newCols back into row first order
  for i in range(0, 3)
    let newBoard = extend(newBoard, [l:newCols[l:i]] + [l:newCols[l:i+4]] + [l:newCols[l:i+8]] + [l:newCols[l:i+12]])
  endfor

  "Check if we've won
  if game2048#IsGameWon(l:newBoard)
    let failed = append(line('$'), "!!! YOU WIN !!!")
    let failed = append(line('$'), "Press n to start a new game")
    let failed = append(line('$'), "2048 board: " . string(l:newBoard))
  else
    "now add a new tile if able
    let newBoard = game2048#AddRandTile(l:newBoard)
    let failed = append(line('$'), "2048 board: " . string(l:newBoard))
  endif


  return l:newBoard
endfunction

function! game2048#Left()
  call append(line('$'), 'LEFT')
  call append(line('$'), '')
  call cursor(line('$'),0)
  let last = search('^2048 board', 'b')
  if l:last == 0
    return 0
  endif
  let boardstring = getline(l:last)[12:]
  if game2048#IsGameOver(l:boardstring)
    return 0
  endif
  let b = eval(boardstring)
  let newBoard = []

  "for i in range(0,12,4)
    "let row = filter(l:b[(l:i):(l:i+3)], 'v:val != 0')
    "if len(l:row) > 1
      "for i in range(0, len(l:row) - 2, 1)
        "if l:row[l:i] == l:row[l:i+1]
          "let l:row[l:i] = l:row[l:i] * 2
          "let l:row[l:i+1] = 0
        "endif
      "endfor
    "endif
    "let row = filter(l:row, 'v:val != 0')
    "let row = extend(l:row, repeat([0], 4-len(l:row)))
    "let newBoard = extend(newBoard, l:row)
  "endfor

  let newBoard = game2048#ShiftBoard(b, 'l')

  "Check if we've won
  if game2048#IsGameWon(l:newBoard)
    let failed = append(line('$'), "!!! YOU WIN !!!")
    let failed = append(line('$'), "Press n to start a new game")
    let failed = append(line('$'), "2048 board: " . string(l:newBoard))
  else
    "now add a new tile if able
    let newBoard = game2048#AddRandTile(l:newBoard)
    let failed = append(line('$'), "2048 board: " . string(l:newBoard))
  endif

  return l:newBoard
endfunction

function! game2048#Right()
  call append(line('$'), 'RIGHT')
  call append(line('$'), '')
  call cursor(line('$'),0)
  let last = search('^2048 board', 'b')
  if l:last == 0
    return 0
  endif
  let boardstring = getline(l:last)[12:]
  if game2048#IsGameOver(l:boardstring)
    return 0
  endif
  let b = eval(boardstring)
  let newBoard = []

  let newBoard = game2048#ShiftBoard(b, 'r')

  "Check if we've won
  if game2048#IsGameWon(l:newBoard)
    let failed = append(line('$'), "!!! YOU WIN !!!")
    let failed = append(line('$'), "Press n to start a new game")
    let failed = append(line('$'), "2048 board: " . string(l:newBoard))
  else
    "now add a new tile if able
    let newBoard = game2048#AddRandTile(l:newBoard)
    let failed = append(line('$'), "2048 board: " . string(l:newBoard))
  endif

  return l:newBoard
endfunction

"[ 0,  1,  2,  3
"  4,  5,  6,  7
"  8,  9, 10, 11
" 12, 13, 14, 15 ]
"Transpose left should result in:
"[ 3,  7,  11,  15
"  2,  6,  10,  14
"  1,  5,   9,  13
"  0,  4,   8,  12 ]
"game2048#TransposeBoard(b,'l')  => transpose board to the left
"game2048#TransposeBoard(b,'r')  => transpose board to the right
function! game2048#TransposeBoard(board, direction)
  let newBoard = []

  if a:direction == 'l'
    for i in range(3, 0, -1)
      let newRow = [a:board[l:i]] + [a:board[l:i+4]] + [a:board[l:i+8]] + [a:board[l:i+12]]
      let newBoard = extend(newBoard, newRow)
    endfor
  elseif a:direction == 'r'
    for i in range(0, 3)
      let newRow = reverse([a:board[l:i]] + [a:board[l:i+4]] + [a:board[l:i+8]] + [a:board[l:i+12]])
      let newBoard = extend(newBoard, newRow)
    endfor
  endif

  return l:newBoard
endfunction

"game2048#ShiftBoard(b, 'l')
"game2048#ShiftBoard(b, 'r')
function! game2048#ShiftBoard(board, direction)
  "Shift board to the left, combining matching tiles and pushing zeroes to the
  "right.
  let newBoard = []

  "Shift left by default, reverse the row before and after to shift right
  for i in range(0,12,4)
    let row = filter(a:board[(l:i):(l:i+3)], 'v:val != 0')
    let row = a:direction == 'r' ? reverse(row) : row

    if len(l:row) > 1
      for i in range(0, len(l:row) - 2, 1)
        if l:row[l:i] == l:row[l:i+1]
          let l:row[l:i] = l:row[l:i] * 2
          let l:row[l:i+1] = 0
        endif
      endfor
    endif

    let row = filter(l:row, 'v:val != 0')
    let row = extend(l:row, repeat([0], 4-len(l:row)))

    let row = a:direction == 'r' ? reverse(row) : row

    let newBoard = extend(newBoard, l:row)
  endfor

  return l:newBoard
endfunction

function! game2048#PrettyPrint()
  call cursor(line('$'),0)
  let last = search('^2048 board', 'bc')
  if l:last == 0
    echo "Not on a board"
    return 0
  endif
  let boardstring = getline(l:last)[12:]
  if game2048#IsGameOver(l:boardstring)
    return 0
  endif
  let b = eval(boardstring)

  call game2048#PrintBoard(b)
endfunction

function! game2048#PrintBoard(board)
  let rows = []
  "split the board out into rows
  for i in range(0, 12, 4)
    let rows = add(l:rows, a:board[(l:i):(l:i+3)])
  endfor
  "print each now nicely
  let failed = append(line('$'), 'Pretty Print:')
  for row in l:rows
    let line = '['
    for item in l:row
      "let line = l:line . game2048#PadL(string(l:item), 4) . ','
      let line = l:line . substitute(game2048#PadL(string(l:item), 5), ' 0', '  ', '') . ','
    endfor
    let line = l:line[0:len(l:line)-2] . ' ]'
    "let failed = append(line('$'), string(l:row))
    let failed = append(line('$'), l:line)
  endfor
  let failed = append(line('$'), '')
  call cursor(line('$'),0)
endfunction

function! game2048#PadR(s,amt,...)
   "  game2048#PadR('abc', 5) == 'abc  '
   "  game2048#PadR('ab', 5, '.') ==  'ab...'
  let char = a:0 > 0 ? a:1 : ' '
  return a:s . repeat(char,a:amt - len(a:s))
endfunction

function! game2048#PadL(s,amt,...)
  " game2048#PadL('832', 4)      == ' 832'
  " game2048#PadL('832', 4, '0') == '0832'
  let char = a:0 > 0 ? a:1 : ' '
  return repeat(char,a:amt - len(a:s)) . a:s
endfunction

let s:RAND_MAX = 32767
let s:seed = localtime()

function! game2048#Rand()
  let s:seed = s:seed * 214013 + 2531011
  return (s:seed < 0 ? s:seed - 0x80000000 : s:seed) / 0x10000 % 0x8000
endfunction

function! game2048#AddRandTile(board)
  "Randomly adds a 2 or 4 tile to to the board on a free tile (ie. a 0 tile).
  let b = deepcopy(a:board)

  let freeTiles = len(filter(copy(l:b), 'v:val == 0'))
  if l:freeTiles == 0
    return ["GameOver"]
  endif

  "Randomly choose 2 or 4 favoring 2
  let newTile = game2048#Rand() % 10 < 9 ? 2 : 4

  "Randomly choose a free tile to populate with l:newTile
  let picking = 1
  while l:picking
    let i = game2048#Rand() % 16
    if l:b[i] == 0
      let l:b[i] = l:newTile
      let l:picking = 0
    endif
  endwhile

  return l:b
endfunction

function! game2048#IsGameWon(board)
  let b = deepcopy(a:board)
  let winningTiles = len(filter(copy(l:b), 'v:val == 2048'))

  "0 means we haven't won yet. Anything greater and we've won!
  return l:winningTiles
endfunction

function! game2048#IsGameOver(board)
  if a:board == "['GameOver']"
    let failed = append(line('$'), "GAME OVER")
    return 1
  else
    return 0
  endif
endfunction
