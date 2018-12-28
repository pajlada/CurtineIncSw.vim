function! FindInc()
  let dirname=fnamemodify(expand("%:p"), ":h")
  let target_file=b:inc_sw
  let cmd="find " . dirname . " . -type f -regex \".*\/" . target_file . "\" -print -quit"
  let find_res=system(cmd)
  if filereadable(find_res)
    return 0
  endif

  exe "e " find_res
endfun

function! CurtineIncSw()
  if exists("b:inc_sw")
    e#
    return 0
  endif
  if match(expand("%"), '\.c') > 0
    let b:inc_sw=substitute(expand("%:t"), '\.c\([a-z+]*\)', '.h[a-z+]*', "")
  elseif match(expand("%"), "\\.h") > 0
    let b:inc_sw=substitute(expand("%:t"), '\.h\([a-z+]*\)', '.c[a-z+]*', "")
  endif

  call FindInc()
endfun

