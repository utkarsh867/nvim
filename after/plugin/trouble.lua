vim.keymap.set("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>")
vim.keymap.set("n", "<leader>tf", function() require("trouble").toggle("quickfix") end)
