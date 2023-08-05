-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local noremap = { noremap = true }
local silent = { silent = true }
local silent_expr = { expr = true, silent = true }

---------- Helper functions ----------
local function nmap(keyCombo, mapping)
  vim.api.nvim_set_keymap('n', keyCombo, mapping, noremap)
end

local function cmap(keyCombo, mapping)
  vim.api.nvim_set_keymap('c', keyCombo, mapping, noremap)
end

---------- MIXED MODES MAPPINGS ----------
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', silent)

---------- NORMAL MODE MAPPINGS ----------
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", silent_expr)
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", silent_expr)

-- buffer navigation
nmap('<c-h>', ':bprevious<enter>')
nmap('<c-l>', ':bnext<enter>')

-- scroll up/down one line keeping current position
nmap('<C-j>', '<C-e>j')
nmap('<C-k>', '<C-y>k')

-- highlight searches
nmap('/', [[:set hls<enter>/\v]])
nmap('?', [[:set hls<enter>?\v]])
nmap('#', [[:set hls<enter>#\v]])
nmap('*', [[:set hls<enter>*\v]])

-- toggle cursorline
nmap('<F6>', ':set cursorline!<enter>:set cursorline?<enter>')

-- toggle search highlighting
nmap('<F7>', ':set hls!<enter>:set hls?<enter>')

-- remap quit and macro recording
nmap('<Leader>q', 'q')
nmap('q', ':q<enter>')

-- don't loose your vertical split when closing a buffer
nmap('<C-c>', ':bp|bd #<enter>')

-- tab fun
nmap('<Leader><Down>', ':tabnew<return>')
nmap('<Leader><Left>', ':tabnext<enter>')
nmap('<Leader><Right>', ':tabNext<enter>')
nmap('<Leader>o', ':tabonly<enter>')
nmap('<Leader><Up>', ':tabclose<enter>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- shift+insert copies from XA_PRIMARY (mouse selection, * register)
-- this mapping copies/paste to/from XA_CLIPBOARD (clipboard, + register)
-- equivalent to CTRL-C/CTRL-V in other editors
--
-- no need to map paste: in insert mode the terminal will handle it with
-- CTRL-SHIFT-v
-- copy needs to have something preselected, works in visual mode
vim.keymap.set('v', '<c-c>', '"+y')

---------- COMMAND MODE MAPPINGS ----------
-- regexp: set very magic when doing global substitutions
-- Note: key typing sequence must happen fast for it to work
cmap([[%s/]], [[%s/\v]])

-- I always keep the Shift key pressed a little bit more than
-- needed
cmap('W<enter>', 'w<enter>')
cmap('X<enter>', 'x<enter>')

-- have the benefits of `smartcase` but search strictly when using `*` or `#`,
-- since I always use those to search for exact matches
local asterisk = [[<cmd>:set hls<enter>:let @/='\C\<' . expand('<cword>') . '\>'<CR>:let v:searchforward=1<CR>n]]
local sharp = [[<cmd>:set hls<enter>:let @/='\C\<' . expand('<cword>') . '\>'<CR>:let v:searchforward=0<CR>n]]
vim.keymap.set('n', '*', asterisk, { noremap = true, silent = true })
vim.keymap.set('n', '#', sharp, { noremap = true, silent = true })
