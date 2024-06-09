local M = {}

local navic = require 'nvim-navic'
local icons = {
  ui = {
    BigCircle = ' ',
    BigUnfilledCircle = ' ',
    BookMark = ' ',
    Bug = ' ',
    Calendar = ' ',
    Check = ' ',
    ChevronRight = '',
    Circle = ' ',
    Close = ' ',
    Code = ' ',
    Comment = ' ',
    Crosshair = ' ',
    Dashboard = ' ',
    Fire = ' ',
    Gear = ' ',
    History = ' ',
    Lightbulb = ' ',
    List = ' ',
    Lock = ' ',
    NewFile = ' ',
    Note = ' ',
    Package = ' ',
    Pencil = ' ',
    Project = ' ',
    Search = ' ',
    SignIn = ' ',
    Table = ' ',
    Telescope = ' ',
  },
  diagnostics = {
    Error = ' ',
    Hint = ' ',
    Information = ' ',
    Question = ' ',
    Warning = ' ',
  },
  lsp = {
    server_installed = '✓',
    server_pending = '➜',
    server_uninstalled = '✗',
  },
  git = {
    Add = ' ',
    Diff = ' ',
    Ignore = ' ',
    Mod = ' ',
    Remove = ' ',
    Rename = ' ',
    Repo = ' ',
  },
}
local colors = {
  white = '#D3C6AA',
  darker_black = '#272f35',
  black = '#2b3339', --  nvim bg
  black2 = '#323a40',
  one_bg = '#333b41',
  one_bg2 = '#363e44',
  one_bg3 = '#3a4248',
  telescope_bg = '#3a4248',
  grey = '#282828',
  grey_fg = '#50585e',
  grey_fg2 = '#5e666c',
  light_grey = '#61696f',
  telescope_prompt = '#4a5258',
  red = '#e67e80',
  baby_pink = '#ce8196',
  pink = '#ff75a0',
  line = '#3a4248', -- for lines like vertsplit
  green = '#83c092',
  vibrant_green = '#a7c080',
  dark_green = '#8ea767',
  nord_blue = '#78b4ac',
  blue = '#7393b3',
  dark_blue = '#5a7a9a',
  yellow = '#dbbc7f',
  sun = '#d1b171',
  purple = '#d699b6',
  dark_purple = '#ae718e',
  teal = '#69a59d',
  orange = '#e69875',
  cyan = '#95d1c9',
  statusline_bg = '#2e363c',
  lightbg = '#3d454b',
  lightbg2 = '#333b41',
  pmenu_bg = '#83c092',
  folder_bg = '#7393b3',
}

function get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

vim.api.nvim_set_hl(0, 'WinBarSeparator', { fg = colors.grey })
vim.api.nvim_set_hl(0, 'WinBarFilename', { fg = colors.purple, bg = colors.grey })
vim.api.nvim_set_hl(0, 'WinBarContext', { fg = colors.purple, bg = colors.grey })

M.winbar_filetype_exclude = {
  'help',
  'startify',
  'dashboard',
  'packer',
  'neogitstatus',
  'NvimTree',
  'Trouble',
  'alpha',
  'lir',
  'Outline',
  'spectre_panel',
  'toggleterm',
}

local excludes = function()
  if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

local function is_empty(s)
  return s == nil or s == ''
end

local function getTypeIcon(ft)
  local ic = require('nvim-web-devicons').get_icon_by_filetype(ft)
  if is_empty(ic) then
    return icons.ui.Crosshair .. ' '
  end

  return ic .. ' '
end

local function get_modified()
  if get_buf_option 'mod' then
    local mod = icons.git.Mod
    return '%#WinBarFilename#' .. getTypeIcon(vim.bo.filetype) .. mod .. ' ' .. '%t' .. '%*'
  end
  return '%#WinBarFilename#' .. getTypeIcon(vim.bo.filetype) .. '%t' .. '%*'
end

local function get_location()
  local location = navic.get_location()
  if not is_empty(location) then
    return '%#WinBarContext#' .. ' ' .. icons.ui.ChevronRight .. ' ' .. location .. '%*'
  end
  return ''
end

function M.get_winbar()
  if excludes() then
    return ''
  end
  if navic.is_available() then
    return ' %#WinBarSeparator#'
      --.. "%="
      .. '█'
      .. '%*'
      .. get_modified()
      .. get_location()
      .. '%#WinBarSeparator#'
      .. '█'
      .. '%*'
  else
    return ' %#WinBarSeparator#' .. '█' .. '%*' .. get_modified() .. '%#WinBarSeparator#' .. '█' .. '%*'
  end
end

return M
