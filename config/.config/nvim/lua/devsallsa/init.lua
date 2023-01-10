--[[
|  \  |  \        \/      \|  \   |  \      \  \     /  \
| ▓▓\ | ▓▓ ▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓\ ▓▓   | ▓▓\▓▓▓▓▓▓ ▓▓\   /  ▓▓
| ▓▓▓\| ▓▓ ▓▓__   | ▓▓  | ▓▓ ▓▓   | ▓▓ | ▓▓ | ▓▓▓\ /  ▓▓▓
| ▓▓▓▓\ ▓▓ ▓▓  \  | ▓▓  | ▓▓\▓▓\ /  ▓▓ | ▓▓ | ▓▓▓▓\  ▓▓▓▓
| ▓▓\▓▓ ▓▓ ▓▓▓▓▓  | ▓▓  | ▓▓ \▓▓\  ▓▓  | ▓▓ | ▓▓\▓▓ ▓▓ ▓▓
| ▓▓ \▓▓▓▓ ▓▓_____| ▓▓__/ ▓▓  \▓▓ ▓▓  _| ▓▓_| ▓▓ \▓▓▓| ▓▓
| ▓▓  \▓▓▓ ▓▓     \\▓▓    ▓▓   \▓▓▓  |   ▓▓ \ ▓▓  \▓ | ▓▓
 \▓▓   \▓▓\▓▓▓▓▓▓▓▓ \▓▓▓▓▓▓     \▓    \▓▓▓▓▓▓\▓▓      \▓▓
--]]

require("devsallsa.set")
require("devsallsa.keymap")
require("devsallsa.plugins")
require("devsallsa.cmp-tabnine")
require("devsallsa.nvim-cmp")
require("devsallsa.lsp")
require("devsallsa.which-key")
require("devsallsa.nvim-treesitter")
require("devsallsa.telescope")
require("devsallsa.nvim-lightbulb")
require("devsallsa.fidget-nvim")
-- require("devsallsa.nvim-autopairs")

local xdg_config_home = os.getenv("XDG_CONFIG_HOME")
local nvim_config_path = xdg_config_home .. "/nvim"
local filetype_header_path = nvim_config_path .. "/filetype_header"

vim.opt.completeopt = { "menu", "menuone", "noselect" }
-- Add header to bash scripts
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    pattern = { "*.sh" },
    command = "0r " .. filetype_header_path .. "/sh_header.temp",
})

-- Format on save and delete trailing spaces
vim.api.nvim_create_augroup("FormatFile", { clear = false })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "FormatFile",
    command = "undojoin | Neoformat",
})
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "FormatFile",
    command = "%s/s+$//e",
})

-- For treesitter base folding
-- vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
--   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
--   callback = function()
--     vim.opt.foldmethod     = 'expr'
--     vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
--   end
-- })
