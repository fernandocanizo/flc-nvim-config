-- Setup https://github.com/lukas-reineke/indent-blankline.nvim
-- See `:help indent_blankline.txt`
local config = {}
config.indent = {
  char = '┊'
}

require('ibl').setup(config)
