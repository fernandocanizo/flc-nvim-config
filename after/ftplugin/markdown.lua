vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2
vim.o.expandtab = true

-- show wrapped lines visually but don't hard-wrap them
vim.o.number = true -- just to help visualize this
vim.o.textwidth = 0
vim.o.wrapmargin = 0
-- visual wrap (no real line cutting is made)
vim.o.wrap = true
vim.o.linebreak = true -- breaks by word rather than character
-- next is the magic line: tell nvim that we have only 80 columns
-- (usually this is set automatically to the width of your window)
--
-- TODO this is working wonderful until I have to make a vertical split, then is
-- a mess because the splits open inside this 80 columns restriction, making the
-- reading and editing cumbersome. I'll leave it commented, already asked on
-- Neovim Discourse forum
--
-- vim.opt_local.columns = 80

-- don't wrap around file when searching
vim.o.wrapscan = false
