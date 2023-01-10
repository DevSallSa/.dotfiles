-- Git conflicts plugin
vim.keymap.set("n", "<leader>co", vim.cmd.ConflictMarkerOurselves)
vim.keymap.set("n", "<leader>ct", vim.cmd.ConflictMarkerThemselves)
vim.keymap.set("n", "<leader>cb", vim.cmd.ConflictMarkerBoth)
vim.keymap.set("n", "<leader>c0", vim.cmd.ConflictMarkerNone)
vim.keymap.set("n", "<leader>cn", vim.cmd.ConflictMarkerNextHunk)
vim.keymap.set("n", "<leader>cp", vim.cmd.ConflictMarkerPrevHunk)
