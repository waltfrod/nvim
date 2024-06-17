local M = {}

local Terminal = require('toggleterm.terminal').Terminal
local cwd = vim.loop.cwd()
local tui = require('utils.tui')
local fileType = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), 'filetype')

local function launch(cmd, dir)
	Terminal:new({
		cmd = cmd,
		dir = dir,
		direction = 'float',
		float_opts = {
			border = 'double',
		},
		highlights = {
			FloatBorder = { fg = '#a9b1d6' },
		},
		close_on_exit = true,
	}):toggle()
end

function M.Shell()
	launch('bash', cwd)
end

function M.MC()
	launch('mc -b', cwd)
end

function M.ProjectInfo()
	launch("tokei && echo 'Presione cualquier tecla para continuar ...' && read", cwd)
end

function M.StackOverflow()
	local val = vim.fn.input('StackOverflow search (' .. fileType .. ')', '', val)
	if val == '' then
		vim.notify('Empty search', vim.log.levels.ERROR)
		return
	end

	launch('so ' .. fileType .. val, cwd)
end

return M
