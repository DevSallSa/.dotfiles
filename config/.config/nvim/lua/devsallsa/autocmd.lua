local xdg_config_home = os.getenv("XDG_CONFIG_HOME")
local nvim_config_path = xdg_config_home .. "/nvim"
local filetype_header_path = nvim_config_path .. "/filetype_header"
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Custom groups
local format_file_group = augroup("FormatFile", { clear = false })
local yank_group = augroup("HighlightYank", {})
local remap_key_group = augroup("RemapKey", {})

-- Custom autocmd
-- Add header to bash scripts
autocmd({ "BufNewFile" }, {
  pattern = { "*.sh" },
  command = "0r " .. filetype_header_path .. "/sh_header.temp",
})

-- Delete trailing spaces
autocmd("BufWritePre", {
  group = format_file_group,
  command = "%s/s+$//e",
})

-- Highlight when yanking
autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- Remap capslock key to escape
autocmd("VimEnter", {
  group = remap_key_group,
  command = "silent !setxkbmap -option caps:escape",
})

autocmd("VimLeave", {
  group = remap_key_group,
  command = "silent !setxkbmap -option",
})

-- For treesitter base folding
-- autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
--   group = augroup('TS_FOLD_WORKAROUND', {}),
--   callback = function()
--     vim.opt.foldmethod     = 'expr'
--     vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
--   end
-- })
