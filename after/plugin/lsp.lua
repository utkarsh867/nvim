require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'rust_analyzer' },
  handlers = {
    function(server_name)
      vim.lsp.enable(server_name)
    end,
  },
})

vim.lsp.config('terraformls', {
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        }
      }
    }
  }
})

local function tab_complete()
  if vim.fn.pumvisible() == 1 then
    -- navigate to next item in completion menu
    return '<Down>'
  end

  local c = vim.fn.col('.') - 1
  local is_whitespace = c == 0 or vim.fn.getline('.'):sub(c, c):match('%s')

  if is_whitespace then
    -- insert tab
    return '<Tab>'
  end

  local lsp_completion = vim.bo.omnifunc == 'v:lua.vim.lsp.omnifunc'

  if lsp_completion then
    -- trigger lsp code completion
    return '<C-x><C-o>'
  end

  -- suggest words in current buffer
  return '<C-x><C-n>'
end

local function tab_prev()
  if vim.fn.pumvisible() == 1 then
    -- navigate to previous item in completion menu
    return '<Up>'
  end

  -- insert tab
  return '<Tab>'
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.cmd [[set completeopt+=menuone,noinsert,popup]]
      -- Slow!!!
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = event.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
          vim.diagnostic.enable(event.buf)
        end,
      })
    end

    local opts = { buffer = event.buf }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set("n", "<leader>[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<leade>]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>dl", function() vim.diagnostic.setloclist() end, opts)

    vim.keymap.set("n", "<leader>ff", function() vim.lsp.buf.format() end, opts)

    vim.keymap.set('i', '<Tab>', tab_complete, { expr = true })
    vim.keymap.set('i', '<S-Tab>', tab_prev, { expr = true })
  end
})

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = false
})
