local require_lualine_success, lualine = pcall(require, "lualine")
if not require_lualine_success then
  return
end

local require_gitblame_success, gitblame = pcall(require, "gitblame")
if not require_gitblame_success then
  return
end

local require_icons_success, devicons = pcall(require, "nvim-web-devicons")
if not require_icons_success then
  return
end

local icons =
  devicons.get_icon_by_filetype(vim.api.nvim_buf_get_option(0, "filetype"))

-- Color table for highlights
local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  white = "#ffffff",
}

-- Inserts a component in lualine_c at left section
local function ins_left(config, component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
-- local function ins_right(config, component)
-- 	table.insert(config.sections.lualine_x, component)
-- end

local config2 = {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "fileformat",
      {
        "diagnostics",

        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " " },
        diagnostics_color = {
          color_error = { fg = colors.red },
          color_warn = { fg = colors.yellow },
          color_info = { fg = colors.cyan },
        },
      },
    },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {
      {
        "filename",
        icon = icons,
      },
    },
    lualine_b = {
      {
        gitblame.get_current_blame_text,
        cond = gitblame.is_blame_text_available,
      },
    },
    lualine_c = {},
    lualine_x = {
      {
        "lsp_progress",
        -- display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' }},
        -- With spinner
        -- display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' }},
        colors = {
          percentage = colors.cyan,
          title = colors.cyan,
          message = colors.cyan,
          spinner = colors.cyan,
          lsp_client_name = colors.magenta,
          use = true,
        },
        separators = {
          component = " ",
          progress = " | ",
          -- message = { pre = '(', post = ')'},
          percentage = { pre = "", post = "%% " },
          title = { pre = "", post = ": " },
          lsp_client_name = { pre = "[", post = "]" },
          spinner = { pre = "", post = "" },
          message = {
            commenced = "In Progress",
            completed = "Completed",
          },
        },
        display_components = {
          "lsp_client_name",
          "spinner",
          { "title", "percentage", "message" },
        },
        timer = {
          progress_enddelay = 500,
          spinner = 1000,
          lsp_client_name_enddelay = 1000,
        },
        spinner_symbols = {
          "🌑 ",
          "🌒 ",
          "🌓 ",
          "🌔 ",
          "🌕 ",
          "🌖 ",
          "🌗 ",
          "🌘 ",
        },
      },
    },
    lualine_y = { "diff" },
    lualine_z = { "branch" },
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

-- Center next component
ins_left(config2, {
  function()
    return "%="
  end,
})

-- Lsp server name .
ins_left(config2, {
  function()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  separator = { left = "X", right = "X" },
  icon = " LSP:",
  color = { fg = colors.white, gui = "bold" },
})

-- Now don't forget to initialize lualine
lualine.setup(config2)
