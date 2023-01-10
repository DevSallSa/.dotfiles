vim.keymap.set("n", "<leader>fl", function()
  require("telescope.builtin").live_grep()
end, { desc = "[Telescope] Grep in files" })

vim.keymap.set("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "[Telescope] Show current buffers" })

vim.keymap.set("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end, { desc = "[Telescope] Show help" })

vim.keymap.set("n", "<leader>ft", function()
  require("telescope.builtin").treesitter()
end, { desc = "[Telescope] Treesitter symbols" })

vim.keymap.set("n", "<leader>ff", function()
  require("devsallsa.telescope").find_files()
end, { desc = "[Telescope] Find files" })

vim.keymap.set("n", "<leader>fg", function()
  require("telescope.builtin").git_files()
end, { desc = "[Telescope] Find files in git project" })

vim.keymap.set("n", "<leader>fw", function()
  require("devsallsa.telescope").search_workspaces()
end, { desc = "[Telescope] Find files in workspace folder" })

vim.keymap.set("n", "<leader>fd", function()
  require("devsallsa.telescope").search_dotfiles()
end, { desc = "[Telescope] Find files in dotfiles" })

vim.keymap.set("n", "<leader>fc", function()
  require("devsallsa.telescope").search_config()
end, { desc = "[Telescope] Find files in config folder" })

vim.keymap.set("n", "<leader>fs", function()
  require("devsallsa.telescope").search_scripts()
end, { desc = "[Telescope] Find scripts" })

vim.keymap.set("n", "<leader>fnc", function()
  require("devsallsa.telescope").search_neovim_config()
end, { desc = "[Telescope] Find neovim config" })
