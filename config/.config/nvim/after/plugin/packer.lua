local success, packer = pcall(require, "packer")
if not success then
  return
end

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data")
    .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

-- TODO: use lua for creating autocmd
-- Sync config each time this file is updated.
-- Clean, update and/or install plugins.
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

local packer_bootstrap = ensure_packer()

return packer.startup({
  function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Quick config LSP
    use({
      -- Managing and installing lsp servers
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    })

    use({
      "jose-elias-alvarez/null-ls.nvim",
      "jayp0521/mason-null-ls.nvim",
    })

    -- Java LSP
    use("mfussenegger/nvim-jdtls")

    -- Indicates if "code actions" are possible
    use("kosayoda/nvim-lightbulb")

    -- Autocompletion plugin
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/nvim-cmp")

    -- Tabnine AI plugin for nvim-cmp
    use({
      "tzachar/cmp-tabnine",
      run = "./install.sh",
      requires = "hrsh7th/nvim-cmp",
    })

    -- Adding Icons to nvim-cmp
    use("onsails/lspkind-nvim")

    -- Fuzzy finder and navigations
    use({
      "nvim-telescope/telescope.nvim",
      requires = { "nvim-lua/plenary.nvim" },
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "nvim-telescope/telescope-ui-select.nvim" })

    use("ThePrimeagen/harpoon")

    -- Refactoring library
    -- TODO:
    -- use({
    --   "ThePrimeagen/refactoring.nvim",
    --   requires = {
    --     { "nvim-lua/plenary.nvim" },
    --     { "nvim-treesitter/nvim-treesitter" },
    --   },
    -- })

    -- Status bar for (neo)vim
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "nvim-tree/nvim-web-devicons" },
    })

    -- lsp progression UI
    use("arkav/lualine-lsp-progress")

    -- Autopairs
    use("windwp/nvim-autopairs")

    -- Autoclose and rename html tag by using treesitter
    use({
      "windwp/nvim-ts-autotag",
      requires = {

        -- Treesitter for syntax coloring
        "nvim-treesitter/nvim-treesitter",
        run = function()
          local ts_update = require("nvim-treesitter.install").update({
            with_sync = true,
          })
          ts_update()
        end,
      },
    })

    -- Using snippets
    use("SirVer/ultisnips")
    use("honza/vim-snippets")
    use("quangnguyen30192/cmp-nvim-ultisnips")

    -- use("rstacruz/vim-closer")

    -- Automatic closing of quotes, brackets, etc...
    -- Want to replace for nvim-autopair
    -- use("Raimondi/delimitMate")

    -- Allow to surround texts with tags, brackets, etc...
    use("tpope/vim-surround")

    -- Give a startup menu when opening (neo)vim
    -- without argument
    use("mhinz/vim-startify")

    -- Displaying a popup of possible vim keybindings
    -- in normal mode. The popup appears after 1s
    use("folke/which-key.nvim")

    -- Show edit lines of current file inside git project
    use("airblade/vim-gitgutter")

    -- Show commit and its author in line
    use("f-person/git-blame.nvim")

    -- Manage git conflicts
    -- use({
    --   "akinsho/git-conflict.nvim",
    --   tag = "*",
    --   config = function()
    --     require("git-conflict").setup()
    --   end,
    -- })
    use("rhysd/conflict-marker.vim")

    -- Show css color
    use("ap/vim-css-color")

    -- Edit and preview markdown files
    use({
      "iamcco/markdown-preview.nvim",
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
    })

    -- Comment lines
    use("tomtom/tcomment_vim")

    -- Floating terminal
    use("voldikss/vim-floaterm")

    -- Code scratchpad (RunJS like)
    use("metakirby5/codi.vim")

    -- Repeat plugin commands
    use("tpope/vim-repeat")

    -- Colorscheme
    use("haishanh/night-owl.vim")
    use("diegoulloao/neofusion.nvim")
    use({ "catppuccin/nvim", as = "catppuccin" })

    -- Vim be good game
    use("ThePrimeagen/vim-be-good")

    -- Check history
    use("mbbill/undotree")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
      packer.sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
  },
})
