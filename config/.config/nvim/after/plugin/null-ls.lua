local success, null_ls = pcall(require, "null-ls")
if not success then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local code_actions = null_ls.builtins.code_actions
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
  sources = {
    diagnostics.eslint_d.with({
      diagnostics_format = "[eslint] #{m}\n(#{c})",
    }),
    diagnostics.pylint,
    diagnostics.cpplint,
    diagnostics.hadolint,
    diagnostics.jsonlint,
    diagnostics.pylint.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
      end,
    }),
    diagnostics.yamllint,
    -- TODO: Explore refactoring.nvim
    -- code_actions.refactoring,
    code_actions.eslint_d,
    formatting.prettierd.with({
      filetypes = {
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "html",
        "css",
        "angular",
        "vue",
        "markdown",
      },
    }),
    formatting.stylua.with({
      extra_args = {
        "--column-width",
        "80",
        "--line-endings",
        "Unix",
        "--indent-type",
        "Spaces",
        "--indent-width",
        "2",
      },
    }),
    formatting.clang_format.with({
      filetypes = { "c", "cpp", "cs" },
      extra_args = { "-style=llvm" },
    }),
    formatting.black.with({
      extra_args = { "-l 79" },
    }),
    formatting.jq,
  },

  -- Format on save
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufnr,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
