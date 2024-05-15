-- Lazy.nvim Setup
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- OPTION SETTINGS ------------------------------------------------------------
vim.g.mapleader = ' ' -- Set <space> as the leader key
vim.g.maplocalleader = '\\'
vim.o.hlsearch = true -- Set highlight on search
vim.wo.number = true -- Make line numbers default
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true
-- Tab 4 spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.wo.signcolumn = 'yes' -- Keep signcolumn on by

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Make sure your terminal supports this
vim.o.termguicolors = true

-- Show special chars
vim.o.listchars = 'eol:$,tab:>>,trail:~,extends:❯,precedes:❮,space:·,nbsp:§,multispace:┄┄┄┊'
vim.o.list = true

vim.o.magic = true
vim.o.wrap = false

-- Folding
vim.o.foldenable = true
vim.o.foldmethod = 'marker'

vim.o.formatoptions = 'cq'

vim.o.textwidth = 130
vim.o.wrapmargin = 130

local keymap = vim.keymap.set

keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- General
keymap('n', '<leader>ww', '<cmd>w!<CR>', { desc = 'Save buffer' })
keymap('n', '<leader>wa', '<cmd>wall!<CR>', { desc = 'Save all buffers' })
keymap('n', '<leader>qq', '<cmd>q!<CR>', { desc = 'Quit buffer' })
keymap('n', '<leader>qa', '<cmd>qall!<CR>', { desc = 'Quit all buffers' })

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = '' })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, desc = '' })

-- Mejor visualización en la búsqueda
keymap('n', 'n', 'nzzzv', { desc = 'Search next and Center' })
keymap('n', 'N', 'Nzzzv', { desc = 'Search prev and Center' })
keymap('n', 'g,', 'g,zvzz', { desc = '' })
keymap('n', 'g;', 'g;zvzz', { desc = '' })

-- Mejor desplazamiento
keymap('n', '<C-d>', '<C-d>zz', { desc = 'Page down and center' })
keymap('n', '<C-u>', '<C-u>zz', { desc = 'Page up and center' })

-- Paste
keymap('', ']p', 'o<Esc>p', { desc = 'Paste below' })
keymap('n', ']P', 'O<Esc>p', { desc = 'Paste above' })

-- Better escape
keymap('n', '<Esc>', '<cmd>nohl<CR>', { desc = 'ESC in normal mode' })
keymap({ 'i', 'x', 'n' }, '<C-]>', '<ESC>', { desc = 'Alternate escape' })
keymap('t', '<C-]>', '<C-\\><C-n>', { desc = 'Escape in terminal mode' })

-- Movimientos Dvorak
-- Normal Mode
keymap('n', '<M-r>', 'h')
keymap('n', '<M-t>', 'j')
keymap('n', '<M-n>', 'k')
keymap('n', '<M-s>', 'l')
-- Visual Mode
keymap('x', '<M-r>', 'h')
keymap('x', '<M-t>', 'j')
keymap('x', '<M-n>', 'k')
keymap('x', '<M-s>', 'l')
-- Insert Mode
keymap('i', '<M-r>', '<Left>')
keymap('i', '<M-t>', '<Down>')
keymap('i', '<M-n>', '<Up>')
keymap('i', '<M-s>', '<Right>')
-- Terminal mode
keymap('t', '<C-r>', '<C-\\><C-n><C-w>h')
keymap('t', '<C-t>', '<C-\\><C-n><C-w>j')
keymap('t', '<C-n>', '<C-\\><C-n><C-w>k')
keymap('t', '<C-s>', '<C-\\><C-n><C-w>l')
-- Movimientos entre buffers - (Dvorak latam)
keymap('n', '<C-r>', '<C-w>h', { desc = 'Go left buffer' })
keymap('n', '<C-t>', '<C-w>j', { desc = 'Go upper buffer' })
keymap('n', '<C-n>', '<C-w>k', { desc = 'Go lower buffer' })
keymap('n', '<C-s>', '<C-w>l', { desc = 'Go right buffer' })

-- Buffer
keymap('n', '<C-h>', '<cmd>bp<CR>', { desc = 'Next buffer' })
keymap('n', '<C-l>', '<cmd>bn<CR>', { desc = 'Prev buffer' })
keymap('n', '<leader>bd', '<cmd>bd<CR>', { desc = 'Delete buffer' })

-- Identación
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- Pegar sobre el texto actualmente seleccionado sin copiarlo
keymap('v', 'p', '"_dp')
keymap('v', 'P', '"_dP')
-- Copiar desde el cursor hasta el final de línea
keymap('n', 'Y', 'y$')
-- X clipboard
keymap('x', '<leader>y', '"+y', { desc = 'Copy to Clipboard' })
keymap('n', '<leader>p', '"+p', { desc = 'Paste from Clipboard' })
keymap('n', '<leader>P', '"+P', { desc = 'Paste before from Clipboard' })

-- Insertar líneas en blanco
keymap('n', '<leader>]', 'o<Esc>', { desc = 'Insert line next' })
keymap('n', '<leader>[', 'O<Esc>', { desc = 'Insert line prev' })

-- Undo/Redo
keymap('n', '<leader>(', ':undo<CR>', { desc = 'Undo action' })
keymap('n', '<leader>)', ':redo<CR>', { desc = 'Redo action' })

-- Auto indent
keymap('n', 'i', function()
  if #vim.fn.getline '.' == 0 then
    return [["_cc]]
  else
    return 'i'
  end
end, { expr = true })

-- LAZYNVIM SETUP -------------------------------------------------------------

require('lazy').setup {
  spec = {
    { import = 'pde' },
  },
  ui = { border = 'double' },
  defaults = { lazy = true, version = nil },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
}

vim.o.background = 'dark'
vim.cmd [[colorscheme gruvbox]]

require 'nvim.autocmd'
-- Winbar
require 'nvim.winbar'
vim.opt.winbar = "%{%v:lua.require'nvim.winbar'.get_winbar()%}"
