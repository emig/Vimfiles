" File: lib.vim
" Author: Andrew Radev
" Description: The place for any functions I might decide I need.
" Last Modified: October 09, 2009

" Function to check if the cursor is currently in a php block. Useful for
" autocompletion. Ripped directly from phpcomplete.vim
function! lib#CursorIsInsidePhpMarkup()
  let phpbegin = searchpairpos('<?', '', '?>', 'bWn',
      \ 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string\|comment"')
  let phpend   = searchpairpos('<?', '', '?>', 'Wn',
      \ 'synIDattr(synID(line("."), col("."), 0), "name") =~? "string\|comment"')
  return !(phpbegin == [0,0] && phpend == [0,0])
endfunction

" Function to Align ranged text on whitespace -- by columns:
"
" Requires: Align
function! lib#AlignSpace() range
  AlignPush
  AlignCtrl lp0P0
  execute a:firstline.','.a:lastline.'Align \s\S'
  AlignPop
endfunction

" Function to toggle between settings:
function! lib#MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
endfunction

" Function to capitalize first letter of argument:
" word -> Word
function! lib#Capitalize(word)
  return substitute(a:word, '^\w', '\U\0', 'g')
endfunction