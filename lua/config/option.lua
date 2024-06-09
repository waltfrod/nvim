-- OPTION SETTINGS ---------------------------------

local M = {}

function M.setup()
	vim.g.mapleader = ' '
	vim.g.maplocalleader = '\\'

	vim.o.hlsearch = true
	vim.wo.number = true
	vim.o.mouse = 'a'
	vim.o.breakindent = true
	vim.o.undofile = true
	vim.o.ignorecase = true
	vim.o.smartcase = true
	-- Tab 4 spaces
	vim.o.tabstop = 4
	vim.o.softtabstop = 4
	vim.o.shiftwidth = 4
	vim.o.expandtab = true
	vim.o.smartindent = true

	vim.wo.signcolumn = 'yes'
	vim.wo.conceallevel = 0

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
	vim.o.title = true
	vim.o.undofile = true

	-- Folding
	vim.o.foldenable = false
	vim.o.foldmethod = 'expr'
	vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

	vim.o.formatoptions = 'cq'

	vim.o.textwidth = 130
	vim.o.wrapmargin = 130

	vim.o.winbar = "%{%v:lua.require'config.winbar'.get_winbar()%}"

	-- vim.g.loaded_netrw = 1
	-- vim.g.loaded_netrwPlugin = 1
end

return M
