local require_mason_success, mason = pcall(require, "mason")
if not require_mason_success then
  return
end

local require_lspconfig_success, mason_lspconfig =
  pcall(require, "mason-lspconfig")
if not require_lspconfig_success then
  return
end

local require_null_ls_success, mason_null_ls = pcall(require, "mason-null-ls")
if not require_null_ls_success then
  return
end

local servers = {
  "angularls",
  "cssls",
  "clangd",
  "dockerls",
  "docker_compose_language_service",
  "emmet_ls",
  -- "hls",
  "html",
  "pyright",
  "lua_ls",
  "tsserver",
  "vimls",
}

local linter_and_formatter = {
  -- linter
  "cpplint",
  "eslint_d",
  "hadolint",
  "jsonlint",
  "pylint",
  "yamllint",

  -- formatter
  "black",
  "clang_format",
  "jq",
  "prettierd",
  "stylua",
}

-- For mason to work properly, make sure to have package manager for
-- Node, rust, haskell, python3.XX-venv, etc...
mason.setup({
  ui = {
    border = "rounded",
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

mason_lspconfig.setup({
  ensure_installed = servers,
})

mason_null_ls.setup({
  -- automatic_setup = true,
  automatic_installation = true,
  ensure_installed = linter_and_formatter,
})
