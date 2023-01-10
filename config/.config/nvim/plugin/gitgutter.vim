" Function to cycle through line updated
"
function! GitGutterNextHunkCycle()
  let line = line('.')
  silent! GitGutterNextHunk
  if line('.') == line
    1
    GitGutterNextHunk
  endif
  silent! call repeat#set("]h")
endfunction
