require('gitsigns').setup({
  signs = {
    add = { text = '+' },
  },
})

require('gitsigns.config').config.on_attach = function (bufnr)
  if vim.bo[bufnr].filetype == "netrw" then return false end
end
