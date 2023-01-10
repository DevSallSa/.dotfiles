-- Git gutter
vim.keymap.set("n", "]h", vim.cmd.GitGutterNextHunkCycle, {noremap = false})
vim.keymap.set("n", "<leader>hp", vim.cmd.GitGutterPreviewHunk, {noremap = false})
