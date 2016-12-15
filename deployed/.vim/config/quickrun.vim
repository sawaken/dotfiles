" Haskellはstack経由で実行するようにする
let g:quickrun_config = {
      \    "_" : {
      \        'runner'    : 'vimproc',
      \        'runner/vimproc/updatetime' : 60,
      \        'outputter' : 'error',
      \        'outputter/error/success' : 'buffer',
      \        'outputter/error/error'   : 'quickfix',
      \        'outputter/buffer/split'  : ':rightbelow 8sp',
      \        'outputter/buffer/close_on_empty' : 1,
      \    },
      \   'haskell' : { 'type' : 'haskell/stack' },
      \   'haskell/stack' : {
      \       'command' : 'stack',
      \       'exec' : '%c %o %s %a',
      \       'cmdopt' : 'runghc',
      \   },
      \}

let g:quickrun_no_default_key_mappings = 1

" normal-mode時に\rでファイル全体を実行
nnoremap <leader>r :write<CR>:QuickRun -mode n<CR>
" visual-mode時に\rで選択範囲を実行
xnoremap <leader>r :<C-U>write<CR>gv:QuickRun -mode v<CR>
" 実行中にC-cで停止
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
