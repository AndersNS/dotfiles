" Fix for breaking diagnostics
let g:easymotion#is_active = 0
function! EasyMotionCoc() abort
  if EasyMotion#is_active()
    let g:easymotion#is_active = 1
    CocDisable
  else
    if g:easymotion#is_active == 1
      let g:easymotion#is_active = 0
      CocEnable
    endif
  endif
endfunction
autocmd TextChanged,CursorMoved * call EasyMotionCoc()


" Jump anywhere with a two character search
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insentive features
let g:EasyMotion_smartcase = 1 

" Move to lines down / up
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Move to line
map <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>l <Plug>(easymotion-overwin-line)

" Set colors to match color scheme
hi link EasyMotionTarget Function
hi link EasyMotionShade  Comment

hi link EasyMotionTarget2First Special
hi link EasyMotionTarget2Second Special

hi link EasyMotionMoveHL Search
hi link EasyMotionIncSearch Search

