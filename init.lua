-- LAZY.NVIM SETUP -------------------------------------------------------------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require('config.option').setup()
require('lazy').setup({
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
})
require('config.keymap.base').setup()
require('config.autocmd').setup()

vim.o.background = 'dark'
vim.cmd([[colorscheme gruvbox]])
