-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

if vim == nil then
	vim = {}
end

local M = {}

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

function M.setup()
	vim.cmd([[
augroup IndentationSettings
  autocmd!
  autocmd FileType javascript,css,scss,sass,html,xhtml,ts,yaml,yml,lua,json,typescript set smartindent autoindent shiftwidth=2 tabstop=2 softtabstop=2 noexpandtab
	autocmd FileType c,cpp,java,rust,go,latex set smartindent autoindent shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
augroup END
]])

	-- See `:help vim.highlight.on_yank()`
	local au = augroup('highlight_yank', {})
	autocmd('TextYankPost', {
		callback = function()
			vim.highlight.on_yank()
		end,
		group = au,
		pattern = '*',
	})

	-- Alternar automáticamente entre números de línea relativos y absolutos
	-- Los números relativos se utilizan en un búfer que tiene el foco y está en modo normal, ya que es ahí donde te
	-- mueves.
	-- Se desactivan cuando sales de Vim, cambias a otra división o entra en los modos de inserción y comando.
	au = augroup('numbertoggle', {})
	autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'CmdlineLeave', 'WinEnter' }, {
		pattern = '*',
		group = 'numbertoggle',
		callback = function()
			if vim.o.nu and vim.api.nvim_get_mode().mode ~= 'i' then
				vim.opt.relativenumber = true
			end
		end,
	})
	autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'CmdlineEnter', 'WinLeave' }, {
		pattern = '*',
		group = 'numbertoggle',
		callback = function()
			if vim.o.number then
				vim.opt.relativenumber = false
				vim.cmd('redraw')
			end
		end,
	})

	local is_int = function(n)
		return (type(n) == 'number') and (math.floor(n) == n)
	end

	-- Ubicar el cursor es la última posición
	local lastEdited = augroup('lastEdited', {})
	autocmd('BufReadPost', {
		pattern = '*',
		group = lastEdited,
		callback = function()
			pos = vim.fn.line('.')
			fin = vim.fn.line('$')
			if is_int(pos) and is_int(fin) and pos > 0 and pos <= fin then
				vim.cmd([[normal! g`"]])
			end
		end,
	})

	-- Formatter.nvim
	augroup('__formatter__', { clear = true })
	autocmd('BufWritePost', {
		group = '__formatter__',
		command = ':FormatWrite',
	})

	-- Evitar la sobreescritura de la configuración de editorconfig
	augroup('editorconfig', { clear = true })
	autocmd('BufEnter', {
		group = 'editorconfig',
		callback = function()
			vim.b.editorconfig = false
		end,
	})

	-- windows to close
	autocmd('FileType', {
		group = augroup('close_with_q', { clear = true }),
		pattern = {
			'OverseerForm',
			'OverseerList',
			'checkhealth',
			'floggraph',
			'fugitive',
			'git',
			'help',
			'lspinfo',
			'man',
			'neotest-output',
			'neotest-summary',
			'qf',
			'query',
			'spectre_panel',
			'startuptime',
			'toggleterm',
			'tsplayground',
			'vim',
			'neoai-input',
			'neoai-output',
			'notify',
		},
		callback = function(event)
			vim.bo[event.buf].buflisted = false
			vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
		end,
	})

	-- Creates intermediary directories when saving a buffer
	vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
		group = augroup('auto_create_dir', { clear = true }),
		callback = function(event)
			local file = vim.loop.fs_realpath(event.match) or event.match
			vim.fn.mkdir(vim.fn.fnamemodify(file, ':p:h'), 'p')
		end,
	})

	-- No comentar nuevas líneas
	vim.cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])
end

return M
