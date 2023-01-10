local success, which_key = pcall(require, "which-key")
if not success then
  return
end

which_key.setup({})
