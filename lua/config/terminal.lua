local M = {}

local Terminal = require('toggleterm.terminal').Terminal
local cwd = vim.loop.cwd()

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
	launch('mc -b ' .. cwd .. vim.fn.expand('~'), cwd)
end

function M.ProjectInfo()
	launch("tokei && echo 'Presione cualquier tecla para continuar ...' && read", cwd)
end

function M.StackOverflow()
	local fileType = vim.bo.filetype
	local val = vim.fn.input('StackOverflow search (' .. fileType .. ')', '')
	if val == '' then
		vim.notify('Empty search', vim.log.levels.ERROR)
		print('')
		return
	end

	launch('so ' .. fileType .. val, cwd)
end

return M
