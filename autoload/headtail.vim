let s:save_a = ''
let s:save_o = ''
let s:save_p = []

function! headtail#ToHeadOrTail(a) abort
  let s:save_a = a:a
  let s:save_o = v:operator
  let s:save_p = getpos('.')
  set opfunc=s:TextObj
endfunction

function! s:TextObj(type) abort
  if s:save_a =~# 'o' || s:save_a =~# 'x'
    call setpos('.', s:save_p)
    normal v
  endif
  if s:save_a =~# 'f'
    call setpos('.', getpos("']"))
  else
    let p = getpos("'[")
    call setpos('.', p)
    if p[2] <= 1
      normal ^
    elseif getline(p[1])->len() <= p[2]
      normal j^
    endif
  endif
  if s:save_a =~# 'o'
    call feedkeys("\<Esc>", 'nt')
    execute 'normal!' s:save_o
  endif
endfunction

function! headtail#Map(headkey, tailkey) abort
  for l:m in ['nmap', 'omap', 'vmap']
    for l:i in ['a', 'i']
      execute $'{m} {a:headkey}{l:i} <Plug>(to-head){l:i}'
      execute $'{m} {a:tailkey}{l:i} <Plug>(to-tail){l:i}'
    endfor
  endfor
endfunction
