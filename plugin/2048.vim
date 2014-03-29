
"This is a game of 2048 in vim just for fun.
"
"board is an array of 16 ints arranged like:
"[ 0,  1,  2,  3
"  4,  5,  6,  7
"  8,  9, 10, 11
" 12, 13, 14, 15 ]

function! NewGame()
  let board = [0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0]
  let board = AddRandTile(l:board)
  let board = AddRandTile(l:board)

  let failed = append(line('$'), "New game of 2048!")
  let failed = append(line('$'), "2048 board: " . string(l:board))

  return l:board
endfunction

function! Up2048()
  call append(line('$'), 'UP')
  call append(line('$'), '')
  call cursor(line('$'),0)
  let last = search('^2048 board', 'b')
  if l:last == 0
    return 0
  endif
  let boardstring = getline(l:last)[11:]
  let b = eval(boardstring)
  let newBoard = []

  let newCols = []  "build up the list in column first order
  for i in range(0,3)
    let col = [l:b[l:i]] + [l:b[l:i+4]] + [l:b[l:i+8]] + [l:b[l:i+12]]
    let col = filter(l:col, 'v:val !~ 0')
    if len(l:col) > 1
      for i in range(0, len(l:col) - 2, 1)
        if l:col[l:i] == l:col[l:i+1]
          let l:col[l:i] = l:col[l:i] * 2
          let l:col[l:i+1] = 0
        endif
      endfor
    endif

    let col = filter(l:col, 'v:val !~ 0')
    let col = extend(l:col, repeat([0], 4-len(l:col)))
    let newCols = extend(newCols, l:col)
  endfor

  "now transpose newCols back into row first order
  for i in range(0, 3)
    let newBoard = extend(newBoard, [l:newCols[l:i]] + [l:newCols[l:i+4]] + [l:newCols[l:i+8]] + [l:newCols[l:i+12]])
  endfor

  "now add a new tile if able
  let newBoard = AddRandTile(l:newBoard)

  let failed = append(line('$'), "2048 board: " . string(l:newBoard))

  return l:newBoard
endfunction


function! Down2048()
  call append(line('$'), 'DOWN')
  call append(line('$'), '')
  call cursor(line('$'),0)
  let last = search('^2048 board', 'b')
  if l:last == 0
    return 0
  endif
  let boardstring = getline(l:last)[11:]
  let b = eval(boardstring)
  let newBoard = []

  let newCols = []  "build up the list in column first order
  for i in range(0,3)
    let col = [l:b[l:i]] + [l:b[l:i+4]] + [l:b[l:i+8]] + [l:b[l:i+12]]
    let col = filter(l:col, 'v:val !~ 0')
    if len(l:col) > 1
      for i in range(len(l:col) - 1,1, -1)
        if l:col[l:i] == l:col[l:i-1]
          let l:col[l:i] = l:col[l:i] * 2
          let l:col[l:i-1] = 0
        endif
      endfor
    endif

    let col = filter(l:col, 'v:val !~ 0')
    let col = extend(repeat([0], 4-len(l:col)), l:col)
    let newCols = extend(newCols, l:col)
  endfor

  "now transpose newCols back into row first order
  for i in range(0, 3)
    let newBoard = extend(newBoard, [l:newCols[l:i]] + [l:newCols[l:i+4]] + [l:newCols[l:i+8]] + [l:newCols[l:i+12]])
  endfor

  "now add a new tile if able
  let newBoard = AddRandTile(l:newBoard)

  let failed = append(line('$'), "2048 board: " . string(l:newBoard))

  return l:newBoard
endfunction

function! Left2048()
  call append(line('$'), 'LEFT')
  call append(line('$'), '')
  call cursor(line('$'),0)
  let last = search('^2048 board', 'b')
  if l:last == 0
    return 0
  endif
  let boardstring = getline(l:last)[11:]
  let b = eval(boardstring)
  let newBoard = []

  for i in range(0,12,4)
    let row = filter(l:b[(l:i):(l:i+3)], 'v:val !~ 0')
    if len(l:row) > 1
      for i in range(0, len(l:row) - 2, 1)
        if l:row[l:i] == l:row[l:i+1]
          let l:row[l:i] = l:row[l:i] * 2
          let l:row[l:i+1] = 0
        endif
      endfor
    endif
    let row = filter(l:row, 'v:val !~ 0')
    let row = extend(l:row, repeat([0], 4-len(l:row)))
    let newBoard = extend(newBoard, l:row)
  endfor

  "now add a new tile if able
  let newBoard = AddRandTile(l:newBoard)

  let failed = append(line('$'), "2048 board: " . string(l:newBoard))

  return l:newBoard
endfunction

function! Right2048()
  call append(line('$'), 'RIGHT')
  call append(line('$'), '')
  call cursor(line('$'),0)
  let last = search('^2048 board', 'b')
  if l:last == 0
    return 0
  endif
  let boardstring = getline(l:last)[11:]
  let b = eval(boardstring)
  let newBoard = []

  for i in range(0,12,4)
    let row = filter(l:b[(l:i):(l:i+3)], 'v:val !~ 0')
    if len(l:row) > 1
      for i in range(len(l:row) - 1, 1, -1)
        if l:row[l:i] == l:row[l:i-1]
          let l:row[l:i] = l:row[l:i] * 2
          let l:row[l:i-1] = 0
        endif
      endfor
    endif
    let row = filter(l:row, 'v:val !~ 0')
    let row = extend(repeat([0], 4-len(l:row)), l:row)
    let newBoard = extend(newBoard, l:row)
  endfor

  "now add a new tile if able
  let newBoard = AddRandTile(l:newBoard)

  let failed = append(line('$'), "2048 board: " . string(l:newBoard))

  return l:newBoard
endfunction

function! PrettyPrint()
  call cursor(line('$'),0)
  let last = search('^2048 board', 'bc')
  if l:last == 0
    echo "Not on a board"
    return 0
  endif
  let boardstring = getline(l:last)[11:]
  let b = eval(boardstring)

  let rows = []
  "split the board out into rows
  for i in range(0, 12, 4)
    let rows = add(l:rows, l:b[(l:i):(l:i+3)])
  endfor
  "print each now nicely
  let failed = append(line('$'), 'Pretty Print:')
  for row in l:rows
    let failed = append(line('$'), string(l:row))
  endfor
  let failed = append(line('$'), '')
  call cursor(line('$'),0)
endfunction

function! Rand()
  return str2nr(matchstr(reltimestr(reltime()), '\v\.@<=\d+')[1:])
endfunction

function! AddRandTile(board)
  "Randomly adds a 2 or 4 tile to to the board on a free tile (ie. a 0 tile).
  let b = deepcopy(a:board)

  let freeTiles = len(filter(copy(l:b), 'v:val == 0'))
  if l:freeTiles == 0
    return ["GameOver"]
  endif

  "Randomly choose 2 or 4
  let newTile = (4 - ((Rand() % 2) * 2))

  "Randomly choose a free tile to populate with l:newTile
  let picking = 1
  while l:picking
    let i = Rand() % 16
    if l:b[i] == 0
      let l:b[i] = l:newTile
      let l:picking = 0
    endif
  endwhile

  return l:b
endfunction

