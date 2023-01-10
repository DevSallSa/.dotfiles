-- For floating terminal
vim.keymap.set("t", "<F11>", "<C-\\><C-n><cmd>      :FloatermNext<CR>", { silent = true })
vim.keymap.set("t", "<F12>", "<C-\\><C-n><cmd>      :FloatermToggle<CR>", { silent = true })
vim.keymap.set("n", "<F12>", vim.cmd.FloatermToggle, { silent = true })
vim.keymap.set("n", "<leader>tt", vim.cmd.FloatermNew, { silent = true })
vim.keymap.set("n", "<leader>tg", "<cmd>            :FloatermNew ghci<CR>", { silent = true })
vim.keymap.set("n", "<leader>tj", "<cmd>            :FloatermNew nvim -c 'let g:startify_disable_at_vimenter = 1 | Codi javascript'<CR>", { silent = true })
vim.keymap.set("n", "<leader>tk", "<C-\\><C-n><cmd> :FloatermKill<CR>", { silent = true })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
