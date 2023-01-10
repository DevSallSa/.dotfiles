local require_mark_success, mark = pcall(require, "harpoon.mark")
if not require_mark_success then
  return
end

local require_ui_success, ui = pcall(require, "harpoon.ui")
if not require_ui_success then
  return
end


vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<A-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<A-j>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<A-k>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<A-l>", function() ui.nav_file(4) end)
