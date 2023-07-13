vim.cmd([[
  augroup TrailingSpace
    au!
    au VimEnter,WinEnter * highlight link TrailingSpace MiniTrailSpace
    au VimEnter,WinEnter * match TrailingSpace /\v\s+$/
  augroup END
]])
