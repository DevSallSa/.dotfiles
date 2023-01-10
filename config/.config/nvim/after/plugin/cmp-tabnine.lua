-- Tabnine AI completion configuration
local success, tabnine = pcall(require, "cmp_tabnine.config")
if not success then
  return
end

tabnine.setup({
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  snippet_placeholder = "...",
})
