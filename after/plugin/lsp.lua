vim.filetype.add({ extension = { templ = "templ" } })

local lsp = require('lsp-zero')
local lsp_configurations = require('lspconfig.configs')

lsp.preset("recommended")

lsp.ensure_installed({
  'rust_analyzer'
})

lsp.nvim_workspace()
lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

require('lspconfig').ccls.setup({
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
})

require('lspconfig').html.setup({
  filetypes = { "html", "templ"},
})

require('lspconfig').tailwindcss.setup({
    filetypes = { "templ", "astro", "javascript", "typescript", "react" },
    init_options = { userLanguages = { templ = "html" } },
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

  vim.keymap.set("n", "<leader>[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "<leade>]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>dl", function() vim.diagnostic.setloclist() end, opts)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = false
})

