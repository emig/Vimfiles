setlocal nowrap

xnoremap <buffer> d  :DeleteLines<cr>
nnoremap <buffer> dd :DeleteLines<cr>
nnoremap <buffer> u  :UndoDelete<cr>

if !exists(':DeleteLines')
  let b:deletion_stack = []

  command! -range -buffer DeleteLines call s:DeleteLines(<line1>, <line2>)
  function! s:DeleteLines(start, end)
    let saved_cursor = getpos('.')
    let start        = a:start - 1
    let end          = a:end - 1

    let qflist  = getqflist()
    let deleted = remove(qflist, start, end)
    call insert(b:deletion_stack, [start, deleted], 0)

    call setqflist(qflist)
    call setpos('.', saved_cursor)
    echo
  endfunction

  command! -buffer UndoDelete call s:UndoDelete()
  function! s:UndoDelete()
    if empty(b:deletion_stack)
      return
    endif

    let saved_cursor = getpos('.')
    let qflist       = getqflist()

    let [index, deleted] = remove(b:deletion_stack, 0)
    for line in deleted
      call insert(qflist, line, index)
      let index = index + 1
    endfor

    call setqflist(qflist)
    call setpos('.', saved_cursor)
    echo
  endfunction
end