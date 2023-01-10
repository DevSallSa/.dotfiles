-- Editor config
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.showtabline = 2
vim.opt.showmode = false
vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- For activating specific settings for a filetype
vim.opt.filetype = "plugin-on"

-- Change tab to 2 spaces; check :h
vim.opt.tabstop = 4
vim.opt.softtabstop = 0
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.incsearch = true

-- Font, unicode, etc...
vim.opt.compatible = false
vim.opt.bomb = false
vim.opt.encoding = "utf-8"
vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h15"

-- Netrw
-- vim.g.netrw_liststyle = 3
