-- vim.keymap.set("n","<leader>y", '<cmd>lua print("hello sallsa")<cr>')
vim.keymap.set("n", "<leader>3", function()
  vim.cmd.lua('print("hello sallsa")')
end)
vim.keymap.set("n", "<leader>x", vim.cmd.Explore)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Navigation
-- -- Center cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "<C-Left> ", vim.cmd.tabprevious)
vim.keymap.set("n", "<C-Right>", vim.cmd.tabnext)

-- Overwrite pasting without losing yank word after selecting
vim.keymap.set("x", "<leader>p", '"_dP')

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
