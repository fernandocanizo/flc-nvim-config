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

## `vim.keymap.set` vs. `vim.api.nvim_set_keymap`

- `vim.api.nvim_set_keymap` comes from the v0.5 days and has some downsides

- use `vim.keymap.set`, which is Lua exclusive interface designed to work around `nvim_set_keymap` issues.
