let s:suite = themis#suite('Test headtail')
let s:assert = themis#helper('assert')

" setup test {{{
execute 'source' expand('<sfile>:p:h:h') .. '/plugin/headtail.vim'
execute 'source' expand('<sfile>:p:h:h') .. '/autoload/headtail.vim'

function s:suite.before()
  HeadTailMap [ ]
endfunction

function s:suite.before_each()
  normal! ggdG
  call append(0, '<html>')
  call append(1, '  <body>')
  call append(2, '    aaa')
  call append(3, '    bbb')
  call append(4, '    ccc')
  call append(5, '  </body>')
  call append(6, '</html>')
  normal gg
  set ft=html
endfunction

function s:suite.after_each()
  call feedkeys("\<ESC>")
endfunction
"}}}

function s:suite.Normal()
  call setpos('.', [0, 2, 5, 0])
  call feedkeys('[i>', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [2, 4], 'jump to after <')
  call setpos('.', [0, 2, 5, 0])
  call feedkeys(']i>', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [2, 7], 'jump to before >')
  call setpos('.', [0, 2, 5, 0])
  call feedkeys('[a>', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [2, 3], 'jump to <')
  call setpos('.', [0, 2, 5, 0])
  call feedkeys(']a>', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [2, 8], 'jump to >')
  call setpos('.', [0, 4, 5, 0])
  call feedkeys('[it', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [3, 5], 'jump to head of inner html-tag')
  call setpos('.', [0, 4, 5, 0])
  call feedkeys(']it', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [6, 2], 'jump to tail of inner html-tag')
  call setpos('.', [0, 4, 5, 0])
  call feedkeys('[at', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [2, 3], 'jump to head of html-tag')
  call setpos('.', [0, 4, 5, 0])
  call feedkeys(']at', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [6, 9], 'jump to tail of html-tag')
endfunction

function s:suite.Visual()
  let v = "\<ESC>v"
  call setpos('.', [0, 2, 5, 0])
  call feedkeys(v .. '[i>', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [2, 4], 'jump to after <')
  call setpos("'[", [0, 2, 5, 0])
  call feedkeys(v .. ']i>', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [2, 7], 'jump to before >')
  call setpos("'[", [0, 2, 5, 0])
  call feedkeys(v .. '[a>', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [2, 3], 'jump to <')
  call setpos("'[", [0, 2, 5, 0])
  call feedkeys(v .. ']a>', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [2, 8], 'jump to >')
  call setpos("'[", [0, 4, 5, 0])
  call feedkeys(v .. '[it', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [3, 5], 'jump to head of inner html-tag')
  call setpos("'[", [0, 4, 5, 0])
  call feedkeys(v .. ']it', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [6, 2], 'jump to tail of inner html-tag')
  call setpos("'[", [0, 4, 5, 0])
  call feedkeys(v .. '[at', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [2, 3], 'jump to head of html-tag')
  call setpos("'[", [0, 4, 5, 0])
  call feedkeys(v .. ']at', 'xt')
  call s:assert.equals(getpos('.')[1 : 2], [6, 9], 'jump to tail of html-tag')
  call feedkeys("\<Esc>", 'xt')
endfunction

function s:suite.Op()
  call setpos('.', [0, 2, 5, 0])
  call feedkeys('y[i>', 'xt')
  call s:assert.equals(getreg(), 'bo', 'yank to after <')
  call setpos('.', [0, 2, 5, 0])
  call feedkeys('y]i>', 'xt')
  call s:assert.equals(getreg(), 'ody', 'yank to before >')
  call setpos('.', [0, 2, 5, 0])
  call feedkeys('y[a>', 'xt')
  call s:assert.equals(getreg(), '<bo', 'yank to <')
  call setpos('.', [0, 2, 5, 0])
  call feedkeys('y]a>', 'xt')
  call s:assert.equals(getreg(), 'ody>', 'yank to >')
  call setpos('.', [0, 4, 5, 0])
  call feedkeys('y[it', 'xt')
  call s:assert.equals(getreg(), "aaa\n    b", 'yank to head of inner html-tag')
  call setpos('.', [0, 4, 5, 0])
  call feedkeys('y]it', 'xt')
  call s:assert.equals(getreg(), "bbb\n    ccc\n  ", 'yank to tail of inner html-tag')
  call setpos('.', [0, 4, 5, 0])
  call feedkeys('y[at', 'xt')
  call s:assert.equals(getreg(), "<body>\n    aaa\n    b", 'yank to head of html-tag')
  call setpos('.', [0, 4, 5, 0])
  call feedkeys('y]at', 'xt')
  call s:assert.equals(getreg(), "bbb\n    ccc\n  </body>", 'yank to tail of html-tag')
endfunction

