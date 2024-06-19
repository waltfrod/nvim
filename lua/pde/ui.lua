local cfg = require('config.keymap.plugin')

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
					-- border = 'rounded',
				},
			},
		},
	},
	{
		'liuchengxu/vista.vim',
		cmd = { 'Vista' },
		init = function()
			vim.g.vista_ctags_cmd = { go = 'gotags' }
			cfg.vista.setupKeyboard()
		end,
	},
	{
		'lmburns/lf.nvim',
		lazy = false,
		config = function()
			local fn = vim.fn
			-- This feature will not work if the plugin is lazy-loaded
			vim.g.lf_netrw = 1

			require('lf').setup({
				escape_quit = false,
				border = 'rounded',
				height = fn.float2nr(fn.round(0.75 * vim.go.lines)), -- height of the *floating* window
				width = fn.float2nr(fn.round(0.75 * vim.go.columns)), -- width of the *floating* window
			})

			vim.keymap.set('n', '-', '<Cmd>Lf<CR>')

			vim.api.nvim_create_autocmd({
				event = 'User',
				pattern = 'LfTermEnter',
				callback = function(a)
					vim.api.nvim_buf_set_keymap(a.buf, 't', 'q', 'q', { nowait = true })
				end,
			})
		end,
		dependencies = { 'akinsho/toggleterm.nvim' },
	},
	{
		'feline-nvim/feline.nvim',
		lazy = false,
		config = function()
			vim.opt.termguicolors = true
			require('feline').setup()
		end,
	},
	{
		'ThePrimeagen/harpoon',
		branch = 'harpoon2',
		dependencies = { 'nvim-lua/plenary.nvim' },
		init = function()
			local harpoon = require('harpoon')
			harpoon:setup()
			cfg.harpoon.setupKeyboard()
		end,
	},
}
