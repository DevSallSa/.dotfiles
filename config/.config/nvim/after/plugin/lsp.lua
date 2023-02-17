local require_nvim_lsp_success, nvim_lsp = pcall(require, "lspconfig")
if not require_nvim_lsp_success then
  return
end

local require_util_success, util = pcall(require, "lspconfig/util")
if not require_util_success then
  return
end

local require_cmp_success, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not require_cmp_success then
  return
end

local capabilities = cmp_nvim_lsp.default_capabilities()
local server_settings = {
  ["hls"] = {
    haskell = {
      -- formattingProvider = 'ormolu',
    },
  },
  ["lua_ls"] = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

local path = util.path
local keymap = vim.keymap.set

local on_attach = function(client, bufnr)
  -- use these keymap only to buffers which have LSP
  local bufopts = { buffer = bufnr, remap = false }

  keymap("n", "K", function()
    vim.lsp.buf.hover()
  end, bufopts)
  keymap("n", "<C-k>", function()
    vim.lsp.buf.signature_help()
  end, bufopts)
  keymap("n", "gD", function()
    vim.lsp.buf.declaration()
  end, bufopts)
  keymap("n", "gd", function()
    vim.lsp.buf.definition()
  end, bufopts)
  keymap("n", "gr", function()
    vim.lsp.buf.references()
  end, bufopts)
  keymap("n", "gti", function()
    vim.lsp.buf.implementation()
  end, bufopts)
  keymap("n", "<leader>D", function()
    vim.lsp.buf.type_definition()
  end, bufopts)
  keymap("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
  end, bufopts)
  keymap("n", "<leader>rca", function()
    vim.lsp.buf.range_code_action()
  end, bufopts)
  keymap("n", "<leader>rn", function()
    vim.lsp.buf.rename()
  end, bufopts)
  keymap("n", "<leader>wa", function()
    vim.lsp.buf.add_workspace_folder()
  end, bufopts)
  keymap("n", "<leader>wr", function()
    vim.lsp.buf.remove_workspace_folder()
  end, bufopts)
  keymap("n", "<leader>fo", function()
    vim.lsp.buf.formatting()
  end, bufopts)
  keymap("n", "<leader>dl", function()
    vim.cmd.Telescope("diagnostics")()
  end, bufopts)
  keymap("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  -- Customzing how diagnostics are displayed
  vim.diagnostic.config({
    -- virtual_text = {
    --     prefix = "●", -- Could be '●', '▎', 'x'
    -- },
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
  })
end

-- Customizing diagnostics signs
-- You need to pay attention to if your terminal support emoji and render them
-- correcty.
-- Else, you will have glitches. For example, the emojis in the upper line
-- aren't correctly supported by Kitty terminal; well at least not all of them.
-- In kitty, I use the ctrl+shift+u to see all well rendered emoji.
local signs = { Error = "❌", Warn = "", Hint = "💡", Info = "🔔" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end
  -- Find and use virtualenv from pipenv in workspace directory.
  local match = vim.fn.glob(path.join(workspace, "Pipfile"))
  if match ~= "" then
    local venv =
      vim.fn.trim(vim.fn.system("PIPENV_PIPFILE=" .. match .. " pipenv --venv"))
    return path.join(venv, "bin", "python")
  end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

--[[
--
--  THIS SECTION IS FOR CONFIGURING LSP SERVER
--
--]]

-- Config pour le server LSP de Python
nvim_lsp.pyright.setup({
  capabilities = capabilities,
  on_attach = function()
    require("lsp_signature").on_attach({
      hint_enable = false,
    })
    return on_attach
  end,
  on_init = function(client)
    client.config.settings.python.pythonPath =
      get_python_path(client.config.root_dir)
  end,
})

-- Config pour le server LSP de VimL
nvim_lsp.vimls.setup({
  cmd = { "vim-language-server", "--stdio" },
  filetypes = { "vim" },
  init_options = {
    diagnostic = {
      enable = true,
    },
    indexes = {
      count = 3,
      gap = 100,
      projectRootPatterns = {
        "runtime",
        "nvim",
        ".git",
        "autoload",
        "plugin",
      },
      runtimepath = true,
    },
    iskeyword = "@,48-57,_,192-255,-#",
    runtimepath = "",
    suggest = {
      fromRuntimepath = true,
      fromVimruntime = true,
    },
    vimruntime = "",
  },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Config pour le server LSP de Javascript/TypeScript
nvim_lsp.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Config pour le server LSP de C/C++
nvim_lsp.clangd.setup({})

-- Config pour le server LSP de Haskell
nvim_lsp.hls.setup({
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "hs", "haskell", "lhaskell" },
  root_dir = util.root_pattern(
    "*.cabal",
    "stack.yaml",
    "cabal.project",
    "package.yaml",
    "hie.yaml"
  ),
  single_file_support = true,
  settings = server_settings["hls"],
  lspinfo = function(cfg)
    local extra = {}
    local function on_stdout(_, data, _)
      local version = data[1]
      table.insert(extra, "version:   " .. version)
    end

    local opts = {
      cwd = cfg.cwd,
      stdout_buffered = true,
      on_stdout = on_stdout,
    }
    local chanid = vim.fn.jobstart({ cfg.cmd[1], "--version" }, opts)
    vim.fn.jobwait({ chanid })
    return extra
  end,
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Config for Lua LSP client
nvim_lsp.lua_ls.setup({
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_dir = util.root_pattern(
    ".luarc.json",
    ".luacheckrc",
    ".stylua.toml",
    "selene.toml",
    ".git"
  ),
  settings = server_settings["lua_ls"],
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Angular LSP client
nvim_lsp.angularls.setup({})

-- Config for html and css completion + snippets
-- Enable (broadcasting) snippet capability for completion
local html_css_capabilities = vim.lsp.protocol.make_client_capabilities()
html_css_capabilities.textDocument.completion.completionItem.snippetSupport =
  true

nvim_lsp.html.setup({
  capabilities = html_css_capabilities,
})

nvim_lsp.cssls.setup({
  capabilities = html_css_capabilities,
})

nvim_lsp.emmet_ls.setup({
  capabilities = html_css_capabilities,
  filetypes = {
    "html",
    "typescriptreact",
    "javascriptreact",
    "css",
    "sass",
    "scss",
    "less",
  },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
})

--[[
--
--  THIS SECTION IS FOR LSP SERVER THAT I WANT TO USE OR REMOVE
--
--]]

-- Config for Java LSP client
-- nvim_lsp.java_language_server.setup({
--     cmd = {
--         "/home/devsallsa/.local/share/nvim/bundle/java-language-server/dist/lang_server_linux.sh",
--     },
--     filetypes = { "java" },
--     root_dir = function(startpath)
--         return M.search_ancestors(startpath, matcher)
--     end,
--     settings = {},
-- })

-- Need to install ccls. I build the binary from source in /usr/local/bin/
-- nvim_lsp.ccls.setup({
--     cmd = { "ccls" },
--     init_options = {
--         cache = {
--             directory = "/tmp/ccls-cache",
--         },
--         index = {
--             thread = 0,
--         },
--         completion = {
--             filterAndSort = false,
--         },
--     },
--     capabilities = capabilities,
--     on_attach = on_attach,
-- })
