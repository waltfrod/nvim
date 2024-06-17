local nvmap = vim.keymap.set
local M = {}

M.autocomplete = {
	setupKeyboard = function()
		nvmap('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, desc = 'Tab/Next suggestion' })
		nvmap('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true, desc = 'S-Tab/Previous suggestion' })
	end,
}

M.fzf = {
	setupKeyboard = function()
		nvmap('n', '<leader>ff', '<cmd>FzfLua files<CR>', { desc = 'Files' })
		nvmap('n', '<leader>fb', '<cmd>FzfLua buffers<CR>', { desc = 'Buffers' })
		nvmap('n', '<leader>fh', '<cmd>FzfLua oldfiles<CR>', { desc = 'History' })
		nvmap('n', '<leader>fl', '<cmd>FzfLua blines<CR>', { desc = 'Lines in buffer' })
		nvmap('n', '<leader>fs', '<cmd>FzfLua live_grep<CR>', { desc = 'Live search' })
		nvmap('n', '<leader>ft', '<cmd>FzfLua btags<CR>', { desc = 'Tags in buffer' })
		nvmap('n', '<leader>fc', '<cmd>FzfLua git_commits<CR>', { desc = 'Git commits' })
		nvmap('n', '<leader>fa', '<cmd>FzfLua help_tags<CR>', { desc = 'Neovim help' })
		nvmap('n', '<leader>fm', '<cmd>FzfLua marks<CR>', { desc = 'Marks' })
		nvmap('n', '<leader>fj', '<cmd>FzfLua jumps<CR>', { desc = 'Jumps' })
		nvmap('n', '<leader>fk', '<cmd>FzfLua keymaps<CR>', { desc = 'Keymaps' })
	end,
}

M.vimux = {
	setupKeyboard = function()
		nvmap('n', '<leader>vl', '<cmd>VimuxRunLastCommand<CR>', { desc = 'Run last command' })
		nvmap('n', '<leader>vp', '<cmd>VimuxPromptCommand<CR>', { desc = 'Prompt command' })
		nvmap('n', '<leader>vc', '<cmd>VimuxInterruptRunner<CR>', { desc = 'Interrupt runner' })
	end,
}

M.easyalign = {
	setupKeyboard = function()
		nvmap({ 'n', 'x' }, 'ga', '<Plug>(EasyAlign)', { desc = 'EasyAlign' })
	end,
}

M.codeium = {
	setupKeyboard = function()
		local neo = require('neocodeium')
		nvmap('i', '<A-g>', function()
			neo.accept()
		end, { expr = true, desc = 'Accept codeium suggestion' })
		nvmap('i', '<A-c>', function()
			neo.accept_word()
		end, { expr = true, desc = 'Accept word suggestion' })
		nvmap('i', '<A-h>', function()
			neo.accept_line()
		end, { expr = true, desc = 'Accept line suggestion' })
		nvmap('i', '<A-l>', function()
			neo.clear()
		end, { expr = true, desc = 'Clear codeium suggestion' })
		nvmap('i', '<A-f>', function()
			return neo.cycle(1)
		end, { expr = true, desc = 'Cycle forward codeium suggestion' })
	end,
}

M.vista = {
	setupKeyboard = function()
		nvmap('n', '<leader>vt', '<cmd>Vista!!<CR>', { desc = 'Toggle Vista CTags' })
	end,
}

M.netrw = {
	setupKeyboard = function()
		nvmap('n', '-', '<cmd>Explore<CR>', { desc = 'Toggle Netrw file browser' })
	end,
	setupNavigate = function()
		nvmap('n', 'H', 'u', { desc = 'Back history', buffer = true })
		nvmap('n', 'h', '-^', { desc = 'Up dir', buffer = true })
		nvmap('n', 'q', '<cmd>bd<CR>', { desc = 'Close', buffer = true })
		nvmap('n', '.', 'gh', { desc = 'Show/Hidde hidden files', buffer = true })
		nvmap('n', '<Tab>', 'mf', { desc = 'Mark', buffer = true })
		nvmap('n', '<S-Tab>', 'mF', { desc = 'Unmark', buffer = true })
		nvmap('n', '<leader><Tab>', 'mu', { desc = 'Unmark All', buffer = true })
		nvmap('n', 'ff', '%', { desc = 'New buffer', buffer = true })
		nvmap('n', 'fe', 'R', { desc = 'Rename file', buffer = true })
		nvmap('n', 'fc', 'mc', { desc = 'Copy mark file', buffer = true })
		nvmap('n', 'fC', 'mtmc', { desc = 'Copy mark file', buffer = true })
		nvmap('n', 'fx', 'mm', { desc = 'Move mark file', buffer = true })
		nvmap('n', 'fX', 'mtmm', { desc = 'Move mark file', buffer = true })
		nvmap('n', 'fl', function()
			print(vim.fn.join(vim.call('netrw#Expose', 'netrwmarkfilelist'), '\n'))
		end, { desc = 'List marks', buffer = true })
		nvmap('n', 'fq', function()
			print(vim.call('netrw#Expose', 'netrwftgt'))
		end, { desc = 'Show target', buffer = true })
	end,
}

M.harpoon = {
	setupKeyboard = function()
		local harpoon = require('harpoon')
		nvmap('n', '<leader>a', function()
			harpoon:list():add()
		end, { desc = 'Add to harpoon' })
		nvmap('n', '<C-e>', function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = 'Toggle harpoon menu' })
		nvmap('n', '<A-m>', function()
			harpoon:list():select(1)
		end, { desc = 'Select harpoon #1' })
		nvmap('n', '<A-w>', function()
			harpoon:list():select(2)
		end, { desc = 'Select harpoon #2' })
		nvmap('n', '<A-v>', function()
			harpoon:list():select(3)
		end, { desc = 'Select harpoon #3' })
		nvmap('n', '<A-z>', function()
			harpoon:list():select(4)
		end, { desc = 'Select harpoon #4' })
		nvmap('n', '<A-b>', function()
			harpoon:list():prev()
		end, { desc = 'Previous harpoon' })
		nvmap('n', '<A-d>', function()
			harpoon:list():next()
		end, { desc = 'Next harpoon' })
	end,
}

M.toggleterm = {
	setupKeyboard = function()
		local term = require('config.terminal')
		nvmap('n', '<leader>xb', function()
			term.Shell()
		end, { desc = 'Bash shell' })
		nvmap('n', '<leader>xp', function()
			term.ProjectInfo()
		end, { desc = 'Tokei - Project info' })
		nvmap('n', '<leader>xs', function()
			term.ProjectInfo()
		end, { desc = 'StackOverflow Search' })
	end,
}

return M
