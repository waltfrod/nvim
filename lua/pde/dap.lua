return {
	{
		'mfussenegger/nvim-dap',
		lazy = true,
		dependencies = {
			'theHamsta/nvim-dap-virtual-text',
			'rcarriga/nvim-dap-ui',
			'nvim-neotest/nvim-nio',
			'leoluz/nvim-dap-go',
			'jay-babu/mason-nvim-dap.nvim',
		},
		config = function()
			require('mason-nvim-dap').setup({
				ensure_installed = { 'delve' },
			})
			vim.fn.sign_define('DapBreakpoint', { text = '', texthl = '', linehl = 'Keyword', numhl = '' })
			vim.fn.sign_define('DapStopped', { text = '', texthl = '', linehl = '', numhl = '' })

			local dap = require('dap')
			local dapui = require('dapui')
			local dapgo = require('dap-go')
			dapui.setup({
				icons = { expanded = '', collapsed = '', current_frame = '' },
				layouts = {
					{
						elements = {
							'scopes',
							'watches',
						},
						size = 70,
						position = 'left',
					},
					{
						elements = {
							'breakpoints',
							'console',
						},
						size = 10,
						position = 'bottom',
					},
				},
			})
			dapgo.setup()
			require('nvim-dap-virtual-text').setup({
				commented = true,
			})
			dap.listeners.after.event_initialized['dapui_config'] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated['dapui_config'] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited['dapui_config'] = function()
				dapui.close()
			end
		end,
		cmd = {
			'DapContinue',
			'DapLoadLaunchJSON',
			'DapRestartFrame',
			'DapSetLogLevel',
			'DapShowLog',
			'DapStepInto',
			'DapStepOut',
			'DapStepOver',
			'DapTerminate',
			'DapToggleBreakpoint',
			'DapToggleRepl',
		},
		keys = {
			{
				'<leader>dR',
				function()
					require('dap').run_to_cursor()
				end,
				desc = 'Run to Cursor',
			},
			{
				'<leader>dE',
				function()
					require('dapui').eval(vim.fn.input('[Expression] > '))
				end,
				desc = 'Evaluate Input',
			},
			{
				'<leader>dC',
				function()
					require('dap').set_breakpoint(vim.fn.input('[Condition] > '))
				end,
				desc = 'Conditional Breakpoint',
			},
			{
				'<leader>dU',
				function()
					require('dapui').toggle()
				end,
				desc = 'Toggle UI',
			},
			{
				'<leader>db',
				function()
					require('dap').step_back()
				end,
				desc = 'Step Back',
			},
			{
				'<leader>dc',
				function()
					require('dap').continue()
				end,
				desc = 'Continue',
			},
			{
				'<leader>dd',
				function()
					require('dap').disconnect()
				end,
				desc = 'Disconnect',
			},
			{
				'<leader>de',
				function()
					require('dapui').eval()
				end,
				mode = { 'n', 'v' },
				desc = 'Evaluate',
			},
			{
				'<leader>dg',
				function()
					require('dap').session()
				end,
				desc = 'Get Session',
			},
			{
				'<leader>dh',
				function()
					require('dap.ui.widgets').hover()
				end,
				desc = 'Hover Variables',
			},
			{
				'<leader>dS',
				function()
					require('dap.ui.widgets').scopes()
				end,
				desc = 'Scopes',
			},
			{
				'<leader>di',
				function()
					require('dap').step_into()
				end,
				desc = 'Step Into',
			},
			{
				'<leader>do',
				function()
					require('dap').step_over()
				end,
				desc = 'Step Over',
			},
			{
				'<leader>dp',
				function()
					require('dap').pause.toggle()
				end,
				desc = 'Pause',
			},
			{
				'<leader>dq',
				function()
					require('dap').close()
				end,
				desc = 'Quit',
			},
			{
				'<leader>dr',
				function()
					require('dap').repl.toggle()
				end,
				desc = 'Toggle REPL',
			},
			{
				'<leader>ds',
				function()
					require('dap').continue()
				end,
				desc = 'Start',
			},
			{
				'<leader>dt',
				function()
					require('dap').toggle_breakpoint()
				end,
				desc = 'Toggle Breakpoint',
			},
			{
				'<leader>dx',
				function()
					require('dap').terminate()
				end,
				desc = 'Terminate',
			},
			{
				'<leader>du',
				function()
					require('dap').step_out()
				end,
				desc = 'Step Out',
			},
		},
	},
}
