-- Setup https://github.com/numToStr/Comment.nvim
-- See `:h comment-nvim`
require('Comment').setup({
  -- Ignore empty lines
  ignore = '^$',
  mappings = {
    -- Disable basic mappings. I'm gonna do my own, see below
    basic = false,
    -- Disable extra mappings, they are stupid
    extra = false,
  },
})

-- Toggle current line or with count
vim.keymap.set('n', '<F1>', function()
  local toggle_current_line = '<Plug>(comment_toggle_linewise_current)j'
  local toggle_count_lines = '<Plug>(comment_toggle_linewise_count)' .. vim.v.count .. 'j'
  return vim.v.count == 0 and toggle_current_line or toggle_count_lines
end, { expr = true })

-- Toggle visual, line comment
vim.keymap.set('x', '<F1>', '<Plug>(comment_toggle_linewise_visual)', { expr = true })

-- Toggle count, block comment
vim.keymap.set('n', '<F2>', function()
  return '<Plug>(comment_toggle_blockwise_count)' .. vim.v.count .. 'j'
end, { expr = true })

-- Toggle visual, block comment
vim.keymap.set('x', '<F2>', '<Plug>(comment_toggle_blockwise_visual)', { expr = true })
