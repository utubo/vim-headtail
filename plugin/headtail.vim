if exists('g:loaded_headtail') && g:loaded_headtail
  finish
endif
let g:loaded_headtail = 1

nnoremap <Plug>(to-head) <Cmd>call headtail#ToHeadOrTail('bn')<CR><Esc>g@
onoremap <Plug>(to-head) <Cmd>call headtail#ToHeadOrTail('bo')<CR><Esc>g@
xnoremap <Plug>(to-head) <Cmd>call headtail#ToHeadOrTail('bx')<CR><Esc>g@
nnoremap <Plug>(to-tail) <Cmd>call headtail#ToHeadOrTail('fn')<CR><Esc>g@
onoremap <Plug>(to-tail) <Cmd>call headtail#ToHeadOrTail('fo')<CR><Esc>g@
xnoremap <Plug>(to-tail) <Cmd>call headtail#ToHeadOrTail('fx')<CR><Esc>g@
command! -nargs=+ HeadTailMap call headtail#Map(<f-args>)
