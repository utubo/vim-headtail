if exists('g:loaded_headtail') && g:loaded_headtail
  finish
endif
let g:loaded_headtail = 1

nnoremap <Plug>(to-head) <Cmd>call headtail#ToHeadOrTail('bn')<CR>g@
onoremap <Plug>(to-head) <Cmd>call headtail#ToHeadOrTail('bo')<CR><Esc>g@
vnoremap <Plug>(to-head) <Cmd>call headtail#ToHeadOrTail('bv')<CR><Esc>g@
nnoremap <Plug>(to-tail) <Cmd>call headtail#ToHeadOrTail('fn')<CR>g@
onoremap <Plug>(to-tail) <Cmd>call headtail#ToHeadOrTail('fo')<CR><Esc>g@
vnoremap <Plug>(to-tail) <Cmd>call headtail#ToHeadOrTail('fv')<CR><Esc>g@
command! -nargs=+ HeadTailMap call headtail#Map(<f-args>)
