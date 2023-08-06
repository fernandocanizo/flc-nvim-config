# Notes

## Reminders

```
-- Some Lua in Neovim reminders
-- nvim global
vim.g.variable
-- tab-local
vim.t.variable
-- window-local
vim.w.variable
-- buffer-local
vim.b.variable
```

## vim.keymap.set vs. vim.api.nvim_set_keymap

- `vim.api.nvim_set_keymap` comes from the v0.5 days and has some downsides

- use `vim.keymap.set`, which is Lua exclusive interface designed to work around `nvim_set_keymap` issues.

## On file explorers

Neovim comes by default with `netrw` file explorer. I tried it and didn't like it. However it has powerfull over-the-network editing and browsing capabilities. Which I'm not interested currently.

So I analyzed several and finally decided for `neo-tree`.

My main rule was to choose only from the ones written in Lua. And a secondary rule was for it to have a simple setup. And the third rule, based on my experience with `nvim-tree`, was that hopefully the plugin doesn't mess much into my configuration. See notes at the end about my grievances and problems about `nvim-tree`.

### List of analyzed plugins

- [NERDTree](https://github.com/preservim/nerdtree) (vimscript)
- [fern.vim](https://github.com/lambdalisue/fern.vim) (vimscript)
- [dirvish.vim](https://github.com/justinmk/vim-dirvish) (vimscript)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) (lua, but that's the one I was ditching)
- [tree.nvim](https://github.com/zgpio/tree.nvim) (C++, overkill, I don't wanna have to compile a plugin if I can avoid it)
- [defx.nvim](https://github.com/Shougo/defx.nvim) (python)
- [CHADTree](https://github.com/ms-jpq/chadtree) (python)
- [lir.nvim](https://github.com/tamago324/lir.nvim) (lua)
  This one's pretty simple and claims not to mess with my filesystem. I didn't try it because I liked much more the looks of `neo-tree`, however this one would have been my second choice.
- [telescope-file-browser.nvim](https://github.com/nvim-telescope/telescope-file-browser.nvim) (lua)
  Telescope is pretty cool, I didn't installed this one, but it would be a contender should I revise file navigators again.
- [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) (lua)

### nvim-tree issues

I don't like that:

- doesn't came with sane default mappings for opening it, but it comes with other key mappings that mess with my configuration.

- if I have a vertical split and from the `nvim-tree` window I try to open another file, it asks me "Pick a window". And I don't know what to put. Tried numbers, the file name, the mouse, but nothing worked, so I cannot open from it a file into a vertical split.

- comes with a mapping for `<c-t>` to open a new tab, I changed that mapping but `nvim-tree` kept hold on the mapping and mine didn't work.

- I tried to issue the help, which documentation says it's brought via `g?` key combination, but didn't work for me.
