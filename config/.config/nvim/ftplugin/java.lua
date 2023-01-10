local success, jdtls = pcall(require, "jdtls")
if not success then
  return
end

local require_jdtls_setup_success, jdtls_setup = pcall(require, "jdtls.setup")
if not require_jdtls_setup_success then
  return
end

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local jdtls_install_location = os.getenv("XDG_DATA_HOME") .. "/eclipse-jdtls"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_folder = os.getenv("WORKSPACES")
  .. "/Java-projects/"
  .. project_name
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.xml" }

local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    jdtls_install_location
      .. "/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    -- "/home/devsallsa/.local/share/eclipse-jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
    "-configuration",
    jdtls_install_location .. "/config_linux",
    "-data",
    workspace_folder,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = jdtls_setup.find_root(root_markers),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      codeGeneration = {
        generateComments = true,
        hashCodeEquals = {
          useJava7Objects = true,
        },
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
      completion = {
        importOrder = { "java", "javax", "com", "org" },
      },
      format = {
        enabled = true,
        tabSize = 2,
      },
      import = {
        gradle = {
          enabled = true,
        },
        maven = {
          enabled = true,
        },
        exclusions = {
          "**/node_modules/**",
          "**/.metadata/**",
          "**/archetype-resources/**",
          "**/META-INF/maven/**",
          "/**/test/**",
        },
      },
      saveActions = {
        organizeImports = true,
      },
      signatureHelp = { enabled = true },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)

-- to check; specific keymap in lua

-- Functional wrapper for mapping custom keybindings
local bufopts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<leader><A-o>", function()
  jdtls.organize_imports()
end, bufopts)
keymap("n", "<leader>xv", function()
  jdtls.extract_variable()
end, bufopts)
keymap("v", "<leader>xv<Esc>", function()
  jdtls.extract_variable(true)
end, bufopts)
keymap("n", "<leader>xc", function()
  jdtls.extract_constant()
end, bufopts)
keymap("v", "<leader>xc<Esc>", function()
  jdtls.extract_constant(true)
end, bufopts)
keymap("v", "<leader>xm<Esc>", function()
  jdtls.extract_method(true)
end, bufopts)
keymap("n", "K", vim.lsp.buf.hover, bufopts)
keymap("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
keymap("n", "gD", vim.lsp.buf.declaration, bufopts)
keymap("n", "gd", vim.lsp.buf.definition, bufopts)
keymap("n", "gr", vim.lsp.buf.references, bufopts)
keymap("n", "gti", vim.lsp.buf.implementation, bufopts)
keymap("n", "<leader>jca", vim.lsp.buf.code_action, bufopts)
keymap("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
keymap("n", "<leader>fo", vim.lsp.buf.formatting, bufopts)
keymap("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", bufopts)
keymap("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
