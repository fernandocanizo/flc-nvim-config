require('packer-setup')

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
if vim.g.flc_is_packer_bootstrapped then
  print '=================================='
  print '    Plugins are being installed'
  print '    Wait until Packer completes,'
  print '       then restart nvim'
  print '=================================='
  return
end

require('general-settings')
require('style')
require('general-mappings')
require('general-commands')
require('autocommands')

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-S-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  --  flc 2023-07-10: me sale un mensaje de que 'sumneko_lua' no es una entrada válida
  --  ver: https://github.com/nvim-lua/kickstart.nvim/issues/179
  lua_ls = {
    Lua = {
      -- Disable "Undefined global `vim`" message
      diagnostics = {
        globals = {'vim'}
      },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      -- should I set it up for any LS?
      -- single_file_support = server_name == 'tsserver' or server_name == 'eslint',
      single_file_support = true
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      -- 2024-01-12
      -- TODO check what does the next 
      -- I commented it because my cursor was jumping around like crazy on TAG
      -- pressing. Usually after pressing `o` to go to a new line. But sometimes
      -- when pressing ENTER on insert mode, if I needed a new indentation
      -- level, pressing TAB instead of inserting the character moved me around,
      -- usually to the beginning, but the behavior wasn't regular. Sometimes
      -- worked well. So I'm commenting this to see if that solves it.
      -- But I'd like to know what I'm missing, so investigate that function
      -- elseif luasnip.expand_or_jumpable() then
        -- luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

local lspconfig = require 'lspconfig'
lspconfig.denols.setup({
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  init_options = {
    lint = true,
    unstable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true,
          ["https://cdn.nest.land"] = true,
          ["https://crux.land"] = true,
        },
      },
    },
  },

  on_attach = on_attach,
})

-- Don't attach `ts_ls` on Deno projects
lspconfig.ts_ls.setup({
  on_attach = function (client, bufnr)
    on_attach(client, bufnr);
    vim.keymap.set('n', '<leader>ro', function()
      vim.lsp.buf.execute_command({
        command = "_typescript.organizeImports",
        arguments = { vim.fn.expand("%:p") }
      })
    end, { buffer = bufnr,  remap = false });
  end,

  root_dir = function (filename)
    local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(filename);
    if denoRootDir then
      -- print('this seems to be a deno project; returning nil so that `ts_ls` does not attach');
      return nil;
    else
      -- print('this seems to be a ts project; return root dir based on `package.json`')
      return lspconfig.util.root_pattern("package.json")(filename);
    end
  end,
  single_file_support = false,
})

-- Don't attach `eslint` on Deno projects
lspconfig.eslint.setup({
  root_dir = function (filename)
    local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(filename);
    if denoRootDir then
      -- print('this seems to be a deno project; returning nil so that `eslint` does not attach');
      return nil;
    else
      -- print('this seems to be a ts project; return root dir based on `package.json`')
      return lspconfig.util.root_pattern("package.json")(filename);
    end
  end,
  single_file_support = false,
})

-- Don't attach `htmx` on Deno projects
lspconfig.htmx.setup({
  root_dir = function (filename)
    local denoRootDir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(filename);
    if denoRootDir then
      -- print('this seems to be a deno project; returning nil so that `htmx` does not attach');
      return nil;
    else
      -- print('this seems to be a ts project; return root dir based on `package.json`')
      return lspconfig.util.root_pattern("package.json")(filename);
    end
  end,
  single_file_support = false,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
