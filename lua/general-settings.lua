-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Indentation block
local spaceAmount = 4
-- use TABs
vim.o.expandtab = false
-- number of spaces to show for a TAB character
vim.o.tabstop = spaceAmount
-- number of spaces for indent function (>> and ENTER)
vim.o.shiftwidth = spaceAmount
-- When shifting lines, round the indentation to the nearest
-- multiple of `shiftwidth`
vim.o.shiftround = true
-- New lines inherit the indentation of previous lines
vim.o.autoindent = true
-- Indentation block ends
