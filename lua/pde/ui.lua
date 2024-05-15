return {
  {
    'ellisonleao/gruvbox.nvim',
    config = true,
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = '', -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = false,
    },
    priority = 1000,
  },
  {
    'j-hui/fidget.nvim',
    lazy = false,
    opts = {
      notification = {
        filter = vim.log.levels.INFO, -- Minimum notifications level
        history_size = 128, -- Number of removed messages to retain in history
        override_vim_notify = true, -- Automatically override vim.notify() with Fidget
        window = {
          normal_hl = 'Operator',
          border = 'rounded',
        },
      },
    },
  },
  {
    'liuchengxu/vista.vim',
    cmd = { 'Vista' },
    init = function()
      vim.g.vista_ctags_cmd = { go = 'gotags' }
      vim.keymap.set('n', '<leader>vv', ':Vista!!<CR>')
    end,
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    cmd = { 'Oil' },
    keys = {
      { '-', '<cmd>Oil<cr>', desc = 'Open parent directory' },
    },
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'feline-nvim/feline.nvim',
    lazy = false,
    config = function()
      require('feline').setup()
    end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      local harpoon = require 'harpoon'
      harpoon:setup()
      vim.keymap.set('n', '<leader>a', function()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set('n', '<A-m>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<A-w>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<A-v>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<A-z>', function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<A-h>', function()
        harpoon:list():prev()
      end)
      vim.keymap.set('n', '<A-l>', function()
        harpoon:list():next()
      end)
    end,
  },
}
