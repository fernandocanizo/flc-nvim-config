-- Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme onedark]]

vim.cmd('hi CursorLine cterm=NONE ctermbg=darkgrey ctermfg=white guibg=darkgrey guifg=white')
vim.opt.cursorline = false
