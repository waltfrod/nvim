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

local cfg = require('config.keymap.plugin')

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
		'kylechui/nvim-surround',
		version = '*',
		event = 'VeryLazy',
		config = function()
			require('nvim-surround').setup()
		end,
	},
	{ 'DaikyXendo/nvim-material-icon' },
	{
		'echasnovski/mini.comment',
		version = '*',
		init = function()
			require('mini.comment').setup({
				mappings = {
					comment = 'gc',
					comment_line = 'gcc',
					comment_visual = 'gc',
					textobject = 'gc',
				},
			})
		end,
	},
	{
		'echasnovski/mini.starter',
		version = '*',
		init = function()
			local starter = require('mini.starter')
			starter.setup({
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
			})
		end,
	},
	{
		'echasnovski/mini.cursorword',
		version = '*',
		init = function()
			require('mini.cursorword').setup()
		end,
	},
	{
		'echasnovski/mini.completion',
		version = '*',
		init = function()
			require('mini.completion').setup({
				window = {
					info = { border = 'rounded' },
					signature = { border = 'rounded' },
				},
			})
			cfg.autocomplete.setupKeyboard()
		end,
	},
	{
		'echasnovski/mini.notify',
		version = '*',
		init = function()
			local notify = require('mini.notify')
			notify.setup()
			local opts = { ERROR = { duration = 10000 } }
			vim.notify = notify.make_notify(opts)
		end,
	},
	{
		'echasnovski/mini.jump',
		version = '*',
		init = function()
			require('mini.jump').setup()
		end,
	},
	{
		'echasnovski/mini.jump2d',
		version = '*',
		init = function()
			require('mini.jump2d').setup({
				labels = 'aoeiudrtnspyfgchlbkxmj',
			})
		end,
	},
	{
		'echasnovski/mini.pairs',
		version = '*',
		init = function()
			require('mini.pairs').setup()
		end,
	},
	{
		'echasnovski/mini.tabline',
		version = '*',
		init = function()
			require('mini.tabline').setup({ show_icons = true })
		end,
	},
	{
		'ibhagwan/fzf-lua',
		dependencies = { 'DaikyXendo/nvim-material-icon' },
		event = 'VeryLazy',
		config = function(_, opts)
			-- calling `setup` is optional for customization
			require('fzf-lua').setup(opts)
			cfg.fzf.setupKeyboard()
		end,
	},
	{
		'preservim/vimux',
		lazy = false,
		config = function()
			cfg.vimux.setupKeyboard()
		end,
	},
	{
		'junegunn/vim-easy-align',
		lazy = false,
		config = function()
			vim.g.easy_align_bypass_fold = 1
			cfg.easyalign.setupKeyboard()
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
				'xml',
				'css',
				'javascript',
				'typescript',
				'markdown',
				'vim',
				'yaml',
				'toml',
				'latex',
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
		'monkoose/neocodeium',
		event = 'VeryLazy',
		config = function()
			local neo = require('neocodeium')
			neo.setup()
			cfg.codeium.setupKeyboard()
		end,
	},
	{
		'mattn/emmet-vim',
		ft = { 'css', 'html', 'html4', 'xhtml', 'haml', 'htmldjango', 'xml', 'xsd' },
		init = function()
			vim.g.user_emmet_leader_key = ','
			vim.g.user_emmet_settings = {
				variables = { lang = 'es' },
				html = {
					snippets = {
						html = '<!DOCTYPE html>\n'
							.. '<html lang="es">\n'
							.. '\t<head>\n'
							.. '\t\t<meta charset="${charset}">\n'
							.. '\t\t<title></title>\n'
							.. '\t\t<meta name="viewport" content="width=device-width, initial-scale=1.0">\n'
							.. '\t</head>\n'
							.. '\t<body>\n\t${child}\n</body>\n'
							.. '</html>',
					},
				},
			}
		end,
	},
	{
		'folke/which-key.nvim',
		event = 'VeryLazy',
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		config = function(_, opts)
			local wk = require('which-key')
			wk.register({
				['<leader>'] = {
					['<leader>'] = 'Save & Quit',
					['b'] = 'Buffer',
					['f'] = 'FzfLua/WindowZoom',
					['v'] = 'Vimux/Vista',
					['x'] = '3party apps',
					['z'] = 'Folding',
				},
			})
			wk.setup(opts)
		end,
		opts = {
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				-- the presets plugin, adds help for a bunch of default keybindings in Neovim
				-- No actual key bindings are created
				spelling = {
					enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
					suggestions = 20, -- how many suggestions should be shown in the list?
				},
				presets = {
					operators = true, -- adds help for operators like d, y, ...
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
			},
		},
	},
	{
		'akinsho/toggleterm.nvim',
		version = '*',
		lazy = false,
		init = function()
			require('toggleterm').setup({
				direction = 'float',
				close_on_exit = false,
				float_opts = {
					border = 'curved',
					title_pos = 'left',
				},
			})
			cfg.toggleterm.setupKeyboard()
		end,
	},
	{
		'hjson/vim-hjson',
		ft = { 'hjson', 'hj' },
	},
	{
		'lewis6991/gitsigns.nvim',
		event = 'VeryLazy',
		config = function()
			require('gitsigns').setup()
		end,
	},
}
