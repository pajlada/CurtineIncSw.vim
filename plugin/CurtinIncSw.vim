function! FindInc()
  let dirname=fnamemodify(expand("%:p"), ":h")
  let target_file=b:inc_sw
  let cmd="find " . dirname . " . -type f -regex \".*\/" . target_file . "\" -print -quit"
  let find_res=system(cmd)
  if filereadable(find_res)
    return 0
  endif

  let b:inc_sw_buffered_result=find_res

  exe "e " find_res
endfun

function! CurtineIncSw()
  if exists("b:inc_sw_inc_sw_buffered_result")
    " Open up the buffered result
    " TODO: Check if file exists before attempting to open it?
    " TODO: Handle failure cases
    exe "e " b:inc_sw_buffered_result
    return 0
  endif

  if match(expand("%"), '\.c') > 0
    let b:inc_sw=substitute(expand("%:t"), '\.c\([a-z+]*\)', '.h[a-z+]*', "")
  elseif match(expand("%"), '\.h') > 0
    let b:inc_sw=substitute(expand("%:t"), '\.h\([a-z+]*\)', '.c[a-z+]*', "")
  endif

  call FindInc()
endfun
