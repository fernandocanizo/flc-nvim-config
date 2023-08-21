vim.cmd([[
  command! SyntaxId echo synIDattr(synID(line("."), col("."), 1), "name")
]])
