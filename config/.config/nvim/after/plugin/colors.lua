-- vim.g.devsallsa_colorscheme = "night-owl"
vim.g.devsallsa_colorscheme = "neofusion"
-- vim.g.devsallsa_colorscheme = "catppuccin-mocha"

vim.opt.syntax = "enable"
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.cmd.colorscheme(vim.g.devsallsa_colorscheme)

-- Git conflict colors
vim.api.nvim_set_hl(
  0,
  "ConflictMarkerBegin",
  { background = "#2f7366", bold = true }
)
vim.api.nvim_set_hl(
  0,
  "ConflictMarkerOurs",
  { background = "#2e5049", bold = true }
)
vim.api.nvim_set_hl(
  0,
  "ConflictMarkerTheirs",
  { background = "#344f69", bold = true }
)
vim.api.nvim_set_hl(
  0,
  "ConflictMarkerEnd",
  { background = "#2f628e", bold = true }
)
vim.api.nvim_set_hl(
  0,
  "ConflictMarkerCommonAncestorsHunk",
  { background = "#754a81", bold = true }
)
