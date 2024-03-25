local builtin = require('telescope.builtin')
local extensions = require('telescope').extensions

vim.keymap.set('n', '<leader>pF', builtin.find_files, {})
vim.keymap.set('n', '<leader>po', extensions.live_grep_args.live_grep_args, {})
vim.keymap.set('n', '<leader>pf', builtin.git_files, {})

vim.keymap.set('n', '<leader>fb', extensions.file_browser.file_browser, {})

