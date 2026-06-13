-- Setup nvim-treesitter (minimal — parser management only)
require('nvim-treesitter').setup()

-- Enable treesitter highlighting and indent for all filetypes
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    -- Highlight if parser is available
    pcall(vim.treesitter.start)
    -- Indent via treesitter except for Python
    if vim.bo.filetype ~= 'python' then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter.indent'.get_indent(v:lnum)"
    end
  end,
})

-- Ensure wanted parsers are installed (runs once after startup)
vim.defer_fn(function()
  local config = require('nvim-treesitter.config')
  local installed = config.get_installed('parsers')
  local wanted = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'vimdoc', 'elixir' }
  local to_install = {}
  for _, lang in ipairs(wanted) do
    if not vim.tbl_contains(installed, lang) then
      table.insert(to_install, lang)
    end
  end
  if #to_install > 0 then
    require('nvim-treesitter').install(to_install)
  end
end, 100)

-- Setup nvim-treesitter-textobjects (standalone since 2024)
require('nvim-treesitter-textobjects').setup({
  select = {
    lookahead = true,
    include_surrounding_whitespace = false,
  },
  move = {
    set_jumps = true,
  },
})

-- Textobject selection
local select = require('nvim-treesitter-textobjects.select')
vim.keymap.set({ 'x', 'o' }, 'aa', function() select.select_textobject('@parameter.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ia', function() select.select_textobject('@parameter.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'af', function() select.select_textobject('@function.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'if', function() select.select_textobject('@function.inner', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ac', function() select.select_textobject('@class.outer', 'textobjects') end)
vim.keymap.set({ 'x', 'o' }, 'ic', function() select.select_textobject('@class.inner', 'textobjects') end)

-- Textobject move
local move = require('nvim-treesitter-textobjects.move')
vim.keymap.set({ 'n', 'x', 'o' }, ']m', function() move.goto_next_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function() move.goto_next_start('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, ']M', function() move.goto_next_end('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '][', function() move.goto_next_end('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[m', function() move.goto_previous_start('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function() move.goto_previous_start('@class.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[M', function() move.goto_previous_end('@function.outer', 'textobjects') end)
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function() move.goto_previous_end('@class.outer', 'textobjects') end)

-- Textobject swap
local swap = require('nvim-treesitter-textobjects.swap')
vim.keymap.set('n', '<leader>a', function() swap.swap_next('@parameter.inner', 'textobjects') end)
vim.keymap.set('n', '<leader>A', function() swap.swap_previous('@parameter.inner', 'textobjects') end)
