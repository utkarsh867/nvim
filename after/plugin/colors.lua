-- require('rose-pine').setup({
--     disable_background = true
-- })
--
-- function ColorMyPencils(color)
-- 	color = color or "rose-pine"
-- 	vim.cmd.colorscheme(color)
--
-- 	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
-- 	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
-- end
--
-- ColorMyPencils()

require("catppuccin").setup({
  flavour = "auto",
  background = {
    light = "latte",
    dark = "mocha"
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    treesitter = true,
    harpoon = true,
    notify = false,
    mason = true,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
  }
})

vim.o.background = "dark"
vim.keymap.set("n", "<leader>cl", function()
  if vim.o.background == "light" then
    vim.o.background = "dark"
  else
    vim.o.background = "light"
  end
end)

vim.cmd.colorscheme("catppuccin")
