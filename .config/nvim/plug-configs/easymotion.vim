" Jump anywhere with a two character search
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insentive features
let g:EasyMotion_smartcase = 1 

map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

hi link EasyMotionTarget Function
hi link EasyMotionShade  Comment

hi link EasyMotionTarget2First Special
hi link EasyMotionTarget2Second Special

hi link EasyMotionMoveHL Search
hi link EasyMotionIncSearch Search

