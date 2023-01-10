local require_npairs_success, npairs = pcall(require, "nvim-autopairs")
if not require_npairs_success then
  return
end

local require_rule_success, Rule = pcall(require, "nvim-autopairs.rule")
if not require_rule_success then
  return
end

local require_ts_conds_success, ts_conds =
  pcall(require, "nvim-autopairs.ts-conds")
if not require_ts_conds_success then
  return
end

npairs.setup({
  check_ts = true,
  ts_config = {
    lua = { "string" }, -- it will not add a pair on that treesitter node
    javascript = { "template_string" },
    java = false, -- don't check treesitter on java
  },
  enable_check_bracket_line = false,
  ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
})

-- press % => %% only while inside a comment or string
npairs.add_rules({
  Rule("%", "%", "lua"):with_pair(ts_conds.is_ts_node({ "string", "comment" })),
  Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({ "function" })),
})
