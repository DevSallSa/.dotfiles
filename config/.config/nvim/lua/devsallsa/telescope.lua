-- Telescope configs
local success, telescope = pcall(require, "telescope")
if not success then
  return
end

local success1, themes = pcall(require, "telescope.themes")
if not success1 then
  return
end

local success2, builtin = pcall(require, "telescope.builtin")
if not success2 then
  return
end

local xdg_config_home = os.getenv("XDG_CONFIG_HOME")
local dotfiles_folder = os.getenv("DOTFILES")
local workspaces_folder = os.getenv("WORKSPACES")
local custom_script_folder = os.getenv("CUSTOM_SCRIPTS_DIR")

telescope.setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    file_ignore_patterns = {
      "node_modules",
      ".git/+",
      ".ccls-cache",
      ".var/*",
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    ["ui-select"] = {
      themes.get_dropdown({}),
    },
  },
})

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
telescope.load_extension("fzf")
telescope.load_extension("ui-select")

-- This is some custom features that I added to Telescope
local custom_features = {}
custom_features.search_workspaces = function()
  builtin.find_files({
    prompt_title = "🔧 Workspaces 🔧",
    cwd = workspaces_folder,
    hidden = true,
  })
end

custom_features.search_dotfiles = function()
  builtin.find_files({
    prompt_title = "🔧 DOTFILES 🔧",
    cwd = dotfiles_folder,
    hidden = true,
  })
end

custom_features.search_config = function()
  builtin.find_files({
    prompt_title = "⚙️  Find Config ⚙️ ",
    cwd = xdg_config_home,
    hidden = true,
  })
end

custom_features.search_neovim_config = function()
  builtin.find_files({
    prompt_title = "⚙️  Find neovim config ⚙️ ",
    cwd = xdg_config_home .. "/nvim",
    hidden = true,
  })
end

custom_features.search_scripts = function()
  builtin.find_files({
    prompt_title = "💻 Find script 💻",
    cwd = custom_script_folder,
    hidden = true,
  })
end

custom_features.find_files = function()
  builtin.find_files({
    hidden = true,
  })
end
return custom_features
