local function header()
  return [[
        .&(            &@             /&,
      &&&&(           @@@@@           /&&&@
   ,&&& .&(         @@@@@@@@@         /&, %&&*   ╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮
 .&&    .&(       @@@@@@@@@@@@        /&,    &&, │ $ ││ & ││ [ ││ { ││ ( ││ < ││ > ││ ) ││ } ││ ] ││ / |│ ` ││ + │
 .&     .&(      @@@@@@@@@@@@@@@      /&,     &, ╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯
 .&     .&(    @@@@@@@@@@@@@@@@@@@    /&,     &,        ╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮
 .&     .&(  @@@@@@@@@@. @@@@@@@@@@.  /&,     &,        │ Ñ ││ , ││ . ││ P ││ Y ││ F ││ G ││ C ││ H ││ L ││ ´ ││ ^ │
 @&     .&( @@@@@@@@@@     @@@@@@@@@@ /&,     &,        ╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯
 &&     &&@@@@@@@@@@        %@@@@@@@@@@&&     &,         ╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮
 &&   &&&@@@@@@@@@@           @@@@@@@@@@@&&   &,         │ A ││ O ││ E ││ I ││ U ││ D ││ R ││ T ││ N ││ S ││ ' ││ \ │
 && %&&@@@@@@@@@@               @@@@@@@@@@&&% &,         ╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯
 .&&&@@@@@@@@@@%                 #@@@@@@@@@(&&&,        ╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮
    &@@@@@@@@@                     &@@@@@@@@@           │ * ││ - ││ Q ││ J ││ K ││ X ││ B ││ M ││ W ││ V ││ Z │
       @@@@@                        *@@@@@.             ╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯
         %#          NEOVIM           (&
  ]]
end

return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
    opts = {
      ui = { border = 'double' },
    },
  },
  {
    'echasnovski/mini.nvim',
    version = false,
    init = function()
      require('mini.clue').setup {
        triggers = {
          -- Leader triggers
          { mode = 'n', keys = '<Leader>' },
          { mode = 'x', keys = '<Leader>' },
          -- Built-in completion
          { mode = 'i', keys = '<C-x>' },

          -- `g` key
          { mode = 'n', keys = 'g' },
          { mode = 'x', keys = 'g' },

          -- Marks
          { mode = 'n', keys = "'" },
          { mode = 'n', keys = '`' },
          { mode = 'x', keys = "'" },
          { mode = 'x', keys = '`' },

          -- Registers
          { mode = 'n', keys = '"' },
          { mode = 'x', keys = '"' },
          { mode = 'i', keys = '<C-r>' },
          { mode = 'c', keys = '<C-r>' },

          -- Window commands
          { mode = 'n', keys = '<C-w>' },
        },

        clues = {
          { mode = 'n', keys = '<Leader>f', desc = 'Find' },
          { mode = 'n', keys = '<Leader>w', desc = 'NVim' },
          { mode = 'n', keys = '<Leader>v', desc = 'Vimux' },
          { mode = 'n', keys = '<Leader>q', desc = 'NVim' },
          function()
            MiniClue.gen_clues.g()
          end,
          function()
            MiniClue.gen_clues.builtin_completion()
          end,
          function()
            MiniClue.gen_clues.marks()
          end,
          function()
            MiniClue.gen_clues.registers()
          end,
          function()
            MiniClue.gen_clues.windows()
          end,
          function()
            MiniClue.gen_clues.z()
          end,
        },
        window = {
          delay = 300,
        },
      }
      require('mini.comment').setup {
        mappings = {
          comment = 'gc', -- Toggle comment (like `gcip` - comment inner paragraph) for both Normal and Visual modes
          comment_line = 'gcc', -- Toggle comment on current line
          comment_visual = 'gc', -- Toggle comment on visual selection
          textobject = 'gc', -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        },
      }
      local starter = require 'mini.starter'
      starter.setup {
        evaluate_single = true,
        header = header,
        items = {
          starter.sections.builtin_actions(),
          starter.sections.recent_files(10, false),
          starter.sections.recent_files(10, true),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(),
          starter.gen_hook.indexing('all', { 'Builtin actions' }),
          starter.gen_hook.padding(3, 2),
        },
      }
      require('mini.completion').setup {
        window = {
          info = { border = 'rounded' },
          signature = { border = 'rounded' },
        },
      }
      vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
      vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

      require('mini.jump').setup()
      require('mini.jump2d').setup {
        -- Characters used for labels of jump spots (in supplied order)
        labels = 'aoeiudrtnspyfgchlbkxmj',
      }
      require('mini.cursorword').setup()
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.tabline').setup { show_icons = true }
    end,
  },
  {
    'mhartington/formatter.nvim',
    lazy = false,
    config = function()
      require('formatter').setup {
        logging = false,
        filetype = { -- Settings by File Types
          lua = require('formatter.filetypes.lua').stylua,
          go = require('formatter.filetypes.go').goimports,
          --[[
         function()
            return {
              exe = 'golines',
              args = {
                '--base-formatter="goimports"',
              },
              stdin = true,
            }
          end,
        --]]
          javascript = require('formatter.filetypes.javascript').prettierd,
          html = require('formatter.filetypes.html').prettierd,
          css = require('formatter.filetypes.css').prettierd,
          json = require('formatter.filetypes.json').jq,
          sql = require('formatter.filetypes.sql').pgformat,
          ['*'] = {
            require('formatter.filetypes.any').remove_trailing_whitespace,
          },
        },
      }
    end,
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    config = function(_, opts)
      -- calling `setup` is optional for customization
      require('fzf-lua').setup(opts)
      local keymap = vim.keymap.set
      keymap('n', '<leader>ff', '<cmd>FzfLua files<CR>', { desc = 'Files' })
      keymap('n', '<leader>fb', '<cmd>FzfLua buffers<CR>', { desc = 'Buffers' })
      keymap('n', '<leader>fh', '<cmd>FzfLua oldfiles<CR>', { desc = 'History' })
      keymap('n', '<leader>fl', '<cmd>FzfLua blines<CR>', { desc = 'Lines in buffer' })
      keymap('n', '<leader>fs', '<cmd>FzfLua live_grep<CR>', { desc = 'Live search' })
      keymap('n', '<leader>ft', '<cmd>FzfLua btags<CR>', { desc = 'Tags in buffer' })
      keymap('n', '<leader>fc', '<cmd>FzfLua git_commits<CR>', { desc = 'Git commits' })
      keymap('n', '<leader>fa', '<cmd>FzfLua help_tags<CR>', { desc = 'Neovim help' })
      keymap('n', '<leader>fm', '<cmd>FzfLua marks<CR>', { desc = 'Marks' })
      keymap('n', '<leader>fj', '<cmd>FzfLua jumps<CR>', { desc = 'Jumps' })
      keymap('n', '<leader>fk', '<cmd>FzfLua keymaps<CR>', { desc = 'Keymaps' })
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        actions = {
          open_file = {
            window_picker = {
              enable = false,
            },
          },
        },
      }
      vim.keymap.set('n', '<F12>', '<cmd>NvimTreeToggle<CR>')
    end,
  },
  {
    'preservim/vimux',
    lazy = false,
    config = function()
      local keymap = vim.keymap.set
      keymap('n', '<leader>vl', '<cmd>VimuxRunLastCommand<CR>')
      keymap('n', '<leader>vp', '<cmd>VimuxPromptCommand<CR>')
      keymap('n', '<leader>vc', '<cmd>VimuxInterruptRunner<CR>')
    end,
  },
  {
    'junegunn/vim-easy-align',
    lazy = false,
    config = function()
      vim.g.easy_align_bypass_fold = 1
      vim.keymap.set({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      sync_install = false,
      ensure_installed = {
        'lua',
        'go',
        'html',
        'css',
        'javascript',
        'typescript',
        'markdown',
        'vim',
        'vimdoc',
        'json',
      },
      highlight = { enable = true },
      indent = { enable = true },
      -- context_commentstring = { enable = true, enable_autocmd = false },
      skip_context_commentstring = true,
      incremental_selection = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
      },
      matchup = {
        enable = true,
      },
    },
    config = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        ---@type table<string, boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'Exafunction/codeium.vim',
    event = 'InsertEnter',
      -- stylua: ignore
      config = function ()
        vim.g.codeium_disable_bindings = 1
        local keymap = vim.keymap.set
        keymap("i", "<A-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true })
        keymap("i", "<A-c>", function() return vim.fn["codeium#CycleCompletions"](1) end, { expr = true })
        keymap("i", "<A-h>", function() return vim.fn["codeium#CycleCompletions"](-1) end, { expr = true })
        keymap("i", "<A-l>", function() return vim.fn["codeium#Clear"]() end, { expr = true })
        keymap("i", "<A-s>", function() return vim.fn["codeium#Complete"]() end, { expr = true })
      end,
  },
  {
    'hjson/vim-hjson',
    ft = { 'hjson', 'hj' },
  },
}
