-- Indentation block
local spaceAmount = 2
-- use TABs
vim.o.expandtab = true
-- number of spaces to show for a TAB character
vim.o.tabstop = spaceAmount
-- number of spaces for indent function (>> and ENTER)
vim.o.shiftwidth = spaceAmount
-- When shifting lines, round the indentation to the nearest
-- multiple of `shiftwidth`
vim.o.shiftround = true
-- Disable softabstop, which isn't needed
vim.o.softtabstop = 0
-- New lines inherit the indentation of previous lines
vim.o.autoindent = true
-- Indentation block ends
